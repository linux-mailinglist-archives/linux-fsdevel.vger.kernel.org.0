Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CA245BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 03:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfEUBpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 21:45:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56245 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbfEUBpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 21:45:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id ADF3BBFD1;
        Mon, 20 May 2019 21:45:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 May 2019 21:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=zSyPy+Mn5LVlJ+FlCj33Ng1Vj0N
        3aj5sXaJqqEQXdJg=; b=aVzZIMke8RgIn6fgRezyJIRNTdJNmy5BsAfcf1rzNh9
        kfmmri+unp7PyZsnxtkTgHSaodOlSW0TTlKw/4fzSUEUmmtotFcMflrouEawmetl
        yMmjYklNKZ2LGYBcwcppzbcYXLRiwTA4QcWSB/ZX7H9FsqXPJxD/cRXvqR7HSnbl
        zmsZE4Ph1MtGXYkMjSGtQYC7AFO14uXoLyZbbHwa5QkUlBhb3yBrrCFILt19iBEf
        kwl8tl11sbo2aN+IhYgJFA3CPgZgs+3qDPLfVBdw4eJznoV2b2tluB4D4CqOi8Cz
        8hEcWr+0tr06AIlzR9mIdoTTxdmg5oLtQIMgMM4lQRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zSyPy+
        Mn5LVlJ+FlCj33Ng1Vj0N3aj5sXaJqqEQXdJg=; b=wogBIOI9ILp8CO+jyYf2m/
        4O6hf7ZDRufCxFGdAvGp6xsRPd+RZznXygF6h6C8FzaK2UCm+jexQBRPR5a036PZ
        ragLxfROMNdB/0r9JMwaS38EjvpdLnYb6fIAMRTYkPNQkcbQryDr2NjG42OxjcBW
        byUfI68V1yvb882goJR9nc6oZZ2w4KokjWRhkD9kaYfk1ROH6zxZnlbBDN2gDvJO
        7blXnkWpM6kS89cTpb9wYgh63AMAU4w6AKN4L9TLTCXZXNm6HDKxrTN6+h/1QAZv
        nk5lOnZ1kaxo4AMVAoe6nuYv6JnFpbD1aDar6wzuzMu+RpE4pza1gfrJUfw8GXDw
        ==
X-ME-Sender: <xms:QFjjXGtb0C56eqETPYVgual6pqtTl3Xv4VQd2dU88ZWfBDZlqDgMDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdduheeirddvtdefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QFjjXGIUKhDO5k2QKvBTG4W_hsJowdoztPZE9oKq0Iey0Y_y7DE0TQ>
    <xmx:QFjjXKeDFCQTJi5XPVg3TWkSTJwYsjmcT--3DtyGNqhPO6u28SGLQA>
    <xmx:QFjjXIW67bTni76x_zcwROybxmtiemrH031fommHrIE4s3RokU4WTA>
    <xmx:RFjjXCYvXZUddiAM0f0wNqhYLLKvySulEgfuHrNdsxa024x5Zp9wow>
Received: from localhost (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id B78C810378;
        Mon, 20 May 2019 21:45:35 -0400 (EDT)
Date:   Tue, 21 May 2019 11:44:57 +1000
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
Subject: Re: [RFC PATCH v5 13/16] slub: Enable balancing slabs across nodes
Message-ID: <20190521014457.GA27676@eros.localdomain>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-14-tobin@kernel.org>
 <20190521010404.GB9552@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521010404.GB9552@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 01:04:10AM +0000, Roman Gushchin wrote:
> On Mon, May 20, 2019 at 03:40:14PM +1000, Tobin C. Harding wrote:
> > We have just implemented Slab Movable Objects (SMO).  On NUMA systems
> > slabs can become unbalanced i.e. many slabs on one node while other
> > nodes have few slabs.  Using SMO we can balance the slabs across all
> > the nodes.
> > 
> > The algorithm used is as follows:
> > 
> >  1. Move all objects to node 0 (this has the effect of defragmenting the
> >     cache).
> 
> This already sounds dangerous (or costly). Can't it be done without
> cross-node data moves?
>
> > 
> >  2. Calculate the desired number of slabs for each node (this is done
> >     using the approximation nr_slabs / nr_nodes).
> 
> So that on this step only (actual data size - desired data size) has
> to be moved?

This is just the most braindead algorithm I could come up with.  Surely
there are a bunch of things that could be improved.  Since I don't know
the exact use case it seemed best not to optimize for any one use case.

I'll review, comment on, and test any algorithm you come up with!

thanks,
Tobin.
