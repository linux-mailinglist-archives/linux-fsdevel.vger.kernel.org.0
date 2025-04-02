Return-Path: <linux-fsdevel+bounces-45492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA83A7876E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 06:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C84016E35E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 04:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6137230BC7;
	Wed,  2 Apr 2025 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jLnfTDA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E21AD27;
	Wed,  2 Apr 2025 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569598; cv=none; b=HXjqb+bG+jaZsKOCGBINCRnBnFYAyWgHfZf+A0QAoHhCFjL0bRJUElW0swCIePYAtH5jV9U4UX19WwssresD1EAxxu48+CK/N2UV0I0vR4jyyLez3/YyboJPj8hEusdYC7XWdz8tDp3IoDvabRUVy4/Ilp3DEYRsR4qeM6JBXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569598; c=relaxed/simple;
	bh=1p/p24fKQmwG5MgKH3lwZvDNy0dI8nPxF64et6Oh5M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKvH3sYDR1LVESpjqBDzAOkZoNTbiVPR9mxNm84LZo9IcDUiLL/Ii1wlYxhtqwBwDWbSgIs7vHOj8vuxXJhR/x8x9wUvhJ7SLJIyoHRwYx2jpSqk9vtNP1M9lrtlDNdFM0u9550zwsnKp5YcZVyB4kx7TsQ0XDtuWekrG5iE0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jLnfTDA3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UT1AqupZtOwH0L8qQgNBpdiEXV0FClrSPN37lD8JtvQ=; b=jLnfTDA3dkc3irYllmeMdDQukG
	GmbukxTl+IzW5YHG/BvHkoNpw0hpcgdbJDxFMbdLPqXMYistlGfIJi3Xu7ccogIq3eMeKXcQD2nnN
	E70qSv9X+x9YkKYtXKbE4gxp1OCbzBDB0QB/ZoG86yT0bfoMysji22dw+ELVKATh7dfIO6J26JXp6
	75PrieyOeqTA/J3nlN/TbT/+lB3cOcqcHkc1YLDc2cQ/jgii3lE0T7XumMMx1ZHra9zAUGw2qEubr
	lFpM0Ztq+sXTJ/81vH86ma8Jqw0Z9au3K9XZfhE/eRqw/VYwadD1OHj3B2ALeRi+SMhn5USb/QKUN
	KaDe2LkQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzq6D-00000006y0K-0a5h;
	Wed, 02 Apr 2025 04:53:13 +0000
Message-ID: <edcc6e4d-3270-46f1-aafc-437c6ba5b0a3@infradead.org>
Date: Tue, 1 Apr 2025 21:53:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: initramfs: update compression and mtime
 descriptions
To: David Disseldorp <ddiss@suse.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250402033949.852-2-ddiss@suse.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250402033949.852-2-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/25 8:39 PM, David Disseldorp wrote:
> Update the document to reflect that initramfs didn't replace initrd
> following kernel 2.5.x.
> The initramfs buffer format now supports many compression types in
> addition to gzip, so include them in the grammar section.
> c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes since v1 following feedback from Randy Dunlap:
> - contents -> content
> - format of the initramfs buffer format -> the initramfs buffer format
> 
>  .../early-userspace/buffer-format.rst         | 34 ++++++++++++-------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
> index 7f74e301fdf35..726bfa2fe70da 100644
> --- a/Documentation/driver-api/early-userspace/buffer-format.rst
> +++ b/Documentation/driver-api/early-userspace/buffer-format.rst
> @@ -4,20 +4,18 @@ initramfs buffer format
>  
>  Al Viro, H. Peter Anvin
>  
> -Last revision: 2002-01-13
> -
> -Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
> -getting {replaced/complemented} with the new "initial ramfs"
> -(initramfs) protocol.  The initramfs contents is passed using the same
> -memory buffer protocol used by the initrd protocol, but the contents
> +With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
> +with an "initial ramfs" protocol.  The initramfs content is passed
> +using the same memory buffer protocol used by initrd, but the content
>  is different.  The initramfs buffer contains an archive which is
> -expanded into a ramfs filesystem; this document details the format of
> -the initramfs buffer format.
> +expanded into a ramfs filesystem; this document details the initramfs
> +buffer format.
>  
>  The initramfs buffer format is based around the "newc" or "crc" CPIO
>  formats, and can be created with the cpio(1) utility.  The cpio
> -archive can be compressed using gzip(1).  One valid version of an
> -initramfs buffer is thus a single .cpio.gz file.
> +archive can be compressed using gzip(1), or any other algorithm provided
> +via CONFIG_DECOMPRESS_*.  One valid version of an initramfs buffer is
> +thus a single .cpio.gz file.
>  
>  The full format of the initramfs buffer is defined by the following
>  grammar, where::
> @@ -25,12 +23,20 @@ grammar, where::
>  	*	is used to indicate "0 or more occurrences of"
>  	(|)	indicates alternatives
>  	+	indicates concatenation
> -	GZIP()	indicates the gzip(1) of the operand
> +	GZIP()	indicates gzip compression of the operand
> +	BZIP2()	indicates bzip2 compression of the operand
> +	LZMA()	indicates lzma compression of the operand
> +	XZ()	indicates xz compression of the operand
> +	LZO()	indicates lzo compression of the operand
> +	LZ4()	indicates lz4 compression of the operand
> +	ZSTD()	indicates zstd compression of the operand
>  	ALGN(n)	means padding with null bytes to an n-byte boundary
>  
> -	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
> +	initramfs := ("\0" | cpio_archive | cpio_compressed_archive)*
>  
> -	cpio_gzip_archive := GZIP(cpio_archive)
> +	cpio_compressed_archive := (GZIP(cpio_archive) | BZIP2(cpio_archive)
> +		| LZMA(cpio_archive) | XZ(cpio_archive) | LZO(cpio_archive)
> +		| LZ4(cpio_archive) | ZSTD(cpio_archive))
>  
>  	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)
>  
> @@ -75,6 +81,8 @@ c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
>  The c_mode field matches the contents of st_mode returned by stat(2)
>  on Linux, and encodes the file type and file permissions.
>  
> +c_mtime is ignored unless CONFIG_INITRAMFS_PRESERVE_MTIME=y is set.
> +
>  The c_filesize should be zero for any file which is not a regular file
>  or symlink.
>  

-- 
~Randy

