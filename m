Return-Path: <linux-fsdevel+bounces-54553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C8B00EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 00:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D241795FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A502BE057;
	Thu, 10 Jul 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Pi1SncNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D14zX4SP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9229E10D
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187432; cv=none; b=F15t0g+/B3DhqQLVQXw9IuN5/XhJGPbVcP3jxtzIsVAoh5GmXNbslKZa8+VnXenoG8i57Vd4XnEtw2q8rcCoJIZZ9GXfup3/tNya65geKaxkTyPICPAQz+OosW5g7dCrRt6wISl+eO3JLsK23eD9Hto5rHSNase6sxi6fVhru1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187432; c=relaxed/simple;
	bh=7V7t0Bg+0zQ8C5qPkAXGvk0SQF1ohI8Fjo2R2VOBI+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quVy6EZlsXLFRHKXiV1cFaGFWSE9uLOtRgg7PZQ6nBEhMoXN5oeXSrKiSVPbrF6hmmXo8yXkdMXYBJs2a+yipEMQRMbxvdGgd27hF8CC4La/gVszIpFBijbDOnRtne6qmDS3DNyn0RqBdLACxNckVjz/xnQvcUNYrhvLz1+0aro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Pi1SncNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D14zX4SP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CE4D61D0012B;
	Thu, 10 Jul 2025 18:43:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 10 Jul 2025 18:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752187428;
	 x=1752273828; bh=o1FAdBzFIGucu/PYSB99+Hk3XuRcdVu2qhU7ny0SSWk=; b=
	Pi1SncNv/95Fz9wTtHftLdQnvG/fJJZwoIljkLp+KtYiKsXlTqbVuIkk8lSfqDtR
	PWkKC1QL1v1lsg+K7v0pwtOVbAegLMCeId3NCcd7RNR7TF8/Pk5Prq5wE7c9qXqH
	TbWU9KdRDIbQwfv3ic0HMIxeMtsGmfvoEI9BAI8Nc3rSvibToxmzOOu5VaSXyTFZ
	fZ4mkW13rYpRwy70rUcE5o5OOzzy19SCei+SPV0kVs2QcFEijxXqgqOuI2GPAXwx
	Ksje/NlCP2Wks8aGVBkubWYCfVjMUeZlOxNMnCdaiN8CbWZ1zJ8DvTi02nAPRkyG
	PmvXW5s3HmWKRdOeYRkdNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752187428; x=
	1752273828; bh=o1FAdBzFIGucu/PYSB99+Hk3XuRcdVu2qhU7ny0SSWk=; b=D
	14zX4SPZ2Rn7ut3ZQWcIsqOsOsByAVnVwPx4zz9vlgrtJb/BoGe70pgXmcw9/upm
	+aqMDSQjU5QOE/OgmFZFH1Cj4X33nYCp+2W9RGrzXA5QyyjrP7BpGhvaY5NE/v1t
	FhcpKLyIX2awt0HaSBpm9VyeKiGUhNtFHKqMrLnamIiVgSggW/Arsj8/xjolPiPH
	yJxqc8bwshr36RB2uVDP8Itz1bHc9J2e4vRpmdrXR7oX7EisGHdDINBTa6vpiqid
	R82de0s24H976sbzqztCqqVJ14X8fB4+BoRKovMruL3ewK3KbxCEbBo0rXO/qvWv
	jDxw63Edo5Pb6LtEJw7Ig==
X-ME-Sender: <xms:JEJwaDUV5fJ658TLbzxmGuOgUnxKhd3Zlt4cIJ1_Da2HESjvaWUuCQ>
    <xme:JEJwaO2t8fNb8ZeL7VKWtO18-4xm3iu2U4qIlifCyOniX8H6WFlE5UlhotLHrJPQJ
    cj2k_c5KTKdYHNf>
X-ME-Received: <xmr:JEJwaI1_cMWz6BoPMVp5enw6U1lOmosUYqpjsNL9IoTbdF_Zu-AC44Yj4P5RjOYiBeCPA2vOYfMwrdD60eGI9AYgk8tM1wT-Gf_5Pih73xzeOgZ0M4SD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveejieef
    veeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghmih
    hrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgv
    ughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:JEJwaJ943GnRBllXHAffkXgvtKfkdcF_ZqhkZpbrJSCU2HBzCMHWQA>
    <xmx:JEJwaN22Y0bcOvCUcaaQpAI_EMu6X_NXv707QfPibg_9SIFn1i0dJQ>
    <xmx:JEJwaO9zTjbkhz7LkBwN4s8fiFnyB5cAd43d85RK07CY0Dvkfmb9qg>
    <xmx:JEJwaFvXEiEBYUVbM5BW7Oz6UemeKLRYlndEK3ZDSm89cTRfYfs2rw>
    <xmx:JEJwaELk0jAXa3fgvSSBUysYBPe0Tz1kwIikz8IucCYdfIbBJ7J-BUNz>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 18:43:47 -0400 (EDT)
Message-ID: <fe814a25-be4c-4bed-aed4-fc70ab870156@fastmail.fm>
Date: Fri, 11 Jul 2025 00:43:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: do not allow mapping a non-regular backing file
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20250710100830.595687-1-amir73il@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250710100830.595687-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 12:08, Amir Goldstein wrote:
> We do not support passthrough operations other than read/write on
> regular file, so allowing non-regular backing files makes no sense.
> 
> Fixes: efad7153bf93 ("fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> While working on readdir passthrough, I realized that we accidentrly
> allowed creating backing fds for non-regular files.
> This needs to go to stable kernels IMO.
> 
> Thanks,
> Amir.
> 
>  fs/fuse/passthrough.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 607ef735ad4a..eb97ac009e75 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -237,6 +237,11 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
>  	if (!file)
>  		goto out;
>  
> +	/* read/write/splice/mmap passthrough only relevant for regular files */
> +	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
> +	if (!d_is_reg(file->f_path.dentry))
> +		goto out_fput;
> +
>  	backing_sb = file_inode(file)->i_sb;
>  	res = -ELOOP;
>  	if (backing_sb->s_stack_depth >= fc->max_stack_depth)

LGTM,

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

