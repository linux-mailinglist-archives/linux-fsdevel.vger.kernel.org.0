Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36263350D55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 05:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhDAD4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 23:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDAD4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:56:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C284C0613E6;
        Wed, 31 Mar 2021 20:56:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z3so804215ioc.8;
        Wed, 31 Mar 2021 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7EDSHuA0GwUlPINZP06/yN+akmMXN7gu9sOlY1lvF0=;
        b=NKcYDCerRdzw/l9o7/rNJp/4d2WriAR/6BnH5GEgw6YbTepXeh0lOIdkPIEdfg7Itv
         nU1+FGa5OYdX5tlSpfybhELXxZJSidEtxSHRF6Ax20o6COw96chkiJ+Tb97fqxY6P486
         YmGG+q+nWY0Jkb9zPGkoq7M6iBBFjifCBDBUhCTIVJxxgFCpjC8tm7XBjE3BbMQVoMuO
         HmoYL+qkJp5/8yWRLs3VtXkCl540aT1daVpUX3gclmNbuBBGf6cXSnbf9rcixtw/5bWs
         I7VnwtnrJdi/4YI4kzhbEge5EB0A+iXaIA1+jRcaDfsUzEOCBjJZmHj+5/jNU0UT4YZy
         K1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7EDSHuA0GwUlPINZP06/yN+akmMXN7gu9sOlY1lvF0=;
        b=GyjNCJFEJ1GqiZ1UWzXOVyg2wBNzcIor2+blLUEq9x9o4MBu/1bSdtXwU+Fs2Dd9/N
         mcFNu14EHJVhAkuPlJJMsfemijXQzTY2yi4rV7+Fm8gNC4W/9pnTdJcgvBdKZ+nRXRDv
         VnkQ5ttUALjcokaCDsFfgYA6OtZXBu5W0ldvbQfWgnhoHPYuGO0KQDCG+ib1P8hhixk+
         P2Zlfb5jFpIH0C5ZXt6FhMxuYZ72cA6dhyGd9a9hnk2aVXnvNCZqVC4aPn41cgBpRh2V
         Fx+AZj4lgN7eRlz4UuFco7p/WYBfUvenR6RbUi5wPTqO/jqeTAftRnPsKKt+2EyKPEMV
         TiZA==
X-Gm-Message-State: AOAM530M68ET4eB5cg8AbDaIG9yDQx6M8qydWK1AbzCW4BmlCleoKn73
        X1fyzpqLKff7PtPW0m0smk/lb+K9z0pIB4Bp7ndD5ctTKPU=
X-Google-Smtp-Source: ABdhPJyqw/7+HmJsaDNB4hU6krH7Mf8COLTt04ZC2Vzk2RMcezRikgLA6WsYa3G5LwbJDBx5alcoPPUPCjUx/c0PouQ=
X-Received: by 2002:a02:a796:: with SMTP id e22mr5938245jaj.93.1617249391764;
 Wed, 31 Mar 2021 20:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Apr 2021 06:56:20 +0300
Message-ID: <CAOQ4uxhPzTK=DvUxTGV0KXnqWNsumjm1UbSiFgXbdogbzyd29w@mail.gmail.com>
Subject: Re: [PATCHSET RFC v3 00/18] xfs: atomic file updates
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 4:14 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Hi all,
>
> This series creates a new FIEXCHANGE_RANGE system call to exchange
> ranges of bytes between two files atomically.  This new functionality
> enables data storage programs to stage and commit file updates such that
> reader programs will see either the old contents or the new contents in
> their entirety, with no chance of torn writes.  A successful call
> completion guarantees that the new contents will be seen even if the
> system fails.
>
> User programs will be able to update files atomically by opening an
> O_TMPFILE, reflinking the source file to it, making whatever updates
> they want to make, and exchange the relevant ranges of the temp file
> with the original file.  If the updates are aligned with the file block
> size, a new (since v2) flag provides for exchanging only the written
> areas.  Callers can arrange for the update to be rejected if the
> original file has been changed.
>
> The intent behind this new userspace functionality is to enable atomic
> rewrites of arbitrary parts of individual files.  For years, application
> programmers wanting to ensure the atomicity of a file update had to
> write the changes to a new file in the same directory, fsync the new
> file, rename the new file on top of the old filename, and then fsync the
> directory.  People get it wrong all the time, and $fs hacks abound.
> Here is the proposed manual page:
>

I like the idea of modernizing FIEXCHANGE_RANGE very much and
I think that the improved implementation and new(?) flags will be very
useful just the way you designed them, but maybe something to consider...

Taking a step back and ignoring the existing xfs ioctl, all the use cases
that you listed actually want MOVE_RANGE not exchange range.
No listed use case does anything with the old data except dump it in the
trash bin. Right?

I do realize that implementing atomic extent exchange was easier back
when that ioctl was implemented for xfs and ext4 and I realize that
deferring inode unlink was much simpler to implement than deferred
extent freeing, but seeing how punch hole and dedupe range already
need to deal with freeing target inode extents, it is not obvious to me that
atomic freeing the target inode extents instead of exchange is a bad idea
(given the appropriate opt-in flags).

Is there a good reason for keeping the "freeing old blocks with unlink"
strategy the only option?

Thanks,
Amir.
