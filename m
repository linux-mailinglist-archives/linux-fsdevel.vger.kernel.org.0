Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A721DCC7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgEUL51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 07:57:27 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47184 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgEUL51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 07:57:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbjpB-0002UN-NE; Thu, 21 May 2020 05:57:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbjpA-00053F-6i; Thu, 21 May 2020 05:57:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
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
        <87d06ygssl.fsf@x220.int.ebiederm.org>
        <202005201642.E1C6B4A457@keescook>
Date:   Thu, 21 May 2020 06:53:36 -0500
In-Reply-To: <202005201642.E1C6B4A457@keescook> (Kees Cook's message of "Wed,
        20 May 2020 16:43:28 -0700")
Message-ID: <875zcph5bz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbjpA-00053F-6i;;;mid=<875zcph5bz.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oiz5qlPjrQa2T3u47CbOQrej8gssp24I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1127 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (1.2%), b_tie_ro: 12 (1.0%), parse: 1.66
        (0.1%), extract_message_metadata: 19 (1.7%), get_uri_detail_list: 1.72
        (0.2%), tests_pri_-1000: 8 (0.7%), tests_pri_-950: 1.81 (0.2%),
        tests_pri_-900: 1.40 (0.1%), tests_pri_-90: 56 (5.0%), check_bayes: 54
        (4.8%), b_tokenize: 9 (0.8%), b_tok_get_all: 7 (0.6%), b_comp_prob:
        3.0 (0.3%), b_tok_touch_all: 31 (2.8%), b_finish: 1.17 (0.1%),
        tests_pri_0: 1013 (89.8%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        2.0 (0.2%), tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, May 20, 2020 at 05:12:10PM -0500, Eric W. Biederman wrote:
>> 
>> I have pushed this out to:
>> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next
>> 
>> I have collected up the acks and reviewed-by's, and fixed a couple of
>> typos but that is it.
>
> Awesome!
>
>> If we need comment fixes or additional cleanups we can apply that on top
>> of this series.   This way the code can sit in linux-next until the
>> merge window opens.
>> 
>> Before I pushed this out I also tested this with Kees new test of
>> binfmt_misc and did not find any problems.
>
> Did this mean to say binfmt_script? It'd be nice to get a binfmt_misc
> test too, though.

Yes.  Sorry.  I meant your binfmt_script test.

Eric
