Return-Path: <linux-fsdevel+bounces-13016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E0D86A2CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBB0B2909D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F255C08;
	Tue, 27 Feb 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="fODDGh06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298F56469
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074154; cv=none; b=nOEUlZvn1yFfTZ7o1QuolAt5QoGcvg8Dp2MwcJ+cDcCgkb4LlZFizsA87Ub0nAjZgIVeNLrHPLtCOnqSuVp/1sS1U35r1iOzqUeK7l500ixqY8N8YLxTj7pB107ht7NXUmfNGSrLulFyMfmYX7TAIDGDOHSLx6EFa8kR23Nu2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074154; c=relaxed/simple;
	bh=9lmPb+GhBBGwwl/sHglYV2uZNrot41NmTVqqY9Ubl/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/v0d6XxcharuNOBvY16THr1Vqynz0oKlyIH3uJyan//Khx9uYAMRdymLmLqzkcgVxXNiKaMbFHzBF+Q0qh2j7qNoPChRYmKV20I/cgUQ9lhaw69c7A5pRVawtqJFPoywq2hYN7DQzS4INJ2ydXwGzF73My8NTbCb8KEq7ARbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=fODDGh06; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id B528233505B;
	Tue, 27 Feb 2024 16:49:05 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net B528233505B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1709074145;
	bh=0ZpROQxyXTK09s2Rjc88Ytrnav4C6IyHMgCA4iONqS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fODDGh06znccSZoLXoATeYq1HwQuBK4S35mA7hjt5yTBjwWWR4yl0uz801Zkxt5ED
	 wQ5PSr7lidc+qFM84bfaXJS9g+TJI/R1dXNQJ2JaKOVwKnLPxmQ2z44bWlXrZ+gu4F
	 9+dAy5lN0/WX619vc92lkOQRxbPtJqhPa5IjY5ALyJUitTz9MqNMZbZbPWRkU78IH0
	 QG2h8GrDCVFse0psPIWqiBsJTlo6t6cwS/4txlppcoomRfjForC9RxPI8XMiwkDI+L
	 I/JXpOUR1PINICCbzu/X/ye+Mg+qdJTaSjDWT7/wFpB6XDQi+dE5OjOkmzNBdM6iYe
	 HHXsLrk3hExXQ==
Message-ID: <ff9e0d7b-49e7-4c4d-95d1-76bbf8b0b685@sandeen.net>
Date: Tue, 27 Feb 2024 16:49:04 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qnx4: convert qnx4 to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: al@alarsen.net, brauner@kernel.org, sandeen@redhat.com
References: <20240226224628.710547-1-bodonnel@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240226224628.710547-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/24 4:46 PM, Bill O'Donnell wrote:
> Convert the qnx4 filesystem to use the new mount API.
> 
> Tested mount, umount, and remount using a qnx4 boot image.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
>  fs/qnx4/inode.c | 49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 6eb9bb369b57..c36fbe45a0e9 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -21,6 +21,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
>  #include <linux/statfs.h>
> +#include <linux/fs_context.h>
>  #include "qnx4.h"
>  
>  #define QNX4_VERSION  4
> @@ -30,28 +31,33 @@ static const struct super_operations qnx4_sops;
>  
>  static struct inode *qnx4_alloc_inode(struct super_block *sb);
>  static void qnx4_free_inode(struct inode *inode);
> -static int qnx4_remount(struct super_block *sb, int *flags, char *data);
>  static int qnx4_statfs(struct dentry *, struct kstatfs *);
> +static int qnx4_get_tree(struct fs_context *fc);
>  
>  static const struct super_operations qnx4_sops =
>  {
>  	.alloc_inode	= qnx4_alloc_inode,
>  	.free_inode	= qnx4_free_inode,
>  	.statfs		= qnx4_statfs,
> -	.remount_fs	= qnx4_remount,
>  };
>  
> -static int qnx4_remount(struct super_block *sb, int *flags, char *data)
> +static int qnx4_reconfigure(struct fs_context *fc)
>  {
> -	struct qnx4_sb_info *qs;
> +	struct super_block *sb = fc->root->d_sb;
> +	struct qnx4_sb_info *qs = sb->s_fs_info;

You assign *qs here at declaration
  
>  	sync_filesystem(sb);
>  	qs = qnx4_sb(sb);

and then reassign it here (qnx4_sb() just gets sb->s_fs_info as well)

Don't need both, I'd stick with just the uninitialized *qs as was
originally in qnx4_remount().

The rest looks fine to me,
-Eric



