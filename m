Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207E41DB902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETQJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 12:09:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60054 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 12:09:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbRHM-0002da-JB; Wed, 20 May 2020 10:09:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbRHL-00070A-LM; Wed, 20 May 2020 10:09:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
        <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net>
Date:   Wed, 20 May 2020 11:05:29 -0500
In-Reply-To: <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net> (Rob Landley's
        message of "Tue, 19 May 2020 16:59:06 -0500")
Message-ID: <874ksaioc6.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbRHL-00070A-LM;;;mid=<874ksaioc6.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19NAyurH9iGPP/ahHUMxq6hKHYaPv0QJ5Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rob Landley <rob@landley.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 407 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.4%), b_tie_ro: 8 (2.1%), parse: 0.83 (0.2%),
         extract_message_metadata: 10 (2.6%), get_uri_detail_list: 0.96 (0.2%),
         tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.17 (0.3%),
        tests_pri_-900: 0.93 (0.2%), tests_pri_-90: 134 (32.8%), check_bayes:
        131 (32.0%), b_tokenize: 7 (1.7%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.92 (0.5%), b_tok_touch_all: 111 (27.2%), b_finish: 1.47
        (0.4%), tests_pri_0: 231 (56.7%), check_dkim_signature: 0.72 (0.2%),
        check_dkim_adsp: 2.9 (0.7%), poll_dns_idle: 0.64 (0.2%), tests_pri_10:
        3.3 (0.8%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> On 5/18/20 7:33 PM, Eric W. Biederman wrote:
>> 
>> Most of the support for passing the file descriptor of an executable
>> to an interpreter already lives in the generic code and in binfmt_elf.
>> Rework the fields in binfmt_elf that deal with executable file
>> descriptor passing to make executable file descriptor passing a first
>> class concept.
>
> I was reading this to try to figure out how to do execve(NULL, argv[], envp) to
> re-exec self after a vfork() in a chroot with no /proc, and hit the most trivial
> quibble ever:

We have /proc/self/exe today.  If I understand you correctly you would
like to do the equivalent of 'execve("/proc/self/exe", argv[], envp[])'
without having proc mounted.

The file descriptor is stored in mm->exe_file.

Probably the most straight forward implementation is to allow
execveat(AT_EXE_FILE, ...).

You can look at binfmt_misc for how to reopen an open file descriptor.

>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1323,7 +1323,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	 */
>>  	set_mm_exe_file(bprm->mm, bprm->file);
>>  
>> +	/* If the binary is not readable than enforce mm->dumpable=0 */
>
> then

It took me a minute yes good catch.

Eric
