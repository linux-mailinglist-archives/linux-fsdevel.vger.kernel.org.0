Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19B01CC42B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgEITnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 15:43:55 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53792 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEITny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 15:43:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVNz-0002uX-Fb; Sat, 09 May 2020 13:43:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVNy-0006US-Ht; Sat, 09 May 2020 13:43:47 -0600
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
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
Date:   Sat, 09 May 2020 14:40:17 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVNy-0006US-Ht;;;mid=<87v9l4zyla.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19IOND8rj4bMCGwxstKDUfSmpiOWIeGpr4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 511 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 12 (2.3%), parse: 0.81
        (0.2%), extract_message_metadata: 2.3 (0.5%), get_uri_detail_list:
        0.70 (0.1%), tests_pri_-1000: 3.6 (0.7%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 160 (31.3%), check_bayes:
        158 (31.0%), b_tokenize: 6 (1.1%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 138 (26.9%), b_finish: 1.17
        (0.2%), tests_pri_0: 311 (60.8%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 1.13 (0.2%), tests_pri_10:
        3.8 (0.7%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/5] exec: Control flow simplifications
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


It is hard to follow the control flow in exec.c as the code has evolved
over time and something that used to work one way now works another.
This set of changes attempts to address the worst of that, to remove
unnecessary work and to make the code a little easier to follow.

The one rough point in my changes is cap_bprm_set_creds propbably
needs a new name as I have taken it out of security_bprm_set_creds
but my imagination failed to come up with anything better.

Eric W. Biederman (5):
      exec: Call cap_bprm_set_creds directly from prepare_binprm
      exec: Directly call security_bprm_set_creds from __do_execve_file
      exec: Remove recursion from search_binary_handler
      exec: Allow load_misc_binary to call prepare_binfmt unconditionally
      exec: Move the call of prepare_binprm into search_binary_handler

 arch/alpha/kernel/binfmt_loader.c |  5 +----
 fs/binfmt_em86.c                  |  7 +-----
 fs/binfmt_misc.c                  | 22 +++---------------
 fs/binfmt_script.c                |  5 +----
 fs/exec.c                         | 47 +++++++++++++++++++++------------------
 include/linux/binfmts.h           | 11 ++-------
 include/linux/security.h          |  2 +-
 security/apparmor/domain.c        |  3 ---
 security/commoncap.c              |  1 -
 security/selinux/hooks.c          |  2 --
 security/smack/smack_lsm.c        |  3 ---
 security/tomoyo/tomoyo.c          |  6 -----
 12 files changed, 34 insertions(+), 80 deletions(-)

---

I think this is correct set of changes that makes things better but
please look things over/review this code if you have any expertise in
anything I am touching.

Thank you,
Eric


