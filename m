Return-Path: <linux-fsdevel+bounces-48692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF5AB2E7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D116B3B30B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 04:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35A254856;
	Mon, 12 May 2025 04:52:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1B2576
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747025567; cv=none; b=lzcZ7nXqkySI/KIEaQSAv5pjKOWh5lHhQBfZFc5XxiWLTjpNK78Ed5wIw+5+PFIjhAZ+SuceCnv7vXo4Qg31V75JHeYDW7kqbm7sQlS3X3Afj7uNjxh23T7uz6zNv4wrxktFt9zfzf/X6U3+pSOc8iAsG64VBWeS7kMy77mqjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747025567; c=relaxed/simple;
	bh=O8wICcMAbrvHPRxIP5V2kB7kl1iSs15Vcto8NaWL6e8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ah0sDLuUNekZGfAGEau1MTilcKTPEMti69LTF81Ge/JdPbqFvzTFc1hdwbsvJHOyBWZveHBDpkjEttMd675hpLKfiLdonGyVEtalr5s/QTj4HsXMJeJiRyNFYhsUsmRVzT7q350UWtwqBydsdct3Adn13G1FC0p9cHP/djPpu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:56758)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uEL9a-0030FV-8O; Sun, 11 May 2025 22:52:38 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:34436 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uEL9Y-00CyJM-Jo; Sun, 11 May 2025 22:52:37 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>
References: <20250511232732.GC2023217@ZenIV>
Date: Sun, 11 May 2025 23:50:40 -0500
In-Reply-To: <20250511232732.GC2023217@ZenIV> (Al Viro's message of "Mon, 12
	May 2025 00:27:32 +0100")
Message-ID: <87jz6m300v.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uEL9Y-00CyJM-Jo;;;mid=<87jz6m300v.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/HFB0fJwIN2uQpGMRXihTXGbjmx4ePnfM=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4908]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1010 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (1.1%), b_tie_ro: 10 (1.0%), parse: 1.27
	(0.1%), extract_message_metadata: 14 (1.4%), get_uri_detail_list: 3.4
	(0.3%), tests_pri_-2000: 9 (0.9%), tests_pri_-1000: 2.4 (0.2%),
	tests_pri_-950: 1.26 (0.1%), tests_pri_-900: 0.99 (0.1%),
	tests_pri_-90: 384 (38.0%), check_bayes: 381 (37.7%), b_tokenize: 11
	(1.1%), b_tok_get_all: 11 (1.1%), b_comp_prob: 3.5 (0.3%),
	b_tok_touch_all: 351 (34.7%), b_finish: 1.05 (0.1%), tests_pri_0: 565
	(55.9%), check_dkim_signature: 0.60 (0.1%), check_dkim_adsp: 2.9
	(0.3%), poll_dns_idle: 1.04 (0.1%), tests_pri_10: 3.3 (0.3%),
	tests_pri_500: 13 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [BUG] propagate_umount() breakage
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: brauner@kernel.org, torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Al Viro <viro@zeniv.linux.org.uk> writes:

> reproducer:
> ------------------------------------------------------------
> # create a playground
> mkdir /tmp/foo
> mount -t tmpfs none /tmp/foo
> mount --make-private /tmp/foo
> cd /tmp/foo
>
> # set one-way propagation from A to B
> mkdir A
> mkdir B
> mount -t tmpfs none A
> mount --make-shared A
> mount --bind A B
> mount --make-slave B
>
> # A/1 -> B/1, A/1/2 -> B/1/2
> mkdir A/1
> mount -t tmpfs none A/1
> mkdir A/1/2
> mount -t tmpfs none A/1/2
>
> # overmount the entire B/1/2
> mount -t tmpfs none B/1/2
>
> # make sure it's busy - set a mount at B/1/2/x
> mkdir B/1/2/x
> mount -t tmpfs none B/1/2/x
>
> stat B/1/x # shouldn't exist
>
> umount -l A/1
>
> stat B/1/x # ... and now it does
> ------------------------------------------------------------
>
> What happens is that mounts on B/1 and B/1/2 had been considered
> as victims - and taken out, since the overmount on top of B/1/2
> overmounted the root of the first mount on B/1/2 and it got
> reparented - all the way to B/1.

Yes, that behavior is incorrect since it causes a userspace visible
change on where the mount is visible.

> Correct behaviour would be to have B/1 left in place and upper
> B/1/2 to be reparented once.

As I read __propagate_umount that is what is trying to be implemented.

I am a bit mystified why the semantics aren't simply to lazily umount
(aka MNT_DETACH) that overmount.  But that is not what the code is
trying to do.  It probably isn't worth considering a change in semantics
at this point.

It looks like the challenge is in the __propgate_umount loop.
If I am reading thing correctly:
- __propagate_umount recognizes that B/1/2 can be unmounted from the
  overmount.
- The code then considers the parent of B/1/2 B/1.
- When considering B/1 there is only one child B/1/2 that has been
  umounted and it has already been marked to be umounted so it
  is ignored (Sigh).

So a minimal fix would go up the mount pile to see if there is anything
that must remain.  Or probably use a bit like use a bit like MNT_MARK to
recognize there is an overmount remaining.  So despite a child being
unmounted it still should count as if it was mounted.

> As an aside, that's a catch from several days of attempts to prove
> correctness of propagate_umount(); I'm still not sure there's
> nothing else wrong with it.  _Maybe_ it's the only problem in
> there, but reconstructing the proof of correctness has turned
> out to be a real bitch ;-/
>
> I seriously suspect that a lot of headache comes from trying
> to combine collecting the full set of potential victims with
> deciding what can and what can not be taken out - gathering
> all of them first would simplify things.  First pass would've
> logics similar to your variant, but without __propagate_umount()
> part[*]

This is there be dragons talk.

With out care it is easy to get the code to go non-linear in
the number of mounts.

That said I don't see any immediate problem with a first pass
without my __propgate_umount.

As I read the current code the __propagate_umount loop is just
about propagating the information up from the leaves.

> After the set is collected, we could go through it, doing the
> something along the lines of
> 	how = 0
> 	for each child in children(m)
> 		if child in set
> 			continue
> 		how = 1
> 		if child is not mounted on root
> 			how = 2
> 			break
> 	if how == 2
> 		kick_out_ancestors(m)
> 		remove m itself from set // needs to cooperate with outer loop
> 	else if how == 1
> 		for (p = m; p in set && p is mounted on root; p = p->mnt_parent)
> 			;
> 		if p in set
> 			kick_out_ancestors(p)
> 	else if children(m) is empty && m is not locked	// to optimize things a bit
> 		commit to unmounting m (again, needs to cooperate with the outer loop)
>
> "Cooperate with the outer loop" might mean something like
> having this per-element work leave removal of its argument to
> caller and report whether its argument needs to be removed.
>
> After that we'd be left with everything still in the set
> having no out-of-set children that would be obstacles.
> The only thing that remains after that is MNT_LOCKED and
> that's as simple as
> 	while set is not empty
> 		m = first element of set
> 		for (p = m; p is locked && p in set; p = p->mnt_parent)
> 			;
> 		if p not in set {
> 			if p is not committed to unmount
> 				remove everything from m to p from set
> 				continue
> 		} else {
> 			p = p->mnt_parent
> 		}
> 		commit everything from m to p to unmount, removing from set
>
> I'll try to put something of that sort together, along with
> detailed explanation of what it's doing - in D/f/*, rather than
> buring it in commit messages, and along with "read and update
> D/f/... if you are ever touch this function" in fs/pnode.c itself;
> this fun is not something I would like to repeat several years
> down the road ;-/

I think I understand what you are saying.  But I will have to see the
actually code.

> We *REALLY* need a good set of regression tests for that stuff.
> If you have anything along those lines sitting somewhere, please
> post a reference.  The same goes for everybody else who might
> have something in that general area.

I will have to look.  As I recall everything I have is completely manual
but it could be a starting point at least.

> [*] well, that and with fixed skip_propagation_subtree() logics; it's
> easier to combine it with propagation_next() rather than trying to set
> the things up so that the next call of propagation_next() would DTRT -
> it's less work and yours actually has a corner case if the last element
> of ->mnt_slave_list has non-empty ->mnt_slave_list itself.

I hope that helps a little,

Eric


