typedef struct node Node;

struct node {
  char key[20];
  Node *lchild, *mchild, *rchild;
  int level;
};

Node *new_node(char *key, Node *lchild, Node *mchild, Node *rchild) {
  Node *node = (Node *) malloc(sizeof(Node));
  sprintf(node->key, "%s", key);
  node->lchild = lchild;
  node->mchild = mchild;
  node->rchild = rchild;
  return node;
};

void printR(Node *current, int ind, int spc) {
  int level = current->level + 1;

  if (current->lchild != NULL) {
    printf("%*schild{ node{%s}\n", ind + spc * current->level, "", current->key);
    current->lchild->level = level;
    printR(current->lchild, ind, spc);
    current->mchild->level = level;
    printR(current->mchild, ind, spc);
    current->rchild->level = level;
    printR(current->rchild, ind, spc);
    printf("%*s}\n", ind + spc * current->level, "");
  }
  else
    printf("%*schild{ node[folha]{%s} }\n", ind + spc * current->level, "", current->key);

  free(current);
}

void print(Node *current) {
  int indentation = 8, spacing = 4, level = current->level + 1;

  printf("%*s\\node{%s}\n", indentation, "", current->key);
  current->lchild->level = level;
  printR(current->lchild, indentation, spacing);
  current->mchild->level = level;
  printR(current->mchild, indentation, spacing);
  current->rchild->level = level;
  printR(current->rchild, indentation, spacing);
  printf("%*s;\n", indentation, "");
  free(current);
}

void erase(Node *current) {
  if (current->lchild != NULL) {
    erase(current->lchild);
    erase(current->mchild);
    erase(current->rchild);
  }

  free(current);
}