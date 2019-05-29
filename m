Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF052D45C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 05:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfE2Dyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 23:54:52 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35683 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfE2Dyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 23:54:52 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6E1D2412;
        Tue, 28 May 2019 23:54:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 May 2019 23:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=C/3/rW+cjxuts9eVyQG2YcqoLaE
        6ta6yRwttYTGwP58=; b=RMh4cRIsKgvvRcIMot+ceI2cTTlj13kxgcoWm6kZIPH
        WjcYyrakjoXyJiU+GEGzkS5eGbRQvxvJZRDZGYWjh5gMXojfocIQ2RX9fi05CilS
        fGpXxY3VxjS9MY/cl4h+iV9f1sF0kGt8UaNDTYhmtzIX7dBcKELY4/nb3MVEDBUz
        XmTPyA04wGUcTiwE6aNJ/6pfj51DdSSXu5gl7UeVCulxSEVgct7ST1qOZxHR7uX3
        kKMYk5/2b5eFAaBhPiPGs5Tu+eERe2tF7s0/F/PZXfFXowwwXTgGveU40uh86YmB
        K4+15yYcpmWiP85wqAbPtVI9Kuqkqu+7yJn6r6DCYIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C/3/rW
        +cjxuts9eVyQG2YcqoLaE6ta6yRwttYTGwP58=; b=B2/amyXQNQrAt5O5X5wA2c
        kQXkfC58JIoqnldg4y5haXy4B4EFmzbG3+1KIj5gOBUvWpHjeTCCq/gNQ3IV3B1s
        tbTgzXWtlzXOEBvKIebJ3Pm+R16stKjtlyY1FKv/pvgM7vOsQylV9gR+Y2BmB+89
        4pD1C1LDtxu4hAN6sNGli0641uDLZZLA6WasO2Op9wUPfkJ5j9so+haCKKEcyxAV
        MO2PSO+XiT3dRZ4jYAHKJb0J5bz9YfV10NlNyty9WGWdW0ZxbE0KdavYrMSJcqDu
        kval6nTSZ6MuQTF0HBrMCWTts35keQ96t34e1ylhxqzUh3Qli+VYYwDDTMfY9Y4Q
        ==
X-ME-Sender: <xms:hwLuXKhJ8RpwWx5tIqyI_Ce6OXOUXeGfNro2shZbSc5OvKV6bltjcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddviedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrddujedurdefuddrudeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hwLuXH8KVmtakAESo4imAubhYDVFiySgffEyqi2XkhhLUrCHFCkkgQ>
    <xmx:hwLuXNuvDUVOUc2IMg1Dy7fucpBptyRh4Y3lwSRsycK7zi5wEtEZvA>
    <xmx:hwLuXLow9eJpDk2WF-cm25BgUIWZXSjzV1SdCSLbUdNbKL63Hlv5DQ>
    <xmx:igLuXPl89IlGmwN4RVkrZqHseV-vqGJpKBqMU-IptL3Qun9Rde6_0g>
Received: from localhost (124-171-31-144.dyn.iinet.net.au [124.171.31.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7A6E80064;
        Tue, 28 May 2019 23:54:46 -0400 (EDT)
Date:   Wed, 29 May 2019 13:54:06 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Roman Gushchin <guro@fb.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 16/16] dcache: Add CONFIG_DCACHE_SMO
Message-ID: <20190529035406.GA23181@eros.localdomain>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
 <20190521013118.GB25898@eros.localdomain>
 <20190521020530.GA18287@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521020530.GA18287@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.12.0 (2019-05-25)
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 02:05:38AM +0000, Roman Gushchin wrote:
> On Tue, May 21, 2019 at 11:31:18AM +1000, Tobin C. Harding wrote:
> > On Tue, May 21, 2019 at 12:57:47AM +0000, Roman Gushchin wrote:
> > > On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrote:
> > > > In an attempt to make the SMO patchset as non-invasive as possible add a
> > > > config option CONFIG_DCACHE_SMO (under "Memory Management options") for
> > > > enabling SMO for the DCACHE.  Whithout this option dcache constructor is
> > > > used but no other code is built in, with this option enabled slab
> > > > mobility is enabled and the isolate/migrate functions are built in.
> > > > 
> > > > Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
> > > > Slab Movable Objects infrastructure.
> > > 
> > > Hm, isn't it better to make it a static branch? Or basically anything
> > > that allows switching on the fly?
> > 
> > If that is wanted, turning SMO on and off per cache, we can probably do
> > this in the SMO code in SLUB.
> 
> Not necessarily per cache, but without recompiling the kernel.
> > 
> > > It seems that the cost of just building it in shouldn't be that high.
> > > And the question if the defragmentation worth the trouble is so much
> > > easier to answer if it's possible to turn it on and off without rebooting.
> > 
> > If the question is 'is defragmentation worth the trouble for the
> > dcache', I'm not sure having SMO turned off helps answer that question.
> > If one doesn't shrink the dentry cache there should be very little
> > overhead in having SMO enabled.  So if one wants to explore this
> > question then they can turn on the config option.  Please correct me if
> > I'm wrong.
> 
> The problem with a config option is that it's hard to switch over.
> 
> So just to test your changes in production a new kernel should be built,
> tested and rolled out to a representative set of machines (which can be
> measured in thousands of machines). Then if results are questionable,
> it should be rolled back.
> 
> What you're actually guarding is the kmem_cache_setup_mobility() call,
> which can be perfectly avoided using a boot option, for example. Turning
> it on and off completely dynamic isn't that hard too.

Hi Roman,

I've added a boot parameter to SLUB so that admins can enable/disable
SMO at boot time system wide.  Then for each object that implements SMO
(currently XArray and dcache) I've also added a boot parameter to
enable/disable SMO for that cache specifically (these depend on SMO
being enabled system wide).

All three boot parameters default to 'off', I've added a config option
to default each to 'on'.

I've got a little more testing to do on another part of the set then the
PATCH version is coming at you :)

This is more a courtesy email than a request for comment, but please
feel free to shout if you don't like the method outlined above.

Fully dynamic config is not currently possible because currently the SMO
implementation does not support disabling mobility for a cache once it
is turned on, a bit of extra logic would need to be added and some state
stored - I'm not sure it warrants it ATM but that can be easily added
later if wanted.  Maybe Christoph will give his opinion on this.

thanks,
Tobin.
