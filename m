Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568EB41CF7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 00:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbhI2Wwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 18:52:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39731 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346417AbhI2Wwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:52:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DC5D5C00ED;
        Wed, 29 Sep 2021 18:51:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 Sep 2021 18:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        /SmpU8+zuhfCdM1F4tBy43UJVJESbBMrVSDv8V0+hsM=; b=ZooT6Wo17uDeqWhA
        JzZvdNwHGFCwnBtwMSFoHQWa2+ibDLx3MgQIvebs8DLPyHa98ts1xdA6WrJF7LtJ
        oPKuFdO+OkBUKk10+uVAq9ocUpFZx9dfONzK0ndhLrRyOJaipCUbrlpU3RzGvrDi
        kYJDesiqb4eGfB4KfCHTpoztPUqB9OVNis+dEaGUU8vJWVpMtT5ciB7ZwJZHnvpI
        GWNFRfxE9izpSRLRKAi8Jqshevhoiq1BS7g1u1PEw0b4LjWoo5FrJfsaRfyV9jSr
        SLYPpLBNz6jjt7egqhZo28GA2iX1d0Rx12VANvrCKC5iZJQFhUiDH0tf+l+toEdS
        j+eoiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/SmpU8+zuhfCdM1F4tBy43UJVJESbBMrVSDv8V0+h
        sM=; b=K1rX6rFqOT4VP4yUORHS9r9Ohu15BQWLde3fiLqJnCQWCgncTNcv5Q7OF
        lVN5ZpujXdBtWjWLqTafjaDWDgNzOTTxiJsIsBtAVoKmtLXGRASvUuBOLMFAkZCb
        0FM9L3PyWqGDa/efrYCY0iETk6ivr1jWZS1mceSN2Z5kckpAi6FaeMIgtbfOH9dz
        9h+/4bJ7oAVj+NqxSXczIO7pSttZQvqXpqeTwPHtSRe8M4cUC7JlAfKaI8ZgqW7f
        8++zX4gHR/alP1SHUn/v+PAH2vgVm4Lu0xW8rnj73yBr3Lmh4CFMWa3BMzqwWyOu
        DvsGCeZLgoRvX8tcGxMRGo/ANwXiQ==
X-ME-Sender: <xms:1-1UYbLB4ykPLFZRHxSI1FmLclt-Hfx2XwHZlPGHdlAenYW4H8RVuQ>
    <xme:1-1UYfKADao8vDauuWssRZg2_hgz-mrrVKXiAlgUJbZmwWd5nakDzfDf9G1Whq_49
    zwY-44by6r0>
X-ME-Received: <xmr:1-1UYTurETxYWSckYoMq7EmFgFbDuI03vrde9ZpFCtj9m1luLCK7p-4NGENmZxq_Xrgp5M8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekfedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:1-1UYUZWpLyimArHZ4Zx2OFmaln-u9Zb9CAYHfx3V74M0-dKWo_BIA>
    <xmx:1-1UYSZkR3A-QwTiAV1ojrqbGGKhX6OL2scxeomtmQo1qv2GEiwcKw>
    <xmx:1-1UYYBkTroxpqGPUVqjIdtS94GmwmB3hJRqSikdsVR6PNqMOYcFgw>
    <xmx:1-1UYa4rgWiuIFb77e1qv3IHxxEXk9T7yJ6W6v3BmFuIXCik28-WzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 18:50:59 -0400 (EDT)
Message-ID: <32c970d1f93a02207cb1746852e51bae4b2691c8.camel@themaw.net>
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
Date:   Thu, 30 Sep 2021 06:50:56 +0800
In-Reply-To: <d54d122a7267eddbdcdeb4cb4fad6630e9e0ffe3.camel@themaw.net>
References: <163288467430.30015.16308604689059471602.stgit@mickey.themaw.net>
         <YVQCE3vhK8z33Na2@kroah.com>
         <d54d122a7267eddbdcdeb4cb4fad6630e9e0ffe3.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-09-30 at 06:28 +0800, Ian Kent wrote:
> On Wed, 2021-09-29 at 08:05 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 29, 2021 at 11:04:34AM +0800, Ian Kent wrote:
> > > In kernfs_iop_lookup() a negative dentry is created if there's no
> > > kernfs
> > > node associated with the dentry or the node is inactive.
> > > 
> > > But inactive kernfs nodes are meant to be invisible to the VFS
> > > and
> > > creating a negative dentry for these can have unexpected side
> > > effects
> > > when the node transitions to an active state.
> > > 
> > > The point of creating negative dentries is to avoid the expensive
> > > alloc/free cycle that occurs if there are frequent lookups for
> > > kernfs
> > > attributes that don't exist. So kernfs nodes that are not yet
> > > active
> > > should not result in a negative dentry being created so when they
> > > transition to an active state VFS lookups can create an
> > > associated
> > > dentry is a natural way.
> > > 
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > ---
> > >  fs/kernfs/dir.c |    9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > Does this fix a specific commit and need a "Fixes:" tag?
> 
> Oh, of course yes, apologies, my bad.
> I re-post it.

But in case your ok to add it on my behalf it should be:
Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")

> 
> 
> Ian


