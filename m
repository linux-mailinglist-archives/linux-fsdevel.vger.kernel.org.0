Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10B11EC736
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 04:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCCPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 22:15:45 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46947 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgFCCPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:15:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 031EC5802D6;
        Tue,  2 Jun 2020 22:15:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Jun 2020 22:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        6pUUgnZdVRfgssHG6PiGy/ksy5g4aXP+llHJT50Buho=; b=CL9HkFj4APm/nhtS
        xi/AVwtjfIwDza3rkh82FsGQ1VLBMVewwTrGnJPusgNFjf0sVpPobl8VNmmiHQXT
        7o9fboO1Z7qsMqJdaxSChgJdc/Trqt8kM/1zgRWDCiWzBE1tDUZ3KMErVVPMfexl
        EJov2FGhME06VLfEtZBecgGnE3QTgUn35RFvs9w+wOR5Jro37nmwthjugeiMzJnb
        Y9fqHN1BkObepELPB2rdlyX9lS+4gqpPyBFfwFD3kvbKtEqb6v+jZN3KjhqeUgLW
        6GHn46/MSWigx12U8cNsMMLuoCdhBXpd/ArE9jVueyyCZLTWm/FrzyjTYhcuhUgS
        a7h3hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=6pUUgnZdVRfgssHG6PiGy/ksy5g4aXP+llHJT50Bu
        ho=; b=gj+4db0wdCSTFiluY15U1lPN7KQoRKcTNe9Lx4BBRoZbSaVR7UsSneZ7N
        I2vgKIwpKWqe8n39Jd86xhp8PttxF9+y5j4Lps8YmUSp+E4S6LtAHvc3U95p63Ug
        YM6DTdpDTgFL4cBnKJXcQ7PHaoJFdJdpsJcFbHsHoewaf8GV9pvvB3u8fANfFI+s
        BkdzWGECZqv/mKV/F0UUykdQN71DI+hazhyOykFsZ71ScLM6yA0s0853Lv9VS5uO
        EEDLFnf2+No7AouUzhgReYfxJufMZ8u6d4/GipyNUshXCPybOMITnSsY9gpqGy68
        vjy6Vivf3wCrZ/R7Z+MjlmNS2Iy+Q==
X-ME-Sender: <xms:zwfXXsjTR8MMxv6E4ZilxF-v9os9_9fZMk-mcLXo-csWfoiHsxnSUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefkedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekkeejieeiieegvedvvdejjeegfeffleekudekgedvudeggeevgfekvdfhvdelfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeehkedrjedrvdehgedrleehnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhes
    thhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:zwfXXlD4MKIQOUEnl8hEoCToW96ihLrAT8n9zR3sc9wcR9GK2mUwSQ>
    <xmx:zwfXXkHyEU8LJ52_-ijOOtBEEUxqGhdvzvd1Jz1xoawMWjRS-iv7Bg>
    <xmx:zwfXXtT3GcFiCF1xd13SLQP_qq0FVKKXQXiK0FNVtpJuU0BfmG7LNg>
    <xmx:zwfXXpe1rCTlOYNdnGwK1fvTLF6SwbEP-vxQwEmPuVLwUeo9CH856w>
Received: from mickey.themaw.net (58-7-254-95.dyn.iinet.net.au [58.7.254.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D1D830618C1;
        Tue,  2 Jun 2020 22:15:38 -0400 (EDT)
Message-ID: <639a79d90f51da0b53a0ba45ec28d5b0dd9fee7b.camel@themaw.net>
Subject: Re: [GIT PULL] General notification queue and key notifications
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com,
        andres@anarazel.de, christian.brauner@ubuntu.com,
        jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Jun 2020 10:15:34 +0800
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
References: <1503686.1591113304@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> 
> [[ With regard to the mount/sb notifications and fsinfo(), Karel Zak
> and
>    Ian Kent have been working on making libmount use them,
> preparatory to
>    working on systemd:
> 
> 	https://github.com/karelzak/util-linux/commits/topic/fsinfo
> 	
> https://github.com/raven-au/util-linux/commits/topic/fsinfo.public
> 
>    Development has stalled briefly due to other commitments, so I'm
> not
>    sure I can ask you to pull those parts of the series for
> now.  Christian
>    Brauner would like to use them in lxc, but hasn't started.
>    ]]

Linus,

Just so your aware of what has been done and where we are at here's
a summary.

Karel has done quite a bit of work on libmount (at this stage it's
getting hold of the mount information, aka. fsinfo()) and most of
what I have done is included in that too which you can see in Karel's
repo above). You can see a couple of bug fixes and a little bit of
new code present in my repo which hasn't been sent over to Karel
yet.

This infrastructure is essential before notifications work is started
which is where we will see the most improvement.

It turns out that while systemd uses libmount it has it's own
notifications handling sub-system as it deals with several event
types, not just mount information, in the same area. So, unfortunately,
changes will need to be made there as well as in libmount, more so
than the trivial changes to use fsinfo() via libmount.

That's where we are at the moment and I will get back to it once
I've dealt with a few things I postponed to work on libmount.

If you would like a more detailed account of what we have found I
can provide that too.

Is there anything else you would like from me or Karel?

Ian

