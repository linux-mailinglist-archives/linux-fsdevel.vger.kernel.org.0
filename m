Return-Path: <linux-fsdevel+bounces-32284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0A9A3136
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 01:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C781F22B3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A822739A;
	Thu, 17 Oct 2024 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSw3Gz6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A821D958F;
	Thu, 17 Oct 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206811; cv=none; b=YAoCjUHHDxR8w+dOlNSWICa+Sf+CP9QaMmbknV4qSPjMjh14cke4HPMbssOXwn0c7FaWdcyp/WsmzqeAkihAokpRglMaNG0N5Te+jMSob5XhokbpNTpQ2H1SmtpwqQBJPmNS8kweM4IympA+5puYpSR7c5jTHmYJ/KkRhumQyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206811; c=relaxed/simple;
	bh=Tm57HR5NFw2CYwx4uunjmcx++qzhwMBgCorqbzmbFv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4mKIE+gnuWYHDranGz1If7ycwfT+oAbHAWq5mh/u/4Cex6rwLO93nPbMbxJm3bJxvCom6RdxTEajaLWA6hHgHxHy00GvjkJ1sZIVN4iTSBA95OQYaA6UmV9LlDwD4W6P6vzmjptsfEn/gnlMpMlwtY5XBdbBa2K/CF9C2+9Jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iSw3Gz6y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=B8mX33s5nApem0yXGWM3AlBpANvFaXCy2a1aCEwgJeo=; b=iSw3Gz6ynGTxgONka5L3hPlc3N
	/4XdFxJmX1AruX9PaoPovNzVy33I4Ckvjy8akXWg6JhVT3jDXHbtkaBuL7XgxDUGaQv4vPYruLmSt
	gblrn3zUlypdRdTbTKJrWHav8lq6lV13cJOLmfBlnvkMBTRpKTEQq6PK3jje1+1zQLjA39NFGqODU
	jI+SUCRO0RZNPvetNjxyYoPbNdgXTR1T6601aHK5GaUGaUlldiZ8ASE2j0/x9vskE0GklCKtWKby2
	8fDbw01oXItQYIU9WSbA1R426YfATIrrdj1HO9YshMzdw877UgI3uecWYbaRdximbEDkiP42pqUOl
	aHFBfNmw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Zg6-00000007F1I-0HtV;
	Thu, 17 Oct 2024 23:13:11 +0000
Message-ID: <787b22d1-7072-4ab7-8314-3f1fd15e5a22@infradead.org>
Date: Thu, 17 Oct 2024 16:13:01 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] docs: tmpfs: Add casefold options
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Gabriel Krisman Bertazi <krisman@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@suse.de>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
 <20241017-tonyk-tmpfs-v7-9-a9c056f8391f@igalia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241017-tonyk-tmpfs-v7-9-a9c056f8391f@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/17/24 2:14 PM, André Almeida wrote:
> Document mounting options for casefold support in tmpfs.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
> Changes from v3:
> - Rewrote note about "this doesn't enable casefold by default" (Krisman)
> ---
>  Documentation/filesystems/tmpfs.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 56a26c843dbe964086503dda9b4e8066a1242d72..0385310f225808f55483413f2c69d3b6dc1b9913 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -241,6 +241,28 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>  
> +tmpfs has the following mounting options for case-insensitive lookup support:
> +
> +================= ==============================================================
> +casefold          Enable casefold support at this mount point using the given
> +                  argument as the encoding standard. Currently only UTF-8
> +                  encodings are supported. If no argument is used, it will load
> +                  the latest UTF-8 encoding available.
> +strict_encoding   Enable strict encoding at this mount point (disabled by
> +                  default). In this mode, the filesystem refuses to create file
> +                  and directory with names containing invalid UTF-8 characters.
> +================= ==============================================================
> +
> +This option doesn't render the entire filesystem case-insensitive. One needs to
> +still set the casefold flag per directory, by flipping +F attribute in an empty

I would say:                                     flipping the +F attribute

> +directory. Nevertheless, new directories will inherit the attribute. The
> +mountpoint itself cannot be made case-insensitive.
> +
> +Example::
> +
> +    $ mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding fs_name /mytmpfs
> +    $ mount -t tmpfs -o casefold fs_name /mytmpfs
> +
>  
>  :Author:
>     Christoph Rohland <cr@sap.com>, 1.12.01
> @@ -250,3 +272,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
>     KOSAKI Motohiro, 16 Mar 2010
>  :Updated:
>     Chris Down, 13 July 2020
> +:Updated:
> +   André Almeida, 23 Aug 2024
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy


