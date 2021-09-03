Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33E940076A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbhICV1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhICV1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:27:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895DC061575;
        Fri,  3 Sep 2021 14:26:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k13so895758lfv.2;
        Fri, 03 Sep 2021 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OLsaBzFgvjm17V9pG0gkdCDmdtjBqM923spEyHQ9LIg=;
        b=B4NTlZvxLtB/7WrZJ0PaD5G+O7Lst+0vuSjzCqcII8qdiijT+7mcNypW9u03ir3zu2
         7qIqJRkURqfm5f70AnDhd0iiZx3/p8pkfLwst3xKIL7DNCy+mnRbz91OG7PuFgbBRwip
         aA+f3MXi9D69Yf7U6fA49mj257Yq+GRnOddWRB8WdXvVlria0xpvcWvlIiUdoSwgD51M
         ZVsYzpsirCv187OM5sr1XM7cbJfLUGwwsg0KmWA91c6fJBejudUfTj4HjzaB6kaA2dq9
         +YnIB7jhEIEBuIyRG5exEkgBV6auLQWN6600FKMbqpJrgpNzCEPzSNT1Rb7R42jnhxqY
         jO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OLsaBzFgvjm17V9pG0gkdCDmdtjBqM923spEyHQ9LIg=;
        b=qQoaMj3Ue2NvTEEVkSA+UDC93ZDKlZqzr4PkYJQdT8/AOrNxnA5Wlyx/UzRh1Y1h09
         yYBwEvEfA+gfQUzSW73ry78sEaVEuV1wIgWk/g7afdcvVnH3KntybNhG92rSyBsSIfTu
         e4PiwDq9wydtESY2O1BDS222+i0u0qHjZb9X+xSBcP9fdm3NEUuDYtxo0WVhn+HDxGuo
         xqRqH9DWBI9UuYCVUSMjJF93H2rLM3FrL3jJ/uwCc44rKAlgDjASwYsxiIXLj/0Ft2ro
         BTKKa9nS1GMw0vg89WWRZ3wx6tYWymTcA0NUTfXgukeXJAn7/5uLg1rapXMVIDHqv7hh
         BfBg==
X-Gm-Message-State: AOAM532iE9pZctmCH9PcGbxw4jSAxes7sU1o8tyCa8FtrtZkgw0Bp3AN
        zmfpyd+0x4+CLP0t+erI2Qo=
X-Google-Smtp-Source: ABdhPJzhPmtnN/j2JHYBtpAA4ei9yAMop3b/Z2FXIHoC76feQ8rDQuqouxAy0GlWJz5QhQG+k16Itg==
X-Received: by 2002:a19:c350:: with SMTP id t77mr644526lff.7.1630704379466;
        Fri, 03 Sep 2021 14:26:19 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m17sm33096ljp.80.2021.09.03.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 14:26:19 -0700 (PDT)
Date:   Sat, 4 Sep 2021 00:26:16 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 00/20] fs: Remove usage of broken nls_utf8 and drop it
Message-ID: <20210903212616.xbi5tz5ier5xcpas@kari-VirtualBox>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 08, 2021 at 06:24:33PM +0200, Pali Rohár wrote:
> Module nls_utf8 is broken in several ways. It does not support (full)
> UTF-8, despite its name. It cannot handle 4-byte UTF-8 sequences and
> tolower/toupper table is not implemented at all. Which means that it is
> not suitable for usage in case-insensitive filesystems or UTF-16
> filesystems (because of e.g. missing UTF-16 surrogate pairs processing).
> 
> This is RFC patch series which unify and fix iocharset=utf8 mount
> option in all fs drivers and converts all remaining fs drivers to use
> utf8s_to_utf16s(), utf16s_to_utf8s(), utf8_to_utf32(), utf32_to_utf8
> functions for implementing UTF-8 support instead of nls_utf8.
> 
> So at the end it allows to completely drop this broken nls_utf8 module.

Now that every filesystem will support nls=NULL. Is it possible to just
drop default_table completly? Then default has to be utf8, but is it a
problem?

Then I was also thinking that every nls "codepage module" can have in
Kconfig
	select HAVE_NLS

HAVE_NLS will tell if we can get anything other than nls=NULL. This way
fs can drop some functions if they wanted to.  It would be nice to also
make nls module as small as possible because also acpi, pci and usb
selects it. Also many other driver seems to depend on it and they do not
even seem to select it. All other than filesystems seems to just need
utf conversions. At least for quick eye.  Other option is to seperate
nls and utf, but I'm not fan this idea just yet at least.

Whole point is to help little bit small Linux and embedded devices. I'm
happy to do this, but all really depens on if utf8 can be default and
that we sure can think before hand. 

  Argillander

> For more details look at email thread where was discussed fs unification:
> https://lore.kernel.org/linux-fsdevel/20200102211855.gg62r7jshp742d6i@pali/t/#u
> 
> This patch series is mostly untested and presented as RFC. Please let me
> know what do you think about it and if is the correct way how to fix
> broken UTF-8 support in fs drivers. As explained in above email thread I
> think it does not make sense to try fixing whole NLS framework and it is
> easier to just drop this nls_utf8 module.
> 
> Note: this patch series does not address UTF-8 fat case-sensitivity issue:
> https://lore.kernel.org/linux-fsdevel/20200119221455.bac7dc55g56q2l4r@pali/
> 
> Pali Rohár (20):
>   fat: Fix iocharset=utf8 mount option
>   hfsplus: Add iocharset= mount option as alias for nls=
>   udf: Fix iocharset=utf8 mount option
>   isofs: joliet: Fix iocharset=utf8 mount option
>   ntfs: Undeprecate iocharset= mount option
>   ntfs: Fix error processing when load_nls() fails
>   befs: Fix printing iocharset= mount option
>   befs: Rename enum value Opt_charset to Opt_iocharset to match mount
>     option
>   befs: Fix error processing when load_nls() fails
>   befs: Allow to use native UTF-8 mode
>   hfs: Explicitly set hsb->nls_disk when hsb->nls_io is set
>   hfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
>   hfsplus: Do not use broken utf8 NLS table for iocharset=utf8 mount
>     option
>   jfs: Remove custom iso8859-1 implementation
>   jfs: Fix buffer overflow in jfs_strfromUCS_le() function
>   jfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
>   ntfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
>   cifs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
>   cifs: Remove usage of load_nls_default() calls
>   nls: Drop broken nls_utf8 module
> 
>  fs/befs/linuxvfs.c          |  22 ++++---
>  fs/cifs/cifs_unicode.c      | 128 +++++++++++++++++++++++-------------
>  fs/cifs/cifs_unicode.h      |   2 +-
>  fs/cifs/cifsfs.c            |   2 +
>  fs/cifs/cifssmb.c           |   8 +--
>  fs/cifs/connect.c           |   8 ++-
>  fs/cifs/dfs_cache.c         |  24 +++----
>  fs/cifs/dir.c               |  28 ++++++--
>  fs/cifs/smb2pdu.c           |  17 ++---
>  fs/cifs/winucase.c          |  14 ++--
>  fs/fat/Kconfig              |  15 -----
>  fs/fat/dir.c                |  17 ++---
>  fs/fat/fat.h                |  22 +++++++
>  fs/fat/inode.c              |  28 ++++----
>  fs/fat/namei_vfat.c         |  26 ++++++--
>  fs/hfs/super.c              |  62 ++++++++++++++---
>  fs/hfs/trans.c              |  62 +++++++++--------
>  fs/hfsplus/dir.c            |   6 +-
>  fs/hfsplus/options.c        |  39 ++++++-----
>  fs/hfsplus/super.c          |   7 +-
>  fs/hfsplus/unicode.c        |  31 ++++++++-
>  fs/hfsplus/xattr.c          |  14 ++--
>  fs/hfsplus/xattr_security.c |   3 +-
>  fs/isofs/inode.c            |  27 ++++----
>  fs/isofs/isofs.h            |   1 -
>  fs/isofs/joliet.c           |   4 +-
>  fs/jfs/jfs_dtree.c          |  13 +++-
>  fs/jfs/jfs_unicode.c        |  35 +++++-----
>  fs/jfs/jfs_unicode.h        |   2 +-
>  fs/jfs/super.c              |  29 ++++++--
>  fs/nls/Kconfig              |   9 ---
>  fs/nls/Makefile             |   1 -
>  fs/nls/nls_utf8.c           |  67 -------------------
>  fs/ntfs/dir.c               |   6 +-
>  fs/ntfs/inode.c             |   5 +-
>  fs/ntfs/super.c             |  60 ++++++++---------
>  fs/ntfs/unistr.c            |  28 +++++++-
>  fs/udf/super.c              |  50 ++++++--------
>  fs/udf/udf_sb.h             |   2 -
>  fs/udf/unicode.c            |   4 +-
>  40 files changed, 510 insertions(+), 418 deletions(-)
>  delete mode 100644 fs/nls/nls_utf8.c
> 
> -- 
> 2.20.1
> 
