Return-Path: <linux-fsdevel+bounces-70371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54223C98F36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 21:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A956C4E2653
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973C2505AA;
	Mon,  1 Dec 2025 20:04:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4A22578D;
	Mon,  1 Dec 2025 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619497; cv=none; b=Yg57uh3QcAp8X3o9VkyUyc60JnwPPI1ZG039B0VeNzHmHN6iUcsGX4tulzwXgENfZLDji/GvE16DQBxvFWDFeFp+r4zgySEiyjvALbs1jU2b0Blv/86IeMAQDXYOPh0oqkaAIW912T3pRljZXDVfAjwS5t1cGjcYmhAxfHPFRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619497; c=relaxed/simple;
	bh=dpjx3y3Tb9cXY+TvTDbrVCrrhentYbXxh4YVOaJqGic=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=MRgi3n60XUN2iOwKvnSimqPEkF5Qi8CCbEmLK3iwNJrfGR8wZNGkX9EfDj+OHNxFENRkvlyi9h9xUa7qBrfe2d9BQDwFzto+YxKmTSIei5E1L3Kis9VU8aN1WqdkM5CWvjS9MvWdcdi9S9aFwmpvQvD587VADrH4Zkt+iEDs9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:46846)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vQ9Dr-00GGVj-FS; Mon, 01 Dec 2025 12:06:07 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:41296 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1vQ9Dq-007zSD-Cr; Mon, 01 Dec 2025 12:06:07 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 Linux Containers <containers@lists.linux.dev> 
In-Reply-To: <20251128-kernel-namespaces-v619-28629f3fc911@brauner> (Christian
	Brauner's message of "Fri, 28 Nov 2025 17:48:16 +0100")
References: <20251128-vfs-v619-77cd88166806@brauner>
	<20251128-kernel-namespaces-v619-28629f3fc911@brauner>
Date: Mon, 01 Dec 2025 13:06:02 -0600
Message-ID: <87ecperpid.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1vQ9Dq-007zSD-Cr;;;mid=<87ecperpid.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19aoM64k9dDBoyRNQGGjpvmcBJ6R9OWKtQ=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5029]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <brauner@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 12 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.68
	(0.1%), extract_message_metadata: 2.4 (0.5%), get_uri_detail_list:
	0.75 (0.2%), tests_pri_-2000: 2.9 (0.6%), tests_pri_-1000: 2.7 (0.6%),
	tests_pri_-950: 1.29 (0.3%), tests_pri_-900: 0.97 (0.2%),
	tests_pri_-90: 227 (47.0%), check_bayes: 225 (46.7%), b_tokenize: 6
	(1.2%), b_tok_get_all: 36 (7.5%), b_comp_prob: 1.99 (0.4%),
	b_tok_touch_all: 177 (36.6%), b_finish: 1.28 (0.3%), tests_pri_0: 215
	(44.7%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 4.8
	(1.0%), poll_dns_idle: 1.30 (0.3%), tests_pri_10: 2.3 (0.5%),
	tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL 05/17 for v6.19] namespaces
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: containers@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, brauner@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Christian Brauner <brauner@kernel.org> writes:

> Hey Linus,
>
> /* Summary */
> This contains substantial namespace infrastructure changes including a new
> system call, active reference counting, and extensive header cleanups.
> The branch depends on the shared kbuild branch for -fms-extensions
> support.

I am missing something.  From the description it looks like
you are making nested containers impossible once this feature
is adopted.  Because the container will be able to see all of
the other namespaces and thus to see outside of it's own namespace.

The reason such as system call has not been introduced in the past
is because it introduces the namespace of namespace problem.

How have you solved the namespace of namespaces problem?

If you want nesting of containers the listing of namespaces very
much must be incomplete.

I haven't looked at reviewed or looked at the code yet because
the code was not posted in any of the usual places for container
development, nor was I copied.

Can you please describe how you are avoiding the namespace of namespaces
problem?


Eric

