Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348F437F972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhEMOMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 10:12:12 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48831 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234342AbhEMOMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 10:12:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0382958072A;
        Thu, 13 May 2021 10:10:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 May 2021 10:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        gW0JdC4P4G363eWc6TJOZ13YBq4n2Zwp0poo+YdSL2c=; b=efpwsLQEPR4bUC1H
        cCf5O7WF/HAhhgn24k9HFiDPsOVKsaGYvMtFA01QvUAO6paIcWG5v50GkqEiMmPZ
        AEcWBMbx3Z9gchTolya+HPEbvcbkAFp8unidNFMsAPqQHJd3GIzry169LI0FaC5O
        bzPTbuORtvBhJCDHYw1rhYI+OKYm3F7nyBfPB5ZINuvp68cVZPQxHZVEBvKBt8F1
        /bMQmsYzXi+kD8OPacUtfbF/47/5vYVzPyiWC5nBLQh8ZVh+WBPQoLspRSLxYJNA
        N+pQAANPmU4WlRLRfsKA9okJ0SzojugYwRCAq0QvMiLuc1U1OP3k48SeIgcLG8RL
        4DeFwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=gW0JdC4P4G363eWc6TJOZ13YBq4n2Zwp0poo+YdSL
        2c=; b=MlXCcZw9qIbYPOZKAK7pgZFReLt1uRXeeCJ9jZd04RE4Up7TlpPu8Iaxk
        088IryfWYRD+TAC620LnFX+ym9OZphYcU8hMc6PvYRsvydYweZrhZnWPmmKqpNmR
        ra+mEh/GZyXDhfbr5Cq6KcmIm4kcRltF6obYr5fs1l11lmgNQfpmyubLuPU1wT2t
        0nR/9/egAm1ep3V7gt/JkJvwzjNZat0FeJnFRwK9tSIVpH+QdMHIQw0wHM+HIyQN
        FlKiR7zz7tQZQ4Lc61loGM5YrP5R2AwZ9cC6tHCaznu44x0ebPfZoCGb/rL2J3ln
        Vk0UxRxdQWRmG1yXcTeSNdFtkxd7g==
X-ME-Sender: <xms:bjOdYEc9BjJsgMP6ovCAV32sfTxAhl_EtC5yQ7Wp8qhMp_bol6W8EA>
    <xme:bjOdYGP9Hz-hAUsBRPUlTuD1qxu3-mt-nsvnoVRJooEX7XcaA_Yyk8kdPLwdjMnpy
    JDfifcEyKG_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekkeejieeiieegvedvvdejjeegfeffleekudekgedvudeggeevgfekvdfhvdelfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdeirdeiledrvdefuddrgeegne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgv
    nhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:bjOdYFgt6gaoPI3NKZwNffevLcL2q4vNpA74Y3q14Fg6PD_usCNFzw>
    <xmx:bjOdYJ_KdbilV0gh297P-uOPDHg1cSBgjKwYd2xn77tXhu2I95BWPg>
    <xmx:bjOdYAvkCUeFni7MicE6p-FQRr0DNrvVhW2w0iTysjE-BG-wpd9H2A>
    <xmx:bzOdYOAbX1krcifV6z07-JTTkqJa7nmytKT48z69C-BrDFH2X8XjvQ>
Received: from mickey.long.domain.name.themaw.net (106-69-231-44.dyn.iinet.net.au [106.69.231.44])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 10:10:49 -0400 (EDT)
Message-ID: <4eae44395ad321d05f47571b58fe3fe2413b6b36.camel@themaw.net>
Subject: Re: [PATCH v4 0/5] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Eric Sandeen <sandeen@sandeen.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 13 May 2021 22:10:46 +0800
In-Reply-To: <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
References: <162077975380.14498.11347675368470436331.stgit@web.messagingengine.com>
         <YJtz6mmgPIwEQNgD@kroah.com>
         <CAC2o3D+28g67vbNOaVxuF0OfE0RjFGHVwAcA_3t1AAS_b_EnPg@mail.gmail.com>
         <CAC2o3DJm0ugq60c8mBafjd81nPmhpBKBT5cCKWvc4rYT0dDgGg@mail.gmail.com>
         <CAC2o3DJdwr0aqT6LwhuRj8kyXt6NAPex2nG5ToadUTJ3Jqr_4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-05-12 at 16:54 +0800, Fox Chen wrote:
> On Wed, May 12, 2021 at 4:47 PM Fox Chen <foxhlchen@gmail.com> wrote:
> > 
> > Hi,
> > 
> > I ran it on my benchmark (
> > https://github.com/foxhlchen/sysfs_benchmark).
> > 
> > machine: aws c5 (Intel Xeon with 96 logical cores)
> > kernel: v5.12
> > benchmark: create 96 threads and bind them to each core then run
> > open+read+close on a sysfs file simultaneously for 1000 times.
> > result:
> > Without the patchset, an open+read+close operation takes 550-570
> > us,
> > perf shows significant time(>40%) spending on mutex_lock.
> > After applying it, it takes 410-440 us for that operation and perf
> > shows only ~4% time on mutex_lock.
> > 
> > It's weird, I don't see a huge performance boost compared to v2,
> > even
> 
> I meant I don't see a huge performance boost here and it's way worse
> than v2.
> IIRC, for v2 fastest one only takes 40us

Thanks Fox,

I'll have a look at those reports but this is puzzling.

Perhaps the added overhead of the check if an update is
needed is taking more than expected and more than just
taking the lock and being done with it. Then there's
the v2 series ... I'll see if I can dig out your reports
on those too.

> 
> 
> > though there is no mutex problem from the perf report.
> > I've put console outputs and perf reports on the attachment for
> > your reference.

Yep, thanks.
Ian

