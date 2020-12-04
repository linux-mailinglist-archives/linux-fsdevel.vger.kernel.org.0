Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F62CE849
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 07:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgLDGqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 01:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLDGqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:46:15 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327AC061A51;
        Thu,  3 Dec 2020 22:45:28 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n14so4699753iom.10;
        Thu, 03 Dec 2020 22:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ji7lnODD86OvcD1GRe4ZTKTW6GNjOwZtQgzj2MJUj5Y=;
        b=Xywy5lY0sw6zLewJ8SPDNBMYMRLQlehPbQhyCgwvXevAeo6l8yz0F4w4kNeocgEVfN
         NiFgslqN2xxX4bcGQIH/Bl161QFnq8T9Bx6HCmBq5snZCMXY2TrBL9EzGdmeb+6Csy1v
         KK487zppO+/WMn4yI9ncldbCzNURZEqMbMviU6TB7p8H1vH0pPYkJaYRz4AOZxHsquzP
         n3InRm/k74U5weGUlFpMfMeOmknVJplk/rUrbDngzAqZN1H6oy/DpNexQ5j861dc94Pf
         chbMxbOCyRf54wDcvlCm2CyafF6pIS1aHWfC2LOgk6c+YLNodLI3W0BxEgXeL82TmkFg
         yH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ji7lnODD86OvcD1GRe4ZTKTW6GNjOwZtQgzj2MJUj5Y=;
        b=tXNdVTdL1YqFgl+cT6ZrKr6SKZALH1aHqCVvKh/gQ34Tx128yD3WFfWddN1otK8q22
         VM2xaof0d6uFjxikfofBcqX8T3sAw3D7t6HMODIFILlOvckgz0px2orhXKMvWUu5ACCd
         coneHB3YhvV78VoeuX0DKU5m7RUeIauA//91TMWp4IJNsh5sttWNeKUuiYEHu/aXUsN7
         hbS3r1XrkmVowYWKoOcV6TdGWLX/bF8eVJogZD7stJ0dkcrEE2KE2fAUlRT3awRGRymb
         dGZmt3X5E/RnkvCkYCJBMb/miWmRWCU60KYiyxjDcXnMBeCGQjJc31gnjIQzrMlqrbYg
         TZ/A==
X-Gm-Message-State: AOAM532ZGqjwXgcNS51CrWwGpXAWeLZ7aYzdNMi8GjrX1jx7OoSxrLX2
        KRpEFN2g17aTGiPVC219zfBMncIAgSpIzJK7ohQ5Z4vd
X-Google-Smtp-Source: ABdhPJz0TmpZazTiLodDcK5J3SQTBxG5R/x9rowDVhVbo18nFcgok/i+8nQlLzanpBl2Tedb3yrm17jzTNiAYGWwtTs=
X-Received: by 2002:a05:6602:1608:: with SMTP id x8mr4362983iow.72.1607064328278;
 Thu, 03 Dec 2020 22:45:28 -0800 (PST)
MIME-Version: 1.0
References: <0a3979479ffbf080fa1cd492923a7fa8984078b9.camel@redhat.com>
 <20201202213434.GA4070@redhat.com> <2e08895bf0650513d7d12e66965eec611f361be3.camel@redhat.com>
 <20201203104225.GA30173@ircssh-2.c.rugged-nimbus-611.internal>
 <20201203142712.GA3266@redhat.com> <93894cddefff0118d8b1f5f69816da519cb0a735.camel@redhat.com>
 <CAMp4zn_Mn8khp43XvNbAPg5qzriRY6ozdB2enMOTYRLwcBf_Cw@mail.gmail.com>
 <e5534c44661a503102cd23965a85291f0dec907a.camel@redhat.com>
 <20201203204356.GF3266@redhat.com> <b38de55c91ecd7b1102c62cb36e81bb156748d1c.camel@redhat.com>
 <20201203222457.GB12683@redhat.com> <742b7c180d4fe18ddbf28fea6505b08475c4aace.camel@redhat.com>
In-Reply-To: <742b7c180d4fe18ddbf28fea6505b08475c4aace.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 4 Dec 2020 08:45:16 +0200
Message-ID: <CAOQ4uxgjrL3aCK+aO1Wrs7qaKWNmKnAWBQaDXO-hzCR4eBmdMg@mail.gmail.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error behaviour
To:     Jeff Layton <jlayton@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Here is the background.
> >
> > We introduced a new option "-o volatile" for overlayfs. What this option
> > does is that it disables all calls to sync/syncfs/fsync and returns
> > success.
> >
> > https://www.kernel.org/doc/html/latest/filesystems/overlayfs.html?highlight=overlayfs#volatile-mount
> >
> > Now one problem with this we realized is that what happens if there is
> > a writeback error on upper filesystem. Previously fsync will catch
> > that error and return to user space. Now we are not doing any actual
> > sync for volatile mount, so we don't have a way to detect if any
> > writeback error happened on upper filesystem.
> >
> > So it is possible that an application writes something to overlay
> > volatile mount and gets back corrupted/old data.
> >
> > - App writes something.
> > - Writeback of that page fails
> > - app does fsync, which succeds without doing any sync.
> > - app reads back page and can get old data if page has been evicted out
> >   of cache.
> >
> > So we lost capability to return writeback errors to user space with
> > volatile mounts. So Amir/Sargun proposed that lets take snapshot
> > of upper ->s_wb_err when volatile overlay is being mounted. And
> > on every sync/fsync call check if any error has happened on upper
> > since volatile overlay has been mounted. If yes, return error to
> > user space.
> >
> > In fact, Idea is that once an error has been detected, volatile
> > overlay should effectively return -EIO for all the operations. IOW,
> > one should now unmount it, throw away upper and restart again.
> >
> >
> > > If it turns out that you just want to see if it ever had an error, you
> > > can always use errseq_check with 0 as the "since" value and that will
> > > tell you without marking or advancing anything. It's not clear to me
> > > what the value of that is here though.
> >
> > I think "since == 0" will not work. Say upper already has an error
> > (seen/unseen), then errseq_check() will always return error. We
> > don't want that. We don't care if upper has an seen/unseen error
> > at the time when we sample it. What we care about is that if
> > there is an error after we sampled, we can detect that and make
> > whole volatile mount bad.
> >
> > >
> > > > So key requirement here seems to be being able to detect error
> > > > on underlying superblock without consuming the unseen error.
> > > >
> > >
> > > I think for overlayfs what you really want to do is basically "proxy"
> > > fsync and syncfs calls to the upper layer. Then you should just be able
> > > to use the upper layer's "realfile" when doing fsync/syncfs. You won't
> > > need to sample anything at mount time that way as it should just happen
> > > naturally when you open files on overlayfs.
> >
> > Which we already do, right? ovl_fsync()/ovl_sync() result in a
> > call on upper. This probably can be improve futher.
> >
> > >
> > > That does mean you may need to rework how the syncfs syscall dispatches
> > > to the filesystem, but that's not too difficult in principle.
> >
> > I think we are looking at two overlay cases here. One is regular
> > overlayfs where syncfs() needs to be reworked to propagate errors
> > from upper/ to all the way to application. Right now VFS ignores
> > error returned from ->sync_fs.
> >
> > The other case we are trying to solve right now is volatile mount.
> > Where we will not actually call fsync/sync_filesystem() on upper
> > but still want to detect if any error happened since we mounted
> > this volatile mount.
> >
> > And that's why all this discussion of being able to detect an
> > error on super block without actually consuming the error. Once
> > we detect that some error has happened on upper since we mounted,
> > we can start returning errors for all I/O operations to user and
> > user is supposed to unmount and throw away upper dir and restart.
> >
>
>
> The problem here is that you want to be able to sample the thing in two
> different ways such that you potentially get two different results
> afterward:
>
> 1) the current syncfs/fsync case where we don't expect later openers to
> be able to see the error after you take it.
>
> 2) the situation you want where you want to sample the errseq_t but
> don't want to cloak an fsync on a subsequent open from seeing it
>
> That's fundamentally not going to work with the single SEEN flag we're
> using now. I wonder if you could get you the semantics you want with 2
> flags instead of 1. Basically, split the SEEN bit into two:
>
> 1) a bit to indicate that the counter doesn't need to be incremented the
> next time an error is recorded (SKIP_INC)
>
> 2) a bit to indicate that the error has been reported in a way that was
> returned to userland, such that later openers won't see it (SEEN)
>
> Then you could just add two different sorts of sampling functions. One
> would set both bits when sampling (or advancing) and the other would
> just set one of them.
>
> It's a bit more complicated than what we're doing now though and you'd
> need to work through the logic of how the API would interact with both
> flags.
>

This discussion is a very good exercise for my brain ;-)
but I think we are really over complicating the requirements of volatile.

My suggestion to sample sb error on mount was over-interpreted that
we MUST disregard writeback errors that happened before the mount.
I don't think this is a requirement. If anything, this is a non-requirement.
Why? because what happens if someone unpacks the layers onto
underlying fs (as docker most surely does) and then mounts the volatile
overlay. The files data could have been lost in the time that passed between
unpack of layer and overlay mount.

Of course overlayfs can not be held responsible for the integrity of the
layers it was handed, but why work so hard to deprive users of something
that can benefit the integrity of their system?

So I think we may be prudent and say that if there is an unseen error we
should fail the volatile mount (say ESTALE).

This way userland has the fast path of mounting without syncfs in the
common case and the fallback to slow path:
- syncfs (consume the error)
- unpack layers
- volatile mount

Doesn't this make sense *and* make life simpler?

1. On volatile mount sample sb_err and make sure no unseen error
2. On fsync/syncfs verify no sb_err since mount

Am I missing something?

Thanks,
Amir.
