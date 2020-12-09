Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907972D4D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 23:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbgLIWHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 17:07:47 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:41826 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgLIWHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:07:44 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7bz-0059tg-AI; Wed, 09 Dec 2020 15:07:03 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7bv-0004QI-Jp; Wed, 09 Dec 2020 15:07:02 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-15-ebiederm@xmission.com>
        <20201207232900.GD4115853@ZenIV.linux.org.uk>
        <877dprvs8e.fsf@x220.int.ebiederm.org>
        <20201209040731.GK3579531@ZenIV.linux.org.uk>
        <877dprtxly.fsf@x220.int.ebiederm.org>
        <20201209142359.GN3579531@ZenIV.linux.org.uk>
        <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
        <20201209194938.GS7338@casper.infradead.org>
Date:   Wed, 09 Dec 2020 16:06:21 -0600
In-Reply-To: <20201209194938.GS7338@casper.infradead.org> (Matthew Wilcox's
        message of "Wed, 9 Dec 2020 19:49:38 +0000")
Message-ID: <877dpqprc2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kn7bv-0004QI-Jp;;;mid=<877dpqprc2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+CaXIkETEianRwMvPYKmQ6uf9fDkRkFWk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2817 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.4%), b_tie_ro: 10 (0.3%), parse: 0.83
        (0.0%), extract_message_metadata: 12 (0.4%), get_uri_detail_list: 0.68
        (0.0%), tests_pri_-1000: 5 (0.2%), tests_pri_-950: 1.56 (0.1%),
        tests_pri_-900: 1.14 (0.0%), tests_pri_-90: 192 (6.8%), check_bayes:
        189 (6.7%), b_tokenize: 4.0 (0.1%), b_tok_get_all: 5 (0.2%),
        b_comp_prob: 1.91 (0.1%), b_tok_touch_all: 174 (6.2%), b_finish: 1.10
        (0.0%), tests_pri_0: 120 (4.3%), check_dkim_signature: 0.44 (0.0%),
        check_dkim_adsp: 3.1 (0.1%), poll_dns_idle: 2440 (86.6%),
        tests_pri_10: 2.1 (0.1%), tests_pri_500: 2468 (87.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] files: rcu free files_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Dec 09, 2020 at 12:04:38PM -0600, Eric W. Biederman wrote:
>> @@ -397,8 +397,9 @@ static struct fdtable *close_files(struct files_struct * files)
>>  		set = fdt->open_fds[j++];
>>  		while (set) {
>>  			if (set & 1) {
>> -				struct file * file = xchg(&fdt->fd[i], NULL);
>> +				struct file * file = fdt->fd[i];
>>  				if (file) {
>> +					rcu_assign_pointer(fdt->fd[i], NULL);
>
> Assuming this is safe, you can use RCU_INIT_POINTER() here because you're
> storing NULL, so you don't need the wmb() before storing the pointer.

Thanks.  I was remembering there was a special case like and I had
forgotten what the rule was.

Eric

