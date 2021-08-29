typedef struct node Node;

struct node {
  char key[20];
  Node *lchild, *rchild;
  int level;
};

Node *new_node(char *key, Node *lchild, Node *rchild) {
  Node *node = (Node *) malloc(sizeof(Node));
  sprintf(node->key, "%s", key);
  node->lchild = lchild;
  node->rchild = rchild;
  return node;
};

void printR(Node *current, int ind, int spc) {
  if (current->lchild != NULL) {
    printf("%*schild{ node{%s}\n", ind + spc * current->level, "", current->key);
    current->lchild->level = current->level + 1;
    printR(current->lchild, ind, spc);
    current->rchild->level = current->level + 1;
    printR(current->rchild, ind, spc);
    printf("%*s}\n", ind + spc * current->level, "");
  }
  else
    printf("%*schild{ node{%s} }\n", ind + spc * current->level, "", current->key);

  free(current);
}

void print(Node *current) {
  int indentation = 8, spacing = 4;

  printf("%*s\\node{%s}\n", indentation, "", current->key);
  current->lchild->level = current->level + 1;
  printR(current->lchild, indentation, spacing);
  current->rchild->level = current->level + 1;
  printR(current->rchild, indentation, spacing);
  printf("%*s;\n", indentation, "");
  free(current);
}

void erase(Node *current) {
  if (current->lchild != NULL) {
    erase(current->lchild);
    erase(current->rchild);
  }

  free(current);
}