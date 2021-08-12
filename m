Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307633E9DFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 07:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhHLFh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 01:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhHLFhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:37:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B1C061765;
        Wed, 11 Aug 2021 22:36:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n12so5152365plf.4;
        Wed, 11 Aug 2021 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RdNJ1ei8LOzpD4pXrGIsYfNzAwATBCIZZw+FyUAq7xw=;
        b=ETl2/Kg0oJzC7YPbxvknqhtWmRQxQc/ZzTskpUAeEtJgBPhuxtR6OfMK9lgmW6f+2q
         0j+w/xGdfZs9fGKcNkhKcMqBkl1i2T0a86Jv4i/C9AjELTYheM8I4O8B2XU5imiR3TeS
         TgWCDgombHQuqnWWPpadj4upzjlD8l970BMk/Uu5frc3hAFosljrbyTc/+HKzjnvzobv
         G1VWDQmHS6XWBvDi6YTHM3w001owrTC+SkRBWypKWRvtH2B6+22h9lz8H9Xo4lOHCUYb
         VfL4FdiHSHkt2J3W6cc/cpKszk6cHnAENEKIR28QBzcUSIm7w+PE+s4a51YUACNfssuc
         3HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RdNJ1ei8LOzpD4pXrGIsYfNzAwATBCIZZw+FyUAq7xw=;
        b=NrZrHyCKANp4QpnkRfbzpnTQZA8xM+ogOaAvwvX1B74WEIRRX8BP/OP03uV2Y/7CUi
         +A+4e73M/5bm6R1cAoeCnL6X7aC1T651xeCwPQEz67LoUWfIYovbVzGJIMUYzVZ25nIW
         YOuzRYI616fThGX9JwJO5YqcG1BBo+iu4V5s3LTwOicE/6IsGtZwRtCLvJAVaSjxUPUi
         AQaqlA2ELr3Amq2ZYAa1CcBKWXHd4p8296VR4LYe/glLVmpWKvBr2ZHnpDbtAK+vbjm1
         lHenu933Fu85Px5YFCBFcLevRSOi7hvrZRIiG2CwG6xj8EgdkZh/JnspmQ2XlLkhXoGB
         Jq1A==
X-Gm-Message-State: AOAM531WR+aU6RWFmWgUyKe1Dwj22U1oYjIY+SPMUFgUmQnSdd8i/CNU
        nlWRFOVTpHHECOI+Ghxh2lM=
X-Google-Smtp-Source: ABdhPJxnn3YCVdcjSzgsjNjgY0qaeW+PSEHyJu4yq7bSorvJ04/ZPqiUSBiIyrHb52m2Gf+ARVmmiw==
X-Received: by 2002:a05:6a00:1481:b029:3e0:4537:a1d9 with SMTP id v1-20020a056a001481b02903e04537a1d9mr2430363pfu.36.1628746619455;
        Wed, 11 Aug 2021 22:36:59 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id z17sm1597978pfe.148.2021.08.11.22.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 22:36:59 -0700 (PDT)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <2f640877-dd82-6827-dfd0-c7f8fd5acbbc@gmail.com>
Date:   Thu, 12 Aug 2021 07:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811104030.in6f25hw5h5cotti@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC += Eric, in case he has a comment on the last piece]

Hi Christian,

(A few questions below.)

On 8/11/21 12:40 PM, Christian Brauner wrote:
> On Wed, Aug 11, 2021 at 12:47:14AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Christian,
>>
>> Some further questions...
>>
>> In ERRORS there is:
>>
>>        EINVAL The underlying filesystem is mounted in a user namespace.
>>
>> I don't understand this. What does it mean?
> 
> The underlying filesystem has been mounted in a mount namespace that is
> owned by a non-initial user namespace (Think of sysfs, overlayfs etc.).

Thanks!

>> Also, there is this:
>>
>>        ENOMEM When  changing  mount  propagation to MS_SHARED, a new peer
>>               group ID needs to be allocated for  all  mounts  without  a
>>               peer  group  ID  set.  Allocation of this peer group ID has
>>               failed.
>>
>>        ENOSPC When changing mount propagation to MS_SHARED,  a  new  peer
>>               group  ID  needs  to  be allocated for all mounts without a
>>               peer group ID set.  Allocation of this peer  group  ID  can
>>               fail.  Note that technically further error codes are possi‐
>>               ble that are specific to the ID  allocation  implementation
>>               used.
>>
>> What is the difference between these two error cases? (That is, in what 
>> circumstances will one get ENOMEM vs ENOSPC and vice versa?)
> 
> I did really wonder whether to even include those errors and I regret
> having included them because they aren't worth a detailed discussion as
> I'd consider them kernel internal relevant errors rather than userspace
> relevant errors. In essence, peer group ids are allocated using the id
> infrastructure of the kernel. It can fail for two main reasons:
> 
> 1. ENOMEM there's not enough memory to allocate the relevant internal
>    structures needed for the bitmap.
> 2. ENOSPC we ran out of ids, i.e. someone has somehow managed to
>    allocate so many peer groups and managed to keep the kernel running
>    (???) that the ida has ran out of ids.
> 
> Feel free to just drop those errors.

Because they can at least theoretically be visible to user space, I
prefer to keep them. But I've reworked a bit:

       ENOMEM When changing mount propagation to MS_SHARED, a new
              peer group ID needs to be allocated for all mounts
              without a peer group ID set.  This allocation failed
              because there was not enough memory to allocate the
              relevant internal structures.

       ENOSPC When changing mount propagation to MS_SHARED, a new
              peer group ID needs to be allocated for all mounts
              without a peer group ID set.  This allocation failed
              because the kernel has run out of IDs.

>> And then:
>>
>>        EPERM  One  of  the mounts had at least one of MOUNT_ATTR_NOATIME,
>>               MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
>>               MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
>>               locked.  Mount attributes become locked on a mount if:
>>
>>               •  A new mount or mount tree is created causing mount prop‐
>>                  agation  across  user  namespaces.  The kernel will lock
>>
>> Propagation is done across mont points, not user namespaces.
>> should "across user namespaces" be "to a mount namespace owned 
>> by a different user namespace"? Or something else?
> 
> That's really splitting hairs.

To be clear, I'm not trying to split hairs :-). It's just that
I'm struggling a little to understand. (In particular, the notion
of locked mounts is one where my understanding is weak.) 

And think of it like this: I am the first line of defense for the
user-space reader. If I am having trouble to understand the text,
I wont be alone. And often, the problem is not so much that the
text is "wrong", it's that there's a difference in background
knowledge between what you know and what the reader (in this case
me) knows. Part of my task is to fill that gap, by adding info
that I think is necessary to the page (with the happy side
effect that I learn along the way.)

> Of course this means that we're
> propagating into a mount namespace that is owned by a different user
> namespace though "crossing user namespaces" might have been the better
> choice.

This is a perfect example of the point I make above. You say "of course",
but I don't have the background knowledge that you do :-). From my
perspective, I want to make sure that I understand your meaning, so
that that meaning can (IMHO) be made easier for the average reader
of the manual page.

>>                  the aforementioned  flags  to  protect  these  sensitive
>>                  properties from being altered.
>>
>>               •  A  new  mount  and user namespace pair is created.  This
>>                  happens for  example  when  specifying  CLONE_NEWUSER  |
>>                  CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).  The
>>                  aforementioned flags become locked to protect user name‐
>>                  spaces from altering sensitive mount properties.
>>
>> Again, this seems imprecise. Should it say something like:
>> "... to prevent changes to sensitive mount properties in the new 
>> mount namespace" ? Or perhaps you have a better wording.
> 
> That's not imprecise. 

Okay -- poor choice of wording on my part:

s/this seems imprecise/I'm having trouble understanding this/

> What you want to protect against is altering
> sensitive mount properties from within a user namespace irrespective of
> whether or not the user namespace actually owns the mount namespace,
> i.e. even if you own the mount namespace you shouldn't be able to alter
> those properties. I concede though that "protect" should've been
> "prevent".

Can I check my education here please. The point is this:

* The mount point was created in a mount NS that was owned by
  a more privileged user NS (e.g., the initial user NS).
* A CLONE_NEWUSER|CLONE_NEWNS step occurs to create a new (user and) 
  mount NS.
* In the new mount NS, the mounts become locked.

And, help me here: is it correct that the reason the properties
need to be locked is because they are shared between the mounts?

> You could probably say:
> 
> 	A  new  mount  and user namespace pair is created.  This
> 	happens for  example  when  specifying  CLONE_NEWUSER  |
> 	CLONE_NEWNS  in unshare(2), clone(2), or clone3(2).
> 	The aforementioned flags become locked in the new mount
> 	namespace to prevent sensitive mount properties from being
> 	altered.
> 	Since the newly created mount namespace will be owned by the
> 	newly created user namespace a caller privileged in the newly
> 	created user namespace would be able to alter senstive
> 	mount properties. For example, without locking the read-only
> 	property for the mounts in the new mount namespace such a caller
> 	would be able to remount them read-write.

So, I've now made the text:

       EPERM  One of the mounts had at least one of MOUNT_ATTR_NOATIME,
              MOUNT_ATTR_NODEV, MOUNT_ATTR_NODIRATIME, MOUNT_ATTR_NOEXEC,
              MOUNT_ATTR_NOSUID, or MOUNT_ATTR_RDONLY set and the flag is
              locked.  Mount attributes become locked on a mount if:

              •  A new mount or mount tree is created causing mount
                 propagation across user namespaces (i.e., propagation to
                 a mount namespace owned by a different user namespace).
                 The kernel will lock the aforementioned flags to prevent
                 these sensitive properties from being altered.

              •  A new mount and user namespace pair is created.  This
                 happens for example when specifying CLONE_NEWUSER |
                 CLONE_NEWNS in unshare(2), clone(2), or clone3(2).  The
                 aforementioned flags become locked in the new mount
                 namespace to prevent sensitive mount properties from
                 being altered.  Since the newly created mount namespace
                 will be owned by the newly created user namespace, a
                 calling process that is privileged in the new user
                 namespace would—in the absence of such locking—be able
                 to alter senstive mount properties (e.g., to remount a
                 mount that was marked read-only as read-write in the new
                 mount namespace).

Okay?

> (Fwiw, in this scenario there's a bit of (moderately sane) strangeness.
>  A CLONE_NEWUSER | CLONE_NEWMNT will cause even stronger protection to
>  kick in. For all mounts not marked as expired MNT_LOCKED will be set
>  which means that a umount() on any such mount copied from the previous
>  mount namespace will yield EINVAL implying from userspace' perspective
>  it's not mounted - granted EINVAL is the ioctl() of multiplexing errnos
>  - whereas a remount to alter a locked flag will yield EPERM.)

Thanks for educating me! So, is that what we are seeing below?

$ sudo umount /mnt/m1
$ sudo mount -t tmpfs none /mnt/m1
$ sudo unshare -pf -Ur -m --mount-proc strace -o /tmp/log umount /mnt/m1
umount: /mnt/m1: not mounted.
$ grep ^umount /tmp/log
umount2("/mnt/m1", 0)                   = -1 EINVAL (Invalid argument)

The mount_namespaces(7) page has for a log time had this text:

       *  Mounts that come as a single unit from a more privileged mount
          namespace are locked together and may not be separated in a
          less privileged mount namespace.  (The unshare(2) CLONE_NEWNS
          operation brings across all of the mounts from the original
          mount namespace as a single unit, and recursive mounts that
          propagate between mount namespaces propagate as a single unit.)

I have had trouble understanding that. But maybe you just helped.
Is that text relevant to what you just wrote above? In particular,
I have trouble understanding what "separated" means. But, perhaps
is means "separately unmounted"? (I added Eric in CC,
in case he has something to say.)

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
