#nodes and edges csv files generated with challenges/advent-of-code/2025/vba/day08/ExportCSVDay8Mod.bas

import pandas as pd
import plotly.graph_objects as go

nodes = pd.read_csv("challenges/advent-of-code/2025/vba/nodes.csv")
edges = pd.read_csv("challenges/advent-of-code/2025/vba/edges.csv")

frames = []
all_edges_x = []
all_edges_y = []
all_edges_z = []

visited_nodes = set()

for i in range(len(edges)):
    e = edges.iloc[i]
    
    u = nodes.loc[nodes.id == e.u].iloc[0]
    v = nodes.loc[nodes.id == e.v].iloc[0]
    
    # Agregar nodos visitados
    visited_nodes.add(e.u)
    visited_nodes.add(e.v)
    
    # Agregar la nueva arista a la lista acumulada
    all_edges_x.extend([u.x, v.x, None])
    all_edges_y.extend([u.y, v.y, None])
    all_edges_z.extend([u.z, v.z, None])
    
    # Nodos no visitados (gris claro)
    unvisited_mask = ~nodes.id.isin(visited_nodes)
    
    # Crear el frame con todos los datos acumulados
    frames.append(
        go.Frame(
            data=[
                # Nodos no visitados
                go.Scatter3d(
                    x=nodes.loc[unvisited_mask, 'x'],
                    y=nodes.loc[unvisited_mask, 'y'],
                    z=nodes.loc[unvisited_mask, 'z'],
                    mode='markers',
                    marker=dict(size=3, color='lightgray', opacity=0.3),
                    name='No visitados',
                    showlegend=(i == 0)
                ),
                # Nodos visitados
                go.Scatter3d(
                    x=nodes.loc[~unvisited_mask, 'x'],
                    y=nodes.loc[~unvisited_mask, 'y'],
                    z=nodes.loc[~unvisited_mask, 'z'],
                    mode='markers',
                    marker=dict(size=5, color='lightblue'),
                    name='Visitados',
                    showlegend=(i == 0)
                ),
                # Todas las aristas encontradas hasta ahora
                go.Scatter3d(
                    x=all_edges_x.copy(),
                    y=all_edges_y.copy(),
                    z=all_edges_z.copy(),
                    mode='lines',
                    line=dict(width=2, color='cyan'),
                    name='Camino',
                    showlegend=(i == 0)
                ),
                # Arista actual resaltada
                go.Scatter3d(
                    x=[u.x, v.x],
                    y=[u.y, v.y],
                    z=[u.z, v.z],
                    mode='lines',
                    line=dict(width=6, color='red'),
                    name='Actual',
                    showlegend=(i == 0)
                )
            ],
            name=str(i),
            layout=go.Layout(
                title=dict(
                    text=f"Arista {i+1} de {len(edges)} | Nodos visitados: {len(visited_nodes)}",
                    x=0.5,
                    xanchor='center'
                )
            )
        )
    )

fig = go.Figure(
    data=frames[0].data,
    frames=frames
)

fig.update_layout(
    scene=dict(
        xaxis_title="X",
        yaxis_title="Y",
        zaxis_title="Z",
        camera=dict(
            eye=dict(x=1.5, y=1.5, z=1.5)
        )
    ),
    title=dict(
        text=f"Arista 1 de {len(edges)} | Nodos visitados: {len(visited_nodes)}",
        x=0.5,
        xanchor='center'
    ),
    updatemenus=[
        {
            "type": "buttons",
            "direction": "left",
            "x": 0.1,
            "y": 1.15,
            "buttons": [
                {
                    "label": "▶ Play",
                    "method": "animate",
                    "args": [None, {
                        "frame": {"duration": 60, "redraw": True},
                        "fromcurrent": True,
                        "mode": "immediate",
                        "transition": {"duration": 0}
                    }]
                },
                {
                    "label": "⏸ Pause",
                    "method": "animate",
                    "args": [[None], {
                        "frame": {"duration": 0, "redraw": False},
                        "mode": "immediate",
                        "transition": {"duration": 0}
                    }]
                }
            ]
        }
    ],
    sliders=[{
        "active": 0,
        "steps": [
            {
                "args": [[f.name], {
                    "frame": {"duration": 2, "redraw": True},
                    "mode": "immediate",
                    "transition": {"duration": 0}
                }],
                "label": str(i+1),
                "method": "animate"
            }
            for i, f in enumerate(frames)
        ],
        "x": 0.1,
        "len": 0.85,
        "y": 0,
        "xanchor": "left",
        "yanchor": "top"
    }],
    height=700
)

fig.show()