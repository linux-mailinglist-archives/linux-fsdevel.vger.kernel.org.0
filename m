Return-Path: <linux-fsdevel+bounces-40096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22CAA1BEBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AAE16451E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC01E98E7;
	Fri, 24 Jan 2025 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="SplTDQ8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9JeC6oB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975261E98E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759486; cv=none; b=J0KJ//isrFcOPC/Mg4+vrl0y4X9ZPfhQv4GcyUmGAthr6NrQLvFeu+e0n68YO/RSRSoLisccRl618u9JQ2cSpV98UZVUnZpRtDJW6pc73JE3GtjFqZuvwuSs3UakLIeMZ0ovZWB83SETtj3ohC+xIQuaYuaZUF8vJPrZEzqgVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759486; c=relaxed/simple;
	bh=XR7wNW6hezRrTrj8yYN8/dU9N0wzQWocXraltbXykQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGW4d1iZYWlb7bxG6dzaiuBQt4yDP9vbONtDjh/GIpSc7hmostni52hTaMslLwh4rq+kcbLAngF5t8b3ThINme3HCcEzVtq1WiCLWfvxPOPVu/iExTfe0y2wHhjol9dmVnO1U90LDfQ3u1rxypFgBRyYPNrlwp3Iomd37goXPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=SplTDQ8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9JeC6oB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CC8125401B9;
	Fri, 24 Jan 2025 17:58:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 24 Jan 2025 17:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737759483;
	 x=1737845883; bh=bWIrzMRQKYeRQMlS5l0zKNj311nHr9KHFyJSZIeq1GQ=; b=
	SplTDQ8pGBy2JA2XHPFrj+bxaAYzegwkDCdhJ0sGI0gtgGttXz95WfiTI+OWVF+U
	camugDOo+I8NoHd0hJhbSF3HVjOBE25yRTYzsB7ueYp1U5OKS/lstXwbC1x1I5u2
	1VBMV/uPSKCdigNvhtDr8NON0VEmG1VoCoEwkM4nuCl5Z/eP9nLBfpgsiiyrn0RG
	VbaCNMqYZyrtKVwIrW9AbjU3EBsYV3rrk/g7VFX06+uXWTWYPJRNZc/Cg9v+DZp7
	aoFoNrF3SYcFWBoAFNns4i4o3AmbKbrt+e20APuUSV1klm/ouer3R3rbgc8/zK6L
	1buOcGGMWg+vA7UQHnQxZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737759483; x=
	1737845883; bh=bWIrzMRQKYeRQMlS5l0zKNj311nHr9KHFyJSZIeq1GQ=; b=H
	9JeC6oBuiPyl1hh3kmvY12JkWwaW7taG9WptXEWZEMqaEIYXf8I4RZPIMzCMJZU6
	4c0IBKKm3KiWB2uFkoNgQOeBIbouYQcsJkmZDhK09chkTFAbzqA50Lquywsa6p6S
	1IWVYGn0pUfevUDnVznVI7A3avFsNhWdxIjT4eYc2gwuD1wctHPENJSC6VT398c0
	/IT1hux2dMhEwCByD04GGaSxEfLiCtWvtjMD9CYFNyqnTbvh41ugT+KOkfFJWt1x
	rIyiny7w7dmBZUIb6cvrDrn+7kcsIYpjgEgiHfiaocgCaFcwEUfRbD/9P3h9i1f8
	umytW6AaYIhFx+gcn7QXQ==
X-ME-Sender: <xms:-hqUZ0UKQAihhULo3CIk6fm_Z-q5xKN9cuAWLtlXI6Ko6KMDqsf_Wg>
    <xme:-hqUZ4l5EKLTpzCB0F3HxkV6lGnIy4iE2QWRTjkq2aH-0_j0GyFYzItHnPoUm5XUJ
    LYrvZrIIxiEHZFf>
X-ME-Received: <xmr:-hqUZ4Yt4Z1QQZCpHRU5_t4t3Vj6qTkR4BLwCQuwAow20NIdjbLnYJ-T82kvpKXIr6HD0ood4sNm_5bUI12XPh1-a8I7hLmxfL1EPe1kXR3S2rVn8dsD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:-hqUZzUyMvj12L62XlGOs_7lPlMzmKltPibD0143qB1aYp6n7WRy4g>
    <xmx:-hqUZ-nCmkF0WqyuIY8eW3eVCR4JhrSRETplaS8LSKR16PA8LXC7yA>
    <xmx:-hqUZ4fvtDd10moswH-pG2HJ_HDnP4aoK52oIB__350G1pnV4oLvGw>
    <xmx:-hqUZwHYTpxlyXMJXYrzsVdaLq57fVLaIjAarYGiVlTMtNp-azu73g>
    <xmx:-xqUZ_AFaUqq2zWDn8o9mzL3ubO-coMu2wlxJjWb87SySsZ1vUBr0cNJ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 17:58:01 -0500 (EST)
Message-ID: <f9e180db-59a1-4652-bf1b-2eacb0af5128@fastmail.fm>
Date: Fri, 24 Jan 2025 23:58:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: optimize over-io-uring request expiration check
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250123235251.1139078-1-joannelkoong@gmail.com>
 <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm>
 <e7dd6a74-ddd3-475a-ab31-f69763aec8ea@fastmail.fm>
 <CAJnrk1amoDyenJQcDbW_dcsHVGNY-LdhrRO=3=VK+tHWx4LxbA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1amoDyenJQcDbW_dcsHVGNY-LdhrRO=3=VK+tHWx4LxbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/24/25 23:05, Joanne Koong wrote:
> On Fri, Jan 24, 2025 at 10:22 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Joanne,
>>
>> On 1/24/25 12:30, Bernd Schubert wrote:
>>> Hmm, would only need to check head? Oh I see it, we need to use
>>> list_move_tail().
>>
>>
>> how about the attached updated patch, which uses
>> list_first_entry_or_null()? It also changes from list_move()
>> to list_move_tail() so that oldest entry is always on top.
>> I didn't give it any testing, though.
> 
> Woah that's cool, I didn't know you could send attachments over the
> mailing list.
> Ah I didn't realize list_move doesn't already by default add to the
> tail of the list - thanks for catching that, yes those should be
> list_move_tail() then.
> 
> In t he attached patch, I think we still need the original
> ent_list_request_expired() logic:
> 
> static bool ent_list_request_expired(struct fuse_conn *fc, struct
> list_head *list)
> {
>     struct fuse_ring_ent *ent;
>     struct fuse_req *req;
> 
>     list_for_each_entry(ent, list, list) {
>     req = ent->fuse_req;
>     if (req)
>         return time_is_before_jiffies(req->create_time +
>                     fc->timeout.req_timeout);
>     }
> 
>     return false;
> }

Could you explain why? That would be super expensive if lists
have many entries? Due to fg and bg queues it might not be
perfectly ordered, but that it actually also true for
fuse_req_queue and also without io-uring. Server might process
requests in different order, so ent_commit_queue might also not
be perfectly sorted. But then I'm not even sure if we need to
process that queue, as it has entries that are already processed - at
best that would catch fuse client/kernel bugs.
Though, if there is some kind if req processing issue, either
everything times out, or the head will eventually get the older
requests. So I don't understand why would need to go over all entries.

> 
> and we can't assume req is non-NULL. For entries that have been
> committed, their ->req is set to NULL but they are still on the
> ent_commit_queue.

Yeah sorry, right, though I wonder if we can just avoid checking
that queue.


Thanks,
Bernd

