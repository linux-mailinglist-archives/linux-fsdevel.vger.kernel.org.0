Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89087FE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437153AbfHIQZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 12:25:44 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:41648 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfHIQZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:25:44 -0400
X-EEMSG-check-017: 7626218|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,364,1559520000"; 
   d="scan'208";a="7626218"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Aug 2019 16:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565367942; x=1596903942;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/w/smSUo4Br48A/U7NsOvak6LRZP4zk9FEXaScE8PBY=;
  b=IHnd0NE3gg2ubzvr3kSApsZIZqPFrokev4pCipjlkeY1JHwSIZwQS5OC
   Ackc7myaDgz6+t2nwkSE1esgOw6quf/UQ6lr8Y/TDmiB5Xdul48yUAmHH
   MJ/obf19pNweasfBxTSjWcA6Q45gbmpfc6tneFk1uuP34teKLH4W91qaZ
   dGUPDL7ECf4SNZlbShMnnmtpWWRqacTRxH58NKKhB4mx8d+NQVR0TzLUJ
   o0xULdwUE5b/Pmh23oZCulEEhI3rUFObOY8t8o3AzYklzTFhgG9omLT0R
   JgrhnYhCJAxFOzwVbTrM/4yFBaqlVziOB77hK3xlkSgnU7kdRsDyX8qBw
   w==;
X-IronPort-AV: E=Sophos;i="5.64,364,1559520000"; 
   d="scan'208";a="26638379"
IronPort-PHdr: =?us-ascii?q?9a23=3Aryx8bBdFU0dYeCUj5vRe9fQ0lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc25Zx2N2/xhgRfzUJnB7Loc0qyK6vqmADVfqsfQ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLq8UanIlvJqk1xx?=
 =?us-ascii?q?bNv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx/IgU+KqYziOTOey+UDs2+a7+V9S+2vj3MspgZrrTezyccsjY?=
 =?us-ascii?q?jJiZ8LxV3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?APsUXDAiD2mEL2gLWQdko44ein9/7rYrDnpp+YL4N0iwf+PboymsGnHOg1PQ?=
 =?us-ascii?q?cDU3Kb9OihzrHv40L0TKtQgvEriqXZtYrVJcUfpq63GQ9V1YMj5g6lADi639?=
 =?us-ascii?q?QYmngHI09bdx+ck4joO03BIPD/DfulhVSsiy1ky+rJPr3mHJXBNmLDn6v5fb?=
 =?us-ascii?q?Zh905czxI+wspa55JVELEMIvz+Wk71tNHDAR85Nha7w+fjCNlnyoweXmePCL?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8Nojn9Nvwl6uX2jXAjhF8debCl3Z4QaHC/BPRpPV?=
 =?us-ascii?q?+VbmbrgtcECW0KpBYxTPT2iF2eVj5ef22yULw45jE6DoKmEIjCS5uzgLyOwi?=
 =?us-ascii?q?i7BIdaZmNYBVCWF3fnaYGEV+0LaCKILc9riiYEWqS5S489yRGusxf3y75mLu?=
 =?us-ascii?q?rS5y0Zuovv1MNr6OLPiBEy7z10D9id0m2USmF0mX4HRyIy3K9hukF91FiD3r?=
 =?us-ascii?q?Zig/BCFtxc+elJUgEkOp7Y1eB6DMryWg3ZdNeTVFmmWsmmAS02Tt8px98OYk?=
 =?us-ascii?q?B9G8itjxza0SqqGKIamKKVBJMq9qLRxGbxJ8ljxHbczqUhjEcpQtFJNWK4gq?=
 =?us-ascii?q?5z7Q/TB5TGk0+Bjaalabwc3DLR9GeE1WeBoUFYUAl+UKrbWXAfYlDWoM/j5k?=
 =?us-ascii?q?zcUrCuCa4oMhdbxcGeLatKb8XjjU9aS/f7JNTef2Wxln+yBRmS2ryMb5Hne3?=
 =?us-ascii?q?4A3CXGFkcIiRwc/HeePwgkGiihu37eDCBpFV/3YUPs9O5+qGmhTk811AGHdE?=
 =?us-ascii?q?th2KCw+hELhPyQUfQT3qgLuC05sTV7AE69387KC9qHvwdheKRcYdUg4FZIzG?=
 =?us-ascii?q?7ZtBJyPoamL698gl4TaBp3v0zw2BVtEIlAktYlrGkszAVsLaKUylRBdymX3c?=
 =?us-ascii?q?O4BrqCA2zz5liAbKrawU3T0dDerq4K6e5n8FTnlA6sH0smtX5g1o8Rm0OV+5?=
 =?us-ascii?q?GCKQ0VS5+5Bl4+6hxSv7jHZmw44ITO2DtnNqzi4RHY3Nd8LeI/zRDoUNBePK?=
 =?us-ascii?q?6AXFv7GMIdBsSjAPA7kFiuKBQfNaZd87BibJDuTOePxKP+ZLUopzmhl2kSpd?=
 =?us-ascii?q?kmg08=3D?=
X-IPAS-Result: =?us-ascii?q?A2AbBwDonU1d/wHyM5BmHAEBAQQBAQcEAQGBZ4FpBSqBP?=
 =?us-ascii?q?gEyKoQej3QBAQEBAQaBCS2JaZEhCQEBAQEBAQEBATQBAgEBhD8CgmEjOBMBB?=
 =?us-ascii?q?AEBAQQBAQMBCQEBbIUzgjopAYJnAQIDIwQRPwIQCxgCAh8HAgJXBgEMBgIBA?=
 =?us-ascii?q?YJTDD+BdxSran8zhUmDN4FJgQwoi2QXeIEHgTiCNjU+g34SGIMnglgEjCSCN?=
 =?us-ascii?q?4VgXZYtCYIfi1yITQYbgjCHL4QUikWNUZoOIYFYKwgCGAghD4MngnqOKSMDM?=
 =?us-ascii?q?IEGAQGLNw0XB4IlAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Aug 2019 16:25:41 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x79GPe9O016728;
        Fri, 9 Aug 2019 12:25:40 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Amir Goldstein <amir73il@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
 <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <e69f95ba-3da7-380a-ef14-cc866172d79a@tycho.nsa.gov>
Date:   Fri, 9 Aug 2019 12:25:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/9/19 5:06 AM, Amir Goldstein wrote:
> On Thu, Aug 8, 2019 at 9:33 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Wed, Jul 31, 2019 at 11:35 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>> As of now, setting watches on filesystem objects has, at most, applied a
>>> check for read access to the inode, and in the case of fanotify, requires
>>> CAP_SYS_ADMIN. No specific security hook or permission check has been
>>> provided to control the setting of watches. Using any of inotify, dnotify,
>>> or fanotify, it is possible to observe, not only write-like operations, but
>>> even read access to a file. Modeling the watch as being merely a read from
>>> the file is insufficient for the needs of SELinux. This is due to the fact
>>> that read access should not necessarily imply access to information about
>>> when another process reads from a file. Furthermore, fanotify watches grant
>>> more power to an application in the form of permission events. While
>>> notification events are solely, unidirectional (i.e. they only pass
>>> information to the receiving application), permission events are blocking.
>>> Permission events make a request to the receiving application which will
>>> then reply with a decision as to whether or not that action may be
>>> completed. This causes the issue of the watching application having the
>>> ability to exercise control over the triggering process. Without drawing a
>>> distinction within the permission check, the ability to read would imply
>>> the greater ability to control an application. Additionally, mount and
>>> superblock watches apply to all files within the same mount or superblock.
>>> Read access to one file should not necessarily imply the ability to watch
>>> all files accessed within a given mount or superblock.
>>>
>>> In order to solve these issues, a new LSM hook is implemented and has been
>>> placed within the system calls for marking filesystem objects with inotify,
>>> fanotify, and dnotify watches. These calls to the hook are placed at the
>>> point at which the target path has been resolved and are provided with the
>>> path struct, the mask of requested notification events, and the type of
>>> object on which the mark is being set (inode, superblock, or mount). The
>>> mask and obj_type have already been translated into common FS_* values
>>> shared by the entirety of the fs notification infrastructure. The path
>>> struct is passed rather than just the inode so that the mount is available,
>>> particularly for mount watches. This also allows for use of the hook by
>>> pathname-based security modules. However, since the hook is intended for
>>> use even by inode based security modules, it is not placed under the
>>> CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
>>> modules would need to enable all of the path hooks, even though they do not
>>> use any of them.
>>>
>>> This only provides a hook at the point of setting a watch, and presumes
>>> that permission to set a particular watch implies the ability to receive
>>> all notification about that object which match the mask. This is all that
>>> is required for SELinux. If other security modules require additional hooks
>>> or infrastructure to control delivery of notification, these can be added
>>> by them. It does not make sense for us to propose hooks for which we have
>>> no implementation. The understanding that all notifications received by the
>>> requesting application are all strictly of a type for which the application
>>> has been granted permission shows that this implementation is sufficient in
>>> its coverage.
>>>
>>> Security modules wishing to provide complete control over fanotify must
>>> also implement a security_file_open hook that validates that the access
>>> requested by the watching application is authorized. Fanotify has the issue
>>> that it returns a file descriptor with the file mode specified during
>>> fanotify_init() to the watching process on event. This is already covered
>>> by the LSM security_file_open hook if the security module implements
>>> checking of the requested file mode there. Otherwise, a watching process
>>> can obtain escalated access to a file for which it has not been authorized.
>>>
>>> The selinux_path_notify hook implementation works by adding five new file
>>> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
>>> (descriptions about which will follow), and one new filesystem permission:
>>> watch (which is applied to superblock checks). The hook then decides which
>>> subset of these permissions must be held by the requesting application
>>> based on the contents of the provided mask and the obj_type. The
>>> selinux_file_open hook already checks the requested file mode and therefore
>>> ensures that a watching process cannot escalate its access through
>>> fanotify.
>>>
>>> The watch, watch_mount, and watch_sb permissions are the baseline
>>> permissions for setting a watch on an object and each are a requirement for
>>> any watch to be set on a file, mount, or superblock respectively. It should
>>> be noted that having either of the other two permissions (watch_reads and
>>> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
>>> permission. Superblock watches further require the filesystem watch
>>> permission to the superblock. As there is no labeled object in view for
>>> mounts, there is no specific check for mount watches beyond watch_mount to
>>> the inode. Such a check could be added in the future, if a suitable labeled
>>> object existed representing the mount.
>>>
>>> The watch_reads permission is required to receive notifications from
>>> read-exclusive events on filesystem objects. These events include accessing
>>> a file for the purpose of reading and closing a file which has been opened
>>> read-only. This distinction has been drawn in order to provide a direct
>>> indication in the policy for this otherwise not obvious capability. Read
>>> access to a file should not necessarily imply the ability to observe read
>>> events on a file.
>>>
>>> Finally, watch_with_perm only applies to fanotify masks since it is the
>>> only way to set a mask which allows for the blocking, permission event.
>>> This permission is needed for any watch which is of this type. Though
>>> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
>>> trust to root, which we do not do, and does not support least privilege.
>>>
>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>> ---
>>>   fs/notify/dnotify/dnotify.c         | 15 +++++++--
>>>   fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
>>>   fs/notify/inotify/inotify_user.c    | 13 ++++++--
>>>   include/linux/lsm_hooks.h           |  9 +++++-
>>>   include/linux/security.h            | 10 ++++--
>>>   security/security.c                 |  6 ++++
>>>   security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>>>   security/selinux/include/classmap.h |  5 +--
>>>   8 files changed, 120 insertions(+), 12 deletions(-)
>>
>> Other than Casey's comments, and ACK, I'm not seeing much commentary
>> on this patch so FS and LSM folks consider this your last chance - if
>> I don't hear any objections by the end of this week I'll plan on
>> merging this into selinux/next next week.
> 
> Please consider it is summer time so people may be on vacation like I was...
> 
> First a suggestion, take it or leave it.
> The name of the hook _notify() seems misleading to me.
> naming the hook security_path_watch() seems much more
> appropriate and matching the name of the constants FILE__WATCH
> used by selinux.
> 
> Few more comments below..
> 
>>
>>> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
>>> index 250369d6901d..87a7f61bc91c 100644
>>> --- a/fs/notify/dnotify/dnotify.c
>>> +++ b/fs/notify/dnotify/dnotify.c
>>> @@ -22,6 +22,7 @@
>>>   #include <linux/sched/signal.h>
>>>   #include <linux/dnotify.h>
>>>   #include <linux/init.h>
>>> +#include <linux/security.h>
>>>   #include <linux/spinlock.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/fdtable.h>
>>> @@ -288,6 +289,17 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>>>                  goto out_err;
>>>          }
>>>
>>> +       /*
>>> +        * convert the userspace DN_* "arg" to the internal FS_*
>>> +        * defined in fsnotify
>>> +        */
>>> +       mask = convert_arg(arg);
>>> +
>>> +       error = security_path_notify(&filp->f_path, mask,
>>> +                       FSNOTIFY_OBJ_TYPE_INODE);
>>> +       if (error)
>>> +               goto out_err;
>>> +
>>>          /* expect most fcntl to add new rather than augment old */
>>>          dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>>>          if (!dn) {
>>> @@ -302,9 +314,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>>>                  goto out_err;
>>>          }
>>>
>>> -       /* convert the userspace DN_* "arg" to the internal FS_* defines in fsnotify */
>>> -       mask = convert_arg(arg);
>>> -
>>>          /* set up the new_fsn_mark and new_dn_mark */
>>>          new_fsn_mark = &new_dn_mark->fsn_mark;
>>>          fsnotify_init_mark(new_fsn_mark, dnotify_group);
>>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>>> index a90bb19dcfa2..b83f27021f54 100644
>>> --- a/fs/notify/fanotify/fanotify_user.c
>>> +++ b/fs/notify/fanotify/fanotify_user.c
>>> @@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops = {
>>>   };
>>>
>>>   static int fanotify_find_path(int dfd, const char __user *filename,
>>> -                             struct path *path, unsigned int flags)
>>> +                             struct path *path, unsigned int flags, __u64 mask)
>>>   {
>>>          int ret;
>>> +       unsigned int obj_type;
>>>
>>>          pr_debug("%s: dfd=%d filename=%p flags=%x\n", __func__,
>>>                   dfd, filename, flags);
>>> @@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>>>
>>>          /* you can only watch an inode if you have read permissions on it */
>>>          ret = inode_permission(path->dentry->d_inode, MAY_READ);
>>> +       if (ret) {
>>> +               path_put(path);
>>> +               goto out;
>>> +       }
>>> +
>>> +       switch (flags & FANOTIFY_MARK_TYPE_BITS) {
>>> +       case FAN_MARK_MOUNT:
>>> +               obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
>>> +               break;
>>> +       case FAN_MARK_FILESYSTEM:
>>> +               obj_type = FSNOTIFY_OBJ_TYPE_SB;
>>> +               break;
>>> +       case FAN_MARK_INODE:
>>> +               obj_type = FSNOTIFY_OBJ_TYPE_INODE;
>>> +               break;
>>> +       default:
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
> 
> Sorry, I just can't stand this extra switch statement here.
> Please initialize obj_type at the very first switch statement in
> do_fanotify_mark() and pass it to fanotify_find_path().
> Preferably also make it a helper that returns either
> valid obj_type or <0 for error.
> 
> 
I have no problem moving the initialization of obj_type up one level to 
do_fanotify_mark(). I don't think that a helper is necessary at this 
juncture as this logic seems to only exist in one place. Should this 
change, then there would be merit to having a separate function.
>>> +
>>> +       ret = security_path_notify(path, mask, obj_type);
>>>          if (ret)
>>>                  path_put(path);
> 
> It is probably best to mask out FANOTIFY_EVENT_FLAGS
> when calling the hook. Although FAN_EVENT_ON_CHILD
> and FAN_ONDIR do map to corresponding FS_ constants,
> the security hooks from dnotify and inotify do not pass these
> flags, so the security module cannot use them as reliable
> information, so it will have to assume that they have been
> requested anyway.
> 
> Alternatively, make sure that dnotify/inotify security hooks
> always set these two flags, by fixing up and using the
> dnotify/inotify arg_to_mask conversion helpers before calling
> the security hook.
> 
I think that at this point either approach you mentioned makes just as 
much sense. If it's all the same to you, Amir, I'll just change the 
caller in fanotify to include (mask) & ~(FANOTIFY_EVENT_FLAGS)
>>> +
>>>   out:
>>>          return ret;
>>>   }
>>> @@ -1014,7 +1037,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>>>                  goto fput_and_out;
>>>          }
>>>
>>> -       ret = fanotify_find_path(dfd, pathname, &path, flags);
>>> +       ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
>>>          if (ret)
>>>                  goto fput_and_out;
>>>
>>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
>>> index 7b53598c8804..e0d593c2d437 100644
>>> --- a/fs/notify/inotify/inotify_user.c
>>> +++ b/fs/notify/inotify/inotify_user.c
>>> @@ -39,6 +39,7 @@
>>>   #include <linux/poll.h>
>>>   #include <linux/wait.h>
>>>   #include <linux/memcontrol.h>
>>> +#include <linux/security.h>
>>>
>>>   #include "inotify.h"
>>>   #include "../fdinfo.h"
>>> @@ -342,7 +343,8 @@ static const struct file_operations inotify_fops = {
>>>   /*
>>>    * find_inode - resolve a user-given path to a specific inode
>>>    */
>>> -static int inotify_find_inode(const char __user *dirname, struct path *path, unsigned flags)
>>> +static int inotify_find_inode(const char __user *dirname, struct path *path,
>>> +                                               unsigned int flags, __u64 mask)
>>>   {
>>>          int error;
>>>
>>> @@ -351,8 +353,15 @@ static int inotify_find_inode(const char __user *dirname, struct path *path, uns
>>>                  return error;
>>>          /* you can only watch an inode if you have read permissions on it */
>>>          error = inode_permission(path->dentry->d_inode, MAY_READ);
>>> +       if (error) {
>>> +               path_put(path);
>>> +               return error;
>>> +       }
>>> +       error = security_path_notify(path, mask,
>>> +                               FSNOTIFY_OBJ_TYPE_INODE);
>>>          if (error)
>>>                  path_put(path);
>>> +
>>>          return error;
>>>   }
>>>
>>> @@ -744,7 +753,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>>>          if (mask & IN_ONLYDIR)
>>>                  flags |= LOOKUP_DIRECTORY;
>>>
>>> -       ret = inotify_find_inode(pathname, &path, flags);
>>> +       ret = inotify_find_inode(pathname, &path, flags, mask);
> 
> Please use (mask & IN_ALL_EVENTS) for converting to common FS_ flags
> or use the inotify_arg_to_mask() conversion helper, which contains more
> details irrelevant for the security hook.
> Otherwise mask may contain flags like IN_MASK_CREATE, which mean
> different things on different backends and the security module cannot tell
> the difference.
> 
> Also note that at this point, before inotify_arg_to_mask(), the mask does
> not yet contain FS_EVENT_ON_CHILD, which could be interesting for
> the security hook (fanotify users can opt-in with FAN_EVENT_ON_CHILD).
> Not a big deal though as security hook can assume the worse
> (that events on child are requested).
> 
I'll use (mask & IN_ALL_EVENTS).
> Thanks,
> Amir.
> 

I can implement the changes in the ways I mentioned above. I don't see a 
need for anything more in the cases you brought up since none of them 
change the logic of the hook itself or would make a substantive 
difference to the operation of the hook given its current implementation.

-- 
Aaron
