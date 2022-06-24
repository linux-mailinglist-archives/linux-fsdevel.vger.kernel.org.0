Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCCC559352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiFXGYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiFXGYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:24:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854B47072
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 23:24:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m13so1810638ioj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjEUcM5dZzyfw79N6+5GwuY0eEBwOPNksbspIFfV09w=;
        b=oKMYNfW75/HQsRJxhpAC3D8HUXGn9wDRDe5KJRi9m8c46OXlYAk0Bq/Wy8bjJ/Zjuj
         nVPcig2kMQDqRRcTLW+7DNGYfpUeIb69wyO7riRaiM38xk88DVEoD9MYu1u+iRoajboa
         WclNMfqkYNcqB4I1uECvnp4bpkeyd00Qwb/KbSsFPkgmjcbGij/S33Iq+8Z4S38OJqpF
         mYphJl9CwP7u4Zne/11wYQsHsxo82MHyx0GrWwV0EwkEPB0Bf1Zjed9Kf1ue9LIfKs4+
         xkg/KWPeNAOgYmG+uPa7KyPwWm7UJu5N82uSuGywSwrBAzivgqTWcC/aGSo9p4Qf0WQc
         1TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjEUcM5dZzyfw79N6+5GwuY0eEBwOPNksbspIFfV09w=;
        b=RgqzhhiEPtqKO5upbLhourqSrLLHuHo0B0+TMPpCA2I3ULXpqbDSheOk73OswXHc45
         ygsWs8jHhLcD9XaFvZ4aXfIZ5vbkOFQDwEvt2OSkmQiSCVOIsuVJvoO9Nrm3qe9l2h1f
         5wm4R3JP0ccOPeUspIJPOxgNLrKaArdSK5wZ1tXrckAAdbpwgrywVeCuK6BuaO2LgRFp
         tgm4r4PZ6OzOn7lOr7FS6qkNwGecRtSQJ/k016i2UXNJ/UZexf7Pu1uwxuAKv10cBldY
         tp3MJLFgeaNuYI56HF2ZF8f9l69DUX3bcy7qF1ChZX4g36nWt7NRAZYG0ilUXzChq/EX
         tQzw==
X-Gm-Message-State: AJIora+eCkfQJPthvOtz5S4N+K8UF6VR1qmC1XVGxBq/FLc1QrZTk9iQ
        5x9o00lDeUdu9Tku0zTzQbU/PoeFItvoAYydZ0oesw==
X-Google-Smtp-Source: AGRyM1vOMbCrYNEm+moREM6h/f63nQBMVM5suou8CIgz910cLDSzB3txAqvyyvsMKZz2SWhIFsXcjL5ARZrsn/zpxdI=
X-Received: by 2002:a02:85e3:0:b0:339:cf24:68f6 with SMTP id
 d90-20020a0285e3000000b00339cf2468f6mr7749121jai.161.1656051859648; Thu, 23
 Jun 2022 23:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125651.14954-1-11123156@vivo.com> <YrSzLNCSg/8fWZ1j@redhat.com>
 <CAFQAk7h3ZVD8BGbg_z+o+=T=dX0qdRm4b8+g0ZOsv-C-o3WvsA@mail.gmail.com>
In-Reply-To: <CAFQAk7h3ZVD8BGbg_z+o+=T=dX0qdRm4b8+g0ZOsv-C-o3WvsA@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Fri, 24 Jun 2022 14:24:08 +0800
Message-ID: <CAFQAk7gLTYCmX3-4ABkc4Kg-BhO9YvEmZCg8aogkNsEHjkK35g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: force sync attr when inode is invalidated
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     wubo <11123156@vivo.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Bo <bo.wu@vivo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:27 AM Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> On Fri, Jun 24, 2022 at 3:26 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 08:56:51PM +0800, wubo wrote:
> > > From: Wu Bo <bo.wu@vivo.com>
> > >
> > > Now the fuse driver only trust it's local inode size when
> > > writeback_cache is enabled. Even the userspace server tell the driver
> > > the inode cache is invalidated, the size attrabute will not update. And
> > > will keep it's out-of-date size till the inode cache is dropped. This is
> > > not reasonable.
> >
> > BTW, can you give more details about what's the use case. With
> > writeback_cache, writes can be cached in fuse and not sent to
> > file server immediately. And I think that's why fuse trusts
> > local i_size.
> >
> > With writeback_cache enabled, I don't think file should be modified
> > externally (outside the fuse client).
> >
> > So what's that use case where file size cached in fuse is out of
> > date. You probably should not use writeback_cache if you are
> > modifying files outside the fuse client.
> >
> > Having said that I am not sure why FUSE_NOTIFY_INVAL_INODE was added to
> > begin with. If files are not supposed to be modifed outside the fuse
> > client, why are we dropping acls and invalidating attrs. If intent is
> > just to drop page cache, then it should have been just that nothing
> > else.
> >
> > So up to some extent, FUSE_NOTIFY_INVAL_INODE is somewhat confusing. Would
> > have been good if there was some documentation for it.
> >
> > Thanks
> > Vivek
> >
>
> Hi Wu and Vivek,
>
> Recently, we have had some discussions about the writeback_cache
> revalidation on the mailing list [1][2]. Miklos gave his initial
> patchset about writeback_cache v2, which supports c/mtime and size
> updates [1]. However, those methods do not make use of reverse
> messages, as virtio-fs does not support reverse notification yet. I'm
> going to send out a new version of that patch based on the discussion
> and with more considerations.

The new patch:
https://lore.kernel.org/linux-fsdevel/20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com/

Thanks,
Jiachen

>
> I also agree that, semantically, FUSE_NOTIFY_INVAL_INODE should
> invalidate i_size as well. So I think this patch is a good supplement
> for FUSE_NOTIFY_INVAL_INODE. But we need to be more careful as the
> size can be updated from server to kernel, and from kernel to server.
> I will leave some comments about such issues in the following code.
>
> For the use case, writeback_cache is superb over write-through mode in
> write-intensive scenarios, but its consistency among multiple clients
> is too bad (almost no consistency). I think it's good to give a little
> more consistency to writeback_cache.
>
> [1] https://lore.kernel.org/linux-fsdevel/20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com/
> [2] https://lore.kernel.org/linux-fsdevel/20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com/
>
> > >
> > > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > > ---
> > >  fs/fuse/inode.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 8c0665c5dff8..a4e62c7f2b83 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -162,6 +162,11 @@ static ino_t fuse_squash_ino(u64 ino64)
> > >       return ino;
> > >  }
> > >
> > > +static bool fuse_force_sync(struct fuse_inode *fi)
> > > +{
> > > +     return fi->i_time == 0;
> > > +}
> > > +
> > >  void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
> > >                                  u64 attr_valid, u32 cache_mask)
> > >  {
> > > @@ -222,8 +227,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
> > >  u32 fuse_get_cache_mask(struct inode *inode)
> > >  {
> > >       struct fuse_conn *fc = get_fuse_conn(inode);
> > > +     struct fuse_inode *fi = get_fuse_inode(inode);
> > > +     bool is_force_sync = fuse_force_sync(fi);
> > >
> > > -     if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
> > > +     if (!fc->writeback_cache || !S_ISREG(inode->i_mode) || is_force_sync)
> > >               return 0;
> > >
> > >       return STATX_MTIME | STATX_CTIME | STATX_SIZE;
> > > @@ -437,6 +444,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
> > >       fi = get_fuse_inode(inode);
> > >       spin_lock(&fi->lock);
> > >       fi->attr_version = atomic64_inc_return(&fc->attr_version);
> > > +     fi->i_time = 0;
> > >       spin_unlock(&fi->lock);
>
> Seems fuse_reverse_inval_inode() only drops page cache from offset to
> offset+len, should we only invalidate i_time on a full cache drop?
> Otherwise, as the server size is stale, the users may see a file is
> truncated.
>
> Also, what if a FUSE_GETATTR request gets the attr_version after
> fuse_reverse_inval_inode() increases it, but tries to update i_size
> after the invalidate_inode_pages2_range() in
> fuse_reverse_inval_inode()? In this case, server_size can be updated
> by invalidate_inode_pages2_range(), and FUSE_GETATTR might gets a
> stale server_size. Meanwhile, as FUSE_GETATTR has got the newest
> attr_version, the kernel_size will still be updated. This can cause
> false truncation even for a single FUSE client. So we may need to do
> more about the attr_version in writeback mode.
>
> Thanks,
> Jiachen
>
> > >
> > >       fuse_invalidate_attr(inode);
> > > --
> > > 2.35.1
> > >
> >
