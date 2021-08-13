Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF233EAE1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 03:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhHMBZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhHMBZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:25:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB295C061756;
        Thu, 12 Aug 2021 18:25:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so13703371pjb.0;
        Thu, 12 Aug 2021 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ytp7j4tvDqB8JRsA43hK2XfyaSDtDGizfAgSYtOwnqQ=;
        b=dcyNcuPYwGn99N/iOhVwFBCjxqRDa168WIlpvwIMgqjRyrh0JSG7GkyQ+3uJnZC244
         Lzr22wtWMkN6Lr4IB2FQ820WE3i+9wmb4oRs6NBoK1NaNqqamWd1Syj4w4825YxSAnGa
         CdNwDo1P+HbAcE/PPOeNMYmtS+NDfCT6shjs3DlkFfYSv+Qd74BbblMmEfJMiw2BS91M
         nWKKdB+jc/efJRmDcryV6CnwsmubvMd2Ppho3A90Mwn3wEuy3W6bTTzZEHVOIzCEYGOE
         LqoShVc6KPUABLuthriGq7eRHXr2V9t0cA1E0aqXoXxqKDkmg1hwhyIZLc+QPD6YDVft
         xz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ytp7j4tvDqB8JRsA43hK2XfyaSDtDGizfAgSYtOwnqQ=;
        b=JDJUY/LwreqCEBH8TZrrR8DFfmDta218QM6Bg9bKoSZAg3XoD9KfLo6FxXAjjji1vJ
         7vmRfdCt1Z5O18DktJ0CExnkO9lbHUBT4UUieduASe9Val5ZFk/2/9UlQyDgW1/3PdUH
         HT3yeZPOhiuY0Mn7AIVzglrXYC8yRFasGpf5CijnTWfi2eST/ClAU5ACVUjKerecaoHR
         CL1CzcSz1NSLxVFYHCRBlKvcRje+wbPK8Kb0yYEloLljuGpDwelrEYXdtQ/xEfek3FV/
         d5CEuKRHZw65EffZEmfXtlHo5eJVN2RCq6AB8D8XCeointCB4L+H2bETF1gOzYAl2Bok
         5wlg==
X-Gm-Message-State: AOAM533vu7N/XG3U1iGuzBEy6tmZBptFNWLsmqaOM7aUFu3hkUvBbMO2
        c+/BK5hP4lfasxHBqXZ946Q=
X-Google-Smtp-Source: ABdhPJxnbn9PZ8ieYqblXX18DNWm5ZoR51uNZ62h39Iu+dJQQsLFUyRkQvfBTamHdjUo//Yo6+ZuPw==
X-Received: by 2002:a63:464b:: with SMTP id v11mr6418350pgk.26.1628817907434;
        Thu, 12 Aug 2021 18:25:07 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id u13sm4135pfn.94.2021.08.12.18.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 18:25:06 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Questions re the new mount_setattr(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <d5a8061a-3d8a-6353-5158-8feee0156c6b@gmail.com>
 <20210811104030.in6f25hw5h5cotti@wittgenstein>
 <2f640877-dd82-6827-dfd0-c7f8fd5acbbc@gmail.com>
 <20210812083826.bfuqiwjlshjdwdby@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <a58d8751-8a9e-5543-fafc-227d3873a31e@gmail.com>
Date:   Fri, 13 Aug 2021 03:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812083826.bfuqiwjlshjdwdby@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christian,

On 8/12/21 10:38 AM, Christian Brauner wrote:
> On Thu, Aug 12, 2021 at 07:36:54AM +0200, Michael Kerrisk (man-pages) wrote:
>> [CC += Eric, in case he has a comment on the last piece]

[...]

>>> That's really splitting hairs.
>>
>> To be clear, I'm not trying to split hairs :-). It's just that
>> I'm struggling a little to understand. (In particular, the notion
>> of locked mounts is one where my understanding is weak.) 
>>
>> And think of it like this: I am the first line of defense for the
>> user-space reader. If I am having trouble to understand the text,
>> I wont be alone. And often, the problem is not so much that the
>> text is "wrong", it's that there's a difference in background
>> knowledge between what you know and what the reader (in this case
>> me) knows. Part of my task is to fill that gap, by adding info
>> that I think is necessary to the page (with the happy side
>> effect that I learn along the way.)
> 
> All very good points.
> I didn't mean to complain btw. Sorry that it seemed that way. :)

No problem. I need to think more carefully about my words 
sometimes in mails too :-)

>>> Of course this means that we're
>>> propagating into a mount namespace that is owned by a different user
>>> namespace though "crossing user namespaces" might have been the better
>>> choice.
>>
>> This is a perfect example of the point I make above. You say "of course",
>> but I don't have the background knowledge that you do :-). From my
>> perspective, I want to make sure that I understand your meaning, so
>> that that meaning can (IMHO) be made easier for the average reader
>> of the manual page.
>>
>>>>                  the aforementioned  flags  to  protect  these  sensitive
>>>>                  properties from being altered.
>>>>
>>>>               •  A  new  mount  and user namespace pair is created.  This
>>>>                  happens for  example  when  specifying  CLONE_NEWUSER  |
>>>>                  CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).  The
>>>>                  aforementioned flags become locked to protect user name‐
>>>>                  spaces from altering sensitive mount properties.
>>>>
>>>> Again, this seems imprecise. Should it say something like:
>>>> "... to prevent changes to sensitive mount properties in the new 
>>>> mount namespace" ? Or perhaps you have a better wording.
>>>
>>> That's not imprecise. 
>>
>> Okay -- poor choice of wording on my part:
>>
>> s/this seems imprecise/I'm having trouble understanding this/
>>
>>> What you want to protect against is altering
>>> sensitive mount properties from within a user namespace irrespective of
>>> whether or not the user namespace actually owns the mount namespace,
>>> i.e. even if you own the mount namespace you shouldn't be able to alter
>>> those properties. I concede though that "protect" should've been
>>> "prevent".
>>
>> Can I check my education here please. The point is this:
>>
>> * The mount point was created in a mount NS that was owned by
>>   a more privileged user NS (e.g., the initial user NS).
>> * A CLONE_NEWUSER|CLONE_NEWNS step occurs to create a new (user and) 
>>   mount NS.
>> * In the new mount NS, the mounts become locked.
>>
>> And, help me here: is it correct that the reason the properties
>> need to be locked is because they are shared between the mounts?
> 
> Yes, basically.

Yes, but that last sentence of mine was wrong, wasn't it? The 
properties are not actually shared between the mounts, right?
(Earlier, I had done in experiment which misled e into thinking
there was sharing, but now it looks to me like there is not.)

> The new mount namespace contains a copy of all the mounts in the
> previous mount namespace. So they are separate mounts which you can best
> see when you do unshare --mount --propagation=private. An unmount in the
> new mount namespace won't affect the mount in the previous mount
> namespace. Which can only nicely work if they are separate mounts.
> Propagation relies (among other things) on the fact that mount
> namespaces have copies of the mounts.
> 
> The copied mounts in the new mount namespace will have inherited all
> properties they had at the time when copy_namespaces() and specifically
> copy_mnt_ns() was called. Which calls into copy_tree() and ultimately
> into the appropriately named clone_mnt(). This is the low-level routine
> that is responsible for cloning the mounts including their mount
> properties.
> 
> Some mount properties such as read-only, nodev, noexec, nosuid, atime -
> while arguably not per se security mechanisms - are used for protection
> or as security measures in userspace applications. The most obvious one
> might be the read-only property. One wouldn't want to expose a set of
> files as read-only only for someone else to trivially gain write access
> to them. An example of where that could happen is when creating a new
> mount namespaces and user namespace pair where the new mount namespace
> is owned by the new user namespace in which the caller is privileged and
> thus the caller would also able to alter the new mount namespace. So
> without locking flags all it would take to turn a read-only into a
> read-write mount is:
> unshare -U --map-root --propagation=private -- mount -o remount,rw /some/mnt
> locking such flags prevents that from happening.

Thanks for the detailed explanation; it's very helpful.

>>> You could probably say:
>>>
>>> 	A  new  mount  and user namespace pair is created.  This
>>> 	happens for  example  when  specifying  CLONE_NEWUSER  |
>>> 	CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).
>>> 	The aforementioned flags become locked in the new mount
>>> 	namespace to prevent sensitive mount properties from being
>>> 	altered.
>>> 	Since the newly created mount namespace will be owned by the
>>> 	newly created user namespace a caller privileged in the newly
>>> 	created user namespace would be able to alter senstive
>>> 	mount properties. For example, without locking the read-only
>>> 	property for the mounts in the new mount namespace such a caller
>>> 	would be able to remount them read-write.
>>
>> So, I've now made the text:
>>
>>        EPERM  One of the mounts had at least one of MOUNT_ATTR_NOATIME,
>>               MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
>>               MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
>>               locked.  Mount attributes become locked on a mount if:
>>
>>               •  A new mount or mount tree is created causing mount
>>                  propagation across user namespaces (i.e., propagation to
>>                  a mount namespace owned by a different user namespace).
>>                  The kernel will lock the aforementioned flags to prevent
>>                  these sensitive properties from being altered.
>>
>>               •  A new mount and user namespace pair is created.  This
>>                  happens for example when specifying CLONE_NEWUSER |
>>                  CLONE_NEWNS in unshare(2), clone(2), or clone3(2).  The
>>                  aforementioned flags become locked in the new mount
>>                  namespace to prevent sensitive mount properties from
>>                  being altered.  Since the newly created mount namespace
>>                  will be owned by the newly created user namespace, a
>>                  calling process that is privileged in the new user
>>                  namespace would—in the absence of such locking—be able
>>                  to alter senstive mount properties (e.g., to remount a
>>                  mount that was marked read-only as read-write in the new
>>                  mount namespace).
>>
>> Okay?
> 
> Sounds good.

Okay.

>>> (Fwiw, in this scenario there's a bit of (moderately sane) strangeness.
>>>  A CLONE_NEWUSER | CLONE_NEWMNT will cause even stronger protection to
>>>  kick in. For all mounts not marked as expired MNT_LOCKED will be set
>>>  which means that a umount() on any such mount copied from the previous
>>>  mount namespace will yield EINVAL implying from userspace' perspective
>>>  it's not mounted - granted EINVAL is the ioctl() of multiplexing errnos
>>>  - whereas a remount to alter a locked flag will yield EPERM.)
>>
>> Thanks for educating me! So, is that what we are seeing below?

(Was your silence to the above question an implicit "yes"?)

>> $ sudo umount /mnt/m1
>> $ sudo mount -t tmpfs none /mnt/m1
>> $ sudo unshare -pf -Ur -m --mount-proc strace -o /tmp/log umount /mnt/m1
>> umount: /mnt/m1: not mounted.
>> $ grep ^umount /tmp/log
>> umount2("/mnt/m1", 0)                   = -1 EINVAL (Invalid argument)
>>
>> The mount_namespaces(7) page has for a log time had this text:
>>
>>        *  Mounts that come as a single unit from a more privileged mount
>>           namespace are locked together and may not be separated in a
>>           less privileged mount namespace.  (The unshare(2) CLONE_NEWNS
>>           operation brings across all of the mounts from the original
>>           mount namespace as a single unit, and recursive mounts that
>>           propagate between mount namespaces propagate as a single unit.)
>>
>> I have had trouble understanding that. But maybe you just helped.
>> Is that text relevant to what you just wrote above? In particular,
>> I have trouble understanding what "separated" means. But, perhaps
> 
> The text gives the "how" not the "why".

Yes, that's a big problem :-}.

> Consider a more elaborate mount tree where e.g., you have bind-mounted a
> mount over a subdirectory of another mount:
> 
> sudo mount -t tmpfs /mnt
> sudo mkdir /mnt/my-dir/
> sudo touch /mnt/my-dir/my-file
> sudo mount --bind /opt /mnt/my-dir
> 
> The files underneath /mnt/my-dir are now hidden. Consider what would
> happen if one would allow to address those mounts separately. A user
> could then do:
> 
> unshare -U --map-root --mount
> umount /mnt/my-dir
> cat /mnt/my-dir/my-file
> 
> giving them access to what's in my-dir.
> 
> Treating such mount trees as a unit in less privileged mount namespaces
> (cf. [1]) prevents that, i.e., prevents revealing files and directories
> that were overmounted.

Got it!
 
> Treating such mounts as a unit is also relevant when e.g. bind-mounting
> a mount tree containing locked mounts. Sticking with the example above:
> 
> unshare -U --map-root --mount
> 
> # non-recursive bind-mount will fail
> mount --bind /mnt /tmp
> 
> # recursive bind-mount will succeed
> mount --rbind /mnt /tmp
> 
> The reason is again that the mount tree at /mnt is treated as a mount
> unit because it is locked. If one were to allow to non-recursively
> bind-mountng /mnt somewhere it would mean revealing what's underneath
> the mount at my-dir (This is in some sense the inverse of preventing a
> filesystem from being mounted that isn't fully visible, i.e. contains
> hidden or over-mounted mounts.).

Got it!

> These semantics, in addition to being security relevant, also allow a
> more privileged mount namespace to create a restricted view of the
> filesystem hierarchy that can't be circumvented in a less privileged
> mount namespace (Otherwise pivot_root would have to be used which can
> also be used to guarantee a restriced view on the filesystem hierarchy
> especially when combined with a separate rootfs.).

Okay.

Christian, thanks for so generously taking the time to write this up.
It really helped me a lot! I will do some work on the mount namespaces
manual page, to cover at least part of what you said.

Thanks,

Michael

> Christian
> 
> [1]: I'll avoid jumping through the hoops of speaking about ownership
>      all the time now for the sake of brevity. Otherwise I'll still sit
>      here at lunchtime.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
