Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB27BA3A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbjJEP6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjJEP4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:52 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6426FF2;
        Thu,  5 Oct 2023 06:07:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-452b4fd977eso482463137.1;
        Thu, 05 Oct 2023 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696511232; x=1697116032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kGRsW3ktDtW6m3KSjx2TUIO0ZRjHIgeK99H149BbmQ=;
        b=SwB+zmR1nX4yd7qHWNv+ofaQR1t/QcqqKVrcA1uIB2qOPJzsDNQson3xdPaQ4dZ+j/
         6aH66sAlJhXrH4x8728ZXNKnn66V+JrKsRPRRQIjSry+qXy8xmid7g6VPRPdZcQuke7r
         LG+fYuJY20XqmH8sEtr0IPDylGOtAu4mPouWU6rLatGk43J0RHPOaTjNrYQE2fbXpNYG
         8uECy+n6q0mV4e68CRw3GgrE3g0xPIUnqLPqDB58rzB9NGtiryUEIFBfVZuHzNDfPTF9
         CFZHiyWXWvVjHqRFA/AfeKVqe1DZCiFWSZvXUII72QRvPuzzYHCClfGo9I7PGgOUsKNc
         Navw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696511232; x=1697116032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kGRsW3ktDtW6m3KSjx2TUIO0ZRjHIgeK99H149BbmQ=;
        b=sEXWNhzcfPWQQHhIYaO86x7FlIi1kMQnVyUvQgB0p/3EeT/f1BnwptqpUm2+u7w2Mk
         DW0nYY2dLnswNzLe7wALu3jECVWdGMpINxLDUtLLoTFG91FNdO9sbTRh3bmnEeZgtHfj
         djiZD/asfpD0rj43GiyRDSGHGFDyrKQS3tPvjrIvmSCam7yWZrFHlbrXs/uBTR6Mkk/j
         rPw7sTy+xCXxJmy9d/95fODu0ZTvQhLrD4w8h2+97JtVAlpgJBYLWrp4RDux0ZCpZb17
         SvCKP11k+Dq5+c6fea08roX5QSthL507etwO35DvswlV4+rLzP+drmRWtLBf4gtDPU0q
         kSdA==
X-Gm-Message-State: AOJu0YyKqE9sqQolDM5/hz2eSd54bV/JCv4bfLcUH1s8kb3L8XsELpx4
        +HSdSyn+9dLHm+r6W4WvugY+aS4L6vnQv+krU5Y=
X-Google-Smtp-Source: AGHT+IEvgaY3HCpdmVW9l6pMHlJGhzAF7876u5S5d/QYEoIfrgWHHfOtRETgUihUE1RhZRsLaBMnSk34GujufdtSDPs=
X-Received: by 2002:a67:f65a:0:b0:44d:3f96:6c61 with SMTP id
 u26-20020a67f65a000000b0044d3f966c61mr5198137vso.30.1696511232660; Thu, 05
 Oct 2023 06:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231004185530.82088-1-jlayton@kernel.org> <20231004185530.82088-3-jlayton@kernel.org>
 <CAOQ4uxgtyaBTM1bOSSGmsk+F4ZwsK+-N5ZZ3wAt_nv_E6G3C7Q@mail.gmail.com> <9af5c896da0c39c66d0555879c04c23fd853c9de.camel@kernel.org>
In-Reply-To: <9af5c896da0c39c66d0555879c04c23fd853c9de.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Oct 2023 16:07:01 +0300
Message-ID: <CAOQ4uxhXG=oMKLgCPwnLAToxtF7MCgv7jk72iG9gZ_6B2exbwg@mail.gmail.com>
Subject: Re: [PATCH v2 89/89] fs: move i_generation into new hole created
 after timestamp conversion
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 5, 2023 at 3:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2023-10-05 at 08:08 +0300, Amir Goldstein wrote:
> > On Wed, Oct 4, 2023 at 9:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > The recent change to use discrete integers instead of struct timespec=
64
> > > shaved 8 bytes off of struct inode, but it also moves the i_lock
> > > into the previous cacheline, away from the fields that it protects.
> > >
> > > Move i_generation above the i_lock, which moves the new 4 byte hole t=
o
> > > just after the i_fsnotify_mask in my setup.
> >
> > Might be good to mention that this hole has a purpose...
> >
> > >
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  include/linux/fs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 485b5e21c8e5..686c9f33e725 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -677,6 +677,7 @@ struct inode {
> > >         u32                     i_atime_nsec;
> > >         u32                     i_mtime_nsec;
> > >         u32                     i_ctime_nsec;
> > > +       u32                     i_generation;
> > >         spinlock_t              i_lock; /* i_blocks, i_bytes, maybe i=
_size */
> > >         unsigned short          i_bytes;
> > >         u8                      i_blkbits;
> > > @@ -733,7 +734,6 @@ struct inode {
> > >                 unsigned                i_dir_seq;
> > >         };
> > >
> > > -       __u32                   i_generation;
> > >
> > >  #ifdef CONFIG_FSNOTIFY
> > >         __u32                   i_fsnotify_mask; /* all events this i=
node cares about */
> >
> > If you post another version, please leave a comment here
> >
> > +         /* 32bit hole reserved for expanding i_fsnotify_mask to 64bit=
 */
> >
>
> Sure.
>
> I suppose we could create a union there too if you really want to
> reserve it:
>
>         union {
>                 __u32           i_fsnotify_mask;
>                 __u64           __i_fsnotify_mask_ext;
>         };
>

No need.
I was thinking it is going to be
      unsigned long i_fsnotify_mask;

on 32bit arch, we either not support the high bitmask events
or we fold them with the lower 32bit in the inode mask,
because i_fsnotify_mask is an optimization to avoid going
into inode marks iteration.

Thanks,
Amir.
