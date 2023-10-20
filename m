Return-Path: <linux-fsdevel+bounces-808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB87D0890
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8031C20F3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1660EC127;
	Fri, 20 Oct 2023 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JGJvSwBi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LC0wQbny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99C46670
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 06:37:02 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06393A3;
	Thu, 19 Oct 2023 23:37:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7401E5C0BD9;
	Fri, 20 Oct 2023 02:37:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 20 Oct 2023 02:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697783820; x=1697870220; bh=xA
	WhvJyTwIlMRjiPKv8rd0f6EZnz1syx0+2giec34Ls=; b=JGJvSwBi2KS9Z09BYB
	fJVxONUbLX7Z4H3etKXqaHoHj29lkP8DiHI93taxql0ZYLHdCII2C4SaljI1Yina
	6OZ5tpfbD/7lV+0Z8R4IQjaP4DzQWIawi0uHZnHDPzWFesrBuvQjK07LBGg21RHC
	WiK/90slio8eFBjDUV9QojelCKfXay1MhzWZT/NYNi0VHPuWGHfY5R18GmbLxTVd
	BnETZX/MRMdl1DEMk8t5AG9u1n0tI3NEYe95zi9FIDERy7r/xPUP2OFnI5a04czq
	wRrM2fHfVIU0h5wa3bs9EG2FbbC98wDTTyRPsWSd3YmKAwKv7CAShUgYPhEjZdDp
	lKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697783820; x=1697870220; bh=xAWhvJyTwIlMR
	jiPKv8rd0f6EZnz1syx0+2giec34Ls=; b=LC0wQbnyB2iq8ETSI9WRrIMX/Bkjk
	YAEsisbyPxiLLZOPcp4qoUaQ4jwWmTJaTWhakoWIjCsjMleEHOzED5av8hgAM0Gc
	XE6enpluUOKV19cdZ0QBMlUxhQbl7a+iiSo8UmB5536NN5+N4Kb8ESUzqQv7nnQs
	/JDATVM3sgDxyGD1QEOyj+R1pKxF/HTVNnv2tAW/HM53gik6Qx9aYOaIXpamycqa
	FvUKbjvJfFZDIlW6OzMGjiL3C40vu+WN39SC0PLJcVomwrxUv4HO71Of6QKQOnsx
	aV9JaoM0d5HifHMQnwjPXj3mGHZNqdnjpPaYFLFqIcbS5OxFaYO7je5Dw==
X-ME-Sender: <xms:DCAyZV74mP2H0aDjEcE-9ZyXUl743ig-YDnrN8LHDelVz6r5cA-Ixw>
    <xme:DCAyZS5Q5Csfw8kYT6u7jduf4n7UKf3G1vv_xOHVqKwk9q25x7rCFlniSflKOb326
    PQhFFmYFmS0fPlRWao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DCAyZcfPB5YpCJZZu3BmSFLjpUPcSiJpbSlSB1SgdrCnI2UUnlJSPA>
    <xmx:DCAyZeKtV0j3GkVcdTE2wRWGHeDdoUDIyTtGoaOPKsNK9vD5_zhykw>
    <xmx:DCAyZZLZKRi4pqukADcJxP7eHgSQyR-Pif-4KnYvK58RMeUArIAbfA>
    <xmx:DCAyZepB2nT6S-keWgBFCWivTkyLef3Pm9zg8qU0_p91whZnnoneEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 237B7B60089; Fri, 20 Oct 2023 02:37:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
References: 
 <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
Date: Fri, 20 Oct 2023 08:36:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org
Cc: "Ian Kent" <raven@themaw.net>, "Bill O'Donnell" <bodonnel@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: autofs: add autofs_parse_fd()
Content-Type: text/plain

On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
> it as compat mode boot testing. Recently it started to failed to get login
> prompt.
>
> We have not seen any kernel crash logs.
>
> Anders, bisection is pointing to first bad commit,
> 546694b8f658 autofs: add autofs_parse_fd()
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>

I tried to find something in that commit that would be different
in compat mode, but don't see anything at all -- this appears
to be just a simple refactoring of the code, unlike the commits
that immediately follow it and that do change the mount
interface.

Unfortunately this makes it impossible to just revert the commit
on top of linux-next. Can you double-check your bisection by
testing 546694b8f658 and the commit before it again?

What are the exact mount options you pass to autofs in your fstab?

    Arnd

