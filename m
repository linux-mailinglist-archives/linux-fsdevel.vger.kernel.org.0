Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83839B0BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFDDQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 23:16:48 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:43969 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229704AbhFDDQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:16:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 67BA410AE;
        Thu,  3 Jun 2021 23:14:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Jun 2021 23:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        zem9Q4RlcvGrfCCj+kfnOYD6QehzuYzskFj0/CwIV2g=; b=hSsCPICFHVjLNEUo
        MYRkpSKV9SscCWJGWNB9Y6TLjEoiJpITwEo+5aQuw4tZw6k9vc7Enc0wrEO3Ooez
        BtCvxNYVzq4uVxsnuRxsg5V97dobzIa5CUAIBpczFz+IUK+uZ42E+79kGHsDtOoj
        9KOJ7XHWnVK1/YdKdS3xTyuCa3BwupsPq5y/F7AQkmAVWruicI4lUxRimwjyqghv
        VIHu1wfX2BxUKMlaaOTjxRQQluytQYbmKuuDMmM74LJmHic8Sp9qdjh1U+cmvbJM
        CHSrI95DEET/6PhAhYFGtmllBPt3Whs4PFl4Kv/ebC4CQc0TDoIBTWTLmIogrQIY
        TrY3bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=zem9Q4RlcvGrfCCj+kfnOYD6QehzuYzskFj0/CwIV
        2g=; b=PdYh/LpgXeX82k13TZWLEqTl578E6C13LCiwYpTZI3Gqy+7v+J67nLz+w
        qsKF5Skt/l4zVDmBasFdqa369GBGEmJvilSHXCzNOSgQU6z7fnvyZRNg+g9X5ozL
        bwwqMlWd45ggbP556TxL4dpkGR/Nh/cC+Mf0N1V7x7t9tTllE94ww9s1P2cExHsQ
        my1LiTRCzfVI3B/egtndn+elzqfxVT9AI2YaeFiax8DbeTyDiBi8us096ZiBDDCj
        deeKgwu8rLUhXcMbmC7zh59fGvnxH4etoc4Xd0lakbXEeW+5GB4npvLHaURI8+7E
        HCSCrjSKmLIZ02R7usdiKCGDZ4NEA==
X-ME-Sender: <xms:r5q5YDCbQoQ1UZ3yIst0QmfQN6dPEUb-3EfaO5Vlgyw0JsoFGfJ7Cw>
    <xme:r5q5YJhP_x-BJX6jNgFrVW9_o2iKsMx-qmeltcFsr4Ymr5LjosRl3K2k8LeGmCAOg
    j6dJoAwMNSR>
X-ME-Received: <xmr:r5q5YOnLtyjJ8MeaiGp0o1paxWcH1Q9U4lIXAnAF2uyW-yxch-Aa4ovt_E2zxHaBIpT5ZVLvde7ZjeNNZNR9qnpJfWArWvq_bVJjKzG5hyMKzI2lxQzPJlgkuTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedttddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:sJq5YFyUJMWx4dWd2_jNSdRcXB8KxyITu50uKDm8v6oTY6pCSoXJow>
    <xmx:sJq5YISX8ZaTj6lWpbPdas2WnVo4ZwNCV57exVNSPA-pBYVAtirZJw>
    <xmx:sJq5YIa3lPkX5M3C4A-70ekDlsK3kyFtwqMV5_qCpVD3CCURcTGFYA>
    <xmx:spq5YNISve5sUovxVsu8Ue5QJDuGno1UqzhXHA1JwLN_SoArq4hFjx3zB9Y>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 23:14:51 -0400 (EDT)
Message-ID: <6ae8e5f843855c2c14b58227340e2a0070ef1b6c.camel@themaw.net>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jun 2021 11:14:47 +0800
In-Reply-To: <87y2bqli8b.fsf@disp2133>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
         <87czt2q2pl.fsf@disp2133>
         <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
         <87y2bqli8b.fsf@disp2133>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-06-03 at 17:02 -0500, Eric W. Biederman wrote:
> Miklos Szeredi <miklos@szeredi.hu> writes:
> 
> > On Thu, 3 Jun 2021 at 19:26, Eric W. Biederman < 
> > ebiederm@xmission.com> wrote:
> > > 
> > > Ian Kent <raven@themaw.net> writes:
> > > 
> > > > If there are many lookups for non-existent paths these negative
> > > > lookups
> > > > can lead to a lot of overhead during path walks.
> > > > 
> > > > The VFS allows dentries to be created as negative and hashed,
> > > > and caches
> > > > them so they can be used to reduce the fairly high overhead
> > > > alloc/free
> > > > cycle that occurs during these lookups.
> > > > 
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > ---
> > > >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++------
> > > > ----------------
> > > >  1 file changed, 33 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > > index 4c69e2af82dac..5151c712f06f5 100644
> > > > --- a/fs/kernfs/dir.c
> > > > +++ b/fs/kernfs/dir.c
> > > > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct
> > > > dentry *dentry, unsigned int flags)
> > > >       if (flags & LOOKUP_RCU)
> > > >               return -ECHILD;
> > > > 
> > > > -     /* Always perform fresh lookup for negatives */
> > > > -     if (d_really_is_negative(dentry))
> > > > -             goto out_bad_unlocked;
> > > > +     mutex_lock(&kernfs_mutex);
> > > > 
> > > >       kn = kernfs_dentry_node(dentry);
> > > > -     mutex_lock(&kernfs_mutex);
> > > 
> > > Why bring kernfs_dentry_node inside the mutex?
> > > 
> > > The inode lock of the parent should protect negative to positive
> > > transitions not the kernfs_mutex.  So moving the code inside
> > > the mutex looks unnecessary and confusing.
> > 
> > Except that d_revalidate() may or may not be called with parent
> > lock
> > held.

Bringing the kernfs_dentry_node() inside taking the mutex is probably
wasteful, as you say, oddly the reason I did it that conceptually it
makes sense to me since the kernfs node is being grabbed. But it
probably isn't possible for a concurrent unlink so is not necessary.

Since you feel strongly about I can change it.

> 
> I grant that this works because kernfs_io_lookup today holds
> kernfs_mutex over d_splice_alias.

Changing that will require some thought but your points about
maintainability are well taken.

> 
> The problem is that the kernfs_mutex only should be protecting the
> kernfs data structures not the vfs data structures.
> 
> Reading through the code history that looks like a hold over from
> when
> sysfs lived in the dcache before it was reimplemented as a
> distributed
> file system.  So it was probably a complete over sight and something
> that did not matter.
> 
> The big problem is that if the code starts depending upon the
> kernfs_mutex (or the kernfs_rwsem) to provide semantics the rest of
> the
> filesystems does not the code will diverge from the rest of the
> filesystems and maintenance will become much more difficult.
> 
> Diverging from other filesystems and becoming a maintenance pain has
> already been seen once in the life of sysfs and I don't think we want
> to
> go back there.
> 
> Further extending the scope of lock, when the problem is that the
> locking is causing problems seems like the opposite of the direction
> we
> want the code to grow.
> 
> I really suspect all we want kernfs_dop_revalidate doing for negative
> dentries is something as simple as comparing the timestamp of the
> negative dentry to the timestamp of the parent dentry, and if the
> timestamp has changed perform the lookup.  That is roughly what
> nfs does today with negative dentries.
> 
> The dentry cache will always lag the kernfs_node data structures, and
> that is fundamental.  We should take advantage of that to make the
> code
> as simple and as fast as we can not to perform lots of work that
> creates
> overhead.
> 
> Plus the kernfs data structures should not change much so I expect
> there will be effectively 0 penalty in always performing the lookup
> of a
> negative dentry when the directory itself has changed.

This sounds good to me.

In fact this approach should be able to be used to resolve the
potential race Miklos pointed out in a much simpler way, not to
mention the revalidate simplification itself.

But isn't knowing whether the directory has changed harder to
do than checking a time stamp?

Look at kernfs_refresh_inode() and it's callers for example.

I suspect that would require bringing back the series patch to use
a generation number to identify directory changes (and also getting
rid of the search in revalidate).

Ian

