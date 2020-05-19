Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668611DA280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 22:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgESUYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 16:24:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54046 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESUYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 16:24:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb8mX-0002h2-BJ; Tue, 19 May 2020 14:24:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb8mW-0002mR-Ik; Tue, 19 May 2020 14:24:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
        <202005191220.2DB7B7C7@keescook>
        <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
Date:   Tue, 19 May 2020 15:20:27 -0500
In-Reply-To: <CAHk-=wg=cHD0oZTFgj0z33=8H8yKEcbn=eNpTj19GPEgJwrQzg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 19 May 2020 12:54:40 -0700")
Message-ID: <87a723n0c4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb8mW-0002mR-Ik;;;mid=<87a723n0c4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Go4GcdBQ9Hlcsq7Wxbs0FCcH2FRifgGQ=
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
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 392 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (3.2%), b_tie_ro: 11 (2.8%), parse: 1.35
        (0.3%), extract_message_metadata: 22 (5.6%), get_uri_detail_list: 1.46
        (0.4%), tests_pri_-1000: 23 (5.8%), tests_pri_-950: 1.58 (0.4%),
        tests_pri_-900: 1.26 (0.3%), tests_pri_-90: 62 (15.8%), check_bayes:
        60 (15.3%), b_tokenize: 8 (2.2%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 38 (9.8%), b_finish: 1.08
        (0.3%), tests_pri_0: 221 (56.4%), check_dkim_signature: 0.68 (0.2%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 0.77 (0.2%), tests_pri_10:
        7 (1.7%), tests_pri_500: 35 (9.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 19, 2020 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> Though frankly, I wonder if interp_flags could just be removed in favor
>> of two new bit members, especially since interp_data is gone:
>
> Yeah, I think that might be a good cleanup - but please keep it as a
> separate thing at the end of the series (or maybe the beginning)

I will.

With a little care we can replace setting BINPRM_FLAGS_ENFORCE_NONDUMP
and clearing bprm->mm->dumpable.

Which is the direction I have been looking.

Now that I think about it I believe that the loop in exec_binprm should
be clearing BINPRM_FLAGS_PATH_INACCESSIBLE as it is only relevant to
fexec/execveat with a close on exec file descriptor.

Eric
