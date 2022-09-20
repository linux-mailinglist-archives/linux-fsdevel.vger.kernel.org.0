Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D05BE93D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiITOn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiITOn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:43:27 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9353004;
        Tue, 20 Sep 2022 07:43:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:58122)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaeT5-007JKb-2U; Tue, 20 Sep 2022 08:43:23 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:40460 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaeT2-00A5cd-1m; Tue, 20 Sep 2022 08:43:22 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     <keescook@chromium.org>, <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>
References: <20220920120812.231417-1-renzhijie2@huawei.com>
Date:   Tue, 20 Sep 2022 09:42:48 -0500
In-Reply-To: <20220920120812.231417-1-renzhijie2@huawei.com> (Ren Zhijie's
        message of "Tue, 20 Sep 2022 20:08:12 +0800")
Message-ID: <87sfkmyumv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oaeT2-00A5cd-1m;;;mid=<87sfkmyumv.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18i+9VOR1RYod84Byw32gyuF/Em/c5q38s=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Ren Zhijie <renzhijie2@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1718 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 15 (0.9%), b_tie_ro: 13 (0.8%), parse: 1.09
        (0.1%), extract_message_metadata: 15 (0.9%), get_uri_detail_list: 2.7
        (0.2%), tests_pri_-1000: 8 (0.4%), tests_pri_-950: 1.49 (0.1%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 298 (17.3%), check_bayes:
        291 (16.9%), b_tokenize: 9 (0.5%), b_tok_get_all: 9 (0.5%),
        b_comp_prob: 3.8 (0.2%), b_tok_touch_all: 262 (15.3%), b_finish: 1.74
        (0.1%), tests_pri_0: 1311 (76.3%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 41 (2.4%), tests_pri_10:
        4.0 (0.2%), tests_pri_500: 60 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Force binary name when argv is empty
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ren Zhijie <renzhijie2@huawei.com> writes:

> From: Hui Tang <tanghui20@huawei.com>
>
> First run './execv-main execv-child', there is empty in 'COMMAND' column
> when run 'ps -u'.
>
>  USER       PID %CPU %MEM    VSZ   RSS TTY    [...] TIME COMMAND
>  root       368  0.3  0.0   4388   764 ttyS0        0:00 ./execv-main
>  root       369  0.6  0.0   4520   812 ttyS0        0:00
>
> The program 'execv-main' as follows:
>
>  int main(int argc, char **argv)
>  {
>    char *execv_argv[] = {NULL};
>    pid_t pid = fork();
>
>    if (pid == 0) {
>      execv(argv[1], execv_argv);
>    } else if (pid > 0) {
>      wait(NULL);
>    }
>    return 0;
>  }
>
> So replace empty string ("") added with the name of binary
> when calling execve with a NULL argv.

I do not understand the point of this patch.  The command name is
allowed to be anything.  By convention it is the name of the binary but
that is not required.  For login shells it is always something else.

The practical problem that commit dcd46d897adb ("exec: Force single
empty string when argv is empty") addresses is that a NULL argv[0]
is not expected by programs, and can be used to trigger bugs in
those programs.  Especially suid programs.

The actual desired behavior is to simply have execve fail in that
case.  Unfortunately there are a few existing programs that depend
on running that way, so we could not have such exec's fail.

For a rare case that should essentially never happen why make it
friendlier to use?  Why not fix userspace to add the friendly name
instead of the kernel?

Unless there is a good reason for it, it would be my hope that in
a couple of years all of the userspace programs that trigger
the warning when they start up could be fixed, and we could have
execve start failing in those cases.

Eric

>
> Fixes: dcd46d897adb ("exec: Force single empty string when argv is empty")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  fs/exec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 939d76e23935..7d1909a89a57 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -494,8 +494,8 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
>  	 * signal to the parent that the child has run out of stack space.
>  	 * Instead, calculate it here so it's possible to fail gracefully.
>  	 *
> -	 * In the case of argc = 0, make sure there is space for adding a
> -	 * empty string (which will bump argc to 1), to ensure confused
> +	 * In the case of argc = 0, make sure there is space for adding
> +	 * bprm->filename (which will bump argc to 1), to ensure confused
>  	 * userspace programs don't start processing from argv[1], thinking
>  	 * argc can never be 0, to keep them from walking envp by accident.
>  	 * See do_execveat_common().
> @@ -1900,7 +1900,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>  
>  	retval = count(argv, MAX_ARG_STRINGS);
>  	if (retval == 0)
> -		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
> +		pr_warn_once("process '%s' launched '%s' with NULL argv: bprm->filename added\n",
>  			     current->comm, bprm->filename);
>  	if (retval < 0)
>  		goto out_free;
> @@ -1929,13 +1929,13 @@ static int do_execveat_common(int fd, struct filename *filename,
>  		goto out_free;
>  
>  	/*
> -	 * When argv is empty, add an empty string ("") as argv[0] to
> +	 * When argv is empty, add bprm->filename as argv[0] to
>  	 * ensure confused userspace programs that start processing
>  	 * from argv[1] won't end up walking envp. See also
>  	 * bprm_stack_limits().
>  	 */
>  	if (bprm->argc == 0) {
> -		retval = copy_string_kernel("", bprm);
> +		retval = copy_string_kernel(bprm->filename, bprm);
>  		if (retval < 0)
>  			goto out_free;
>  		bprm->argc = 1;
