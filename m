Return-Path: <linux-fsdevel+bounces-48011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435BAA8910
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C369418941D4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C88242D7E;
	Sun,  4 May 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="pEEzGbZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G7JLIyoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC884C96
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385105; cv=none; b=j1vd0ZmCM2CpX2ZFGfSLb/U+lRDXF7jaxErX1XPvlvRJkXXMhtvGEujMev0qmiZTr5B+PjJW+5dwQGTMasvluZTivVDvth4CsLBfZI458bUORSA3zgFb+vyQmWqS5/0Ki4yar0SHd3ys+DkycjaqZeA/OaV8oERjmi3oKZoBmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385105; c=relaxed/simple;
	bh=Inn+ZfBm0UTqysrs7hUyJoaGYL3HdZEkFL8xHwn/VXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7etYWwIazuZ+9BRabPErf1hqw00hJBtyHn/XfU6FQMnkkaqpU1utnnsMdMzUZnVV0+mvKFAMhvFFTS2w+i/Tiyg2cA5jVDRmNSkjQuYjNCMlj1zcm3q6z263QdTFPLoKu8iOdmNOReQQcM9sUcL2bDs+Sv0psvgbNsoVoT6IGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=pEEzGbZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G7JLIyoz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C25E1380198;
	Sun,  4 May 2025 14:58:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 04 May 2025 14:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746385102;
	 x=1746471502; bh=/cGKzKIDGbdv9DOgwF0aU3ARIiUoVbY29ZrHMj40yiU=; b=
	pEEzGbZyg6pHBFKv192TMDWEb0d37Zyk813XQVdu8NuM2xbfBP9wUWumeMIGRyfW
	nMapgF4169XczzZGymsS7PN0Ge5b7BHDHGl7CkxYMDIlBFbzzhCsIWRmUZOhYC0S
	uBwcTo4fxKP2Sqk1GsegcFWXecZgNSPs+qpFe02DEf+DT1Ld33iYjIsF4R7jYJ5f
	RtQkoWKO4lo425tnfsf1RYJAuHH4BHhXrFl37tBspl1/dtLHic0wmAoHxfexfgsv
	1O58vOnA1swqwNY26oX3eVhMD9LfeDBuxqyrAE1ucbc/soH+U1ym2Q4F5lUsVRLA
	JNB/OGbixit1Sfh7ut+DMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746385102; x=
	1746471502; bh=/cGKzKIDGbdv9DOgwF0aU3ARIiUoVbY29ZrHMj40yiU=; b=G
	7JLIyozJnkE3TOf2cSpbwwkQVqmKpKHgcVVUYUQrqSAMQbmYbMcQS6CIy/gMJ0cY
	pF7YEvNWPbHdi+Q0P9pzOqXuN85Abz7GGXOjYrahTUOAPbczieW5KUiCAEv1INIZ
	56IZzfzV0UB9c1L6ZCsecNG/xiZpSWBYIwBTovmfHT8oF2dJQlgpeU+EH3u08quG
	PO3Hr7ovh2exjBtzeitNBtBlCXldPsgqr7cEApR4jSwuwtMaizYV/dLVerXJCil1
	4i3E765eMZQkSP3OLBuZW3wJ8sIP2xye/CCGbACJsmAH+w/LPUkOtQuDy7yn5M13
	vQp+lUlsdtbk7y7JLo0LA==
X-ME-Sender: <xms:zbgXaObXR0_Nw9mW3PI2nV8QgESGgNP-dFKMCMBuqb5Ykx7nn-GX7g>
    <xme:zbgXaBatjRH9Vmihf3BLAXg-gCyI0sB9e_C2LMUnh51EhKVrK2hQT7Yzm-HJdEezO
    AhpxdTmS0D2yIx9>
X-ME-Received: <xmr:zbgXaI_OfF4qwJ-JER-aJPOK82yUplOkbPYb5VSmpofDV9iAR3wuAzdSKbvrhmVpxqyBl4e_0c9D5TKPJ--Teo871FbW8SJjGA2rhIZUPuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnheptdfhieekleej
    leelfffhveffgeekhfeihfekieeuvdetkefgudeltdegheegfefgnecuffhomhgrihhnpe
    grrhhgshdrphgrghgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdp
    rhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhope
    ifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdht
    vggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:zbgXaArZbw8x5DYFsRsmeCHByzTef4bJCKWGD4S9hly7UWVuVJ68AA>
    <xmx:zbgXaJopGg1P7Lquywc9DngMR38fJ83p_M47jmcwb6k3O7le18AYDw>
    <xmx:zbgXaOSuYnxJUzKzxs0LuPq37iu_gLlZKzJXd_neM8MRS3fkM0pftg>
    <xmx:zbgXaJrg8gNYOKQr77ybD_2p-27iUqsSgSg5IuZLpM5zLuyvn1tj4Q>
    <xmx:zrgXaCY6KdUmVhROBnkUIHHADbtSiDOFWhHk4gzvbG9l0YzvwqrQqcLC>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 14:58:20 -0400 (EDT)
Message-ID: <06d9f7e9-4dc7-445b-af34-2b8e8f95951e@fastmail.fm>
Date: Sun, 4 May 2025 20:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] fuse: support large folios for folio reads
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-6-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250426000828.3216220-6-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/25 02:08, Joanne Koong wrote:
> Add support for folios larger than one page size for folio reads into
> the page cache.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e44b6d26c1c6..0ca3b31c59f9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -793,7 +793,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
>  	struct inode *inode = folio->mapping->host;
>  	struct fuse_mount *fm = get_fuse_mount(inode);
>  	loff_t pos = folio_pos(folio);
> -	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
> +	struct fuse_folio_desc desc = { .length = folio_size(folio) };
>  	struct fuse_io_args ia = {
>  		.ap.args.page_zeroing = true,
>  		.ap.args.out_pages = true,


