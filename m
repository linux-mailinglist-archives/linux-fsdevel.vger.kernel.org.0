Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2A1E6ACE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406541AbgE1TZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:25:54 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38176 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406352AbgE1TZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:25:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeOA2-0003ht-6V; Thu, 28 May 2020 13:25:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeOA1-0008Pm-5i; Thu, 28 May 2020 13:25:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
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
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
        <87y2pcvz3b.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
Date:   Thu, 28 May 2020 14:21:57 -0500
In-Reply-To: <CAHk-=wiAG4tpPoWsWSqHbyMZDnWR8RHUpbwxB9_tdAqbE59NxA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 28 May 2020 12:08:02 -0700")
Message-ID: <875zcfvp9m.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeOA1-0008Pm-5i;;;mid=<875zcfvp9m.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/beXd4KA5c+7dsn0MqQrGKegUPWaEyJac=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 351 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (2.7%), b_tie_ro: 8 (2.2%), parse: 0.83 (0.2%),
        extract_message_metadata: 13 (3.8%), get_uri_detail_list: 0.88 (0.3%),
        tests_pri_-1000: 24 (6.9%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 0.98 (0.3%), tests_pri_-90: 107 (30.6%), check_bayes:
        106 (30.1%), b_tokenize: 6 (1.8%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.91 (0.5%), b_tok_touch_all: 88 (25.2%), b_finish: 0.86
        (0.2%), tests_pri_0: 182 (51.8%), check_dkim_signature: 0.53 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.55 (0.2%), tests_pri_10:
        1.98 (0.6%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 09/11] exec: In bprm_fill_uid only set per_clear when honoring suid or sgid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, May 28, 2020 at 8:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> It makes no sense to set active_per_clear when the kernel decides not
>> to honor the executables setuid or or setgid bits.  Instead set
>> active_per_clear when the kernel actually decides to honor the suid or
>> sgid permission bits of an executable.
>
> You seem to be confused about the naming yourself.
>
> You talk about "active_per_clear", but the code is about "per_clear". WTF?

I figured out how to kill active_per_clear see (3/11) and I failed to
update the patch description here.

I think active_ is a louzy suffix but since it all goes away in patch 3
when I remove the recomputation and the need to have two versions of the
setting I think it is probably good enough.

Eric






