Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EC1E07EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgEYHXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 03:23:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52133 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388951AbgEYHXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 03:23:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 54ECB5C0073;
        Mon, 25 May 2020 03:23:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 May 2020 03:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        qw3U0CcqTo0cQeMDt+HS3gLTNE8CpK3Apl/Gtn5gyiw=; b=M+NHqWcV3e6Dl6cX
        MmzZCPQf3JaTVzLakiNvkneJQUA5WA9R+kWATP62u0feYzRH6GWcDRSA+psz8pNa
        hAOU1yKWdQiOMoqCfEQdj0uFRX4uEj+QyIZVS+yN9KLfpT2U+MV4sBt+LC4jX4ZW
        QT63eoHRMMokTBqbCa6G/2/m+AEqaUCNgopyU6NvSH0mQRhhKnfDcmaNclD5kjRC
        YmGXbjmao+YDGlX2SG0m5PJkMEZ7XR25Hf1BKINCiSP6l7NJtWa6Oo1fylLYG2xG
        xiVzePIPK+EXzd28VwVRYO90nWOQimYcMEzL8pf2XtOyhYOPrZJIHeXdHhuAMNmK
        uCldTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=qw3U0CcqTo0cQeMDt+HS3gLTNE8CpK3Apl/Gtn5gy
        iw=; b=0wtSGzV1CP6240VoYMM4RT9ZZFuQpRETg6vGRPUjqOMU3Ca08HSIzDSdk
        spwXYraB1Fwy5SxZ1kCPdPR9viQIAAsFKXVFGEZ8E8JvyYos4Gpk4dkhCxPstgZK
        PT05ZhVNCsovXD+/yqAjz7OE8RbE5G5J01x8NBJKYxVlvd4K79lhHKKYlkcowWDE
        i/Fkk2jidF9GdBjpLz+0YjoD/ByVCXWasQ9XcgnwhC5hgd44ArVEFF7pn+nk9IOe
        mrfcU3qxfUJCzoVAg9J//b7njrw5V+q+cXWroVYixTN6fTJ4tU+2Pcz5r+hhpQcu
        5nqNjKH5Rya0qZvCZGFOq4IiYqfQQ==
X-ME-Sender: <xms:f3LLXs1zI0Q62uDw2dghUkhOGvR1tuCn0JjNeGWnBQvFekqEancsUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epfeefteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecu
    kfhppeduudekrddvtdekrddujeekrddukeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:f3LLXnGYFKy91zeZ2ss4hglmbL2KTU8gxQ-adUXizPXG8R1l6qi4AQ>
    <xmx:f3LLXk7GRkOz31e7ASSubgJ-587PmRXRnfANdUaJsF3Ci_995-7w2Q>
    <xmx:f3LLXl3vF_RzAGWoJxq7AJZYvdyqGH1_eAyvsx91iGTgIy63pLK23Q>
    <xmx:gHLLXgPS_9gYpCZ0-xtk-nhZ4niLrVPWtRfK4x5UAZKJNPvecwbYVA>
Received: from mickey.themaw.net (unknown [118.208.178.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71ADD3066552;
        Mon, 25 May 2020 03:23:39 -0400 (EDT)
Message-ID: <b9e8f8171096813c76df3719719bdda87033fd78.camel@themaw.net>
Subject: Re: [PATCH 0/4] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 May 2020 15:23:35 +0800
In-Reply-To: <20200525061616.GA57080@kroah.com>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
         <20200525061616.GA57080@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-05-25 at 08:16 +0200, Greg Kroah-Hartman wrote:
> On Mon, May 25, 2020 at 01:46:59PM +0800, Ian Kent wrote:
> > For very large systems with hundreds of CPUs and TBs of RAM booting
> > can
> > take a very long time.
> > 
> > Initial reports showed that booting a configuration of several
> > hundred
> > CPUs and 64TB of RAM would take more than 30 minutes and require
> > kernel
> > parameters of udev.children-max=1024
> > systemd.default_timeout_start_sec=3600
> > to prevent dropping into emergency mode.
> > 
> > Gathering information about what's happening during the boot is a
> > bit
> > challenging. But two main issues appeared to be, a large number of
> > path
> > lookups for non-existent files, and high lock contention in the VFS
> > during
> > path walks particularly in the dentry allocation code path.
> > 
> > The underlying cause of this was believed to be the sheer number of
> > sysfs
> > memory objects, 100,000+ for a 64TB memory configuration.
> 
> Independant of your kernfs changes, why do we really need to
> represent
> all of this memory with that many different "memory objects"?  What
> is
> that providing to userspace?
> 
> I remember Ben Herrenschmidt did a lot of work on some of the kernfs
> and
> other functions to make large-memory systems boot faster to remove
> some
> of the complexity in our functions, but that too did not look into
> why
> we needed to create so many objects in the first place.
> 
> Perhaps you might want to look there instead?

I presumed it was a hardware design requirement or IBM VM design
requirement.

Perhaps Rick can find out more on that question.

Ian

