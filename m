Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8D3F0F62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHSAZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhHSAZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:25:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C22C0613D9;
        Wed, 18 Aug 2021 17:24:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so3777777pjv.3;
        Wed, 18 Aug 2021 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9Ya7+WbjLi7OVwTnSEdB2pipd5tTpPIQIluWWZlyyI=;
        b=ab/CZiNk7D7jnpvasA1Smvs5eO9s/K3WE/Zeu9kkPHkhCnb3A7LbipBBcvRBgk+68d
         VLJTRK+YLeEnwO+dD78CFOlz9OVgsjr/CtO6uHEu0T6SD24p8BmqV350AdkJkx3346rK
         a54YiXOh5exwNh8ZDWIHg3GEyaXRPCJCfrus4/TDTpvBcaTjl0ua/K6o2dAj9ocBtvZS
         nilu6IbCLhhWoX73jczPaXpTjeVU5weGlkxHWBFWnmt3zNyuRrHE1u+y2lcOAcf5wJpI
         1ZVerfwuce74yem9Fe+er+zD8J21iM6zxF7xK8GAQx7ENU/cDEIR01QtRFKGrnphmvX9
         3SkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9Ya7+WbjLi7OVwTnSEdB2pipd5tTpPIQIluWWZlyyI=;
        b=cbR+zHcN6T0RsxTvbjlNK8M4PCvrVptG+/jZBK2jXaqEDx/f8L+VnnWFrg/S9dCg39
         6DUiBKn34mDKRS1y+niXJ7bdKqUmRAQ9mYvlWDWVRokfMW5lMgK8chCmkdvzSNsLB7AA
         9qkJBiFwD0z3XHGx2AOarR1VDLkUY9JKNUlMeKgFuyyKOBZ99PCCq49ENjRlGuGE2jHf
         ++GZbkKgTaZ3upjuGUEZSfpjwLisX3avP2lJe0GgOuQj1kIQU1pS772HJZF1yUSOFwBO
         3wfT3Embd+aaCq4g7oP78h3tgxhM1gImZtLJqR6Uvo9qEcDsec/4+kw3PNAFjXBmYy58
         aNCA==
X-Gm-Message-State: AOAM530JJNoy+nVyM/Qi900eMwqQYssKIvdZGQLRNPlOKDaF3RSVbCB0
        pUlBXnI5aWdc6nayhL0GPGE=
X-Google-Smtp-Source: ABdhPJzqANq9HcLHPxBLnoLFpaD8lpfP+HawPp+XLF1jVqsdStgNHxpTO2LaN1eFxeVSBz7ggr0pvQ==
X-Received: by 2002:a17:902:9889:b0:12c:fd88:530b with SMTP id s9-20020a170902988900b0012cfd88530bmr9176684plp.33.1629332674693;
        Wed, 18 Aug 2021 17:24:34 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id b17sm611257pjo.39.2021.08.18.17.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 17:24:34 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCHi, man-pages] mount_namespaces.7: More clearly explain
 "locked mounts"
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     mtk.manpages@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20210813220120.502058-1-mtk.manpages@gmail.com>
 <87r1et1io8.fsf@disp2133> <56bbb8ed-8ecf-a0be-5253-350727ae1d24@gmail.com>
 <20210817140649.7pmz5qcelgjzgxtz@wittgenstein>
Message-ID: <1600c787-f9f6-7f44-ed5b-dc6625963e17@gmail.com>
Date:   Thu, 19 Aug 2021 02:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817140649.7pmz5qcelgjzgxtz@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On 8/17/21 4:06 PM, Christian Brauner wrote:
> On Tue, Aug 17, 2021 at 05:12:20AM +0200, Michael Kerrisk (man-pages) wrote:
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
> 
> Could be even be better to use an example involving /etc/shadow, e.g.:
> 
> sudo mount --bind /etc /mnt
> sudo mount --bind /dev/null /mnt/shadow

Nice! I've rewritten the example to use /etc/shadow
instead of a bind-mounted directory at /mnt/dir.
Thanks!

> the procfs example might be a bit awkward (see below).

Okay.

>>> It has been common to mount over /proc files and directories that can be
>>> written to by the global root so that users in a mount namespace may not
>>> touch them.
>>
>> Seems reasonable. But I want to check one thing. Can you please
>> define "global root". I'm pretty sure I know what you mean, but
>> I'd like to know your definition.
> 
> (global root == root in the initial user namespace.)

(As noted in the mail to Eric, I've added this definition to
user_namespaces(7).)

> Some application container runtimes have a concept of "masked paths"
> where they overmount certain directories they want to hide with an empty
> tmpfs and some files they want to hide with /dev/null (see [1]).
> 
> But I don't think this is a great example because this overmounting is
> mostly needed and done when you're running privileged containers (see [2]).
> 
> There's usually no point in overmounting parts of procfs that are
> writable by global root. If you're running in an unprivileged container
> userns root can't write to any of the files that only global root can.
> Otherwise this would be a rather severe security issue.
> 
> There might be a use-case for overmounting files that contain global
> information that are readable inside user namespaces but then one either
> has to question why they are readable in the first place or why this
> information needs to be hidden. Examples include /proc/kallsyms and
> /proc/keys.
> 
> But overall the overmounting of procfs is most sensible when running
> privileged containers or when sharing pid namespaces and procfs is
> somehow bind-mounted from somewhere. But that means there's no user
> namespace in play which means that the mounts aren't locked.
> 
> So if the container runtime has e.g. overmounted /proc/kcore with
> /dev/null then the privileged container can unmount it. To protect
> against this such privileged containers usually drop CAP_SYS_ADMIN.
> So the protection here comes from dropping capabilities not from locking
> mounts together. All of this makes this a bit of a confusing example.
> 
> An example where locked mount protection is relied on heavily which I'm
> involved in is systemd(-nspawn). All custom mounts a container gets such
> as data shared from the host with the container are mounted in a separate
> (privileged) mount namespace before the container workload is cloned.
> The cloned container then gets a new mount + userns pair and hence, all
> the mounts it inherited are now locked.
> 
> This way, you can e.g. share /etc with your container and just overmount
> /etc/shadow with /dev/null or a custom /etc/shadow (Reason for my
> example above.) without dropping capabilities that would prevent the
> container from mounting.
> 
> So I'd suggest using a simple example. This is not about illustrating
> what container runtimes do but what the behavior of a mount namespace
> is. There's really no need to overcomplicate this.

Thanks for the detailed explanation. As noted above, I've rewritten
the example to use /etc/shadow.

> [1]: https://github.com/moby/moby/blob/51b06c6795160d8a1ba05d05d6491df7588b2957/oci/defaults.go#L90
> [2]: https://github.com/moby/moby/blob/51b06c6795160d8a1ba05d05d6491df7588b2957/oci/defaults.go#L110
> 
>>
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
>>           into a mount namespace that is owned by a less privileged user
>>           namespace, as illustrated in the following example.
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
> I'd just add a note about mounts that propagated locked together as unit
> as being unmountable as a unit (which is intuitive but may need to be
> spelled out). But I'd leave this lenghty example as it makes the
> manpage pretty convoluted.

Christian, I do sympathize with this point of view, and I hesitated
about adding this much text to the page. But, on the other hand:

* Many of the pages in section 7 are intended to provide "the big
  picture" of how things work.
* Mount namespaces are complex and (I think) generally poorly
  understood. So let's help people as much as we can.
* I had already relocated this whole subsection to the end of
  the page, so it is less obtrusive.

In summary, I'm inclined to keep the text, but thank you for
voicing your (mild) objection.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
