Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0883920197E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392573AbgFSR3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 13:29:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48044 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgFSR3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:29:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmKp2-0001N7-BM; Fri, 19 Jun 2020 11:29:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmKp1-0004bC-7P; Fri, 19 Jun 2020 11:29:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
Date:   Fri, 19 Jun 2020 12:24:41 -0500
In-Reply-To: <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com> (Junxiao Bi's
        message of "Fri, 19 Jun 2020 08:56:21 -0700")
Message-ID: <87k1036k9y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmKp1-0004bC-7P;;;mid=<87k1036k9y.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18t/kZAHYChf4fQBy2tfa9zm0fEa/HZ2QQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0096]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Junxiao Bi <junxiao.bi@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 540 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (2.5%), b_tie_ro: 12 (2.1%), parse: 1.08
        (0.2%), extract_message_metadata: 3.9 (0.7%), get_uri_detail_list:
        0.92 (0.2%), tests_pri_-1000: 4.0 (0.7%), tests_pri_-950: 1.55 (0.3%),
        tests_pri_-900: 1.29 (0.2%), tests_pri_-90: 123 (22.8%), check_bayes:
        121 (22.3%), b_tokenize: 3.8 (0.7%), b_tok_get_all: 5 (1.0%),
        b_comp_prob: 1.50 (0.3%), b_tok_touch_all: 105 (19.5%), b_finish: 1.53
        (0.3%), tests_pri_0: 373 (69.1%), check_dkim_signature: 0.84 (0.2%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Junxiao Bi <junxiao.bi@oracle.com> writes:

> Hi Eric,
>
> The patch didn't improve lock contention.

Which raises the question where is the lock contention coming from.

Especially with my first variant.  Only the last thread to be reaped
would free up anything in the cache.

Can you comment out the call to proc_flush_pid entirely?

That will rule out the proc_flush_pid in d_invalidate entirely.

The only candidate I can think of d_invalidate aka (proc_flush_pid) vs ps.

Eric
