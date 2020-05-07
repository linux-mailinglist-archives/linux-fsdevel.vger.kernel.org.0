Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330261C8BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgEGNG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgEGNG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 09:06:56 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67560C05BD43;
        Thu,  7 May 2020 06:06:55 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o24so5098637oic.0;
        Thu, 07 May 2020 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrKE0/k9TqvO63dFVD5bdAgHBAm+WjFMdax9qWxHqKs=;
        b=CojCw9Fmh9zgr/0dIGJBy9xx9eWODCnoJMmbcD0f752ky4fgbcwRw7B9uOCFzQRteP
         O2rqfKu0O73IQxAsBUNVFV+5qRjL6w/6Z4E8M+CWtfRdEF7SgdIqv4cWr9QErt9oJsy+
         jvcNmhVrwy0jEDEA3z16tYXv1cKUu6B1tKL4lcF7T0uf19RthMQchvysM2Rzbg7XHXcV
         2jm8Gvduu8R9jNUnn67MjsyYV+hbQ+JgW5mOitej7bNy4O84oi5OzqlpW06UvPp+9zVR
         4aqsRg4qS05H8m0uUCO2eyQ4D/jDNHlDyZXtevyZcNDz1VIyS5MwcO9ADjmuvS064y2b
         8+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrKE0/k9TqvO63dFVD5bdAgHBAm+WjFMdax9qWxHqKs=;
        b=HKSgkCe1nu19Tv87a4uhE8UkZPtgaFHWQ0CJMd4gz1FfKniNDJyNSoIg5VThkwwYoZ
         5sdBAERJUm02Qubfg+25sFjXnPOXL0p5hJMv7UCCr3VAEhPo3FlgnMUMCdIulwxh6dDJ
         riz35ZUwUYfirHLOQ926LVig7Xf8MNWjI9jmBLqiAXStUKocO+p/LuGVhqrzT9ubN7Sj
         QKhyOGZKFW9yDiBB4a3RObqja2sGwOUrkY7eVzCQ6yEcYtW3t+opfi1D8Fx4U/vpJiJV
         zkWGyHiVDmSUb8GLX/l0diZ1H98EzqHw5BsuFreyNxIlaix8L3nukRbULWf0sEEMF6gn
         Carw==
X-Gm-Message-State: AGi0Pub3aSIW7qAk6YqzycdE9ZEO/HUhdd2TaKh4ddEqzlLRVa1IOjCU
        xEcwR2YGvjlQzePs8Wg1Zv92CgVZH4mmHGWla7c=
X-Google-Smtp-Source: APiQypIk4Twgp18++aGpnhrRi6PUMUuxUCqdmRlUvlSXGSpcGj5jfGXT2YT7GXAqCLRLEIQmOdYavVVdR1znSrjovn8=
X-Received: by 2002:aca:4c0b:: with SMTP id z11mr6337744oia.92.1588856814638;
 Thu, 07 May 2020 06:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
 <CAJfpegtWEMd_bCeULG13PACqPq5G5HbwKjMOnCoXyFQViXE0yQ@mail.gmail.com>
 <CAEjxPJ56JXRr0MWxtekBhfNS7i8hFex2oiwqGYrh=m1cH9X4kg@mail.gmail.com> <CAJFHJrppbb1cUTq9w7G7E2RrV5CbYx54dAfk62tiZYCewcwXhg@mail.gmail.com>
In-Reply-To: <CAJFHJrppbb1cUTq9w7G7E2RrV5CbYx54dAfk62tiZYCewcwXhg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 May 2020 09:06:43 -0400
Message-ID: <CAEjxPJ6LZowJJ1uQXa+NTSMA=y2AWatNKvtp3iDcH7kL4D-qcw@mail.gmail.com>
Subject: Re: fuse doesn't use security_inode_init_security?
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 7, 2020 at 3:53 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
> On Sat, May 2, 2020 at 3:32 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> >
> > (cc selinux list)
> >
> > security_inode_init_security() calls the initxattrs callback to
> > actually set each xattr in the backing store (if any), so unless you
> > have a way to pass that to the daemon along with the create request
> > the attribute won't be persisted with the file.  Setting the xattrs is
> > supposed to be atomic with the file creation, not a separate
> > setxattr() operation after creating the file, similar to ACL
> > inheritance on new files.
> >
>
> But it's not truly atomic, is it?  The underlying file system creates
> the inode and then the inode_init_security selinux hook actually sets
> the attributes.  What would happen if the computer lost power after
> the file system driver created the inode but before the selinux hook
> set the attributes?

IIUC, in the case of ext4 and xfs at least, the setting of the
security.selinux xattr is performed in the same transaction as the
file create, so a crash will either yield a file that has its xattr
set or no file at all.  This is also true of POSIX ACLs.  Labeled NFS
(NFSv4.2) likewise is supposed to send the MAC label with the file
create request and either create it with that label or not create it
at all.  Note that nfs however uses security_dentry_init_security() to
get the MAC label since it doesn't yet have an inode and MAC labels
are a first class abstraction in NFS not merely xattrs.

> > - deadlock during mount with userspace waiting for mount(2) to complete
> > and the kernel blocked on requesting the security.selinux xattr of the
> > root directory as part of superblock setup during mount
>
> I haven't personally run into this.  It Just Works, except for the
> fscreate issue.

Yes, this can be worked around in your fuse daemon if it supports
handling getxattr during mount (e.g. multi-threaded, other threads can
service the getxattr request while the mount(2) is still in progress).
But not supported by stock fuse userspace IIUC.

> I guess what I'm trying to understand is: what are the issues with
> having the fuse driver call the inode_init_security hooks?  Even if
> it's not something that can be turned on by default in mainline, I'd
> like to evaluate whether we can turn it on locally in our restricted
> environment.
>
> One issue is the lack of atomicity guarantees.  This is likely a
> deal-breaker for general fuse usage.  However, I don't think it's an
> issue for our restricted use of virtiofs because the attributes will
> be set "atomically" from the guest userspace's perspective.  It won't
> be atomic on the host side, but host processes don't have access to
> those directories anyway.
>
> Are there any other issues?

I don't have a problem with fuse calling the hook (either
security_inode_init_security or security_dentry_init_security).  It is
just a question of what it will do with the result (i.e. what its
initxattr callback will do for the former or what it will do with the
returned label in the latter). Optimally it will take the label
information and bundle it up along with the create request to the
daemon, which can then handle it as a single transaction.  Failing
that, it needs to support setting the label in some manner during file
creation that at least provides atomicity with respect to the user of
the filesystem (the guest in your case).
