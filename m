Return-Path: <linux-fsdevel+bounces-20726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533A8D73B9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 06:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C342F281F95
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C612B6C;
	Sun,  2 Jun 2024 04:08:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD3BE47;
	Sun,  2 Jun 2024 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717301334; cv=none; b=Tbqj6E8c4oLuZ4y0DJJQDGQX2hikOXcJnguSQAGXY616qmKOK3IKfbB67m0ktHOqBsYqAEuWvlkpmeEgTDJQldKa8vCHq08sKVWV9cxj/jrJVPccOEme3+RWtUUZQI+0G77WYbeI0QqfvBr+tJAE3l/+NqA+K4G+i6pSVXOjPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717301334; c=relaxed/simple;
	bh=zt/mCGLUmVzFbMigp4I4greEWSN7ilXHuSeRteZ0s7s=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=L6nUy9WgrZi+DmP0TfUf6zR6GmrNu5RTSIZYo7ingCNtcEvP3fjdAEMTew9nB8wcSs0vOyYbxZVzkh3YEujbsHiBBN6wHZkuzmOLYlTGugNZITX6AeW9GvpsA/uwrXDy57JJvv+V1qKN7Wqxufd6VPo2AOqOdnSbfDkUQGOosYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:36664)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sDcGs-00Eawn-4E; Sat, 01 Jun 2024 21:52:38 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:34300 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sDcGq-00F7Wn-Mp; Sat, 01 Jun 2024 21:52:37 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org,  linux-mm@kvack.org,
  linux-fsdevel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  audit@vger.kernel.org,  linux-security-module@vger.kernel.org,
  selinux@vger.kernel.org,  bpf@vger.kernel.org,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Kees Cook <keescook@chromium.org>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-2-laoar.shao@gmail.com>
Date: Sat, 01 Jun 2024 22:51:57 -0500
In-Reply-To: <20240602023754.25443-2-laoar.shao@gmail.com> (Yafang Shao's
	message of "Sun, 2 Jun 2024 10:37:49 +0800")
Message-ID: <87ikysdmsi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sDcGq-00F7Wn-Mp;;;mid=<87ikysdmsi.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1860tjt8nodVMvTZzeRt1UmJFO9w9v1+IM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Yafang Shao <laoar.shao@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 817 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 14 (1.7%), b_tie_ro: 12 (1.4%), parse: 1.68
	(0.2%), extract_message_metadata: 39 (4.7%), get_uri_detail_list: 4.4
	(0.5%), tests_pri_-2000: 39 (4.8%), tests_pri_-1000: 2.8 (0.3%),
	tests_pri_-950: 1.37 (0.2%), tests_pri_-900: 1.09 (0.1%),
	tests_pri_-90: 126 (15.4%), check_bayes: 93 (11.4%), b_tokenize: 10
	(1.3%), b_tok_get_all: 10 (1.3%), b_comp_prob: 3.1 (0.4%),
	b_tok_touch_all: 65 (8.0%), b_finish: 1.24 (0.2%), tests_pri_0: 357
	(43.7%), check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 3.2
	(0.4%), poll_dns_idle: 215 (26.3%), tests_pri_10: 2.0 (0.3%),
	tests_pri_500: 229 (28.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Yafang Shao <laoar.shao@gmail.com> writes:

> Quoted from Linus [0]:
>
>   Since user space can randomly change their names anyway, using locking
>   was always wrong for readers (for writers it probably does make sense
>   to have some lock - although practically speaking nobody cares there
>   either, but at least for a writer some kind of race could have
>   long-term mixed results

Ugh.
Ick.

This code is buggy.

I won't argue that Linus is wrong, about removing the
task_lock.

Unfortunately strscpy_pad does not work properly with the
task_lock removed, and buf_size larger that TASK_COMM_LEN.
There is a race that will allow reading past the end
of tsk->comm, if we read while tsk->common is being
updated.

So __get_task_comm needs to look something like:

char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
{
	size_t len = buf_size;
        if (len > TASK_COMM_LEN)
        	len = TASK_COMM_LEN;
	memcpy(buf, tsk->comm, len);
        buf[len -1] = '\0';
	return buf;
}

What shows up in buf past the '\0' is not guaranteed in the above
version but I would be surprised if anyone cares.

If people do care the code can do something like:
char *last = strchr(buf);
memset(last, '\0', buf_size - (last - buf));

To zero everything in the buffer past the first '\0' byte.


Eric


> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  fs/exec.c             | 7 +++++--
>  include/linux/sched.h | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index b3c40fbb325f..b43992d35a8a 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1227,12 +1227,15 @@ static int unshare_sighand(struct task_struct *me)
>  	return 0;
>  }
>  
> +/*
> + * User space can randomly change their names anyway, so locking for readers
> + * doesn't make sense. For writers, locking is probably necessary, as a race
> + * condition could lead to long-term mixed results.
> + */
>  char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
>  {
> -	task_lock(tsk);
>  	/* Always NUL terminated and zero-padded */
>  	strscpy_pad(buf, tsk->comm, buf_size);
> -	task_unlock(tsk);
>  	return buf;
>  }
>  EXPORT_SYMBOL_GPL(__get_task_comm);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c75fd46506df..56a927393a38 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1083,7 +1083,7 @@ struct task_struct {
>  	 *
>  	 * - normally initialized setup_new_exec()
>  	 * - access it with [gs]et_task_comm()
> -	 * - lock it with task_lock()
> +	 * - lock it with task_lock() for writing
>  	 */
>  	char				comm[TASK_COMM_LEN];

