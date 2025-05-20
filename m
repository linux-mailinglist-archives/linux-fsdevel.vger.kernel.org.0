Return-Path: <linux-fsdevel+bounces-49547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE262ABE6F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 00:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C298D8A64C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB5262D0C;
	Tue, 20 May 2025 22:28:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393F25F7AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780092; cv=none; b=KgBTjV3ejxKnIbLgX/3EcELVzTruAxg5TwJWoYdwAWUwtIy2UIM6lRBvvq60Nk2VNWQ4GcLCGlbxi8rRPot2vRD5SPHSoWXK5WaHuP+ExYccC0AkgSv16nBo9N5POOT9uz0Nmv59dB5CBvVwiuWnrdBg9CeE6cC/WO1gKtVTF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780092; c=relaxed/simple;
	bh=Tk4ENC68DBZROvllHXNl1A2fqPDgbjC0iIQ/lnUkRiQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=HHoYLS6VJ2yYZRshwP1rTTQR4z8I5hgf86xmIUPhkkquYGKAotpVwHLTK6BAsVg4KI+IulsNKYDhjOEq/vgw0+8dLYXXJfLmYIe8+fENIEffVombfPzMQavneXiMgdmYW5skrV98ov1bfShuKFTIkahGHS1tw8wDNQAFgV8ViHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:36316)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uHVRL-004q4w-FH; Tue, 20 May 2025 16:28:03 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:39524 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uHVRK-00D09M-Ab; Tue, 20 May 2025 16:28:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
  linux-fsdevel@vger.kernel.org,  Christian Brauner <brauner@kernel.org>
References: <20250511232732.GC2023217@ZenIV>
	<87jz6m300v.fsf@email.froward.int.ebiederm.org>
	<20250513035622.GE2023217@ZenIV> <20250515114150.GA3221059@ZenIV>
	<20250515114749.GB3221059@ZenIV> <20250516052139.GA4080802@ZenIV>
	<CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
	<20250519213508.GA2023217@ZenIV>
Date: Tue, 20 May 2025 17:27:55 -0500
In-Reply-To: <20250519213508.GA2023217@ZenIV> (Al Viro's message of "Mon, 19
	May 2025 22:35:08 +0100")
Message-ID: <87wmaancic.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uHVRK-00D09M-Ab;;;mid=<87wmaancic.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18/Zt/tICDckcf4lJyl5VWcl8wDsmfIbZg=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4210]
	*  1.5 TR_Symld_Words too many words that have symbols inside
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 520 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.12 (0.2%),
	 extract_message_metadata: 13 (2.5%), get_uri_detail_list: 1.56 (0.3%),
	 tests_pri_-2000: 10 (1.8%), tests_pri_-1000: 2.6 (0.5%),
	tests_pri_-950: 1.34 (0.3%), tests_pri_-900: 1.10 (0.2%),
	tests_pri_-90: 91 (17.5%), check_bayes: 88 (17.0%), b_tokenize: 10
	(1.8%), b_tok_get_all: 7 (1.4%), b_comp_prob: 2.9 (0.5%),
	b_tok_touch_all: 65 (12.6%), b_finish: 1.01 (0.2%), tests_pri_0: 375
	(72.1%), check_dkim_signature: 0.80 (0.2%), check_dkim_adsp: 3.0
	(0.6%), poll_dns_idle: 1.05 (0.2%), tests_pri_10: 3.1 (0.6%),
	tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: brauner@kernel.org, linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, May 19, 2025 at 11:11:10AM -0700, Linus Torvalds wrote:
>> Another thing that is either purely syntactic, or shows that I
>> *really* don't understand your patch. Why do you do this odd thing:
>> 
>>         // reduce the set until it's non-shifting
>>         for (m = first_candidate(); m; m = trim_one(m))
>>                 ;
>> 
>> which seems to just walk the candidates list in a very non-obvious
>> manner (this is one of those "I had to go back and forth to see what
>> first_candidate() did and what lists it used" cases).
>> 
>> It *seems* to be the same as
>> 
>>         list_for_each_entry_safe(m, tmp, &candidates, mnt_umounting)
>>                 trim_one(m);
>> 
>> because if I read that code right, 'trim_one()' will just always
>> return the next entry in that candidate list.
>
>
> 	Another variant would be to steal one more bit from mnt_flags,
> set it for all candidates when collecting them, have is_candidate() check
> that instead of list_empty(&m->mnt_umounting) and clean it where this
> variant removes from the list; trim_one() would immediately return if
> bit is not set.  Then we could really do list_for_each_entry_safe(),
> with another loop doing list removals afterwards.  Extra work that way,
> though, and I still think it's more confusing...

I have only skimmed this so far, and I am a bit confused what we
are using MNT_MARK for.   I would think we should be able to use
MNT_MARK instead of stealing another bit.

Regardless I believe you said the goal is to make the code as readable
as possible, so next time it needs to be audited a decade from now
it won't be hard to figure out what is going on.

To that end I think leaving everything on the candidate list, and
flipping a bit when we decide that that the mount should be kept
will be easier to understand.

That way we can have all of the mostly naive algorithms examine
a mount and see what we should do with it, in all of the various
cases, and we don't have to be clever.

The only way I can see to avoid difficult audits is to remove as
much cleverness from the code as the problem domain allows.

Eric

