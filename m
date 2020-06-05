Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2351EF053
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 06:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgFEEVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 00:21:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51542 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgFEEVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:21:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jh3rQ-0008Og-16; Thu, 04 Jun 2020 22:21:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jh3rO-0000N9-Em; Thu, 04 Jun 2020 22:21:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
        <87ftbah8q2.fsf@x220.int.ebiederm.org>
        <20200605000838.huaeqvgpvqkyg3wh@comp-core-i7-2640m-0182e6>
Date:   Thu, 04 Jun 2020 23:17:38 -0500
In-Reply-To: <20200605000838.huaeqvgpvqkyg3wh@comp-core-i7-2640m-0182e6>
        (Alexey Gladkov's message of "Fri, 5 Jun 2020 02:08:38 +0200")
Message-ID: <87zh9idu3h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jh3rO-0000N9-Em;;;mid=<87zh9idu3h.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7Jf9GLHKnziYGhzfXd2JkxjWEWXRDCRc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3013]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 653 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 11 (1.6%), parse: 1.50
        (0.2%), extract_message_metadata: 21 (3.1%), get_uri_detail_list: 5
        (0.8%), tests_pri_-1000: 5 (0.8%), tests_pri_-950: 1.67 (0.3%),
        tests_pri_-900: 1.21 (0.2%), tests_pri_-90: 83 (12.7%), check_bayes:
        81 (12.5%), b_tokenize: 19 (2.8%), b_tok_get_all: 14 (2.1%),
        b_comp_prob: 4.9 (0.8%), b_tok_touch_all: 39 (6.0%), b_finish: 1.29
        (0.2%), tests_pri_0: 501 (76.8%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.73 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 12 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level procfs entries
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Thu, Jun 04, 2020 at 03:33:25PM -0500, Eric W. Biederman wrote:
>> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>> 
>> > Greetings!
>> >
>> > Preface
>> > -------
>> > This patch set can be applied over:
>> >
>> > git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git d35bec8a5788
>> 
>> I am not going to seriously look at this for merging until after the
>> merge window closes. 
>
> OK. I'll wait.

That will mean your patches can be based on -rc1.

>> Have you thought about the possibility of relaxing the permission checks
>> to mount proc such that we don't need to verify there is an existing
>> mount of proc?  With just the subset pids I think this is feasible.  It
>> might not be worth it at this point, but it is definitely worth asking
>> the question.  As one of the benefits early propopents of the idea of a
>> subset of proc touted was that they would not be as restricted as they
>> are with today's proc.
>
> I'm not sure I follow.
>
> What do you mean by the possibility of relaxing the permission checks to
> mount proc?
>
> Do you suggest to allow a user to mount procfs with hidepid=2,subset=pid
> options? If so then this is an interesting idea.

The key part would be subset=pid.  You would still need to be root in
your user namespace, and mount namespace.  You would not need to have a
separate copy of proc with nothing hidden already mounted.

>> I ask because this has a bearing on the other options you are playing
>> with.
>
> I can not agree with this because I do not touch on other options.
> The hidepid and subset=pid has no relation to the visibility of regular
> files. On the other hand, in procfs there is absolutely no way to restrict
> access other than selinux.

Untrue.  At a practical level the user namespace greatly restricts
access to proc because many of the non-process files are limited to
global root only.

>> Do we want to find a way to have the benefit of relaxed permission
>> checks while still including a few more files.
>
> In fact, I see no problem allowing the user to mount procfs with the
> hidepid=2,subset=pid options.
>
> We can make subset=self, which would allow not only pids subset but also
> other symlinks that lead to self (/proc/net, /proc/mounts) and if we ever
> add virtualization to meminfo, cpuinfo etc.
>
>> > Overview
>> > --------
>> > Directories and files can be created and deleted by dynamically loaded modules.
>> > Not all of these files are virtualized and safe inside the container.
>> >
>> > However, subset=pid is not enough because many containers wants to have
>> > /proc/meminfo, /proc/cpuinfo, etc. We need a way to limit the visibility of
>> > files per procfs mountpoint.
>> 
>> Is it desirable to have meminfo and cpuinfo as they are today or do
>> people want them to reflect the ``container'' context.   So that
>> applications like the JVM don't allocation too many cpus or don't try
>> and consume too much memory, or run on nodes that cgroups current make
>> unavailable.
>
> Of course, it would be better if these files took into account the
> limitations of cgroups or some kind of ``containerized'' context.
>
>> Are there any users or planned users of this functionality yet?
>
> I know that java uses meminfo for sure.
>
> The purpose of this patch is to isolate the container from unwanted files
> in procfs.

If what we want is the ability not to use the original but to have
a modified version of these files.  We probably want empty files that
serve as mount points.

Or possibly a version of these files that takes into account
restrictions.  In either even we need to do the research through real
programs and real kernel options to see what is our best option for
exporting the limitations that programs have and deciding on the long
term API for that.

If we research things and we decide the best way to let java know of
it's limitations is to change /proc/meminfo.  That needs to be a change
that always applies to meminfo and is not controlled by options.

>> I am concerned that you might be adding functionality that no one will
>> ever use that will just add code to the kernel that no one cares about,
>> that will then accumulate bugs.  Having had to work through a few of
>> those cases to make each mount of proc have it's own super block I am
>> not a great fan of adding another one.
>>
>> If the runc, lxc and other container runtime folks can productively use
>> such and option to do useful things and they are sensible things to do I
>> don't have any fundamental objection.  But I do want to be certain this
>> is a feature that is going to be used.
>
> Ok, just an example how docker or runc (actually almost all golang-based
> container systems) is trying to block access to something in procfs:
>
> $ docker run -it --rm busybox
> # mount |grep /proc
> proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
> proc on /proc/bus type proc (ro,relatime)
> proc on /proc/fs type proc (ro,relatime)
> proc on /proc/irq type proc (ro,relatime)
> proc on /proc/sys type proc (ro,relatime)
> proc on /proc/sysrq-trigger type proc (ro,relatime)
> tmpfs on /proc/asound type tmpfs (ro,seclabel,relatime)
> tmpfs on /proc/acpi type tmpfs (ro,seclabel,relatime)
> tmpfs on /proc/kcore type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
> tmpfs on /proc/keys type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
> tmpfs on /proc/latency_stats type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
> tmpfs on /proc/timer_list type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
> tmpfs on /proc/sched_debug type tmpfs (rw,seclabel,nosuid,size=65536k,mode=755)
> tmpfs on /proc/scsi type tmpfs (ro,seclabel,relatime)
>
> For now I'm just trying ti create a better way to restrict access in
> the procfs than this since procfs is used in containers.

Docker historically has been crap about having a sensible policy.  The
problem is that Docker wanted to allow real root in a container and
somehow make it safe by blocking access to proc files and by dropping
capabilities.

Practically everything that Docker has done is much better and simpler by
restricting the processes to a user namespace, with a root user whose
uid is not the global root user.

Which is why I want us to make certain we are doing something that makes
sense, and is architecturally sound.

You have cleared the big hurdle and proc now has options that are
usable.   I really appreciate that.  I am not opposed to the general
direction you are going to find a way to make proc more usable.  I just
want our next step to be solid.

Eric
