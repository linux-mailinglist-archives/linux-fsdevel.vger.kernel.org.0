Return-Path: <linux-fsdevel+bounces-22838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6A91D67B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 05:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144F31C211D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153B17BBB;
	Mon,  1 Jul 2024 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ERwIOWab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CaLft+Wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDC171C9;
	Mon,  1 Jul 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803166; cv=none; b=IFSLQ6rQEIy2+A6FpI7UHgIBWfJk/EQE0WT846PMw/3iHPGptJlFj1pc5kq1g2cph2Ff+a2rb+eLmVROG4x5KqfDu4ZLRud3TWzJjiQRuvgHMbqX5zbSoYXVQWnmZ7+mIVHshmRD4m7x6UVe8MWPZtY9MNJq8nMjLR5GbZkeXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803166; c=relaxed/simple;
	bh=WdLI9+KQMowdRE4lt/uDMQf5cs86flgWpmReQzVfpQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGKthf8SQwuC8yZrlT8Qmbvg1oVgd2dsUM1ogQ4Bm22TDLeW+QRhHsQCTEzQ1zi5jLH6CKecSxNuLUvwRteXFt89gGqmgxye3FttqJY3p/bL6DDNg2BzfMAoey+P/L/wgbIw6hd9zoQYU8cmVRB4NDCfx0lwa2D3Nan4V2GtLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=ERwIOWab; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CaLft+Wb; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id F36851C00092;
	Sun, 30 Jun 2024 23:06:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 30 Jun 2024 23:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1719803162;
	 x=1719889562; bh=blAxKVj7q0jwyu+EbjanaoPWlHbeXSCclOdG6j2yjMs=; b=
	ERwIOWabVaaMR5gTgfZDkN2VHLmxLmGEsHXTPKWiuRfPbj1IHYJ6Ay6zr+rZo2EH
	6ywTpS05qtJpqoEDXh0UHeacpg4uRmHPDb7zdlq6COJ21qbOfs8VdkL0BOqVGH0j
	np7ebgww2y8krla7iYJQbduWPXKxqZbYkeTBPtaIEZPp98MmlKCdEktn9mu3EFt0
	qVKKWqhWhG2nrzwrJ0buTt+XkpNNZJaqwIWZpxQh4Ioa9dg2hRQR7RKp3ddpVQxi
	zMg0cAPrTxIG8weNhla5e1N8HTAtYKrmwYw20uvMbwciOifhmsSBCBOnzDiWOOrw
	xCmIQB6vqZSMunrl91Ej4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719803162; x=
	1719889562; bh=blAxKVj7q0jwyu+EbjanaoPWlHbeXSCclOdG6j2yjMs=; b=C
	aLft+WbY3GV1DDLMxyDNSnLqzRwrOdxeiowo7BKPaT8eBbtc2U8wM1hDZnU74YmM
	yze3ApszyllIyWHs3LgmjNg34PWuSxmxhOKStOGB4PIfYiwkfBluQLyvdZT9jHb+
	aqG5f8C0IF8UyTCGMmEEtzFalPh316qMPut3/OQI6FAWpb/gzaXtm6j+DdI+lWmK
	2M8enZtmUiKZcZbJ7OjXvMtD6aiw7im522CrV0wQxPq2i4B7OfPrp64V6lB5+zIs
	SXQbCqQ9Hrf5pU9TcOSrPXOpPZHH7rlpOxCJM1jpPDVRPtWbBP2s0VfHZPtDoHw6
	Fl+TKJnZ+3g5FR+YBBHJg==
X-ME-Sender: <xms:Gh2CZozGUAwP8JX7nsbR2BVTBn0nk7pMd8Y2hOUjNRDz3QSMTN14NQ>
    <xme:Gh2CZsRtzIkkJQo-r8z-vV5sELO9ufdzAh4YWwsSKZqchEWYlM1NX_3tZb3hb6fR4
    RYZC280i5Ia>
X-ME-Received: <xmr:Gh2CZqUsuXZnX-eWehJ8ESE6K92wzNsL6t7XxbO1kjhz3QvjA0IAWrK1kIOmFbGicDkkku-OjgTU3bgaJEgDpQu-oThEu49mirf2_pAo3TerL8AiBR5X-wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    efkefhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Gh2CZmis822uieLplCdDT13iPQleY6Lz3J_PPlseRUJVqzRNb1pPhQ>
    <xmx:Gh2CZqCcyRn4DDJPd088BJEb2SKJXrtGcsd3onru_sMrIoFR-Z7iPQ>
    <xmx:Gh2CZnIM9sEkoED2AueVyhTAVzKABgYRQM7ob5nl5Zj5wxK9FMU49g>
    <xmx:Gh2CZhBKp2xwh6hdxCd9CZwS2vCNVylRQSyuXJz62Ejde0ERSEuEvg>
    <xmx:Gh2CZlPOlFLRhuOgtLaSvhhoBDGgZteWrPaB9EKqt3UsXkgMJuRUYtFu>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jun 2024 23:06:00 -0400 (EDT)
Message-ID: <da8b776e-f5af-4d61-b030-c5a18e2276cf@themaw.net>
Date: Mon, 1 Jul 2024 11:05:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] autofs: Convert to new uid/gid option parsing
 helpers
To: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
Cc: autofs@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <faccdd51-07d6-413f-aa55-41bb0e7660df@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <faccdd51-07d6-413f-aa55-41bb0e7660df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/6/24 08:27, Eric Sandeen wrote:
> Convert to new uid/gid option parsing helpers
>
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> ---
>   fs/autofs/inode.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index 1f5db6863663..cf792d4de4f1 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -126,7 +126,7 @@ enum {
>   const struct fs_parameter_spec autofs_param_specs[] = {
>   	fsparam_flag	("direct",		Opt_direct),
>   	fsparam_fd	("fd",			Opt_fd),
> -	fsparam_u32	("gid",			Opt_gid),
> +	fsparam_gid	("gid",			Opt_gid),
>   	fsparam_flag	("ignore",		Opt_ignore),
>   	fsparam_flag	("indirect",		Opt_indirect),
>   	fsparam_u32	("maxproto",		Opt_maxproto),
> @@ -134,7 +134,7 @@ const struct fs_parameter_spec autofs_param_specs[] = {
>   	fsparam_flag	("offset",		Opt_offset),
>   	fsparam_u32	("pgrp",		Opt_pgrp),
>   	fsparam_flag	("strictexpire",	Opt_strictexpire),
> -	fsparam_u32	("uid",			Opt_uid),
> +	fsparam_uid	("uid",			Opt_uid),
>   	{}
>   };
>   
> @@ -193,8 +193,6 @@ static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	struct autofs_fs_context *ctx = fc->fs_private;
>   	struct autofs_sb_info *sbi = fc->s_fs_info;
>   	struct fs_parse_result result;
> -	kuid_t uid;
> -	kgid_t gid;
>   	int opt;
>   
>   	opt = fs_parse(fc, autofs_param_specs, param, &result);
> @@ -205,16 +203,10 @@ static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	case Opt_fd:
>   		return autofs_parse_fd(fc, sbi, param, &result);
>   	case Opt_uid:
> -		uid = make_kuid(current_user_ns(), result.uint_32);
> -		if (!uid_valid(uid))
> -			return invalfc(fc, "Invalid uid");
> -		ctx->uid = uid;
> +		ctx->uid = result.uid;
>   		break;
>   	case Opt_gid:
> -		gid = make_kgid(current_user_ns(), result.uint_32);
> -		if (!gid_valid(gid))
> -			return invalfc(fc, "Invalid gid");
> -		ctx->gid = gid;
> +		ctx->gid = result.gid;
>   		break;
>   	case Opt_pgrp:
>   		ctx->pgrp = result.uint_32;


I like the idea and it looks just fine for autofs.

Acked-by: Ian Kent <raven@themaw.net>


Ian



