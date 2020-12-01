Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2812CA15A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgLALaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 06:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgLALaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:30:12 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9943C0613CF;
        Tue,  1 Dec 2020 03:29:32 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id z136so1230277iof.3;
        Tue, 01 Dec 2020 03:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0FAKq+IIQm8W2FrWhxqoTDybYcuiTh1HtIoPAph5kY=;
        b=bflk46O3dXcllU4nhRwv7/Jue+8DmW9EVwKFxWR99k5mXkqxKMEEYPBphLYYWw0Cvz
         e+hiIkBUuztDHLrWvOUBSR5PoVbUVQQ8lpBYIrCTpXxzN8QLY7nqCkjLFLuP5EqpFymM
         xa73uZvgh8WNtc8QzndfcCChhPxxGTgxLaGkJ+5GpqOekiiNllRGd3dYgbN/Uxe3KydD
         hMi+k2RRRlhlt/PFMsB68pDvqsfalPVYryyFQBQYp4P2wD9N37na6GhRBgmYgKFSpkfU
         nGdI2ShYIJcCUnk0VNJoNe8tw0DBN4fl71h6BzpTN/AokbVi6yLRnE3GwzIGohcMrRtk
         wRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0FAKq+IIQm8W2FrWhxqoTDybYcuiTh1HtIoPAph5kY=;
        b=TzQyUqaHRwGFkb8HPERQoRFAIXiSFIiGQqb8S+2ZZlzq0iM1S3RUjypeVOTvJLzeJO
         +ml7DOgKbNLpQKDjnDoN69CKaubQ3PWqR2W5O9kAqkV4z61cYF1jCIeUko2tWIl0aSfD
         L5bmNgHvHdLLRfK+u1ImoSvK4WtFqat/I/12uPWRAvJc+HJLvLyBhnVmd0X5LUO6aJuE
         R4m9lF9SCdBTuKGZModAhropc3PkipTjaWB6DSSuNevY/J7n47mveks+jBDu86LTNwkk
         tYVQmdNxMRg0kYaeB3MVrjETCZYjdFWeBbkpz+h7IAIcQ/xJC3Bwr7yV0+RpCd8T9bCT
         pOlg==
X-Gm-Message-State: AOAM530kp6O1ghLwQKEfNBzpVbDcoSVgTDPWjxKnbh2eobgbaumU6ZXi
        lhEmGw8gV8sKuvSdLMwAHRuc66lp3I9zU6PsmBM=
X-Google-Smtp-Source: ABdhPJwyjIBCMOOKWu0QFSN9gpKyfr16ncY6UqgwDwb4+Zu0lzdpvtkiIjXS8/UlnJ/VHtTegWgvHC93lBCEIEGkjJ4=
X-Received: by 2002:a02:8c2:: with SMTP id 185mr2218799jac.120.1606822172093;
 Tue, 01 Dec 2020 03:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-3-sargun@sargun.me>
 <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
 <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal>
 <1338a059d03db0e85cf3f3234fd33434a45606c6.camel@redhat.com>
 <20201128044530.GA28230@ircssh-2.c.rugged-nimbus-611.internal>
 <CAOQ4uxjT6FF03Sq3qXuqDcqJQnzQq2dD_XVbuj_Fb9A2Ag585w@mail.gmail.com>
 <20201128085227.GB28230@ircssh-2.c.rugged-nimbus-611.internal> <20201201110928.GA24837@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201201110928.GA24837@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Dec 2020 13:29:21 +0200
Message-ID: <CAOQ4uxiVLY14=3zDwcRysw69=EN=2vVq5y8JP0Q72Cz95qJ6ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] overlay: Document current outstanding shortcoming
 of volatile
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Jeff Layton <jlayton@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> syncfs seems to enforce the semantics laid out by VFS[1]. Specifically the
> statement:
>   When there is an error during writeback, they expect that error to be reported
>   when a file sync request is made. After an error has been reported on one
>   request, subsequent requests on the same file descriptor should return 0, unless
>   further writeback errors have occurred since the previous file syncronization.
>
> This is enforced by the errseq_check_and_advance logic. We can hack around this
> logic by resetting the errset (setting the error on it) every time we get the
> sync_fs callback, but that to me seems wrong. FWIW, implementing this behaviour
> for fdatasync, and fsync is easier, because the error is bubbled up from the
> filesystem to the VFS. I don't actually think this is a good idea because
> it seems like this sync_fs behaviour is a bit...not neccessarily what all
> filesystems expect. For example, btrfs_sync_fs returns an error if it
> is unable to finish the current transaction. Nowhere in the btrfs code
> does it set the errseq on the superblock if this fails.
>
> I think we have a couple paths forward:
> 1. Change the semantic of sync_fs so the error is always bubbled up if
>    it returns a non-zero value. If we do this, we have to decide whether
>    or not we would _also_ call errseq_check_and_advance on the SB,
>    or leave that to a subsequent call.
> 2. Have overlayfs forcefully set an error on the superblock on every
>    callback to sync_fs. This seems ugly, but I wrote a little patch,
>    and it seems to solve the problem for all the fsync / fdatasync /
>    sync / syncfs variants without having to do plumbing in VFS.
> 3. Choose a different set of semantics for how we want to handle
>    errors in volatile mounts.
>

IMO it is best if you post your patch to fix volatile overlayfs, because
it seems to me that the volatile overlayfs issue is worse than generic
sync_fs issues and it's good if we had a small backportable patch
even if a bit ugly.

Later you can pursue the sync_fs semantic fixes if you wish they
do not contradict the fix in overlayfs, just are just a way to remove
a hack.

Thanks,
Amir.
