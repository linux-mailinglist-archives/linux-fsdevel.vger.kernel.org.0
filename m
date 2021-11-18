Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9C4562FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhKRS6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:58:25 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:33592 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRS6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:58:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:36828)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnmZ7-00Dk1O-1D; Thu, 18 Nov 2021 11:55:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47584 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnmZ5-003dsG-1S; Thu, 18 Nov 2021 11:55:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Yordan Karadzhov \(VMware\)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        hagen@jauu.net, rppt@kernel.org,
        James.Bottomley@HansenPartnership.com, akpm@linux-foundation.org,
        vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
In-Reply-To: <20211118181210.281359-1-y.karadz@gmail.com> (Yordan Karadzhov's
        message of "Thu, 18 Nov 2021 20:12:06 +0200")
References: <20211118181210.281359-1-y.karadz@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 18 Nov 2021 12:55:07 -0600
Message-ID: <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnmZ5-003dsG-1S;;;mid=<87a6i1xpis.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19CHNrH0EbIYtS7glLiHudcKRXMiScCSek=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4835]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Yordan Karadzhov \(VMware\)" <y.karadz@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 443 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.9%), b_tie_ro: 2.8 (0.6%), parse: 0.68
        (0.2%), extract_message_metadata: 8 (1.8%), get_uri_detail_list: 1.26
        (0.3%), tests_pri_-1000: 11 (2.4%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 128 (28.9%), check_bayes:
        127 (28.7%), b_tokenize: 6 (1.3%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 1.74 (0.4%), b_tok_touch_all: 108 (24.4%), b_finish: 0.73
        (0.2%), tests_pri_0: 280 (63.1%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 1.57 (0.4%), poll_dns_idle: 0.28 (0.1%),
        tests_pri_10: 1.79 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Adding the containers mailing list which is for discussions like this.

"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> writes:

> We introduce a simple read-only virtual filesystem that provides
> direct mechanism for examining the existing hierarchy of namespaces
> on the system. For the purposes of this PoC, we tried to keep the
> implementation of the pseudo filesystem as simple as possible. Only
> two namespace types (PID and UTS) are coupled to it for the moment.
> Nevertheless, we do not expect having significant problems when
> adding all other namespace types.
>
> When fully functional, 'namespacefs' will allow the user to see all
> namespaces that are active on the system and to easily retrieve the
> specific data, managed by each namespace. For example the PIDs of
> all tasks enclosed in the individual PID namespaces. Any existing
> namespace on the system will be represented by its corresponding
> directory in namespacesfs. When a namespace is created a directory
> will be added. When a namespace is destroyed, its corresponding
> directory will be removed. The hierarchy of the directories will
> follow the hierarchy of the namespaces.

It is not correct to use inode numbers as the actual names for
namespaces.

I can not see anything else you can possibly uses as names for
namespaces.

To allow container migration between machines and similar things
the you wind up needing a namespace for your names of namespaces.

Further you talk about hierarchy and you have not added support for the
user namespace.  Without the user namespace there is not hierarchy with
any namespace but the pid namespace. There is definitely no meaningful
hierarchy without the user namespace.

As far as I can tell merging this will break CRIU and container
migration in general (as the namespace of namespaces problem is not
solved).

Since you are not solving the problem of a namespace for namespaces,
yet implementing something that requires it.

Since you are implementing hierarchy and ignoring the user namespace
which gives structure and hierarchy to the namespaces.

Since this breaks existing use cases without giving a solution.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
