#include <iostream>
#include <string>

using namespace std;

#include "Tree.h"

Tree::Tree() : root(0) {
}

Tree::~Tree() {
    clear(root);
}

void Tree::clear(Node *current) {
    if (current) {
        clear(current->left);
        clear(current->middle);
        clear(current->right);
        delete current;
    }
}

void Tree::insert(const string &data) {
    if (!root) {
        root = new Node(data);
        return;
    }
    Node *current = root;
    while (!current->isLeaf()) {
        if (data < current->small && current->left) {
            current = current->left;
        } else if (data < current->large && current->middle) {
            current = current->middle;
        } else {
            current = current->right;
        }
    }
    if (!current->isThreeNode()) {
        if (current->small < data) {
            current->large = data;
        } else {
            current->large = current->small;
            current->small = data;
        }
        return;
    } else {
        split(current, data);
    }
}

void Tree::splitRight(Node *current, string data, Node *childLeft, Node *childRight) {
    Node *parent = current->parent;
    if (current->large < data) {
        string temp = current->large;
        current->large = data;
        data = temp;
    } else if (current->small > data) {
        string temp = current->small;
        current->small = data;
        data = temp;
    }
    Node *middle = new Node(current->small);
    Node *right = new Node(current->large);
    middle->parent = parent;
    right->parent = parent;
    if (!parent->middle) {
        parent->middle = middle;
    }
    parent->right = right;
    middle->left = current->left;
    middle->right = current->middle;
    //Sets parents of children
    if (middle->left) {
        middle->left->parent = middle;
    }
    if (middle->right) {
        middle->right->parent = middle;
    }
    if (childLeft) {
        right->left = childLeft;
        childLeft->parent = right;
    }
    if (childRight) {
        right->right = childRight;
        childRight->parent = right;
    }
    delete current;
    if (!parent->isThreeNode()) {
        if (parent->small < data) {
            parent->large = data;
        } else {
            parent->large = parent->small;
            parent->small = data;
        }
    } else {
        split(parent, data, middle, right);
    }
}

void Tree::splitMiddle(Node *current, string data, Node *childLeft, Node *childRight) {
    Node *parent = current->parent;
    if (current->large < data) {
        string temp = current->large;
        current->large = data;
        data = temp;
    } else if (current->small > data) {
        string temp = current->small;
        current->small = data;
        data = temp;
    }
    Node *left = new Node(current->small);
    Node *right = new Node(current->large);
    left->left = current->left;
    right->right = current->right;
    //Sets parents of children
    if (left->left) {
        left->left->parent = left;
    }
    if (right->right) {
        right->right->parent = right;
    }
    if (childLeft) {
        left->right = childLeft;
        childLeft->parent = left;
    }
    if (childRight) {
        right->left = childRight;
        childRight->parent = right;
    }
    if (parent == root) {
        splitRoot(current->parent, left, right, data);
        delete current;
    } else {
        split(parent, data, left, right);
    }
}

void Tree::splitLeft(Node *current, string data, Node *childLeft, Node *childRight) {
    Node *parent = current->parent;
    if (current->large < data) {
        string temp = current->large;
        current->large = data;
        data = temp;
    } else if (current->small > data) {
        string temp = current->small;
        current->small = data;
        data = temp;
    }
    Node *left = new Node(current->small);
    Node *middle = new Node(current->large);
    middle->parent = parent;
    left->parent = parent;
    parent->left = left;
    if (!parent->middle) {
        parent->middle = middle;
    }
    left->left = current->left;
    middle->right = current->right;
    //Sets parents of children
    if (left->left) {
        left->left->parent = left;
    }
    if (middle->right) {
        middle->right->parent = middle;
    }
    if (childLeft) {
        left->right = childLeft;
        childLeft->parent =  left;
    }
    if (childRight) {
        middle->left = childRight;
        childRight->parent = middle;
    }
    delete current;
    if (!parent->isThreeNode()) {
        if (parent->small < data) {
            parent->large = data;
        } else {
            parent->large = parent->small;
            parent->small = data;
        }
    } else {
        split(parent, data, left, middle);
    }
}

void Tree::split(Node* current, string data, Node *childLeft, Node *childRight) {
    if (current == root) {
        if (childLeft || childRight) {
            splitRoot(current, childLeft, childRight, data, 1);
        }
        else {
            splitRoot(current, data);
        }
    } else if (current == current->parent->left) {
        splitLeft(current, data, childLeft, childRight);
    } else if (current == current->parent->middle) {
        splitMiddle(current, data, childLeft, childRight);
    } else {
        splitRight(current, data, childLeft, childRight);
    }
}

void Tree::splitRoot(Node *current, string data) {
    if (current->isThreeNode() && data < current->small) {
        Node *left = new Node(data);
        Node *right = new Node(current->large);
        current->large = "";
        current->left = left;
        left->parent = current;
        current->right = right;
        right->parent = current;
    } else if (current->isThreeNode() && data > current->large) {
        Node *left = new Node(current->small);
        Node *right = new Node(data);
        current->small = current->large;
        current->large = "";
        current->left = left;
        left->parent = current;
        current->right = right;
        right->parent = current;
    } else {
        Node *parent = new Node(data);
        root = parent;
        Node *left = new Node(current->small);
        Node *right = new Node(current->large);
        left->parent = parent;
        right->parent = parent;
        parent->left = left;
        parent->right = right;
        delete current;
    }
}

void Tree::splitRoot(Node *current, Node *left, Node *right, string data, int flag) {
    if (current->large < data) {
        string temp = current->large;
        current->large = data;
        data = temp;
    } else if (current->small > data) {
        string temp = current->small;
        current->small = data;
        data = temp;
    }
    Node *parent = new Node(data);
    root = parent;
    Node *rootLeft = new Node(current->small);
    Node *rootRight = new Node(current->large);
    parent->left = rootLeft;
    parent->right = rootRight;
    rootLeft->parent = parent;
    rootRight->parent = parent;
    if (flag) {
        rootLeft->left = current->left;
        rootLeft->left->parent = rootLeft;
        rootLeft->right = current->middle;
        rootLeft->right->parent = rootLeft;
        rootRight->left = left;
        left->parent = rootRight;
        rootRight->right = right;
        right->parent = rootRight;
        delete current;
    } else { 
        rootLeft->left = current->left;
        rootLeft->left->parent = rootLeft;
        rootLeft->right = left;
        rootRight->left = right;
        rootRight->right = current->right;
        rootRight->right->parent = rootRight;
        left->parent = rootLeft;
        right->parent = rootRight;
        delete current;
    }
}

void Tree::preOrder() const {
    preOrder(root);
    cout << endl;
}

void Tree::inOrder() const {
    inOrder(root);
    cout << endl;
}

void Tree::postOrder() const {
    postOrder(root);
    cout << endl;
}

void Tree::remove(const string &data) {
    Node *node = search(root, data);
    if (node) {
        Node *leafNode = node;
        if (!node->isLeaf()) {
            if (leafNode->small == data && leafNode->middle) {
                leafNode = nextNode(node->middle);
            } else {
                leafNode = nextNode(node->right);
            }
            swapNodes(node, leafNode);
        } else if (node == root && !node->isThreeNode()) {
            delete node;
            root = 0;
            return;
        }
        if (leafNode->small == data) {
            leafNode->small = "";
            if (!leafNode->large.empty()) {
                leafNode->small = leafNode->large;
                leafNode->large = "";
            }
        } else {
            leafNode->large = "";
        }
        if (leafNode->isEmpty()) {
            fix(leafNode);
        }
    }
}

void Tree::fix(Node *node) {
    if (node == root) {
        if (node->left) {
            Node *tempNode = node->left;
            delete root;
            root = tempNode;
            tempNode->parent = 0;
        } else if (node->right) {
            Node *tempNode = node->right;
            delete root;
            root = tempNode;
            tempNode->parent = 0;
        } else {
            delete root;
            root = 0;
        }
    } else {
        Node *parent = node->parent;
        if (parent->left && parent->left->isThreeNode()) {
            distribute(node, parent);           
        } else if (parent->middle && parent->middle->isThreeNode()) {
            distribute(node, parent);
        } else if (parent->right && parent->right->isThreeNode()) {
            distribute(node, parent);
        } else {
            merge(node, parent);
        }
    }
}

void Tree::merge(Node *node, Node *parent) {
    Node *sibling = 0;
    //Merges nodes if parent is not a three node
    if (!parent->isThreeNode()) {
        //Merges if right node is empty
        if (parent->right->isEmpty()) {
            sibling = parent->left;
            sibling->large = parent->small;
            parent->small = "";
            if (!node->isLeaf()) {
                Node *child = 0;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                sibling->middle = sibling->right;
                sibling->right = child;
                child->parent = sibling;
            } if (sibling->large < sibling->small) {
                sibling->swapData();
            }
          //Merges if left node is empty
        } else {
            sibling = parent->right;
            sibling->large = sibling->small;
            sibling->small = parent->small;
            parent->small = "";
            if (!node->isLeaf()) {
                Node *child = 0;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                sibling->middle = sibling->left;
                sibling->left = child;
                child->parent = sibling;
            }
            if (sibling->large < sibling->small) {
                sibling->swapData();
            }
        }
    //Merges nodes if parent is a three node
    } else {
        //Merges if left node is empty
        if (parent->left->isEmpty()) {
            sibling = parent->middle;
            sibling->large = sibling->small;
            sibling->small = parent->small;
            parent->small = parent->large;
            parent->large = "";
            if (!node->isLeaf()) {
                Node *child = 0;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                sibling->middle = sibling->left;
                sibling->left = child;
                child->parent = sibling;
            }
            if (sibling->large < sibling->small) {
                sibling->swapData();
            }
          //Merges if middle node is empty
        } else if (parent->middle->isEmpty()) {
            sibling = parent->left;
            sibling->large = parent->small;
            parent->small = parent->large;
            parent->large = "";
            if (!node->isLeaf()) {
                Node *child = 0;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                sibling->middle = sibling->right;
                sibling->right = child;
                child->parent = sibling;
            }
            if (sibling->large < sibling->small) {
                sibling->swapData();
            }
          //Merges if right node is empty
        } else {
            sibling = parent->middle;
            sibling->large = parent->large;
            parent->large = "";
            if (!node->isLeaf()) {
                Node *child = 0;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                sibling->middle = sibling->right;
                sibling->right = child;
                child->parent = sibling;
            }
            if (sibling->large < sibling->small) {
                sibling->swapData();
            }
        }
    }
    if (parent->left == node) {
        parent->left = sibling;
        if (!parent->isThreeNode()) {
            parent->middle = 0;
        }
    } else if (parent->middle == node) {
        parent->middle = 0;
    } else {
        parent->right = sibling;
        if (!parent->isThreeNode()) {
            parent->middle = 0;
        }
    }
    delete node;
    //Calls fix if parent is now empty
    if (parent->isEmpty()) {
        fix(parent);
    }
}

void Tree::distribute(Node *node, Node *parent) {
    unsigned childNum = 0;
    if (parent->left == node) {
        childNum = 1;
    } else if (parent->middle == node) {
        childNum = 2;
    } else {
        childNum = 3;
    }
    //Distributes if parent is not a three node
    if (!parent->isThreeNode()) {
        //Distributes if empty node is right
        if (childNum == 3) {
            node->small = parent->small;
            parent->small = parent->left->large;
            parent->left->small = parent->left->large;
            parent->left->large = "";
            if (!node->isLeaf()) {
                Node *child;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                node->right = child;
                node->left = parent->left->right;
                parent->left->right = parent->left->middle;
                parent->left->middle = 0;
            }
          //Distributes if empty node is left
        } else {
            node->small = parent->small;
            parent->small = parent->right->small;
            parent->right->small = parent->right->large;
            parent->right->large = "";
            if (!node->isLeaf()) {
                Node *child;
                if (node->left) {
                    child = node->left;
                } else {
                    child = node->right;
                }
                node->left = child;
                node->right = parent->right->left;
                parent->right->left = parent->right->middle;
                parent->right->middle = 0;
            }
        }
      //Distributes if parent is a three node
    } else {
        //Distributes if empty node is left
        if (childNum == 1) {
            if (parent->middle->isThreeNode()) {
                node->small = parent->small;
                parent->small = parent->middle->small;
                parent->middle->small = parent->middle->large;
                parent->middle->large = "";
                if (!node->isLeaf()) {
                    Node *child = 0;
                    if (node->left) {
                        child = node->left;
                    } else {
                        child = node->right;
                    }
                    node->left = child;
                    node->right = parent->middle->left;
                    node->right->parent = node;
                    parent->middle->left = parent->middle->middle;
                    parent->middle->middle = 0;
                }
            } else {
                node->small = parent->small;
                parent->small = parent->middle->small;
                parent->middle->small = parent->large;
                parent->large = parent->right->small;
                parent->right->small = parent->right->large;
                parent->right->large = "";
            }
          //Distributes if empty node is middle
        } else if (childNum == 2) {
            if (parent->right->isThreeNode()) {
                node->small = parent->large;
                parent->large = parent->right->small;
                parent->right->small = parent->right->large;
                parent->right->large = "";
            } else {
                node->small = parent->small;
                parent->small = parent->left->large;
                parent->left->large = "";
            }
          //Distributes if empty node is right
        } else {
            if (parent->middle->isThreeNode()) {
                node->small = parent->large;
                parent->large = parent->middle->large;
                parent->middle->large = "";
            } else {
                node->small = parent->large;
                parent->large = parent->middle->small;
                parent->middle->small = parent->small;
                parent->small = parent->left->large;
                parent->left->large = "";
            }
        }
    }     
}

Node* Tree::nextNode(Node *node) {
    while (node->left) {
        node = node->left;
    }
    return node;
}

void Tree::swapNodes(Node *node1, Node *node2) {
    string tempSmall = node1->small;
    string tempLarge = node1->large;
    node1->small = node2->small;
    node2->small = tempSmall;
    node1->large = node2->large;
    node2->large = tempLarge;
}

bool Tree::search(const string &data) const {
    return search(root, data);
}

void Tree::preOrder(Node *start) const {
    if (start) {
        start->printSmall();
        preOrder(start->left);
        start->printLarge();
        preOrder(start->middle);
        preOrder(start->right);
    }
}

void Tree::inOrder(Node *start) const {
    if (start) {
        inOrder(start->left);
        start->printSmall();
        inOrder(start->middle);
        start->printLarge();
        inOrder(start->right);
    }
}

void Tree::postOrder(Node *start) const {
    if (start) {
        postOrder(start->left);
        postOrder(start->middle);
        if (start->large.empty()) {
            postOrder(start->right);
            start->printSmall();
        } else {
            start->printSmall();
            postOrder(start->right);
            start->printLarge();
        }
    }
}

Node* Tree::search(Node *start, const string &data) const {
    if (start) {
        if (start->small == data || start->large == data) {
            return start;
        } else {
            if (data < start->small) {
                return search(start->left, data);
            } else if (data < start->large) {
                return search(start->middle, data);
            } else {
                return search(start->right, data);
            }
        }
    }
    return 0;
}

