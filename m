Return-Path: <linux-fsdevel+bounces-2879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C927EBACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 02:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E310B20BA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122A631;
	Wed, 15 Nov 2023 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="s6iUKWri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nxD4uJdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B86394;
	Wed, 15 Nov 2023 01:06:56 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD7DC;
	Tue, 14 Nov 2023 17:06:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E39E55C0150;
	Tue, 14 Nov 2023 20:06:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Nov 2023 20:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700010414; x=1700096814; bh=ZfFaIHFWUpEiFsmXQhLKQzZFRlFi+XgkIGO
	E31T1wx4=; b=s6iUKWriyYhRjPG6hlTrcyQ2zmFGlLVIxhnbH+RXJOt95U30Z06
	MaftuwLQeDHVtJ4L4260JQ7VLYCOTYBEfpXJ3kqDVCffGvemH0tInLKETcL3plXK
	M/lmhX+UDPrq+BNr9PYNJz4deeq1QIk+7mC83g/LfJ0TYNbG1W+4sUG1d5DsB7Wh
	LKakKi7k9twvivdZkeFKA1sZaXdg5pQh16qd2yTmPDes6binJ5GPYSatoC/r1TlQ
	S1DVBStxpQ1mGX8/42GY2z5jZukWstwkON5XJkZShP3ID82ekg0OsPjMFAYjlnLB
	BMHRq0vjhkRwpi5ahM0pxEfblMf6cvEK4WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700010414; x=1700096814; bh=ZfFaIHFWUpEiFsmXQhLKQzZFRlFi+XgkIGO
	E31T1wx4=; b=nxD4uJdHGXMW/Kby432f/6dASClN6oJyvSlCNNtKCfnzw2OeJac
	Bat8zLNEza4Jt1DwAAShyGMaouuQd/UtqtyFNc3HhTRtArrBrIDRYa6s6l1A9S2c
	/CVb6oGmsX1dkIAXkXCA10gLom8pG0SjusLaNbae8FekRSVTXSl72xlB3QUG9Ufv
	3tkWOCWm/LzY2ZA3+xgXJSUsHRC6cH3+qsdsJUwCQiWd8WxEnt56CjN+shT3t2Jm
	0fjc+xjMpokAAvcSl1yuoGDN0BLRIaNuhLOf1i/aCKlL52MnB3EEapiLWrgEmTwx
	FMDTxLRAxFxczSRUmZQjnWNmgXW7bkB19Ng==
X-ME-Sender: <xms:rhlUZaIAMel4ZwwHqMNlqvf-wQjtYVuW329ZY2NIJZ_N-vCxbV6bYA>
    <xme:rhlUZSLtvKk0gekYXNHubtDFcM6eG6F4vxKFK-8oZS3efH0t-omFNVXU3mMi1Kr9z
    rpxLYfRNQSM>
X-ME-Received: <xmr:rhlUZavbNRFUoBKqrDB9uAfXDRqypv1A8T-PzlsVATQ7PKqn1m5pEJ3-45zbGsdWOVw-bCknmkMN2PXPC0FzsuZOuuzbA1PxjfagRNNVCRTlkoFCt1PiXFF1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefgedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:rhlUZfaV0ccWdWFHb_DA_8C6ImJrMUO3hzZ85CSx7ji_YJ1AArq9Tg>
    <xmx:rhlUZRaiAzBT7VvaUkVEAT1yPH1ONBwtPPD_iBH1PClYg4aXjE-D5A>
    <xmx:rhlUZbBjWrbsjm2J98QkfLVVcjiuRW-r8XGXtAbaYJQmDqL8JczkUQ>
    <xmx:rhlUZQVrNFsf1bhd2FcOQxFXz8uiCcFJyr3nklFhXwabuDlErW70sA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 20:06:51 -0500 (EST)
Message-ID: <dcd50f92-e0e3-9a24-daf1-f2402f06518f@themaw.net>
Date: Wed, 15 Nov 2023 09:06:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
 <20231114044110.GR1957730@ZenIV>
 <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
 <20231114152601.GS1957730@ZenIV>
 <7b982b5e-ecad-1b55-7388-faf759b65cfe@themaw.net>
 <20231115003527.GW1957730@ZenIV>
From: Ian Kent <raven@themaw.net>
In-Reply-To: <20231115003527.GW1957730@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/23 08:35, Al Viro wrote:
> On Wed, Nov 15, 2023 at 08:18:33AM +0800, Ian Kent wrote:
>
>> I guess that including the locking is not going to make much difference.
>>
>> I don't remember now but it was probably done because there may be many
>>
>> mounts (potentially several thousand) being done and I wanted to get rid
>>
>> of anything that wasn't needed.
> Seeing that lock in question is not going to be contended... ;-)
>
> Seriously, though - the fewer complications we have in the locking rules,
> the better.

Sure, no problem, I'll make that change.

I do need to do a compile and test it actually ok works so it's

taking a little while.


Ian

>
> Al, currently going through audit of ->d_name/->d_parent uses and cursing
> at the 600-odd places left to look through...

