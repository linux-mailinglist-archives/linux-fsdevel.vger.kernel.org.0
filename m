Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C707C209B27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbgFYIPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 04:15:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51653 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbgFYIP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:15:29 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 36E7F5C0129;
        Thu, 25 Jun 2020 04:15:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jun 2020 04:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        P/eFafOZttAQk1jUfpBb2bbEKVsHkuSm9g64OcFOYWE=; b=YGmTVosK6St1n/Hj
        MESzAVdtrVJA2OIGxRuTdLd/yrEzpR4Ge8CYTHVSzVA3RjjA5j1yUOV38Y6RAL6z
        KABOXpds+++j22U6acBfkJ116DjL3mj9XxNaQnGSVDT0iFLZDwJ+LBylG0DJvOA2
        spWImfZH8CdCyVjQqoBeqA53DxDdC7KwtzmJclN6tPlzDUo8FLQMNZ61fZ0CHvRf
        3KqVtuqV7p6MP/zeOLpR08Aih6dLmfxwQOOeTUD1wms8S/ulb3fnu9FtQ4eiJOqT
        uk+UQCp81sRnqeDTm4dFfjc19oOUtl9bsnsaOLZGqkFlG3zQgejJW1xUJmIuEJXM
        ndtKow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=P/eFafOZttAQk1jUfpBb2bbEKVsHkuSm9g64OcFOY
        WE=; b=cvICLLJK0oHcBiKIgxnDyKcq9n4BIW959sOPKH7JVpFGP4T/Y9cGqOXwJ
        2eAmRqi8bP7BZXPsxxCd+rWT/kQZKKtY9uYHnc04k578SEMXPB/+O+nTETsP4kmR
        fILxQUFao3A3rXPtHXXGqhVnRd727ObKRLNBKpRn80nfgfMiIak2aT11BIISfyFu
        SG4BFY/gGjPiOrLf55QCfdS4TGJ9aSJRlSWBqH58MjUqecTIlqqC3jCxNnn0eZ+X
        5twP7eitYh5qplaEN7i9z5HQCPR5awB2gEH8Kvl1ZaCfRC+mfQ3DR4lZuNYFA/ha
        3Qega9i6bkFK9kt4JhD18hilnzesg==
X-ME-Sender: <xms:H130Xma7mmdtzJFfxpK3KQqGICrADguVZ3hIQDh9rhYBeM-jaxRV0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrheejrdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:H130XpaKPZ_jfTV3f2kFNiaYHHjavQe9mDSqRPQrqqm36IMoixl_3A>
    <xmx:H130Xg8eX-W7fOQaY1hNImGaVeFJUVDBVdlHLKjv8retzIaqPN_Ztg>
    <xmx:H130XoqyOBvYd5_2gjMbhIbb8a6oMUtK9alojs_oWlKPSRnhRCUnng>
    <xmx:IF30XqC9sX6SmjhqbrifSkxfL7IGquxwJRNHPDk4KDTLoahJnL-tCg>
Received: from mickey.themaw.net (unknown [118.208.57.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D6B6306778F;
        Thu, 25 Jun 2020 04:15:23 -0400 (EDT)
Message-ID: <ac4a2c133da21856439f907989c3f9d781857cbf.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jun 2020 16:15:19 +0800
In-Reply-To: <20200623231348.GD13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
         <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
         <20200619222356.GA13061@mtj.duckdns.org>
         <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
         <20200622175343.GC13061@mtj.duckdns.org>
         <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
         <20200623231348.GD13061@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-06-23 at 19:13 -0400, Tejun Heo wrote:
> Hello, Rick.
> 
> On Mon, Jun 22, 2020 at 02:22:34PM -0700, Rick Lindsley wrote:
> > > I don't know. The above highlights the absurdity of the approach
> > > itself to
> > > me. You seem to be aware of it too in writing: 250,000 "devices".
> > 
> > Just because it is absurd doesn't mean it wasn't built that way :)
> > 
> > I agree, and I'm trying to influence the next hardware design.
> > However,
> 
> I'm not saying that the hardware should not segment things into
> however many
> pieces that it wants / needs to. That part is fine.
> 
> > what's already out there is memory units that must be accessed in
> > 256MB
> > blocks. If you want to remove/add a GB, that's really 4 blocks of
> > memory
> > you're manipulating, to the hardware. Those blocks have to be
> > registered
> > and recognized by the kernel for that to work.
> 
> The problem is fitting that into an interface which wholly doesn't
> fit that
> particular requirement. It's not that difficult to imagine different
> ways to
> represent however many memory slots, right? It'd take work to make
> sure that
> integrates well with whatever tooling or use cases but once done this
> particular problem will be resolved permanently and the whole thing
> will
> look a lot less silly. Wouldn't that be better?

Well, no, I am finding it difficult to imagine different ways to
represent this but perhaps that's because I'm blinker eyed on what
a solution might look like because of my file system focus.

Can "anyone" throw out some ideas with a little more detail than we
have had so far so we can maybe start to formulate an actual plan of
what needs to be done.

Ian

