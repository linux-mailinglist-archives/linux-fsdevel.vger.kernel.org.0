Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720A55E299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbiF1Kq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbiF1KqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:46:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD9313A8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 03:46:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y18so12424115iof.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHrjPVariWqGD9Q0+OudpM/sw+FFCFuadlVMWQsqTbE=;
        b=7uLWxfmogEqEQs6CDYy12pFrIckdQswPGQ/PmdtKohFpd5A4vAymdPp4tPXRXao1Hb
         M78IM9YF3ARRDFOuC4xdfDLndyiRNLWnMtI/kUdIvKQ5Suqx9PuUyG0xlKwM7cETqBe5
         KKUpVaTCLIhrT+s/91NdvoOvAv2czxoTZivfvjW9GkXdVJyjC+iTdvqzasSho6tuX6H2
         dJ99OflOb7uWY9QDNSMfdmhHrCj2RypclJnpcZ7R/Ik/XJT/aSu1O1+vZwJCL2ZmWTrS
         dO22wdvWZVzN5pt34S6In2Tc40YxODjfO6jeQtGd+Nct+MUoFvfRuj0YNwcjTIy+cuiF
         ImUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHrjPVariWqGD9Q0+OudpM/sw+FFCFuadlVMWQsqTbE=;
        b=bYqoj3pqu44nfIouqtI2x2diniMhia7ALRv1FCmu9Jf8j8RMoGjJp+gDmb/WiZfHdH
         97QfqyQqqdFSPM+ru9pKUTnBLWPRxt3mkApJD2JS8AFnZLTBTPrddfRAYXBgKkueLH4p
         04MJxTU+KT5Rn063A33ThUStN2ndQFMQEHFRDpixY/O/64QLVuNksHoWcZbW/HKXuRj1
         kHKCzmUokN49zfiQQGED2/KwDeG3YuNyPsXs0WnSoeBmBryBnQLe/cbZ+kI+A4nBVrrJ
         9iad1YV66e0UouAncltTm1k3H0Nwx9sodqe6AmUl/oovISH1nqqkjM7iN4wUKo/RPEWU
         ZCow==
X-Gm-Message-State: AJIora/cBbsid2XFl91LXPBvvTE1O/W6/tvxNgpIpbxHA0wVCxAfha5+
        l4Gx6tR4AsNHC+gUODyksG9JRcNuY5YQsGtY5duDxw==
X-Google-Smtp-Source: AGRyM1tdmH03y5YWN/0dZSJ4H3bchhmJ3afr1wcau9WHd3Gr1ga1Vm7UvafXQuKO3BTFEOpnfyWMFGbXfjxxsHyqvnU=
X-Received: by 2002:a05:6602:2c13:b0:669:7f63:a2d7 with SMTP id
 w19-20020a0566022c1300b006697f63a2d7mr9022096iov.169.1656413183662; Tue, 28
 Jun 2022 03:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
 <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
 <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
 <CAFQAk7hakYNfBaOeMKRmMPTyxFb2xcyUTdugQG1D6uZB_U1zBg@mail.gmail.com>
 <Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com> <YrnCfISl7Nl8Wk52@redhat.com>
In-Reply-To: <YrnCfISl7Nl8Wk52@redhat.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Tue, 28 Jun 2022 18:46:12 +0800
Message-ID: <CAFQAk7iVKxXGyybJ8OB0sUL1zq=aXSO32OEv3te-80sFNgbRMw@mail.gmail.com>
Subject: Re: Re: Re: Re: [RFC PATCH] fuse: support cache revalidation in
 writeback_cache mode
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Apr 26, 2022 at 03:09:05PM +0200, Miklos Szeredi wrote:
> > On Mon, Apr 25, 2022 at 09:52:44PM +0800, Jiachen Zhang wrote:
> >
> > > Some users may want both the high performance of writeback mode and a
> > > little bit more consistency among FUSE mounts. In the current
> > > writeback mode implementation, users of one FUSE mount can never see
> > > the file expansion done by other FUSE mounts.
> >
> > Okay.
> >
> > Here's a preliminary patch that you could try.
> >
> > Thanks,
> > Miklos
> >
> > ---
> >  fs/fuse/dir.c             |   35 ++++++++++++++++++++++-------------
> >  fs/fuse/file.c            |   17 +++++++++++++++--
> >  fs/fuse/fuse_i.h          |   14 +++++++++++++-
> >  fs/fuse/inode.c           |   32 +++++++++++++++++++++++++++-----
> >  include/uapi/linux/fuse.h |    5 +++++
> >  5 files changed, 82 insertions(+), 21 deletions(-)
> >
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -194,6 +194,7 @@
> >   *  - add FUSE_SECURITY_CTX init flag
> >   *  - add security context to create, mkdir, symlink, and mknod requests
> >   *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
> > + *  - add FUSE_WRITEBACK_CACHE_V2 init flag
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -353,6 +354,9 @@ struct fuse_file_lock {
> >   * FUSE_SECURITY_CTX:        add security context to create, mkdir, symlink, and
> >   *                   mknod
> >   * FUSE_HAS_INODE_DAX:  use per inode DAX
> > + * FUSE_WRITEBACK_CACHE_V2:
> > + *                   - allow time/size to be refreshed if no pending write
> > + *                   - time/size not cached for falocate/copy_file_range
> >   */
> >  #define FUSE_ASYNC_READ              (1 << 0)
> >  #define FUSE_POSIX_LOCKS     (1 << 1)
> > @@ -389,6 +393,7 @@ struct fuse_file_lock {
> >  /* bits 32..63 get shifted down 32 bits into the flags2 field */
> >  #define FUSE_SECURITY_CTX    (1ULL << 32)
> >  #define FUSE_HAS_INODE_DAX   (1ULL << 33)
> > +#define FUSE_WRITEBACK_CACHE_V2      (1ULL << 34)
> >
> >  /**
> >   * CUSE INIT request/reply flags
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -222,19 +222,37 @@ void fuse_change_attributes_common(struc
> >  u32 fuse_get_cache_mask(struct inode *inode)
> >  {
> >       struct fuse_conn *fc = get_fuse_conn(inode);
> > +     struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >       if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
> >               return 0;
> >
> > +     /*
> > +      * In writeback_cache_v2 mode if all the following conditions are met,
> > +      * then allow the attributes to be refreshed:
> > +      *
> > +      * - inode is not dirty (I_DIRTY_INODE)
> > +      * - inode is not in the process of being written (I_SYNC)
> > +      * - inode has no dirty pages (I_DIRTY_PAGES)
> > +      * - inode does not have any page writeback in progress
> > +      *
> > +      * Note: checking PAGECACHE_TAG_WRITEBACK is not sufficient in fuse,
> > +      * since inode can appear to have no PageWriteback pages, yet still have
> > +      * outstanding write request.
> > +      */
>
> Hi,
>
> I started following this thread just now after Jiachen pointed me to
> previous conversations. Without going into too much details.
>
> Based on above description, so we will update mtime/ctime/i_size only
> if inode does not have dirty pages or nothing is in progress. So that
> means sometime we will update it and other times we will ignore it.
>
> Do I understand it correctly. I am wondering how that is useful to
> applications.
>
> I thought that other remote filesystems might have leasing for this so
> that one client can acquire the lease and cache changes and when lease
> is broken, this client pushes out all the changes and other client gets
> the lease.
>
> Given we don't have any lease mechanism, we probably need to define the
> semantics more clearly and we should probably document it as well.
>

Hi Vivek,

I agree we should define or document the semantics properly. For now,
it seems that Miklos' writeback_mode_v2 is making best-effort updating
when pages are not dirty and a set of new attributes are returned from
FUSE server.

Thanks,
Jiachen

> Thanks
> Vivek
>
