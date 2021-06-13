Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B83A55FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFMB7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Jun 2021 21:59:22 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:49119 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhFMB7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Jun 2021 21:59:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 3D3644D0;
        Sat, 12 Jun 2021 21:57:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 12 Jun 2021 21:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        Uom0PmQvH9twYv18/8DY+8ughWYvRfkhlllMXqiZF9U=; b=OVUqdN8gDqbMKH0g
        IlIvGy0J1ex1TF/hXzLNtxTfLsNa4rSJkveblDtecrR9zYUHKgfiZi2GLyQz8khL
        yd881w21Mb6sfk6IE/KYPowxeh4lqcc+oROudNGRpZjeAHG3I0SyoGaRbaYjVC0q
        50SaI6zRhbg7ILd3am82bbrnfAmCP74Xb/TgwwMR4b+6jE3YHoxN4AMAHelbDLeU
        vOnv8/qo1br9kMoxZ/A2S15L61yGXhXnxM1HS0mgpeDsYPJcGb+7vXwK4IKx2Nk7
        x9wbNylHNp2CFyoBhyjtx556ET2k7pe9Gw5AwTnf51bA26pivVzgN1pgcIIUIqUa
        e8wpYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Uom0PmQvH9twYv18/8DY+8ughWYvRfkhlllMXqiZF
        9U=; b=HNfZq2tlph76QK1wHJxNX6QbI4L3TFJBIjObPCmEcRhDEw5jUGAi/vz7y
        DkRRI4+vEj6TviS+s5KeBwcaN65Bl9bAUwQvebCw7IdodA47vAl7866a1bXizA2M
        p2JKl5jgV03coqHIecWwZx4qYUbTDRupWx+8skwYbR93eX/Y5JAlXloKUSYq9bv/
        lB2C6LRi4MYTyLgs9V1KAfYeMT6YM/wFM+8dcXUEJFtQXwurUKzwtTu4zoXLwxBw
        RewV03ncFGxnl7QzafuquIQ6NX2ON35qZQ/SG/sVRVgu3GHqKJW9r2yhZfb9/3CJ
        qEh1uExBTKXSsas6ohBXJEpB6xe6g==
X-ME-Sender: <xms:_2XFYAGg2JgsMRq-fp4-I3qvMYXdajSGaLaOA5jai9OUC6zI2bkqOw>
    <xme:_2XFYJUi31r4Yo8WQsbm9Q6qyxK_RxQJqg4z_IbESvlG9MC1AXf9Hy-Qn7UEydi97
    pNt_iGqMIfP>
X-ME-Received: <xmr:_2XFYKLvzzgYfkeJ552w9pGM3fwrjubCFB4eKNGZDEkmwD-5Nta9Q0I4ApMgPsCvkMSH6xsaTYHCgPS2v7Wv7ixJP_Dx_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:_2XFYCEAEKwgBPvgEHemsufSq1urmp73BWLtbDDQeED5s5vQBQm_SQ>
    <xmx:_2XFYGV4nZva6EZSru6LmOlS5UPBkh8Mes7N9f8Y8UQCz1zcHLCB6w>
    <xmx:_2XFYFOdOdAUmJKbu7g_b9RQ3vdr8Tk10VWI9U3yLK6o7SlWlFt4Ww>
    <xmx:_2XFYNOqDfpbim5uFT_jufWJoiEFkyndl7LI6VEcJe5LXakTyhqyqHQTRhs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jun 2021 21:57:14 -0400 (EDT)
Message-ID: <8304e49310b16b865868982802bd2344d076c974.camel@themaw.net>
Subject: Re: [PATCH v6 3/7] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 13 Jun 2021 09:57:10 +0800
In-Reply-To: <YMQTMnfmOfdv2DpA@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322862726.361452.10114120072438540655.stgit@web.messagingengine.com>
         <YMP6topegaTXGNgC@zeniv-ca.linux.org.uk>
         <2ee74cbed729d66a38a5c7de9c4608d02fb89f26.camel@themaw.net>
         <ab91ce6f0c1b2e9549fc6e966db7514a988d0bf1.camel@themaw.net>
         <YMQTMnfmOfdv2DpA@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-06-12 at 01:51 +0000, Al Viro wrote:
> On Sat, Jun 12, 2021 at 09:08:05AM +0800, Ian Kent wrote:
> 
> > But if I change to take the read lock to ensure there's no
> > operation
> > in progress for the revision check I would need the dget_parent(),
> > yes?
> 
> WTF for?  ->d_parent can change *ONLY* when ->d_lock is held on all
> dentries involved (including old and new parents).

Understood, thanks.

> 
> And it very definitely does *not* change for negative dentries.  I
> mean,
> look at the very beginning of __d_move().

