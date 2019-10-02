Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAADC922E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 21:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfJBTTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 15:19:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46360 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBTTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:19:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFk9v-0001xj-7D; Wed, 02 Oct 2019 13:19:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFk9u-0004LZ-Lh; Wed, 02 Oct 2019 13:19:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Daegyu Han <dgswsk@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
References: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
        <20191002124651.GC13880@mit.edu>
        <CA+i3KrYvp1pXbpCb_WJDCRx0COU2KCFT_Nfsgcn1mLGrVzErvA@mail.gmail.com>
Date:   Wed, 02 Oct 2019 14:18:57 -0500
In-Reply-To: <CA+i3KrYvp1pXbpCb_WJDCRx0COU2KCFT_Nfsgcn1mLGrVzErvA@mail.gmail.com>
        (Daegyu Han's message of "Wed, 2 Oct 2019 23:42:47 +0900")
Message-ID: <875zl7gdlq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iFk9u-0004LZ-Lh;;;mid=<875zl7gdlq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18SzlbA8dtCDypuh+W4sfMx6jJFF19m/Oc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0598]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Daegyu Han <dgswsk@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 211 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.3%), b_tie_ro: 2.00 (0.9%), parse: 0.98
        (0.5%), extract_message_metadata: 3.2 (1.5%), get_uri_detail_list:
        1.08 (0.5%), tests_pri_-1000: 2.8 (1.3%), tests_pri_-950: 1.05 (0.5%),
        tests_pri_-900: 0.84 (0.4%), tests_pri_-90: 15 (6.9%), check_bayes: 13
        (6.3%), b_tokenize: 3.6 (1.7%), b_tok_get_all: 4.9 (2.3%),
        b_comp_prob: 1.17 (0.6%), b_tok_touch_all: 2.3 (1.1%), b_finish: 0.58
        (0.3%), tests_pri_0: 169 (80.1%), check_dkim_signature: 0.35 (0.2%),
        check_dkim_adsp: 2.3 (1.1%), poll_dns_idle: 1.01 (0.5%), tests_pri_10:
        1.68 (0.8%), tests_pri_500: 5.0 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: How can I completely evict(remove) the inode from memory and access the disk next time?
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daegyu Han <dgswsk@gmail.com> writes:

> Thank you for your consideration.
>
> Okay, I will check ocfs2 out.
>
> By the way, is there any possibility to implement this functionality
> in the vfs layer?

The vfs does support this.  It is just the filesystems have to do their
part as well.

> I looked at the dcache.c, inode.c, and mm/vmscan.c code and looked at
> several functions,
> and as you said, they seem to have way complex logic.
>
> The logic I thought was to release the desired dentry, dentry_kill()
> the negative dentry, and break the inodes of the file that had that
> dentry.

That fundamentally doesn't work when writes are cached (as the vfs
does).

> Can you tell me the detailed logic of the dentry and inode caches that
> I'm curious about?
> If not, can you give me a reference paper or book?

Look at the revalidate method in the vfs.

Eric
