Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A993AF621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 21:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhFUTau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 15:30:50 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43432 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhFUTas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:30:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvPaz-009kRk-1P; Mon, 21 Jun 2021 13:28:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lvPax-00DZ7U-U6; Mon, 21 Jun 2021 13:28:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrei Vagin <avagin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210615162346.16032-1-avagin@gmail.com>
        <877diuq5xb.fsf@disp2133>
        <CANaxB-zVMxxvt8c1XNKfy6-hAUoodxp=ChJpP_Rn5cTD=26p9w@mail.gmail.com>
Date:   Mon, 21 Jun 2021 14:27:47 -0500
In-Reply-To: <CANaxB-zVMxxvt8c1XNKfy6-hAUoodxp=ChJpP_Rn5cTD=26p9w@mail.gmail.com>
        (Andrei Vagin's message of "Tue, 15 Jun 2021 15:35:14 -0700")
Message-ID: <87pmwfggr0.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lvPax-00DZ7U-U6;;;mid=<87pmwfggr0.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/KkeURioQeUCQv/lbdzgTzMI2/4Daqa8s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1997]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrei Vagin <avagin@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 488 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 11 (2.2%), parse: 1.14
        (0.2%), extract_message_metadata: 12 (2.4%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.41 (0.3%), tests_pri_-90: 103 (21.1%), check_bayes:
        101 (20.7%), b_tokenize: 9 (1.9%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 3.6 (0.7%), b_tok_touch_all: 73 (14.9%), b_finish: 1.32
        (0.3%), tests_pri_0: 327 (67.1%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 3.3 (0.7%), poll_dns_idle: 1.06 (0.2%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec/binfmt_script: trip zero bytes from the buffer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:

> On Tue, Jun 15, 2021 at 12:33 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Andrei Vagin <avagin@gmail.com> writes:
>>
>> > Without this fix, if we try to run a script that contains only the
>> > interpreter line, the interpreter is executed with one extra empty
>> > argument.
>> >
>> > The code is written so that i_end has to be set to the end of valuable
>> > data in the buffer.
>>
>> Out of curiosity how did you spot this change in behavior?
>
> gVisor tests started failing with this change:
> https://github.com/google/gvisor/blob/5e05950c1c520724e2e03963850868befb95efeb/test/syscalls/linux/exec.cc#L307
>
> We run these tests on Ubuntu 20.04 and this is the reason why we
> caught this issue just a few days ago.

I like where you are going, but starting at the end of the buffer
there is the potential to skip deliberately embedded '\0' characters.

While looking at this I realized that your patch should not have
made a difference but there is a subtle bug in the logic of
next_non_spacetab, that allowed your code to make it that far.

Can you test my patch below?

I think I have simplified the logic enough to prevent bugs from getting
in.

Eric

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 1b6625e95958..7d204693326c 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -26,7 +26,7 @@ static inline const char *next_non_spacetab(const char *first, const char *last)
 static inline const char *next_terminator(const char *first, const char *last)
 {
 	for (; first <= last; first++)
-		if (spacetab(*first) || !*first)
+		if (spacetab(*first))
 			return first;
 	return NULL;
 }
@@ -44,9 +44,9 @@ static int load_script(struct linux_binprm *bprm)
 	/*
 	 * This section handles parsing the #! line into separate
 	 * interpreter path and argument strings. We must be careful
-	 * because bprm->buf is not yet guaranteed to be NUL-terminated
-	 * (though the buffer will have trailing NUL padding when the
-	 * file size was smaller than the buffer size).
+	 * because bprm->buf is not guaranteed to be NUL-terminated
+	 * (the buffer will have trailing NUL padding when the file
+	 * size was smaller than the buffer size).
 	 *
 	 * We do not want to exec a truncated interpreter path, so either
 	 * we find a newline (which indicates nothing is truncated), or
@@ -57,33 +57,37 @@ static int load_script(struct linux_binprm *bprm)
 	 */
 	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
 	i_end = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
-	if (!i_end) {
-		i_end = next_non_spacetab(bprm->buf + 2, buf_end);
-		if (!i_end)
-			return -ENOEXEC; /* Entire buf is spaces/tabs */
-		/*
-		 * If there is no later space/tab/NUL we must assume the
-		 * interpreter path is truncated.
-		 */
-		if (!next_terminator(i_end, buf_end))
-			return -ENOEXEC;
-		i_end = buf_end;
+	if (i_end) {
+		/* Hide the trailing newline */
+		i_end = i_end - 1;
+	} else {
+		/* Find the end of the text */
+		i_end = memchr(bprm->buf + 2, '\0', sizeof(bprm->buf));
+		i_end = i_end ? i_end - 1 : buf_end;
 	}
+
 	/* Trim any trailing spaces/tabs from i_end */
-	while (spacetab(i_end[-1]))
+	while (spacetab(i_end[0]))
 		i_end--;
 
 	/* Skip over leading spaces/tabs */
 	i_name = next_non_spacetab(bprm->buf+2, i_end);
-	if (!i_name || (i_name == i_end))
+	if (!i_name)
 		return -ENOEXEC; /* No interpreter name found */
 
 	/* Is there an optional argument? */
 	i_arg = NULL;
 	i_sep = next_terminator(i_name, i_end);
-	if (i_sep && (*i_sep != '\0'))
+	if (i_sep)
 		i_arg = next_non_spacetab(i_sep, i_end);
 
+	/*
+	 * If there is no space/tab/NUL after the interpreter we must
+	 * assume the interpreter path is truncated.
+	 */
+	if (!i_sep && (i_end == buf_end))
+		return -ENOEXEC;
+
 	/*
 	 * If the script filename will be inaccessible after exec, typically
 	 * because it is a "/dev/fd/<fd>/.." path against an O_CLOEXEC fd, give

