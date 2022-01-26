Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5666649D021
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiAZQ6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 11:58:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53120 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbiAZQ56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:57:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54328)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nClcK-004q9Y-Rl; Wed, 26 Jan 2022 09:57:56 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:37556 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nClcJ-004Xqo-M4; Wed, 26 Jan 2022 09:57:56 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
        <YfFh6O2JS6MybamT@casper.infradead.org>
Date:   Wed, 26 Jan 2022 10:57:29 -0600
In-Reply-To: <YfFh6O2JS6MybamT@casper.infradead.org> (Matthew Wilcox's message
        of "Wed, 26 Jan 2022 14:59:52 +0000")
Message-ID: <877damwi2u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nClcJ-004Xqo-M4;;;mid=<877damwi2u.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX199LLVbAXOZV45XrLVVWkp0iDR5ez5Z1fE=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 412 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.3%), parse: 0.76 (0.2%),
         extract_message_metadata: 15 (3.6%), get_uri_detail_list: 1.36 (0.3%),
         tests_pri_-1000: 16 (4.0%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 157 (38.0%), check_bayes:
        141 (34.3%), b_tokenize: 6 (1.4%), b_tok_get_all: 6 (1.5%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 124 (30.0%), b_finish: 0.95
        (0.2%), tests_pri_0: 194 (47.1%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.2 (0.8%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        3.0 (0.7%), tests_pri_500: 11 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
>> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
>> but there was no consensus to support fixing this issue then.
>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>> of this bug in a shellcode, we can reconsider.
>> 
>> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
>
> Having now read 8408 ... if ABI change is a concern (and I really doubt
> it is), we could treat calling execve() with a NULL argv as if the
> caller had passed an array of length 1 with the first element set to
> NULL.  Just like we reopen fds 0,1,2 for suid execs if they were
> closed.

Where do we reopen fds 0,1,2 for suid execs?  I feel silly but I looked
through the code fs/exec.c quickly and I could not see it.


I am attracted to the notion of converting an empty argv array passed
to the kernel into something we can safely pass to userspace.

I think it would need to be having the first entry point to "" instead
of the first entry being NULL.  That would maintain the invariant that you
can always dereference a pointer in the argv array.

Eric




