Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EED91AEC46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDRL7B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 07:59:01 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60032 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgDRL7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:59:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPm7f-0007nX-II; Sat, 18 Apr 2020 05:58:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPm7e-0001Xl-Io; Sat, 18 Apr 2020 05:58:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
References: <20200414070142.288696-1-hch@lst.de>
        <20200414070142.288696-3-hch@lst.de>
        <87pnc5akhk.fsf@x220.int.ebiederm.org>
        <87k12dakfx.fsf_-_@x220.int.ebiederm.org>
        <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
Date:   Sat, 18 Apr 2020 06:55:56 -0500
In-Reply-To: <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr> (Christophe Leroy's
        message of "Sat, 18 Apr 2020 10:05:19 +0200")
Message-ID: <87v9lx3t4j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1jPm7e-0001Xl-Io;;;mid=<87v9lx3t4j.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18UJp5X1nu8GvTzwVNg4DhYMBf3vdPs/94=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong,XM_B_Unicode,XM_B_Unicode3
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1268]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 XM_B_Unicode3 BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christophe Leroy <christophe.leroy@c-s.fr>
X-Spam-Relay-Country: 
X-Spam-Timing: total 521 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.11
        (0.2%), extract_message_metadata: 15 (2.8%), get_uri_detail_list: 1.79
        (0.3%), tests_pri_-1000: 13 (2.5%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 79 (15.1%), check_bayes:
        77 (14.8%), b_tokenize: 8 (1.6%), b_tok_get_all: 18 (3.5%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 44 (8.5%), b_finish: 0.89
        (0.2%), tests_pri_0: 380 (73.0%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 1.15 (0.2%), tests_pri_10:
        2.6 (0.5%), tests_pri_500: 13 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from copy_siginfo_to_user32
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 17/04/2020 à 23:09, Eric W. Biederman a écrit :
>>
>> To remove the use of set_fs in the coredump code there needs to be a
>> way to convert a kernel siginfo to a userspace compat siginfo.
>>
>> Call that function copy_siginfo_to_compat and factor it out of
>> copy_siginfo_to_user32.
>
> I find it a pitty to do that.
>
> The existing function could have been easily converted to using
> user_access_begin() + user_access_end() and use unsafe_put_user() to copy to
> userspace to avoid copying through a temporary structure on the stack.
>
> With your change, it becomes impossible to do that.

I don't follow.  You don't like temporary structures in the coredump
code or temporary structures in copy_siginfo_to_user32?

A temporary structure in copy_siginfo_to_user is pretty much required
so that it can be zeroed to guarantee we don't pass a structure with
holes to userspace.

The implementation of copy_siginfo_to_user32 used to use the equivalent
of user_access_begin() and user_access_end() and the code was a mess
that was very difficult to reason about.  I recall their being holes
in the structure that were being copied to userspace.

Meanwhile if you are going to set all of the bytes a cache hot temporary
structure is quite cheap.

> Is that really an issue to use that set_fs() in the coredump code ?

Using set_fs() is pretty bad and something that we would like to remove
from the kernel entirely.  The fewer instances of set_fs() we have the
better.

I forget all of the details but set_fs() is both a type violation and an
attack point when people are attacking the kernel.  The existence of
set_fs() requires somethings that should be constants to be variables.
Something about that means that our current code is difficult to protect
from spectre style vulnerabilities.

There was a very good thread about it all in I think 2018 but
unfortunately I can't find it now.

Eric
