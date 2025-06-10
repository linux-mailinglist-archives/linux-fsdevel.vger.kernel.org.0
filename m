Return-Path: <linux-fsdevel+bounces-51204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA090AD45FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B753A6EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4725D546;
	Tue, 10 Jun 2025 22:30:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF21442F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594645; cv=none; b=jMKl4pG1B6aQKdNCZhuScUqwNv/n7ff1WCHIWIQcIGHRxPVC0RSpbGYV+dQOvbOls9YzUBpc6quU9cyD17FinuepXPD7ii8emyY64Ky4WcPSNy62OJiTbMc/Weu3BvBfnM7jzE8VmELfmQ5OnzUkodx+HsVzzjvx5UldthAdHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594645; c=relaxed/simple;
	bh=LiPcBqNMrFO3Szd+AYmx0K3VCnk3qufDOnsmT04KwzM=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Q+SoP/2dPixdrMRphblWasqEBSTzn9wPhnvGuHSAxBM5j3rgWTEC6VyUilSeC5AOpssdBxznu4bFaqa21z2OGAJGbb8IRjhmryZFaQI6ONT/cFqo9zWVNjtPKLErFFGbR4rGUv3yeLGRgKeQO+65ktga3cVLLAWLD1NgWgWTHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:53852)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uP7UI-008M4P-99; Tue, 10 Jun 2025 16:30:34 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:39534 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uP7UH-002MJX-94; Tue, 10 Jun 2025 16:30:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,  jack@suse.cz,
  torvalds@linux-foundation.org
References: <20250610081758.GE299672@ZenIV>
	<20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Date: Tue, 10 Jun 2025 17:30:11 -0500
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk> (Al Viro's
	message of "Tue, 10 Jun 2025 09:21:23 +0100")
Message-ID: <87bjqvfcwc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uP7UH-002MJX-94;;;mid=<87bjqvfcwc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX196XOeQ9CYBSa8I5KAQRxuAxv2r1wi0oOE=
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_05 8+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 512 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.5 (0.7%), b_tie_ro: 2.4 (0.5%), parse: 0.64
	(0.1%), extract_message_metadata: 9 (1.7%), get_uri_detail_list: 0.89
	(0.2%), tests_pri_-2000: 7 (1.4%), tests_pri_-1000: 1.85 (0.4%),
	tests_pri_-950: 0.99 (0.2%), tests_pri_-900: 0.78 (0.2%),
	tests_pri_-90: 132 (25.7%), check_bayes: 130 (25.4%), b_tokenize: 4.3
	(0.8%), b_tok_get_all: 6 (1.1%), b_comp_prob: 1.33 (0.3%),
	b_tok_touch_all: 116 (22.7%), b_finish: 0.60 (0.1%), tests_pri_0: 344
	(67.0%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 2.7
	(0.5%), poll_dns_idle: 1.37 (0.3%), tests_pri_10: 2.8 (0.5%),
	tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/26] copy_tree(): don't set ->mnt_mountpoint on the
 root of copy
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: torvalds@linux-foundation.org, jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Al Viro <viro@zeniv.linux.org.uk> writes:

> It never made any sense - neither when copy_tree() had been introduced
> (2.4.11-pre5), nor at any point afterwards.  Mountpoint is meaningless
> without parent mount and the root of copied tree has no parent until we get
> around to attaching it somewhere.  At that time we'll have mountpoint set;
> before that we have no idea which dentry will be used as mountpoint.
> IOW, copy_tree() should just leave the default value.

I will just note that does not result in dst_mnt->mnt_mountpoint
being left as NULL.

Rather dst_mnt->mnt_mountpoint retains the value that clone_mnt
sets it to which is dst_mnt->mnt.mnt_root.

It would be nice to have a note that says something like leaving
dst_mnt->mnt_parent and dst_mnt->mnt_mountpoint alone indicates that the
mount is not mounted anywhere, and that the current situation of just
setting one of them completely confusing.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e13d9ab4f564..5eeb17c39fcb 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2259,7 +2259,6 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
>  		return dst_mnt;
>  
>  	src_parent = src_root;
> -	dst_mnt->mnt_mountpoint = src_root->mnt_mountpoint;
>  
>  	list_for_each_entry(src_root_child, &src_root->mnt_mounts, mnt_child) {
>  		if (!is_subdir(src_root_child->mnt_mountpoint, dentry))

