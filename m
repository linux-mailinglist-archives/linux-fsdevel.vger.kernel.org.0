Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D873F397FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfFGVmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 17:42:13 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53098 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfFGVmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:42:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMcl-00081M-IX; Fri, 07 Jun 2019 15:42:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMck-0002Ng-OJ; Fri, 07 Jun 2019 15:42:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        <linux-arch@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
Date:   Fri, 07 Jun 2019 16:41:58 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <878sudax95.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZMck-0002Ng-OJ;;;mid=<878sudax95.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+g9ei2CqhvR0nVQpyGyzZNkV3XsxNnw0o=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,T_TooManySym_02,
        T_TooManySym_03,T_TooManySym_04,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 435 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.70 (0.4%), parse: 0.76
        (0.2%), extract_message_metadata: 10 (2.3%), get_uri_detail_list: 0.95
        (0.2%), tests_pri_-1000: 13 (2.9%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.10 (0.3%), tests_pri_-90: 22 (5.0%), check_bayes: 20
        (4.7%), b_tokenize: 6 (1.5%), b_tok_get_all: 7 (1.5%), b_comp_prob:
        1.91 (0.4%), b_tok_touch_all: 3.4 (0.8%), b_finish: 0.62 (0.1%),
        tests_pri_0: 372 (85.5%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.68 (0.2%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC PATCH 2/5] signal/kvm:  Stop using sigprocmask in kvm_sigset_(activate|deactivate)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Instead of jumping through hoops call __set_current_blocked directly.
As well as directly manipulating real_blocked.

This is in preparation for modifying the code to always keep
real_blocked in sync with blocked except in the rare cases when the
kernel needs to override it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 virt/kvm/kvm_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f0d13d9d125d..8575a1010bfc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2240,7 +2240,8 @@ void kvm_sigset_activate(struct kvm_vcpu *vcpu)
 	 * ->real_blocked don't care as long ->real_blocked is always a subset
 	 * of ->blocked.
 	 */
-	sigprocmask(SIG_SETMASK, &vcpu->sigset, &current->real_blocked);
+	current->real_blocked = current->blocked;
+	__set_current_blocked(&vcpu->sigset);
 }
 
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
@@ -2248,7 +2249,7 @@ void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
 	if (!vcpu->sigset_active)
 		return;
 
-	sigprocmask(SIG_SETMASK, &current->real_blocked, NULL);
+	__set_current_blocked(&current->real_blocked);
 	sigemptyset(&current->real_blocked);
 }
 
-- 
2.21.0.dirty

