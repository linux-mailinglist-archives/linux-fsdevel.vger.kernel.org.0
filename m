Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A8E16FA4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 10:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgBZJLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 04:11:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgBZJLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582708275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEqkrC4VLq8DaEUXXUlw4qM+t78tq2tEXmDFeRSdK/U=;
        b=LYX8khLquEaMYAmpi8dZX3a+4Tcgs9mZJYjMH41sxOF7boBZdvJzapJhBKV1BVnE/L8F8/
        ZS7/GiU4Ss5VGv1pjHMadZKd2jnrK+Fq1Qchy0tT/2t0s5RfI3MFC8/J3fBwDJT1feTUyj
        ZrDunVqgNfN4YYsXgwirggJqlOGEjGQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-fn3YZllmPuGcj2XnNEK4nQ-1; Wed, 26 Feb 2020 04:11:13 -0500
X-MC-Unique: fn3YZllmPuGcj2XnNEK4nQ-1
Received: by mail-qt1-f197.google.com with SMTP id l25so3626337qtu.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 01:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEqkrC4VLq8DaEUXXUlw4qM+t78tq2tEXmDFeRSdK/U=;
        b=ObkHge6P7luct7yZlfi7hiFvIJaV/DRN6KqBM2L6/fWFFv66lwNUVVXdZFUn6Xhi4D
         5gMKpL76FFenxiNesS+cVRFL4frKfBd8l75TguqlDMTsO+jcOEeY4mQUXTTaKg5yYzCo
         sV5GaKBbIkgZ2NmayaFFK5mL1Sm9j0pRBDQ2+tmNr3pZenjQFZPWqPLLB3gdAgrbP68o
         x7WxCIR62IqxwuqLZVPoD4sDDPrm8lAfwBvMomSwNywM+uPdLDxMFQkRIS10Fmjjs3Hs
         TMywN7EhEkTKsFG7Pc013XsfiSUeJTqp1vjXsZTMHndBma5lUVPzLkTTfb/cr3odmFYR
         00Nw==
X-Gm-Message-State: APjAAAVAvm8hW7b+hEwrihT3jmptYAgQdcbYWX51hT0auaGx+rM+STW2
        wOo3mZFuOM82BKoSMAKjdSHkCaSnGtu6q3h41VCLT/fL7epYe4aUiOSMrj68sgt6xSCjH7uiCu5
        Ghk6OHaihQJSO9fORumeN14Uv3aIMAWMA638j44o32w==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr4423905qka.211.1582708273448;
        Wed, 26 Feb 2020 01:11:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXjPA2Pp28AoAuqRyzeCA+TX5xe5BSYiQaT9UAKY0Cw8GAaR+YwHF7q/xXePrlEyxxI8KoSd+4S3BP8Ddn7Zw=
X-Received: by 2002:a37:40d2:: with SMTP id n201mr4423885qka.211.1582708273224;
 Wed, 26 Feb 2020 01:11:13 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
In-Reply-To: <1582644535.3361.8.camel@HansenPartnership.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 26 Feb 2020 10:11:02 +0100
Message-ID: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:29 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> The other thing a file descriptor does that sysfs doesn't is that it
> solves the information leak: if I'm in a mount namespace that has no
> access to certain mounts, I can't fspick them and thus I can't see the
> information.  By default, with sysfs I can.

That's true, but procfs/sysfs has to deal with various namespacing
issues anyway.  If this is just about hiding a number of entries, then
I don't think that's going to be a big deal.

The syscall API is efficient: single syscall per query instead of
several, no parsing necessary.

However, it is difficult to extend, because the ABI must be updated,
possibly libc and util-linux also, so that scripts can also consume
the new parameter.  With the sysfs approach only the kernel needs to
be updated, and possibly only the filesystem code, not even the VFS.

So I think the question comes down to:  do we need a highly efficient
way to query the superblock parameters all at once, or not?

Thanks,
Miklos

