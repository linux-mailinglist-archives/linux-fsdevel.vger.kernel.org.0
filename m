Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293941DDDDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 05:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgEVDcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 23:32:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38556 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVDca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 23:32:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbyQ5-0003kP-Qo; Thu, 21 May 2020 21:32:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbyQ3-0005Zy-E7; Thu, 21 May 2020 21:32:25 -0600
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
        <874ksaioc6.fsf@x220.int.ebiederm.org>
        <fc2cf2a7-e1a7-3170-32c9-43e593636799@landley.net>
Date:   Thu, 21 May 2020 22:28:39 -0500
In-Reply-To: <fc2cf2a7-e1a7-3170-32c9-43e593636799@landley.net> (Rob Landley's
        message of "Thu, 21 May 2020 17:50:41 -0500")
Message-ID: <87r1vcd4wo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbyQ3-0005Zy-E7;;;mid=<87r1vcd4wo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3+/zmcrzojQSjNrpeoIT45VaWKsfVFlI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rob Landley <rob@landley.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2000 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (0.2%), b_tie_ro: 3.2 (0.2%), parse: 1.06
        (0.1%), extract_message_metadata: 11 (0.6%), get_uri_detail_list: 1.29
        (0.1%), tests_pri_-1000: 4.5 (0.2%), tests_pri_-950: 1.11 (0.1%),
        tests_pri_-900: 0.82 (0.0%), tests_pri_-90: 52 (2.6%), check_bayes: 51
        (2.6%), b_tokenize: 5 (0.3%), b_tok_get_all: 7 (0.4%), b_comp_prob:
        1.67 (0.1%), b_tok_touch_all: 34 (1.7%), b_finish: 0.71 (0.0%),
        tests_pri_0: 212 (10.6%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 6 (0.3%), poll_dns_idle: 1701 (85.0%), tests_pri_10:
        2.8 (0.1%), tests_pri_500: 1707 (85.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Rob Landley <rob@landley.net> writes:

> On 5/20/20 11:05 AM, Eric W. Biederman wrote:

> Toybox would _like_ proc mounted, but can't assume it. I'm writing a new
> bash-compatible shell with nommu support, which means in order to do subshell
> and background tasks if (!CONFIG_FORK) I need to create a pipe pair, vfork(),
> have the child exec itself to unblock the parent, and then read the context data
> that just got discarded through the pipe from the parent. ("Wheee." And you can
> quote me on that.)

Do you have clone(CLONE_VM) ?  If my quick skim of the kernel sources is
correct that should be the same as vfork except without causing the
parent to wait for you.  Which I think would remove the need to reexec
yourself.

>> The file descriptor is stored in mm->exe_file.
>> Probably the most straight forward implementation is to allow
>> execveat(AT_EXE_FILE, ...).
>
> Cool, that works.
>
>> You can look at binfmt_misc for how to reopen an open file descriptor.
>
> Added to the todo heap.

Yes I don't think it would be a lot of code.

I think you might be better served with clone(CLONE_VM) as it doesn't
block so you don't need to feed yourself your context over a pipe.

Eric
