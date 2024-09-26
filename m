Return-Path: <linux-fsdevel+bounces-30136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE7986B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8B1F22D23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2007C17625C;
	Thu, 26 Sep 2024 02:45:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A21D5AAE;
	Thu, 26 Sep 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318723; cv=none; b=QXpsC8jIL8o5BlfvFMzCvMh6U2FnZPUXRIpsjIU3LDhGpVWgD3FpY6iEbOjCQWrXswKqOA+H9gkp9U+O38mqfURpdha3RpQj8wDdZMKQcaXffpn3RCAedtwL/aQNOJyMb0m+ueqqbnYz+EfYpCQMShKsYlXjOXEJeMaJpM9q+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318723; c=relaxed/simple;
	bh=XlJDVay2cRa4S19npJjYLMt5x9m4ip4Jc3BifmP0yE0=;
	h=From:To:Cc:References:Date:Message-ID:MIME-Version:Content-Type:
	 Subject; b=ajghQRKraL4fVh3ryufeEiIaHUfHoyJcfp/fJEYx6vkcy6oHmExtBGMq8UMeRTaK+bW0l46Ju287HFFQ7OeNiKsjStK7onBSyxORs+GerUxH2kHD7YJp7caXNka+QHVRuerhaxEIoY5rN+nyX4PZrIqmoRGG2eFcgqDAL4kb04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:43028)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stdxJ-001jjo-HT; Wed, 25 Sep 2024 20:10:09 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:60542 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1stdxI-0092mE-JA; Wed, 25 Sep 2024 20:10:09 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Aleksa Sarai <cyphar@cyphar.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Kees Cook <kees@kernel.org>,  Jeff Layton
 <jlayton@kernel.org>,  Chuck Lever <chuck.lever@oracle.com>,  Alexander
 Aring <alex.aring@gmail.com>,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Tycho Andersen
 <tandersen@netflix.com>,  Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>
References: <20240924141001.116584-1-tycho@tycho.pizza>
	<87msjx9ciw.fsf@email.froward.int.ebiederm.org>
	<20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>
	<ZvR+k3D1KGALOIWt@tycho.pizza>
Date: Wed, 25 Sep 2024 21:09:18 -0500
Message-ID: <878qvf17zl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1stdxI-0092mE-JA;;;mid=<878qvf17zl.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/r7gePPtcWACfkta5ly/kAAypuqpcvQ0I=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4152]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.4 (1.2%), b_tie_ro: 3.0 (0.8%), parse: 1.12
	(0.3%), extract_message_metadata: 11 (2.9%), get_uri_detail_list: 1.30
	(0.4%), tests_pri_-2000: 10 (2.8%), tests_pri_-1000: 2.2 (0.6%),
	tests_pri_-950: 1.00 (0.3%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 124 (33.9%), check_bayes: 121 (33.0%), b_tokenize: 4.8
	(1.3%), b_tok_get_all: 44 (12.1%), b_comp_prob: 1.67 (0.5%),
	b_tok_touch_all: 67 (18.3%), b_finish: 0.81 (0.2%), tests_pri_0: 199
	(54.4%), check_dkim_signature: 0.37 (0.1%), check_dkim_adsp: 3.1
	(0.8%), poll_dns_idle: 1.71 (0.5%), tests_pri_10: 2.5 (0.7%),
	tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: zbyszek@in.waw.pl, tandersen@netflix.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, kees@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, cyphar@cyphar.com, tycho@tycho.pizza
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Tycho Andersen <tycho@tycho.pizza> writes:

> Yep, I did this for the test above, and it worked fine:
>
>         if (bprm->fdpath) {
>                 /*
>                  * If fdpath was set, execveat() made up a path that will
>                  * probably not be useful to admins running ps or similar.
>                  * Let's fix it up to be something reasonable.
>                  */
>                 struct path root;
>                 char *path, buf[1024];
>
>                 get_fs_root(current->fs, &root);
>                 path = __d_path(&bprm->file->f_path, &root, buf, sizeof(buf));
>
>                 __set_task_comm(me, kbasename(path), true);
>         } else {
>                 __set_task_comm(me, kbasename(bprm->filename), true);
>         }
>
> obviously we don't want a stack allocated buffer, but triggering on
> ->fdpath != NULL seems like the right thing, so we won't need a flag
> either.
>
> The question is: argv[0] or __d_path()?

You know.  I think we can just do:

	BUILD_BUG_ON(DNAME_INLINE_LEN >= TASK_COMM_LEN);
	__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);

Barring cache misses that should be faster and more reliable than what
we currently have and produce the same output in all of the cases we
like, and produce better output in all of the cases that are a problem
today.

Does anyone see any problem with that?

Eric

