Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7E23D67E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHFFnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 01:43:24 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44399 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726093AbgHFFnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:43:23 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id B1A6FC10;
        Thu,  6 Aug 2020 01:43:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Aug 2020 01:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        Awpd/iaKMwO3xriBXgL7yRd6ZsbwGEwHcJ9iVbEAWAs=; b=1krTwyayDva0Q1mK
        m6P8LfWxFtP0gbC5ZJ4RXLrW4Xe3B+4DvLjbWeiGFj6KbGknmmigNG2sczhB0pcG
        13nhBFr7d4/GOjO6ol86Fq6R0tks5VS0Y8ZasfxsrRZlVdjrKyq8YzfFcG6cksw2
        fmiIS+SwhFecOGr6hs2vrTnBCgZZQAyTlJlvrrSvijUecgyWUFcre4aMZaTcWp8V
        o2ffi+CgrWkpBgpdrNBWsVFhZsR0EaRMyXM9kMFOYp48W1uOibG7iUx/HBqCzMqT
        3qy2MXnvbgV1QDuMCz5n5aCDC7hrTdsaymx+RfzFPZP9v/yME/r2wN+n572rU40y
        6Rdb5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Awpd/iaKMwO3xriBXgL7yRd6ZsbwGEwHcJ9iVbEAW
        As=; b=q4byEJlGrJpU4Clt62ffMOHvyBeHqc8C49IeF6pTmi7wr38QHrxKsMNpl
        y5dLQJjehgjmpRhgdyrHqIJM96MnLMEqv2uIEfVh+6c/g4ip2shY47lR8d6Cmmlf
        OwIWw4AENYOwphwTZwXTQgCLOcFzMdAQseX4NITk+jA3z/mDNi6EVqnH4hA94Cex
        M4teDxu4YBDH0MvD4NF99T/BrjbDMC3Qv4FyRD4oxYERb2ttk1kc7Cj6nXM71eh/
        J4RQK7qglO5YRf3zWv639KugPAyujWjKJ56z+0VJ2tvQNHtTQAqFRmKOTC7Z2CxZ
        GBj2WEEHNmbzR/5lxWi9FFCZQsfqw==
X-ME-Sender: <xms:d5grXypyMjU5lPa9O4PGPfW_TL8izh0JfU_S0FxO4JBNUUSrSvVtcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeelgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrhedvrddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:d5grXwp0uuu8oMFPdvGqzuBMRqEA3BQKG45IOM9gIDwhnWZDUE42EQ>
    <xmx:d5grX3O8PH9YKBd8nAHvF_fed9saYJjKkXqKcvJbWWRWqa2xQdb7Ww>
    <xmx:d5grXx77End6UsceFnSpNn6SWZS4jkW4VNblRQK2WzSbvaqpHFr_2w>
    <xmx:eZgrX-x5TRGWifJQA8UOi0mdSPMkYSl7bB2iSPKyppoLGJ0yjVu8kiLTR-w>
Received: from mickey.themaw.net (unknown [118.208.52.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5174328005E;
        Thu,  6 Aug 2020 01:43:14 -0400 (EDT)
Message-ID: <61ad7b12b1d242247b066e6ffbf5f9382bc57b2a.camel@themaw.net>
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver
 #21]
From:   Ian Kent <raven@themaw.net>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Aug 2020 13:43:11 +0800
In-Reply-To: <20200805193303.GM23808@casper.infradead.org>
References: <CAJfpegtOguKOGWxv-sA_C9eSWG_3Srnj_k=oW-wSHNprCipFVg@mail.gmail.com>
         <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
         <20200804104108.GC32719@miu.piliscsaba.redhat.com>
         <2306029.1596636828@warthog.procyon.org.uk>
         <2315925.1596641410@warthog.procyon.org.uk>
         <20200805193303.GM23808@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 20:33 +0100, Matthew Wilcox wrote:
> On Wed, Aug 05, 2020 at 04:30:10PM +0100, David Howells wrote:
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > idr_alloc_cyclic() seems to be a good template for doing the
> > > lower
> > > 32bit allocation, and we can add code to increment the high 32bit
> > > on
> > > wraparound.
> > > 
> > > Lots of code uses idr_alloc_cyclic() so I guess it shouldn't be
> > > too
> > > bad in terms of memory use or performance.
> > 
> > It's optimised for shortness of path and trades memory for
> > performance.  It's
> > currently implemented using an xarray, so memory usage is dependent
> > on the
> > sparseness of the tree.  Each node in the tree is 576 bytes and in
> > the worst
> > case, each one node will contain one mount - and then you have to
> > backfill the
> > ancestry, though for lower memory costs.
> > 
> > Systemd makes life more interesting since it sets up a whole load
> > of
> > propagations.  Each mount you make may cause several others to be
> > created, but
> > that would likely make the tree more efficient.
> 
> I would recommend using xa_alloc and ignoring the ID assigned from
> xa_alloc.  Looking up by unique ID is then a matter of iterating
> every
> mount (xa_for_each()) looking for a matching unique ID in the mount
> struct.  That's O(n) search, but it's faster than a linked list, and
> we
> don't have that many mounts in a system.

How many is not many, 5000, 10000, I agree that 30000 plus is fairly
rare, even for the autofs direct mount case I hope the implementation
here will help to fix.

Ian

