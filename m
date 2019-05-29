Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1A2D58F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfE2Gds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 02:33:48 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43629 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfE2Gdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 02:33:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id n145so372589ybg.10;
        Tue, 28 May 2019 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yENNg7cJ89dNJXBOI0oAIdYRt7Ra6atK2tYz8p0gMCg=;
        b=gSd6RavHCdQA6U4PmK50WU7ujwJFo5fxoJGlDl+i6xOvDAKDtBpghDDm0UIcMJ1ZlU
         /aFHtGuF1bHEqxQJVd15Budgd3S9h4YJFeiyLo45rxhzARoBSJebbdrzA0YZpTTVqEYb
         lSF2E9NzXeBFPdV8Lx+IBYhxY511yYJgLeJOOqjg9mmcuWw8GR6BzqMA0kxhJIjhC/7a
         80JkV/Di3vv9PZtwM/LWYu4EkvfW28oVckVL8hJ8W0KEj1QRFONAs3K5vyC0Z6OVuZmL
         cO3Art9UkR+Pe6p6QueAGoQSVAJZWkE8ESlqRnuiuYQUG8jRt4SdqwWPcwwnynIV7yxX
         4yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yENNg7cJ89dNJXBOI0oAIdYRt7Ra6atK2tYz8p0gMCg=;
        b=p0k8OEzNgbMmJwHut6h3wTLGgZWUCQEujQQ9riWJ1gURsUgoFJqAzFADXNrKkZvLYq
         tCzVR0KDRz+B7jXNk67rWqasc6F0RAWPhGylEznFkB//XMaaFajQ+KlpPtZsKgBu5BqW
         7wOVc/qzEUtrF0hu/yokN6HdqMGlZfxSjXZm9QErbrNyMZMRYimZkoAB3SAh+qYaCwkB
         xs29sTpbUxFadaSGKktoDlibIH1nYtVNt+NYKYigeRwJ18+Rn0hnVTEDxPPsV9ln+8W/
         AiRx3ms9uqdABcBAD9cRMExzKSjFe75rhRUDW7jtXSgo+zfYKI4Q1Es4R8NOzW1CqTY4
         FU5w==
X-Gm-Message-State: APjAAAUizDDwygy6YqyCsbw5RXndhLkMTC+4xo6FgYUOTHg8XzKa45oL
        2FZvhEBjYyzMALoW9GLw0mTt0OYtZbWqeH2vvaU=
X-Google-Smtp-Source: APXvYqw6mhDaSRkRnU+dl3Ic5kIIYX8fjw8ZnGYUgNxTD9y/LjYm69ByqIvjP7UucT+m0cDy12RZjAOWaXE0FMJVtOo=
X-Received: by 2002:a25:8109:: with SMTP id o9mr28076017ybk.132.1559111626228;
 Tue, 28 May 2019 23:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 09:33:35 +0300
Message-ID: <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 7:03 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Al,
>
> Here's a set of patches to add a general variable-length notification queue
> concept and to add sources of events for:
>
>  (1) Mount topology events, such as mounting, unmounting, mount expiry,
>      mount reconfiguration.
>
>  (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
>      errors (not complete yet).
>
>  (3) Block layer events, such as I/O errors.
>
>  (4) Key/keyring events, such as creating, linking and removal of keys.
>
> One of the reasons for this is so that we can remove the issue of processes
> having to repeatedly and regularly scan /proc/mounts, which has proven to
> be a system performance problem.  To further aid this, the fsinfo() syscall
> on which this patch series depends, provides a way to access superblock and
> mount information in binary form without the need to parse /proc/mounts.
>
>
> Design decisions:
>
>  (1) A misc chardev is used to create and open a ring buffer:
>
>         fd = open("/dev/watch_queue", O_RDWR);
>
>      which is then configured and mmap'd into userspace:
>
>         ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
>         ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
>         buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
>                    MAP_SHARED, fd, 0);
>
>      The fd cannot be read or written (though there is a facility to use
>      write to inject records for debugging) and userspace just pulls data
>      directly out of the buffer.
>
>  (2) The ring index pointers are stored inside the ring and are thus
>      accessible to userspace.  Userspace should only update the tail
>      pointer and never the head pointer or risk breaking the buffer.  The
>      kernel checks that the pointers appear valid before trying to use
>      them.  A 'skip' record is maintained around the pointers.
>
>  (3) poll() can be used to wait for data to appear in the buffer.
>
>  (4) Records in the buffer are binary, typed and have a length so that they
>      can be of varying size.
>
>      This means that multiple heterogeneous sources can share a common
>      buffer.  Tags may be specified when a watchpoint is created to help
>      distinguish the sources.
>
>  (5) The queue is reusable as there are 16 million types available, of
>      which I've used 4, so there is scope for others to be used.
>
>  (6) Records are filterable as types have up to 256 subtypes that can be
>      individually filtered.  Other filtration is also available.
>
>  (7) Each time the buffer is opened, a new buffer is created - this means
>      that there's no interference between watchers.
>
>  (8) When recording a notification, the kernel will not sleep, but will
>      rather mark a queue as overrun if there's insufficient space, thereby
>      avoiding userspace causing the kernel to hang.
>
>  (9) The 'watchpoint' should be specific where possible, meaning that you
>      specify the object that you want to watch.
>
> (10) The buffer is created and then watchpoints are attached to it, using
>      one of:
>
>         keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
>         mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
>         sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);
>
>      where in all three cases, fd indicates the queue and the number after
>      is a tag between 0 and 255.
>
> (11) The watch must be removed if either the watch buffer is destroyed or
>      the watched object is destroyed.
>
>
> Things I want to avoid:
>
>  (1) Introducing features that make the core VFS dependent on the network
>      stack or networking namespaces (ie. usage of netlink).
>
>  (2) Dumping all this stuff into dmesg and having a daemon that sits there
>      parsing the output and distributing it as this then puts the
>      responsibility for security into userspace and makes handling
>      namespaces tricky.  Further, dmesg might not exist or might be
>      inaccessible inside a container.
>
>  (3) Letting users see events they shouldn't be able to see.
>
>
> Further things that could be considered:
>
>  (1) Adding a keyctl call to allow a watch on a keyring to be extended to
>      "children" of that keyring, such that the watch is removed from the
>      child if it is unlinked from the keyring.
>
>  (2) Adding global superblock event queue.
>
>  (3) Propagating watches to child superblock over automounts.
>

David,

I am interested to know how you envision filesystem notifications would
look with this interface.

fanotify can certainly benefit from providing a ring buffer interface to read
events.

From what I have seen, a common practice of users is to monitor mounts
(somehow) and place FAN_MARK_MOUNT fanotify watches dynamically.
It'd be good if those users can use a single watch mechanism/API for
watching the mount namespace and filesystem events within mounts.

A similar usability concern is with sb_notify and FAN_MARK_FILESYSTEM.
It provides users with two complete different mechanisms to watch error
and filesystem events. That is generally not a good thing to have.

I am not asking that you implement fs_notify() before merging sb_notify()
and I understand that you have a use case for sb_notify().
I am asking that you show me the path towards a unified API (how a
typical program would look like), so that we know before merging your
new API that it could be extended to accommodate fsnotify events
where the final result will look wholesome to users.

Thanks,
Amir.
