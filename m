Return-Path: <linux-fsdevel+bounces-47984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69C1AA7E68
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 06:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597393AFBD9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7431718C002;
	Sat,  3 May 2025 04:22:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAF171C9
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 May 2025 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246174; cv=none; b=LkpHYTDIwHk2qmeMxLhWsJ+Iit5hD4JPsQtNuPkmi78ivNjRsar8TGjLlYF9VK3zvJDfVKWWT8GPETAscmnBeu0D6stGHnmyZsHybIRsAd8yPwd8texxsekP5OEto9uk5ERHoOC6kUl6kb98lCewNWbuzQR5T/VYHm/catq3vuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246174; c=relaxed/simple;
	bh=XxNWMvtyWhw1NZ3xibhQcyslGu3dHYM7EahhExk4xjU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=FSsJ2ZOKKGN82xUTMF5rwW6nnaHVDHjEako+jSrb67HebdUmG5AqQJi/BZKQo4spL54ZssngvaikQC39jGjiWsynhakjFhmwX1hZDgY6YT31fJjqzYtm0GraH1h9IHREgi0NekI1EUrPHXu5Cp0kv3beGi+Sec+agbSxyETGMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:42078)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uB3r5-00005m-1W; Fri, 02 May 2025 21:47:59 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:39776 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uB3r3-000ags-PM; Fri, 02 May 2025 21:47:58 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Airy <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Christian Brauner <brauner@kernel.org>
References: <20250501201506.GS2023217@ZenIV>
Date: Fri, 02 May 2025 22:46:26 -0500
In-Reply-To: <20250501201506.GS2023217@ZenIV> (Al Viro's message of "Thu, 1
	May 2025 21:15:06 +0100")
Message-ID: <87plgq8igd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uB3r3-000ags-PM;;;mid=<87plgq8igd.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19AXG0XK/vji+K33p4ZmTM/gdwYnL4XaO0=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Airy <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 760 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 19 (2.5%), b_tie_ro: 16 (2.1%), parse: 3.4 (0.4%),
	 extract_message_metadata: 24 (3.1%), get_uri_detail_list: 2.7 (0.4%),
	tests_pri_-2000: 10 (1.3%), tests_pri_-1000: 3.1 (0.4%),
	tests_pri_-950: 1.46 (0.2%), tests_pri_-900: 1.17 (0.2%),
	tests_pri_-90: 266 (35.0%), check_bayes: 261 (34.3%), b_tokenize: 12
	(1.6%), b_tok_get_all: 8 (1.0%), b_comp_prob: 3.0 (0.4%),
	b_tok_touch_all: 234 (30.8%), b_finish: 1.66 (0.2%), tests_pri_0: 406
	(53.5%), check_dkim_signature: 0.76 (0.1%), check_dkim_adsp: 3.3
	(0.4%), poll_dns_idle: 0.66 (0.1%), tests_pri_10: 3.1 (0.4%),
	tests_pri_500: 14 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] MNT_LOCKED vs. finish_automount()
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: brauner@kernel.org, torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Al Viro <viro@zeniv.linux.org.uk> writes:

> 	Back in 2011, when ->d_automount() had been introduced,
> we went with "stepping on NFS referral, etc., has the submount
> inherit the flags of parent one" (with the obvious exceptions
> for internal-only flags).  Back then MNT_LOCKED didn't exist.
>
> 	Two years later, when MNT_LOCKED had been added, an explicit
> "don't set MNT_LOCKED on expirable mounts when propagating across
> the userns boundary; their underlying mountpoints can be exposed
> whenever the original expires anyway".  Same went for root of
> subtree attached by explicit mount --[r]bind - the mountpoint
> had been exposed before the call, after all and for roots of
> any propagation copies created by such (same reason).  Normal mount
> (created by do_new_mount()) could never get MNT_LOCKED to start with.
>
> 	However, mounts created by finish_automount() bloody well
> could - if the parent mount had MNT_LOCKED on it, submounts would
> inherited it.  Even if they had been expirable.  Moreover, all their
> propagation copies would have MNT_LOCKED stripped out.
>
> 	IMO this inconsistency is a bug; MNT_LOCKED should not
> be inherited in finish_automount().
>
> 	Eric, is there something subtle I'm missing here?

I don't think you are missing anything.  This looks like a pretty clear
cut case of simply not realizing finish_automount was special in a way
that could result in MNT_LOCKED getting set.

I skimmed through the code just a minute ago and my reading of it
matches your reading of it above.

The intended semantics of MNT_LOCKED are to not let an unprivileged user
see under mounts they would never be able to see under without creating
a mount namespace.

The mount point of an automount is pretty clearly something that is safe
to see under.  Doubly so if this is a directory that will always be
empty on a pseudo filesystem (aka autofs).

Eric

