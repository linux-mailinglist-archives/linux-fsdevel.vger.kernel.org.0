Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1434937430
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfFFMcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 08:32:53 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:8578 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfFFMcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:32:53 -0400
X-EEMSG-check-017: 712922440|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,559,1557187200"; 
   d="scan'208";a="712922440"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jun 2019 12:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559824354; x=1591360354;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dHD02qUEn9l4gW8o1GuRfUenIeZceFNfpLCJZMeFyG8=;
  b=cGm1UbzpMZVgpBjy0PmiXnQ/V2N7hsa7l4T/f3tDGRgaJJuJMG5fHuDi
   4JciaQn5nl80GPuNLsSuVyg7ROorMdOZl/cdfFSmvlSVWBe/4qOUoWKbf
   RpQuA1NTtLBuAZjdsCtw2M0I75YmBufuApmaQ5tRDga7i8UpFqOGlG2ou
   PJQUmVFUKLAiTntYuwi6wwbTtiloEdEEQpSF+UeBiGZ5382cVDkm7eD9R
   jpOLal/LYKKV1W6PntztPHSNTZWr0G80GCbKrvHkCuTkBdwvUxeF27FkY
   X8brtYJDUopYL5EFUYRUqDWjw/WKf5Wcy4NfdkqvqcyUEBI7jNCw7vsgs
   A==;
X-IronPort-AV: E=Sophos;i="5.63,559,1557187200"; 
   d="scan'208";a="24461124"
IronPort-PHdr: =?us-ascii?q?9a23=3AuFX0Ah9CYkZ1bf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1e8RIJqq85mqBkHD//Il1AaPAdyCrasY16GL6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVmTaxe65+IRq5oAnetsQanJZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV4RcMiRntnuCc8yrAeup?=
 =?us-ascii?q?60YjIKyJI5yB7bcfCHdJKI4h3lWe2MIjl4nGpodK+wihu960StyvDwWtOq3F?=
 =?us-ascii?q?tFsCZJiMTAu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0U44Oeo8eXnYqj9ppOGK491ih3xMqQpmsClB+Q3Lh?=
 =?us-ascii?q?MOUHSB9eS51b3j+VX1QLRMjvIojqnUqI3WKMsUq6KjAwJZz5wv5wiwAju4yt?=
 =?us-ascii?q?gUgGELLFdfdxKGi4jpNUvOIPf9DfqnmFSjjSxryuvaPrzhHprNLn/DnK3nfb?=
 =?us-ascii?q?Zm8UFQ0gUzzddB555MELEOPOrzWlPttNzfFhI2Lgy0w+HpCdpj0oMeXXmPD7?=
 =?us-ascii?q?SDMKzMrFCI5vggI/WWaIAJvzb9LuAv5+Tygn8hhV8dYa6p0IMJaHC5BPRmJF?=
 =?us-ascii?q?6UYHvyjdcHEGcKoBAyTOjriF2ETD5SaGy+X6Um5jE0Eo6mEITDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1CDC3fnaYqEW/QMaC+JJs9hkzoEVaWuSo8v0hGuqQn6xKd9Ie?=
 =?us-ascii?q?rI+y0YspTj2MJy5+3JmhE47SZ0ANiF02GRU2F0mXsFSCMs06Bkv0N8ykyO0b?=
 =?us-ascii?q?NkjPxYD9NT+v1JUgMkOp7G1uB1F8r9VhjdcdeOTVasWs+mDi0pTtIt398OZF?=
 =?us-ascii?q?5wG9GjjhDFwiqrDKYZl6GQBJMv6a/cwXfxKNhny3rc16kukUMmQs1ROm2inK?=
 =?us-ascii?q?J/8BLTB4HRmUWDi6mqbbgc3DLK9Gqb12qBpl9YXxB2UajeQXAfZlXZrdHj6U?=
 =?us-ascii?q?LMVbOuD6ooMhdZw86YNqRKcsHpjUlBRPr7PNTeYmSxm3q/BBqRyLOMd5fldH?=
 =?us-ascii?q?sD3CrDDEgJiB4T/XmYOggkHCuhoHzRDCZoFV3xZ0Pg6+5+qGm0TkUs1QGFc1?=
 =?us-ascii?q?Vh16ap+h4SnfGcT/IT3rQZuCYusjl7Bk6939PNBtqeqApuYr9cbck+4FhZz2?=
 =?us-ascii?q?LZsRJyPpi6I6BlnF4efBx9v1ny2BVvFoVAjc8qoWsuzApzL6KYzVxAeyqD0p?=
 =?us-ascii?q?D0Pb3YNmry8Quxa67ZxF7eysya+qQR5/QirVXsogWpGlAl83V93Nlfy2Gc6Y?=
 =?us-ascii?q?nSDAoOTZLxVV469xtkqLDaeCk95oXU1XJ3MaSvrD/C1MwmBPE/xhajYdhfKq?=
 =?us-ascii?q?WEGxH2E8EAAMiuMuMqkUCzbh0YJOBS6LI0P8S+evuC2a6rOvtgnT2/gWRc/o?=
 =?us-ascii?q?9yzl+M9zB9Su7U35cJ2vSY3gyaWDfhiFeurNv6mZ5LZT4MBGqz0yvkC5BLZq?=
 =?us-ascii?q?10Y4kLDX2iI8qtxtVxn5TtQWJX9Ea/B1Ma38+kYR6Sb1373Q1N2kUbuH+nlj?=
 =?us-ascii?q?WizzxyjT4pqrGS3DLBw+v8bhoLIG1LS3d4jVfqP4e0i8oWXE+ybwgmjBGl/1?=
 =?us-ascii?q?r1x7BHpKRjKGneWV9IcDLrL2FmSaawrqCNY9NL6J8xtCVXV+O8YUqERbLnvx?=
 =?us-ascii?q?Qa1CbjTCNiw2UXfi+rtt3ZmAN3jGaGZCJ/rH3GdMV03j/F6dDcTOIX1T0DEm?=
 =?us-ascii?q?0wlzjNAXCuMt+o45OQlpHeoqa5TW3nS54AXzPsyNa7qCaj5WBsSSa6lvS3l8?=
 =?us-ascii?q?yvRRM2ygfnxtJqUmPOtx+6bY71gffpedl7d1VlUQevo/FxHZtzx85p38Ad?=
X-IPAS-Result: =?us-ascii?q?A2CEBAC5Bflc/wHyM5BlHAEBAQQBAQcEAQGBZYFnKmpRA?=
 =?us-ascii?q?TIohBSSPIEBAQEBAQEBBoEQJYlRjyKBZwkBAQEBAQEBAQEtBwECAQGEQAKCY?=
 =?us-ascii?q?yM4EwEDAQEBBAEBAQEDAQFsHAyCOikBgmYBAQEBAgEjBBE6BQIFCwsOCgICJ?=
 =?us-ascii?q?gICVwYBDAgBAYJTDD8BgXYFDw+maX4zgk+CeIMhgUaBDCiLWxd4gQeBEScMg?=
 =?us-ascii?q?UpnLj6CYQQYgSwDAYMhglgEizFMiAWHK40CagmCEIIbhCiMdAYbgiOKe4F2h?=
 =?us-ascii?q?3SNCgSBKYVpkSwhgVgrCAIYCCEPO4JtCIISF4hhhVsjAzGBBQEBjCqCUQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jun 2019 12:32:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x56CWTLU004553;
        Thu, 6 Jun 2019 08:32:29 -0400
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
Date:   Thu, 6 Jun 2019 08:32:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/19 5:41 AM, David Howells wrote:
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


I'm not in favor of this approach. Can we check permission to the object 
being watched when a watch is set (read-like access), make sure every 
access that can trigger a notification requires a (write-like) 
permission to the accessed object, and make sure there is some sane way 
to control the relationship between the accessed object and the watched 
object (write-like)?  For cases where we have no object per se or at 
least no security structure/label associated with it, we may have to 
fall back to a coarse-grained "Can the watcher get this kind of 
notification in general?".

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
> David Howells (10):
>        security: Override creds in __fput() with last fputter's creds
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
>   drivers/base/notify.c                  |   82 +++
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
>   fs/mount_notify.c                      |  180 ++++++
>   fs/namespace.c                         |    9
>   fs/super.c                             |  116 ++++
>   include/linux/blkdev.h                 |   15 +
>   include/linux/dcache.h                 |    1
>   include/linux/device.h                 |    7
>   include/linux/fs.h                     |   79 +++
>   include/linux/key.h                    |    4
>   include/linux/lsm_hooks.h              |   15 +
>   include/linux/security.h               |   14 +
>   include/linux/syscalls.h               |    5
>   include/linux/usb.h                    |   19 +
>   include/linux/watch_queue.h            |   87 +++
>   include/uapi/linux/fsinfo.h            |   10
>   include/uapi/linux/keyctl.h            |    1
>   include/uapi/linux/watch_queue.h       |  213 ++++++++
>   kernel/sys_ni.c                        |    7
>   mm/interval_tree.c                     |    2
>   mm/memory.c                            |    1
>   samples/Kconfig                        |    6
>   samples/Makefile                       |    1
>   samples/vfs/test-fsinfo.c              |   13
>   samples/watch_queue/Makefile           |    9
>   samples/watch_queue/watch_test.c       |  310 +++++++++++
>   security/keys/Kconfig                  |   10
>   security/keys/compat.c                 |    2
>   security/keys/gc.c                     |    5
>   security/keys/internal.h               |   30 +
>   security/keys/key.c                    |   37 +
>   security/keys/keyctl.c                 |   88 +++
>   security/keys/keyring.c                |   17 -
>   security/keys/request_key.c            |    4
>   security/security.c                    |    9
>   54 files changed, 3025 insertions(+), 38 deletions(-)
>   create mode 100644 Documentation/watch_queue.rst
>   create mode 100644 drivers/base/notify.c
>   create mode 100644 drivers/misc/watch_queue.c
>   create mode 100644 fs/mount_notify.c
>   create mode 100644 include/linux/watch_queue.h
>   create mode 100644 include/uapi/linux/watch_queue.h
>   create mode 100644 samples/watch_queue/Makefile
>   create mode 100644 samples/watch_queue/watch_test.c
> 

