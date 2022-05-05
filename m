Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551A51B746
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 06:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbiEEEzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 00:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiEEEzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 00:55:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208B12E0B2;
        Wed,  4 May 2022 21:51:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso3107170pjj.2;
        Wed, 04 May 2022 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DibF2XgQ9hWvd/D9cWqRFEkqDfo/OQeSrnJABKFxuok=;
        b=fZvYO/C8Ynx0Fv4pKqEx019u11vMxz3woAT0bJp8A7xfYhD084SlkqXyZw+c9NYgYG
         erj1PtJNEa30axtKm+Fquk2W/VbIrhWViaX3BAbzE8dkNNoJXqDe8MNm1jfsCHr2B5Xs
         tzaHiTsW8yr3EOL3zhlekGU6Wfs6/cVkWYDOj7CLVfa11oCV6OKiDlLw1RD6FN+fB0Db
         4+QbVVWQJ7HnSoVmo7bE9dEuWOlsZ9PCjuh8i/jBuLUYPI4XIWhvXUnp4sxofBLqgClN
         WQyT+9XaCqrk7UF6eL1nafOIM1YZkaKuh61xQhMt5Fbodyo/s4dGqySKtwTTZhsETc2+
         9bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DibF2XgQ9hWvd/D9cWqRFEkqDfo/OQeSrnJABKFxuok=;
        b=YnX0r6FMb6Wwa7pIGyYMi76Pm/nXiRez9yA0MeSRZZ6GEHU/X5x5+0beZ01QN+zzDz
         hi1x/2V1MyY6FSZZkdGMWvcQjDKO9ql/V9YKRBwFpYaMTCjYQsclw7BwEgW5S+YHiupC
         bYu+zYwYWxHd+V76VRjejZirU12IuPsjmOiCHP6X3bxDDPLu/5WdX+B37l6ebN4MEVm6
         ir9i8NHvKSvPtplHTzUH/ByIJEEWJ42I5HCtdVmIe7B2MPkcSgGTHZRU3Ny+Ivj187iL
         UpUlIs/GeNg6v70MGCJ7+BY9dZfOt23lZhTWSQM1RnieBAyaXbg8r7fhSEwFlM1mjlQN
         o94g==
X-Gm-Message-State: AOAM530vFSiJpmVjo3d742ltGsfN008vYCnPesiqbF0qjfuv10QjmcoK
        a9SPvzpx8nHxOY3GnUBhifIKvAqwvTHV6LQBpfGNiGHJNa+nqA==
X-Google-Smtp-Source: ABdhPJw00BpFodkS5ZcF+/efpylIFOdCr4PQRL/4MyHZ5LWL0DORlCRZ7uoMcXsVO/OkheZOZ83hgmnEJEBowKzqtyk=
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id
 a9-20020a17090aa50900b001cac48ea795mr3782346pjq.165.1651726293470; Wed, 04
 May 2022 21:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
 <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com> <YnKR9CFYPXT1bM1F@redhat.com>
In-Reply-To: <YnKR9CFYPXT1bM1F@redhat.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Thu, 5 May 2022 10:21:21 +0530
Message-ID: <CACUYsyG+QRyObnD5eaD8pXygwBRRcBrGHLCUZb2hmMZbFOfFTg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 4, 2022 at 8:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, May 04, 2022 at 09:56:49AM +0530, Dharmendra Hans wrote:
> > On Wed, May 4, 2022 at 1:24 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, May 02, 2022 at 03:55:19PM +0530, Dharmendra Singh wrote:
> > > > From: Dharmendra Singh <dsingh@ddn.com>
> > > >
> > > > When we go for creating a file (O_CREAT), we trigger
> > > > a lookup to FUSE USER SPACE. It is very  much likely
> > > > that file does not exist yet as O_CREAT is passed to
> > > > open(). This lookup can be avoided and can be performed
> > > > as part of create call into libfuse.
> > > >
> > > > This lookup + create in single call to libfuse and finally
> > > > to USER SPACE has been named as atomic create. It is expected
> > > > that USER SPACE create the file, open it and fills in the
> > > > attributes which are then used to make inode stand/revalidate
> > > > in the kernel cache. Also if file was newly created(does not
> > > > exist yet by this time) in USER SPACE then it should be indicated
> > > > in `struct fuse_file_info` by setting a bit which is again used by
> > > > libfuse to send some flags back to fuse kernel to indicate that
> > > > that file was newly created. These flags are used by kernel to
> > > > indicate changes in parent directory.
> > >
> > > Reading the existing code a little bit more and trying to understand
> > > existing semantics. And that will help me unerstand what new is being
> > > done.
> > >
> > > So current fuse_atomic_open() does following.
> > >
> > > A. Looks up dentry (if d_in_lookup() is set).
> > > B. If dentry is positive or O_CREAT is not set, return.
> > > C. If server supports atomic create + open, use that to create file and
> > >    open it as well.
> > > D. If server does not support atomic create + open, just create file
> > >    using "mknod" and return. VFS will take care of opening the file.
> > >
> > > Now with this patch, new flow is.
> > >
> > > A. Look up dentry if d_in_lookup() is set as well as either file is not
> > >    being created or fc->no_atomic_create is set. This basiclally means
> > >    skip lookup if atomic_create is supported and file is being created.
> > >
> > > B. Remains same. if dentry is positive or O_CREATE is not set, return.
> > >
> > > C. If server supports new atomic_create(), use that.
> > >
> > > D. If not, if server supports atomic create + open, use that
> > >
> > > E. If not, fall back to mknod and do not open file.
> > >
> > > So to me this new functionality is basically atomic "lookup + create +
> > > open"?
> > >
> > > Or may be not. I see we check "fc->no_create" and fallback to mknod.
> > >
> > >         if (fc->no_create)
> > >                 goto mknod;
> > >
> > > So fc->no_create is representing both old atomic "create + open" as well
> > > as new "lookup + create + open" ?
> > >
> > > It might be obvious to you, but it is not to me. So will be great if
> > > you shed some light on this.
> > >
> >
> > I think you got it right now. New atomic create does what you
> > mentioned as new flow.  It does  lookup + create + open in single call
> > (being called as atomic create) to USER SPACE.mknod is a special case
>
> Ok, naming is little confusing. I think we will have to put it in
> commit message and where you define FUSE_ATOMIC_CREATE that what's
> the difference between FUSE_CREATE and FUSE_ATOMIC_CREATE. This is
> ATOMIC w.r.t what?

Sure, I would update the commit message to make the distinction clear
between the two. This operation is atomic w.r.t to USER SPACE FUSE
implementations. i.e USER SPACE would be performing all these
operations in a single call to it.


> May be atomic here means that "lookup + create + open" is a single operation.
> But then even FUSE_CREATE is atomic because "creat + open" is a single
> operation.
>
> In fact FUSE_CREATE does lookup anyway and returns all the information
> in fuse_entry_out.
>
> IIUC, only difference between FUSE_CREATE and FUSE_ATOMIC_CREATE is that
> later also carries information in reply whether file was actually created
> or not (FOPEN_FILE_CREATED). This will be set if file did not exist
> already and it was created indeed. Is that right?

FUSE_CREATE is atomic but upto level of libfuse. Libfuse separates it
into two calls, create and lookup separately into USER SPACE FUSE
implementation.
This FUSE_ATOMIC_CREATE does all these ops in a single call to FUSE
implementations.  We do not want to break any existing FUSE
implementations, therefore it is being introduced as a new feature. I
forgot to include links to libfuse patches as well. That would have
made it much clearer.  Here is the link to libfuse patch for this call
https://github.com/libfuse/libfuse/pull/673.

>
> I see FOPEN_FILE_CREATED is being used to avoid calling
> fuse_dir_changed(). That sounds like a separate optimization and probably
> should be in a separate patch.

FUSE_ATOMIC_CREATE needs to send back info about if  file was actually
created or not (This is suggestion from Miklos) to correctly convey if
the parent dir is really changing or not. I included this as part of
this patch itself instead of having it as a separate patch.

> IOW, I think this patch should be broken in to multiple pieces. First
> piece seems to be avoiding lookup() and given the way it is implemented,
> looks like we can avoid lookup() even by using existing FUSE_CREATE
> command. We don't necessarily need FUSE_ATOMIC_CREATE. Is that right?

Its not only about changing fuse kernel code but USER SPACE
implementations also. If we change the you are suggesting we would be
required to twist many things at libfuse and FUSE low level API. So to
keep things simple and not to break any existing implementations we
have kept it as new call (we now pass `struct stat` to USER SPACE FUSE
to filled in).

> And once that is done, a separate patch should probably should explain
> the problem and say fuse_dir_changed() call can be avoided if we knew
> if file was actually created or it was already existing there. And that's
> when one need to introduce a new command. Given this is just an extension
> of existing FUSE_CREATE command and returns additiona info about
> FOPEN_FILE_CREATED, we probably should simply call it FUSE_CREATE_EXT
> and explain how this operation is different from FUSE_CREATE.

As explained above, we are not doing this way as we have kept in mind
all existing libfuse APIs as well.
