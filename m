Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90D5307FE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhA1Uvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 15:51:43 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57024 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhA1Uvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:51:38 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l5EFk-002oc7-0l; Thu, 28 Jan 2021 13:50:56 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1l5EFi-0007vO-Nl; Thu, 28 Jan 2021 13:50:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
        <20210119162204.2081137-3-mszeredi@redhat.com>
        <8735yw8k7a.fsf@x220.int.ebiederm.org>
        <20210128165852.GA20974@mail.hallyn.com>
        <87o8h8x1a6.fsf@x220.int.ebiederm.org>
        <CAJfpegv8e5+xn2X8-QrNnu0QJbe=CoK-DWNOdTV9EdrHrJvtEg@mail.gmail.com>
Date:   Thu, 28 Jan 2021 14:49:35 -0600
In-Reply-To: <CAJfpegv8e5+xn2X8-QrNnu0QJbe=CoK-DWNOdTV9EdrHrJvtEg@mail.gmail.com>
        (Miklos Szeredi's message of "Thu, 28 Jan 2021 21:38:00 +0100")
Message-ID: <87tur0vlb4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l5EFi-0007vO-Nl;;;mid=<87tur0vlb4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ay7DlYNZuYViioRwECggdIxy8OTBSDAk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 494 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (1.6%), b_tie_ro: 6 (1.3%), parse: 0.81 (0.2%),
        extract_message_metadata: 13 (2.7%), get_uri_detail_list: 0.97 (0.2%),
        tests_pri_-1000: 14 (2.8%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 0.97 (0.2%), tests_pri_-90: 92 (18.6%), check_bayes:
        90 (18.2%), b_tokenize: 5 (1.1%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 1.88 (0.4%), b_tok_touch_all: 74 (15.0%), b_finish: 0.82
        (0.2%), tests_pri_0: 153 (30.9%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 194 (39.3%), tests_pri_10:
        1.75 (0.4%), tests_pri_500: 207 (41.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, Jan 28, 2021 at 9:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> <aside>
>> From our previous discussions I would also argue it would be good
>> if there was a bypass that skipped all conversions if the reader
>> and the filesystem are in the same user namespace.
>> </aside>
>
> That's however just an optimization (AFAICS) that only makes sense if
> it helps a read world workload.   I'm not convinced that that's the
> case.

It is definitely a different issue.

From previous conversations with Serge, there is a concern with a
sysadmin wanting to see what is actually on disk.  In case there are
bugs that care about the different layout.  Just passing everything
through when no translation is necessary will allow that kind of
diagnosis.

As your patch demonstrates we already have had bugs in this area
so being able to get at the raw data may help people if they get into a
situation where bugs matter.

Eric
