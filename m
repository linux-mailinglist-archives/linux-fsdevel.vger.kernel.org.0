Return-Path: <linux-fsdevel+bounces-3951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BBC7FA523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8771B2122A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5334572;
	Mon, 27 Nov 2023 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056411A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 07:48:17 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:45924)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r7dqH-0037sg-6R; Mon, 27 Nov 2023 08:48:13 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:47674 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r7dqF-001Jou-Tb; Mon, 27 Nov 2023 08:48:12 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org,  Miklos Szeredi <miklos@szeredi.hu>
References: <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
	<CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
	<20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
	<20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
	<20231127063842.GG38156@ZenIV>
Date: Mon, 27 Nov 2023 09:47:47 -0600
In-Reply-To: <20231127063842.GG38156@ZenIV> (Al Viro's message of "Mon, 27 Nov
	2023 06:38:42 +0000")
Message-ID: <87jzq3nqos.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r7dqF-001Jou-Tb;;;mid=<87jzq3nqos.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19Ivoqmgj6NYRmk04vHCeMgMvlWWNyi8uM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 655 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.8 (0.7%), b_tie_ro: 3.4 (0.5%), parse: 1.41
	(0.2%), extract_message_metadata: 15 (2.2%), get_uri_detail_list: 5
	(0.8%), tests_pri_-2000: 8 (1.2%), tests_pri_-1000: 1.97 (0.3%),
	tests_pri_-950: 0.94 (0.1%), tests_pri_-900: 0.79 (0.1%),
	tests_pri_-90: 70 (10.8%), check_bayes: 69 (10.5%), b_tokenize: 11
	(1.6%), b_tok_get_all: 14 (2.1%), b_comp_prob: 4.7 (0.7%),
	b_tok_touch_all: 37 (5.6%), b_finish: 0.77 (0.1%), tests_pri_0: 540
	(82.4%), check_dkim_signature: 0.45 (0.1%), check_dkim_adsp: 7 (1.1%),
	poll_dns_idle: 6 (0.9%), tests_pri_10: 1.82 (0.3%), tests_pri_500: 7
	(1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sun, Nov 26, 2023 at 06:41:41PM +0000, Al Viro wrote:
>
>> d_invalidate() situation is more subtle - we need to sort out its interplay
>> with d_splice_alias().
>> 
>> More concise variant of the scenario in question:
>> * we have /mnt/foo/bar and a lot of its descendents in dcache on client
>> * server does a rename, after which what used to be /mnt/foo/bar is /mnt/foo/baz
>> * somebody on the client does a lookup of /mnt/foo/bar and gets told by
>> the server that there's no directory with that name anymore.
>> * that somebody hits d_invalidate(), unhashes /mnt/foo/bar and starts
>> evicting its descendents
>> * We try to mount something on /mnt/foo/baz/blah.  We look up baz, get
>> an fhandle and notice that there's a directory inode for it (/mnt/foo/bar).
>> d_splice_alias() picks the bugger and moves it to /mnt/foo/baz, rehashing
>> it in process, as it ought to.  Then we find /mnt/foo/baz/blah in dcache and 
>> mount on top of it.
>> * d_invalidate() finishes shrink_dcache_parent() and starts hunting for
>> submounts to dissolve.  And finds the mount we'd done.  Which mount quietly
>> disappears.
>> 
>> Note that from the server POV the thing had been moved quite a while ago.
>> No server-side races involved - all it seeem is a couple of LOOKUP in the
>> same directory, one for the old name, one for the new.
>> 
>> On the client on the mounter side we have an uneventful mount on /mnt/foo/baz,
>> which had been there on server at the time we started and which remains in
>> place after mount we'd created suddenly disappears.
>> 
>> For the thread that ended up calling d_invalidate(), they'd been doing e.g.
>> stat on a pathname that used to be there a while ago, but currently isn't.
>> They get -ENOENT and no indication that something odd might have happened.
>> 
>> >From ->d_revalidate() point of view there's also nothing odd happening -
>> dentry is not a mountpoint, it stays in place until we return and there's
>> no directory entry with that name on in its parent.  It's as clear-cut
>> as it gets - dentry is stale.
>> 
>> The only overlap happening there is d_splice_alias() hitting in the middle
>> of already started d_invalidate().
>> 
>> For a while I thought that ff17fa561a04 "d_invalidate(): unhash immediately"
>> and 3a8e3611e0ba "d_walk(): kill 'finish' callback" might have something
>> to do with it, but the same problem existed prior to that.
>> 
>> FWIW, I suspect that the right answer would be along the lines of
>> 	* if d_splice_alias() does move an exsiting (attached) alias in
>> place, it ought to dissolve all mountpoints in subtree being moved.
>> There might be subtleties, but in case when that __d_unalias() happens
>> due to rename on server this is definitely the right thing to do.
>> 	* d_invalidate() should *NOT* do anything with dentry that
>> got moved (including moved by d_splice_alias()) from the place we'd
>> found it in dcache.  At least d_invalidate() done due to having
>> ->d_revalidate() return 0.
>> 	* d_invalidate() should dissolve all mountpoints in the
>> subtree that existed when it got started (and found the victim
>> still unmoved, that is).  It should (as it does) prevent any
>> new mountpoints added in that subtree, unless the mountpoint
>> to be had been moved (spliced) out.  What it really shouldn't
>> do is touch the mountpoints that are currently outside of it
>> due to moves.
>> 
>> I'm going to look around and see if we have any weird cases where
>> d_splice_alias() is used for things like "correct the case of
>> dentry name on a case-mangled filesystem" - that would presumably
>> not want to dissolve any submounts.  I seem to recall seeing
>> some shite of that sort, but that was a long time ago.
>> 
>> Eric, Miklos - it might be a good idea if you at least took a
>> look at whatever comes out of that (sub)thread; I'm trying to
>> reconstruct the picture, but the last round of serious reworking
>> of that area had been almost 10 years ago and your recollections
>> of the considerations back then might help.  I realize that they
>> are probably rather fragmentary (mine definitely are) and any
>> analysis will need to be redone on the current tree, but...

By subthread I assume you are referring to the work to that generalized
check_submounts_and_drop into the current d_invalidate.

My memory is that there were deliberate restrictions on where
d_revalidate could be called so as not to mess with mounts.

I believe those restrictions either prevented or convinced us it
prevented nasty interactions between d_invalidate and d_splice_alias.

There is a lot going on there.  I remember one of the relevant
restrictions was marking dentries dont_mount, and inodes S_DEAD
in unlink and rmdir.

But even without out that marking if d_invalidate is called
from d_revalidate the inode and all of it's dentries must be
dead because the inode is stale and most go.  There should
be no resurrecting it at that point.

I suspect the most fruitful way to think of the d_invalidate vs
d_splice_alias races is an unlink vs rename race.


I don't think the mechanism matters, but deeply and fundamentally
if we detect a directory inode is dead we need to stick with
that decision and not attempt to resurrect it with d_splice_alias.


Looking at ext4 and f2fs it appears when case folding they are calling
d_invalidate before the generic code can, and before marking like
dont_mount happen.  Is that the tie in with where the current
conversation comes in?


> TBH, I wonder if we ought to have d_invalidate() variant that would
> unhash the dentry in question,

You mean like the current d_invalidate does?  It calls __d_drop which
unhashes the thing and prevent lookups.  You even pointed to the change
that added that in the previous email.  The only thing that does not
happen currently is marking the dentry as unhashed.

Looking the rmdir code uses not only dont_mount but marks the
inode S_DEAD as well.

Right now we can't even get to d_splice_alias unless the original
dentry is unhashed.

So I suspect it isn't d_invalidate you are fighting.

> do a variant of shrink_dcache_parent()
> that would report if there had been any mountpoints and if there
> had been any, do namespace_lock() and go hunting for mounts in that
> subtree, moving corresponding struct mountpoint to a private list
> as we go (removing them from mountpoint hash chains, that it).  Then
> have them all evicted after we'd finished walking the subtree...

>
> The tricky part will be lock ordering - right now we have the
> mountpoint hash protected by mount_lock (same as mount hash, probably
> worth splitting anyway) and that nests outside of ->d_lock.

I don't get get it.

All we have to do is to prevent the inode lookup from succeeding
if we have decided the inode has been deleted.  It may be a little
more subtle the path of the inode we are connecting goes through
a dentry that is being invalidated.

But either need to prevent it in the lookup that leads to d_alloc,
or prevent the new dentry from being attached.

I know d_splice_alias takes the rename_lock to prevent some of those
races.


I hope that helps on the recollection front.


I am confused what is going on with ext4 and f2fs.  I think they
are calling d_invalidate when all they need to call is d_drop.

Eric

