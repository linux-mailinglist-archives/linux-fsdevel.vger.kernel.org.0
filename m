Return-Path: <linux-fsdevel+bounces-44359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5EA67DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9D3ADFAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E921146F;
	Tue, 18 Mar 2025 20:12:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFAA1C5F3F;
	Tue, 18 Mar 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328764; cv=none; b=DMzlS7a5/yaFFVtF1pAv3UlcdlwPQac1YiPzlgiaShkQsknkZzrmw0gs1L5s5Esf8Hcwp873M0r/vT7kf5xMfyCUs9f9R1iXt3AGTIEhNyrswUigpLS7le0XJxfGg6f8bj2p0szibmzAiaA3A3zHfQA2cOFKkPu4dddN8SXlsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328764; c=relaxed/simple;
	bh=DwTciTWioLC/efRZqFQubcLVfUXzAK1lbJgHP9X4rA8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=IaRBtn+LLWQgF4DRXmqz6TCXOWUywvZUmjAFz3RHibIJAD3BJJgYeqmZ+XtSkhaqdDAI5fMjRB1N/B+umFf8qmZy6FfUT+VMBUBTi4OkmI1DHITwWkBTenBKe/H8n8t4sHtDrKnEhZRFwMSiqHbM8e7ra4U2LPXCqSaA7WLQqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:42030)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tudIl-000u1I-T2; Tue, 18 Mar 2025 14:12:39 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:60782 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tudIi-00CP89-UK; Tue, 18 Mar 2025 14:12:38 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: trondmy@kernel.org
Cc: Christian Brauner <brauner@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,
  linux-fsdevel@vger.kernel.org,  linux-nfs@vger.kernel.org
References: <12f212d4ef983714d065a6bb372fbb378753bf4c.1742315194.git.trond.myklebust@hammerspace.com>
Date: Tue, 18 Mar 2025 15:12:30 -0500
In-Reply-To: <12f212d4ef983714d065a6bb372fbb378753bf4c.1742315194.git.trond.myklebust@hammerspace.com>
	(trondmy@kernel.org's message of "Tue, 18 Mar 2025 12:29:21 -0400")
Message-ID: <87wmcmxfm9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tudIi-00CP89-UK;;;mid=<87wmcmxfm9.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18gEMRXdAIAt23DqmflYa+E0S1+/xmgGJo=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;trondmy@kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 349 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.6 (1.0%), b_tie_ro: 2.5 (0.7%), parse: 0.63
	(0.2%), extract_message_metadata: 11 (3.0%), get_uri_detail_list: 1.00
	(0.3%), tests_pri_-2000: 11 (3.1%), tests_pri_-1000: 1.80 (0.5%),
	tests_pri_-950: 1.04 (0.3%), tests_pri_-900: 0.78 (0.2%),
	tests_pri_-90: 112 (32.1%), check_bayes: 108 (30.8%), b_tokenize: 4.8
	(1.4%), b_tok_get_all: 6 (1.7%), b_comp_prob: 1.38 (0.4%),
	b_tok_touch_all: 93 (26.5%), b_finish: 0.86 (0.2%), tests_pri_0: 195
	(55.9%), check_dkim_signature: 0.37 (0.1%), check_dkim_adsp: 2.8
	(0.8%), poll_dns_idle: 0.67 (0.2%), tests_pri_10: 2.5 (0.7%),
	tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] umount: Allow superblock owners to force umount
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org, trondmy@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

trondmy@kernel.org writes:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Loosen the permission check on forced umount to allow users holding
> CAP_SYS_ADMIN privileges in namespaces that are privileged with respect
> to the userns that originally mounted the filesystem.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Semantically this seems reasonable.  I think forced umounts just got
overlooked when I was relaxing the other permission checks, to allow
things if you own the superblock.

The code has already checked you have permissions on the current mount
namespace.  Which was my immediate concern looking at the code.

Eric

> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8f1000f9f3df..d401486fe95d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2026,6 +2026,7 @@ static void warn_mandlock(void)
>  static int can_umount(const struct path *path, int flags)
>  {
>  	struct mount *mnt = real_mount(path->mnt);
> +	struct super_block *sb = path->dentry->d_sb;
>  
>  	if (!may_mount())
>  		return -EPERM;
> @@ -2035,7 +2036,7 @@ static int can_umount(const struct path *path, int flags)
>  		return -EINVAL;
>  	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
>  		return -EINVAL;
> -	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
> +	if (flags & MNT_FORCE && !ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  	return 0;
>  }

