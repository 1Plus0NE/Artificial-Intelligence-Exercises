import math
from queue import Queue

import networkx as nx  # biblioteca de tratamento de grafos necessária para desnhar graficamente o grafo
import matplotlib.pyplot as plt  # idem

from Node import Node


# Constructor
# Number of edges
# Adjacancy matrix, adjacency list, list of edges

# Methods for adding edges

# Methods for removing edges

# Methods for searching a graph
# BFS, DFS, 


class Graph:
    def __init__(self, directed=False):
        self.m_nodes = []  
        self.m_directed = directed
        self.m_graph = {}  # dicionario para armazenar os nodos e arestas

    #############
    #    escrever o grafo como string
    #############
    def __str__(self):
        out = ""
        for key in self.m_graph.keys():
            out = out + "node" + str(key) + ": " + str(self.m_graph[key]) + "\n"
            return out

    ################################
    #   encontrar nodo pelo nome
    ################################

    def get_node_by_name(self, name):
        search_node = Node(name)
        for node in self.m_nodes:
            if node == search_node:
                return node
            else:
                return None

    ##############################3
    #   imprimir arestas
    ############################333333

    def imprime_aresta(self):
        listaA = ""
        lista = self.m_graph.keys()
        for nodo in lista:
            for (nodo2, custo) in self.m_graph[nodo]:
                listaA = listaA + nodo + " ->" + nodo2 + " custo:" + str(custo) + "\n"
        return listaA

    ################
    #   adicionar   aresta no grafo
    ######################

    def add_edge(self, node1, node2, weight):
        n1 = Node(node1)
        n2 = Node(node2)
        if (n1 not in self.m_nodes):
            n1_id = len(self.m_nodes)  # numeração sequencial
            n1.setId(n1_id)
            self.m_nodes.append(n1)
            self.m_graph[node1] = []
        

        if (n2 not in self.m_nodes):
            n2_id = len(self.m_nodes)  # numeração sequencial
            n2.setId(n2_id)
            self.m_nodes.append(n2)
            self.m_graph[node2] = []
        

        self.m_graph[node1].append((node2, weight))  


    #############################
    # devolver nodos
    ##########################

    def getNodes(self):
        return self.m_nodes

    #######################
    #    devolver o custo de uma aresta
    ##############3

    def get_arc_cost(self, node1, node2):
        custoT = math.inf
        a = self.m_graph[node1]  # lista de arestas para aquele nodo
        for (nodo, custo) in a:
            if nodo == node2:
                custoT = custo

        return custoT

    ##############################
    #  dado um caminho calcula o seu custo
    ###############################

    def calcula_custo(self, caminho):
        # caminho é uma lista de nodos
        teste = caminho
        custo = 0
        i = 0
        while i + 1 < len(teste):
            custo = custo + self.get_arc_cost(teste[i], teste[i + 1])
            #print(teste[i])
            i = i + 1
        return custo

    ################################################################################
    #     procura DFS -- TO DO
    ####################################################################################

    def procura_DFS(self, inicio, fim, path=[], visited=set()):
        path.append(inicio)
        visited.add(inicio)

        if inicio == fim:
            custoT = self.calcula_custo(path)
            return (path, custoT)

        peso = self.calcula_custo(path)

        for (vizinho, peso) in self.getNeighbours(inicio):
            if vizinho not in visited:
                resultado = self.procura_DFS(vizinho, fim, path, visited)
                if resultado is not None:
                    return resultado
        path.pop()
        return None
    
    #####################################################
    # Procura BFS  -- TO DO
    ######################################################

    def procura_BFS(self, inicio, fim):
        # definir novos visitados para evitar ciclos
        visited = set()
        fila = Queue()
        # adicionar o nodo inicial
        fila.put(inicio)
        visited.add(inicio)
        # permitir que o nodo inicial nao tem pais
        parent = dict()
        parent[inicio] = None # parent de inicio é none, pois não tem parent
        path_found = False

        # BFS
        while not fila.empty() and not path_found:
            nodo_atual = fila.get()
            if nodo_atual == fim:
                path_found = True
            else:
                for (vizinho, peso) in self.getNeighbours(nodo_atual):
                    if vizinho not in visited:
                        fila.put(vizinho)
                        parent[vizinho] = nodo_atual # associar o parent do nodo_atual
                        visited.add(vizinho)
        # reconstruir caminho e calcular custo
        if not path_found:
            return (None, math.inf)

        # reconstrói do fim até ao inicio
        path = []
        node = fim
        # exemplo, para A a D, nos vamos ter node = fim como D, vamos pegar no parent de D que é C até chegar a A cujo parent é None
        while node is not None:
            path.append(node)
            node = parent[node]
        # neste caso vamos ter que reverter a lista para que represente o caminho na ordem correta
        path.reverse()
        
        custo = self.calcula_custo(path)

        return (path, custo)
                    
    ####################
    # função  getneighbours, devolve vizinhos de um nó
    ##############################

    def getNeighbours(self, nodo):
        lista = []
        for (adjacente, peso) in self.m_graph[nodo]:
            lista.append((adjacente, peso))
        return lista

    ###########################
    # desenha grafo  modo grafico
    #########################

    def desenha(self):
        ##criar lista de vertices
        lista_v = self.m_nodes
        lista_a = []
        g = nx.Graph()
        for nodo in lista_v:
            n = nodo.getName()
            g.add_node(n)
            for (adjacente, peso) in self.m_graph[n]:
                lista = (n, adjacente)
                # lista_a.append(lista)
                g.add_edge(n, adjacente, weight=peso)

        pos = nx.spring_layout(g)
        nx.draw_networkx(g, pos, with_labels=True, font_weight='bold')
        labels = nx.get_edge_attributes(g, 'weight')
        nx.draw_networkx_edge_labels(g, pos, edge_labels=labels)

        plt.draw()
        plt.show()

   





