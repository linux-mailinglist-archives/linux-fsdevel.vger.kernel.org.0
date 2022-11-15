Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE162A300
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 21:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKOUcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 15:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiKOUbc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:31:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365A317C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 12:29:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so17985178pjk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3/UOuXLNqaGhZ6h8rL6G+T7mz9ElbPyTxd9oL2Zpwc4=;
        b=Wl8GJcZB5yJKKs1GkMIHqH8ck1Q4o2AbAMVSjHcfU/R84x3wy+vg+t+xKs2kj7vnL+
         +A/SKgdbduIQ535wzU+LIkz9qYiTB838YTfE4qPp5POwWoyT3CHswYcsnc/yx0eIITRH
         6V7B4PA8iohNRI3H9hCrxyg5ZNCFn2CpKZv52uykRyh8HxD9ufKAAkU/jr0/8RoZXSmg
         OEW7oGtiz1V5uWFCH4E0EQALB7Mu1MkpEiwFV9Cuig86vDZLutIUVXpTyjvXii4CUdZv
         mOfbrY9dzzAdCcYlXqIVpS36DLCyuYfbvdVGwpX6X7tVW8vzzAt2nAxZo3EqWvKQWG/0
         lOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/UOuXLNqaGhZ6h8rL6G+T7mz9ElbPyTxd9oL2Zpwc4=;
        b=Jj/LoOcRcEP3IYEr3Ki8UUHZBarCXRKkM4zcCr40WBiX7z3Y3hn+mCnabTtLpX8wIn
         FLmJs7u6TU+G8IwsqRUEsDEpFzMR+f64wR4uW7Lj48c4jvpYVPIauFjzI3zz5n+uwR8K
         Esj8yKrbIA6OL5qcFigmcv1ZkhCp+s8NBSEGPajNYOOLJ2yNAJzLuYApakyFEIkU3Fi7
         dYlZeKvKPyU4iUnJQmxJaNOnr3gtwQToVs++Zo5sTjkzfuTx5MqfiHOLprUgi4yStGn4
         O96jatQq4vWex5CO0qS9SOM4qvVfgdJFsY8bdidLtVd09RRAyjUfVEvAnNihiRPNjr0+
         Bnzw==
X-Gm-Message-State: ANoB5plClzTA9tH1odFPEz2uBZwZQCOEFKqT0rxaPwE5xCS86EbpZ0AY
        bPp4hB+91/gXhP00Cu1mIs6UmInGXWIn8tYfWdRbOA==
X-Google-Smtp-Source: AA0mqf5g+PjMHVaMyW3VHm15GEuEAWIvpJFuKkcYzd8+862mvjgAqp1n5brxFUK5ru3yru2AtAzJT5RpIxyWbx+ln8I=
X-Received: by 2002:a17:90b:4fcf:b0:218:725:c820 with SMTP id
 qa15-20020a17090b4fcf00b002180725c820mr73901pjb.170.1668544147673; Tue, 15
 Nov 2022 12:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20221114192129.zkmubc6pmruuzkc7@quack3> <20221114212155.221829-1-feldsherov@google.com>
 <20221115105513.6qqyxj4klci6hozl@quack3>
In-Reply-To: <20221115105513.6qqyxj4klci6hozl@quack3>
From:   Svyatoslav Feldsherov <feldsherov@google.com>
Date:   Tue, 15 Nov 2022 22:28:55 +0200
Message-ID: <CACgs1VAo5AD-6sw2QCNKhRtoOy99XNP24dAWUrdryJKhCxwsMA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: do not update freeing inode io_list
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for the review.

I've sent v3 with proposed fixes.
Also tried to be more consistent and use i_io_list in comments and
commit message instead of io_list//io list.

On Tue, Nov 15, 2022 at 12:55 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-11-22 21:21:55, Svyatoslav Feldsherov wrote:
> > After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
> > already has I_DIRTY_INODE") writeiback_single_inode can push inode with
>                                 ^^^ writeback
>
> > I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
> > I_DIRTY_TIME set this can happened after deletion of inode io_list at
>                                 ^^ happen               ^^^ deletion of
> inode *from i_io_list*
>
> > evict. Stack trace is following.
> >
> > evict
> > fat_evict_inode
> > fat_truncate_blocks
> > fat_flush_inodes
> > writeback_inode
> > sync_inode_metadata(inode, sync=0)
> > writeback_single_inode(inode, wbc) <- wbc->sync_mode == WB_SYNC_NONE
> >
> > This will lead to use after free in flusher thread.
> >
> > Similar issue can be triggered if writeback_single_inode in the
> > stack trace update inode->io_list. Add explicit check to avoid it.
>                         ^^ inode->i_io_list
>
> > Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
> > Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
> > Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
>
> Besides these gramatical nits the patch looks good to me. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Thanks!
>
>                                                                 Honza
>
> > ---
> >  V1 -> V2:
> >  - address review comments
> >  - skip inode_cgwb_move_to_attached for freeing inode
> >
> >  fs/fs-writeback.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 443f83382b9b..c4aea096689c 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1712,18 +1712,26 @@ static int writeback_single_inode(struct inode *inode,
> >       wb = inode_to_wb_and_lock_list(inode);
> >       spin_lock(&inode->i_lock);
> >       /*
> > -      * If the inode is now fully clean, then it can be safely removed from
> > -      * its writeback list (if any).  Otherwise the flusher threads are
> > -      * responsible for the writeback lists.
> > +      * If the inode is freeing, it's io_list shoudn't be updated
> > +      * as it can be finally deleted at this moment.
> >        */
> > -     if (!(inode->i_state & I_DIRTY_ALL))
> > -             inode_cgwb_move_to_attached(inode, wb);
> > -     else if (!(inode->i_state & I_SYNC_QUEUED)) {
> > -             if ((inode->i_state & I_DIRTY))
> > -                     redirty_tail_locked(inode, wb);
> > -             else if (inode->i_state & I_DIRTY_TIME) {
> > -                     inode->dirtied_when = jiffies;
> > -                     inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> > +     if (!(inode->i_state & I_FREEING)) {
> > +             /*
> > +              * If the inode is now fully clean, then it can be safely
> > +              * removed from its writeback list (if any). Otherwise the
> > +              * flusher threads are responsible for the writeback lists.
> > +              */
> > +             if (!(inode->i_state & I_DIRTY_ALL))
> > +                     inode_cgwb_move_to_attached(inode, wb);
> > +             else if (!(inode->i_state & I_SYNC_QUEUED)) {
> > +                     if ((inode->i_state & I_DIRTY))
> > +                             redirty_tail_locked(inode, wb);
> > +                     else if (inode->i_state & I_DIRTY_TIME) {
> > +                             inode->dirtied_when = jiffies;
> > +                             inode_io_list_move_locked(inode,
> > +                                                       wb,
> > +                                                       &wb->b_dirty_time);
> > +                     }
> >               }
> >       }
> >
> > --
> > 2.38.1.431.g37b22c650d-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--
Slava
