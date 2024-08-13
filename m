Return-Path: <linux-fsdevel+bounces-25820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258EF950E28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02661F21D8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93791A704C;
	Tue, 13 Aug 2024 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ssVTiNy7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPSusTpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0263B192;
	Tue, 13 Aug 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582293; cv=none; b=CnG3l8UV1taCpPH52TnoV8lhLrvuMIlIM+uAxEBuLATs2lfNfIHZZKBsL/nsDelcQKdQYNztcSTih+TEjTmv9f/dJbU4buQvs/zEpec7lbYXgzt7UawNSOP6j2iNT6mqdNucG2rKJe/PUpRkOW3DsD5MWmPfvfiP6LFEMjfraHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582293; c=relaxed/simple;
	bh=NJTt26QOaIzjNnEioBR2M6hmrFI0nPiiBJdNnuP5EOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPbGd0JS5yN6QUjLv1QYJuX9XdFg43YKKGGzXg4ypiNwOqAmCYJmopmO4LDCg+1gH3OUmaL2pPwTKoQZ57gSA6pFAiI6DQsZIFPDch4t2oBJuPpSWbxOLvXbi0x2s72/rOP0l3OiYQU818x1RkIqtk+inFnVbs8teqfnzput/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ssVTiNy7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPSusTpi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7BA011383A46;
	Tue, 13 Aug 2024 16:51:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 16:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723582290;
	 x=1723668690; bh=bUzud+CzxUUzqep0SKVIqN5uPddQlB5I7JlliJFz8wM=; b=
	ssVTiNy7VGIPpoB7gOPKkDEHbI7DHcIzClhQxzCeCs6CsJ2JhNd6l3p1zpc5PMIl
	uz07+HuWWCkkkNxoBDusnH+IxnUTwZeTmbOC8e8nlD36wv0uqzMiFFd8X588BsbK
	l7NR5DsYQRYyUUDsYytxusoYe2J4twLCZI9UlmNdJMBIhoEoxbXrwC1tghGORQhh
	2rgw6hpPTVHQWMH2ZLA3AXZPdFX4IAVo74sS3mK8UNQJAY/y6HLJ9SP7lay7SZwe
	UcNMRsaVD8gdG/qbcNCDDIkicBQNsYgO6unSGdmJWEZF2HytkWlFemHFuuQgBBpE
	ozB3jv2hSpaqaUyaCWq2jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723582290; x=
	1723668690; bh=bUzud+CzxUUzqep0SKVIqN5uPddQlB5I7JlliJFz8wM=; b=M
	PSusTpiTRsGD+ZpDnrs6FmbhF+EUwIHTGOSMMJGdjJdjb4Dgqkqsn5uoDjJ1eR60
	QeH26oMsUWR/g1u1LHAohWWUSdSsDgTHHKjYrZmhuwNWigEwxXy9uLObP9gpjASQ
	8WGLGMhh6JfYEY/2V1RMoyjFgHN+IS6LgBYOcKtaclMmJyvY1lSG6/jU56puOys8
	8RghUEmA+XLWc8+vpyg2RqB8WzDR/J1n89dXx7kFrze3GWpxkYtSNBZIX9q13+Tc
	Zlj4AyrWWiT9hY16EGbOmtqD4d7Nl33Kg4e5owH1t08eVH0CDHOkM+UBvrjeLlYQ
	rRv2KyA74xk3IqlPRuc8w==
X-ME-Sender: <xms:Use7ZqTH5cFp11ee2CJ_WBUv5NjjouNbTOYLK0Ri2oaNOwYtPqQfjw>
    <xme:Use7Zvx0WYtkuRyknl6ck-khgMYcGLzuZJo8ZEgD7GKeVrr0V2mNAzfqLvsGNwtmT
    KVwi9trlzpOP6kp>
X-ME-Received: <xmr:Use7Zn2P4Qv7Ms-MVdTusgW56aZO_8whnQsVNZ8svCqsFyxPrVsMsBrW5HcM6p4QXToPJJf61uHXBdtr4jb4WyNxfNzS1qYSS1mLCw8KG3-sVNIEUu7vV32xcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprggrphhtvghlsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Use7ZmDSE6hsx5-_0pdnI0Tr-imKNHs8pMv23mn8_H7xIUO84Dr_eg>
    <xmx:Use7ZjiXNszMx7aCIDhKuJ7wud80rm6nxZDbep4XhPyvGh_iw9pd4Q>
    <xmx:Use7ZipPoXdMhdr8ypUaxS9lmJJRGQ_ZlBfjlYN-gWCzDYMoL3cp4w>
    <xmx:Use7ZmgCJLanHosH8CEkj3fyiAiQmupzqRgPFNHANbL6p8RpdX6fyA>
    <xmx:Use7Zjd2HB73PW_aFbKi2rDGD6Y7o1I87Y9hV7Ju9aVTau5dvY-4YUnR>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 16:51:29 -0400 (EDT)
Message-ID: <f5f61ebb-cb44-47e0-8cae-0c64d1afc7ff@fastmail.fm>
Date: Tue, 13 Aug 2024 22:51:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/fuse: use correct name fuse_conn_list in docstring
To: Aurelien Aptel <aaptel@nvidia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240517161028.7046-1-aaptel@nvidia.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240517161028.7046-1-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/17/24 18:10, Aurelien Aptel wrote:
> fuse_mount_list doesn't exist, use fuse_conn_list.
> 
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> ---
>  fs/fuse/fuse_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b24084b60864..bd2ae3748d37 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -869,7 +869,7 @@ struct fuse_conn {
>  	/** Negotiated minor version */
>  	unsigned minor;
>  
> -	/** Entry on the fuse_mount_list */
> +	/** Entry on the fuse_conn_list */
>  	struct list_head entry;
>  
>  	/** Device ID from the root super block */


LGTM


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

