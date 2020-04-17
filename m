Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598E41AE757
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 23:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDQVL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 17:11:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46498 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDQVL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:11:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPYGk-0005yL-PC; Fri, 17 Apr 2020 15:11:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPYGi-0003AY-UF; Fri, 17 Apr 2020 15:11:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20200414070142.288696-1-hch@lst.de>
        <20200414070142.288696-3-hch@lst.de>
Date:   Fri, 17 Apr 2020 16:08:23 -0500
In-Reply-To: <20200414070142.288696-3-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 14 Apr 2020 09:01:36 +0200")
Message-ID: <87pnc5akhk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPYGi-0003AY-UF;;;mid=<87pnc5akhk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sMSqzlC3UCo8sLeQoBbXwuy1pdf5wSzo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4911]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1372 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (1.0%), b_tie_ro: 12 (0.9%), parse: 1.10
        (0.1%), extract_message_metadata: 13 (0.9%), get_uri_detail_list: 1.38
        (0.1%), tests_pri_-1000: 4.7 (0.3%), tests_pri_-950: 1.53 (0.1%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 62 (4.5%), check_bayes: 60
        (4.4%), b_tokenize: 4.7 (0.3%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        1.68 (0.1%), b_tok_touch_all: 42 (3.0%), b_finish: 1.22 (0.1%),
        tests_pri_0: 138 (10.1%), check_dkim_signature: 0.48 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 1114 (81.2%),
        tests_pri_10: 2.0 (0.1%), tests_pri_500: 1132 (82.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 2/8] signal: clean up __copy_siginfo_to_user32
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Instead of an architecture specific calling convention in common code
> just pass a flags argument with architecture specific values.

This bothers me because it makes all architectures pay for the sins of
x32.  Further it starts burying the details of the what is happening in
architecture specific helpers.  Hiding the fact that there is only
one niche architecture that does anything weird.

I am very sensitive to hiding away signal handling details right now
because way to much of the signal handling code got hidden in
architecture specific files and was quite buggy because as a result.

My general sense is putting all of the weird details up front and center
in kernel/signal.c is the only way for this code will be looked at
and successfully maintained.

How about these patches to solve set_fs with binfmt_elf instead:

Eric W. Biederman (2):
      signal: Factor copy_siginfo_to_external32 from copy_siginfo_to_user32
      signal: Remove the set_fs in binfmt_elf.c:fill_siginfo_note

 fs/binfmt_elf.c        |   5 +----
 fs/compat_binfmt_elf.c |   2 +-
 include/linux/compat.h |   1 +
 include/linux/signal.h |   7 +++++++
 kernel/signal.c        | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------

Eric
