Return-Path: <linux-fsdevel+bounces-1607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8F7DC431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E2928156C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2390D10F1;
	Tue, 31 Oct 2023 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="G/kpKiSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXcbZv4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCDEC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 02:12:46 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A3E9;
	Mon, 30 Oct 2023 19:12:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 529D35C01FC;
	Mon, 30 Oct 2023 22:12:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 30 Oct 2023 22:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698718361; x=1698804761; bh=6tJrD6I0LgEASeE3RKgWSmG2zLolRjfGkvx
	4l2vPd9o=; b=G/kpKiSEReG1HHwkple9n/KAY7C25UrqF1M67aXqifnIlektVqX
	qY4bYsVQYUnoGTGoFLf02r52v49s0Fd5rkcCCW+JDMK/Jh4n/xB4lfvDOIbOXv1t
	qLdd+7X+8xQFp9g/m0bTTpo98/dACY7jEWyZ78Yuj/OHv5Tm+hrrFk44da8RYi2l
	4goKbHvw3ebVnnAN/4XZJ4tFdDeE+ErpsKLu28PfDgH41ZVCcV/cTgQDtUzU2HHr
	wcV0iNZT2BLM+VWBs3sBZs6WgiKU3aIkdvvnIdm5MIh23xuyWbVQozIW9G+3Qhkx
	223LuOVktPIeniT48iNRLSMYjC01XizSlSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698718361; x=1698804761; bh=6tJrD6I0LgEASeE3RKgWSmG2zLolRjfGkvx
	4l2vPd9o=; b=XXcbZv4Jnx6sufRLavi7UbK80zjEhBvzbsJQ38D3jEmAVUK2Z1L
	v+3ZHsbveISHe/To/Spso0VM+Rs+nSbnZm+AdzTpWBTYme815QJzMItOf2G9H0dK
	+alyDXdoh0qvM9i/etU6bPrVOrcp0Wpv8sKtOPNyKQ6ejQqt4UzbJQl6Iq3ZVA4a
	dPP6Ldt8+uV7/V3BOqV+NQH07izaQamrvHgmokjNGjtDfgTtZs7ioqHRqg4OMrQA
	4lGq6h5S7M7/Y3NCPko3//Jj+30tfkOT43mfly5u7ZuzY5qWODcyzRIkFvmlkXg8
	fEXpLlr1QxU6G2ucPO40jcNM3lMaC+ymPAg==
X-ME-Sender: <xms:mWJAZVoxHoKmFOfkc10bPjyExq7GF5FmhCrsI1IuM8A7KK9et-1Fsw>
    <xme:mWJAZXr7H1rdKDmLVTHPybGZ9TxLbvbToocZE34q_NRRg0YJL-jQVJsaxjMZjBTq6
    ks_jxn4Jncp>
X-ME-Received: <xmr:mWJAZSMHZrOlLVGYqpoi4T6NiQSdsbHLXZfgbeC-OlQjV1opxCQfzztKKo_8_SSgV3eVVYuKwH69QRXGFvmZ309xwIeyXMTDZVJhNKvtL-jLyj8t_N3mrNCm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:mWJAZQ7oAUBUc1TFiAZSxrDNhbJpssvBtJHy5fa3nWrJ-82RpJNJiA>
    <xmx:mWJAZU4meEQlDQv9SeGITPlTyS-l-4eBCVsuY27CFiTETm78t46w5Q>
    <xmx:mWJAZYj_YI4M59miSPrm82qWIDYOp_7uY5oqdQUBjtWo5PNZ2fCCWA>
    <xmx:mWJAZUFvWCshlGbdQ4aan5Wj2-LeLx-FWtcTlTScqCjk6b2g5XMPLw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 22:12:39 -0400 (EDT)
Message-ID: <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
Date: Tue, 31 Oct 2023 10:12:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL for v6.7] autofs updates
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
 <ZT+9kixqhgsRKlav@redhat.com>
From: Ian Kent <raven@themaw.net>
In-Reply-To: <ZT+9kixqhgsRKlav@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/23 22:28, Bill O'Donnell wrote:
> On Sun, Oct 29, 2023 at 03:54:52PM +0800, Ian Kent wrote:
>> On 27/10/23 22:33, Christian Brauner wrote:
>>> Hey Linus,
>>>
>>> /* Summary */
>>> This ports autofs to the new mount api. The patchset has existed for
>>> quite a while but never made it upstream. Ian picked it back up.
>>>
>>> This also fixes a bug where fs_param_is_fd() was passed a garbage
>>> param->dirfd but it expected it to be set to the fd that was used to set
>>> param->file otherwise result->uint_32 contains nonsense. So make sure
>>> it's set.
>>>
>>> One less filesystem using the old mount api. We're getting there, albeit
>>> rather slow. The last remaining major filesystem that hasn't converted
>>> is btrfs. Patches exist - I even wrote them - but so far they haven't
>>> made it upstream.
>> Yes, looks like about 39 still to be converted.
>>
>>
>> Just for information, excluding btrfs, what would you like to see as the
>>
>> priority for conversion (in case me or any of my colleagues get a chance
>>
>> to spend a bit more time on it)?
> I'm just starting to have a look at zonefs as a candidate.
> -Bill
>
And devpts looks fairly straight forward and is used a lot ... I'll see if

I can get time to get that one done, ;)


Ian



