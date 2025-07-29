Return-Path: <linux-fsdevel+bounces-56271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB375B1533E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DDA18A3C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FB23BF91;
	Tue, 29 Jul 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="TPLipFB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB7253F13
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815928; cv=none; b=uk/EeAn9EOPXVw2LFOYAisX9y3KhFA5+HikrFoZ8Hbm1uYWxVtdJ99Apl/7ZoyXazUy41wYzCxG/667pNGUpRIvBWVrBkUeuzw0Xu3u2oqVXDjhtZAwLTNdHYowCCDKoir091fFUlrkWXR1MPixdMYhv/I8uzyPJX17YL8DRvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815928; c=relaxed/simple;
	bh=QbN0SH9yYbFq+vTe8Xz7LYyYtBtdP4A/96NTHVHAgTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw8f4C0LssuHgr43+I0EcIALZ7v5Saq1U11Nl8UpcyBhGSxfDTAdQcrtxkEjMJ0lqhhif6CDga6/CrS9xyRMcZGSQyzHkKBbQ1Uu35wr/1c15+Ih5sK2mm5rYGtcy8xBAvPjJEbEokoEuJsXLWZ/qi1Wc86kdo+QoetT2fr28X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=fail (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=TPLipFB5 reason="signature verification failed"; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id CvqqbLErys1EnPAX; Tue, 29 Jul 2025 15:01:28 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=f4fX58kUCT74DiR/RcJY5gzNqJ7+c0REb9/ApE2kcEo=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Content-Language:Subject:MIME-Version:Date:Message-ID; b=TPLipFB5lCvkKbuDgQgp
	Dxmc5Oul5VzC06gsLaCFhqLgF382vkMUe/toqLAdKbO/mXNktw4b5vRoI0fggvQNAu+yX8unWewAn
	HUKNDbQTRvUmsV/5N/SboOpS6yYa3SmwlsBCFbllikCzYt7LZUI7Sf4P6NBQo+ZkiiopgiZhsQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14113945; Tue, 29 Jul 2025 15:01:28 -0400
Message-ID: <17323677-08b1-46c3-90a8-5418d0bde9fe@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Tue, 29 Jul 2025 15:01:28 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
To: Matthew Wilcox <willy@infradead.org>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
 <aIkVHBsC6M5ZHGzQ@casper.infradead.org>
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <aIkVHBsC6M5ZHGzQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1753815688
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1640
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1753815688-1cf43947df81fe0001-kl68QG

On 7/29/25 14:38, Matthew Wilcox wrote:
> On Tue, Jul 29, 2025 at 12:13:42PM -0400, Tony Battersby wrote:
>> Improve writeback performance to RAID-4/5/6 by aligning writes to stri=
pe
>> boundaries.  This relies on io_opt being set to the stripe size (or
>> a multiple) when BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE is set.
> When you say "aligning writes to stripe boundaries", what you actually
> seem to be doing here is sending writes down once we hit a write stripe
> boundary, instead of accumulating writes that cross stripe boundaries.
> Do I understand correctly?
>
> If so, the performance gain we see here is presumably from the DM/MD
> driver not having to split bios that cross boundaries?
>
> Further, wouldn't it be simpler to just put a new condition in
> iomap_can_add_to_ioend() rather than turning iomap_add_to_ioend()
> into a nested loop?
>
Yes, you understand correctly.=C2=A0 The test creates a number of sequent=
ial
writes, and this patch cuts the stream of sequential bios on the stripe
boundaries rather than letting the bios span stripes, so that MD doesn't
have to do extra work for writes that cross the boundary.=C2=A0 I am actu=
ally
working on an out-of-tree RAID driver that benefits hugely from this
because it doesn't have the complexity of the MD caching layer.=C2=A0 But
benchmarks showed that MD benefited from it=C2=A0 (slightly) also, so I
figured it was worth submitting.

The problem with using iomap_can_add_to_ioend() is that it returns
true/false, whereas sometimes it is necessary to add some of the folio
to the current bio and the rest to a new bio.

Tony Battersby
Cybernetics



