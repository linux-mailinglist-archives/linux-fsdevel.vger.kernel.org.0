Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A941CF3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbhI2WaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 18:30:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58563 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233018AbhI2W37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:29:59 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 214FB5C00E9;
        Wed, 29 Sep 2021 18:28:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 29 Sep 2021 18:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        RbGSPlaIqE0tLsEJBLRO6taLWZBMOszsIYdAAt8k7wU=; b=aNRDdpAiuUudGwPF
        hJ6KGND/HIU0vfe4677Y0dhl/XTuHawULRt5xHsxajJhRY0GrlzfHoZku9CyUhdS
        rtQRdqAGx3FX0jDzXxoDOi2iZ/o418kS6YuUrnREYBGjlrRVEAnJS5oOGgx3oVhd
        NWEZQYsrRmWKaqW3ucCj2w3YHY4Ob6BD3+OMWtIxLvAxfZTUPV3aC8r6xt3po2IT
        VKk7SbMdeJPLcy6vcYnNBkgLLYmiIKFc/8S5G1HDaXA5Cjt6dcPYCQbgzl+4VVGR
        LtkRiOKtk846AS+MLYx21RWGrjb+mEilgae16yqFNRNWwuaUytS8pmdpjFlWpQlM
        CpzqnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RbGSPlaIqE0tLsEJBLRO6taLWZBMOszsIYdAAt8k7
        wU=; b=FBoFQ3vHs/BeHpb1aZj4/5L3FoWUGuhmmTqIqha71qQR3jzZqIZoSg2OQ
        9mowR5tePMDfR6CRXvfKXtwncAD9dVvVGuwRkzkUimyUyayfpaC+Gda4Fo+Ju0zA
        HGXIBhopllgQ9Z2XqUDnizId70wTJoUKJ6n+dFwXhL697wpsqmxMNtrxHWRX5iiQ
        AMTh1Zcmqg5pCNnp9T9adq3QwIbyPTYHZOmopZsAhrL8DcqxO9EdFbZr3ticXC0g
        btJ+c7hfrsISlBs/v9xngfJCpvW41dBsIMlmG7LnWp1MdrtMDdoqLM70Vk9fVxwF
        tuF5+//prsjsL/m+lUsXSxnHg8mGQ==
X-ME-Sender: <xms:f-hUYbrmdr62FTnPYdsXlbl0Wj8WkP9C34xw8QE5EF1_T79FLcINqw>
    <xme:f-hUYVp1WTNOW7ti2qfWiCEYpcuuHs6P_5f8jIG1HcoXSulOe9y0NSaelPR8IyRhe
    2qT3wgxnSRK>
X-ME-Received: <xmr:f-hUYYMr3m5eqCuOda0kKnzxdcaEK__XgnbDRpYrAvqpSys-W4eRd0BWkjrXR1Svb2NWLvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekfedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:f-hUYe6kV8uIzVd0ryQCsr-fNb6pxqQm04GUEByx-pVRWQxgYeg41w>
    <xmx:f-hUYa7RKv7Gd9arLtlRv5CsPQ1iDuHtpyOpdtZUKNA5EiLnhrMOPQ>
    <xmx:f-hUYWg37GH0kkD5pvxhjQLJPdM6Fm9l1nYYWFnIgo7M4UCTYjwPjQ>
    <xmx:gehUYRYK05tsOrO0fcCpwP5rkp-TealgkQDH6NNiCJAYrpZI5A9GIQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 18:28:12 -0400 (EDT)
Message-ID: <d54d122a7267eddbdcdeb4cb4fad6630e9e0ffe3.camel@themaw.net>
Subject: Re: [PATCH] kernfs: don't create a negative dentry if inactive node
 exists
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Hou Tao <houtao1@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Sep 2021 06:28:08 +0800
In-Reply-To: <YVQCE3vhK8z33Na2@kroah.com>
References: <163288467430.30015.16308604689059471602.stgit@mickey.themaw.net>
         <YVQCE3vhK8z33Na2@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-09-29 at 08:05 +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 29, 2021 at 11:04:34AM +0800, Ian Kent wrote:
> > In kernfs_iop_lookup() a negative dentry is created if there's no
> > kernfs
> > node associated with the dentry or the node is inactive.
> > 
> > But inactive kernfs nodes are meant to be invisible to the VFS and
> > creating a negative dentry for these can have unexpected side
> > effects
> > when the node transitions to an active state.
> > 
> > The point of creating negative dentries is to avoid the expensive
> > alloc/free cycle that occurs if there are frequent lookups for
> > kernfs
> > attributes that don't exist. So kernfs nodes that are not yet
> > active
> > should not result in a negative dentry being created so when they
> > transition to an active state VFS lookups can create an associated
> > dentry is a natural way.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Does this fix a specific commit and need a "Fixes:" tag?

Oh, of course yes, apologies, my bad.
I re-post it.


Ian

