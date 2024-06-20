Return-Path: <linux-fsdevel+bounces-22040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DA9114D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 23:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6381F213DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B3280605;
	Thu, 20 Jun 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="N9eeNJ6u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mn8yBW35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116874BF0;
	Thu, 20 Jun 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919648; cv=none; b=o4b5gixea88kSseajy7dCBmFKzFj026e3LhLM/F87zMRuO7iczlP2j5F0Rx5Gk1cU4zX3d0PffCJnAxegBEJpB9te2z4wVxe0PJedhcsFH523XMuxNTWugT+OFsGeFlPKOKF8i56jkVn9qcBPjrPQp8evSXwyPuVLuJTiX7ikSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919648; c=relaxed/simple;
	bh=/ZqHaM7eyu6SEUfj0+cHTAw1+kYHMfcUuW+8dm6VPTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1TXBi+YREsdPe5nqd8qVfbA7rSCtl/hufybju+/JrG5ntGqUOSiBNNb22AHxBg3NxYt2WlKJZIheySHKqTYOcWMw2pomGdMH0Rx2RBnDcD9/5vHk6X4s759Ln3iUUaS0fjvn9rWtsnq6/AHxxlWOOckoKvhsKcubxyMceFl28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=N9eeNJ6u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mn8yBW35; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 150491C00111;
	Thu, 20 Jun 2024 17:40:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jun 2024 17:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718919644;
	 x=1719006044; bh=U+RQTWGThkmobRX/Ae5sAZDBhtv41vgHeflEaT6xjZA=; b=
	N9eeNJ6uNO7irK7f8M72gWeb/rVgXRDLxog5z6GWz/j/+grE9gRoyI/1B68CVfBb
	D6qc03M0R8DtSt06pK8mDKJ24hY32hbnewOgoZg6fTQGQd2wF+Cr6CLj1V7/+Cpz
	MfaBLz3DppQjyYyObSrz2CaGgc2ROeOlbVTMLzg27TnAqRWKY8skzbzZ47B4WxwD
	djJIGTmFyY70M7LPRjYx0bM+BjXgYdPJ9DyxSappwy7VPUEUM+FZopuH7QeDkbpD
	jAW5iUD9q4M3Drn9CErNAzq2+GsG+JIFzfwn5z6nF6ayEr29UDrCfSghcW2YPY32
	wA854AsRwmwxQZ5OE0dHdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718919644; x=
	1719006044; bh=U+RQTWGThkmobRX/Ae5sAZDBhtv41vgHeflEaT6xjZA=; b=M
	n8yBW35S91ledb2ISb0AO6UywBGqhbfacKehc5eO+0U/hFJqAuL3wUGqOFQ6k5W7
	HiyGabFBXiGTkZ4MfJewmLFofapdWXotHDAW2tIbN7HcCKCSnSatmz1zFi9YJHkl
	wveFsAVCaX6w7KPZHg4f/k1Fi8IwU1Kb29SKQfKEK3wCO4bNFa7w7ZQlVeApXD9n
	t+AuKZS2JQx0DUrm3gq0AG5c6e1uRR/KSQ0dLOAsJzj9TLQE8udcosGxfjb710Aa
	b0gWHKg486FtSydP0ZQ72bilKbtEiZGjgcs3ct0cvsoUO8LD298jCGijZfKaVV0n
	OFGRTzQLYxvaKDBZ1+gSg==
X-ME-Sender: <xms:3KF0ZqdBFqgTUwDM-6jZGF7O3bwXIuwZXeAIa4EbfsYdzN1yjqnuAQ>
    <xme:3KF0ZkMaYDDx64GKNU0Y87cPPW2sGBubWphSjQ22KrtSKpRf47RO0u05G4xtxOT1I
    M8jwkiPa5-GljZC>
X-ME-Received: <xmr:3KF0Zri4pzfok0YNrmV2t2VdoPlVbtzGJeDSMwW05hazSF9utkIk-0z15I1iuZBLchIBuYTjEwjNXym-iVeZxUybgE_h2sH9q7sC85bECoz57lzr2MbL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeffedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefgueektdefuefgkeeuieekieeljeehffej
    heeludeifeetueefhfetueehhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:3KF0Zn9i4oDauOmi_nlkvaNxTJaK2Rys1nff8wqEw_xSr1qJPh7V2w>
    <xmx:3KF0ZmvOOXA1IvatgqQmI0hZR3yekNZxRyhPqWQLOcQodmYOFZutyw>
    <xmx:3KF0ZuGhm0300HenAkIo9NUM2kAKeGUoz24z95mTh6Lhg8Umd9h2MQ>
    <xmx:3KF0ZlOkvapH134FoJ4dk7m8uookEBLEGUrWLqgKw9ziy_UAsJJCJA>
    <xmx:3KF0ZoV7u-jY_UdubUqyI_qVjF7wthXcKa5tQw4osGIoqlgbXW2v7Gur>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jun 2024 17:40:43 -0400 (EDT)
Message-ID: <db4ed4e5-7c23-468d-8bac-cee215ace19e@fastmail.fm>
Date: Thu, 20 Jun 2024 23:40:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Haifeng Xu <haifeng.xu@shopee.com>, Christian Brauner
 <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
 <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
 <20240617-vanille-labil-8de959ba5756@brauner>
 <2cf34c6b-4653-4f48-9a5f-43b484ed629e@shopee.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <2cf34c6b-4653-4f48-9a5f-43b484ed629e@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/20/24 08:43, Haifeng Xu wrote:
> 
> 
> On 2024/6/17 15:25, Christian Brauner wrote:
>> On Fri, Jun 14, 2024 at 12:01:39PM GMT, Miklos Szeredi wrote:
>>> On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>
>>>> So why the client doesn't get woken up?
>>>
>>> Need to find out what the server (lxcfs) is doing.  Can you do a
>>> strace of lxcfs to see the communication on the fuse device?
>>
>> Fwiw, I'm one of the orignal authors and maintainers of LXCFS so if you
>> have specific questions, I may be able to help.
> 
> Thanks. All server threads of lcxfs wokrs fine now.
> 
> So can we add another interface to abort those dead request?
> If the client thread got killed and wait for relpy, but the fuse sever didn't 
> send reply for some unknown reason，we can use this interface to wakeup the client thread.

Isn't that a manual workaround? I.e. an admin or a script needs to trigger it?

There is a discussion in this thread to add request timeouts
https://lore.kernel.org/linux-kernel/20240605153552.GB21567@localhost.localdomain/T/
I guess for interrupted requests that would be definitely a case where timeouts could be
applied?


Thanks,
Bernd

