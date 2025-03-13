type GetRecentNotesQuery = {
  includeDrafts?: boolean;
  limit?: number;
};

const recentNotesQuery = z.object({
  includeDrafts: z.boolean().default(false),
  limit: z.number().default(),
});

export const getRecentNotes = async (
  _query?: z.input<typeof recentNotesQuery>
) => {
  const query = recentNotesQuery.parse(_query);

  // ...
};

export const collections = {
    notes: defineCollection({
        type: 'content',
        schema: z.object({
            tags: z.array(z.string()).default([]),
            publishedOn: z.date().optional(),
            title: z.string(),
        }),
    }),
};
