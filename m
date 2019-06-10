Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6C3B831
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbfFJPV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 11:21:26 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:4772 "EHLO
        UCOL19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389997AbfFJPVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:21:25 -0400
X-EEMSG-check-017: 27200632|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,575,1557187200"; 
   d="scan'208";a="27200632"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jun 2019 15:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560180078; x=1591716078;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=6GVGeWFfPRtAzKu/YQShunam7JA1BmghsOayMT9r9Wk=;
  b=c2Y8Jz1/blwlxgYRzH1lHXuspx5+FD0VZLyajd1SbEe5sR2Gz0vazwok
   Zhdxt9o5WuxkI0czSqH7yjIgfXgedIJGdcHzSkZGpz+iJCbCihxAJWNNx
   lkBw5WBVqVYfL02zSTk7Gm5YCy3YYUAHm8FN2fq+hFXLveK5QpdQ5Uzqy
   nR7Krjusn7Se1ff9ODlKuTQOHY4/JPyiW6+M0rNcZlgnhyXXQU0QO8ctH
   +ZJSxwSUcglmBPsgn68B+Utnln3Gd2/+E78r9ABAstgf2tliTSaHSluVD
   2iYjwusBCv5rzd5co/L4cqHTU/8jZtJu08WiGxARCbJDQ/xG3XVwqWq7p
   w==;
X-IronPort-AV: E=Sophos;i="5.63,575,1557187200"; 
   d="scan'208";a="28760646"
IronPort-PHdr: =?us-ascii?q?9a23=3APFcDnhIWbgZrwUJU59mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLPn8rarrMEGX3/hxlliBBdydt6sdzbOL6euwBCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfL9+Ngi6oAXPusUZgoZvKrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjfygF1o4nxxjBZPyDaYSI5QjjVOmXLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NulgH/Mrghmsy4AegiNA?=
 =?us-ascii?q?gBQ3Ob9vim2L3m/E35RK1GjvwwkqbHrJDXPdkXq6G2DgNP0osv9gyzAymp3d?=
 =?us-ascii?q?gGh3ULMUpJeBedgIjoP1HOLur4DfC6g1m0izdk2uvGM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG73ubnCNJz14wAXWKPBr?=
 =?us-ascii?q?SZPbjIsVCW++0vI/ODZJMPtDnhLPgl4ubkjWUlll8FYampwZwXZWimHvRnOU?=
 =?us-ascii?q?WZZmHhg9YfHmcMvwo+UvbmiFmDUT5VenazULgw5jYhCIKpF4vDW4OtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfsdoWEXeoMaS2LLs98iTwLTqOsS5Eu1R6wrg/20blnIf?=
 =?us-ascii?q?TO+i0eq53j0MJ55+rJlRE97TZ0FdiS03mRT2FomWMFXzs23KF5oUxgxVaPyL?=
 =?us-ascii?q?N4jOJEGtxO/fNJUxs6NJ7Fw+x/DND9Rx/BftOXR1u9XNWmDi8+Tsgrz98NfU?=
 =?us-ascii?q?l9AdOigQ7H3yawBL8VjbOLDoQu8q3Ax3jxO9p9y3He2aY9lVYmWdVANG29i6?=
 =?us-ascii?q?5k6wfTB5TGk1iXl6aua6scxjfB+3uZwmaUoE5YVwtwW73fXX8DfkvWscj55k?=
 =?us-ascii?q?TaQr+hE7QoLARByc2CKqZRbt3pjFNGROrsOdTQZGKxhmGwCguSybOQbYrqfG?=
 =?us-ascii?q?Md0D/aCEgenAAZ5WyGOhQmBie9v2LeCyRjFUj1bEPy7+Z+rmi2TlM0zw6Uak?=
 =?us-ascii?q?1uzbS09gQThfOCV/MZxqgEtzs5qzVoAFa92MrbC96BpwpnYaVdbsox4Flc1W?=
 =?us-ascii?q?3EqQN9IIKvL6R5i14AfAR4oVnu2w90Copei8gqqm0lzA5oJaKfylNBeCuS3Y?=
 =?us-ascii?q?rsNb3PNmny4BevZrbS2lHf1taW56gO5O0ipFX7vQGkDVQi83p53NlPyXec5Y?=
 =?us-ascii?q?vFDBAUUZ3vVkY77R96p6vVYiMl/YPbyWVsMbWosj/Fw98pAOolyhC9f9ZQKa?=
 =?us-ascii?q?+LDwvyE8oGCMitM+EqhVepYQwePOxI9647Idmmd/2Y166vJupgmyimjWtf6o?=
 =?us-ascii?q?Bnzk2M7zZ8SvLP35sdwPGXwAuGVy39jFenvcD3gptJZS8dHmWh0yjoHo1Rab?=
 =?us-ascii?q?NofYYNF2iuJ9e7xtJkh57iQ3RY7kKsB0sa2M+1fhqfd1j93QxW1UQKrn2rgC?=
 =?us-ascii?q?i4wCJukzEvsKWf2DfDw/rtdBUZIG5HXmpigkn2IYiykd8aWFKkbw8zlBuq/U?=
 =?us-ascii?q?z63bRUpLxjL2nPRkdFZzD2IHt/Uqu0rbeCe9RA6I4ssSlOVeS8ZleaSqTjrB?=
 =?us-ascii?q?cAzyzjGG5el3gHcGSGs4v4k1Raj32QKHJo5C7VecZvyBPb//TGSPJR1yZATy?=
 =?us-ascii?q?59332fGFmmOPG78NOVidHHs+ajRySmTJIVbCq445mHsX6A+WByARC518u2k9?=
 =?us-ascii?q?njHBlyhTT3zPF2RC7Iq1D6eYCt2KOkZ7E0NnJ0DUPxvpIpUrp1lZE90dRJgi?=
 =?us-ascii?q?kX?=
X-IPAS-Result: =?us-ascii?q?A2CQBQBEdf5c/wHyM5BmHAEBAQQBAQcEAQGBZYFnKmpSM?=
 =?us-ascii?q?iiEFZI+NUwBAQEBAQEGgTV+iFOPI4FnCQEBAQEBAQEBAS0HAQIBAYRAAoJ0I?=
 =?us-ascii?q?zgTAQMBAQEEAQEBAQMBAWwcDII6KQGCZgEBAQECASMEET8CEAsOCgICJgICV?=
 =?us-ascii?q?wYBDAgBAYJTDD8BgXYFDw+nSn4zgk+CeIMfgUaBDCiLXRd4gQeBESeBVmAHL?=
 =?us-ascii?q?j6CYQQYgSwDAYMhglgEizZMiAaHLo0HagmCEYIbhCmMeAYbgiWLAIF5h32ND?=
 =?us-ascii?q?wSBKYVqkTUhgVgrCAIYCCEPO4JtCIISF4hhhVsjAzGBBQEBjEqCUQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jun 2019 15:21:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5AFL1op018603;
        Mon, 10 Jun 2019 11:21:02 -0400
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications
 [ver #4]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov>
Date:   Mon, 10 Jun 2019 11:21:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/19 10:17 AM, David Howells wrote:
> 
> Hi Al,
> 
> Here's a set of patches to add a general variable-length notification queue
> concept and to add sources of events for:
> 
>   (1) Mount topology events, such as mounting, unmounting, mount expiry,
>       mount reconfiguration.
> 
>   (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
>       errors (not complete yet).
> 
>   (3) Key/keyring events, such as creating, linking and removal of keys.
> 
>   (4) General device events (single common queue) including:
> 
>       - Block layer events, such as device errors
> 
>       - USB subsystem events, such as device/bus attach/remove, device
>         reset, device errors.
> 
> One of the reasons for this is so that we can remove the issue of processes
> having to repeatedly and regularly scan /proc/mounts, which has proven to
> be a system performance problem.  To further aid this, the fsinfo() syscall
> on which this patch series depends, provides a way to access superblock and
> mount information in binary form without the need to parse /proc/mounts.
> 
> 
> LSM support is included, but controversial:
> 
>   (1) The creds of the process that did the fput() that reduced the refcount
>       to zero are cached in the file struct.
> 
>   (2) __fput() overrides the current creds with the creds from (1) whilst
>       doing the cleanup, thereby making sure that the creds seen by the
>       destruction notification generated by mntput() appears to come from
>       the last fputter.
> 
>   (3) security_post_notification() is called for each queue that we might
>       want to post a notification into, thereby allowing the LSM to prevent
>       covert communications.
> 
>   (?) Do I need to add security_set_watch(), say, to rule on whether a watch
>       may be set in the first place?  I might need to add a variant per
>       watch-type.
> 
>   (?) Do I really need to keep track of the process creds in which an
>       implicit object destruction happened?  For example, imagine you create
>       an fd with fsopen()/fsmount().  It is marked to dissolve the mount it
>       refers to on close unless move_mount() clears that flag.  Now, imagine
>       someone looking at that fd through procfs at the same time as you exit
>       due to an error.  The LSM sees the destruction notification come from
>       the looker if they happen to do their fput() after yours.

I remain unconvinced that (1), (2), (3), and the final (?) above are a 
good idea.

For SELinux, I would expect that one would implement a collection of per 
watch-type WATCH permission checks on the target object (or to some 
well-defined object label like the kernel SID if there is no object) 
that allow receipt of all notifications of that watch-type for objects 
related to the target object, where "related to" is defined per watch-type.

I wouldn't expect SELinux to implement security_post_notification() at 
all.  I can't see how one can construct a meaningful, stable policy for 
it.  I'd argue that the triggering process is not posting the 
notification; the kernel is posting the notification and the watcher has 
been authorized to receive it.

> 
> 
> Design decisions:
> 
>   (1) A misc chardev is used to create and open a ring buffer:
> 
> 	fd = open("/dev/watch_queue", O_RDWR);
> 
>       which is then configured and mmap'd into userspace:
> 
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
> 	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> 	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
> 		   MAP_SHARED, fd, 0);
> 
>       The fd cannot be read or written (though there is a facility to use
>       write to inject records for debugging) and userspace just pulls data
>       directly out of the buffer.
> 
>   (2) The ring index pointers are stored inside the ring and are thus
>       accessible to userspace.  Userspace should only update the tail
>       pointer and never the head pointer or risk breaking the buffer.  The
>       kernel checks that the pointers appear valid before trying to use
>       them.  A 'skip' record is maintained around the pointers.
> 
>   (3) poll() can be used to wait for data to appear in the buffer.
> 
>   (4) Records in the buffer are binary, typed and have a length so that they
>       can be of varying size.
> 
>       This means that multiple heterogeneous sources can share a common
>       buffer.  Tags may be specified when a watchpoint is created to help
>       distinguish the sources.
> 
>   (5) The queue is reusable as there are 16 million types available, of
>       which I've used 4, so there is scope for others to be used.
> 
>   (6) Records are filterable as types have up to 256 subtypes that can be
>       individually filtered.  Other filtration is also available.
> 
>   (7) Each time the buffer is opened, a new buffer is created - this means
>       that there's no interference between watchers.
> 
>   (8) When recording a notification, the kernel will not sleep, but will
>       rather mark a queue as overrun if there's insufficient space, thereby
>       avoiding userspace causing the kernel to hang.
> 
>   (9) The 'watchpoint' should be specific where possible, meaning that you
>       specify the object that you want to watch.
> 
> (10) The buffer is created and then watchpoints are attached to it, using
>       one of:
> 
> 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
> 	mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
> 	sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);
> 
>       where in all three cases, fd indicates the queue and the number after
>       is a tag between 0 and 255.
> 
> (11) The watch must be removed if either the watch buffer is destroyed or
>       the watched object is destroyed.
> 
> 
> Things I want to avoid:
> 
>   (1) Introducing features that make the core VFS dependent on the network
>       stack or networking namespaces (ie. usage of netlink).
> 
>   (2) Dumping all this stuff into dmesg and having a daemon that sits there
>       parsing the output and distributing it as this then puts the
>       responsibility for security into userspace and makes handling
>       namespaces tricky.  Further, dmesg might not exist or might be
>       inaccessible inside a container.
> 
>   (3) Letting users see events they shouldn't be able to see.
> 
> 
> Further things that could be considered:
> 
>   (1) Adding a keyctl call to allow a watch on a keyring to be extended to
>       "children" of that keyring, such that the watch is removed from the
>       child if it is unlinked from the keyring.
> 
>   (2) Adding global superblock event queue.
> 
>   (3) Propagating watches to child superblock over automounts.
> 
> 
> The patches can be found here also:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications
> 
> Changes:
> 
>   v4: Split the basic UAPI bits out into their own patch and then split the
>       LSM hooks out into an intermediate patch.  Add LSM hooks for setting
>       watches.
> 
>       Rename the *_notify() system calls to watch_*() for consistency.
> 
>   v3: I've added a USB notification source and reformulated the block
>       notification source so that there's now a common watch list, for which
>       the system call is now device_notify().
> 
>       I've assigned a pair of unused ioctl numbers in the 'W' series to the
>       ioctls added by this series.
> 
>       I've also added a description of the kernel API to the documentation.
> 
>   v2: I've fixed various issues raised by Jann Horn and GregKH and moved to
>       krefs for refcounting.  I've added some security features to try and
>       give Casey Schaufler the LSM control he wants.
> 
> David
> ---
> David Howells (13):
>        security: Override creds in __fput() with last fputter's creds
>        uapi: General notification ring definitions
>        security: Add hooks to rule on setting a watch
>        security: Add a hook for the point of notification insertion
>        General notification queue with user mmap()'able ring buffer
>        keys: Add a notification facility
>        vfs: Add a mount-notification facility
>        vfs: Add superblock notifications
>        fsinfo: Export superblock notification counter
>        Add a general, global device notification watch list
>        block: Add block layer notifications
>        usb: Add USB subsystem notifications
>        Add sample notification program
> 
> 
>   Documentation/ioctl/ioctl-number.txt   |    1
>   Documentation/security/keys/core.rst   |   58 ++
>   Documentation/watch_queue.rst          |  492 ++++++++++++++++++
>   arch/x86/entry/syscalls/syscall_32.tbl |    3
>   arch/x86/entry/syscalls/syscall_64.tbl |    3
>   block/Kconfig                          |    9
>   block/blk-core.c                       |   29 +
>   drivers/base/Kconfig                   |    9
>   drivers/base/Makefile                  |    1
>   drivers/base/watch.c                   |   89 +++
>   drivers/misc/Kconfig                   |   13
>   drivers/misc/Makefile                  |    1
>   drivers/misc/watch_queue.c             |  889 ++++++++++++++++++++++++++++++++
>   drivers/usb/core/Kconfig               |   10
>   drivers/usb/core/devio.c               |   55 ++
>   drivers/usb/core/hub.c                 |    3
>   fs/Kconfig                             |   21 +
>   fs/Makefile                            |    1
>   fs/file_table.c                        |   12
>   fs/fsinfo.c                            |   12
>   fs/mount.h                             |   33 +
>   fs/mount_notify.c                      |  187 +++++++
>   fs/namespace.c                         |    9
>   fs/super.c                             |  122 ++++
>   include/linux/blkdev.h                 |   15 +
>   include/linux/dcache.h                 |    1
>   include/linux/device.h                 |    7
>   include/linux/fs.h                     |   79 +++
>   include/linux/key.h                    |    4
>   include/linux/lsm_hooks.h              |   48 ++
>   include/linux/security.h               |   35 +
>   include/linux/syscalls.h               |    5
>   include/linux/usb.h                    |   19 +
>   include/linux/watch_queue.h            |   87 +++
>   include/uapi/linux/fsinfo.h            |   10
>   include/uapi/linux/keyctl.h            |    1
>   include/uapi/linux/watch_queue.h       |  213 ++++++++
>   kernel/sys_ni.c                        |    7
>   samples/Kconfig                        |    6
>   samples/Makefile                       |    1
>   samples/vfs/test-fsinfo.c              |   13
>   samples/watch_queue/Makefile           |    9
>   samples/watch_queue/watch_test.c       |  308 +++++++++++
>   security/keys/Kconfig                  |   10
>   security/keys/compat.c                 |    2
>   security/keys/gc.c                     |    5
>   security/keys/internal.h               |   30 +
>   security/keys/key.c                    |   37 +
>   security/keys/keyctl.c                 |   95 +++
>   security/keys/keyring.c                |   17 -
>   security/keys/request_key.c            |    4
>   security/security.c                    |   29 +
>   52 files changed, 3121 insertions(+), 38 deletions(-)
>   create mode 100644 Documentation/watch_queue.rst
>   create mode 100644 drivers/base/watch.c
>   create mode 100644 drivers/misc/watch_queue.c
>   create mode 100644 fs/mount_notify.c
>   create mode 100644 include/linux/watch_queue.h
>   create mode 100644 include/uapi/linux/watch_queue.h
>   create mode 100644 samples/watch_queue/Makefile
>   create mode 100644 samples/watch_queue/watch_test.c
> 

