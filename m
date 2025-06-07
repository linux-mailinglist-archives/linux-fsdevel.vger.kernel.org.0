Return-Path: <linux-fsdevel+bounces-50906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C37AD0D63
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 14:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86231653FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4F2206BF;
	Sat,  7 Jun 2025 12:24:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308EA4C8F
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749299053; cv=none; b=huovXP0uNpQtoDE08Zp2rd70UJC3lk3qwl5L7qqCdjZSH4DfHMppBwnQnBIlabCF5nIAAE/URAsQAU4tHWC1HnJ+FQND/GVaxlSFs0rwu2I0fgJEKw6H9mBp+lTWhqfyn5kNQJ1dnr7Ye8BvVuSR3BsWh4njGvgr4q47oT5jyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749299053; c=relaxed/simple;
	bh=L1NDv3xK90mFPK4Vi0snPakJ26gqY3QeiQcsS5TwuM8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=o6Kyg1gKcUoJ7CYEBJmpMGqCwqoFfNC9U551dbMzu4TbcPJULC5R8rlk8hg9uy3rywY8b8E3RidtZdqqup03aczcCKJsFFQ/o3YtG7VaLY8p4tPMNfg5u4+zPN5741EzDuMU0Kflrp3brbDlve0prS7gbEKQymQtOB45Bu7rvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:60314)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uNs2l-002sVa-GA; Sat, 07 Jun 2025 05:48:59 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:55290 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uNs2k-00CCLE-IU; Sat, 07 Jun 2025 05:48:59 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  Christian Brauner <brauner@kernel.org>,
  Linus Torvalds <torvalds@linux-foundation.org>
References: <20250603204704.GB299672@ZenIV>
Date: Sat, 07 Jun 2025 06:48:40 -0500
In-Reply-To: <20250603204704.GB299672@ZenIV> (Al Viro's message of "Tue, 3 Jun
	2025 21:47:04 +0100")
Message-ID: <87sekbg4br.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uNs2k-00CCLE-IU;;;mid=<87sekbg4br.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+ZjzfZufeqtqA+jSlKbYYbFT76R9X7Ew8=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4698]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 437 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.79 (0.2%),
	 extract_message_metadata: 11 (2.5%), get_uri_detail_list: 0.97 (0.2%),
	 tests_pri_-2000: 9 (2.0%), tests_pri_-1000: 2.3 (0.5%),
	tests_pri_-950: 1.18 (0.3%), tests_pri_-900: 0.92 (0.2%),
	tests_pri_-90: 54 (12.3%), check_bayes: 52 (12.0%), b_tokenize: 9
	(2.0%), b_tok_get_all: 6 (1.4%), b_comp_prob: 2.1 (0.5%),
	b_tok_touch_all: 33 (7.4%), b_finish: 0.74 (0.2%), tests_pri_0: 330
	(75.5%), check_dkim_signature: 1.24 (0.3%), check_dkim_adsp: 4.0
	(0.9%), poll_dns_idle: 0.45 (0.1%), tests_pri_10: 4.1 (0.9%),
	tests_pri_500: 11 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] separate the internal mount flags from the rest
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: torvalds@linux-foundation.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Al Viro <viro@zeniv.linux.org.uk> writes:

> 	Currently we use ->mnt_flags for all kinds of things, including
> the ones only fs/{namespace,pnode}.c care about.
>
> 	That wouldn't be a problem if not for the locking.  ->mnt_flags is
> protected by mount_lock.  All writers MUST grab that.  Having lockless
> readers is unsurprising - after all, for something like noexec we want
> the current state of mount, whatever it happens to be.  If userland
> remounts something noexec and that races with execve(2), there's nothing
> to be done - it is a race, but not the kernel one.


In general I don't have a problem.

I see one possible complication I haven't seen mentioned.
Which mnt_flags get exposed to userspace?

I know it was the expectation that MNT_LOCKED would be visible to
userspace, as it's effects are visible to userspace (it isn't just some
accounting thing).

I may just be objecting to the name of the macro MNT_INTERNAL_FLAGS,
and the making of the decision about flags based on the
internal/external state.

Your patch to change make MNT_LOCKED an internal flag in combination
with this proposed change make me wonder about our classification
of flags as internal/external and how much that matters.

Eric

