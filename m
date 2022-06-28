Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47DB55D806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244789AbiF1FQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 01:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiF1FPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:15:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F082872B
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 22:14:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id k7so7441702ils.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oG6UmMCeULY14p5Tnuuf681QLknd/2jzZKexPfhwXHo=;
        b=1W2RaMrqcsbZfT9D9Kb4GB4UobqcaC7M7RaswpgReAuuCtk4JgzRIGdgBJ4g1WM4Fn
         qru0MTS6IP2RQf6esYtsp9yaH1DLApJzzcfo58uEVpegkBj6EeVjj4f721h2sClNDsqX
         pSzqRCOetnm4dXRflO8aNfBiBAmAaauNAQcnHDm4efmAMANpumeTKYK3ZpiHfY6BBtkd
         DIwwQQ+JPDhlOv+KRBVtB4Nus1SC4UydB0PX88t1SSrRfsNJDNHu24zVD758Z0lv/L0n
         VNvXuyupIqFLISQdJWMUTYPCE4aYf9DdyLUstPm4Pan7PCN7SKQLi3ot7dpsmoluote8
         AZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oG6UmMCeULY14p5Tnuuf681QLknd/2jzZKexPfhwXHo=;
        b=bbO9kG70401fNSNOgV/icK83ditO/74Yqtvx2xUGew1xTuK0soC9iBpPKpxBpnOdOp
         Y++HT6Vk4qul8jPME2poewJNrTnfupcMCllUSHT+oMcl6Aj4H1E1kbO3wdm8Ak/UEHe2
         hHu6P6EcDfdc9IGjWAPEOmnDGvE3GU/vqDZGcs5TB8PcXcGjYE/3PqgD6g9RBPvP0mGw
         cUXO1Vh4RElIF2IOHcqIb9jTNYwaTfP+8xStpL/vZWY+dxbRwz0ZeEulzPQDpEFidfPw
         nZ5wiN9k2U5SF+kxaGJgoALrrw1ZKCaWpl+g3cpAVBT38EyquZn+J8L4fDPN/4Oj4iiS
         Arkg==
X-Gm-Message-State: AJIora+12yptHulHKb1phyWoK4Q+yx1eB1CfZj+cZ86fGD0pFwp6RC7i
        cKVwDN6ufS4kZJ29CPGqkB3Qz9ty5bNT+81UlskMEA==
X-Google-Smtp-Source: AGRyM1usCg0sGk1noQH4VFjDiVGy6bpSg35rY0jEoBZXk9gygcdycANNmduNCCY/SZ2apIYZT4vNGm0cs9nYUijW8rc=
X-Received: by 2002:a05:6e02:1a66:b0:2da:a3c6:d8f1 with SMTP id
 w6-20020a056e021a6600b002daa3c6d8f1mr2783376ilv.180.1656393272553; Mon, 27
 Jun 2022 22:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com> <YrnHeqckLknFleud@redhat.com>
In-Reply-To: <YrnHeqckLknFleud@redhat.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Tue, 28 Jun 2022 13:14:21 +0800
Message-ID: <CAFQAk7jgV1EkLK120tPkcG0MvupRMLQcvLNj8aP-=45nymMnQw@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: add FOPEN_INVAL_ATTR
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:06 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jun 08, 2022 at 06:42:02PM +0800, Jiachen Zhang wrote:
> > So that the fuse daemon can ask kernel to invalidate the attr cache on file
> > open.
>
> Will be great if there was a proper context around this. Without any
> explanation, how one is supposed to understand how this is useful.
>
> By going through other email threads, looks like, with writeback
> cache enabled, you want to invalidate attr cache and data cache
> when file is opened next time. Right?


Hi Vivek,

Yes, exactly. This patch is supposed to be a supplement to the
writeback_cache consistency enhancement patch [1]. Sorry for the lack
of explanation. I think I will send this and the enhancement patch as
a patchset later after there is more comments and discussions.

>
> IOW, when file is closed, its changes will be flushed out. And when
> file is reopened, server somehow is supposed to determine if file
> has changed (on server by another client) and based on that determine
> whether to invalidate attr and data cache on next open?

Yes, to achieve this so-called close-to-open consistency, this patch
gives a knod to FUSE server handler to invalidate attributes cache on
file open.

>
> Even without that, on next open, it probably makes sense to being
> invalidate attr cache. We have notion to invalidate data cache. So
> it will be kind of odd that we can invalidate data but not attrs
> on next open. Am I understanding it right?

Yes, Exactly. It could also be used for immediate attr invalidation in
write-through mode.

[1] https://lore.kernel.org/linux-fsdevel/20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com/

Thanks,
Jiachen

>
> Thanks
> Vivek
>
> >
> > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > ---
> >  fs/fuse/file.c            | 4 ++++
> >  include/uapi/linux/fuse.h | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index fdcec3aa7830..9609d13ec351 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -213,6 +213,10 @@ void fuse_finish_open(struct inode *inode, struct file *file)
> >               file_update_time(file);
> >               fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> >       }
> > +
> > +     if (ff->open_flags & FOPEN_INVAL_ATTR)
> > +             fuse_invalidate_attr(inode);
> > +
> >       if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
> >               fuse_link_write_file(file);
> >  }
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index d6ccee961891..0b0b7d308ddb 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -301,6 +301,7 @@ struct fuse_file_lock {
> >   * FOPEN_CACHE_DIR: allow caching this directory
> >   * FOPEN_STREAM: the file is stream-like (no file position at all)
> >   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> > + * FOPEN_INVAL_ATTR: invalidate the attr cache on open
> >   */
> >  #define FOPEN_DIRECT_IO              (1 << 0)
> >  #define FOPEN_KEEP_CACHE     (1 << 1)
> > @@ -308,6 +309,7 @@ struct fuse_file_lock {
> >  #define FOPEN_CACHE_DIR              (1 << 3)
> >  #define FOPEN_STREAM         (1 << 4)
> >  #define FOPEN_NOFLUSH                (1 << 5)
> > +#define FOPEN_INVAL_ATTR     (1 << 6)
> >
> >  /**
> >   * INIT request/reply flags
> > --
> > 2.20.1
> >
>
