Return-Path: <linux-fsdevel+bounces-44308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A5BA6715C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C40B420364
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88920764C;
	Tue, 18 Mar 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="EsWjar4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVU4muHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668B202997
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294063; cv=none; b=HPl086NO49wlOS9ERg+1AsXiD0w5gy/ur0gFSi3q7AzI82shi93sS6Z58nN9t/y20iLH0EOpzUnTnPPzkHIcWXiuCtOgPhE9Pu3tMomZnwJ8Y9r5zGzbtoZgqjClIwiXDtX9yfKLRfsQ6pHw3dJppJ46CT0Mb5h+MuyFVFHcV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294063; c=relaxed/simple;
	bh=/qLLMjCn2ilr81/BXNeDzupxBMhQho031pVDcJRlZQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6IwjoXe+eTK0ixEuWcM5jGdvnrjlscHvoEx966uq99vrIdz6fUFZ7eRjTFn5IAVD/V0V6bG86I9jAq6j4vg5j3bBd7FrFvLMOUq09anornCKN36atHAVbgHlZUYhpc+bmqz/ZjlNeJM7Tk3tjroO1hSukm1URAlzPW9vK7c3mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=EsWjar4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVU4muHo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 759FF254012D;
	Tue, 18 Mar 2025 06:34:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 06:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742294061;
	 x=1742380461; bh=TfzA+5jTiHYUrrOjA8OBbybmAr4B8rOGs2u3qrija7A=; b=
	EsWjar4FLKv6HRLjnOgsM3o8BPmbhNtmvUOX4KNw3bS2lnObMcOACZhimmiuNCby
	QSazdVsmwyzUNs1DqrgUsvBzOw6sTyft53HoFcXgTQWz4JlZHP2cc4UmJqO8PnSF
	QNotFbrXsz6/3PyY55ud34Rzk0tXAwXFE43GxR03ptw5mQpWQIo2GVXqjSQZ4xDC
	4FgKOpKtGvufDUH33zb9egsQQe+3miIkQ81SFIo2rgaB5droiraQ1o7kcG1CiRAi
	tNBC2ddPVZjaJp+FT34OGe4UJRVtiJOSvwnvLGDHs8/zn6iqog49H7MobriwDEoV
	xTJ86fvqrC5MHIxDnp9cQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742294061; x=
	1742380461; bh=TfzA+5jTiHYUrrOjA8OBbybmAr4B8rOGs2u3qrija7A=; b=J
	VU4muHoa5B49hexgAXaWZW0q1wshdD8A3XhL2TGheTi6kMcYUrPPGDhUOj6Cpv39
	tUAZDgPRnjDdYl2O+XR0eqPiUlerXrbrkqCTK8LbUpRY43MqqFPxcJnwn0Zjmrzn
	/QmC6b3A3PXoKPd4mHut/Je5eSvXCvYFyEPdnTU7GBbNbGxo+DGDNdrxsNWLSxGX
	fWhCdsFqgN5QJ4E1a7+q3TNho/5O+SdVb2qzwT8t5okmeX2kvpoYtwSLwhvy3mPa
	VS3QSu4cpUhmcN3QNO4i/Rq/SW/UygFRig0QeEtApawixOUaBnlvhwcRJ8i4W5+9
	uDP8IsLQjS/bWD2GW4HWQ==
X-ME-Sender: <xms:LEzZZym2FshZeqA7Yt07DbXBkQQtN0YWytSXc76IhGLfCwouZt9k2A>
    <xme:LEzZZ52BFl1b7Mz-fHszT-LLpKcdFj7gaducop1SZdzWepPMdyV99qOuWGrkgsgQ-
    0BsESjemfYFevtu>
X-ME-Received: <xmr:LEzZZwqWJHUHyzknYf_mgNwpoBl9YRaKk8PTdFmT5CABK70LDg5YGJmfqh1RPMKQ48HZaHyiyJgLLf96aiNU7jK-SBr17DrFt6-ms_dpDb7O_0jLCYAn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:LEzZZ2lKfAHXrz0vwjgQRiNOoOHTQztzNguf69jOuFbVQtcBIE1cvw>
    <xmx:LEzZZw3J1S9-W37m0EqfZ-XqORZ_PwZeiaRbnG4NJXkzTJh-CQCozw>
    <xmx:LEzZZ9vkio9DxMDX2tIq-peKxYW-_cj3nQ2ohQUYR1hOjp5ikBmHpA>
    <xmx:LEzZZ8XEQT51DSOz8WkOpYFJ1LShrUhQaQnixJBF5LEe7hqc9nQuxw>
    <xmx:LUzZZzRHGwDuvgaIpLBKUC2OqALTmLzlIRfwQL8ODnkiIfMbNhGHy4us>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 06:34:20 -0400 (EDT)
Message-ID: <1e770415-cd8a-47b7-944c-62ebacfc9557@fastmail.fm>
Date: Tue, 18 Mar 2025 11:34:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: remove unneeded atomic set in uring creation
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250318004152.3399104-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250318004152.3399104-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/25 01:41, Joanne Koong wrote:
> When the ring is allocated, it is kzalloc-ed. ring->queue_refs will
> already be initialized to 0 by default. It does not need to be
> atomically set to 0.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..f54d150330a9 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -239,7 +239,6 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  	ring->nr_queues = nr_queues;
>  	ring->fc = fc;
>  	ring->max_payload_sz = max_payload_size;
> -	atomic_set(&ring->queue_refs, 0);
>  
>  	spin_unlock(&fc->lock);
>  	return ring;

Thank you, LGTM. I don't remember why I had added that explicit
initialization.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

