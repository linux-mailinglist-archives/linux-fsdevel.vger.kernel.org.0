Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86912048F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 07:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgFWFJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 01:09:19 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35173 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbgFWFJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:09:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B51711523;
        Tue, 23 Jun 2020 01:09:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Jun 2020 01:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        BhAMcLIJbzcVg3EcrY75vci3LWn+3/RFUgkWveFZuJ0=; b=P2oBais/wQsWyflW
        7M9CuhHGBe+s5rh4j5PHmrG4qqa2DSt9wgM1cw7/tCA5zfQ8gv/5GDqhvGnpTylm
        U2S+Npbk63AyxQ2uImjOxQVqm2atxUjc2UPJC/ba8QdIZ3MmLGmIWBj7kNl0lKna
        CY73qmyFvzPUIKRA1PNW9m7/2XqsMuVzz440nOuGPMJ5VvCOm+x33JSG3yTMFeIJ
        690S8xmclTGmELMYd+7OfrHja3dDHrRJk57Eb4g0dyzelKRdHtU18slccMC4leC7
        l3mJ8e+ZCmfJWB7czUSZCi8AssXZh8Qs5tt2kXeEZF5b6zDej7sDeSmwrDaqR6r/
        n5u1rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=BhAMcLIJbzcVg3EcrY75vci3LWn+3/RFUgkWveFZu
        J0=; b=NMW+DdGap8KZTIHQbvLwetLGlIMc1O63Ajx49FYNZWz9feJ85fKkCwMBR
        JxZoUnJtBBdsXzoE1fRToW8OnNHhzm/cyP+4CIIv4rLlHLzDFNfHRDRnlvpcyaze
        baHas4qlQxZRXSePwQniZN+YEQuanAZWtN0UAkuXxkshu5GmdHgBIxdPuhF7XGGY
        dbx5iobn3x+6R5CttamWqnJXoU7S6cftCK2siUw9izFhjfXwYXPyoD64lS12j5k7
        xRxjrDzxsbDTodYyzgzTmvw88D0SVtoDncoCC15L5JnIbYnNKtY8QiJ0XYu1PkQJ
        fm0IdpsFxceev2+iTdbBxNBNRJokg==
X-ME-Sender: <xms:fI7xXluCzZiiw5TyO3G3rPn_ipXv_Kh8ChYb0WjBB8R1gcNQKfCm5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrheegrdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:fI7xXudeeBAbIR-Bq7g_yMNCCzpZi5BqQm_le8CohSdrS7fSh-df7A>
    <xmx:fI7xXoxK2O5j-A5hPOmzdPa1sr5MA0oBQCs0QNAOa2ExQwMxqU7uUw>
    <xmx:fI7xXsPxBGssEkTCtHfpuAEsYU-F6aScDjkPrOtgjGeWR-qYVEyy4A>
    <xmx:fY7xXoknoAQHhVn0UYRW0KtPaEG0jwRInryev1DhlCXM-RaokFavHQ>
Received: from mickey.themaw.net (unknown [118.208.54.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D807306743C;
        Tue, 23 Jun 2020 01:09:12 -0400 (EDT)
Message-ID: <2ead27912e2a852bffb1477e8720bdadb591628d.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jun 2020 13:09:08 +0800
In-Reply-To: <20200622180306.GA1917323@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
         <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
         <20200619222356.GA13061@mtj.duckdns.org>
         <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
         <20200622174845.GB13061@mtj.duckdns.org>
         <20200622180306.GA1917323@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-06-22 at 20:03 +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 22, 2020 at 01:48:45PM -0400, Tejun Heo wrote:
> > Hello, Ian.
> > 
> > On Sun, Jun 21, 2020 at 12:55:33PM +0800, Ian Kent wrote:
> > > > > They are used for hotplugging and partitioning memory. The
> > > > > size of
> > > > > the
> > > > > segments (and thus the number of them) is dictated by the
> > > > > underlying
> > > > > hardware.
> > > > 
> > > > This sounds so bad. There gotta be a better interface for that,
> > > > right?
> > > 
> > > I'm still struggling a bit to grasp what your getting at but ...
> > 
> > I was more trying to say that the sysfs device interface with per-
> > object
> > directory isn't the right interface for this sort of usage at all.
> > Are these
> > even real hardware pieces which can be plugged in and out? While
> > being a
> > discrete piece of hardware isn't a requirement to be a device model
> > device,
> > the whole thing is designed with such use cases on mind. It
> > definitely isn't
> > the right design for representing six digit number of logical
> > entities.
> > 
> > It should be obvious that representing each consecutive memory
> > range with a
> > separate directory entry is far from an optimal way of representing
> > something like this. It's outright silly.
> 
> I agree.  And again, Ian, you are just "kicking the problem down the
> road" if we accept these patches.  Please fix this up properly so
> that
> this interface is correctly fixed to not do looney things like this.

Fine, mitigating this problem isn't the end of the story, and you
don't want to do accept a change to mitigate it because that could
mean no further discussion on it and no further work toward solving
it.

But it seems to me a "proper" solution to this will cross a number
of areas so this isn't just "my" problem and, as you point out, it's
likely to become increasingly problematic over time.

So what are your ideas and recommendations on how to handle hotplug
memory at this granularity for this much RAM (and larger amounts)?

Ian

