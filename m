Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F02C6D24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 23:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbgK0WND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 17:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbgK0WMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:12:03 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82737C0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 14:11:58 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u21so6032217iol.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Tzy7SZbbwW8nqIlM9ULMcC6IhFFL2USjTf7kSV1L4w=;
        b=p+NwQMlzpXG75n2TL8qbRwFJghPvivJkvvimq+bxms0kZhtK2eh3qxcXEZZEqf95b4
         V2AG1HX4Bsy3Lb0jC8zyxetSohsDW24n9dgbcGB/88t+e2XH4MokECq5EKjPSjQIei9q
         lwJUNHJFho2Ac0XVmw6VP7gLaHXNR9i4h+iKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Tzy7SZbbwW8nqIlM9ULMcC6IhFFL2USjTf7kSV1L4w=;
        b=fHN/hMNeizkVs/6U2JRyKbZJlBqfwyQlaKVeZ+y8nkDIuudckAcToo+f5EGHNG5XK1
         E5/xa7dQkkhBZqPvWSoWiwuDWM7FNFmG/ib+nuQcLAD/Webnq1NZp8/eEOfhqAAVCWAN
         ohUNnRKV2K5lngOlE94YaUtxiPnhZjviTeVajm5fHUrkxCw8sw9uzFnppat3v+7ksu9z
         vNqbsEjsj/1UVzWO8vq5V+VRD+h57u0hw3XyWFKAxgSxx57qnUvXs1aELBm87Btf4/9b
         BnpLi/t+QSuhg50ewiLXD9tS/Mbm+ZDhBuYunt4paM+PaBNpz4OYzB1MJDS9Da02LWqC
         Qtag==
X-Gm-Message-State: AOAM533/ijt+1xIFousl1wLYq5NiNsNIOal7E2SwbmfH2pikFVvMxVnX
        fxchG+rFJPbhwVWKR+D9qwsJoA==
X-Google-Smtp-Source: ABdhPJyYUXypKceUkeItGokO2dAqrfJEhphXr6i6WKn0Sg4j0XCBKAfEOf7JCVaPhZvizRIWNtY7sQ==
X-Received: by 2002:a6b:6217:: with SMTP id f23mr7558740iog.201.1606515117668;
        Fri, 27 Nov 2020 14:11:57 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id r3sm6155572ilt.76.2020.11.27.14.11.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Nov 2020 14:11:57 -0800 (PST)
Date:   Fri, 27 Nov 2020 22:11:55 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 2/4] overlay: Document current outstanding shortcoming
 of volatile
Message-ID: <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201127092058.15117-1-sargun@sargun.me>
 <20201127092058.15117-3-sargun@sargun.me>
 <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:52:52PM +0200, Amir Goldstein wrote:
> On Fri, Nov 27, 2020 at 11:21 AM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > This documents behaviour that was discussed in a thread about the volatile
> > feature. Specifically, how failures can go hidden from asynchronous writes
> > (such as from mmap, or writes that are not immediately flushed to the
> > filesystem). Although we pass through calls like msync, fallocate, and
> > write, and will still return errors on those, it doesn't guarantee all
> > kinds of errors will happen at those times, and thus may hide errors.
> >
> > In the future, we can add error checking to all interactions with the
> > upperdir, and pass through errseq_t from the upperdir on mappings,
> > and other interactions with the filesystem[1].
> >
> > [1]: https://lore.kernel.org/linux-unionfs/20201116045758.21774-1-sargun@sargun.me/T/#m7d501f375e031056efad626e471a1392dd3aad33
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  Documentation/filesystems/overlayfs.rst | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> > index 580ab9a0fe31..c6e30c1bc2f2 100644
> > --- a/Documentation/filesystems/overlayfs.rst
> > +++ b/Documentation/filesystems/overlayfs.rst
> > @@ -570,7 +570,11 @@ Volatile mount
> >  This is enabled with the "volatile" mount option.  Volatile mounts are not
> >  guaranteed to survive a crash.  It is strongly recommended that volatile
> >  mounts are only used if data written to the overlay can be recreated
> > -without significant effort.
> > +without significant effort.  In addition to this, the sync family of syscalls
> > +are not sufficient to determine whether a write failed as sync calls are
> > +omitted.  For this reason, it is important that the filesystem used by the
> > +upperdir handles failure in a fashion that's suitable for the user.  For
> > +example, upon detecting a fault, ext4 can be configured to panic.
> >
> 
> Reading this now, I think I may have wrongly analysed the issue.
> Specifically, when I wrote that the very minimum is to document the
> issue, it was under the assumption that a proper fix is hard.
> I think I was wrong and that the very minimum is to check for errseq
> since mount on the fsync and syncfs calls.
> 
> Why? first of all because it is very very simple and goes a long way to
> fix the broken contract with applications, not the contract about durability
> obviously, but the contract about write+fsync+read expects to find the written
> data (during the same mount era).
> 
> Second, because the sentence you added above is hard for users to understand
> and out of context. If we properly handle the writeback error in fsync/syncfs,
> then this sentence becomes irrelevant.
> The fact that ext4 can lose data if application did not fsync after
> write is true
> for volatile as well as non-volatile and it is therefore not relevant
> in the context
> of overlayfs documentation at all.
> 
> Am I wrong saying that it is very very simple to fix?
> Would you mind making that fix at the bottom of the patch series, so it can
> be easily applied to stable kernels?
> 
> Thanks,
> Amir.

I'm not sure it's so easy. In VFS, there are places where the superblock's 
errseq is checked[1]. AFAIK, that's going to check "our" errseq, and not the 
errseq of the real corresponding real file's superblock. One solution might be 
as part of all these callbacks we set our errseq to the errseq of the filesystem 
that the upperdir, and then rely on VFS's checking.

I'm having a hard time figuring out how to deal with the per-mapping based
error tracking. It seems like this infrastructure was only partially completed
by Jeff Layton[2]. I don't now how it's actually supposed to work right now,
as not all of his patches landed.

How about I split this into two patchsets? One, where I add the logic to copy
the errseq on callbacks to fsync from the upperdir to the ovl fs superblock,
and thus allowing VFS to bubble up errors, and the documentation. We can CC
stable on those because I think it has an effect that's universal across
all filesystems.

P.S. 
I notice you maintain overlay tests outside of the kernel. Unfortunately, I 
think for this kind of test, it requires in kernel code to artificially bump the 
writeback error count on the upperdir, or it requires the failure injection 
infrastructure. 

Simulating this behaviour is non-trivial without in-kernel support:

P1: Open(f) -> p1.fd
P2: Open(f) -> p2.fd
P1: syncfs(p1.fd) -> errrno
P2: syncfs(p1.fd) -> 0 # This should return an error


[1]: https://elixir.bootlin.com/linux/latest/source/fs/sync.c#L175
[2]: https://lwn.net/Articles/722250/
