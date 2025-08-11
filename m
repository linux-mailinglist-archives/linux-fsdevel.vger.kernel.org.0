Return-Path: <linux-fsdevel+bounces-57343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA27B209D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1001218A6F6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481632DC326;
	Mon, 11 Aug 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b="XZl4ihZK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQCKAswU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1F2D3EDC;
	Mon, 11 Aug 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918064; cv=none; b=hC/9d+Ed4vUPmFxxUFsR0E6VbwqqjfxEPHad3PkXydBGqpeT/VVMxfNO5msYAsX2XOHScXENE8baC2YdzP0AzLT3Y7M+ldswNhLS7BxQjkt0h0P0/2gPydBuum7OPU9EioylPPe2NFhFPlzDDihwPgl2Ez/51M41SmAyWrjdxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918064; c=relaxed/simple;
	bh=DPLqD3GGr96cRV7HKqFLj2qf/dhmL3aEJpnOdLbyf78=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CWSPlcn+CKd58Uen3WWY+pgJ0mD0JBS6dt9/8u7vHf1jMLWGSEreSoVnSbgOl253CE2x/Xhw6aLv/QRbw//EK6uWtsr3625/ZryPV+jBRncg9JQJEBzK0MM5KVvXENuI7Vrxe3JGmDJRF7HTf1BzhzXoemMpqvEolEL6Ap2vDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net; spf=pass smtp.mailfrom=bzzt.net; dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b=XZl4ihZK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQCKAswU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzzt.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 593B31D00093;
	Mon, 11 Aug 2025 09:14:21 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-12.internal (MEProxy); Mon, 11 Aug 2025 09:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bzzt.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754918061;
	 x=1755004461; bh=RGqZbPWNuOFgVl2x8ZENQQRp+k804OgLKfLNdr8vPUc=; b=
	XZl4ihZKzGNAn4imgaCNI9lV+gAE+C+n+6xDSi75QFoUph3fymabm6DhFIXeGxO1
	3UwkLCA2vBQObwwZE6rXxU404D23fJbsTPSbP9yGbDcMhTGLuzpgjFh1jKW12MNU
	SwMJEGotcXsjSKJHtu90FhvpDJ+7ylANePEqKsCfeEe61DvmRnmNi/ugIFnuQd/P
	ZLcjmwm2SELbfUcTt11wT5I0tNgLXfYokaWt7CjRm7iPV2uV9p2B2UKLTMsjjc2C
	gLpQ/Omr61FfVawe7NruHYztXC878Y0hHh4kaiXUSTG3v9N+Ox4N5mAjhLd2Jna+
	6Fm9PgsVRRdsWBqLzsYzhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754918061; x=
	1755004461; bh=RGqZbPWNuOFgVl2x8ZENQQRp+k804OgLKfLNdr8vPUc=; b=l
	QCKAswUPaGiNwxks850xeoFVJbjn0xI46Zyd9HHheohUe5z9I0dgzLEKf7YxhkMo
	LEKJW3kr+zDo0vpC6uxxmr9wKx5FnErrUUzSLx/SJuyMTLAJhaOsFlqXS+Xq+OOb
	Dso5MQ39RjlPXfpsBrfn6A26bk1tvjW893/yF2aHAshirwxFEE5fmIWINso7P2Qs
	HoVB13QYrL9Jxbqn6IKX2HNVw0+xMo8kN1ZByR0ZgkcVbPeWyu6V4mHTftelk9jK
	BRJz3jsSH9vmnlbcCr/LDV1UEYooopF3t8efHmmpFLcGvT1d/FTuhF2sm0pQXTlD
	Cblk8qX6XXgykirFWVgbA==
X-ME-Sender: <xms:rOyZaFQarlfNFgoKw07xdvZT3yqe0tR9w0gfW8HtLKYHM0Kwp0zbiw>
    <xme:rOyZaOzJLiYqB9OpvW33KeKk-G9OXNjsZ1zYMWPJoWejvHS1fDxtv1-5LVetDAnzn
    TOVk7BIDt0_wluFP1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhho
    uhhtucfgnhhgvghlvghnfdcuoegrrhhnohhuthessgiiiihtrdhnvghtqeenucggtffrrg
    htthgvrhhnpeefkeffgfekvefhjeettdelueelfffgtdevfeeftdefveejieeuheehheeh
    vefhveenucffohhmrghinhepvghnghgvlhgvnhdrvghunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhhouhhtsegsiiiithdrnhgvthdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsh
    hmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopegtthesfhhlhihi
    nhhgtghirhgtuhhsrdhiohdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhihrghnsehlrghhfhgrrdighiiipdhrtghpthhtoheprghkphhmsehlihhnuhigqd
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmrgigihhmihhlihgrnhesmhgs
    ohhstghhrdhmvgdprhgtphhtthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rOyZaKtBin8L3MIfTfYFtlhNFH2YI58KgNEnlrngOpw3QENt80mZ1A>
    <xmx:rOyZaM96b9KAZUw_tpXAkeQukwXczQHMqOMDltACQnrTvMe68QnyEg>
    <xmx:rOyZaIY3ZxjddhXV3JoZ1GapBbwRBi3LOa1Toba1bZfIHG--mnqe3A>
    <xmx:rOyZaKpV1EoBGVsP5aAhkPmqZ8y4QgAyP8KZAr6V58mLiofcBfu34w>
    <xmx:reyZaIMdwIDo1nl5FAQnOn3laBWP7fLUMTk6gbmYgR0_FPJvYx-DeF4x>
Feedback-ID: i8a1146c4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3F2AA18C0066; Mon, 11 Aug 2025 09:14:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALpogynE4SFc
Date: Mon, 11 Aug 2025 15:13:59 +0200
From: "Arnout Engelen" <arnout@bzzt.net>
To: "Dominique Martinet" <asmadeus@codewreck.org>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "David Howells" <dhowells@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Maximilian Bosch" <maximilian@mbosch.me>, "Ryan Lahfa" <ryan@lahfa.xyz>,
 "Christian Theune" <ct@flyingcircus.io>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <21fceb38-4c0d-4183-a929-c824a3cb46a9@app.fastmail.com>
In-Reply-To: <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org>
References: <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
 <20250811-iot_iter_folio-v1-2-d9c223adf93c@codewreck.org>
Subject: Re: [PATCH 2/2] iov_iter: iov_folioq_get_pages: don't leave empty slot behind
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Great! I can confirm this indeed fixes my reproducer, and the iov_iter
now looks sensible in gdb as far as I can judge.

Tested-by: Arnout Engelen <arnout@bzzt.net>

On Mon, Aug 11, 2025, at 09:39, Dominique Martinet via B4 Relay wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> After advancing into a folioq it makes more sense to point to the next
> slot than at the end of the current slot.
> This should not be needed for correctness, but this also happens to
> "fix" the 9p bug with iterate_folioq() not copying properly.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> lib/iov_iter.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9193f952f49945297479483755d68a34c6d4ffe..65c05134ab934e1e0bf5d010fff22983bfe9c680 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1032,9 +1032,6 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
> maxpages--;
> }
>  
> - if (maxpages == 0 || extracted >= maxsize)
> - break;
> -
> if (iov_offset >= fsize) {
> iov_offset = 0;
> slot++;
> @@ -1043,6 +1040,9 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
> slot = 0;
> }
> }
> +
> + if (maxpages == 0 || extracted >= maxsize)
> + break;
> }
>  
> iter->count = count;
> 
> -- 
> 2.50.1
> 
> 
> 

-- 
Arnout Engelen
Engelen Open Source
https://engelen.eu

