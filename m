Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99BE19C6C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbgDBQIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 12:08:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35208 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389392AbgDBQIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:08:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK2OD-0007Me-0v; Thu, 02 Apr 2020 10:08:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK2Nx-00044C-IX; Thu, 02 Apr 2020 10:08:20 -0600
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
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
        <20200327172331.418878-9-gladkov.alexey@gmail.com>
Date:   Thu, 02 Apr 2020 11:05:21 -0500
In-Reply-To: <20200327172331.418878-9-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Fri, 27 Mar 2020 18:23:30 +0100")
Message-ID: <87d08pkh4u.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jK2Nx-00044C-IX;;;mid=<87d08pkh4u.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Wu6fmQHfDofF39L0DBA9uLm55GXDDZi0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1157]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 9459 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.0%), b_tie_ro: 2.8 (0.0%), parse: 0.72
        (0.0%), extract_message_metadata: 2.3 (0.0%), get_uri_detail_list:
        0.77 (0.0%), tests_pri_-1000: 3.3 (0.0%), tests_pri_-950: 0.94 (0.0%),
        tests_pri_-900: 0.83 (0.0%), tests_pri_-90: 108 (1.1%), check_bayes:
        105 (1.1%), b_tokenize: 6 (0.1%), b_tok_get_all: 5 (0.1%),
        b_comp_prob: 1.34 (0.0%), b_tok_touch_all: 89 (0.9%), b_finish: 0.85
        (0.0%), tests_pri_0: 220 (2.3%), check_dkim_signature: 0.64 (0.0%),
        check_dkim_adsp: 2.3 (0.0%), poll_dns_idle: 9101 (96.2%),
        tests_pri_10: 1.72 (0.0%), tests_pri_500: 9111 (96.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v10 8/9] proc: use human-readable values for hidehid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> The hidepid parameter values are becoming more and more and it becomes
> difficult to remember what each new magic number means.

In principle I like this change.  In practice I think you have just
broken ABI compatiblity with the new mount ABI.

In particular the following line seems broken.

> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index dbcd96f07c7a..ba782d6e6197 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -45,7 +45,7 @@ enum proc_param {
>  
>  static const struct fs_parameter_spec proc_fs_parameters[] = {
>  	fsparam_u32("gid",	Opt_gid),
> -	fsparam_u32("hidepid",	Opt_hidepid),
> +	fsparam_string("hidepid",	Opt_hidepid),
>  	fsparam_string("subset",	Opt_subset),
>  	{}
>  };

As I read fs_parser.c fs_param_is_u32 handles string inputs and turns them
into numbers, and it handles binary numbers.  However fs_param_is_string
appears to only handle strings.  It appears to have not capacity to turn
raw binary numbers into strings.

So I think we probably need to fix fs_param_is_string to raw binary
numbers before we can safely make this change to fs/proc/root.c

David am I reading the fs_parser.c code correctly?  If I am are you ok
with a change like the above?

Eric
