Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B311A63DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgDMHyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:54:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9AEC008651;
        Mon, 13 Apr 2020 00:54:48 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n10so8549276iom.3;
        Mon, 13 Apr 2020 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fxdds2vPGS3N/102R6ExV/SBHS+w/11kI+QRFuDnruo=;
        b=LdKv4BhmbHJcCbUnqYd7/INd7IRPACwNoGsA+AW7nLT9uuV9rGvs/8favMyv1eZwZZ
         Wyw02zFL0pMC6j02qV9kT8QSNqmPtZ10h7PFXbT5HN15zveOABgeIRuO25KBGTEdiAT1
         x+fL0JFJrzeYbeZskSJBRrxUz3qFqTNh86hPJVMHDz5cFc/H0OUTRTSN1i00o0YbK5wg
         XpCljmKRIw2wEprR1kjab0mzXG0jJFavEUlRlUG4TUbxOD+R8DiHgf30ZT34el3EHw2k
         WezgSHoiZfzKq6GQ3QX2pLsJDeZo5ptLjwoLtpAqUVAQyp/ljQwCsFR9EJAXAOz02qpj
         AEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fxdds2vPGS3N/102R6ExV/SBHS+w/11kI+QRFuDnruo=;
        b=mbber3RmO5vEhbxW1IBgM9Jl5yljeevnkMJFINzNL2XETtYiF3Ta9oUBu70I1whvAy
         OstmP4E7+LWiJ4Z6o2bgOqhoiCii26I+PxjLZ0o/2gDIPWSL8xesTxmZxPTFTerAt5ws
         qUzeY9mahyXCWod6UblpXXLKQhl24oL+QYEqVlKRW58hNIonbVkFI9KQ2cn0N4B/q8um
         mbV9lONA8PksUgPR0sB4rU2C+Ff2jzsfYyJbJGEdihSGGBoGV1w331+Klz64l3AuhvvJ
         3kaT4JTp2FNtwv7Pno+ya1FlbntLgo2/Z/58uC5KeM77+5gZIE3yPYwYKxeq7WJGxXEc
         qH+g==
X-Gm-Message-State: AGi0PuaGv8VKBDV3LNBHF9VSVWIEorJu6QTCGH9stP8Oxdz+iYm1/qz4
        H9JPPRniiWrCUb9wBLcaYuQBzbrJeEO5wk+pPt8=
X-Google-Smtp-Source: APiQypL5Eljk4TK/mwa+XDxgwgpIUGCujDIQ8sy3Yf0VdZARHKdYNLMpnF8pB675OD/IHE0afd4q+knrLM59ckuUgB0=
X-Received: by 2002:a05:6602:1302:: with SMTP id h2mr15261121iov.186.1586764487632;
 Mon, 13 Apr 2020 00:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200413054419.1560503-1-ira.weiny@intel.com>
In-Reply-To: <20200413054419.1560503-1-ira.weiny@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Apr 2020 10:54:36 +0300
Message-ID: <CAOQ4uxguVRysAuVEtQmPj+x=RDtDnGCtNeGvbvXNuvppwagwDg@mail.gmail.com>
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
To:     ira.weiny@intel.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 9:06 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Add XXX to test per file DAX operations.

Please change commit title to "xfs: Add test for per file DAX operations"
The title Add xfs/XXX is not useful even if XXX where a number.

But the kernel patch suggests that there is an intention to make
this behavior also applicable to ext4??
If that is the case I would recommend making this a generic tests
which requires filesystem support for -o dax=XXX

>
> The following is tested[*]
>
>  1. There exists an in-kernel access mode flag S_DAX that is set when
>     file accesses go directly to persistent memory, bypassing the page
>     cache.  Applications must call statx to discover the current S_DAX
>     state (STATX_ATTR_DAX).
>
>  2. There exists an advisory file inode flag FS_XFLAG_DAX that is
>     inherited from the parent directory FS_XFLAG_DAX inode flag at file
>     creation time.  This advisory flag can be set or cleared at any
>     time, but doing so does not immediately affect the S_DAX state.
>
>     Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
>     and the fs is on pmem then it will enable S_DAX at inode load time;
>     if FS_XFLAG_DAX is not set, it will not enable S_DAX.
>
>  3. There exists a dax= mount option.
>
>     "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
>
>     "-o dax=always" means "always set S_DAX (at least on pmem),
>                     and ignore FS_XFLAG_DAX."
>
>     "-o dax"        is an alias for "dax=always".
>
>     "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
>
>  4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
>     be set or cleared at any time.  The flag state is copied into any
>     files or subdirectories when they are created within that directory.
>
>  5. Programs that require a specific file access mode (DAX or not DAX)
>     can do one of the following:
>
>     (a) Create files in directories that the FS_XFLAG_DAX flag set as
>         needed; or
>
>     (b) Have the administrator set an override via mount option; or
>
>     (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
>         must then cause the kernel to evict the inode from memory.  This
>         can be done by:
>
>         i>  Closing the file and re-opening the file and using statx to
>             see if the fs has changed the S_DAX flag; and
>
>         ii> If the file still does not have the desired S_DAX access
>             mode, either unmount and remount the filesystem, or close
>             the file and use drop_caches.
>
>  6. It's not unreasonable that users who want to squeeze every last bit
>     of performance out of the particular rough and tumble bits of their
>     storage also be exposed to the difficulties of what happens when the
>     operating system can't totally virtualize those hardware
>     capabilities.  Your high performance sports car is not a Toyota
>     minivan, as it were.
>
> [*] https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes from v6 (kernel patch set):
>         Start versions tracking the kernel patch set.
>         Update for new requirements
>
> Changes from V1 (xfstests patch):
>         Add test to ensure moved files preserve their flag
>         Check chattr of non-dax flags (check bug found by Darrick)
> ---
...
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -511,3 +511,4 @@
>  511 auto quick quota
>  512 auto quick acl attr
>  513 auto mount
> +999 auto

The test looks also 'quick'

Thanks,
Amir.
