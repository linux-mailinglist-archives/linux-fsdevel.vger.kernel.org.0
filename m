Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4741549F7ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 12:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbiA1LJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 06:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbiA1LJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:09:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BDC061749;
        Fri, 28 Jan 2022 03:09:26 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e8so5034631ilm.13;
        Fri, 28 Jan 2022 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDt4jv4w3YC6Q40GetvSo+cqdaAT0L68ivf9sPs/K8Q=;
        b=EJ4fNl8jGpwOF+l7mYmqwnMdwQaU7ijAZyfJ0sMP9w1lOujGb+aadfBn078cU/LVXQ
         CIjZFd2s8/1wcIz/IAfucniv59I5ug6C1Wdfc4DmVqaGXWPlVnXX7KfoI2I8zkuY9qlP
         slYslrq1aeQhKYeGIWKYTvFuoORRrgA2yZSefrae4Ke3pluEiuMI7Dxy/N72sYXzYXx7
         Fr+7EpWiyElnfqtE0K2vQhHIsB3XjL8vEbzhId/UQ5TsdvG+J8gcQUD25CwxTorFlFOy
         5OjZ4v7itBoShKaf4qwlumgWCxZW6/wuL1AbNbZbaJQHo00QFfeTgUAUvJl5/SQ3uTFN
         KTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDt4jv4w3YC6Q40GetvSo+cqdaAT0L68ivf9sPs/K8Q=;
        b=44c7AKpxFYlPu29UIm0/tkLWMYAjRyJ4G8rq2VJWNmb2CaT6jbAlRl5J23zQOmUvik
         kk+y83cmxZ1hRutFHauwT0XMinHFhvxGlnFy/SgLOJORtwx6GeiWl14FE9wIJUrNes/L
         oatT/wMpXx7sB+5EsxV8TqLKu8aJ5mkPu5+k8rveHY5CUjXxzb+PxCkAC5nrQfy7ZU8I
         +1Lb/E1TUsMxcvLV+uJt/za6OzKlnJdjPvpgabcvk3DELUjp7mjYS7nDuKXz9fbd9VM1
         +dqVp8b8OCMXAVfyh/eF98rsFRnQv5/IjZUIttaLN0+9Q3ypkxi+5u7KwfCU7aB4BISl
         bq8A==
X-Gm-Message-State: AOAM531PhPQTIN9u1Ug4SaaqecSDVMfFfDKZ3Gm+FUL8UPJnk+obnnna
        m3tzF/liMSCZzQXT6MFl2k4Zj1IewVIM9GSGdmQ=
X-Google-Smtp-Source: ABdhPJz/5GVv0Jc1fW6Af1E7s8iF0un/k2ZX3rLG5cEAum2D2zhCnqeEMRYTO6D1GV6CZwFQWFxbLpDEovkL/Cmpe5U=
X-Received: by 2002:a92:c567:: with SMTP id b7mr5367192ilj.24.1643368165717;
 Fri, 28 Jan 2022 03:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20220128074731.1623738-1-hch@lst.de> <918225.1643364739@warthog.procyon.org.uk>
In-Reply-To: <918225.1643364739@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Jan 2022 13:09:14 +0200
Message-ID: <CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: rename S_KERNEL_FILE
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:12 PM David Howells <dhowells@redhat.com> wrote:
>
> Christoph Hellwig <hch@lst.de> wrote:
>
> > S_KERNEL_FILE is grossly misnamed.  We have plenty of files hold
>
> "held".
>
> > open by the kernel kernel using filp_open.
>
> You said "kernel" twice.
>
> And so what?  Cachefiles holds files open by filp_open - but it can only do so
> temporarily otherwise EMFILE/ENFILE and OOMs start to become a serious problem
> because it could end up holding thousands of files open (one or two of the
> xfstests cause this to happen).
>
> Further, holding the file open *doesn't* prevent cachefilesd from trying to
> cull the file to make space whilst it's "in use".
>
> Yet further, I'm not holding the directories that form the cache layout open
> with filp_open at all - I'm not reading them, so that would just be a waste of
> resources - but I really don't want cachefilesd culling them because it sees
> they're empty but cachefiles is holding them ready.
>
> > This flag OTOH signals the inode as being a special snowflake that
> > cachefiles holds onto that can't be unlinked because of ..., erm, pixie
> > dust.
>
> Really?  I presume you read the explanation I gave of the races that are a
> consequence of splitting the driver between the kernel and userspace?  I could
> avoid them - or at least mitigate them - by keeping my own list of all the
> inodes in use by cachefiles so that cachefilesd can query it.  I did, in fact,
> use to have such a list, but the core kernel already has such lists and the
> facilities to translate pathnames into internal objects, so my stuff ought to
> be redundant - all I need is one inode flag.
>
> Further, that inode flag can be shared with anyone else who wants to do
> something similar.  It's just an "I'm using this" lock.  There's no particular
> reason to limit its use to cachefiles.  In fact, it is better if it is then
> shared so that in the unlikely event that two drivers try to use the same
> file, an error will occur.
>

Good idea, but then the helpers to set the flag should not be internal
to cachefiles and the locking semantics should be clear.
FYI, overlayfs already takes an "exclusive lock" on upper/work dir
among all ovl instances.

How do you feel about hoisting ovl_inuse_* helpers to fs.h
and rename s/I_OVL_INUSE/I_EXCL_INUSE?

Whether deny rmdir should have its own flag or not I don't know,
but from ovl POV I *think* it should not be a problem to deny rmdir
for the ovl upper/work dirs as long as ovl is mounted(?).

From our experience, adding the exclusive lock caused regressions
in setups with container runtimes that had mount leaks bugs.
I am hoping that all those mount leaks bugs were fixed, but one never
knows what sort of regressions deny rmdir of upper/work may cause.

Another problem with generic deny of rmdir is that users getting
EBUSY have no way to figure out the reason.
At least for a specific subsystem (i.e. cachefiles) users should be able
to check if the denied dir is in the subsystem's inventory(?)

Thanks,
Amir.
