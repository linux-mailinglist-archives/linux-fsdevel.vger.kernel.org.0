Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785D939CB09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFEUy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 5 Jun 2021 16:54:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54334 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:54:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lpdHX-00ENY9-9y; Sat, 05 Jun 2021 14:52:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lpdHF-006HEL-7F; Sat, 05 Jun 2021 14:52:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ian Kent <raven@themaw.net>
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
In-Reply-To: <9b62c14a7fe71076107ab6dca9bd9fadac4ea08d.camel@themaw.net> (Ian
        Kent's message of "Sat, 05 Jun 2021 11:19:34 +0800")
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
        <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
        <87czt2q2pl.fsf@disp2133>
        <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
        <87y2bqli8b.fsf@disp2133>
        <6ae8e5f843855c2c14b58227340e2a0070ef1b6c.camel@themaw.net>
        <87k0n9ln52.fsf@disp2133>
        <9b62c14a7fe71076107ab6dca9bd9fadac4ea08d.camel@themaw.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sat, 05 Jun 2021 15:52:10 -0500
Message-ID: <871r9gkpad.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lpdHF-006HEL-7F;;;mid=<871r9gkpad.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185yts+/340p6bjibOs4qlawakhrp21EVU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMHurry_00,XMSubLong,
        XM_B_Unicode,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMHurry_00 Hurry and Do Something
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Ian Kent <raven@themaw.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15053 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (0.1%), b_tie_ro: 12 (0.1%), parse: 1.43
        (0.0%), extract_message_metadata: 22 (0.1%), get_uri_detail_list: 4.4
        (0.0%), tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.36 (0.0%),
        tests_pri_-900: 1.26 (0.0%), tests_pri_-90: 194 (1.3%), check_bayes:
        192 (1.3%), b_tokenize: 14 (0.1%), b_tok_get_all: 16 (0.1%),
        b_comp_prob: 5 (0.0%), b_tok_touch_all: 152 (1.0%), b_finish: 1.22
        (0.0%), tests_pri_0: 6600 (43.8%), check_dkim_signature: 0.64 (0.0%),
        check_dkim_adsp: 6009 (39.9%), poll_dns_idle: 14199 (94.3%),
        tests_pri_10: 2.0 (0.0%), tests_pri_500: 8210 (54.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Fri, 2021-06-04 at 09:28 -0500, Eric W. Biederman wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > On Thu, 2021-06-03 at 17:02 -0500, Eric W. Biederman wrote:
>> > > Miklos Szeredi <miklos@szeredi.hu> writes:
>> > > 
>> > > > On Thu, 3 Jun 2021 at 19:26, Eric W. Biederman < 
>> > > > ebiederm@xmission.com> wrote:
>> > > > > 
>> > > > > Ian Kent <raven@themaw.net> writes:
>> > > > > 
>> > > > > > If there are many lookups for non-existent paths these
>> > > > > > negative
>> > > > > > lookups
>> > > > > > can lead to a lot of overhead during path walks.
>> > > > > > 
>> > > > > > The VFS allows dentries to be created as negative and
>> > > > > > hashed,
>> > > > > > and caches
>> > > > > > them so they can be used to reduce the fairly high overhead
>> > > > > > alloc/free
>> > > > > > cycle that occurs during these lookups.
>> > > > > > 
>> > > > > > Signed-off-by: Ian Kent <raven@themaw.net>
>> > > > > > ---
>> > > > > >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++--
>> > > > > > ----
>> > > > > > ----------------
>> > > > > >  1 file changed, 33 insertions(+), 22 deletions(-)
>> > > > > > 
>> > > > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>> > > > > > index 4c69e2af82dac..5151c712f06f5 100644
>> > > > > > --- a/fs/kernfs/dir.c
>> > > > > > +++ b/fs/kernfs/dir.c
>> > > > > > @@ -1037,12 +1037,33 @@ static int
>> > > > > > kernfs_dop_revalidate(struct
>> > > > > > dentry *dentry, unsigned int flags)
>> > > > > >       if (flags & LOOKUP_RCU)
>> > > > > >               return -ECHILD;
>> > > > > > 
>> > > > > > -     /* Always perform fresh lookup for negatives */
>> > > > > > -     if (d_really_is_negative(dentry))
>> > > > > > -             goto out_bad_unlocked;
>> > > > > > +     mutex_lock(&kernfs_mutex);
>> > > > > > 
>> > > > > >       kn = kernfs_dentry_node(dentry);
>> > > > > > -     mutex_lock(&kernfs_mutex);
>> > > > > 
>> > > > > Why bring kernfs_dentry_node inside the mutex?
>> > > > > 
>> > > > > The inode lock of the parent should protect negative to
>> > > > > positive
>> > > > > transitions not the kernfs_mutex.  So moving the code inside
>> > > > > the mutex looks unnecessary and confusing.
>> > > > 
>> > > > Except that d_revalidate() may or may not be called with parent
>> > > > lock
>> > > > held.
>> > 
>> > Bringing the kernfs_dentry_node() inside taking the mutex is
>> > probably
>> > wasteful, as you say, oddly the reason I did it that conceptually
>> > it
>> > makes sense to me since the kernfs node is being grabbed. But it
>> > probably isn't possible for a concurrent unlink so is not
>> > necessary.
>> > 
>> > Since you feel strongly about I can change it.
>> > 
>> > > 
>> > > I grant that this works because kernfs_io_lookup today holds
>> > > kernfs_mutex over d_splice_alias.
>> > 
>> > Changing that will require some thought but your points about
>> > maintainability are well taken.
>> > 
>> > > 
>> > > The problem is that the kernfs_mutex only should be protecting
>> > > the
>> > > kernfs data structures not the vfs data structures.
>> > > 
>> > > Reading through the code history that looks like a hold over from
>> > > when
>> > > sysfs lived in the dcache before it was reimplemented as a
>> > > distributed
>> > > file system.  So it was probably a complete over sight and
>> > > something
>> > > that did not matter.
>> > > 
>> > > The big problem is that if the code starts depending upon the
>> > > kernfs_mutex (or the kernfs_rwsem) to provide semantics the rest
>> > > of
>> > > the
>> > > filesystems does not the code will diverge from the rest of the
>> > > filesystems and maintenance will become much more difficult.
>> > > 
>> > > Diverging from other filesystems and becoming a maintenance pain
>> > > has
>> > > already been seen once in the life of sysfs and I don't think we
>> > > want
>> > > to
>> > > go back there.
>> > > 
>> > > Further extending the scope of lock, when the problem is that the
>> > > locking is causing problems seems like the opposite of the
>> > > direction
>> > > we
>> > > want the code to grow.
>> > > 
>> > > I really suspect all we want kernfs_dop_revalidate doing for
>> > > negative
>> > > dentries is something as simple as comparing the timestamp of the
>> > > negative dentry to the timestamp of the parent dentry, and if the
>> > > timestamp has changed perform the lookup.  That is roughly what
>> > > nfs does today with negative dentries.
>> > > 
>> > > The dentry cache will always lag the kernfs_node data structures,
>> > > and
>> > > that is fundamental.  We should take advantage of that to make
>> > > the
>> > > code
>> > > as simple and as fast as we can not to perform lots of work that
>> > > creates
>> > > overhead.
>> > > 
>> > > Plus the kernfs data structures should not change much so I
>> > > expect
>> > > there will be effectively 0 penalty in always performing the
>> > > lookup
>> > > of a
>> > > negative dentry when the directory itself has changed.
>> > 
>> > This sounds good to me.
>> > 
>> > In fact this approach should be able to be used to resolve the
>> > potential race Miklos pointed out in a much simpler way, not to
>> > mention the revalidate simplification itself.
>> > 
>> > But isn't knowing whether the directory has changed harder to
>> > do than checking a time stamp?
>> > 
>> > Look at kernfs_refresh_inode() and it's callers for example.
>> > 
>> > I suspect that would require bringing back the series patch to use
>> > a generation number to identify directory changes (and also getting
>> > rid of the search in revalidate).
>> 
>> In essence it is a simple as looking at a sequence number or a
>> timestamp
>> to detect the directory has changed.
>
> Yes, both Miklos and Al suggested using a simple revision to detect
> changes to the parent. I did that early on and I don't think I grokked
> what Al recommended and ended up with something more complex than was
> needed. So I dropped it because I wanted to keep the changes to a
> minimum.
>
> But a quick test, bringing that patch back, and getting rid of the
> search in revalidate works well. It's as effective at eliminating
> contention I saw with d_alloc_parallel() for the case of a lot of
> deterministic accesses to the same non-existent file as the racy
> search method I had there, perhaps a bit better, it's certainly
> more straight forward.
>
>> 
>> In practice there are always details that make things more
>> complicated.
>> 
>> I was actually wondering if the approach should be to have an seqlock
>> around an individual directories rbtree.  I think that would give a
>> lot
>> of potential for rcu style optimization during lookups.
>
> Yeah, it's tempting, but another constraint I had is to not increase
> the size of the kernfs_node struct (Greg and Tejun) and there's a
> hole in the node union variant kernfs_elem_dir at least big enough
> for sizeof(pointer) so I can put the revision there. And, given the
> simplification in revalidate, as well as that extra code being pretty
> straight forward itself, it's not too bad from the minimal change
> POV.
>
> So I'd like to go with using a revision for now.

No objection from me.

Eric
