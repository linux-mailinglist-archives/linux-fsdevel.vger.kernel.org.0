Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CF56CE74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jul 2022 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJJ5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJJ53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:57:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B410544;
        Sun, 10 Jul 2022 02:57:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v12so3145207edc.10;
        Sun, 10 Jul 2022 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zGY4kgOqFCDmXLRHsh0LG2vDnIGDCuRQpfcwHB3KcWU=;
        b=q6YGZXsiC7lRySvNR9x7EICYmgXyoe8znrqSso5dmz3hPzbBQd+AcyyWm8ByP2puRs
         vcfiNh58zgu8Z8mxVdFMMIgtshr/QSrKsrnb6Jf/+d5wbyfOfuNvsj9N/6zd9KofPxS7
         4V04r6mqgxZ1QpodbQoRZJTep60s+mhngK7ZN90PtYMZWE44ufuRskZCgpBqvxFixgMU
         XTR9q3gSz7WL/8Rcz3+Dkgi4Bbe2qnCOsYDtvzWk53QWdYVDKvf/DEQIEhUZEDoG5vWP
         7GfJ9eQq5QjMUYFakDYHcNod3mRUxwcfvK+hxFnyNjCSmn8QSPUs98dcJXXx+YOMxvm6
         WemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zGY4kgOqFCDmXLRHsh0LG2vDnIGDCuRQpfcwHB3KcWU=;
        b=EystYOn+gfBa3bBEt2JmiYIPIorr3RpumTZChs2kpLo57JRPKBad604ANri/EJKSha
         Wrf6u6hhJ0l4hOKB2EeLoRFJXh984LbsjT6du3rIsu2hKmN4gcxqQImIzXTix/JvBW4S
         AxZVdlohfnj5kzjXfUAUE5Zxr3gscmDQe02Oy+Wo8IOnH14WqJlWwGAldrsOuCrHT8dj
         8/1h2HhuPd0p8WRO0id9NqrZsqACxHW0LzWiAHa924RGNQZueP1b6ZnGfqhc6cbEI08z
         qmIcoxuE5gE4giI4aiLGvjmWAS7xxDxUvNuHZf0sAJooHuVRKPegXo56qGjeD07HGsYB
         pHZA==
X-Gm-Message-State: AJIora/M/b3WR2t+4fcTWEYP37jffQicmIp1T/75Oh37iRe41zzkSNXH
        rjUnfzymqOMXSy+xNNN+VS9tgQsfEAk=
X-Google-Smtp-Source: AGRyM1sap0lzmD9khzBA+L/RBTXnOVPipjkOYrYQ1IAVhsT58ZpYVKd+Dibp6xXLWWpCwOkVDqB8mQ==
X-Received: by 2002:a05:6402:40cb:b0:43a:8a99:225f with SMTP id z11-20020a05640240cb00b0043a8a99225fmr17281136edb.414.1657447046824;
        Sun, 10 Jul 2022 02:57:26 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7d484000000b0043a46f5fb82sm2453873edr.73.2022.07.10.02.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:57:26 -0700 (PDT)
Date:   Sun, 10 Jul 2022 11:57:24 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH 0/2] landlock: truncate(2) support
Message-ID: <YsqihF0387fBeiVa@nuc>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Mickaël!

Thank you for the fast feedback! I'm looking into your comments from
this mail and the rest of the thread and am working on an updated
patch set.

On Fri, Jul 08, 2022 at 01:16:29PM +0200, Mickaël Salaün wrote:
> Hi Günther, this looks good!
>
> Added linux-fsdevel@vger.kernel.org
>
> On 07/07/2022 22:06, Günther Noack wrote:
> > The goal of these patches is to work towards a more complete coverage
> > of file system operations that are restrictable with Landlock.
> >
> > The known set of currently unsupported file system operations in
> > Landlock is described at [1]. Out of the operations listed there,
> > truncate is the only one that modifies file contents, so these patches
> > should make it possible to prevent the direct modification of file
> > contents with Landlock.
> >
> > The patch introduces the truncate(2) restriction feature as an
> > additional bit in the access_mask_t bitmap, in line with the existing
> > supported operations.
> >
> > Apart from Landlock, the truncate(2) and ftruncate(2) family of system
> > calls can also be restricted using seccomp-bpf, but it is a
> > complicated mechanism (requires BPF, requires keeping up-to-date
> > syscall lists) and it also is not configurable by file hierarchy, as
> > Landlock is. The simplicity and flexibility of the Landlock approach
> > makes it worthwhile adding.
> >
> > I am aware that the documentation and samples/landlock/sandboxer.c
> > tool still need corresponding updates; I'm hoping to get some early
> > feedback this way.
> Yes, that's a good approach.
>
> Extending the sandboxer should be straightforward, you can just extend the
> scope of LL_FS_RW, taking into account the system Landlock ABI because there
> is no "contract" for this sample.

Sounds good, I'll extend the sample tool like this for the updated patch set.

(On the side, as you know from the discussion on the go-landlock
library, I have some suspicion that the "best effort"
backwards-compatibility approach in the sample tool is not the right
one for the "refer" right, but that might be better suited for a
separate patch. Maybe it'll be simpler to just not support a
best-effort downgrade in the sample tool.)

> You'll need to remove the warning about truncate(2) in the documentation,
> and maybe to move it to the "previous limitations" section, with the
> LANDLOCK_ACCESS_TRUNCATE doc pointing to it. I think it would be nice to
> extend the LANDLOCK_ACCESS_FS_WRITE documentation to point to
> LANDLOCK_ACCESS_FS_TRUNCATE because this distinction could be disturbing for
> users. Indeed, all inode-based LSMs (SELinux and Smack) deny such action if
> the inode is not writable (with the inode_permission check), which is not
> the case for path-based LSMs (AppArmor and Tomoyo).

This makes a lot of sense, I'll work on the documentation to point this out.

I suspect that for many common use cases, the
LANDLOCK_ACCESS_FS_TRUNCATE right will anyway only be used together
with LANDLOCK_ACCESS_FS_FILE_WRITE in practice. (See below for more
detail.)

> While we may question whether a dedicated access right should be added for
> the Landlock use case, two arguments are in favor of this approach:
> - For compatibility reasons, the kernel must follow the semantic of a
> specific Landlock ABI, otherwise it could break user space. We could still
> backport this patch and merge it with the ABI 1 and treat it as a bug, but
> the initial version of Landlock was meant to be an MVP, hence this lack of
> access right.
> - There is a specific access right for Capsicum (CAP_FTRUNCATE) that could
> makes more sense in the future.
>
> Following the Capsicum semantic, I think it would be a good idea to also
> check for the O_TRUNC open flag:
> https://www.freebsd.org/cgi/man.cgi?query=rights

open() with O_TRUNC was indeed a case I had not thought about - thanks
for pointing it out.

I started adding some tests for it, and found to my surprise that
open() *is* already checking security_path_truncate() when it is
truncating files. So there is a chance that we can get away without a
special check for O_TRUNC in the security_file_open hook.

The exact semantics might be slightly different to Capsicum though -
in particular, the creat() call (= open with O_TRUNC|O_CREAT|O_WRONLY)
will require the Landlock truncate right when it's overwriting an
existing regular file, but it will not require the Landlock truncate
right when it's creating a new file.

I'm not fully sure how this is done in Capsicum. I assume that the
Comparison with Capsicum is mostly for inspiration, but there is no
goal of being fully compatible with that model?

The creat() behaviour is non-intuitive from userspace, I think:
creat() is a pretty common way to create new files, and it might come
as a surprise to people that this can require the truncate right,
because:

- The function creat() doesn't have "truncate" in its name, and you
  might be tempted to think that the LANDLOCK_ACCESS_FS_MAKE_REG is
  sufficient for calling it.

- Users can work around the need for the truncate right by unlinking
  the existing regular file with the same name and creating a new one.
  So for the most common use case (where users do not care about the
  file's inode identity or race conditions), it is surprising that
  the truncate right is required.

Summarizing this, I also think that the truncate right needs to be a
separate flag, even if just for backwards compatibility reasons.

But at the same time, I suspect that in practice, the truncate right
will probably have to usually go together with the file_write right,
so that the very common creat() use case (and possibly others) does
not yield surprising behaviour.

—Günther

>
>
> >
> > These patches are based on version 5.19-rc5.
> > The patch set can also be browsed on the web at [2].
> >
> > Best regards,
> > Günther
> >
> > [1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
> > [2] https://github.com/gnoack/linux/tree/landlock-truncate
> >
> > Günther Noack (2):
> >    landlock: Support truncate(2).
> >    landlock: Selftests for truncate(2) support.
> >
> >   include/uapi/linux/landlock.h                |  2 +
> >   security/landlock/fs.c                       |  9 +-
> >   security/landlock/limits.h                   |  2 +-
> >   security/landlock/syscalls.c                 |  2 +-
> >   tools/testing/selftests/landlock/base_test.c |  2 +-
> >   tools/testing/selftests/landlock/fs_test.c   | 87 +++++++++++++++++++-
> >   6 files changed, 97 insertions(+), 7 deletions(-)
> >
> > --
> > 2.37.0

--
