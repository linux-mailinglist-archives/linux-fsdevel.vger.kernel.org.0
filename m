Return-Path: <linux-fsdevel+bounces-71489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2071CC4F12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75903043572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746333D6E3;
	Tue, 16 Dec 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Q0cOxPIX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1oMUrLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F302D9492;
	Tue, 16 Dec 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910996; cv=none; b=jdhQj4PVCsF86KhWCdNq7L8Pj2Ha0nbHZRrEISNaJPDbHwmUu14hIC2Xtlch924/v6qakRrjhfx34984desCiOgwSm4ZKvVE08wHxk57//SrAqr5v+2S2gsgdpLTdJVYRIAjqUmZCI/yJbX6XNNVdyVd1mLrNLU0EXM9NHJnaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910996; c=relaxed/simple;
	bh=mYPvR2xAb1M03nQuigCf50b+uBYYJ/c65PqUwnCqNAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQUNc3MxtQ9HEfENBFq5ydZxg9kQflhGXI64cXqwUz+vtvpFG2ccw5Dvsi7MXy/73pWb3x97hsshOy3gQ/UpxYpugiw4/gbs+PLtmPqXCPdTTn1SGzA414FZUT9jxGTrVGwCQPUyGBHTnO3PoSpeNDgUBp2TjODY4NXRw39ydNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Q0cOxPIX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1oMUrLe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FD0C1D000A4;
	Tue, 16 Dec 2025 13:49:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 16 Dec 2025 13:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765910993;
	 x=1765997393; bh=PpOnE8P0Vzppr+wIOUrmwa9fW7qicTY71UnaaE2+FZs=; b=
	Q0cOxPIXvYlcn83tlbPhl+d16fFzKQjyrRPacGrxvyCOFoSEjRs3d3QOtegkKgAb
	QV5twYwStu0R9xEw5OLJo6t6u56Apmfh87ONRHfCuS+gmlcrXvLqEE8I/u12nLyh
	isTPmXf4sE+bARovKMP+En5ljVo6Piug88CK9oP9dgYx6AQYDenNCQKx+Z5pH5OJ
	AdGgmJPr4PSL3wSaDrgEDF2BSk36Qsn6MdIUXxV7UVywKnpVY1wagqsb0r4o9Nq+
	SsY5z1RXiIMpdF94P64DEhqfuASTiW45LyvgToSQeAl7/DVDZyu94xQKwpoMFUXE
	/1YmuVUpI0H8tG94O7p+jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765910993; x=
	1765997393; bh=PpOnE8P0Vzppr+wIOUrmwa9fW7qicTY71UnaaE2+FZs=; b=Q
	1oMUrLeWBS3gu7m8Dn3kwjNwQ1JKmQWCKWi4LRyhVwLPmU/391MvzRZ1WpFia8Ew
	85mKolZR7xKsOgWzv82FVWG8wbT9X1Ciu6TyElp9HRvCrZJo1wUzGmuyKTWaoHcG
	N0yB/lZA9k/gMFFX96DC8iucfcjygwqvACjYlPUQwFy0SyF+iFC17TAPWiVVVf1r
	4PumJ96WbTP8O+jWGxxLUIh5Ep1SoAJXJz7H9G1SPayL+83bR/n4nPzKJF9AAyyA
	3oWFgRVIUjhRXkP1Ziz/DwI/O0+DrdXV5XvlJleKXyjcD5tNyTVyiZX2lIFLMkcn
	ImL5LFkI6r2WXWTF9olaw==
X-ME-Sender: <xms:0KlBaTywzqYV8HC5bfDpWQ4C3Lc7FLpSK81LmgkIusvye4x97U49Rg>
    <xme:0KlBac0uVWrH7erYEEz7KNGVCQWBhTfsgisUKQ2SiFi0zSkr5IVJMDRGIFPV5jx2r
    0-GFWr1XdMOAWTLwSHmCCV7Llaw0geU7t0ILD_7gaFXalG3J5M>
X-ME-Received: <xmr:0KlBacmx1_-aRATfn2su4PMDTilehM76ld_qJf_SUfXuZn1iTYYO0wbketNrxcBifD6nM2bqzVoGEMrQn3iIx9KZ0bZ2REBBR0TfWhBgAuJaxALWzNY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghfihhnrghskhgrrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtoheprghmihhr
    jeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggunh
    drtghomhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohephhgsihhrthhhvghlmhgvrhesuggunhdrtghomhdprhgtphhtthhopehktghhvghnse
    guughnrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:0KlBaT8a3BZVwSv6j2cTd5OP-XfTY6LMa6pMaFUEb-rW2x-vIkbL4A>
    <xmx:0KlBaaLU-Bih-VOVBcygqZ4SZQ8vickg1xpEfGAIuyIgQ5ipmgQWtA>
    <xmx:0KlBaYiTvgSMtSAeJVhFx5Q4h-9m5o4RvwPpzbeCRHLp9D5CCmjbEA>
    <xmx:0KlBaW8iAaxX47miqSGMwXlkaV4JM3mR4rhRXBIPX6WVMZrXKGsHuQ>
    <xmx:0alBaVMMgvRM6lqQED0x_UY5exN-w1J1y1ykj6EWcjvfIpOzyMY7-VIo>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 13:49:50 -0500 (EST)
Message-ID: <b59c5361-c800-4157-89e9-36fb3faaba50@bsbernd.com>
Date: Tue, 16 Dec 2025 19:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
To: Askar Safin <safinaskar@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: amir73il@gmail.com, bschubert@ddn.com, djwong@kernel.org,
 hbirthelmer@ddn.com, kchen@ddn.com, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mharvey@jumptrading.com, miklos@szeredi.hu
References: <20251212181254.59365-1-luis@igalia.com>
 <20251214170224.2574100-1-safinaskar@gmail.com> <87cy4g2bih.fsf@wotan.olymp>
 <CAPnZJGBtHf3p=R+0uxNuK42s5wteMi01Fs+0yhW3gUDMF0PC6w@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAPnZJGBtHf3p=R+0uxNuK42s5wteMi01Fs+0yhW3gUDMF0PC6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/16/25 01:33, Askar Safin wrote:
> On Mon, Dec 15, 2025 at 3:08 PM Luis Henriques <luis@igalia.com> wrote:
>> No, this won't fix that.  This patchset is just an attempt to be a step
>> closer to be able to restart a FUSE server.  But other things will be
>> needed (including changes in the user-space server).
> 
> So, fix for fuse+suspend is planned?

I have an idea about this, but this is not a one-liner and might not
work either. The hard part is wait_event() in request_wait_answer().
Probably also needs libfuse support, because libraries might complain
when they eventually reply, but the request is not there anymore. We can
work on this during my x-mas holidays (feel free to ping from next week
on), but please avoid posting about this in unrelated threads.


Thanks,
Bernd

