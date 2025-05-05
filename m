Return-Path: <linux-fsdevel+bounces-48084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004EFAA94E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E41D3BCC55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB042512F3;
	Mon,  5 May 2025 13:52:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DC1D54EE
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453170; cv=none; b=FJm+vFRsRO98bM+XofkjrxItVW+ph4HIs2xoqSTuoWlOCLRlgrxPkCZhIVU49Z2gmDS8F0plWcQCYJxgHrhKteBfEHOl2BO5JjCOIzHMQw3f+dONjMRvy/i+m+lTsqQ+hGBcpwL2WHEZuG6SVhLWYlFoJ6zGkNCEqKOQsMWmQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453170; c=relaxed/simple;
	bh=6rF087bLoQRwLq16vOa2+Km1hupFRfBI0gqS3iF7oOI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=kfy09fhzsVRUvz7FCdSsImYq5JFvSGFvGCy0ou76scZnEtnX8vvgR1qn7mY+vlNsCE97A275DJAi97t/AhTT2ze+zdAPx0HvNB4ko2nk92kgOfLdCN72rBYoeKzEi6WyCuGEZrwGxBs6myahvmIUs+Kv+nanfyAKaFRDu9zMI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:46336)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uBwFN-009xXi-Vg; Mon, 05 May 2025 07:52:42 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:58068 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uBwFM-00GCH5-Lm; Mon, 05 May 2025 07:52:41 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>
References: <20250501201506.GS2023217@ZenIV>
	<87plgq8igd.fsf@email.froward.int.ebiederm.org>
	<20250504232441.GC2023217@ZenIV>
Date: Mon, 05 May 2025 08:52:16 -0500
In-Reply-To: <20250504232441.GC2023217@ZenIV> (Al Viro's message of "Mon, 5
	May 2025 00:24:41 +0100")
Message-ID: <877c2v88rz.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uBwFM-00GCH5-Lm;;;mid=<877c2v88rz.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/gjawIl9rXZ0MvC6Dz88W7DXU87QkMZ18=
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
	*  1.5 TR_AI_Phishing Email matches multiple AI-related patterns
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 691 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (1.8%), b_tie_ro: 11 (1.5%), parse: 1.61
	(0.2%), extract_message_metadata: 21 (3.0%), get_uri_detail_list: 4.6
	(0.7%), tests_pri_-2000: 13 (1.9%), tests_pri_-1000: 3.2 (0.5%),
	tests_pri_-950: 1.67 (0.2%), tests_pri_-900: 1.28 (0.2%),
	tests_pri_-90: 91 (13.1%), check_bayes: 87 (12.6%), b_tokenize: 13
	(1.9%), b_tok_get_all: 11 (1.6%), b_comp_prob: 4.1 (0.6%),
	b_tok_touch_all: 55 (7.9%), b_finish: 1.05 (0.2%), tests_pri_0: 524
	(75.8%), check_dkim_signature: 0.76 (0.1%), check_dkim_adsp: 3.6
	(0.5%), poll_dns_idle: 1.19 (0.2%), tests_pri_10: 3.9 (0.6%),
	tests_pri_500: 14 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] MNT_LOCKED vs. finish_automount()
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: brauner@kernel.org, torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Fri, May 02, 2025 at 10:46:26PM -0500, Eric W. Biederman wrote:
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>> 
>> > 	Back in 2011, when ->d_automount() had been introduced,
>> > we went with "stepping on NFS referral, etc., has the submount
>> > inherit the flags of parent one" (with the obvious exceptions
>> > for internal-only flags).  Back then MNT_LOCKED didn't exist.
>> >
>> > 	Two years later, when MNT_LOCKED had been added, an explicit
>> > "don't set MNT_LOCKED on expirable mounts when propagating across
>> > the userns boundary; their underlying mountpoints can be exposed
>> > whenever the original expires anyway".  Same went for root of
>> > subtree attached by explicit mount --[r]bind - the mountpoint
>> > had been exposed before the call, after all and for roots of
>> > any propagation copies created by such (same reason).  Normal mount
>> > (created by do_new_mount()) could never get MNT_LOCKED to start with.
>> >
>> > 	However, mounts created by finish_automount() bloody well
>> > could - if the parent mount had MNT_LOCKED on it, submounts would
>> > inherited it.  Even if they had been expirable.  Moreover, all their
>> > propagation copies would have MNT_LOCKED stripped out.
>> >
>> > 	IMO this inconsistency is a bug; MNT_LOCKED should not
>> > be inherited in finish_automount().
>> >
>> > 	Eric, is there something subtle I'm missing here?
>> 
>> I don't think you are missing anything.  This looks like a pretty clear
>> cut case of simply not realizing finish_automount was special in a way
>> that could result in MNT_LOCKED getting set.
>> 
>> I skimmed through the code just a minute ago and my reading of it
>> matches your reading of it above.
>> 
>> The intended semantics of MNT_LOCKED are to not let an unprivileged user
>> see under mounts they would never be able to see under without creating
>> a mount namespace.
>> 
>> The mount point of an automount is pretty clearly something that is safe
>> to see under.  Doubly so if this is a directory that will always be
>> empty on a pseudo filesystem (aka autofs).
>
> Does anybody have objections to the following?
>
> [PATCH] finish_automount(): don't leak MNT_LOCKED from parent to child
>
> Intention for MNT_LOCKED had always been to protect the internal
> mountpoints within a subtree that got copied across the userns boundary,
> not the mountpoint that tree got attached to - after all, it _was_
> exposed before the copying.
>
> For roots of secondary copies that is enforced in attach_recursive_mnt() -
> MNT_LOCKED is explicitly stripped for those.  For the root of primary
> copy we are almost always guaranteed that MNT_LOCKED won't be there,
> so attach_recursive_mnt() doesn't bother.  Unfortunately, one call
> chain got overlooked - triggering e.g. NFS referral will have the
> submount inherit the public flags from parent; that's fine for such
> things as read-only, nosuid, etc., but not for MNT_LOCKED.
>
> This is particularly pointless since the mount attached by finish_automount()
> is usually expirable, which makes any protection granted by MNT_LOCKED
> null and void; just wait for a while and that mount will go away on its own.
>
> The minimal fix is to have do_add_mount() treat MNT_LOCKED the same
> way as other internal-only flags.  Longer term it would be cleaner to
> deal with that in attach_recursive_mnt(), but that takes a bit more
> massage, so let's go with the one-liner fix for now.

How would you deal with this in attach_recursive_mnt?  The problem case
appears to be an automount on top of a recursive mount.  So I don't
see the recursive mount code path being involved at all.



Given that only new mounts explicitly specified by a user and
finish_automount call do_add_mount this looks safe.  Having
MNT_LOCKED set will always be inappropriate in these two
cases.

Eric


> Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 04a9bb9f31fa..352b4ccf1aaa 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3761,7 +3761,7 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
>  {
>  	struct mount *parent = real_mount(path->mnt);
>  
> -	mnt_flags &= ~MNT_INTERNAL_FLAGS;
> +	mnt_flags &= ~(MNT_INTERNAL_FLAGS | MNT_LOCKED);
>  
>  	if (unlikely(!check_mnt(parent))) {
>  		/* that's acceptable only for automounts done in private ns */

