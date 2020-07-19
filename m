Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6073A225355
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 20:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgGSSND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 14:13:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52428 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jxDo4-0006mh-Ph; Sun, 19 Jul 2020 12:13:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jxDo3-0004e5-LR; Sun, 19 Jul 2020 12:13:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        jlayton@redhat.com, christian@brauner.io,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
Date:   Sun, 19 Jul 2020 13:10:04 -0500
In-Reply-To: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Thu, 16 Jul 2020 21:34:37 +0100")
Message-ID: <87tuy3nzpf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jxDo3-0004e5-LR;;;mid=<87tuy3nzpf.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18n0FB3g8mviWS9DVa7xa6vqYpzduK73Jk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4933]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Howells <dhowells@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 498 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 9 (1.7%), parse: 0.84 (0.2%),
         extract_message_metadata: 10 (2.0%), get_uri_detail_list: 0.88 (0.2%),
         tests_pri_-1000: 13 (2.7%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 72 (14.5%), check_bayes:
        71 (14.2%), b_tokenize: 6 (1.2%), b_tok_get_all: 5 (1.1%),
        b_comp_prob: 1.83 (0.4%), b_tok_touch_all: 55 (11.0%), b_finish: 0.81
        (0.2%), tests_pri_0: 376 (75.6%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/5] keys: Security changes, ACLs and Container keyring
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Here are some patches to provide some security changes and some container
> support:

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

There remain unfixed security issues in the new mount api.   Those need
to get fixed before it is even worth anyones time reviewing new code.

Those issues came up in the review.  I successfully demonstrated how to
address the security issues in the new mount api before the code was
merged.  Yet the code was merged with the security issues present,
and I have not seem those issues addressed.

So far I have had to rewrite two filesystems because of bugs in the
mount API.

Enough is enough.  Let's get the what has already been merged sorted
out before we had more.

Eric
