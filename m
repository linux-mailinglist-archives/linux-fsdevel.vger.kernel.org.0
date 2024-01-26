Return-Path: <linux-fsdevel+bounces-9037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8F83D45D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 07:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5306C1F21FCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 06:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6919BA5;
	Fri, 26 Jan 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ePfzeFk3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvOGos/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB550C8E0;
	Fri, 26 Jan 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249814; cv=none; b=HacFVSYpeV+uCZoDxnucS3zqZb6hCahARQgyf6LzDHOUMEhJgVl6udd64MpK12g3+DLYOQuYTAfcfidKLVVzYuH/kM5+ewNfjUmn4xakFKqsQkJzGVyrUwflcrEk5pLQ2JEJ9V+UZGW1N2SW9DoA3PCmD9/P5TFHRQb2g+ftp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249814; c=relaxed/simple;
	bh=UCN1lRs2vRBEnt1CbTI+f6sZAAmHopJNCxiLao/UQMI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=R5CiVlS5xGP3MxaDQRXYfvweUxuEvTmU/S7pO0CIN/bsU+qDVeCT5kZIU7QwrH9HZGDsEp49wvnQhepzZgV6uA+YUnfUuca7hEzXDHl0+1U8O0RS51cgrhKvZuiT1+0/eTU+yF2Xxkwm8FtR2LecxtCnzfGgc5HhwvjvwgCcwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ePfzeFk3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IvOGos/q; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E8B565C0154;
	Fri, 26 Jan 2024 01:16:51 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 01:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706249811; x=1706336211; bh=8lgdoSvIDi
	CRr6hQ1g1iPHkPUjc4Fdr/FoYIzZbtZC8=; b=ePfzeFk3bfvNIDY3cdNxgVlKB/
	Lx7zmBsYKYiBfzuz3dN3XN5LFcp/peY05lJbnFF9f894gJWVcLGYcgDfuwAHXKEd
	mbCtNBjfdmUVW+tfntX2fc/qdF64CxSqYFtjH+Sk0X4j7N3gfPcp+zC27YHro4ei
	Wx5U92unsndmymme9SyFYwXjm2Jc8Ogq5tIs8bjasCNJClWgWHe5k9ecLBj4Rjw9
	6/520Hut0cnxKzcBGRvH2hvYK04phRAEKtH7nnKCVUAs+vMZOzNWvA+Ga/ysKY7P
	2zl0ivFj2Ebjt+umwRQLDL8wLXL364spUAF+owxMr/1SUDi8pBG3VjNmaYoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706249811; x=1706336211; bh=8lgdoSvIDiCRr6hQ1g1iPHkPUjc4
	Fdr/FoYIzZbtZC8=; b=IvOGos/qDPTlf+NWtENxCwSBzGrQvo+skHIemNF8klsC
	3Gcfe+n0TlgFDdYiWWw4RiHvwJcPwxPs44qA8kmE9GkV9tlzOKEWXAFc6Sw0wQxR
	IgGq2VDAQl5yhsLbBDuI46BP/nVMH8A0wTrCZhK9sHePXFcZD3rhfNNKlrSOtrFj
	8x4xN+uTW5aS/9JGdgjeC2k7X5HhAZOlVpwqwAxvqTv/j7FGET6iNxGTXFD/cIXG
	U4lgG0XOFg/5EhMLaA3FEyiWPN3/8IV49WGHDCkahiPsim4HqQQUEfFxMgvQSp9j
	9hs/3pt4Lgfk8S2/5sxt0z6fLDg9pzrDCWLWbPbgSA==
X-ME-Sender: <xms:Uk6zZW2dejTe01OAVCXOuMD8u733oPaxdBo2pmqJmD7jfTqwBpRTZw>
    <xme:Uk6zZZERF3ClcOxNj8DRq3W7NjYlJCmIYGDCW8G2rlCfzr-Lg9FZ-P6IpopB5oyVS
    jCI6OXn05sdIQJaKXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Uk6zZe4Yp1okF1C4JYucisdIq20LY_P-zMWvYPrfGvBmEMgQvRvdLg>
    <xmx:Uk6zZX3d1l0OUejuyAQUgKeHpLiwBLMmkktFgGrTYXYj-EVCMBL5kA>
    <xmx:Uk6zZZFg-tARBEmI6xNqSoBO8RFO-i6UWHPI3h_AqikWyPJfvv7H7A>
    <xmx:U06zZcZgYj-KYDVFq28393AFgHiuOL2lcJsHDHS4quqhlSpdzJREhg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2AD2CB6008D; Fri, 26 Jan 2024 01:16:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <57b62135-2159-493d-a6bb-47d5be55154a@app.fastmail.com>
In-Reply-To: <20240126023630.GA1235@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh> <20240126001128.GC1987@fastly.com>
 <2024012525-outdoors-district-2660@gregkh> <20240126023630.GA1235@fastly.com>
Date: Fri, 26 Jan 2024 07:16:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Joe Damato" <jdamato@fastly.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-api@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, alexander.duyck@gmail.com,
 "Sridhar Samudrala" <sridhar.samudrala@intel.com>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, weiwan@google.com,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nathan Lynch" <nathanl@linux.ibm.com>,
 "Steve French" <stfrench@microsoft.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 "Julien Panis" <jpanis@baylibre.com>,
 "Andrew Waterman" <waterman@eecs.berkeley.edu>,
 "Thomas Huth" <thuth@redhat.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for epoll_params
Content-Type: text/plain

On Fri, Jan 26, 2024, at 03:36, Joe Damato wrote:
> On Thu, Jan 25, 2024 at 04:23:58PM -0800, Greg Kroah-Hartman wrote:
>> On Thu, Jan 25, 2024 at 04:11:28PM -0800, Joe Damato wrote:
>> > On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
>> > > On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
>> > > > +struct epoll_params {
>> > > > +	u64 busy_poll_usecs;
>> > > > +	u16 busy_poll_budget;
>> > > > +
>> > > > +	/* for future fields */
>> > > > +	u8 data[118];
>> > > > +} EPOLL_PACKED;
>> > > 
>
> Sure, that makes sense to me. I'll remove it in the v4 alongside the other
> changes you've requested.
>
> Thanks for your time and patience reviewing my code. I greatly appreciate
> your helpful comments and feedback.

Note that you should still pad the structure to its normal
alignment. On non-x86 targets this would currently mean a
multiple of 64 bits.

I would suggest dropping the EPOLL_PACKED here entirely and
just using a fully aligned structure on all architectures, like

struct epoll_params {
      __aligned_u64 busy_poll_usecs;
      __u16 busy_poll_budget;
      __u8 __pad[6];
};

The explicit padding can help avoid leaking stack data when
a structure is copied back from kernel to userspace, so I would
just always use it in ioctl data structures.

      Arnd

