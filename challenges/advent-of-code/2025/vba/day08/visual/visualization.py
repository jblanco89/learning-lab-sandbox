import pandas as pd
import plotly.graph_objects as go
import numpy as np

#  csv files generated from day08/modules/ExportCSVDay8Mod.bas

nodes = pd.read_csv("challenges/advent-of-code/2025/vba/day08/csv/nodes.csv")
edges = pd.read_csv("challenges/advent-of-code/2025/vba/day08/csv/edges.csv")

# --- CONFIG HARD-CODED ---
STEP_SIZE = 5  # Frames will add this many edges each time to speed up the animation
color_visited_nodes = '#00FFFF'   # cyan
color_unvisited_nodes = '#D3D3D3' # lightgray
color_edge = '#FF00FF'           # magenta
color_current_edge = '#FFFF00'    # yellow
background_color = '#0b1026' 
grid_color = '#404040'
# ---------------------

frames = []
all_edges_x, all_edges_y, all_edges_z = [], [], []
visited_nodes = set()

# 2. build frames in Batches
for i in range(0, len(edges), STEP_SIZE):
    batch = edges.iloc[i : i + STEP_SIZE]
    
    for _, e in batch.iterrows():
        u = nodes.loc[nodes.id == e.u].iloc[0]
        v = nodes.loc[nodes.id == e.v].iloc[0]
        
        visited_nodes.add(e.u)
        visited_nodes.add(e.v)
        
        all_edges_x.extend([u.x, v.x, None])
        all_edges_y.extend([u.y, v.y, None])
        all_edges_z.extend([u.z, v.z, None])
    
    # Last edge of the batch for yellow highlighting
    last_e = batch.iloc[-1]
    u_last = nodes.loc[nodes.id == last_e.u].iloc[0]
    v_last = nodes.loc[nodes.id == last_e.v].iloc[0]
    
    unvisited_mask = ~nodes.id.isin(visited_nodes)
    
    # Rotate camera
    # Create an angle that changes with each frame i
    angle = np.radians(i / len(edges) * 360)
    camera_eye = dict(x=1.5 * np.cos(angle), y=1.5 * np.sin(angle), z=1.2)

    frames.append(
        go.Frame(
            data=[
                # Unvisited nodes
                go.Scatter3d(
                    x=nodes.loc[unvisited_mask, 'x'],
                    y=nodes.loc[unvisited_mask, 'y'],
                    z=nodes.loc[unvisited_mask, 'z'],
                    mode='markers',
                    marker=dict(size=3, color=color_unvisited_nodes, opacity=0.4),
                    name='Unvisited', hoverinfo='skip'
                ),
                # Visited nodes
                go.Scatter3d(
                    x=nodes.loc[~unvisited_mask, 'x'],
                    y=nodes.loc[~unvisited_mask, 'y'],
                    z=nodes.loc[~unvisited_mask, 'z'],
                    mode='markers',
                    marker=dict(size=4, color=color_visited_nodes, opacity=0.8),
                    name='Visited', hoverinfo='skip'
                ),
                # Cumulated edges
                go.Scatter3d(
                    x=all_edges_x.copy(), y=all_edges_y.copy(), z=all_edges_z.copy(),
                    mode='lines', line=dict(width=3, color=color_edge),
                    name='Path', hoverinfo='skip'
                ),
                # Current edge highlighted
                go.Scatter3d(
                    x=[u_last.x, v_last.x], y=[u_last.y, v_last.y], z=[u_last.z, v_last.z],
                    mode='lines', line=dict(width=10, color=color_current_edge),
                    name='Current', hoverinfo='skip'
                )
            ],
            name=str(i),
            layout=go.Layout(
                scene_camera=dict(eye=camera_eye),
                title_text=f"Edges: {min(i + STEP_SIZE, len(edges))}/{len(edges)} | Visited: {len(visited_nodes)}"
            )
        )
    )

# 3. Initial figure
fig = go.Figure(
    data=frames[0].data,
    frames=frames
)

# 4. Controls and layout
fig.update_layout(
    paper_bgcolor=background_color,
    scene=dict(
        xaxis=dict(backgroundcolor=background_color, gridcolor=grid_color, color='white'),
        yaxis=dict(backgroundcolor=background_color, gridcolor=grid_color, color='white'),
        zaxis=dict(backgroundcolor=background_color, gridcolor=grid_color, color='white'),
    ),
    title=dict(
        text=f"Edge 1/{len(edges)} | Visited: 5",
        x=0.5,
        xanchor='center',
        font=dict(color='white', size=16)
    ),
    # Legend styling
    legend=dict(
        bgcolor='rgba(0,0,0,0.5)',
        font=dict(color='white')
    ),
    template="plotly_dark",
    updatemenus=[{
        "type": "buttons",
        "direction": "left",
        "x": 0.1, "y": 1.1,
        "buttons": [
            {"label": "▶ Play", "method": "animate", "args": [None, {"frame": {"duration": 30, "redraw": True}, "fromcurrent": True}]},
            {"label": "Pause", "method": "animate", "args": [[None], {"frame": {"duration": 0, "redraw": False}, "mode": "immediate"}]}
        ]
    }],
    sliders=[{
        "steps": [{"args": [[f.name], {"frame": {"duration": 0, "redraw": True}, "mode": "immediate"}], 
                   "label": f.name, "method": "animate"} for f in frames],
        "active": 0, "x": 0.1, "len": 0.8, "font": {"color": "white"}
    }],
    height=900, width=1600
)

fig.show()