# Classe grafo para representaçao de grafos,
import math
from queue import Queue

import networkx as nx  # biblioteca de tratamento de grafos necessária para desnhar graficamente o grafo
import matplotlib.pyplot as plt  # idem

from Node import Node


# Constructor
# Methods for adding edges
# Methods for removing edges
# Methods for searching a graph
# BFS, DFS, A*, Greedy





class Graph:
    def __init__(self, directed=False):
        self.m_nodes = []  
        self.m_directed = directed
        self.m_graph = {}  
        self.m_h = {}  

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
        else:
            n1 = self.get_node_by_name(node1)

        if (n2 not in self.m_nodes):
            n2_id = len(self.m_nodes)  # numeração sequencial
            n2.setId(n2_id)
            self.m_nodes.append(n2)
            self.m_graph[node2] = []
        else:
            n2 = self.get_node_by_name(node2)

        self.m_graph[node1].append((node2, weight)) 

        if not self.m_directed:
            self.m_graph[node2].append((node1, weight))

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
            i = i + 1
        return custo

    ################################################################################
    #     procura DFS  -- To Do
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
    # Procura BFS -- To Do
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
    # funçãop  getneighbours, devolve vizinhos de um nó
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

    ####################################33
    #    add_heuristica   -> define heuristica para cada nodo 1 por defeito....
    ################################3

    def add_heuristica(self, n, estima):
        n1 = Node(n)
        if n1 in self.m_nodes:
            self.m_h[n] = estima



    ##########################################
    #    A* - To Do
    ##########################################

    def procura_aStar(self, start, end):
        # open_list é uma lista de nodos visitados, mas com vizinhos
        # que ainda não foram todos vizitados, começa com o start

        # closed_list é uma lista de nodos visitados
        # e todos os seus vizinhos também já o foram
        open_list = {start}
        closed_list = set()

        g = {start: 0}
        parent = {start: None}

        while len(open_list) > 0:
            n = None
            for v in open_list:
                if n == None or (g[v] + self.getH(v)) < (g[n] + self.getH(n)):
                    n = v
                    
            if n == None:
                print("Path does not exist")
                return None

            if n == end:
                # reconstruir
                reconst_path = []
                while parent[n] is not None:
                    reconst_path.append(n)
                    n = parent[n]
                reconst_path.reverse()
                return (reconst_path, g[end])
            
            for (vizinho, peso) in self.getNeighbours(n):
                if vizinho in closed_list:
                    continue

                novo_custo = g[n] + peso

                if vizinho not in open_list or novo_custo < g.get(vizinho, math.inf):
                    g[vizinho] = novo_custo
                    parent[vizinho] = n
                    open_list.add(vizinho)

            # Move o nó atual para closed_list
            open_list.remove(n)
            closed_list.add(n)

        print("Path does not exist")
        return None    

    ###################################3
    # devolve heuristica do nodo
    ####################################

    def getH(self, nodo):
        if nodo not in self.m_h.keys():
            return 1000
        else:
            return (self.m_h[nodo])


    ##########################################
    #   Greedy - To Do                       #
    ##########################################

    def greedy(self, start, end):

        # open_list é uma lista de nodos visitados, mas com vizinhos
        # que ainda não foram todos vizitados, começa com o start

        # closed_list é uma lista de nodos visitados
        # e todos os seus vizinhos também já o foram
        open_list = set([start])
        closed_list = set()
        parent = {}
        parent[start] = start
        while len(open_list) > 0:
            n = None
            for v in open_list:
                if n == None or self.getH(v) < self.getH(n):
                    n = v
            if n == None:
                print("Path does not exist")
                return None
            # Se o nodo corrente é o destino
            # reconstruir o caminho a partir desse nodo até ao start
            # seguindo o antecessor

            if n == end:
                reconst_path = []
                while parent[n] != n:
                    reconst_path.append(n)
                    n = parent[n]
                reconst_path.append(start)
                reconst_path.reverse()
                return (reconst_path, self.calcula_custo(reconst_path))
            # para todos os vizinhos do nodo corrente
            for (vizinho, weight) in self.getNeighbours(n):
                # Se o nodo corrente não está no open nem no closed list
                # adiciona-lo à open list e marcar o antecessor
                if vizinho not in open_list and vizinho not in closed_list:
                    open_list.add(vizinho)
                    parent[vizinho] = n
            # remover n de open_List e adiciona-lo a closed_list
            # porque todos os seus vizinhos foram inspecionados
            open_list.remove(n)
            closed_list.add(n)
        print("Path does not exist")
        return None

    
