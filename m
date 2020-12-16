Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C02DC258
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 15:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgLPOhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 09:37:03 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47568 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgLPOhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:37:03 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpXuf-000cXw-J7; Wed, 16 Dec 2020 07:36:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpXud-0000Ij-TV; Wed, 16 Dec 2020 07:36:20 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <871rfqad5g.fsf@x220.int.ebiederm.org>
        <CAHk-=wijn40PoFccpQZExuyWnz2i+wmBx+9gw5nKJPVQVmzb5g@mail.gmail.com>
Date:   Wed, 16 Dec 2020 08:35:34 -0600
In-Reply-To: <CAHk-=wijn40PoFccpQZExuyWnz2i+wmBx+9gw5nKJPVQVmzb5g@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 15 Dec 2020 19:32:37 -0800")
Message-ID: <87wnxh7r9l.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kpXud-0000Ij-TV;;;mid=<87wnxh7r9l.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+NlWkphSa3CpPRKjAGDxjWeL4PNaJD4A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4913]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 834 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.5 (0.4%), b_tie_ro: 2.4 (0.3%), parse: 0.59
        (0.1%), extract_message_metadata: 10 (1.2%), get_uri_detail_list: 0.51
        (0.1%), tests_pri_-1000: 12 (1.4%), tests_pri_-950: 0.98 (0.1%),
        tests_pri_-900: 0.77 (0.1%), tests_pri_-90: 114 (13.7%), check_bayes:
        112 (13.5%), b_tokenize: 3.1 (0.4%), b_tok_get_all: 3.8 (0.5%),
        b_comp_prob: 1.04 (0.1%), b_tok_touch_all: 102 (12.2%), b_finish: 0.66
        (0.1%), tests_pri_0: 100 (12.0%), check_dkim_signature: 0.35 (0.0%),
        check_dkim_adsp: 2.0 (0.2%), poll_dns_idle: 575 (69.0%), tests_pri_10:
        1.59 (0.2%), tests_pri_500: 588 (70.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] exec fixes for v5.11-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Dec 15, 2020 at 3:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> There is a minor conflict with parallel changes to the bpf task_iter
>> code.  The changes don't fundamentally conflict but both are removing
>> code from same areas of the same function.
>
> Ok, that was somewhat confusing.
>
> I think I got it right, but I'd appreciate you giving my resolution a
> second look. Just to be safe.

I have read through the merge commit and everything looks correct.

Eric

