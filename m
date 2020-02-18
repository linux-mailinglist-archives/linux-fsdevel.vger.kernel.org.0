Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE568162161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 08:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgBRHMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 02:12:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:37296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgBRHMJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:12:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05A6BB277;
        Tue, 18 Feb 2020 07:12:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D2BCC1E0CF7; Tue, 18 Feb 2020 08:12:05 +0100 (CET)
Date:   Tue, 18 Feb 2020 08:12:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 43/44] docs: filesystems: convert udf.txt to ReST
Message-ID: <20200218071205.GC16121@quack2.suse.cz>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <2887f8a3a813a31170389eab687e9f199327dc7d.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2887f8a3a813a31170389eab687e9f199327dc7d.1581955849.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 17:12:29, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Add a document title;
> - Add table markups;
> - Add lists markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks! You can add:

Acked-by: Jan Kara <jack@suse.cz>

and I can pickup the patch if you want.

								Honza

> ---
>  Documentation/filesystems/index.rst           |  1 +
>  .../filesystems/{udf.txt => udf.rst}          | 21 +++++++++++++------
>  2 files changed, 16 insertions(+), 6 deletions(-)
>  rename Documentation/filesystems/{udf.txt => udf.rst} (83%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 58d57c9bf922..ec03cb4d7353 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -92,5 +92,6 @@ Documentation for filesystem implementations.
>     tmpfs
>     ubifs
>     ubifs-authentication.rst
> +   udf
>     virtiofs
>     vfat
> diff --git a/Documentation/filesystems/udf.txt b/Documentation/filesystems/udf.rst
> similarity index 83%
> rename from Documentation/filesystems/udf.txt
> rename to Documentation/filesystems/udf.rst
> index e2f2faf32f18..d9badbf285b2 100644
> --- a/Documentation/filesystems/udf.txt
> +++ b/Documentation/filesystems/udf.rst
> @@ -1,6 +1,8 @@
> -*
> -* Documentation/filesystems/udf.txt
> -*
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +UDF file system
> +===============
>  
>  If you encounter problems with reading UDF discs using this driver,
>  please report them according to MAINTAINERS file.
> @@ -18,8 +20,10 @@ performance due to very poor read-modify-write support supplied internally
>  by drive firmware.
>  
>  -------------------------------------------------------------------------------
> +
>  The following mount options are supported:
>  
> +	===========	======================================
>  	gid=		Set the default group.
>  	umask=		Set the default umask.
>  	mode=		Set the default file permissions.
> @@ -34,6 +38,7 @@ The following mount options are supported:
>  	longad		Use long ad's (default)
>  	nostrict	Unset strict conformance
>  	iocharset=	Set the NLS character set
> +	===========	======================================
>  
>  The uid= and gid= options need a bit more explaining.  They will accept a
>  decimal numeric value and all inodes on that mount will then appear as
> @@ -47,13 +52,17 @@ the interactive user will always see the files on the disk as belonging to him.
>  
>  The remaining are for debugging and disaster recovery:
>  
> -	novrs		Skip volume sequence recognition 
> +	=====		================================
> +	novrs		Skip volume sequence recognition
> +	=====		================================
>  
>  The following expect a offset from 0.
>  
> +	==========	=================================================
>  	session=	Set the CDROM session (default= last session)
>  	anchor=		Override standard anchor location. (default= 256)
>  	lastblock=	Set the last block of the filesystem/
> +	==========	=================================================
>  
>  -------------------------------------------------------------------------------
>  
> @@ -62,5 +71,5 @@ For the latest version and toolset see:
>  	https://github.com/pali/udftools
>  
>  Documentation on UDF and ECMA 167 is available FREE from:
> -	http://www.osta.org/
> -	http://www.ecma-international.org/
> +	- http://www.osta.org/
> +	- http://www.ecma-international.org/
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
