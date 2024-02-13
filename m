Return-Path: <linux-fsdevel+bounces-11501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29349854026
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D451128AF4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977163106;
	Tue, 13 Feb 2024 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Hp8NSoaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmviO892"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18F62A02
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867078; cv=none; b=EeC3mxSIOFS924LBJbcRjHQY5FYgmy78YxJsulXtKic+WE+xdHD6xE9QZaqhEx5xR5TwL1rm7j/wIXR4bmAQeg88HGsLH+WEvPK5XNjoBN7LnULlP7TPwpgNzmGr1xkK5/Bb5AlYe0ahIoreypghwPqPCBDre0VuWcqcyciVyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867078; c=relaxed/simple;
	bh=CDygk2YLhPJ4hDGk8tIH83QZl7FYl/rLoX8FdLhwqqA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rtT6LfdddadUXxqJjUu7k6E9kusyhBbaWCvMpCF9vh9eCgw0A1WhXRmBimvLTkzqfaee99HhSILhb5JqENvdGtTdP5No4Vi/Ef+xmwhKd//F42SxteTnVPo3m5vLmJD5H7/TjoLB/XPEAamGG+BmG4v5ZyXXZYqmiWJzs1eCHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Hp8NSoaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmviO892; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5A7C23200A0D;
	Tue, 13 Feb 2024 18:31:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 13 Feb 2024 18:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707867074;
	 x=1707953474; bh=IE0TSo8pVhK2UMJPVhIn83RQC1Y5fqT6+U5+UDDdAxA=; b=
	Hp8NSoaMDXxVlFIq77cWxSjqEbbpe7rYTAL8v9npteh3Sroi2bL6rXjADJjLgXz8
	C08z8osRkOvR7Ov02ICUwPCTHq8Y/X9EGs+41WYwtGoG7DG2LiQ74PwTQJ77YYyI
	X7aOxAw0qOwb1pMPhY5LO0ZvrJivqUVVJlNcvCIyTYrm06lUXoOcZBtKNv0idU8b
	GYRJs4IGtzRuXLFtu4k+fDZYvCe1FWS6cRKEwaXCKMvYqnZFiUvvVI4wLNzCAKRy
	zco/Vq6KqNcwqgqqc3DP+hHo+VR8DxnuRNPN44TBfrEEeu1qrVrHLUI6o7xGJpsH
	sAwoWj7c4t1kf2SX5dZKWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707867074; x=
	1707953474; bh=IE0TSo8pVhK2UMJPVhIn83RQC1Y5fqT6+U5+UDDdAxA=; b=j
	mviO8923CDNlY7sRF8oyWZ4lBRgf5Y8ZnmDuXHmzgDyyK/OFEXmrEQ+o7lUPz0t6
	3FdYy5rBEW9QQWTFfC0RFpKD8di+HXdhsJaCnxnOpgTY638OsX38W7jIyfvC6i/1
	fJo0JVC4jd+hTCaMfpHekptmNyoSmO4lKgJ1FSSG9QbQ543/YCBRySoM1a81SqAf
	AnoqdDw2xXTpyz9Zdp50M/7Lc5fU2RAtwV+5JUbk+swnOzkapqhpHiLoMsL02dxm
	OZpZhMZPbaMb1EdeQQQjaT0VD3XOHK7FOB2PcXfGTdG/1pAsswpZAmhd+Gu8Gp+T
	EZ7lcAaLZ805BBIeuDAjQ==
X-ME-Sender: <xms:wvvLZX4WqzRlj77Tha233rfnGX187paM8VmjSl4-NeqUx58esTB6PA>
    <xme:wvvLZc7jK2tH1IxZ_DHm-XaKiboWF_8o9rd-N-VjxFL8MC3jJ505yEKsguuog9psf
    dqVAkcm70_r>
X-ME-Received: <xmr:wvvLZedqo60Zy0nZAic2HOPlwKiJAkqiZjUvR2No6vFFs3h_qfICk-xL8dg_GSPddXt7y8MjBRc6JcSa8hy4aForMm550jkNXoVqP1HUwotJYtvyQDeD1N8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuhffvfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepff
    ekieffudefuefgtdehkeegjeelteeftedujeeiueeikeejtedvieehjedujeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:wvvLZYJ6d-Qk3W5NUhvIBeZRJnrwKsvbRKhA5iHtbqcKoOgVewLFZg>
    <xmx:wvvLZbK5C4eJ7XIcVUWkBly88OB9FVKGaHs_lJMMfpWAyn7_CCsG4w>
    <xmx:wvvLZRyZ0hWRM4BF80t7lzkC5pHLmjvskto7R0fU-UyFI0MsN4V1nA>
    <xmx:wvvLZdxdJvYu91_WNji7EcSMMpSo_KmUwF9XUzDBhcHBmmAGj1oTQg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 18:31:13 -0500 (EST)
Message-ID: <341e9b40-17b9-4607-8bac-693980c1ab75@themaw.net>
Date: Wed, 14 Feb 2024 07:31:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
From: Ian Kent <raven@themaw.net>
To: Damien Le Moal <dlemoal@kernel.org>, Bill O'Donnell
 <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
 <3252c311-8f8f-4e73-8e4a-92bc6daebc7b@themaw.net>
 <7cf58fb0-b13c-473c-b31c-864f0cac3754@kernel.org>
 <a312df58-4f52-44fe-8eec-92d34aaa46f2@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <a312df58-4f52-44fe-8eec-92d34aaa46f2@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/24 20:12, Ian Kent wrote:
> On 12/2/24 09:13, Damien Le Moal wrote:
>> On 2/11/24 12:36, Ian Kent wrote:
>>>>> +static void zonefs_free_fc(struct fs_context *fc)
>>>>> +{
>>>>> +    struct zonefs_context *ctx = fc->fs_private;
>>>> I do not think you need this variable.
>>> That's a fair comment but it says fs_private contains the fs context
>>>
>>> for the casual reader.
>>>
>>>>> +
>>>>> +    kfree(ctx);
>>>> Is it safe to not set fc->fs_private to NULL ?
>>> I think it's been safe to call kfree() with a NULL argument for ages.
>> That I know, which is why I asked if *not* setting fc->fs_private to 
>> NULL after
>> the kfree is safe. Because if another call to kfree for that pointer 
>> is done, we
>> will endup with a double free oops. But as long as the mount API 
>> guarantees that
>> it will not happen, then OK.
>
> Interesting point, TBH I hadn't thought about it.
>
>
> Given that, as far as I have seen, VFS struct private fields leave the
>
> setting and freeing of them to the file system so I assumed that, seeing
>
> this done in other mount api implementations, including ones written by
>
> the mount api author, it was the same as other VFS cases.
>
>
> But it's not too hard to check.

As I thought, the context private data field is delegated to the file 
system.

The usage here is as expected by the VFS.


Ian

>
>
> Ian
>
>>
>>>
>>> This could be done but so far the convention with mount api code
>>>
>>> appears to have been to add the local variable which I thought was for
>>> descriptive purposes but it could just be the result of cut and pastes.
>> Keeping the variable is fine. After all, that is not the fast path :)
>>
>>
>

