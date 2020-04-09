Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5A1A347E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDINDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 09:03:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59848 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDINDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:03:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMWqF-0001hb-1e; Thu, 09 Apr 2020 07:03:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMWpL-0007xO-Oy; Thu, 09 Apr 2020 07:03:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
References: <20200409123752.1070597-1-gladkov.alexey@gmail.com>
Date:   Thu, 09 Apr 2020 07:59:47 -0500
In-Reply-To: <20200409123752.1070597-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 9 Apr 2020 14:37:44 +0200")
Message-ID: <87y2r4vmpo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMWpL-0007xO-Oy;;;mid=<87y2r4vmpo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WJ31Nql+9t5EG46GA+7qbhhHjHwL+opo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4537]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 10066 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (0.1%), b_tie_ro: 12 (0.1%), parse: 0.95
        (0.0%), extract_message_metadata: 3.4 (0.0%), get_uri_detail_list:
        1.35 (0.0%), tests_pri_-1000: 6 (0.1%), tests_pri_-950: 1.48 (0.0%),
        tests_pri_-900: 1.19 (0.0%), tests_pri_-90: 129 (1.3%), check_bayes:
        127 (1.3%), b_tokenize: 9 (0.1%), b_tok_get_all: 8 (0.1%),
        b_comp_prob: 2.3 (0.0%), b_tok_touch_all: 87 (0.9%), b_finish: 0.81
        (0.0%), tests_pri_0: 6250 (62.1%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 6010 (59.7%), poll_dns_idle: 9630 (95.7%),
        tests_pri_10: 1.48 (0.0%), tests_pri_500: 3632 (36.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH RESEND v11 0/8] proc: modernize proc to support multiple private instances
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Preface:
> --------
> This is patchset v11 to modernize procfs and make it able to support multiple
> private instances per the same pid namespace.
>
> This patchset can be applied on top of:
>
> git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
> 4b871ce26ab2



Why the resend?

Nothing happens until the merge window closes with the release of -rc1
(almost certainly on this coming Sunday).  I goofed and did not act on
this faster, and so it is my fault this did not make it into linux-next
before the merge window.  But I am not going to rush this forward.



You also ignored my review and have not even descibed why it is safe
to change the type of a filesystem parameter.

-	fsparam_u32("hidepid",	Opt_hidepid),
+	fsparam_string("hidepid",	Opt_hidepid),


Especially in light of people using fsconfig(fd, FSCONFIG_SET_...);

All I need is someone to point out that fsparam_u32 does not use
FSCONFIG_SET_BINARY, but FSCONFIG_SET_STRING.



My apologies for being grumpy but this feels like you are asking me to
go faster when it is totally inappropriate to do so, while busily
ignoring my feedback.

I think this should happen.  But I can't do anything until after -rc1.

Eric
