Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592323276D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfFCE1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:27:09 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33187 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbfFCE1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:27:09 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id DBC2D123E;
        Mon,  3 Jun 2019 00:27:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2019 00:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=z9n041mVBoMx+lU8lmhyG3phiO4
        dUW1z+lGS4cRtV5s=; b=qksX5wzsra2tYynWZhegmrL/72S5klpK2oTRqt1rsWS
        smwkyrb0XtcXmGCptBP7qRU+Tj4zHAHmr9+Ttlc+ew0+ZwQ6nvucSxTzNvcGduBn
        B8VoEgz32xnmMBYWfyUcwASTDRzUqvOwadevUAYK3P0ckPFOhW05cJMGofWN5A4B
        itF8HvoxMseJaeg+wXqepRhT0FlG99OV1GWUNC4XjYgyYbC7kagv2gWf0gCb2whx
        uFWbMzr9HOGJjdUmIi+VdGpgaxrCcFzIWVh2nLO8HQxaU3m4DifGlsBEYdBpHuwr
        ZIoLqP80wNrqdrOOOkYm1hAKS/1XSx+2fz887CGstWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=z9n041
        mVBoMx+lU8lmhyG3phiO4dUW1z+lGS4cRtV5s=; b=kAhOfNEOtQESkNPK/QgoFR
        ioYb980SjObemXQqu5rWpyDRd9kll0AzwfrmTgmt5ANtRAzShlUkUSFrWbSZOSdE
        ceZpvYZVvYGypA3K5lm54xk6jdOYImRuothJQUXgBUyw8r8dus1DFuOwccpl12AF
        m3tMunnoo8ScUmzfSt47mHvYeJlQIHJK8z97fztcVDy8il89eoi0qrDB3/ujfEKb
        8PadHRzBbIgfJpFjpmfuVqDjBjlm6DpwOUgj+iFVRr9GPXBX7UIh/Zl65PceLu7m
        wi0xigtqFvyadEkmuJ0nINWGieKwcHzz8FI4JnanlJQzPiYGJCAXd9Dl0u4RnKfg
        ==
X-ME-Sender: <xms:l6H0XKQzXbuonbb3UP4TgqpY6CCDT0nQhhRv9OYBRUa1eGn-ZQMRkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:l6H0XP9KjYpAiNvTS1MfuedY3zJXLP_8ha9aJmBysHyOU8U1iIMJbA>
    <xmx:l6H0XJpReFxW0eBpwvqekelSmmqLqCwQk8bEHuS-1lQIDbrCTlaLeA>
    <xmx:l6H0XEmYSSgn9uupwEN-ZdKr_WuQiZ1e1gdfLfYAB3hbhrmAVyDdiQ>
    <xmx:m6H0XB25yu1H9mUyEsVQ0nMIxjwfKuCgZNRjUEfJrXi_-9cn1V0l_Q>
Received: from localhost (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6920938008B;
        Mon,  3 Jun 2019 00:27:02 -0400 (EDT)
Date:   Mon, 3 Jun 2019 14:26:20 +1000
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
Message-ID: <20190603042620.GA23098@eros.localdomain>
References: <20190520054017.32299-1-tobin@kernel.org>
 <20190520054017.32299-17-tobin@kernel.org>
 <20190521005740.GA9552@tower.DHCP.thefacebook.com>
 <20190521013118.GB25898@eros.localdomain>
 <20190521020530.GA18287@tower.DHCP.thefacebook.com>
 <20190529035406.GA23181@eros.localdomain>
 <20190529161644.GA3228@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529161644.GA3228@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.12.0 (2019-05-25)
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 04:16:51PM +0000, Roman Gushchin wrote:
> On Wed, May 29, 2019 at 01:54:06PM +1000, Tobin C. Harding wrote:
> > On Tue, May 21, 2019 at 02:05:38AM +0000, Roman Gushchin wrote:
> > > On Tue, May 21, 2019 at 11:31:18AM +1000, Tobin C. Harding wrote:
> > > > On Tue, May 21, 2019 at 12:57:47AM +0000, Roman Gushchin wrote:
> > > > > On Mon, May 20, 2019 at 03:40:17PM +1000, Tobin C. Harding wrote:
> > > > > > In an attempt to make the SMO patchset as non-invasive as possible add a
> > > > > > config option CONFIG_DCACHE_SMO (under "Memory Management options") for
> > > > > > enabling SMO for the DCACHE.  Whithout this option dcache constructor is
> > > > > > used but no other code is built in, with this option enabled slab
> > > > > > mobility is enabled and the isolate/migrate functions are built in.
> > > > > > 
> > > > > > Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
> > > > > > Slab Movable Objects infrastructure.
> > > > > 
> > > > > Hm, isn't it better to make it a static branch? Or basically anything
> > > > > that allows switching on the fly?
> > > > 
> > > > If that is wanted, turning SMO on and off per cache, we can probably do
> > > > this in the SMO code in SLUB.
> > > 
> > > Not necessarily per cache, but without recompiling the kernel.
> > > > 
> > > > > It seems that the cost of just building it in shouldn't be that high.
> > > > > And the question if the defragmentation worth the trouble is so much
> > > > > easier to answer if it's possible to turn it on and off without rebooting.
> > > > 
> > > > If the question is 'is defragmentation worth the trouble for the
> > > > dcache', I'm not sure having SMO turned off helps answer that question.
> > > > If one doesn't shrink the dentry cache there should be very little
> > > > overhead in having SMO enabled.  So if one wants to explore this
> > > > question then they can turn on the config option.  Please correct me if
> > > > I'm wrong.
> > > 
> > > The problem with a config option is that it's hard to switch over.
> > > 
> > > So just to test your changes in production a new kernel should be built,
> > > tested and rolled out to a representative set of machines (which can be
> > > measured in thousands of machines). Then if results are questionable,
> > > it should be rolled back.
> > > 
> > > What you're actually guarding is the kmem_cache_setup_mobility() call,
> > > which can be perfectly avoided using a boot option, for example. Turning
> > > it on and off completely dynamic isn't that hard too.
> > 
> > Hi Roman,
> > 
> > I've added a boot parameter to SLUB so that admins can enable/disable
> > SMO at boot time system wide.  Then for each object that implements SMO
> > (currently XArray and dcache) I've also added a boot parameter to
> > enable/disable SMO for that cache specifically (these depend on SMO
> > being enabled system wide).
> > 
> > All three boot parameters default to 'off', I've added a config option
> > to default each to 'on'.
> > 
> > I've got a little more testing to do on another part of the set then the
> > PATCH version is coming at you :)
> > 
> > This is more a courtesy email than a request for comment, but please
> > feel free to shout if you don't like the method outlined above.
> > 
> > Fully dynamic config is not currently possible because currently the SMO
> > implementation does not support disabling mobility for a cache once it
> > is turned on, a bit of extra logic would need to be added and some state
> > stored - I'm not sure it warrants it ATM but that can be easily added
> > later if wanted.  Maybe Christoph will give his opinion on this.
> 
> Perfect!

Hi Roman,

I'm about to post PATCH series.  I have removed all the boot time config
options in contrast to what I stated in this thread.  I feel it requires
some comment so as not to seem rude to you.  Please feel free to
re-raise these issues on the series if you feel it is a better place to
do it than on this thread.

I still hear you re making testing easier if there are boot parameters.
I don't have extensive experience testing on a large number of machines
so I have no basis to contradict what you said.

It was suggested to me that having switches to turn SMO off implies the
series is not ready.  I am claiming that SMO _is_ ready and also that it
has no negative effects (especially on the dcache).  I therefore think
this comment is pertinent.

So ... I re-did the boot parameters defaulting to 'on'.  However I could
then see no reason (outside of testing) to turn them off.  It seems ugly
to have code that is only required during testing and never after.
Please correct me if I'm wrong.

Finally I decided that since adding a boot parameter is trivial that
hackers could easily add one to test if they wanted to test a specific
cache.  Otherwise we just test 'patched kernel' vs 'unpatched kernel'.
Again, please correct me if I'm wrong.

So, that said, please feel free to voice your opinion as strongly as you
wish.  I am super appreciative of the time you have already taken to
look at these patches.  I hope I have made the best technical decision,
and I am totally open to being told I'm wrong :)

thanks,
Tobin.
