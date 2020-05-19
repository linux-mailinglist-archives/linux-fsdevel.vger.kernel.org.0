Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6B1D9AC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgESPKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 11:10:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44388 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgESPKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 11:10:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb3sk-0005GH-Fu; Tue, 19 May 2020 09:10:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb3si-0001s6-RW; Tue, 19 May 2020 09:10:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200518055457.12302-1-keescook@chromium.org>
Date:   Tue, 19 May 2020 10:06:32 -0500
In-Reply-To: <20200518055457.12302-1-keescook@chromium.org> (Kees Cook's
        message of "Sun, 17 May 2020 22:54:53 -0700")
Message-ID: <87a724t153.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb3si-0001s6-RW;;;mid=<87a724t153.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+A3FfcWjqtqqukiK5gO20MFpn1V2jd41Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4778]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 456 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.0%), parse: 1.43 (0.3%),
         extract_message_metadata: 22 (4.8%), get_uri_detail_list: 2.1 (0.5%),
        tests_pri_-1000: 7 (1.6%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 183 (40.1%), check_bayes:
        169 (37.1%), b_tokenize: 6 (1.3%), b_tok_get_all: 5 (1.2%),
        b_comp_prob: 1.90 (0.4%), b_tok_touch_all: 153 (33.5%), b_finish: 1.04
        (0.2%), tests_pri_0: 213 (46.7%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.43 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Hi,
>
> While looking at the code paths for the proposed O_MAYEXEC flag, I saw
> some things that looked like they should be fixed up.
>
>   exec: Change uselib(2) IS_SREG() failure to EACCES
> 	This just regularizes the return code on uselib(2).
>
>   exec: Relocate S_ISREG() check
> 	This moves the S_ISREG() check even earlier than it was already.
>
>   exec: Relocate path_noexec() check
> 	This adds the path_noexec() check to the same place as the
> 	S_ISREG() check.
>
>   fs: Include FMODE_EXEC when converting flags to f_mode
> 	This seemed like an oversight, but I suspect there is some
> 	reason I couldn't find for why FMODE_EXEC doesn't get set in
> 	f_mode and just stays in f_flags.

So I took a look at this series.

I think the belt and suspenders approach of adding code in open and then
keeping it in exec and uselib is probably wrong.  My sense of the
situation is a belt and suspenders approach is more likely to be
confusing and result in people making mistakes when maintaining the code
than to actually be helpful.

Eric
