Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1FF1CB78F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHSrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 14:47:05 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37948 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgEHSrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 14:47:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX81T-0003wn-Rx; Fri, 08 May 2020 12:47:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jX81S-0002jx-TS; Fri, 08 May 2020 12:46:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
Date:   Fri, 08 May 2020 13:43:31 -0500
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 05 May 2020 14:39:32 -0500")
Message-ID: <87sgga6ze4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jX81S-0002jx-TS;;;mid=<87sgga6ze4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zP/RKyneohwPABJrj/EMwOUTBmYaO2o8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 562 ms - load_scoreonly_sql: 0.19 (0.0%),
        signal_user_changed: 13 (2.2%), b_tie_ro: 10 (1.8%), parse: 1.39
        (0.2%), extract_message_metadata: 3.9 (0.7%), get_uri_detail_list:
        0.67 (0.1%), tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.47 (0.3%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 123 (21.8%), check_bayes:
        121 (21.5%), b_tokenize: 6 (1.0%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 104 (18.4%), b_finish: 0.94
        (0.2%), tests_pri_0: 391 (69.6%), check_dkim_signature: 0.95 (0.2%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.25 (0.0%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/6] exec: Trivial cleanups for exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This is a continuation of my work to clean up exec so it's more
difficult problems are approachable.

The changes correct some comments, stop open coding mutex_lock_killable,
and move the point_of_no_return variable up to when the
point_of_no_return actually occurs.

I don't think there is anything controversial in there but if you see
something please let me know.

Eric W. Biederman (6):
      exec: Move the comment from above de_thread to above unshare_sighand
      exec: Fix spelling of search_binary_handler in a comment
      exec: Stop open coding mutex_lock_killable of cred_guard_mutex
      exec: Run sync_mm_rss before taking exec_update_mutex
      exec: Move handling of the point of no return to the top level
      exec: Set the point of no return sooner

 fs/exec.c       | 51 +++++++++++++++++++++++++++------------------------
 kernel/ptrace.c |  4 ++--
 2 files changed, 29 insertions(+), 26 deletions(-)
