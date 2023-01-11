Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49F665085
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 01:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjAKApy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 19:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjAKApk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:45:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C925A89A
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 16:45:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d17so13528751wrs.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ba8myzt4ySSFz4aU4r9qGU3S4MlFiRjAP3chJzstss=;
        b=qN9okT/MMuKphjusRHmZneeZAh1UO8RDipJXW7EjfCuxiHnBEymvRAJVcmVck3dGSN
         QhsKpsNK8aPDVRKTTamY21T5oYARrsmjPj1W8HPWqFLwBmibX91+Qz31+N/ILEcWO5n7
         uenu2g2RmxOA9N8RQsQ2/UULbxKOf5lOskJJ/e4/WOK55tlwbrQq3WbAy7n0GmA0p9au
         pd/6rIYEADdYiIWOrG22k/g1Qoq2QUH4F2xmKf1jR41wouJ6ueQgv4A5d+gBC5Pykws4
         fwFafWQla+Oyn/oHVCbu8VY7qo3ggLZz9yRYJBYWayjdotkilyuxXlyJAJvw/NF6tVfp
         ZApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ba8myzt4ySSFz4aU4r9qGU3S4MlFiRjAP3chJzstss=;
        b=M4XFkp4j2O/HeQl3XWzQT94OTt4HSqgn0vnlJBasIqJ0EMjifSnwXI9Kz4jg18BmkU
         FZaGMftKv0qjlK/Gs01mr6ejORMD40hShETu2dTx+o23XA/yx/J9H184Ly5a0LO2NuXZ
         cwxfWLYpUv6VRPZFPRzO2VPv5Cupj1RbUW6emSre9sypUlQglNakqlv/+2IHo275PRhO
         nK2/Q8zoWJsBI2JvOK9NTLHvrRXF5KAf3Ewx+tGw1M1G7PA7gb5sS2VP17dPbmvcnrHx
         QAQ5kU2QGoy9u4PBcEBdeAXl8DIQwjErlaIo2zFTyLX5PojX7IWdm/Ahc2V6PR4C58Fa
         VOQg==
X-Gm-Message-State: AFqh2kpXot5lmYZWPTTAgWrXHZ0pvqP1MCCrGreyx5vuEB4QJ9MvKA1R
        EBBWfSBAbm15Mn6WY1P3PI+MpVoAmvVBZ2BWzbwPq6Tk
X-Google-Smtp-Source: AMrXdXtuZhaC58A9Ya83r3OT+f39Oe0MoSa32u3UCxZROR25wLaRqqVxViZcD3Ua8qshDAeZjgd14mABNxXSJd+7S0w=
X-Received: by 2002:a5d:5d8a:0:b0:242:257f:3006 with SMTP id
 ci10-20020a5d5d8a000000b00242257f3006mr1541928wrb.147.1673397932242; Tue, 10
 Jan 2023 16:45:32 -0800 (PST)
MIME-Version: 1.0
References: <CAFkJGRdxR=0GeRWiu2g0QrVNzMLqYpqZm6+Ac5Baz2DcL39HTQ@mail.gmail.com>
 <Y7y1yNOfaGlOyhz6@mit.edu>
In-Reply-To: <Y7y1yNOfaGlOyhz6@mit.edu>
From:   Anadon <joshua.r.marshall.1991@gmail.com>
Date:   Tue, 10 Jan 2023 19:45:21 -0500
Message-ID: <CAFkJGRfi4kn09vLSoq612G9os2NfrQN0dEd=o7hNZBaMfoshgQ@mail.gmail.com>
Subject: Re: Do I really need to add mount2 and umount3 syscalls for some
 crazy experiment
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good evening Ted,

You bring up good points, and I'll clarify.  The original prompt for
me was that there are tons of network queue, distributed lock, and
network file sharing software.  On a single system, all of these have
been solved through simple file idioms like named pipes, file locking,
and basic file operations.  Wouldn't it be nice to have all those
idioms transparently work for single systems as in a distributed
manner?  And I'd like to avoid a single point of failure while better
understanding and addressing concerns system administrators have with
NFS.  You're right, I don't have many details about this prompt.
There's not much I can do about my ignorance without trying.

There are a set of characteristics which I would like to preserve.  I
would like connected mount points using a consensus algorithm to
preserve user facing guarantees specified by POSIX.1 such that an
operation applied to one mount point is applied synchronously to all
connected mount points.  Separate operations are asynchronous and it
is the responsibility of the user or program to handle these cases
appropriately, as would be the case if operating strictly locally with
similar concurrency conditions.  It should be accessible in some way
without special permissions and require secure operation via key
exchange and encrypted messaging.   This description is still
malformed.  I want to do a PhD on the subject, but I haven't done that
yet.

Before I step into that thicket, it looks like my trivial case is a
"pass-through" file system.  So I need to learn and implement that.
It seems like a pass-through would just forward all function calls.
That's non-trivial and I need to investigate security hooks because
they might meet my needs, overlayfs because it may allow locking the
underlying directory in a serviceable way, and much of the work
referenced by Amir.

On Mon, Jan 9, 2023 at 7:48 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Jan 08, 2023 at 11:46:38PM -0500, Anadon wrote:
> > I am looking into implementing a distributed RAFT filesystem for
> > reasons.  Before this, I want what is in effect a simple pass-through
> > filesystem.  Something which just takes in calls to open, read, close,
> > etc and forwards them to a specified mounted* filesystem.  Hopefully
> > through FUSE before jumping straight into kernel development.
> >
> > Doing this and having files appear in two places by calling `mount()`
> > then calling the (potentially) userland functions to the mapped file
> > by changing the file path is a way to technically accomplish
> > something.  This has the effect of the files being accessible in two
> > locations.
>
> I fon't quite understand *why* you want to implement a passthrough
> filesystem in terms of how it relates to creating a distributed RAFT
> file system.
>
> Files (and indeed, entire directory hierarchies) being accessible in
> two locations is not a big deal; this can be done using a bind mount
> without needing any kernel code.
>
> And if the question is how to deal with files that can be modified
> externally, from a system elsewhere in the local network (or
> cluster/cell), well, all networked file systems such as NFS, et.al.,
> do this.  If a networked file system knows that a particular file has
> been modified, it can easily invalidate the local page cache copies of
> the file.  Now, if that file is currently being used, and is being
> mmap'ed into some process's address space, perhaps as the read-only
> text (code) segment, what the semantics should be if it is modified
> remotely out from under that process --- or whether the file should be
> allowed to be modified at all if it is being used in certain ways, is
> a semantic/design/policy question you need to answer before we can
> talk about how this might be implemented.
>
> > The problems start where the underlying filesystem won't
> > notify my passthrough layer if there are changes made.
>
> Now, how an underlying file system might notify your passthrough layer
> will no doubt be comletely different from how a distributed/networked
> file system will notify the node-level implementation of that file
> system.  So I'm not at all sure how this is relevant for your use
> case.  (And if you want a file to appear in two places at the same
> time, just make that file *be* the same file in two places via a bind
> mount.)
>
> >  What would be better is to have some struct with all
> > relevant function pointers and data accessible.  That sounds like
> > adding syscalls `int mount2(const char* device, ..., struct
> > return_fs_interface)` and `int umuont3(struct return_fs_interface)`.
>
> I don't understand what you want to do here.  What is going to be in
> this "struct return_fs_interface"?  Function pointers?  Do you really
> want to have kernel code calling userspace functions?  Uh, that's a
> really bad idea.  You should take a closer look at how the FUSE
> kernel/usersace interface works, if the goal is to do something like
> this via a userspace FUSE-like scheme.
>
> > I have looked at `fsopen(...)` as an alternative, but it still does
> > not meet my use case.  Another way would be to compile in every
> > filesystem driver but this just seems downright mad.  Is there a good
> > option I have overlooked?  Am I even asking in the right place?
>
> I'm not sure what "compiling in efvery filesystem driver" is trying to
> accomplish.  Compiling into *what*?   For what purpose?
>
> I'm not sure you are asking the right questions.  It might be better
> to say in more detail what are the functional requirements what it is
> you are trying to achieve, before asking people to evaluate potential
> implementation approaches.
>
> Best regards,
>
>                                                 - Ted
