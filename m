Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A81A35AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgDIOQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 10:16:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45682 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIOQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:16:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMXz8-0002BY-0C; Thu, 09 Apr 2020 08:16:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMXz6-0008S7-HG; Thu, 09 Apr 2020 08:16:49 -0600
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
        <87y2r4vmpo.fsf@x220.int.ebiederm.org>
        <20200409134236.mksvudaucp3jawf6@comp-core-i7-2640m-0182e6>
Date:   Thu, 09 Apr 2020 09:13:55 -0500
In-Reply-To: <20200409134236.mksvudaucp3jawf6@comp-core-i7-2640m-0182e6>
        (Alexey Gladkov's message of "Thu, 9 Apr 2020 15:42:36 +0200")
Message-ID: <87r1wwvja4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMXz6-0008S7-HG;;;mid=<87r1wwvja4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194Q5MsMFzZbdx4uJwnCGkLXvKZWMd2p1E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3993]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 575 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.5%), parse: 1.05 (0.2%),
         extract_message_metadata: 4.3 (0.7%), get_uri_detail_list: 1.94
        (0.3%), tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.55 (0.3%),
        tests_pri_-900: 1.61 (0.3%), tests_pri_-90: 264 (45.9%), check_bayes:
        262 (45.6%), b_tokenize: 9 (1.6%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 234 (40.7%), b_finish: 3.9
        (0.7%), tests_pri_0: 269 (46.8%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RESEND v11 0/8] proc: modernize proc to support multiple private instances
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Thu, Apr 09, 2020 at 07:59:47AM -0500, Eric W. Biederman wrote:
>> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>> 
>> > Preface:
>> > --------
>> > This is patchset v11 to modernize procfs and make it able to support multiple
>> > private instances per the same pid namespace.
>> >
>> > This patchset can be applied on top of:
>> >
>> > git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
>> > 4b871ce26ab2
>> 
>> 
>> 
>> Why the resend?
>> 
>> Nothing happens until the merge window closes with the release of -rc1
>> (almost certainly on this coming Sunday).  I goofed and did not act on
>> this faster, and so it is my fault this did not make it into linux-next
>> before the merge window.  But I am not going to rush this forward.
>> 
>> 
>> 
>> You also ignored my review and have not even descibed why it is safe
>> to change the type of a filesystem parameter.
>> 
>> -	fsparam_u32("hidepid",	Opt_hidepid),
>> +	fsparam_string("hidepid",	Opt_hidepid),
>> 
>> 
>> Especially in light of people using fsconfig(fd, FSCONFIG_SET_...);
>> 
>> All I need is someone to point out that fsparam_u32 does not use
>> FSCONFIG_SET_BINARY, but FSCONFIG_SET_STRING.
>
> I decided to resend again because I was not sure that the previous
> patchset was not lost. I also wanted to ask David to review and explain
> about the new API. I in any case did not ignore your question about
> changing the type of the parameter.
>
> I guess I was wrong when I sent the whole patchset again. Sorry.
>
>> My apologies for being grumpy but this feels like you are asking me to
>> go faster when it is totally inappropriate to do so, while busily
>> ignoring my feedback.
>> 
>> I think this should happen.  But I can't do anything until after -rc1.
>
> I think you misunderstood me. I didn't mean to rush you.

It looks like.  My apologies for the misunderstanding then.

Eric



