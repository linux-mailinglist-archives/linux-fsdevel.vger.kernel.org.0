Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB773EEF8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbhHQPxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:18 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59990 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240527AbhHQPwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:52:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:59524)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mG1NH-003R3q-P6; Tue, 17 Aug 2021 09:51:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52008 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mG1NE-008hUZ-Q5; Tue, 17 Aug 2021 09:51:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20210813220120.502058-1-mtk.manpages@gmail.com>
        <87r1et1io8.fsf@disp2133>
        <56bbb8ed-8ecf-a0be-5253-350727ae1d24@gmail.com>
Date:   Tue, 17 Aug 2021 10:51:25 -0500
In-Reply-To: <56bbb8ed-8ecf-a0be-5253-350727ae1d24@gmail.com> (Michael
        Kerrisk's message of "Tue, 17 Aug 2021 05:12:20 +0200")
Message-ID: <874kboysqq.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mG1NE-008hUZ-Q5;;;mid=<874kboysqq.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/L4YPfXsxMKRmNn15JlZe678h6Tkr8jrQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong,XM_B_SpammyTLD
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1923 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (0.5%), b_tie_ro: 9 (0.5%), parse: 2.00 (0.1%),
         extract_message_metadata: 19 (1.0%), get_uri_detail_list: 5 (0.3%),
        tests_pri_-1000: 8 (0.4%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 168 (8.7%), check_bayes:
        157 (8.2%), b_tokenize: 17 (0.9%), b_tok_get_all: 14 (0.7%),
        b_comp_prob: 4.7 (0.2%), b_tok_touch_all: 117 (6.1%), b_finish: 0.92
        (0.0%), tests_pri_0: 1699 (88.3%), check_dkim_signature: 0.67 (0.0%),
        check_dkim_adsp: 3.2 (0.2%), poll_dns_idle: 1.42 (0.1%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 7 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHi, man-pages] mount_namespaces.7: More clearly explain "locked mounts"
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hi Eric,
>
> Thanks for your feedback!
>
> On 8/16/21 6:03 PM, Eric W. Biederman wrote:
>> Michael Kerrisk <mtk.manpages@gmail.com> writes:
>> 
>>> For a long time, this manual page has had a brief discussion of
>>> "locked" mounts, without clearly saying what this concept is, or
>>> why it exists. Expand the discussion with an explanation of what
>>> locked mounts are, why mounts are locked, and some examples of the
>>> effect of locking.
>>>
>>> Thanks to Christian Brauner for a lot of help in understanding
>>> these details.
>>>
>>> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
>>> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
>>> ---
>>>
>>> Hello Eric and others,
>>>
>>> After some quite helpful info from Chrstian Brauner, I've expanded
>>> the discussion of locked mounts (a concept I didn't really have a
>>> good grasp on) in the mount_namespaces(7) manual page. I would be
>>> grateful to receive review comments, acks, etc., on the patch below.
>>> Could you take a look please?
>>>
>>> Cheers,
>>>
>>> Michael
>>>
>>>  man7/mount_namespaces.7 | 73 +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>
>>> diff --git a/man7/mount_namespaces.7 b/man7/mount_namespaces.7
>>> index e3468bdb7..97427c9ea 100644
>>> --- a/man7/mount_namespaces.7
>>> +++ b/man7/mount_namespaces.7
>>> @@ -107,6 +107,62 @@ operation brings across all of the mounts from the original
>>>  mount namespace as a single unit,
>>>  and recursive mounts that propagate between
>>>  mount namespaces propagate as a single unit.)
>>> +.IP
>>> +In this context, "may not be separated" means that the mounts
>>> +are locked so that they may not be individually unmounted.
>>> +Consider the following example:
>>> +.IP
>>> +.RS
>>> +.in +4n
>>> +.EX
>>> +$ \fBsudo mkdir /mnt/dir\fP
>>> +$ \fBsudo sh \-c \(aqecho "aaaaaa" > /mnt/dir/a\(aq\fP
>>> +$ \fBsudo mount \-\-bind -o ro /some/path /mnt/dir\fP
>>> +$ \fBls /mnt/dir\fP   # Former contents of directory are invisible
>> 
>> Do we want a more motivating example such as a /proc/sys?
>> 
>> It has been common to mount over /proc files and directories that can be
>> written to by the global root so that users in a mount namespace may not
>> touch them.
>
> Seems reasonable. But I want to check one thing. Can you please
> define "global root". I'm pretty sure I know what you mean, but
> I'd like to know your definition.

I mean uid 0 in the initial user namespace.
This uid owns most of files in /proc.

Container systems that don't want to use user namespaces frequently
mount over files in proc to prevent using some of the root privileges
that come simply by having uid 0.

Another use is mounting over files on virtual filesystems like proc
to reduce the attack surface.

For reducing what the root user in a container can do, I think using user
namespaces and using a uid other than 0 in the initial user namespace.


>>> +.EE
>>> +.in
>>> +.RE
>>> +.IP
>>> +The above steps, performed in a more privileged user namespace,
>>> +have created a (read-only) bind mount that
>>> +obscures the contents of the directory
>>> +.IR /mnt/dir .
>>> +For security reasons, it should not be possible to unmount
>>> +that mount in a less privileged user namespace,
>>> +since that would reveal the contents of the directory
>>> +.IR /mnt/dir .
>>  > +.IP
>>> +Suppose we now create a new mount namespace
>>> +owned by a (new) subordinate user namespace.
>>> +The new mount namespace will inherit copies of all of the mounts
>>> +from the previous mount namespace.
>>> +However, those mounts will be locked because the new mount namespace
>>> +is owned by a less privileged user namespace.
>>> +Consequently, an attempt to unmount the mount fails:
>>> +.IP
>>> +.RS
>>> +.in +4n
>>> +.EX
>>> +$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
>>> +               \fBstrace \-o /tmp/log \e\fP
>>> +               \fBumount /mnt/dir\fP
>>> +umount: /mnt/dir: not mounted.
>>> +$ \fBgrep \(aq^umount\(aq /tmp/log\fP
>>> +umount2("/mnt/dir", 0)     = \-1 EINVAL (Invalid argument)
>>> +.EE
>>> +.in
>>> +.RE
>>> +.IP
>>> +The error message from
>>> +.BR mount (8)
>>> +is a little confusing, but the
>>> +.BR strace (1)
>>> +output reveals that the underlying
>>> +.BR umount2 (2)
>>> +system call failed with the error
>>> +.BR EINVAL ,
>>> +which is the error that the kernel returns to indicate that
>>> +the mount is locked.
>> 
>> Do you want to mention that you can unmount the entire subtree?  Either
>> with pivot_root if it is locked to "/" or with
>> "umount -l /path/to/propagated/directory".
>
> Yes, I wondered about that, but hadn't got round to devising 
> the scenario. How about this:
>
> [[
>        *  Following on from the previous point, note that it is possible
>           to unmount an entire tree of mounts that propagated as a unit
                                 ^^^^^ subtree?
>           into a mount namespace that is owned by a less privileged user
>           namespace, as illustrated in the following example.

>
>           First, we create new user and mount namespaces using
>           unshare(1).  In the new mount namespace, the propagation type
>           of all mounts is set to private.  We then create a shared bind
>           mount at /mnt, and a small hierarchy of mount points underneath
>           that mount point.
>
>               $ PS1='ns1# ' sudo unshare --user --map-root-user \
>                                      --mount --propagation private bash
>               ns1# echo $$        # We need the PID of this shell later
>               778501
>               ns1# mount --make-shared --bind /mnt /mnt
>               ns1# mkdir /mnt/x
>               ns1# mount --make-private -t tmpfs none /mnt/x
>               ns1# mkdir /mnt/x/y
>               ns1# mount --make-private -t tmpfs none /mnt/x/y
>               ns1# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>               986 83 8:5 /mnt /mnt rw,relatime shared:344
>               989 986 0:56 / /mnt/x rw,relatime
>               990 989 0:57 / /mnt/x/y rw,relatime
>
>           Continuing in the same shell session, we then create a second
>           shell in a new mount namespace and a new subordinate (and thus
>           less privileged) user namespace and check the state of the
>           propagated mount points rooted at /mnt.
>
>               ns1# PS1='ns2# unshare --user --map-root-user \
>                                      --mount --propagation unchanged bash
>               ns2# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>               1239 1204 8:5 /mnt /mnt rw,relatime master:344
>               1240 1239 0:56 / /mnt/x rw,relatime
>               1241 1240 0:57 / /mnt/x/y rw,relatime
>
>           Of note in the above output is that the propagation type of the
>           mount point /mnt has been reduced to slave, as explained near
>           the start of this subsection.  This means that submount events
>           will propagate from the master /mnt in "ns1", but propagation
>           will not occur in the opposite direction.
>
>           From a separate terminal window, we then use nsenter(1) to
>           enter the mount and user namespaces corresponding to "ns1".  In
>           that terminal window, we then recursively bind mount /mnt/x at
>           the location /mnt/ppp.
>
>               $ PS1='ns3# ' sudo nsenter -t 778501 --user --mount
>               ns3# mount --rbind --make-private /mnt/x /mnt/ppp
>               ns3# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>               986 83 8:5 /mnt /mnt rw,relatime shared:344
>               989 986 0:56 / /mnt/x rw,relatime
>               990 989 0:57 / /mnt/x/y rw,relatime
>               1242 986 0:56 / /mnt/ppp rw,relatime
>               1243 1242 0:57 / /mnt/ppp/y rw,relatime shared:518
>
>           Because the propagation type of the parent mount, /mnt, was
>           shared, the recursive bind mount propagated a small tree of
>           mounts under the slave mount /mnt into "ns2", as can be
>           verified by executing the following command in that shell
>           session:
>
>               ns2# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>               1239 1204 8:5 /mnt /mnt rw,relatime master:344
>               1240 1239 0:56 / /mnt/x rw,relatime
>               1241 1240 0:57 / /mnt/x/y rw,relatime
>               1244 1239 0:56 / /mnt/ppp rw,relatime
>               1245 1244 0:57 / /mnt/ppp/y rw,relatime master:518
>
>           While it is not possible to unmount a part of that propagated
>           subtree (/mnt/ppp/y), it is possible to unmount the entire
>           tree, as shown by the following commands:
>
>               ns2# umount /mnt/ppp/y
>               umount: /mnt/ppp/y: not mounted.
>               ns2# umount -l /mnt/ppp | sed 's/ - .*//'      # Succeeds...
>               ns2# grep /mnt /proc/self/mountinfo
>               1239 1204 8:5 /mnt /mnt rw,relatime master:344
>               1240 1239 0:56 / /mnt/x rw,relatime
>               1241 1240 0:57 / /mnt/x/y rw,relatime
> ]]
>
> ?

Yes.

It is worth noting that in ns2 it is also possible to mount on top of
/mnt/ppp/y and umount from /mnt/ppp/y.


Eric
