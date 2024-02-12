Return-Path: <linux-fsdevel+bounces-11115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA51851347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25B91C22731
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6613A1DF;
	Mon, 12 Feb 2024 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="ZBDWwSTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFUGLtMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766783A1D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739958; cv=none; b=SeZiWI5F424hC106W03hzYlR1dQ1+0rtJIo8I+WdYK/TGFSo+bT/qnLT4Te99M8fakZHNp9PwIM8jahr40U1LdBLwGavkcGNfEPANH32mr6pZoV4tr+WG8wl58PGITMTjRIAgUha4Qg3O+dMLaBIZckBsGAzamKgadB0q89NLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739958; c=relaxed/simple;
	bh=0ZX6DE81J1rW1U7lfq9Dud7O+0BZb2o/cGUBrEiaVsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dutjdbaMdR4TzbnIcDW2s2lsMl1HwdTVvf/0NIadK57x5rAg5b4oPfJGN/G9IuHZqiNQrMDK6DeLVTeKUSZt7hkrHIgPpUBRPl3gRkCqflIN8SJtLVGhRnjkJsRfAoowTHkb9KTfzW7YvLcLbgv9VLKU8eGAGEF5eUS/H9vr5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=ZBDWwSTm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFUGLtMu; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 5DC4B5C0072;
	Mon, 12 Feb 2024 07:12:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 12 Feb 2024 07:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1707739955;
	 x=1707826355; bh=4Dnxf/U/mm2/ajmLdV8om6u4s7XVgmKHgQUVPt9wEMQ=; b=
	ZBDWwSTmentoyfyZWTBlU15ZKghcNU6f3IRYwuZNpR4zOO3gmKeas8MhiOYWCsTA
	ijunGQaH101a0Y9P0IK0onzqlIkGjcfjpYsBZzAD5et4Kexl5YDJcCyEnRpo/iI4
	2rIiXXhXRByAazHTUW8+SoRjrpZqtY2aqzqZI3JgB+y1AjomipINnNSiy/ATrEuu
	Hxd2DaugY4mgmbeWmPsdneiqLYlVYQo6jS1nssYsjbbaU8cMgD/RUhTuzr59f8gi
	N14Z5My/0ICOENBNfkSOddINLu5kEbjq5rLAQ44xCh8tFoTz+6O5pWM4yU7AePfW
	2UAaThKHSxJNWkozmHvHAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707739955; x=
	1707826355; bh=4Dnxf/U/mm2/ajmLdV8om6u4s7XVgmKHgQUVPt9wEMQ=; b=Q
	FUGLtMub1FqYSDLR/gtzXyOfNxZQ4VaCa3JmsDevuqwT9oowwYyYLkGwh3w0NjNQ
	0YblBTAOHaC9Jcy0jj9+d90oQEXx+cMyANYBrt52n7J/uYuL+cdFDAN7yNlYcLdd
	xgnHoDimg3uOmvplIBRqxcsZ23/6ppc7eWGXP/gx6rRKvHs227CKrmYJ6QWkM1v8
	ZG4cdIHsioO7igHsiN4cDVJ8iLC/edc0jObC5GpkEAdJFFfJQ18LrkhVSO64vJJd
	C24DMHhnglX5Kma0rrXc70m86Vndi3sogSmEI9Wvz8JT8DxOvgu8FKjTjoTwx9Sp
	SdKAIqciFQaFvaAiMF0oA==
X-ME-Sender: <xms:MwvKZTMGWRs44s-C-4QFqiki1-1U0cMqvV1Yti7610TR-qxkJfFZrg>
    <xme:MwvKZd-Rc9mgJZ2AhdpdN06Ng1wC831VnJqir-2lhxgIl6Q-0bDYp9GF_GDA1d6tL
    VfPOjPKhWyZ>
X-ME-Received: <xmr:MwvKZSTONz4OIDWMUpVdn6hiYE0U4bqZn6dg9scuefGJb8eGABenVYDGYwxA4sUsZAcvAQ6RgHiD8fmEX2nWntCQsucdLbC1SbTmHvs2AROvRycCR-7pUzJr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepje
    euueetffeugeejheekteeiudefhedvheetjedtjeetleelheekgfeffeeutdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:MwvKZXuJCicgmUdmWyaKy72ZWvXnoxhFB29hlK6Yu1N4HWJKXhoN9A>
    <xmx:MwvKZbfPqLr7vcSw8pELkKkeIYZTqh14n0i_He4xWthj9kSwIwVmow>
    <xmx:MwvKZT13GdS7sagzlgFhk9Wc9ih35WNKEnZd6rJzGwJ3GgEaYQ73rQ>
    <xmx:MwvKZbkLu_28HVStgS7x4jHjeKG3rsFRPX7k3jcYurtquMOnCiGGow>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 07:12:33 -0500 (EST)
Message-ID: <a312df58-4f52-44fe-8eec-92d34aaa46f2@themaw.net>
Date: Mon, 12 Feb 2024 20:12:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
To: Damien Le Moal <dlemoal@kernel.org>, Bill O'Donnell
 <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
 <3252c311-8f8f-4e73-8e4a-92bc6daebc7b@themaw.net>
 <7cf58fb0-b13c-473c-b31c-864f0cac3754@kernel.org>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <7cf58fb0-b13c-473c-b31c-864f0cac3754@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 09:13, Damien Le Moal wrote:
> On 2/11/24 12:36, Ian Kent wrote:
>>>> +static void zonefs_free_fc(struct fs_context *fc)
>>>> +{
>>>> +	struct zonefs_context *ctx = fc->fs_private;
>>> I do not think you need this variable.
>> That's a fair comment but it says fs_private contains the fs context
>>
>> for the casual reader.
>>
>>>> +
>>>> +	kfree(ctx);
>>> Is it safe to not set fc->fs_private to NULL ?
>> I think it's been safe to call kfree() with a NULL argument for ages.
> That I know, which is why I asked if *not* setting fc->fs_private to NULL after
> the kfree is safe. Because if another call to kfree for that pointer is done, we
> will endup with a double free oops. But as long as the mount API guarantees that
> it will not happen, then OK.

Interesting point, TBH I hadn't thought about it.


Given that, as far as I have seen, VFS struct private fields leave the

setting and freeing of them to the file system so I assumed that, seeing

this done in other mount api implementations, including ones written by

the mount api author, it was the same as other VFS cases.


But it's not too hard to check.


Ian

>
>>
>> This could be done but so far the convention with mount api code
>>
>> appears to have been to add the local variable which I thought was for
>> descriptive purposes but it could just be the result of cut and pastes.
> Keeping the variable is fine. After all, that is not the fast path :)
>
>

