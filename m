Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CBC39C56F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhFEDVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 23:21:35 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48429 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhFEDVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:21:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5529F5805EC;
        Fri,  4 Jun 2021 23:19:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 04 Jun 2021 23:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        aVapU30GTGL7h10NNa9Jn5JWfcPuCAQN0aXRyj8greI=; b=vLMywz+NApIbpusS
        x5MTcybQvvpn6M1FiuKkg0zMl4tkj6IuRl3vI4qBvKLp/YuCLU04agejLsUz9lA3
        pngvQrrLNzei9fyQaZl9oHQI/SYl6mSQIYbcyfYLEvbwP1hnV71KLWO/0dgwyJRU
        SKXUjtsSvO6wTfhojGfem5LetYM/MEy8m3I+aeeg6i3v4b8VLUMa3biCeNVvVUnY
        N6/apa3KoN27VJdL1DMbpR/hc9jp6qQbqMbsy4VJaapcKehbbci7PwOwpFAHH6bO
        iFCJ9Es7Kek1hZtfuIzP3CGYZ2D3G92a13FyIdxRud8wYru6Q2BJXrhpDlsq0+yD
        nwA9qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=aVapU30GTGL7h10NNa9Jn5JWfcPuCAQN0aXRyj8gr
        eI=; b=rQ9b2fj1uG3O7rmUgpuFPyAci23CfLZ2ITBF8oWM1PLsLuRbuadmLJG17
        e2fEzM5ZirrU3Ok3OPi8est9ebN43GNGQkTSLRt2+6NfKwHO4alglX1QZahTqhC1
        Dyyvo/4kWNrtcvcWhp53hVshOWvYUvKr/PKsp0R2faobUW5n29t9w2FLg7wges9k
        s46ca1LMFAVdYFjKzGKRZcsbHWaB+1yPvmAuPtakFSkgAJH9dqzhf1Y8oVYJ5O3x
        +mVhJMm1Fl6Z/C2zeju9s0Z156Jr+NMfn5I5CNjxKsE5AVdJhFwn/qpo7wO1SQw8
        vi4rhPwfaGFs5VMI7CVxhtzmCRFow==
X-ME-Sender: <xms:UO26YCMiNtS3z8AgzhEw-25IsdCo_V2vVQT0tYgar0doZVPgkxwRiw>
    <xme:UO26YA8X8heQp-GV7dDU4TnrxgBZoFH5PuHfgwQCabZNRXk0LOKR6f62nWkdtuUjF
    Og6qqvx_m0u>
X-ME-Received: <xmr:UO26YJSj_-0HlasvwU90BiEZLDaeSDE-fErEqrwUxBV0VOf7Sg9K9qYLlpr4qh_7vFMzGdlcA3Cp_kd7D9zco0gQRQDHScX7TeL4HhG3QnxtJAJ6IrtQFXP7kj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:UO26YCsKI2wZnGLupgKUAtlGB0r5pqC_nHwEqJISigP9vBXili4ZSw>
    <xmx:UO26YKe69WsZVtCfdC6gDmZoFz0bToEvaHqLOaw6qj-dvydTMvdgBQ>
    <xmx:UO26YG0fLSJTn-QDvSa_9zjkhb3esRoO5lxPRDgi2QRtSE8NG9tVVQ>
    <xmx:Uu26YLVE7BiF18dvi8TP8Hz-cNcE71daNJz2DLhLVdKJJ_fWE4DYFQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jun 2021 23:19:39 -0400 (EDT)
Message-ID: <9b62c14a7fe71076107ab6dca9bd9fadac4ea08d.camel@themaw.net>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 05 Jun 2021 11:19:34 +0800
In-Reply-To: <87k0n9ln52.fsf@disp2133>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
         <87czt2q2pl.fsf@disp2133>
         <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
         <87y2bqli8b.fsf@disp2133>
         <6ae8e5f843855c2c14b58227340e2a0070ef1b6c.camel@themaw.net>
         <87k0n9ln52.fsf@disp2133>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-06-04 at 09:28 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Thu, 2021-06-03 at 17:02 -0500, Eric W. Biederman wrote:
> > > Miklos Szeredi <miklos@szeredi.hu> writes:
> > > 
> > > > On Thu, 3 Jun 2021 at 19:26, Eric W. Biederman < 
> > > > ebiederm@xmission.com> wrote:
> > > > > 
> > > > > Ian Kent <raven@themaw.net> writes:
> > > > > 
> > > > > > If there are many lookups for non-existent paths these
> > > > > > negative
> > > > > > lookups
> > > > > > can lead to a lot of overhead during path walks.
> > > > > > 
> > > > > > The VFS allows dentries to be created as negative and
> > > > > > hashed,
> > > > > > and caches
> > > > > > them so they can be used to reduce the fairly high overhead
> > > > > > alloc/free
> > > > > > cycle that occurs during these lookups.
> > > > > > 
> > > > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > > > ---
> > > > > >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++--
> > > > > > ----
> > > > > > ----------------
> > > > > >  1 file changed, 33 insertions(+), 22 deletions(-)
> > > > > > 
> > > > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > > > > index 4c69e2af82dac..5151c712f06f5 100644
> > > > > > --- a/fs/kernfs/dir.c
> > > > > > +++ b/fs/kernfs/dir.c
> > > > > > @@ -1037,12 +1037,33 @@ static int
> > > > > > kernfs_dop_revalidate(struct
> > > > > > dentry *dentry, unsigned int flags)
> > > > > >       if (flags & LOOKUP_RCU)
> > > > > >               return -ECHILD;
> > > > > > 
> > > > > > -     /* Always perform fresh lookup for negatives */
> > > > > > -     if (d_really_is_negative(dentry))
> > > > > > -             goto out_bad_unlocked;
> > > > > > +     mutex_lock(&kernfs_mutex);
> > > > > > 
> > > > > >       kn = kernfs_dentry_node(dentry);
> > > > > > -     mutex_lock(&kernfs_mutex);
> > > > > 
> > > > > Why bring kernfs_dentry_node inside the mutex?
> > > > > 
> > > > > The inode lock of the parent should protect negative to
> > > > > positive
> > > > > transitions not the kernfs_mutex.  So moving the code inside
> > > > > the mutex looks unnecessary and confusing.
> > > > 
> > > > Except that d_revalidate() may or may not be called with parent
> > > > lock
> > > > held.
> > 
> > Bringing the kernfs_dentry_node() inside taking the mutex is
> > probably
> > wasteful, as you say, oddly the reason I did it that conceptually
> > it
> > makes sense to me since the kernfs node is being grabbed. But it
> > probably isn't possible for a concurrent unlink so is not
> > necessary.
> > 
> > Since you feel strongly about I can change it.
> > 
> > > 
> > > I grant that this works because kernfs_io_lookup today holds
> > > kernfs_mutex over d_splice_alias.
> > 
> > Changing that will require some thought but your points about
> > maintainability are well taken.
> > 
> > > 
> > > The problem is that the kernfs_mutex only should be protecting
> > > the
> > > kernfs data structures not the vfs data structures.
> > > 
> > > Reading through the code history that looks like a hold over from
> > > when
> > > sysfs lived in the dcache before it was reimplemented as a
> > > distributed
> > > file system.  So it was probably a complete over sight and
> > > something
> > > that did not matter.
> > > 
> > > The big problem is that if the code starts depending upon the
> > > kernfs_mutex (or the kernfs_rwsem) to provide semantics the rest
> > > of
> > > the
> > > filesystems does not the code will diverge from the rest of the
> > > filesystems and maintenance will become much more difficult.
> > > 
> > > Diverging from other filesystems and becoming a maintenance pain
> > > has
> > > already been seen once in the life of sysfs and I don't think we
> > > want
> > > to
> > > go back there.
> > > 
> > > Further extending the scope of lock, when the problem is that the
> > > locking is causing problems seems like the opposite of the
> > > direction
> > > we
> > > want the code to grow.
> > > 
> > > I really suspect all we want kernfs_dop_revalidate doing for
> > > negative
> > > dentries is something as simple as comparing the timestamp of the
> > > negative dentry to the timestamp of the parent dentry, and if the
> > > timestamp has changed perform the lookup.  That is roughly what
> > > nfs does today with negative dentries.
> > > 
> > > The dentry cache will always lag the kernfs_node data structures,
> > > and
> > > that is fundamental.  We should take advantage of that to make
> > > the
> > > code
> > > as simple and as fast as we can not to perform lots of work that
> > > creates
> > > overhead.
> > > 
> > > Plus the kernfs data structures should not change much so I
> > > expect
> > > there will be effectively 0 penalty in always performing the
> > > lookup
> > > of a
> > > negative dentry when the directory itself has changed.
> > 
> > This sounds good to me.
> > 
> > In fact this approach should be able to be used to resolve the
> > potential race Miklos pointed out in a much simpler way, not to
> > mention the revalidate simplification itself.
> > 
> > But isn't knowing whether the directory has changed harder to
> > do than checking a time stamp?
> > 
> > Look at kernfs_refresh_inode() and it's callers for example.
> > 
> > I suspect that would require bringing back the series patch to use
> > a generation number to identify directory changes (and also getting
> > rid of the search in revalidate).
> 
> In essence it is a simple as looking at a sequence number or a
> timestamp
> to detect the directory has changed.

Yes, both Miklos and Al suggested using a simple revision to detect
changes to the parent. I did that early on and I don't think I grokked
what Al recommended and ended up with something more complex than was
needed. So I dropped it because I wanted to keep the changes to a
minimum.

But a quick test, bringing that patch back, and getting rid of the
search in revalidate works well. It's as effective at eliminating
contention I saw with d_alloc_parallel() for the case of a lot of
deterministic accesses to the same non-existent file as the racy
search method I had there, perhaps a bit better, it's certainly
more straight forward.

> 
> In practice there are always details that make things more
> complicated.
> 
> I was actually wondering if the approach should be to have an seqlock
> around an individual directories rbtree.  I think that would give a
> lot
> of potential for rcu style optimization during lookups.

Yeah, it's tempting, but another constraint I had is to not increase
the size of the kernfs_node struct (Greg and Tejun) and there's a
hole in the node union variant kernfs_elem_dir at least big enough
for sizeof(pointer) so I can put the revision there. And, given the
simplification in revalidate, as well as that extra code being pretty
straight forward itself, it's not too bad from the minimal change
POV.

So I'd like to go with using a revision for now.

> 
> 
> 
> All of the little details and choices on how to optimize this is why
> I
> was suggesting splitting the patch in two.  Starting first with
> something that allows negative dentries.  Then adds the tests so that
> the negative dentries are not always invalidated.  That should allow
> focusing on the tricky bits.
> 
> Eric


