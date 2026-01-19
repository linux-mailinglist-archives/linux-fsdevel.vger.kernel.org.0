Return-Path: <linux-fsdevel+bounces-74375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B108ED39F0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 205B930074A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE028AB0B;
	Mon, 19 Jan 2026 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8ZxmNMJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD12459EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805541; cv=none; b=iLv11/ebanuU0XpD6KySJrjkDCkpxXX8qs0EnjNqjI9eXtDGE40XSJrB9sByrfWyb48UaUWYWU02MXObFl9LgCjbtV2gp2oSX5Lb3MtHkez0PE9vK0zKQCXuatfIngpbI26YEJbYWTfyKoZiP+78KofuYny+F1LacwiSgwmRWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805541; c=relaxed/simple;
	bh=680h/zyRrLNDAAm2Sw+VBT115nFYg03F08NE5M1ubZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1zVMg+8hKI7+Tlb1SRgEOmtN05foNmcJHaMCzfr2qzXkLW6HJOSEhXcAZKUQC0ol5hp9Zwv4M9tn63BGb/1DTKZUTb1hZ5M4W2yORUbDOKnDoSUMy9oQBgxZKBSrOrERxqHG9xclmGbwHGGITBlNDbUmbAKmm9SpCkVrRF8HUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8ZxmNMJ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3895f58-2c70-441b-8975-77c121ee2950@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768805536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCZ8tvVl4IXkgaf0eZ5LsA+xn8wafr26jjAwwPn24UQ=;
	b=o8ZxmNMJmhBU00Gy4TvBRueKpDdRMF3AhRw+lfPPdnD62p6PJoPYdVyp2GKCT4AZQShGSp
	PIh9fi4xgB5a7axPntmS5lbdIDK4Dua9Pv29I2A0F0WQGkiifxx4Xb5B9wvyrP2Jx5LWPj
	pF+DJrrxkPPVjE9UOC6UDWdjJO0f5nM=
Date: Mon, 19 Jan 2026 14:51:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 25/37] cifs: SMB1 split: Split SMB1 protocol defs into
 smb1pdu.h
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Enzo Matsumiya <ematsumiya@suse.de>,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251222223006.1075635-1-dhowells@redhat.com>
 <20251222223006.1075635-26-dhowells@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251222223006.1075635-26-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

FILE_BASIC_INFO (and possibly other definitions) is also used in 
client/smb2inode.c, and it is defined in MS-FSCC 2.4.7, so perhaps we 
should move these definitions into a new header file client/fscc.h.

Of course, for FILE_BASIC_INFO, smb/server/ has smb2_file_basic_info in 
smb/server, so we could move them into common/fscc.h.

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 12/23/25 06:29, David Howells wrote:
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> -typedef struct {
> -	__le64 CreationTime;
> -	__le64 LastAccessTime;
> -	__le64 LastWriteTime;
> -	__le64 ChangeTime;
> -	__le32 Attributes;
> -	__u32 Pad;
> -} __packed FILE_BASIC_INFO;	/* size info, level 0x101 */
> -
> --- /dev/null
> +++ b/fs/smb/client/smb1pdu.h
> +typedef struct {
> +	__le64 CreationTime;
> +	__le64 LastAccessTime;
> +	__le64 LastWriteTime;
> +	__le64 ChangeTime;
> +	__le32 Attributes;
> +	__u32 Pad;
> +} __packed FILE_BASIC_INFO;	/* size info, level 0x101 */
> +



