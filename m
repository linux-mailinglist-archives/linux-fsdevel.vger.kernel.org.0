Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF924738A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbgHQS5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 14:57:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48822 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgHQS53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:57:29 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7kJw-004byo-At; Mon, 17 Aug 2020 12:57:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7kJv-00016M-CE; Mon, 17 Aug 2020 12:57:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@gmail.com>, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        <linux-api@vger.kernel.org>
References: <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
        <20200810173431.GA68662@gmail.com>
        <33565447-9b97-a820-bc2c-a4ff53a7675a@virtuozzo.com>
        <20200812175338.GA596568@gmail.com>
        <8f3c9414-9efc-cc01-fb2a-4d83266e96b2@virtuozzo.com>
        <20200814011649.GA611947@gmail.com>
        <0af3f2fa-f2c3-fb7d-b57e-9c41fe94ca58@virtuozzo.com>
        <20200814192102.GA786465@gmail.com>
        <56ed1fb9-4f1f-3528-3f09-78478b9dfcf2@virtuozzo.com>
        <87d03pb7f2.fsf@x220.int.ebiederm.org>
        <20200817174745.jssxjdcwoqxeg5pu@wittgenstein>
Date:   Mon, 17 Aug 2020 13:53:52 -0500
In-Reply-To: <20200817174745.jssxjdcwoqxeg5pu@wittgenstein> (Christian
        Brauner's message of "Mon, 17 Aug 2020 19:47:45 +0200")
Message-ID: <87eeo59k8v.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k7kJv-00016M-CE;;;mid=<87eeo59k8v.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+FTGrE5+KQ689zTUzL/8oNHjtoktJJPc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 566 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 8 (1.4%), parse: 1.25 (0.2%),
         extract_message_metadata: 14 (2.6%), get_uri_detail_list: 3.4 (0.6%),
        tests_pri_-1000: 11 (2.0%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 65 (11.5%), check_bayes:
        63 (11.2%), b_tokenize: 12 (2.1%), b_tok_get_all: 13 (2.4%),
        b_comp_prob: 4.0 (0.7%), b_tok_touch_all: 30 (5.3%), b_finish: 0.87
        (0.2%), tests_pri_0: 448 (79.2%), check_dkim_signature: 0.94 (0.2%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.73 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to expose namespaces lineary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Aug 17, 2020 at 10:48:01AM -0500, Eric W. Biederman wrote:
>> 
>> Creating names in the kernel for namespaces is very difficult and
>> problematic.  I have not seen anything that looks like  all of the
>> problems have been solved with restoring these new names.
>> 
>> When your filter for your list of namespaces is user namespace creating
>> a new directory in proc is highly questionable.
>> 
>> As everyone uses proc placing this functionality in proc also amplifies
>> the problem of creating names.
>> 
>> 
>> Rather than proc having a way to mount a namespace filesystem filter by
>> the user namespace of the mounter likely to have many many fewer
>> problems.  Especially as we are limiting/not allow new non-process
>> things and ideally finding a way to remove the non-process things.
>> 
>> 
>> Kirill you have a good point that taking the case where a pid namespace
>> does not exist in a user namespace is likely quite unrealistic.
>> 
>> Kirill mentioned upthread that the list of namespaces are the list that
>> can appear in a container.  Except by discipline in creating containers
>> it is not possible to know which namespaces may appear in attached to a
>> process.  It is possible to be very creative with setns, and violate any
>> constraint you may have.  Which means your filtered list of namespaces
>> may not contain all of the namespaces used by a set of processes.  This
>
> Indeed. We use setns() quite creatively when intercepting syscalls and
> when attaching to a container.
>
>> further argues that attaching the list of namespaces to proc does not
>> make sense.
>> 
>> Andrei has a good point that placing the names in a hierarchy by
>> user namespace has the potential to create more freedom when
>> assigning names to namespaces, as it means the names for namespaces
>> do not need to be globally unique, and while still allowing the names
>> to stay the same.
>> 
>> 
>> To recap the possibilities for names for namespaces that I have seen
>> mentioned in this thread are:
>>   - Names per mount
>>   - Names per user namespace
>> 
>> I personally suspect that names per mount are likely to be so flexibly
>> they are confusing, while names per user namespace are likely to be
>> rigid, possibly too rigid to use.
>> 
>> It all depends upon how everything is used.  I have yet to see a
>> complete story of how these names will be generated and used.  So I can
>> not really judge.
>
> So I haven't fully understood either what the motivation for this
> patchset is.
> I can just speak to the use-case I had when I started prototyping
> something similar: We needed a way to get a view on all namespaces
> that exist on the system because we wanted a way to do namespace
> debugging on a live system. This interface could've easily lived in
> debugfs. The main point was that it should contain all namespaces.
> Note, that it wasn't supposed to be a hierarchical format it was only
> mean to list all namespaces and accessible to real root.
> The interface here is way more flexible/complex and I haven't yet
> figured out what exactly it is supposed to be used for.
>
>> 
>> 
>> Let me add another take on this idea that might give this work a path
>> forward. If I were solving this I would explore giving nsfs directories
>> per user namespace, and a way to mount it that exposed the directory of
>> the mounters current user namespace (something like btrfs snapshots).
>> 
>> Hmm.  For the user namespace directory I think I would give it a file
>> "ns" that can be opened to get a file handle on the user namespace.
>> Plus a set of subdirectories "cgroup", "ipc", "mnt", "net", "pid",
>> "user", "uts") for each type of namespace.  In each directory I think
>> I would just have a 64bit counter and each new entry I would assign the
>> next number from that counter.
>> 
>> The restore could either have the ability to rename files or simply the
>> ability to bump the counter (like we do with pids) so the names of the
>> namespaces can be restored.
>> 
>> That winds up making a user namespace the namespace of namespaces, so
>> I am not 100% about the idea. 
>
> I think you're right that we need to understand better what the use-case
> is. If I understand your suggestion correctly it wouldn't allow to show
> nested user namespaces if the nsfs mount is per-user namespace.

So what I was thinking is that we have the user namespace directories
and that the mount code would perform a bind mount such that the
directory that matches the mounters user namespace is the root
directory.

> Let me throw in a crazy idea: couldn't we just make the ioctl_ns() walk
> a namespace hierarchy? For example, you could pass in a user namespace
> fd and then you'd get back a struct with handles for fds for the
> namespaces owned by that user namespace and then you could use
> NS_GET_USERNS/NS_GET_PARENT to walk upwards from the user namespace fd
> passed in initially and so on? Or something similar/simpler. This would
> also decouple this from procfs somewhat.

Hmm.

That would remove the need to have names.  We could just keep a list
of the namespaces in creation order.  Hopefully the CRIU folks could
preserve that create order without too much trouble.

Say with an ioctl NS_NEXT_CREATION which takes two fds, and returns
a new file descriptor.  The arguments would be the user namespace
and -1 or the file descriptor last returned fro NS_NEXT_CREATION.


Assuming that is not difficult for CRIU to restore that would be a very
simple patch.

Eric

