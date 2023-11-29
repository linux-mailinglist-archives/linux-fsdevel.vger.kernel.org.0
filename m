Return-Path: <linux-fsdevel+bounces-4281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C292E7FE353
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C660282254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B773B191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="sD6GEzvN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCHDWAyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828F3A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 14:21:33 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id EB8005C01A7;
	Wed, 29 Nov 2023 17:21:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 17:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1701296492; x=1701382892; bh=CHVAaxoz+v0cO/tXy5Ic9W/7NgStREtjOnp
	zZW3AZV0=; b=sD6GEzvN74fPu2D2TxG2HfB7esqZLm9HJNM82O4n+4U6Y9BmLfF
	O1D5R0klYwvBDibpUTF7fQuvBIt+UKPPUy89fcNtBY669yam5eK2+H/2LRJOZo6x
	KH3eXgX2AXyVfgFnOvVLipBHyN3ejrGujDX3RHZWUNVsXNyFfANj296Z5ZvuRVLJ
	YbKGNtpZb9WNr1U4oW4mS17UI7cAbkh3bAJjQ69xs2TDWicvLiZ1qk006TsUEai2
	/eqNewhqmZ1So9iMkvehbUya3+KEjWBB5Jdp/Ju42D7giEW2vN2UDxV3RTUw6XI5
	7eHRVv3wump0k2pBr7lLCEDTLYcza6WeyQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701296492; x=1701382892; bh=CHVAaxoz+v0cO/tXy5Ic9W/7NgStREtjOnp
	zZW3AZV0=; b=NCHDWAyyUwMZbjj0aJraKa481gs1/Tj/XDE8UFrgnUug8T07j87
	0DFlTnqAf1w9+OtVCshUb3nYaHrBBf/Kmi0qkiZbur5KlzXnliq+S3pUngeeySBQ
	euBwNd0KIBsxtMRu8pgeNVo0Yd0KEi0D9Pq5l7uXl8g8youXWlg5TRdxniPCHjDc
	L72JtPI/6Tzd+cUYOu/jZmIjWkZpmrXul2GLjcUu5PD2T2snVg4y7BVasqfGoOoS
	QHzhbxJEvc+WkbjTjSNYfhCOO3ESmI9FV0KhyVeS9WTO3GtAPo6z1pr3mD8Eoi71
	IcFu900nIcKJFUilP6OeVm5kvD7/wzdWtnA==
X-ME-Sender: <xms:bLlnZazUjutFlJsEPM-wcGLtCzldE1OhaQfXjCstvbrDffrzTLFqdQ>
    <xme:bLlnZWQxaR3cEP_Eu4JEy7DTaOqChP7u7Jr59jzJ-NT04PUngJIfNSCL_DPrfUyjx
    aJqe9Ai-lgq3DoL>
X-ME-Received: <xmr:bLlnZcU3uj-jjxZEikhPFRKpcJUBpCQk1jPPgBQzT1znCUUuZfGPb0A9hLm8EAwIxFKfChTQEWDi7SOsoKpi4a7k8Wwl1ywV66IfrUbORRCXPlyA87t->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgse
    htjeertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepve
    fhgfdvledtudfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrsh
    gthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:bLlnZQgp5PRQZZhfP8ftCDCbnisP78b1hIX6VSLrT5YAnV0UC-PVVQ>
    <xmx:bLlnZcBspkFnFtUEbvna3NYpxnBnIMCYLIByPSvQJ82InnZs1SYZvw>
    <xmx:bLlnZRJqd7tMuJH38tiEa7hFXz28aiph-5OP7QeszBqpDr0vEi6J6w>
    <xmx:bLlnZY2bqv92vNXMkIJwOTulq61zwk1CdfT6zcNUz2MnM9ylZNvX4g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 17:21:31 -0500 (EST)
Message-ID: <c652fc1f-cef6-46a9-a47b-d23fb877c5cf@fastmail.fm>
Date: Wed, 29 Nov 2023 23:21:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fuse: Handle no_open/no_opendir in atomic_open
Content-Language: en-US, de-DE
To: Yuan Yao <yuanyaogoog@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
 hbirthelmer@ddn.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 bschubert@ddn.com, keiichiw@chromium.org, takayas@chromium.org
References: <CAOJyEHaoRF7uVdJs25EaeBMbezT0DHV-Qx_6Zu+Kbdxs84BpkA@mail.gmail.com>
 <20231129064607.382933-1-yuanyaogoog@chromium.org>
 <20231129064607.382933-2-yuanyaogoog@chromium.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20231129064607.382933-2-yuanyaogoog@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/29/23 07:46, Yuan Yao wrote:
> Currently, if the fuse server supporting the no_open/no_opendir feature
> uses atomic_open to open a file, the corresponding no_open/no_opendir
> flag is not set in kernel. This leads to the kernel unnecessarily
> sending extra FUSE_RELEASE request, receiving an empty reply from
> server when closes that file.
> 
> This patch addresses the issue by setting the no_open/no_opendir feature
> bit to true if the kernel receives a valid dentry with an empty file
> handler.
> 
> Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
> ---
>   fs/fuse/dir.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 9956fae7f875..edee4f715f39 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -8,6 +8,7 @@
>   
>   #include "fuse_i.h"
>   
> +#include <linux/fuse.h>
>   #include <linux/pagemap.h>
>   #include <linux/file.h>
>   #include <linux/fs_context.h>
> @@ -869,6 +870,13 @@ static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
>   		goto out_err;
>   	}
>   
> +	if (ff->fh == 0) {
> +		if (ff->open_flags & FOPEN_KEEP_CACHE)
> +			fc->no_open = 1;
> +		if (ff->open_flags & FOPEN_CACHE_DIR)
> +			fc->no_opendir = 1;
> +	}
> +
>   	/* prevent racing/parallel lookup on a negative hashed */
>   	if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
>   		d_drop(entry);


Thanks, I first need to fix all the issues Al found (and need to find 
the time for that, hopefully during the next days) and will then add 
this to my series.

(We also need to document for userspace that the atomic_open method 
shall not fill in fi->fh in atomic-open, if it wants the no-open feature).

Thanks,
Bernd

