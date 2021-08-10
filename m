Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3288E3E54FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhHJIUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 04:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhHJIUU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:20:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0703B60FD8;
        Tue, 10 Aug 2021 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628583598;
        bh=PJDJ6GCZzc0E0w7Naf8M+hrNPtronJmpF/C1OGxHItg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sercihlmX75ZdaIziA1OAVZE1A9UxhSDXt0z7cTiHimPjJRnvLvlBxQ7rpcDeJpXA
         RXbQAbgq04P8L36uY5rwwk0yJzpjisrIpiPADx7pVBBWB9ofeeJpTbZbJMANkOU4rS
         QnuYW/+vH+HIDiUdqM9zk3sEjYJIYgFqskiTRWakDG26f7V2zxH+oq2TNVi0er1Eyw
         NJD0RNzbeWvQib6P7b3+i6pD1x3a9rEH3j9VLXds4p2nRS8jwUy4Yu+64pHWFa9MbX
         JF0eh5UUeW4Lms5CDB0hOf7/2ZFOWvMPxfef3OpEhlQXqxr2D+cnFBMG0txscIHUgX
         tWY9sK3kvEfKg==
Received: by pali.im (Postfix)
        id 654B482D; Tue, 10 Aug 2021 10:19:55 +0200 (CEST)
Date:   Tue, 10 Aug 2021 10:19:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20210810081955.b5vdsfc2tdaabbgo@pali>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-9-almaz.alexandrovich@paragon-software.com>
 <20210810074740.mkjcow2inyjaakch@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810074740.mkjcow2inyjaakch@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 10 August 2021 10:47:40 Kari Argillander wrote:
> On Thu, Jul 29, 2021 at 04:49:41PM +0300, Konstantin Komarov wrote:
> > This adds Kconfig, Makefile and doc
> > 
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > ---
> >  Documentation/filesystems/ntfs3.rst | 107 ++++++++++++++++++++++++++++
> 
> Still missing Documentation/filesystems/index.rst as I stated before
> https://lore.kernel.org/linux-fsdevel/20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox/
> 
> >  fs/ntfs3/Kconfig                    |  46 ++++++++++++
> >  fs/ntfs3/Makefile                   |  36 ++++++++++
> >  3 files changed, 189 insertions(+)
> >  create mode 100644 Documentation/filesystems/ntfs3.rst
> >  create mode 100644 fs/ntfs3/Kconfig
> >  create mode 100644 fs/ntfs3/Makefile
> > 
> > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> 
> 
> > +Mount Options
> > +=============
> > +
> > +The list below describes mount options supported by NTFS3 driver in addition to
> > +generic ones.
> > +
> > +===============================================================================
> > +
> > +nls=name		This option informs the driver how to interpret path
> > +			strings and translate them to Unicode and back. If
> > +			this option is not set, the default codepage will be
> > +			used (CONFIG_NLS_DEFAULT).
> > +			Examples:
> > +				'nls=utf8'
> 
> It seems that kernel community will start use iocharset= as default. nls
> option can still be alias but will need deprecated message. See message
> https://lore.kernel.org/linux-fsdevel/20200102211855.gg62r7jshp742d6i@pali/
> 
> and current work from Pali
> https://lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/
> 
> This is still RFC state so probably no horry, but good to know stuff. I
> also added Pali so he also knows.

I was already in loop :-)

Anyway, yes, above RFC patch migrates all drivers to use iocharset=
mount option as it is the option which is already used by most fs
drivers. So argument is consistency.

But having the preferred mount option name in new fs drivers would
decrease work needed to done in that patch series.

> > diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
> > new file mode 100644
> > index 000000000..279701b62
> > --- /dev/null
> > +++ b/fs/ntfs3/Makefile
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the ntfs3 filesystem support.
> > +#
> > +
> > +# to check robot warnings
> > +ccflags-y += -Wint-to-pointer-cast \
> > +	$(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
> > +	$(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)
> 
> It is good idea to include this url in commit message.
> https://lore.kernel.org/linux-fsdevel/212218590.13874.1621431781547@office.mailbox.org/
> 
> And also add that signed off tag from Tor Vic.
> 
> > +
> > +obj-$(CONFIG_NTFS3_FS) += ntfs3.o
> > +
> > +ntfs3-y :=	attrib.o \
> > +		attrlist.o \
> > +		bitfunc.o \
> > +		bitmap.o \
> > +		dir.o \
> > +		fsntfs.o \
> > +		frecord.o \
> > +		file.o \
> > +		fslog.o \
> > +		inode.o \
> > +		index.o \
> > +		lznt.o \
> > +		namei.o \
> > +		record.o \
> > +		run.o \
> > +		super.o \
> > +		upcase.o \
> > +		xattr.o
> > +
> > +ntfs3-$(CONFIG_NTFS3_LZX_XPRESS) += $(addprefix lib/,\
> > +		decompress_common.o \
> > +		lzx_decompress.o \
> > +		xpress_decompress.o \
> > +		)
> > \ No newline at end of file
> > -- 
> > 2.25.4
> > 
