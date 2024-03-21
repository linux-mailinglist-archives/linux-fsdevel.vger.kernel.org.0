Return-Path: <linux-fsdevel+bounces-15016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C3885ECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269F91F21426
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD4D135A53;
	Thu, 21 Mar 2024 16:47:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1724A11;
	Thu, 21 Mar 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039643; cv=none; b=Tqq/Uxv/8Q+PzjYlWTBsJJVOMu3JfohWTyGzYJNXmi4k+qs0CPxVRXdodc6HEdg+d5BPBIr+lJNVbzWjJZ9Dc/p2ly379roUCqiUNWWVkHl81S70k9MlsbDNCSPuHEC1P8SxQnQ/NqFCnkscDCxca6Jp1bh0IFyZv8uJ7QTLh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039643; c=relaxed/simple;
	bh=HLVAmMCpgsC0QELrLic5koFr8nwDxNfHSRgxtVBvamw=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=SAhvtdoN4TNHDX6H14ZnxM5RXQ0jrb4pV7WWWv+/EvrvIcVAeqQ2JvjycCfder1loC9uNtVI5/UOG6MOQ2HfAiG14h/vBLVGE3ywHyVUkxMP9n3qOyWjdZKTj/zm7ZdwcRfjX++5EEP2AHYaD7CHkbilLrl8yHnngV2/n4l/D1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:50958)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rnLCf-004Jao-FF; Thu, 21 Mar 2024 10:23:41 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:60220 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rnLCe-000QNJ-Dr; Thu, 21 Mar 2024 10:23:41 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <keescook@chromium.org>,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
Date: Thu, 21 Mar 2024 11:23:34 -0500
In-Reply-To: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
	(Justin Stitt's message of "Thu, 21 Mar 2024 00:10:59 +0000")
Message-ID: <871q83eepl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rnLCe-000QNJ-Dr;;;mid=<871q83eepl.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/OG1LEXI8jC5HSB4g9jn0q4xs9g3G9J4M=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Justin Stitt <justinstitt@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 450 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.96 (0.2%),
	 extract_message_metadata: 4.2 (0.9%), get_uri_detail_list: 1.93
	(0.4%), tests_pri_-2000: 3.4 (0.8%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.38 (0.3%), tests_pri_-900: 0.90 (0.2%),
	tests_pri_-90: 182 (40.3%), check_bayes: 180 (40.0%), b_tokenize: 8
	(1.7%), b_tok_get_all: 9 (1.9%), b_comp_prob: 3.4 (0.8%),
	b_tok_touch_all: 157 (34.8%), b_finish: 0.94 (0.2%), tests_pri_0: 226
	(50.2%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 2.8
	(0.6%), poll_dns_idle: 1.08 (0.2%), tests_pri_10: 2.0 (0.5%),
	tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt: replace deprecated strncpy with strscpy_pad
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Justin Stitt <justinstitt@google.com> writes:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> In every other location psinfo->pr_fname is used, it's with strscpy_pad.
> It's clear that this field needs to be NUL-terminated and potentially
> NUL-padded as well.
> binfmt_elf.c +1545:
> |	char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
> |	{
> |		task_lock(tsk);
> |		/* Always NUL terminated and zero-padded */
> |		strscpy_pad(buf, tsk->comm, buf_size);
> |		task_unlock(tsk);
> |		return buf;
> |	}
>
> Note that this patch relies on the _new_ 2-argument versions of
> strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
> Allow 2-argument strscpy()").

I am perplexed.  Why not use get_task_comm fill_psinfo like binfmt_elf
does?

It seems very silly to copy half the function without locking and then
not copy it's locking as well.

Given that the more highly tested binfmt_elf uses get_task_comm I can't
imagine a reason why binfmt_elf_fdpic can't use it as well.

Eric



> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  fs/binfmt_elf_fdpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 1920ed69279b..0365f14f18fc 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
>  	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
>  	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
>  	rcu_read_unlock();
> -	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
> +	strscpy_pad(psinfo->pr_fname, p->comm);
>  
>  	return 0;
>  }
>
> ---
> base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
> change-id: 20240320-strncpy-fs-binfmt_elf_fdpic-c-828286d76310
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>

