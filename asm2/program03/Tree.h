#ifndef __TREE_H
#define __TREE_H

#include "Node.h"

class Tree {
  private:
    Node *root;

  public:
    Tree();
    ~Tree();

    //Insert an item into the 2-3 tree. Be sure to maintain the 2-3 tree properties
    void insert(const string &);

    //Traverse and print the tree in preorder notation
    void preOrder() const;

    //Traverse and print the tree in inorder notation
    void inOrder() const;

    //Traverse and print the tree in postorder notation
    void postOrder() const;

    //Remove a specified item from the tree. Be sure to maintain the 2-3 tree properties
    void remove(const string &);

    // Search for a specified item in the tree. Return true if the item exists in the tree. Return false if the item does not exist
    bool search(const string &) const;

  private:
    // Add additional functions/variables here

    //Recursively prints tree in preorder
    void preOrder(Node *) const;

    //Recursively prints tree in inorder
    void inOrder(Node *) const;

    //Recursively prints tree in postorder
    void postOrder(Node *) const;

    //Recursively searches for node in tree and returns pointer
    Node* search(Node *, const string &) const;

    //splits node if needed
    void split(Node *, string, Node *childLeft = 0, Node *childRight = 0);

    //splits the root node
    void splitRoot(Node *, string);

    //splits the root node when children are present, flag signaling what the children represent
    void splitRoot(Node *, Node *, Node*, string, int flag = 0);

    //splits a right node
    void splitRight(Node *, string, Node *childLeft, Node *childRight);

    //splits a middle node
    void splitMiddle(Node *, string, Node *childLeft, Node *childRight);

    //splits a left node
    void splitLeft(Node *, string, Node *childLeft, Node *childRight);

    //fixes a node if it become empty
    void fix(Node *);

    //merges sibling nodes
    void merge(Node *, Node *);

    //distributes nodes
    void distribute(Node *, Node *);

    //returns the next inorder node
    Node* nextNode(Node *);

    //swaps the data values of two nodes
    void swapNodes(Node *, Node *);

    //empties the tree
    void clear(Node *);
};

#endif
