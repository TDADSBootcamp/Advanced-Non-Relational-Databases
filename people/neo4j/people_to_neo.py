import argparse
import csv
import sys

def parse_args():
  parser = argparse.ArgumentParser("Convert from,to CSV data on stdin into nodes and relationships for neo4j")
  parser.add_argument("--nodes", help="nodes output file", required=True)
  parser.add_argument("--relationships", help="relationships output file", required=True)
  return parser.parse_args()

def to_nodes(from_to_list):
  pass


def main():
  args = parse_args()

  rows = [row for row in csv.DictReader(sys.stdin)]

  nodes = set(sum([[row['person'], row['knows']] for row in rows], []))
  nodes_with_indexes = dict([reversed(node) for node in enumerate(nodes)])
  
  with open(args.nodes, 'w') as nodes_out:
    writer = csv.DictWriter(nodes_out, fieldnames=['person:ID','name',':LABEL'])
    writer.writeheader()
    for node, index in nodes_with_indexes.items():
      writer.writerow({
        'person:ID': index,
        'name': node,
        ':LABEL': 'Person'
      })
  
  with open(args.relationships, 'w') as rels_out:
    writer = csv.DictWriter(rels_out, fieldnames=[':START_ID',':END_ID',':TYPE'])
    writer.writeheader()
    for row in rows:
      writer.writerow({
        ':START_ID': nodes_with_indexes[row['person']],
        ':END_ID': nodes_with_indexes[row['knows']],
        ':TYPE': 'knows'
      })


if __name__ == '__main__':
  main()