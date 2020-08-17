Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8824734B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbgHQSx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 14:53:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50364 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbgHQPvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:51:39 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7hQ4-004Hpr-St; Mon, 17 Aug 2020 09:51:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7hQ4-0001iz-0P; Mon, 17 Aug 2020 09:51:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrei Vagin <avagin@gmail.com>, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <875za43b3w.fsf@x220.int.ebiederm.org>
        <9ceb5049-6aea-1429-e35f-d86480f10d72@virtuozzo.com>
        <20200806080540.GA18865@gmail.com>
        <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
        <20200810173431.GA68662@gmail.com>
        <33565447-9b97-a820-bc2c-a4ff53a7675a@virtuozzo.com>
        <20200812175338.GA596568@gmail.com>
        <8f3c9414-9efc-cc01-fb2a-4d83266e96b2@virtuozzo.com>
        <20200814011649.GA611947@gmail.com>
        <0af3f2fa-f2c3-fb7d-b57e-9c41fe94ca58@virtuozzo.com>
        <20200814192102.GA786465@gmail.com>
        <56ed1fb9-4f1f-3528-3f09-78478b9dfcf2@virtuozzo.com>
Date:   Mon, 17 Aug 2020 10:48:01 -0500
In-Reply-To: <56ed1fb9-4f1f-3528-3f09-78478b9dfcf2@virtuozzo.com> (Kirill
        Tkhai's message of "Mon, 17 Aug 2020 17:05:26 +0300")
Message-ID: <87d03pb7f2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k7hQ4-0001iz-0P;;;mid=<87d03pb7f2.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uQ67eEkrOiJa8IBfKMb+gM5QknVFhS74=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kirill Tkhai <ktkhai@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 478 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 1.63 (0.3%),
         extract_message_metadata: 6 (1.2%), get_uri_detail_list: 3.1 (0.6%),
        tests_pri_-1000: 6 (1.2%), tests_pri_-950: 1.98 (0.4%),
        tests_pri_-900: 1.53 (0.3%), tests_pri_-90: 84 (17.7%), check_bayes:
        83 (17.3%), b_tokenize: 8 (1.7%), b_tok_get_all: 10 (2.1%),
        b_comp_prob: 5.0 (1.0%), b_tok_touch_all: 55 (11.6%), b_finish: 0.97
        (0.2%), tests_pri_0: 343 (71.8%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to expose namespaces lineary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Creating names in the kernel for namespaces is very difficult and
problematic.  I have not seen anything that looks like  all of the
problems have been solved with restoring these new names.

When your filter for your list of namespaces is user namespace creating
a new directory in proc is highly questionable.

As everyone uses proc placing this functionality in proc also amplifies
the problem of creating names.


Rather than proc having a way to mount a namespace filesystem filter by
the user namespace of the mounter likely to have many many fewer
problems.  Especially as we are limiting/not allow new non-process
things and ideally finding a way to remove the non-process things.


Kirill you have a good point that taking the case where a pid namespace
does not exist in a user namespace is likely quite unrealistic.

Kirill mentioned upthread that the list of namespaces are the list that
can appear in a container.  Except by discipline in creating containers
it is not possible to know which namespaces may appear in attached to a
process.  It is possible to be very creative with setns, and violate any
constraint you may have.  Which means your filtered list of namespaces
may not contain all of the namespaces used by a set of processes.  This
further argues that attaching the list of namespaces to proc does not
make sense.

Andrei has a good point that placing the names in a hierarchy by
user namespace has the potential to create more freedom when
assigning names to namespaces, as it means the names for namespaces
do not need to be globally unique, and while still allowing the names
to stay the same.


To recap the possibilities for names for namespaces that I have seen
mentioned in this thread are:
  - Names per mount
  - Names per user namespace

I personally suspect that names per mount are likely to be so flexibly
they are confusing, while names per user namespace are likely to be
rigid, possibly too rigid to use.

It all depends upon how everything is used.  I have yet to see a
complete story of how these names will be generated and used.  So I can
not really judge.


Let me add another take on this idea that might give this work a path
forward. If I were solving this I would explore giving nsfs directories
per user namespace, and a way to mount it that exposed the directory of
the mounters current user namespace (something like btrfs snapshots).

Hmm.  For the user namespace directory I think I would give it a file
"ns" that can be opened to get a file handle on the user namespace.
Plus a set of subdirectories "cgroup", "ipc", "mnt", "net", "pid",
"user", "uts") for each type of namespace.  In each directory I think
I would just have a 64bit counter and each new entry I would assign the
next number from that counter.

The restore could either have the ability to rename files or simply the
ability to bump the counter (like we do with pids) so the names of the
namespaces can be restored.

That winds up making a user namespace the namespace of namespaces, so
I am not 100% about the idea. 

Eric


