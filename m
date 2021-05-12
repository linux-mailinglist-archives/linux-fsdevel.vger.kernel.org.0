Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8737EBE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378262AbhELTjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 15:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381358AbhELTd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 15:33:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA230C061761;
        Wed, 12 May 2021 12:28:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b7so31049933ljr.4;
        Wed, 12 May 2021 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWP0l+BA0fGfCW3697UumhoAM6OZCftdKGj+XYdvmfw=;
        b=jau0A7xhAKhNGGJJ6FHnLqlBanUYsG4/Xgrwbeb7LF93cOfKc6gIGxtrG8L93G9h3f
         xdF/N+vTKym3eL4xJZqCUekg/qtC81Tq82Zcm246zcaw/353BgLe5X/qAD1uuA3b7IrD
         IcLGS5RDD44EnpQsLv65nnaiiB1xaG6CQkmXTC6jJ8DQg1bfNnE2GjMLcvjkSUXU7Tkg
         VlUIFCMH5svj1mEyjnxNd9qWES0Tnnq5+U/U/S+OEysNGMpsy8uJ6NIWTsIkPoqLPtBT
         qql0mtiN6aCZ2BkloTkbsla9sXJUTaekCXW9MzOQpPjLTQyxx9BNIhPPy7Ohsa/OrMQh
         GXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWP0l+BA0fGfCW3697UumhoAM6OZCftdKGj+XYdvmfw=;
        b=JQJIfBNcMdlF0YsN79upGcfc/jdVqcCXBSfVgqj7yRX4uGE9yv+qHeNIKtnfrdbWPx
         4wiL15v9t5Zj7BYNEATLzmsbcBUVDabeItMcopFXRO2CnYahtNAbhuhJbEhyGJ3WMNwU
         eHgV7n0Y7QXfr3mjhPKVnJxM/CQ3LFsutbHvVtynnNVwwjP1BLCPJ6ADGETSr+pdLx49
         +y+lHXCHdtkJKiSrYHCv9L4fl7dKqRXSyGPtsb/IRLRfds5cpCHopzOXWAzd2EDzD2o5
         jkPXwnFm0P7Hd+QmY4YmngUdw0zRJ4J0m0ZjCpdMsfGcsI7NkINMDc4vap7a/s3VWIrF
         uKGA==
X-Gm-Message-State: AOAM532OOQ2qkPQ72gO3JSxzVf+XWhiQwGn1UhUTQOLNWxPYZAt/tUWd
        xunkPDWwrYLOeaNRNYcUrF0gqqxUDojRsrtQGV4=
X-Google-Smtp-Source: ABdhPJybjV1UrN30hcZfWkxdJZJglKnFZJNX4SuGmgPSoe/Xw3yeEITbPhCey3BqWWyluYg0SRnoz0qVGrEzJuI95zI=
X-Received: by 2002:a2e:7819:: with SMTP id t25mr9229961ljc.406.1620847732192;
 Wed, 12 May 2021 12:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <YJvwVq3Gl35RQrIe@casper.infradead.org>
In-Reply-To: <YJvwVq3Gl35RQrIe@casper.infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 12 May 2021 14:28:41 -0500
Message-ID: <CAH2r5msOQsdeknBdTsfMXYzrb5=NuKEBPc4WD1CkYp10t19Guw@mail.gmail.com>
Subject: Re: Removing readpages aop
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't have any objections as long as:
- we see at least mild performance benefit (or at least we are
confident that no performance loss)
- it passes regression tests (the usual xfstest bucket)
- it doesn't complicate the code too much (sounds like it actually
might simplify it, but needs a little more work)
- make sure that the usual tuning parms still work (e.g. "rsize" and
"rasize" mount options) or we can figure out a sane way to autotune
readhead so those wouldn't be needed for any workload

But currently since we get the most benefit from multichannel (as that
allows even better parallelization of i/o) ... I have been focused on
various multichannel issues (low credit situations, reconnect, fall
back to different channels when weird errors, adjusting channels
dynamically when server adds or removes adapters on the fly) for the
short term

On Wed, May 12, 2021 at 10:31 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> In Linus' current tree, there are just three filesystems left using the
> readpages address_space_operation:
>
> $ git grep '\.readpages'
> fs/9p/vfs_addr.c:       .readpages = v9fs_vfs_readpages,
> fs/cifs/file.c: .readpages = cifs_readpages,
> fs/nfs/file.c:  .readpages = nfs_readpages,
>
> I'd love to finish getting rid of ->readpages as it would simplify
> the VFS.  AFS and Ceph were both converted since 5.12 to use
> netfs_readahead().  Is there any chance we might get the remaining three
> filesystems converted in the next merge window?
>


-- 
Thanks,

Steve
