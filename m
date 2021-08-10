Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF03E84F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhHJVHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 17:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhHJVHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:07:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2CC0613C1;
        Tue, 10 Aug 2021 14:06:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d1so23080035pll.1;
        Tue, 10 Aug 2021 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5CHy1SNxpRc720cVBspYtxeXtcf77ZLLLtf/urdD5hw=;
        b=ttFNCsHS4q/G2eFtN+LykY8vkZX5cIQNSwlU0dDYmvxiQYpvHClFxTS3WC7pH4xtLl
         rUCqpYLH+kCwsoKOMIV4PWrUAKmuMV6xsYGPz/IHNTQr0VKX7rzElTqwlzwHSzzddxQv
         2JPF9K5WsZygu4y7eRmNSOQPYkmZN1HXbc2DOWB4k6nq4wleCfq4DDJlWaarR/4uiLCW
         8dkzNojVh2M67P1HYTXha6vhZGVQ1u+VIJR9iBey5M/zBKhhScEp/1EJbIguTFCvdSEA
         G4B16QsSnqsY1mqzpw2lVfYaKzObJDwJ3A4IgW/ZRy/9K7WoVg2ZYOUbvKi0SCjQC6kh
         hRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CHy1SNxpRc720cVBspYtxeXtcf77ZLLLtf/urdD5hw=;
        b=XqxvlKuorqbqBNyur5S1VeN8YOy93dSD6ZQ9i0o9MG8YFfDWux2TKEi/9qExotK3d+
         x/GiggWMJjTSeYFAM5X6i5D07HHxOFcoFV5vc+EXe4giqfZe3lp0PoLAQBvnalB0dVzq
         MSs9afIpJfrFK808lyx2byLcZNeo9UUweZbzxqKR2mEkzjylbZ7GtpE0odev8oedWShz
         sNsCiY1ToZPNfcnNBRrFEgdT3K0CKk7Kp89hoFUlmRDA1PlB0PDTr8/orxNHW6OjyBsU
         C9vaXumo7l40eN+7CaN4t3OK9YefCOPTJ5AYoJM3dlPFxYFg31qeGmDCpHr/lDwqBdU8
         B2lw==
X-Gm-Message-State: AOAM5329cKXQzHOSrigLNYdhXFIV2g5gU7Lopz75w2tGO/AazQco4OJ2
        lOpepzXjQi8c/vOEXJmBa5U=
X-Google-Smtp-Source: ABdhPJxYqEGpFkAcZ9EWhq5goli6XIW2Z/g0QlQAFBDcRGsOsVqonyJ5KPBVR3WH4zW11hsn8H5UZw==
X-Received: by 2002:a17:90b:4b8d:: with SMTP id lr13mr7169434pjb.141.1628629618029;
        Tue, 10 Aug 2021 14:06:58 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id p8sm24621044pfw.35.2021.08.10.14.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 14:06:57 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <20210810143255.2tjdskubryir2prp@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <95c7683e-957a-5a78-6b81-2cb8e756315c@gmail.com>
Date:   Tue, 10 Aug 2021 23:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810143255.2tjdskubryir2prp@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christian,

On 8/10/21 4:32 PM, Christian Brauner wrote:
> On Tue, Aug 10, 2021 at 03:38:00AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Christian,
>>
>> Thanks for the very nice manual page that you wrote. I have
> 
> Thank you!
> 
>> made a large number of (mostly trivial) edits. If you could
>> read the page closely, to check that I introduced no errors,
>> I would appreciate it.
> 
> Happy to!

Thanks for the feedback. I've made some changes, and pushed to Git.

There's still a few open questions. Please see "????" below.

>> I have various questions below, marked ???. Could you please take
>> a look at these, and I will then make further edits based on your
>> answers.
> 
> I've answered all questions, I think. Feel free to just reformulate
> where my suggestions weren't adequate. Since most things you ask about
> are minor adaptions there's no need from my end for you to resend with
> those reformulations. You can just make them directly. :) I'll peruse
> the man-pages git repo anyway after you apply them and will send changes
> if I spot issues.
> 
> Thank you for the review!
> Christian
> 
>>
>> The current version of the page is already pushed to the man-pages
>> Git repo.
>>
>>>   MOUNT_SETATTR(2)      Linux Programmer's Manual     MOUNT_SETATTR(2)
>>>
>>>   NAME
>>>       mount_setattr - change mount properties of a mount or mount
>>
>> ???
>> s/mount properties/properties ?
>>
>> (Just bcause more concise.)
> 
> Sounds good.

Done.

>>
>>>       tree
>>>
>>>   SYNOPSIS
>>>       #include <linux/fcntl.h> /* Definition of AT_* constants */
>>>       #include <linux/mount.h> /* Definition of MOUNT_ATTR_* constants */
>>>       #include <sys/syscall.h> /* Definition of SYS_* constants */
>>>       #include <unistd.h>
>>>
>>>       int syscall(SYS_mount_setattr, int dirfd, const char *path,
>>>               unsigned int flags, struct mount_attr *attr, size_t size);
>>>
>>>       Note: glibc provides no wrapper for mount_setattr(),
>>>       necessitating the use of syscall(2).
>>>
>>>   DESCRIPTION

[...]

>>>       The size argument should usually be specified as
>>>       sizeof(struct mount_attr).  However, if the caller does not
>>>       intend to make use of features that got introduced after the
>>>       initial version of struct mount_attr, it is possible to pass
>>>       the size of the initial struct together with the larger
>>>       struct.  This allows the kernel to not copy later parts of
>>>       the struct that aren't used anyway.  With each extension that
>>>       changes the size of struct mount_attr, the kernel will expose
>>>       a definition of the form MOUNT_ATTR_SIZE_VERnumber.  For
>>>       example, the macro for the size of the initial version of
>>>       struct mount_attr is MOUNT_ATTR_SIZE_VER0.
>>
>> ???
>> I think I understand the above paragraph, but I wonder if it could
>> be improved a little. The general principle is that one can always
>> pass the size of an earlier, smaller structure to the kernel, right?
> 
> Yes.
> 
>> My point is that it need not be the size of the initial structure,
>> right? So, I wonder whether a little rewording might be need above.
> 
> Yes, the initial structure size is just an example because that will be
> very common.
> 
>> What do you think?
> 
> Sure, I'm proposing something here but please, fell free to reformulate
> or come up with something completely new:
> 
> 	[...]
> 	However, if the caller is using a kernel that supports an
> 	extended struct mount_attr but the caller does not intend to
> 	make use of these features they can pass the size of an earlier
> 	version of the struct together with the extended structure.
> 	[...]

Perfect! I took that text pretty much exactly as you gave it.

[...]

>>>       The attr_set and attr_clr members are used to specify the
>>>       mount properties that are supposed to be set or cleared for a
>>>       mount or mount tree.  Flags set in attr_set enable a property
>>>       on a mount or mount tree, and flags set in attr_clr remove a
>>>       property from a mount or mount tree.
>>>
>>>       When changing mount properties, the kernel will first clear
>>>       the flags specified in the attr_clr field, and then set the
>>>       flags specified in the attr_set field:
>>
>> ???
>> I find the following example a bit confusing. See below.
>>
>>>
>>>           struct mount_attr attr = {
>>>               .attr_clr = MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NODEV,
>>>               .attr_set = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
>>>           };
>>
>> ???
>> I *think* that what you are trying to show is that the above initializer
>> resuts in the equivalent of the following code. Is that correct? If so, 
>> I think the text needs some work to make this clearer. Let me know.
> 
> Yes, exactly. Feel free to remove that code and just explain it in text
> if that's better.

I've done some rewording to say that the code snippet shows
the effect of the initializer.

[...]

>>>   RETURN VALUE
>>>       On success, mount_setattr() returns zero.  On error, -1 is
>>>       returned and errno is set to indicate the cause of the error.
>>>
>>>   ERRORS

[...]

>>>       EINVAL A valid file descriptor value was specified in
>>>              userns_fd, but the file descriptor wasn't a namespace
>>>              file descriptor or did not refer to a user namespace.
>>
>> ???
>> Could the above not be simplified to
>>
>>       EINVAL A valid file descriptor value was specified in
>>              userns_fd, but the file descriptor did not refer
>>              to a user namespace.
> 
> Sounds good.
> 
>> ?

Done.

>>>
>>>       EINVAL The underlying filesystem does not support ID-mapped
>>>              mounts.
>>>
>>>       EINVAL The mount that is to be ID mapped is not a
>>>              detached/anonymous mount; that is, the mount is
>>
>> ???
>> What is a the distinction between "detached" and "anonymous"?
>> Or do you mean them to be synonymous? If so, then let's use
>> just one term, and I think "detached" is preferable.
> 
> Yes, they are synonymous here. I list both because detached can
> potentially be confusing. A detached mount is a mount that has not been
> visible in the filesystem. But if you attached it an then unmount it
> right after and keep the fd for the mountpoint open it's a detached
> mount purely on a natural language level, I'd argue. But it's not a
> detached mount from the kernel's view anymore because it has been
> exposed in the filesystem and is thus not detached anymore.
> But I do prefer "detached" to "anonymous" and that confusion is very
> unlikely to occur.

Thanks. I made it "detached". Elsewhere, the page already explains
that a detached mount is one that:

          must have been created by calling open_tree(2) with the
          OPEN_TREE_CLONE flag and it must not already have been
          visible in the filesystem.

Which seems a fine explanation. 

????
But, just a thought... "visible in the filesystem" seems not quite accurate. 
What you really mean I guess is that it must not already have been
/visible in the filesystem hierarchy/previously mounted/something else/,
right?

>>>              already visible in the filesystem.
>>>

[...]

>>>       EPERM  An already ID-mapped mount was supposed to be ID
>>>              mapped.
>>
>> ???
>> Better:
>>     An attempt was made to add an ID mapping to a mount that is already
>>     ID mapped.
> 
> Sounds good.
> 
>> ?

Done.

[...]

>>>   NOTES
>>>   ID-mapped mounts
>>>       Creating an ID-mapped mount makes it possible to change the
>>>       ownership of all files located under a mount.  Thus, ID-
>>>       mapped mounts make it possible to change ownership in a
>>>       temporary and localized way.  It is a localized change
>>>       because ownership changes are restricted to a specific mount.
>>
>> ???
>> Would it be clearer to say something like:
>>
>>     It is a localized change because ownership changes are
>>     visible only via a specific mount.
>> ?
> 
> Sounds good.

Done.

[...]

>>>       The following conditions must be met in order to create an
>>>       ID-mapped mount:
>>>
>>>       •  The caller must have the CAP_SYS_ADMIN capability in the
>>>          initial user namespace.
>>>
>>>       •  The filesystem must be mounted in the initial user
>>>          namespace.
>>
>> ???
>> Should this rather be written as:
>>  
>>      The filesystem must be mounted in a mount namespace 
>>      that is owned by the initial user namespace.
> 
> Sounds good.

Done.

>>>       •  The underlying filesystem must support ID-mapped mounts.
>>>          Currently, the xfs(5), ext4(5), and FAT filesystems
>>>          support ID-mapped mounts with more filesystems being
>>>          actively worked on.
>>>
>>>       •  The mount must not already be ID-mapped.  This also
>>>          implies that the ID mapping of a mount cannot be altered.
>>>
>>>       •  The mount must be a detached/anonymous mount; that is, it
>>
>> ???
>> See the above questionon "detached" vs "anonymous"
> 
> Yes, please use "detached" only.

Done.

>>>          must have been created by calling open_tree(2) with the
>>>          OPEN_TREE_CLONE flag and it must not already have been
>>>          visible in the filesystem.
>>>
>>>       ID mappings can be created for user IDs, group IDs, and
>>>       project IDs.  An ID mapping is essentially a mapping of a
>>>       range of user or group IDs into another or the same range of
>>>       user or group IDs.  ID mappings are usually written as three
>>>       numbers either separated by white space or a full stop.  The
>>>       first two numbers specify the starting user or group ID in
>>>       each of the two user namespaces.  The third number specifies
>>>       the range of the ID mapping.  For example, a mapping for user
>>>       IDs such as 1000:1001:1 would indicate that user ID 1000 in
>>>       the caller's user namespace is mapped to user ID 1001 in its
>>>       ancestor user namespace.  Since the map range is 1, only user
>>>       ID 1000 is mapped.
>>
>> ???
>> The details above seem wrong. When writing to map files, the
>> fields must be white-space separated, AFAIK. But above you mention
>> "full stops" and also show an example using colons (:). Those
>> both seem wrong and confusing. Am I missing something?
> 
> This is more about notational conventions that exist and not about how
> they are actually written. That's something I'm not touching on here as
> it doesn't belong on this manpage. But feel free to only mention spaces.

Thanks for the explanation. In this context though, this could mislead
the reader, so I've removed mention of "full stop" and ":".

>>>       It is possible to specify up to 340 ID mappings for each ID
>>>       mapping type.  If any user IDs or group IDs are not mapped,
>>>       all files owned by that unmapped user or group ID will appear
>>>       as being owned by the overflow user ID or overflow group ID
>>>       respectively.
>>>
>>>       Further details and instructions for setting up ID mappings
>>>       can be found in the user_namespaces(7) man page.
>>>
>>>       In the common case, the user namespace passed in userns_fd
>>>       together with MOUNT_ATTR_IDMAP in attr_set to create an ID-
>>>       mapped mount will be the user namespace of a container.  In
>>>       other scenarios it will be a dedicated user namespace
>>>       associated with a user's login session as is the case for
>>>       portable home directories in systemd-homed.service(8)).  It
>>>       is also perfectly fine to create a dedicated user namespace
>>>       for the sake of ID mapping a mount.

I forgot to mention it earlier, but the following text on the
rationale for ID-mapped mounts is what turns this from a good 
manual page into a great manual page. Thank you for including it.

>>>       ID-mapped mounts can be useful in the following and a variety
>>>       of other scenarios:
>>>
>>>       •  Sharing files between multiple users or multiple machines,
>>
>> ???
>> s/Sharing files/Sharing filesystems/ ?
> 
> [1]: But work. But feel free to use "sharing filesystems".

s/But/Both/

I made it "Sharing files or filesystsms"

>>
>>>          especially in complex scenarios.  For example, ID-mapped
>>>          mounts are used to implement portable home directories in
>>>          systemd-homed.service(8), where they allow users to move
>>>          their home directory to an external storage device and use
>>>          it on multiple computers where they are assigned different
>>>          user IDs and group IDs.  This effectively makes it
>>>          possible to assign random user IDs and group IDs at login
>>>          time.
>>>
>>>       •  Sharing files from the host with unprivileged containers.
>>
>> ???
>> s/Sharing files/Sharing filesystems/ ?
> 
> See [1].

Same.

>>>          This allows a user to avoid having to change ownership
>>>          permanently through chown(2).
>>>
>>>       •  ID mapping a container's root filesystem.  Users don't
>>>          need to change ownership permanently through chown(2).
>>>          Especially for large root filesystems, using chown(2) can
>>>          be prohibitively expensive.
>>>
>>>       •  Sharing files between containers with non-overlapping ID
>>
>> ???
>> s/Sharing files/Sharing filesystems/ ?
> 
> See [1].

Same.

[...]

>>>       •  Locally and temporarily restricted ownership changes.  ID-
>>>          mapped mounts make it possible to change ownership
>>>          locally, restricting it to specific mounts, and
>>
>> ???
>> The referent of "it" in the preceding line is not clear.
>> Should it be "the ownership changes"? Or something else?
> 
> It should refer to ownership changes. I'd appreciate it if you could
> reformulate.

Done.

>>>          temporarily as the ownership changes only apply as long as
>>>          the mount exists.  By contrast, changing ownership via the
>>>          chown(2) system call changes the ownership globally and
>>>          permanently.
>>>
>>>   Extensibility

[...]

>>>   EXAMPLES
>>
>> ???
>> Do you have a (preferably simple) example piece of code
>> somewhere for setting up an ID mapped mount?

????
I guess the best example is this:
https://github.com/brauner/mount-idmapped/
right?

[...]

>>>       int
>>>       main(int argc, char *argv[])
>>>       {
>>>           struct mount_attr *attr = &(struct mount_attr){};
>>>           int fd_userns = -EBADF;
>>
>> ???
>> Why this magic initializer here? Why not just "-1"?
>> Using -EBADF makes it look this is value specifically is
>> meaningful, although I don't think that's true.
> 
> [2]: I always use -EBADF to initialize fds in all my code. It makes it
> pretty easy to grep for fd initialization etc. So it's pure visual
> convenience. Freel free to just use -1.

Changed.

[...]

>>>           int fd_tree = open_tree(-EBADF, source,
>>>                        OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC |
>>>                        AT_EMPTY_PATH | (recursive ? AT_RECURSIVE : 0));
>>
>> ???
>> What is the significance of -EBADF here? As far as I can tell, it
>> is not meaningful to open_tree()?
> 
> I always pass -EBADF for similar reasons to [2]. Feel free to just use -1.

????
But here, both -EBADF and -1 seem to be wrong. This argument 
is a dirfd, and so should either be a file descriptor or the
value AT_FDCWD, right?

>>>           if (fd_tree == -1)
>>>               exit_log("%m - Failed to open %s\n", source);
>>>
>>>           if (fd_userns >= 0) {
>>>               attr->attr_set  |= MOUNT_ATTR_IDMAP;
>>>               attr->userns_fd = fd_userns;
>>>           }
>>>
>>>           ret = mount_setattr(fd_tree, "",
>>>                       AT_EMPTY_PATH | (recursive ? AT_RECURSIVE : 0),
>>>                       attr, sizeof(struct mount_attr));
>>>           if (ret == -1)
>>>               exit_log("%m - Failed to change mount attributes\n");
>>>
>>>           close(fd_userns);
>>>
>>>           ret = move_mount(fd_tree, "", -EBADF, target,
>>>                            MOVE_MOUNT_F_EMPTY_PATH);
>>
>> ???
>> What is the significance of -EBADF here? As far as I can tell, it
>> is not meaningful to move_mount()?
> 
> See [2].

????
As above, both -EBADF and -1 seem to be wrong. This argument 
is a dirfd, and so should either be a file descriptor or the
value AT_FDCWD, right?

[...]

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
