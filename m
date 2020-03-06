Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D017C751
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFUv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:51:26 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33232 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFUvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:51:25 -0500
Received: by mail-io1-f65.google.com with SMTP id r15so3460000iog.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 12:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGLtF9/BkDRWldf7v6sxW1Van8tpD2gHUBIr/g2ZUWQ=;
        b=btIso5bBh9Rv1yNfjzkAnbfr2G9RML5beBupa0KwwDUB7Vp6++GaqpK9U+yZZ0xHKM
         ipSc/GpWSMvtp7BCt1SRYDgKseFvcYE6FRrC7IOt6u6eUm9kpmvEnLIf5X0Pj3+wk74Y
         jXqabBNwRqfd1bnlPa77rD0hXRB/4wM9p0ed8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGLtF9/BkDRWldf7v6sxW1Van8tpD2gHUBIr/g2ZUWQ=;
        b=F9Y0wmzP9mEmRQMAFIXHy8ZYcn14nAxuky0yeMlcDcHL2CdNiNbNtxirNlVIPEIjug
         0oCMR2RrWMPkfQtNBJIJvnbDSU8r9slCgASMOpK2gzEan+hJ9ueEAX+MHQQUvm4nZwMQ
         hZwUHjaeMTCbFYkIuq9iipUYVFcXFycHJH8GhdloKMDOCBLHPRcVFQuUiJh3yZrWz+x2
         fzfB6k5H/TEmM/pshL3RXUT5Tho/WXGnzRsJV/K6fzccTg0qFki0UZqgWNy10u8I4PEO
         AeJ0XgZ1JYd3O2IoH0xWq0qP1YlxBuezkA1trvr3DDNFNVAwCpdTvdAGNS8559M2O82q
         t69g==
X-Gm-Message-State: ANhLgQ098SpbZODw+d5PiayRt29l6D012Dfl9ljk4zdxyvF5WqctQRaZ
        YlA/jqD2aVmiYRZeSoEX5271LRKBD0zM9qv/VklBCw==
X-Google-Smtp-Source: ADFU+vu/g23Eny9Hui/8pPFHbWtFGWqaVVE0ZerOiGOSF60dyc66F/0qyRGZhlaMt49a1aoSPVziVIZ4YVAEwD0pspQ=
X-Received: by 2002:a02:70cc:: with SMTP id f195mr4679379jac.78.1583527883788;
 Fri, 06 Mar 2020 12:51:23 -0800 (PST)
MIME-Version: 1.0
References: <107666.1582907766@warthog.procyon.org.uk> <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk> <20200306200522.GA23230@ZenIV.linux.org.uk>
 <20200306203705.GB23230@ZenIV.linux.org.uk> <20200306203844.GC23230@ZenIV.linux.org.uk>
 <20200306204523.GD23230@ZenIV.linux.org.uk>
In-Reply-To: <20200306204523.GD23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Mar 2020 21:51:12 +0100
Message-ID: <CAJfpegsRjHHy5JwB8S6-f0+SXRPmfaJJnaKj8nJvwVQzNCqU=A@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 06, 2020 at 08:38:44PM +0000, Al Viro wrote:
> > On Fri, Mar 06, 2020 at 08:37:05PM +0000, Al Viro wrote:
> >
> > > You are misreading mntput_no_expire(), BTW - your get_mount() can
> > > bloody well race with umount(2), hitting the moment when we are done
> > > figuring out whether it's busy but hadn't cleaned ->mnt_ns (let alone
> > > set MNT_DOOMED) yet.  If somebody calls umount(2) on a filesystem that
> > > is not mounted anywhere else, they are not supposed to see the sucker
> > > return 0 until the filesystem is shut down.  You break that.

Ah, good point.

> >
> > While we are at it, d_alloc_parallel() requires i_rwsem on parent held
> > at least shared.

Okay.

> Egads...  Let me see if I got it right - you are providing procfs symlinks
> to objects on the internal mount of that thing.  And those objects happen
> to be directories, so one can get to their parent that way.  Or am I misreading
> that thing?

Yes.

Thanks,
Miklos
