Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821396249F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKJSwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 13:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKJSwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:52:04 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC818362;
        Thu, 10 Nov 2022 10:52:02 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3775545dc24so23851037b3.7;
        Thu, 10 Nov 2022 10:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahiLR+0HYqx9Hj3q85kkyLXkS2RfP6cywR4r1/bj6Ic=;
        b=BuLNNyZA6RGJSro1aFTVvKQfJXFXyp5VR6864NrwvkzbzqRoktCJVw6N/Doca5qBcu
         30j7oqGhfYMC/2wwo+CnxYyRIcfIpMO1i3CANPIDzCZ/35eph3JNnXqbXZVpyVeE6nwC
         2rgiZ/WGg8qdiA9Wx3EmD01ybzYII1H7SmMVjyiHJ0HXfk4CMj8BCtPoDkfwrzn3wjsG
         tMQ34M0n3gr3bNTVHM2h6CnhVhIFHKJD1ZCvcWbyUbhDpvhP6XUbvTgwPEhVyNT1WYj4
         2KOVt0eemsENinf1T7NLvlf2zR8Rak8qZXX3U/QTi6IKzLl/llUNyWZD4jBYY5o/Cbo9
         gdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahiLR+0HYqx9Hj3q85kkyLXkS2RfP6cywR4r1/bj6Ic=;
        b=UbaJ7IxyJAo/gs3qMYuXXqhRI6APoHvxXj9tDDtMvMzDNkUPI7E3RMj3S8gyqGUnlk
         pYVSMkY2wpsmQK0v7UvKmmcCHT0xifcg7n3fTSUHpA7EETOeNra+KdPBx4nGZkKo8WDA
         fs8hoB1awRu8dmhofafzprtsyqcIXsw5LwpOgDRaVjHpDT4Pd0yADH9OePyCVzSDME1z
         0Y71J5liAF9MtJYZtLZDailvOWBzBVQrYQ6lRpbDzDkrc7BiSU5QwHWVikLiUzFZdPvo
         qhJj4EOfAHTX7t+G3dAAvpyFsOcIN9oD08mkCxFICJS6IEn9/DPd7H0FM2HMu38QtqnR
         2QRA==
X-Gm-Message-State: ACrzQf3R8a2w6DocMwqefmKPyt5Yw0LqSnmlds7dhJPs3kndKch3izf/
        +murK67EoKV5Z/6OmmKtdVdXmOhazeYBkYTINOHWZCf2SzI=
X-Google-Smtp-Source: AMsMyM6qbhoDq4EuNlT/sFztZuNh18/AZoQGojI1IWj/9MWKt4lI+zofGQOcHJnd2iNJiiAFP0Po3i1fYNOJTKFQ5/8=
X-Received: by 2002:a81:63c6:0:b0:349:37f7:73dd with SMTP id
 x189-20020a8163c6000000b0034937f773ddmr62868232ywb.368.1668106321899; Thu, 10
 Nov 2022 10:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com> <20221017202451.4951-12-vishal.moola@gmail.com>
 <CAOzc2pwKoyy4i4zBKhvoKmN8cezUxjDhjYZnK9GLcJniQVPoGA@mail.gmail.com>
In-Reply-To: <CAOzc2pwKoyy4i4zBKhvoKmN8cezUxjDhjYZnK9GLcJniQVPoGA@mail.gmail.com>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 10 Nov 2022 10:51:50 -0800
Message-ID: <CAOzc2pwuUZRK-qMFBhPEENUid-NBSfa9YyJ_FCcFHgwFf4mOuQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        jaegeuk@kernel.org, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:31 PM Vishal Moola <vishal.moola@gmail.com> wrote:
>
> On Mon, Oct 17, 2022 at 1:25 PM Vishal Moola (Oracle)
> <vishal.moola@gmail.com> wrote:
> >
> > Convert function to use a folio_batch instead of pagevec. This is in
> > preparation for the removal of find_get_pages_range_tag().
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  fs/f2fs/node.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 983572f23896..e8b72336c096 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1728,12 +1728,12 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> >                         unsigned int *seq_id)
> >  {
> >         pgoff_t index;
> > -       struct pagevec pvec;
> > +       struct folio_batch fbatch;
> >         int ret = 0;
> >         struct page *last_page = NULL;
> >         bool marked = false;
> >         nid_t ino = inode->i_ino;
> > -       int nr_pages;
> > +       int nr_folios;
> >         int nwritten = 0;
> >
> >         if (atomic) {
> > @@ -1742,20 +1742,21 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> >                         return PTR_ERR_OR_ZERO(last_page);
> >         }
> >  retry:
> > -       pagevec_init(&pvec);
> > +       folio_batch_init(&fbatch);
> >         index = 0;
> >
> > -       while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
> > -                               PAGECACHE_TAG_DIRTY))) {
> > +       while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
> > +                                       (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
> > +                                       &fbatch))) {
> >                 int i;
> >
> > -               for (i = 0; i < nr_pages; i++) {
> > -                       struct page *page = pvec.pages[i];
> > +               for (i = 0; i < nr_folios; i++) {
> > +                       struct page *page = &fbatch.folios[i]->page;
> >                         bool submitted = false;
> >
> >                         if (unlikely(f2fs_cp_error(sbi))) {
> >                                 f2fs_put_page(last_page, 0);
> > -                               pagevec_release(&pvec);
> > +                               folio_batch_release(&fbatch);
> >                                 ret = -EIO;
> >                                 goto out;
> >                         }
> > @@ -1821,7 +1822,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> >                                 break;
> >                         }
> >                 }
> > -               pagevec_release(&pvec);
> > +               folio_batch_release(&fbatch);
> >                 cond_resched();
> >
> >                 if (ret || marked)
> > --
> > 2.36.1
> >
>
> Following up on these f2fs patches (11/23, 12/23, 13/23, 14/23, 15/23,
> 16/23). Does anyone have time to review them this week?

Chao, thank you for taking a look at some of these patches!
If you have time to look over the remaining patches (14, 15, 16)
feedback on those would be appreciated as well.
