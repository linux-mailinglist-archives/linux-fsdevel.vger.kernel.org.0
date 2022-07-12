Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D24572597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 21:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiGLT0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiGLT0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:26:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D7DA9AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:02:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y8so11314276eda.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0VRFok8d4RtwxBJHjcSvKbaYsKKMZp/aSix2M34JvJo=;
        b=fGQ5E6UUyfgi3CeL69sbjE1DvDwNiQns8vMDwoIkMhJ9leWvDoxZce9MughV5jeJSB
         9IeB6UM+jI4kQsJj1LKGf4JrXO3APmr0+O6Aya7hFSllM4MIsNmpf8hU5gAJDCTo2jm2
         MlATrIxXjZVpqZ+d1cpGMUsvT+BEmW4d1zplVoB9M5epNXwzkE6qPJ5kUIG5r8mqLiZo
         yQEbjPFUcY+hJRsnY2IBAsj0a0iGIHUp+1KRGbZLLrbOdExfeXoyT0Dao848636wB3z7
         f8aa0cZ8mxnxrxmanEdqaEn1Eph6SJnqLWSU5tOZuA5nuDUYQDdQgxpYUA59iL1KCz5e
         rZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0VRFok8d4RtwxBJHjcSvKbaYsKKMZp/aSix2M34JvJo=;
        b=PwHj/H4aZP8TqsRs/RS6HoFRQ4bnnLhVG+lTCMdSP0UCHgBlqqfA1dVS3XyykSEm7e
         Dq5tjfZhnpbrW+JSucS/LGutTmC/zIOkchtHYDIEB0LkuM5tpuMeKZx3VO01ZArFT1vf
         CcClYAWRjsxGFsfwKEK8227mWW7KhS6eai4sPbDV20jjmO3Svmedivm6K1ozkAW6IV4H
         zOz8c5p2appUwW/AcJRFPl23pkRtaNpjRour+Dmf9hddVkvPtmUhaHtv6C+ijdVrWiJc
         d5CyHfk/v0GZIo86nRptslyQRBt4fcEmoUg4lMfgm2mTuVvvv96L9XbyIak39kfybqSW
         GYPQ==
X-Gm-Message-State: AJIora9cHPyhpIsPr7AtjFWNA5KElP/Gjyz6V3+wj0hDMXrStuYtHqxm
        5cqtiZvDYftsN4ehRNs5aCvRRz+u61u9RD2sPDpx4w==
X-Google-Smtp-Source: AGRyM1ubLJKY5I+/fjTZNDmzlEp9u1N/65nfRHYH6xkCmEtTjo8Hv2jGB7g5zd6WvUwsjqkqH71+v1VuuHJE8Kx0PqE=
X-Received: by 2002:a05:6402:3581:b0:43a:d66b:99b5 with SMTP id
 y1-20020a056402358100b0043ad66b99b5mr15416269edc.375.1657652555569; Tue, 12
 Jul 2022 12:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de> <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 12 Jul 2022 15:02:24 -0400
Message-ID: <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 1:33 PM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> [ Adding random people who get blamed for lines in this remap_range
> thing to the participants ]
>
> On Tue, Jul 12, 2022 at 5:11 AM Ansgar L=C3=B6=C3=9Fer
> <ansgar.loesser@tu-darmstadt.de> wrote:
> >
> > using the deduplication API we found out, that the FIDEDUPERANGE ioctl
> > syscall can be used to read a writeonly file.
>
> So I think your patch is slightly wrong, but I think this is worth
> fixing - just likely differently.
>
> First off - an odd technicality: you can already read write-only files
> by simply mmap'ing them, because on many architectures PROT_WRITE ends
> up implying PROT_READ too.
>
> So you should basically expect that "I have permissions to write to
> the file" automatically means that you can read it too.
>
> People simply do that "open for writing, mmap to change it" and expect
> it to work - not realizing that that means you have to be able to read
> it too.
>
> Anybody who thought otherwise was sadly wrong, and if you depend on
> "this is write-only" as some kind of security measure for secrets, you
> need to fix your setup.
>
> Now, is that a "feature or a bug"? You be the judge.It is what it is,
> and it's always been that way. Writability trumps readability, even if
> you have to do special things to get there.
>
> That said, this file remap case was clearly not intentional, and
> despite the mmap() issue I think this is just plain wrong and we
> should fix it as a QoI issue.
>
> A dedupe may only write to the destination file, but at the same time
> it does obviously have that implication of "I need to be able to read
> it to see that it's duplicate".

Yeah the implication is there of course, we might as well honor it I
think?  Clearly it's sort of silly to say that the write doesn't imply
read, especially since we can get around it in other ways, but at the
same time I don't really see a harm in adding the extra "hey I can
read this too, right?" since DEDUPE does imply we need to be able to
read both sides.

>
> However, your patch is wrong:
>
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -414,11 +414,11 @@ static bool allow_file_dedupe(struct file *file)
> >
> >       if (capable(CAP_SYS_ADMIN))
> >           return true;
> > -    if (file->f_mode & FMODE_WRITE)
> > +    if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D (FMODE_READ=
 |
> > FMODE_WRITE))
> >           return true;
>
> This part looks like a good idea - although it is possible that people
> will argue that this is the same kind of issue as 'mmap()' has (but
> unlike mmap, we don't have "this is how the hardware works" issues, or
> "long history of uses").
>
> But
>
> > -    if (!inode_permission(mnt_userns, inode, MAY_WRITE))
> > +    if (!inode_permission(mnt_userns, inode, MAY_READ | MAY_WRITE))
>
> looks wrong.
>
> Note that readability is about the file *descriptor*, not the inode.
> Because the file descriptor may have been opened by somebody who had
> permission to read the file even for a write-only file.
>
> That happens for capability reasons, but it also happens for things
> like "open(O_RDWR | O_CREAT, 0444)" which creates a new file that is
> write-only in the filesystem, but despite that the file descriptor is
> actually readable by the opener.
>
> I wonder if the inode_permission() check should just be removed
> entirely (ie the MAY_WRITE check smells bogus too, for the same reason
> I don't like the added MAY_READ one)
>
>  The file permission check - that was done at open time - is the
> correct one, and is the one that read/write already uses.
>
> Any permission checks done at IO time are basically always buggy:
> things may have changed since the 'open()', and those changes
> explicitly should *not* matter for the IO. That's really fundamentally
> how UNIX file permissions work.
>

I don't think we should go this far, after all the normal
write()/read() syscalls do the permission checking each time as well,
so this is consistent with any other file modification operation.  Of
course it's racey, but we should probably be consistently racey with
any other file modification operation.  Thanks,

Josef
