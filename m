Return-Path: <linux-fsdevel+bounces-3970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A27FA8D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A32281695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA13D3B7;
	Mon, 27 Nov 2023 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A652A198;
	Mon, 27 Nov 2023 10:19:41 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:44548)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r7gCp-007QBU-6v; Mon, 27 Nov 2023 11:19:39 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:58050 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r7gCo-006hy6-31; Mon, 27 Nov 2023 11:19:38 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>,
  tytso@mit.edu,  linux-f2fs-devel@lists.sourceforge.net,
  ebiggers@kernel.org,  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org,  Miklos Szeredi <miklos@szeredi.hu>
References: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
	<20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
	<20231123215234.GQ38156@ZenIV> <20231125220136.GB38156@ZenIV>
	<20231126045219.GD38156@ZenIV> <20231126184141.GF38156@ZenIV>
	<20231127063842.GG38156@ZenIV>
	<87jzq3nqos.fsf@email.froward.int.ebiederm.org>
	<20231127160318.GI38156@ZenIV> <20231127161426.GA964333@ZenIV>
Date: Mon, 27 Nov 2023 12:19:09 -0600
In-Reply-To: <20231127161426.GA964333@ZenIV> (Al Viro's message of "Mon, 27
	Nov 2023 16:14:26 +0000")
Message-ID: <87v89nkqjm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r7gCo-006hy6-31;;;mid=<87v89nkqjm.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18q4nSddb4xv1hV6x7/Ii/Wh0OYvIlQsaU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 544 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (2.3%), b_tie_ro: 11 (1.9%), parse: 1.80
	(0.3%), extract_message_metadata: 23 (4.2%), get_uri_detail_list: 4.2
	(0.8%), tests_pri_-2000: 15 (2.8%), tests_pri_-1000: 11 (2.0%),
	tests_pri_-950: 1.84 (0.3%), tests_pri_-900: 1.23 (0.2%),
	tests_pri_-90: 87 (16.0%), check_bayes: 84 (15.4%), b_tokenize: 11
	(2.0%), b_tok_get_all: 10 (1.8%), b_comp_prob: 3.8 (0.7%),
	b_tok_touch_all: 54 (9.9%), b_finish: 1.39 (0.3%), tests_pri_0: 369
	(67.9%), check_dkim_signature: 0.71 (0.1%), check_dkim_adsp: 3.5
	(0.6%), poll_dns_idle: 1.04 (0.2%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 13 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Nov 27, 2023 at 04:03:18PM +0000, Al Viro wrote:
>> On Mon, Nov 27, 2023 at 09:47:47AM -0600, Eric W. Biederman wrote:
>> 
>> > There is a lot going on there.  I remember one of the relevant
>> > restrictions was marking dentries dont_mount, and inodes S_DEAD
>> > in unlink and rmdir.
>> > 
>> > But even without out that marking if d_invalidate is called
>> > from d_revalidate the inode and all of it's dentries must be
>> > dead because the inode is stale and most go.  There should
>> > be no resurrecting it at that point.
>> > 
>> > I suspect the most fruitful way to think of the d_invalidate vs
>> > d_splice_alias races is an unlink vs rename race.
>> > 
>> > I don't think the mechanism matters, but deeply and fundamentally
>> > if we detect a directory inode is dead we need to stick with
>> > that decision and not attempt to resurrect it with d_splice_alias.
>> 
>> Wrong.  Deeply and fundamentally we detect a dentry that does not
>> match the directory contents according to the server.
>> 
>> For example, due to rename done on server.  With object in question
>> perfectly alive there - fhandle still works, etc.
>> 
>> However, it's no longer where it used to be.  And we would bloody better
>> not have lookups for the old name result in access to that object.
>> We also should never allow the access to *new* name lead to two live
>> dentries for the same directory inode.
>> 
>> Again, this is not about rmdir() or unlink() - invalidation can happen
>> for object that is still open, still accessed and still very much alive.
>> Does that all the time for any filesystem with ->d_revalidate().
>
> Put another way, there used to be very odd song and dance in ->d_revalidate()
> instances along the lines of "we can't possibly tell the caller to invalidate
> a mountpoint"; it was racy in the best case and during the rewrite of
> d_invalidate() to teach it how to evict submounts those attempts had been
> dropped - ->d_revalidate() returning 0 does end up with mounts dissolved
> by d_invalidate() from caller.
>
> It always had been racy, starting with the checks that used to be in
> ->d_revalidate() instances way before all those changes.  So the switch
> of d_invalidate() to dissolving submounts had been a step in the right
> direction, but it's not being careful enough.
>
> Again, it's about d_invalidate() caused by pathwalk running into a dentry that
> doesn't match the reality vs. d_splice_alias() finding that it matches the
> inode we had looked up elsewhere.

My point is we should have a atomic way to decide the disposition of
such a dentry, and it's children.

Either we should decide it is useless and remove it and all of it's
children.

Or we should decide it was renamed and just handle it that way.

If we can record such a decision on the dentry or possibly on the inode
then we can resolve the race by having it be a proper race of which
comes first.

It isn't a proper delete of the inode so anything messing with the inode
and marking it S_DEAD is probably wrong.

The code could do something like mark the dentry dont_mount which should
be enough to for d_splice_alias to say oops, something is not proper
here.  Let the d_invalidate do it's thing.

Or the code could remove the dentry from inode->i_dentry and keep
d_splice alias from finding it, and it's children completely.
That is different from unhashing it.

Anyway that is my memory and my general sense of what is going on.
I help it helps.

Eric

