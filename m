Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5E2A59D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 23:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgKCWK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 17:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgKCWK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:10:59 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474EC0613D1;
        Tue,  3 Nov 2020 14:10:59 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k3so5610329otp.12;
        Tue, 03 Nov 2020 14:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgLn3hUv3gYrguGStHj2z/QNkPC6HZO8mh7+qaePmiI=;
        b=MQsUcEHdYVN4zQsL8GuUbfNoJbvKNwW5Vqbhkk5QX5OCOvh+2GD143EBDF9faVTvu2
         oSf2BHDg3p99AgOSyw9IuH0WoqJr6wVTTnaLNIWRaae/Yfjy1yOOWe14pMEvGnoiK8uY
         sapkqh2gpw3awfQn6zuLFHWWgLm6MaCrh3G6i5R1jtkjNKL+xvUrPjlQBuPetFs5ycF6
         CukqwhFB7kJvahaEgkFfH25d7xBvIdzGOLjq0Ux1obSRMB39Zt6ZNYbBqTeYZcVybpKv
         ajK+r0OtX3LWmmWB/kkJ5T8nqmk+1x1McSRqhW+mtD1tmtkREA/RSiFLItw00hT+fv0Q
         pwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgLn3hUv3gYrguGStHj2z/QNkPC6HZO8mh7+qaePmiI=;
        b=srRPIQ9k76N7q96sQKKyEeGX4JNDT2ZZJyew7pQGgOYGdM+y5sSOHYHkFG5M01uRgJ
         MN3dGCCkX+CNlM3ges9zt7v9NSNShJ6EaW3s6Ra5mz25OP61D+7KshHPLzge0/gRJJa2
         RzbB2lVa5GlxeMItspGgoSdbsZnERtPwtXnOHUo8dztdkV/2HYQy0A5P1MqkWSewq93l
         DsMo1nYMqx1X0ACdmWKW5fNajcimag3LGVR94XnIxoIUg1y8Z15mNvx1yTXM/s6+NlMA
         vx5Zjy6bmFPIEKh7Rw1gFeHcjlqZbUxeIs7uuEmlvbLGbsShgaoq9kTXUu7w2Hu12XEz
         u/gA==
X-Gm-Message-State: AOAM532SRzYvSgyq60g55d6sGXlbsU0/Rlfkmxnzw10Iud+nkjC/oyS0
        2q4DqvgyeXZaUjS1M7u+6nMZmyVKgMsPkqJWKX4=
X-Google-Smtp-Source: ABdhPJw2uaDZ9K5GrMj/qXY+5kafw0kbu8rXKbS4ba+lc4MGddpH0RVm9ZKVPPwmhkbrocOaQ7TYSd+XSaY45agmD5w=
X-Received: by 2002:a9d:3d44:: with SMTP id a62mr15867052otc.254.1604441458839;
 Tue, 03 Nov 2020 14:10:58 -0800 (PST)
MIME-Version: 1.0
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <71b8f94034f04da6f69f1ea0720825aabc852a54.1604065695.git.naohiro.aota@wdc.com>
 <502ce12d-1ba6-5e3c-9aab-3b1b42a16bcf@toxicpanda.com>
In-Reply-To: <502ce12d-1ba6-5e3c-9aab-3b1b42a16bcf@toxicpanda.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 14:10:47 -0800
Message-ID: <CAE1WUT7r5EKbRUqQWZ_u3Jb49FapCSdUDEOT2OgFmJM9+=j+Jw@mail.gmail.com>
Subject: Re: [PATCH v9 37/41] btrfs: split alloc_log_tree()
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 2:06 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 10/30/20 9:51 AM, Naohiro Aota wrote:
> > This is a preparation for the next patch. This commit split
> > alloc_log_tree() to allocating tree structure part (remains in
> > alloc_log_tree()) and allocating tree node part (moved in
> > btrfs_alloc_log_tree_node()). The latter part is also exported to be used
> > in the next patch.
> >
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >   fs/btrfs/disk-io.c | 31 +++++++++++++++++++++++++------
> >   fs/btrfs/disk-io.h |  2 ++
> >   2 files changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 2b30ef8a7034..70885f3d3321 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -1211,7 +1211,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
> >                                        struct btrfs_fs_info *fs_info)
> >   {
> >       struct btrfs_root *root;
> > -     struct extent_buffer *leaf;
> >
> >       root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
> >       if (!root)
> > @@ -1221,6 +1220,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
> >       root->root_key.type = BTRFS_ROOT_ITEM_KEY;
> >       root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
> >
> > +     return root;
> > +}
> > +
> > +int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
> > +                           struct btrfs_root *root)
> > +{
> > +     struct extent_buffer *leaf;
> > +
> >       /*
> >        * DON'T set SHAREABLE bit for log trees.
> >        *
> > @@ -1233,26 +1240,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
> >
> >       leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
> >                       NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
> > -     if (IS_ERR(leaf)) {
> > -             btrfs_put_root(root);
> > -             return ERR_CAST(leaf);
> > -     }
> > +     if (IS_ERR(leaf))
> > +             return PTR_ERR(leaf);
> >
> >       root->node = leaf;
> >
> >       btrfs_mark_buffer_dirty(root->node);
> >       btrfs_tree_unlock(root->node);
> > -     return root;
> > +
> > +     return 0;
> >   }
> >
> >   int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
> >                            struct btrfs_fs_info *fs_info)
> >   {
> >       struct btrfs_root *log_root;
> > +     int ret;
> >
> >       log_root = alloc_log_tree(trans, fs_info);
> >       if (IS_ERR(log_root))
>
> newline.
>
> >               return PTR_ERR(log_root);
> > +     ret = btrfs_alloc_log_tree_node(trans, log_root);
> > +     if (ret) {
> > +             kfree(log_root);
>
> btrfs_put_root(log_root);
>
> > +             return ret;
> > +     }
>
> newline.  Thanks,
>
> Josef

These should've shown up on the patch formatter... was it simply not run,
or did the patch formatter not catch it?

Best regards,
Amy Parker
(they/them)
