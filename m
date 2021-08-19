Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9FE3F0F5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhHSAXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhHSAXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:23:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9905FC06179A;
        Wed, 18 Aug 2021 17:22:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e15so2891454plh.8;
        Wed, 18 Aug 2021 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=srgQrtHR6Q3yNNiUf/2UYIBAbFoMkt4HQER7V5Q0Jvk=;
        b=i1heXBhCScGiqthuZUfuNdUuydrLc3JS+9rRLrC+lFYPi7ysv9yN61mw7hYmjg0fio
         wMrmDXQWw8taDtMPCHwOHFxRNAJOdas630KSHwI5NAR5RUd6JJYVIz5rvZqUnDuEEvLF
         rp/bs+ULl7Go02jYllRF/AsneIkIbLCfHpcT/3CdDfKZuq1cqb7sZf5GKRsB2RB5m2LP
         6oJIoWON3RDAW+cLeJYJZRD1jOlIySoXh/3lMGsGN4z05SqC13OJl3B6maNWb/yrajaU
         c3f+kwcStTvyvI1m5S6gHhhThXiPeTYlep3G5tnlmhabQO4d5TjN8SBAonDnJmWar02h
         uiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=srgQrtHR6Q3yNNiUf/2UYIBAbFoMkt4HQER7V5Q0Jvk=;
        b=fQ01VyCcvnA40hfW+9Xwpulv99ykTcg89Yt2YL6C0cK7Vo5YbbqojOBP1DgQF7Qk7V
         PSBZvvpHgO1kd/+ENHH4P6vcX3U+ugsBy/GE/TSNLwqrf5bb9FYlveto05HaDCE2i6ed
         PCBNrRbpEMzSiCUUEEtLn1jDgDRCHtc06GKbIARRFtcEXIObthczmEWoxPas8kY0A0An
         nXXYSdKgoF5DXF3boqAyV8fGUEeeN2IZ2s/WU+Mcmy+QfGccAva4SeEaeUCd2NxrCNQZ
         QDTL+GiB3iN6RDp1KjlhRLpANceKgnpw6NevDL7YPsf789D0gfbPItFWBq3eUmCp/3p+
         +kjg==
X-Gm-Message-State: AOAM532XE7B/xSbrUIzDYgcpssrrAJhdPp+2HAVBiP6TGg4uTUlJMNyN
        CHt/xJsMrlDYG7MrWbPOOUY=
X-Google-Smtp-Source: ABdhPJwbv+titpLTPGsMS3VWTPyw9SMBEsOSM1KGXn0PWgrd1FfnbG5EsxA65BRmdC+LSiH/7fEG9g==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr11778939pjb.152.1629332564125;
        Wed, 18 Aug 2021 17:22:44 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id j12sm942551pfj.54.2021.08.18.17.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 17:22:43 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCHi, man-pages] mount_namespaces.7: More clearly explain
 "locked mounts"
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20210813220120.502058-1-mtk.manpages@gmail.com>
 <87r1et1io8.fsf@disp2133> <56bbb8ed-8ecf-a0be-5253-350727ae1d24@gmail.com>
 <874kboysqq.fsf@disp2133>
Message-ID: <8efe7646-f066-443f-05dc-fbaa3907460d@gmail.com>
Date:   Thu, 19 Aug 2021 02:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <874kboysqq.fsf@disp2133>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Eric,

Thank you for you response.

On 8/17/21 5:51 PM, Eric W. Biederman wrote:
> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
> 
>> Hi Eric,
>>
>> Thanks for your feedback!
>>
>> On 8/16/21 6:03 PM, Eric W. Biederman wrote:
>>> Michael Kerrisk <mtk.manpages@gmail.com> writes:
>>>
>>>> For a long time, this manual page has had a brief discussion of
>>>> "locked" mounts, without clearly saying what this concept is, or
>>>> why it exists. Expand the discussion with an explanation of what
>>>> locked mounts are, why mounts are locked, and some examples of the
>>>> effect of locking.
>>>>
>>>> Thanks to Christian Brauner for a lot of help in understanding
>>>> these details.
>>>>
>>>> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
>>>> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
>>>> ---
>>>>
>>>> Hello Eric and others,
>>>>
>>>> After some quite helpful info from Chrstian Brauner, I've expanded
>>>> the discussion of locked mounts (a concept I didn't really have a
>>>> good grasp on) in the mount_namespaces(7) manual page. I would be
>>>> grateful to receive review comments, acks, etc., on the patch below.
>>>> Could you take a look please?
>>>>
>>>> Cheers,
>>>>
>>>> Michael
>>>>
>>>>  man7/mount_namespaces.7 | 73 +++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 73 insertions(+)
>>>>
>>>> diff --git a/man7/mount_namespaces.7 b/man7/mount_namespaces.7
>>>> index e3468bdb7..97427c9ea 100644
>>>> --- a/man7/mount_namespaces.7
>>>> +++ b/man7/mount_namespaces.7
>>>> @@ -107,6 +107,62 @@ operation brings across all of the mounts from the original
>>>>  mount namespace as a single unit,
>>>>  and recursive mounts that propagate between
>>>>  mount namespaces propagate as a single unit.)
>>>> +.IP
>>>> +In this context, "may not be separated" means that the mounts
>>>> +are locked so that they may not be individually unmounted.
>>>> +Consider the following example:
>>>> +.IP
>>>> +.RS
>>>> +.in +4n
>>>> +.EX
>>>> +$ \fBsudo mkdir /mnt/dir\fP
>>>> +$ \fBsudo sh \-c \(aqecho "aaaaaa" > /mnt/dir/a\(aq\fP
>>>> +$ \fBsudo mount \-\-bind -o ro /some/path /mnt/dir\fP
>>>> +$ \fBls /mnt/dir\fP   # Former contents of directory are invisible
>>>
>>> Do we want a more motivating example such as a /proc/sys?
>>>
>>> It has been common to mount over /proc files and directories that can be
>>> written to by the global root so that users in a mount namespace may not
>>> touch them.
>>
>> Seems reasonable. But I want to check one thing. Can you please
>> define "global root". I'm pretty sure I know what you mean, but
>> I'd like to know your definition.
> 
> I mean uid 0 in the initial user namespace.

(Good. That's what I thought you meant. So far, that term is not 
described in the manual pages. I just now added a definition of the 
term to user_namespaces(7).)

> This uid owns most of files in /proc.
> 
> Container systems that don't want to use user namespaces frequently
> mount over files in proc to prevent using some of the root privileges
> that come simply by having uid 0.
> 
> Another use is mounting over files on virtual filesystems like proc
> to reduce the attack surface.

Thanks for the background. I think for the moment I will go with 
Christian's alternative suggestion (an example using /etc/shadow).

> For reducing what the root user in a container can do, I think using user
> namespaces and using a uid other than 0 in the initial user namespace.
> 
> 
>>>> +.EE
>>>> +.in
>>>> +.RE
>>>> +.IP
>>>> +The above steps, performed in a more privileged user namespace,
>>>> +have created a (read-only) bind mount that
>>>> +obscures the contents of the directory
>>>> +.IR /mnt/dir .
>>>> +For security reasons, it should not be possible to unmount
>>>> +that mount in a less privileged user namespace,
>>>> +since that would reveal the contents of the directory
>>>> +.IR /mnt/dir .
>>>  > +.IP
>>>> +Suppose we now create a new mount namespace
>>>> +owned by a (new) subordinate user namespace.
>>>> +The new mount namespace will inherit copies of all of the mounts
>>>> +from the previous mount namespace.
>>>> +However, those mounts will be locked because the new mount namespace
>>>> +is owned by a less privileged user namespace.
>>>> +Consequently, an attempt to unmount the mount fails:
>>>> +.IP
>>>> +.RS
>>>> +.in +4n
>>>> +.EX
>>>> +$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
>>>> +               \fBstrace \-o /tmp/log \e\fP
>>>> +               \fBumount /mnt/dir\fP
>>>> +umount: /mnt/dir: not mounted.
>>>> +$ \fBgrep \(aq^umount\(aq /tmp/log\fP
>>>> +umount2("/mnt/dir", 0)     = \-1 EINVAL (Invalid argument)
>>>> +.EE
>>>> +.in
>>>> +.RE
>>>> +.IP
>>>> +The error message from
>>>> +.BR mount (8)
>>>> +is a little confusing, but the
>>>> +.BR strace (1)
>>>> +output reveals that the underlying
>>>> +.BR umount2 (2)
>>>> +system call failed with the error
>>>> +.BR EINVAL ,
>>>> +which is the error that the kernel returns to indicate that
>>>> +the mount is locked.
>>>
>>> Do you want to mention that you can unmount the entire subtree?  Either
>>> with pivot_root if it is locked to "/" or with
>>> "umount -l /path/to/propagated/directory".
>>
>> Yes, I wondered about that, but hadn't got round to devising 
>> the scenario. How about this:
>>
>> [[
>>        *  Following on from the previous point, note that it is possible
>>           to unmount an entire tree of mounts that propagated as a unit
>                                  ^^^^^ subtree?

Yes, probably better, to prevent misunderstandings. Changed (and in a few
other places also).

>>           into a mount namespace that is owned by a less privileged user
>>           namespace, as illustrated in the following example.
> 
>>
>>           First, we create new user and mount namespaces using
>>           unshare(1).  In the new mount namespace, the propagation type
>>           of all mounts is set to private.  We then create a shared bind
>>           mount at /mnt, and a small hierarchy of mount points underneath
>>           that mount point.
>>
>>               $ PS1='ns1# ' sudo unshare --user --map-root-user \
>>                                      --mount --propagation private bash
>>               ns1# echo $$        # We need the PID of this shell later
>>               778501
>>               ns1# mount --make-shared --bind /mnt /mnt
>>               ns1# mkdir /mnt/x
>>               ns1# mount --make-private -t tmpfs none /mnt/x
>>               ns1# mkdir /mnt/x/y
>>               ns1# mount --make-private -t tmpfs none /mnt/x/y
>>               ns1# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>>               986 83 8:5 /mnt /mnt rw,relatime shared:344
>>               989 986 0:56 / /mnt/x rw,relatime
>>               990 989 0:57 / /mnt/x/y rw,relatime
>>
>>           Continuing in the same shell session, we then create a second
>>           shell in a new mount namespace and a new subordinate (and thus
>>           less privileged) user namespace and check the state of the
>>           propagated mount points rooted at /mnt.
>>
>>               ns1# PS1='ns2# unshare --user --map-root-user \
>>                                      --mount --propagation unchanged bash
>>               ns2# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>>               1239 1204 8:5 /mnt /mnt rw,relatime master:344
>>               1240 1239 0:56 / /mnt/x rw,relatime
>>               1241 1240 0:57 / /mnt/x/y rw,relatime
>>
>>           Of note in the above output is that the propagation type of the
>>           mount point /mnt has been reduced to slave, as explained near
>>           the start of this subsection.  This means that submount events
>>           will propagate from the master /mnt in "ns1", but propagation
>>           will not occur in the opposite direction.
>>
>>           From a separate terminal window, we then use nsenter(1) to
>>           enter the mount and user namespaces corresponding to "ns1".  In
>>           that terminal window, we then recursively bind mount /mnt/x at
>>           the location /mnt/ppp.
>>
>>               $ PS1='ns3# ' sudo nsenter -t 778501 --user --mount
>>               ns3# mount --rbind --make-private /mnt/x /mnt/ppp
>>               ns3# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>>               986 83 8:5 /mnt /mnt rw,relatime shared:344
>>               989 986 0:56 / /mnt/x rw,relatime
>>               990 989 0:57 / /mnt/x/y rw,relatime
>>               1242 986 0:56 / /mnt/ppp rw,relatime
>>               1243 1242 0:57 / /mnt/ppp/y rw,relatime shared:518
>>
>>           Because the propagation type of the parent mount, /mnt, was
>>           shared, the recursive bind mount propagated a small tree of
>>           mounts under the slave mount /mnt into "ns2", as can be
>>           verified by executing the following command in that shell
>>           session:
>>
>>               ns2# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
>>               1239 1204 8:5 /mnt /mnt rw,relatime master:344
>>               1240 1239 0:56 / /mnt/x rw,relatime
>>               1241 1240 0:57 / /mnt/x/y rw,relatime
>>               1244 1239 0:56 / /mnt/ppp rw,relatime
>>               1245 1244 0:57 / /mnt/ppp/y rw,relatime master:518
>>
>>           While it is not possible to unmount a part of that propagated
>>           subtree (/mnt/ppp/y), it is possible to unmount the entire
>>           tree, as shown by the following commands:
>>
>>               ns2# umount /mnt/ppp/y
>>               umount: /mnt/ppp/y: not mounted.
>>               ns2# umount -l /mnt/ppp | sed 's/ - .*//'      # Succeeds...
>>               ns2# grep /mnt /proc/self/mountinfo
>>               1239 1204 8:5 /mnt /mnt rw,relatime master:344
>>               1240 1239 0:56 / /mnt/x rw,relatime
>>               1241 1240 0:57 / /mnt/x/y rw,relatime
>> ]]
>>
>> ?
> 
> Yes.
> 
> It is worth noting that in ns2 it is also possible to mount on top of
> /mnt/ppp/y and umount from /mnt/ppp/y.

Yes, good point. I've added some text, and an example for that case.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
