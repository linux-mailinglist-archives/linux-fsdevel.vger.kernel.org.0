Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6824124DDD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 19:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgHURXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgHURXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:23:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E14C061573;
        Fri, 21 Aug 2020 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bAt7ua5tnS/ugttXa8syUdUtImCbHpozqT/YgY2E6VQ=; b=HC8fJQDjtjQ3Dn0KB/nl8zm9G5
        OLgrSW3g6OaQ9uai7u+zZmZJfqgSnYnOR2POzC4borlXdhU4uanc69FkLkcMK01ljOM4VsD9evszx
        b8TgshtNVP+0p7U0OyVHyP7m8tgw5IcHbfs4er/rdYYg4vrq3cZK2Hmu4MK8GmJvuzN7HBP3444S+
        udMNGiSWaZyZAoH2u3M0lxijNC51owYxV13GfERmGF6W220M7G7CrwFan+/tYueVE8OuVXhhSnqaS
        BklX4calxAGYqosbBsaY8kFvqDv2dFGwb2QF/h8qja0iAa8pIPv3X7o/G6VbIE2YJgAnMwet+E/U0
        2PuvU1Vw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9Al3-0004jP-5u; Fri, 21 Aug 2020 17:23:17 +0000
Subject: Re: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63ae69b5-ee05-053d-feb6-6c9b5ed04499@infradead.org>
Date:   Fri, 21 Aug 2020 10:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 9:25 AM, Konstantin Komarov wrote:
> This adds fs/ntfs3 Kconfig, Makefile and Documentation file
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  Documentation/filesystems/ntfs3.rst | 93 +++++++++++++++++++++++++++++
>  fs/ntfs3/Kconfig                    | 23 +++++++
>  fs/ntfs3/Makefile                   | 11 ++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 Documentation/filesystems/ntfs3.rst
>  create mode 100644 fs/ntfs3/Kconfig
>  create mode 100644 fs/ntfs3/Makefile
> 
> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> new file mode 100644
> index 000000000000..4a510a6cdaee
> --- /dev/null
> +++ b/Documentation/filesystems/ntfs3.rst
> @@ -0,0 +1,93 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====
> +NTFS3
> +=====
> +
> +
> +Summary and Features
> +====================
> +
> +NTFS3 is fully functional NTFS Read-Write driver. The driver works with
> +NTFS versions up to 3.1, normal/compressed/sparse files
> +and journal replaying. File system type to use on mount is 'ntfs3'.
> +
> +- This driver implements NTFS read/write support for normal, sparsed and

                                                                sparse

> +  compressed files.
> +  NOTE: Operations with compressed files require increased memory consumption;
> +- Supports native journal replaying;
> +- Supports extended attributes;
> +- Supports NFS export of mounted NTFS volumes.
> +
> +Mount Options
> +=============
> +
> +The list below describes mount options supported by NTFS3 driver in addtion to

                                                                       addition

> +generic ones.
> +
> +===============================================================================
> +
> +nls=name		These options inform the driver how to interpret path
> +			strings and translate them to Unicode and back. In case
> +			none of these options are set, or if specified codepage
> +			doesn't exist on the system, the default codepage will be
> +			used (CONFIG_NLS_DEFAULT).
> +			Examples:
> +				'nls=utf8'
> +
> +uid=
> +gid=
> +umask=			Controls the default permissions for files/directories created
> +			after the NTFS volume is mounted.
> +
> +fmask=
> +dmask=			Instead of specifying umask which applies both to
> +			files and directories, fmask applies only to files and
> +			dmask only to directories.
> +
> +nohidden		Files with the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDEN)
> +			attribute will not be shown under Linux.

Without this mount option, will HIDDEN files be shown by default?

> +
> +sys_immutable		Files with the Windows-specific SYSTEM
> +			(FILE_ATTRIBUTE_SYSTEM) attribute will be marked as system
> +			immutable files.
> +
> +discard			Enable support of the TRIM command for improved performance
> +			on delete operations, which is recommended for use with the
> +			solid-state drives (SSD).
> +
> +force			Forces the driver to mount partitions even if 'dirty' flag
> +			(volume dirty) is set. Not recommended for use.
> +
> +sparse			Create new files as "sparse".
> +
> +showmeta		Use this parameter to show all meta-files (System Files) on
> +			a mounted NTFS partition.
> +			By default, all meta-files are hidden.
> +
> +no_acs_rules		"No access rules" mount option sets access rights for
> +			files/folders to 777 and owner/group to root. This mount
> +			option absorbs all other permissions:
> +			- permissions change for files/folders will be reported
> +				as successful, but they will remain 777;
> +			- owner/group change will be reported as successful, but
> +				they will stay as root
> +
> +===============================================================================
> +
> +
> +ToDo list
> +=========
> +
> +- Full journaling support (currently journal replaying is supported) over JBD.

          journalling
seems to be preferred.

> +
> +
> +References
> +==========
> +https://www.paragon-software.com/home/ntfs-linux-professional/
> +	- Commercial version of the NTFS driver for Linux.
> +
> +almaz.alexandrovich@paragon-software.com
> +	- Direct e-mail address for feedback and requests on the NTFS3 implementation.
> +
> +

thanks.
-- 
~Randy

