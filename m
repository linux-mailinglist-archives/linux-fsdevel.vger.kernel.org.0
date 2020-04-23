Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3D71B660B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgDWVPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 17:15:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51522 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:15:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRjBd-0002oW-19; Thu, 23 Apr 2020 15:15:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRjBb-0007nr-F3; Thu, 23 Apr 2020 15:15:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <cai@lca.pw>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <06B50A1C-406F-4057-BFA8-3A7729EA7469@lca.pw>
        <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw>
Date:   Thu, 23 Apr 2020 16:11:58 -0500
In-Reply-To: <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw> (Qian Cai's message
        of "Thu, 23 Apr 2020 16:11:48 -0400")
Message-ID: <877dy5x5y9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRjBb-0007nr-F3;;;mid=<877dy5x5y9.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18X/dkRBG1ZIo4nUQGAwX9BujYXDfYLa/s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_Palau_URI autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4973]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  5.0 XM_Palau_URI RAW: Palau .pw URI
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Qian Cai <cai@lca.pw>
X-Spam-Relay-Country: 
X-Spam-Timing: total 742 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (1.6%), b_tie_ro: 11 (1.4%), parse: 1.30
        (0.2%), extract_message_metadata: 15 (2.0%), get_uri_detail_list: 0.89
        (0.1%), tests_pri_-1000: 5 (0.7%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 65 (8.7%), check_bayes: 63
        (8.5%), b_tokenize: 4.8 (0.6%), b_tok_get_all: 5 (0.7%), b_comp_prob:
        1.62 (0.2%), b_tok_touch_all: 48 (6.5%), b_finish: 0.95 (0.1%),
        tests_pri_0: 627 (84.6%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: out-of-bounds in pid_nr_ns() due to "proc: modernize proc to support multiple private instances"
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

> Eric, Stephen, can you pull out this series while Alexey is getting to
> the bottom of this slab-out-of-bounds?

Done several hours ago on my end.

fs/locks.c and fs/security/tomoyo/realpath.c were rolling proc_pid_ns by
hand and we need to correct that before Alexey's patches are safe.  That
is inprogress now.

Eric
