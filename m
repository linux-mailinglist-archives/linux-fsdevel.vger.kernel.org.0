Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED316197B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgBQSLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:11:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54447 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgBQSLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:11:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73ED15DB6A;
        Mon, 17 Feb 2020 13:11:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=Gls5yVlIPXoemlcn4YXzjgF9Xr4=; b=TG79T8
        3FbsjkBKESEcHAXz5uPEeCeY/KejcslcqdSHWJ5u1wa10tTQR3+FkSUVc8Wp0EjX
        t57tJt64hQImLFtPFs/3ZQBLfq4FSYrF8Us58RA58+8jBHH28FN1VW/FNXe8bSS1
        nuO16y8ajPx3uEDrDH6kHW7HWP7juoAvl03ps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E9B25DB69;
        Mon, 17 Feb 2020 13:11:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=iyn9UhINCd5hDDfrjRg1PJ2j7YzorLyUaLg7k1+K+d0=; b=t3nXETdjohRCFzFiurIjePK5uG1QJGEk5hhjr8L20+8d2pmH/Nf1CXIM6p7QAzf36eGAWQ86R02OFdiugmLPDn+feCtAD9PTicWRFp7Bupj0nZxoX2368tK7jXY4K6YiwEvW4fFmHQRc3H29/0njPRw0HIkZVT7q8/CdWf1Nr/M=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAE565DB68;
        Mon, 17 Feb 2020 13:11:26 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id EFAD62DA01B8;
        Mon, 17 Feb 2020 13:11:25 -0500 (EST)
Date:   Mon, 17 Feb 2020 13:11:25 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/44] docs: filesystems: convert cramfs.txt to ReST
In-Reply-To: <e87b267e71f99974b7bb3fc0a4a08454ff58165e.1581955849.git.mchehab+huawei@kernel.org>
Message-ID: <nycvar.YSQ.7.76.2002171310460.1559@knanqh.ubzr>
References: <cover.1581955849.git.mchehab+huawei@kernel.org> <e87b267e71f99974b7bb3fc0a4a08454ff58165e.1581955849.git.mchehab+huawei@kernel.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: E9DC501E-51B0-11EA-B5D4-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Feb 2020, Mauro Carvalho Chehab wrote:

> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add table markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  .../filesystems/{cramfs.txt => cramfs.rst}    | 19 ++++++++++++-------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 13 insertions(+), 7 deletions(-)
>  rename Documentation/filesystems/{cramfs.txt => cramfs.rst} (88%)
> 
> diff --git a/Documentation/filesystems/cramfs.txt b/Documentation/filesystems/cramfs.rst
> similarity index 88%
> rename from Documentation/filesystems/cramfs.txt
> rename to Documentation/filesystems/cramfs.rst
> index 8e19a53d648b..afbdbde98bd2 100644
> --- a/Documentation/filesystems/cramfs.txt
> +++ b/Documentation/filesystems/cramfs.rst
> @@ -1,12 +1,15 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  
> -	Cramfs - cram a filesystem onto a small ROM
> +===========================================
> +Cramfs - cram a filesystem onto a small ROM
> +===========================================
>  
> -cramfs is designed to be simple and small, and to compress things well. 
> +cramfs is designed to be simple and small, and to compress things well.
>  
>  It uses the zlib routines to compress a file one page at a time, and
>  allows random page access.  The meta-data is not compressed, but is
>  expressed in a very terse representation to make it use much less
> -diskspace than traditional filesystems. 
> +diskspace than traditional filesystems.
>  
>  You can't write to a cramfs filesystem (making it compressible and
>  compact also makes it _very_ hard to update on-the-fly), so you have to
> @@ -28,9 +31,9 @@ issue.
>  Hard links are supported, but hard linked files
>  will still have a link count of 1 in the cramfs image.
>  
> -Cramfs directories have no `.' or `..' entries.  Directories (like
> +Cramfs directories have no ``.`` or ``..`` entries.  Directories (like
>  every other file on cramfs) always have a link count of 1.  (There's
> -no need to use -noleaf in `find', btw.)
> +no need to use -noleaf in ``find``, btw.)
>  
>  No timestamps are stored in a cramfs, so these default to the epoch
>  (1970 GMT).  Recently-accessed files may have updated timestamps, but
> @@ -70,9 +73,9 @@ MTD drivers are cfi_cmdset_0001 (Intel/Sharp CFI flash) or physmap
>  (Flash device in physical memory map). MTD partitions based on such devices
>  are fine too. Then that device should be specified with the "mtd:" prefix
>  as the mount device argument. For example, to mount the MTD device named
> -"fs_partition" on the /mnt directory:
> +"fs_partition" on the /mnt directory::
>  
> -$ mount -t cramfs mtd:fs_partition /mnt
> +    $ mount -t cramfs mtd:fs_partition /mnt
>  
>  To boot a kernel with this as root filesystem, suffice to specify
>  something like "root=mtd:fs_partition" on the kernel command line.
> @@ -90,6 +93,7 @@ https://github.com/npitre/cramfs-tools
>  For /usr/share/magic
>  --------------------
>  
> +=====	=======================	=======================
>  0	ulelong	0x28cd3d45	Linux cramfs offset 0
>  >4	ulelong	x		size %d
>  >8	ulelong	x		flags 0x%x
> @@ -110,6 +114,7 @@ For /usr/share/magic
>  >552	ulelong	x		fsid.blocks %d
>  >556	ulelong	x		fsid.files %d
>  >560	string	>\0		name "%.16s"
> +=====	=======================	=======================
>  
>  
>  Hacker Notes
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index ddd8f7b2bb25..8fe848ea04af 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -56,6 +56,7 @@ Documentation for filesystem implementations.
>     bfs
>     btrfs
>     ceph
> +   cramfs
>     fuse
>     overlayfs
>     virtiofs
> -- 
> 2.24.1
> 
> 
