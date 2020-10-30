Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3062A0B70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgJ3Ql0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 12:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgJ3Ql0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:41:26 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B6620724;
        Fri, 30 Oct 2020 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604076085;
        bh=yDGK3HSIn6gb/VVUQS5nuiDIvM6Z+CXvckaxC2BQVug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvqHZFbdFPQgGVkp6TB84dHb/Yqrz6V82kIm749gIwjEDtgoYqwUhlXZ6ZLV8iVWv
         LpsimexulpWcW9CR5aJ6YNSpUxlD40Sk03En52ysB2sPlR5bWK5SfGh4uRP3A70lBR
         mdRuOMQ5ZaWXlPjaf8Zpx65yor6iGGJ46QeWnrbA=
Received: by pali.im (Postfix)
        id D8D2786D; Fri, 30 Oct 2020 17:41:22 +0100 (CET)
Date:   Fri, 30 Oct 2020 17:41:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com
Subject: Re: [PATCH v11 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20201030164122.vuao3avogggnk42q@pali>
References: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Friday 30 October 2020 18:02:29 Konstantin Komarov wrote:
>  27 files changed, 28364 insertions(+)
>  create mode 100644 Documentation/filesystems/ntfs3.rst
>  create mode 100644 fs/ntfs3/Kconfig
>  create mode 100644 fs/ntfs3/Makefile
>  create mode 100644 fs/ntfs3/attrib.c
>  create mode 100644 fs/ntfs3/attrlist.c
>  create mode 100644 fs/ntfs3/bitfunc.c
>  create mode 100644 fs/ntfs3/bitmap.c
>  create mode 100644 fs/ntfs3/debug.h
>  create mode 100644 fs/ntfs3/dir.c
>  create mode 100644 fs/ntfs3/file.c
>  create mode 100644 fs/ntfs3/frecord.c
>  create mode 100644 fs/ntfs3/fslog.c
>  create mode 100644 fs/ntfs3/fsntfs.c
>  create mode 100644 fs/ntfs3/index.c
>  create mode 100644 fs/ntfs3/inode.c
>  create mode 100644 fs/ntfs3/lznt.c
>  create mode 100644 fs/ntfs3/namei.c
>  create mode 100644 fs/ntfs3/ntfs.h
>  create mode 100644 fs/ntfs3/ntfs_fs.h
>  create mode 100644 fs/ntfs3/record.c
>  create mode 100644 fs/ntfs3/run.c
>  create mode 100644 fs/ntfs3/super.c
>  create mode 100644 fs/ntfs3/upcase.c
>  create mode 100644 fs/ntfs3/xattr.c

I would like to open discussion about two ntfs kernel drivers. Do we
really need two drivers (one read only - current version and one
read/write - this new version)?

What other people think?

I remember that Christoph (added to loop) had in past a good argument
about old staging exfat driver (it had support also for fat32/vfat),
that it would cause problems if two filesystem drivers would provide
support for same filesystem.
