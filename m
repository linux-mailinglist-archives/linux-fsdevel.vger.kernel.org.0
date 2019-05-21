Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF97245A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 03:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfEUBcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 21:32:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41409 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbfEUBcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 21:32:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3E68295B1;
        Mon, 20 May 2019 21:32:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 May 2019 21:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=XT/UdYnmx7GrDaJa60CFoxeSSHk
        /OGQKeLYVIbFsryY=; b=lB8rpyD1L4izyfnU4fBk6mH7b53SchEIWKjue1YVeRl
        NaxeXlXU3AaPgw36mvOLaTbLtOUPaDqMeT+GaLwkFcvhHpd8QV5CTYxWtlLjz7YE
        zCMCS+eSHHf3MGGbaplZ9ZHBqMEbvDTmovpvTZNIl3eC79ObvEjTPK4so04BUjH4
        xTz/EIuOAoBWxpMI1bk03H3M2qey9Wmhj0nxuo24oYJolUm31DvtrPDTfLwxua0U
        AJyYFkychOiXckDOeIr78aAlFUCDhP4WE2x7fE6WlwlzijeFQ5ve14lm4INg0KpF
        OjFJFr0Uy8Vp9Yzk4ITBJG7Qkrj8hpH1+jnXnIDGkbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XT/UdY
        nmx7GrDaJa60CFoxeSSHk/OGQKeLYVIbFsryY=; b=Berg9P+nH9RaKmggVwHyFY
        ApnFW6s0HIqbC+uMEYd8rjX2+6kWRsRoQp+raQ2T9qfB7WC+tagKTopn3HoXZ27s
        39IJChaiXtznrwkVkZTcAJSBT0LGYCBfs7/B8Ht/4L7CPKM6pME6GRqigMejfStF
        T3CfnV8eyI/SSLfHCcngFmO5+CE/puyR5j7NHmCWaEVDWYDPNSMreOeK8bB+sNkZ
        SLCOgynt+12z9I141bI2lzYDPCZimSWYxkjaUqUcNPrr9FyjJrDg2RnX1X3zh5sO
        W7Wg09xwB2quTckKG1cV1Fbj0QeZMUrx4GOQKLPk/zRmgjUjYBMGW7mnY5NClFTw
        ==
X-ME-Sender: <xms:D1XjXAfATuU3Uag8wco2cm4s08ym59tHCiZtH1Cc9iosm-DbvUQ9jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtledggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdduheeirddvtdefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:D1XjXOIir_QTYGS-KY606mTBNFzQq-3A2lmPVbGkjZzrv9G36JbWGw>
    <xmx:D1XjXEkD0kkSzgiUKY5Y1K_HxDHL4yq4zvtG4DB2Yo4nWmGOySzttA>
    <xmx:D1XjXBWseqKrRdaZT63yAe7xvv8CMZwaOc-enQ-nA1EZod8iZkHtRQ>
    <xmx:E1XjXIGw8idhiXFZEFQXC6iOs0Uu7FRcPRe_sWu08XKXEIq31RyoTw>
Received: from localhost (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id D925610379;
        Mon, 20 May 2019 21:31:57 -0400 (EDT)
Date:   Tue, 21 May 2019 11:31:18 +1000
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
Message-ID: <20190521013118.GB25898@eros.localdomain>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521005740.GA9552@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 12:57:47AM +0000, Roman Gushchin wrote:
> On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrote:
> > In an attempt to make the SMO patchset as non-invasive as possible add a
> > config option CONFIG_DCACHE_SMO (under "Memory Management options") for
> > enabling SMO for the DCACHE.  Whithout this option dcache constructor is
> > used but no other code is built in, with this option enabled slab
> > mobility is enabled and the isolate/migrate functions are built in.
> > 
> > Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
> > Slab Movable Objects infrastructure.
> 
> Hm, isn't it better to make it a static branch? Or basically anything
> that allows switching on the fly?

If that is wanted, turning SMO on and off per cache, we can probably do
this in the SMO code in SLUB.

> It seems that the cost of just building it in shouldn't be that high.
> And the question if the defragmentation worth the trouble is so much
> easier to answer if it's possible to turn it on and off without rebooting.

If the question is 'is defragmentation worth the trouble for the
dcache', I'm not sure having SMO turned off helps answer that question.
If one doesn't shrink the dentry cache there should be very little
overhead in having SMO enabled.  So if one wants to explore this
question then they can turn on the config option.  Please correct me if
I'm wrong.

The ifdef guard is there so memory management is not having any negative
effects on the dcache/VFS (no matter how small).  It also means that the
VFS guys don't have to keep an eye on what SMO is doing, they can
just configure SMO out.  The dcache is already fairly complex, I'm not
sure adding complexity to it without good reason is sound practice.  At
best SMO is only going to by mildly useful to the dcache so I feel we
should err on the side of caution.

Open to ideas.

Thanks,
Tobin.
