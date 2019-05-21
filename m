Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3FFA24642
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEUDVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 23:21:11 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42429 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbfEUDVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 23:21:11 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2019 23:21:10 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B9681E3BC;
        Mon, 20 May 2019 23:15:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 May 2019 23:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xK51z/4F3tloMY+tzPug3rex9T4
        6SW7cKlO10EK5SOU=; b=YqeOQlx5ShquIqkxOAUmbnJsp8m/qja6Z41Yjq+YdPF
        VUpy3QyeomaB393THjyzAfuZlrXUwO8Krn2pJ24Ahxh5Bv9bLY9rmnOrTShDoVrZ
        0yjuCDs1mZbQs5I1ciWEUqDdCXqe3i75xs7avcDFkb8uFHr9HQdloN28XH6TPgOd
        EPYiYg/Gj3UAr5GM4Vw7rG1EqKXfQ+N6dDbyKkFOua9jm5DDr55YrhjMvbmnYOdr
        kaOli+q7ca3InzmMZ3tGYMe9bROdzeUQXDV4WdJFNKkQwdWJKMyin4jdaEpvF/w1
        9O861pvSU6K3IUsdGwKxvxA9MJ61cNoA9OGavASYN+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xK51z/
        4F3tloMY+tzPug3rex9T46SW7cKlO10EK5SOU=; b=6IekBOxajm2IVukVZgys4+
        VFDH9sDnFB1A8ggg85ndJ9idlwUvvxh/S+1eYgLmJiVfb0vPp3A+SlHon4r/w17v
        XLdimeduBfCBkasf8KT4RyD9V2tSW32SYzG2NCJOCAYeFiyLxztbHRYYfgcwmedj
        hLtueQRXoOudV4iCDoy+Uh4PFw8JH3jdwxqXzvny0APBpEXaPk2+I+Eay9OegJ5Q
        wiWApBBiFbKT9wh2mYYCkskz00jhYZMzzCp7MMHr73Gm+/3jJxBX42059bNExVaO
        e47CPN+QULGa6FZgUU+WTO4Ab7fA2y2LzsiG6UDRwGFFP1alUc4pHMPiV6hTumyQ
        ==
X-ME-Sender: <xms:ZG3jXF1p4HYxa2LaaW9d1VPD3E0cdYN1ULFc9jETDLokYHIzlbhU4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtledgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdduheeirddvtdefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ZG3jXGGI23jma_u4tPvE-79o_Ify65-SmXl_a9fDSvsx0oXuPoa53g>
    <xmx:ZG3jXMjFqrHjaBbgvErqbhS495QD0n443l2a0nBcc44p05o43_74tQ>
    <xmx:ZG3jXBDkf7juigVj-jf56R0rsFRD5t93EweudCkglm2D49K8arvjmQ>
    <xmx:Zm3jXLlxqiGTgLnufQRjCpfoGRFxTM7UVI3q8oCm_4q_7I_8GG0iTg>
Received: from localhost (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21E9380059;
        Mon, 20 May 2019 23:15:47 -0400 (EDT)
Date:   Tue, 21 May 2019 13:15:08 +1000
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
Message-ID: <20190521031508.GA31794@eros.localdomain>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
 <20190521013118.GB25898@eros.localdomain>
 <20190521020530.GA18287@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521020530.GA18287@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
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
> 
> Of course, it's up to you, it's just probably easier to find new users
> of a new feature, when it's easy to test it.

Ok, cool - I like it.  Will add for next version.

thanks,
Tobin.
