Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3866E1C754B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 17:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgEFPri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 11:47:38 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47436 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgEFPrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 11:47:37 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWMGk-0006bR-Ln; Wed, 06 May 2020 09:47:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWMGi-0006AO-Iz; Wed, 06 May 2020 09:47:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200505101256.3121270-1-hch@lst.de>
        <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
        <877dxqgm7x.fsf@x220.int.ebiederm.org> <20200506063134.GA11391@lst.de>
Date:   Wed, 06 May 2020 10:44:07 -0500
In-Reply-To: <20200506063134.GA11391@lst.de> (Christoph Hellwig's message of
        "Wed, 6 May 2020 08:31:34 +0200")
Message-ID: <87lfm5cblk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWMGi-0006AO-Iz;;;mid=<87lfm5cblk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18n7ilHkYpqhNUvG5niq5VycMEtqxB6v30=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4986]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1706 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.2%), b_tie_ro: 2.4 (0.1%), parse: 0.62
        (0.0%), extract_message_metadata: 9 (0.5%), get_uri_detail_list: 0.65
        (0.0%), tests_pri_-1000: 3.9 (0.2%), tests_pri_-950: 1.01 (0.1%),
        tests_pri_-900: 0.81 (0.0%), tests_pri_-90: 107 (6.3%), check_bayes:
        105 (6.1%), b_tokenize: 4.1 (0.2%), b_tok_get_all: 5 (0.3%),
        b_comp_prob: 1.24 (0.1%), b_tok_touch_all: 92 (5.4%), b_finish: 0.67
        (0.0%), tests_pri_0: 154 (9.0%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 1409 (82.6%),
        tests_pri_10: 1.68 (0.1%), tests_pri_500: 1422 (83.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: remove set_fs calls from the coredump code v6
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Tue, May 05, 2020 at 03:28:50PM -0500, Eric W. Biederman wrote:
>> We probably can.   After introducing a kernel_compat_siginfo that is
>> the size that userspace actually would need.
>> 
>> It isn't something I want to mess with until this code gets merged, as I
>> think the set_fs cleanups are more important.
>> 
>> 
>> Christoph made some good points about how ugly the #ifdefs are in
>> the generic copy_siginfo_to_user32 implementation.
>
> Take a look at the series you are replying to, the magic x86 ifdefs are
> entirely gone from the common code :)

Interesting.

That is a different way of achieving that, and I don't hate it.
  
I still want whatever you are doing to settle before I touch that code
again.  Removing the set_fs is important and I have other fish to fry
at the moment.

Eric



