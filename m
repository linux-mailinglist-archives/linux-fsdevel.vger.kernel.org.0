Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D764B71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfGJR0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 13:26:01 -0400
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:12144 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJR0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:26:01 -0400
X-EEMSG-check-017: 413881465|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jul 2019 17:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562779559; x=1594315559;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vZSg+Rw93WI+lOcTzCOVR/6YKb1K3YqMXaMwu/Cdv0I=;
  b=lrEazAhljlK2PrabQr8ts0gPDqn32LNE6xTK8LwRXLf8nZRs+Ceo+Eef
   /LLrSvXzF/PNWbrWkJngqxHjrPXPqrbhPpMFS4NVl6d2VPPUYVSEVGwFV
   AUF8ovS4oZTZ1UiMSIdBPFzLEQp3WVqaTccRn9YG/NvisibKj5XgNorP2
   LZpggEVHjT7GPFzO2/JVs9CQu6jVSMG5Q+/OLr2ldhcEn0Iw6hFMOyZdO
   /4HthZ3ULTzOdyGUylYmfGflX8Vh8ms6d5PTmb95Q2gPtfgj6Qz5W6daj
   CAJaV6/hSyhv1rtXeFemMRffg3P4DPvEcxTxnhJLAM12db/2sz7BkKRyK
   A==;
X-IronPort-AV: E=Sophos;i="5.63,475,1557187200"; 
   d="scan'208";a="25569785"
IronPort-PHdr: =?us-ascii?q?9a23=3AGTu32BA1rgsxqZIJMEcPUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP34p8mwAkXT6L1XgUPTWs2DsrQY0rCQ7/6rADVaqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5sIBmsogjct8YajZZ/Jqov1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VUiGBnfjlWXr4zuIjKb1uMMs2eG8eVgUf+khmk9pA5trTivwcYshZ?=
 =?us-ascii?q?TXiY8O1lDF9Tl2wIYyJdGiTk57esSrHIFftyGdKYt7W8UvSHxrtiYi0rAKpJ?=
 =?us-ascii?q?G2cScQxJkn2hLTceKLfoeW7h75SeqcJypzimh/d7KlnRmy9FCtyuj7Vsapzl?=
 =?us-ascii?q?lHtjFFktzQtnAV0BzT99SHRuN9/ki/3TaP0Bje6v1eLkAulKrbNoUhzqQslp?=
 =?us-ascii?q?sTrUvDHij2lF/wjKCKbUUr5vKk6+HmYrXivpOcNol0hR/iMqk2h8CyDus1Ph?=
 =?us-ascii?q?IOUmSG4+iwyrLu8VPjTLlXlvE2l7PWsJHeJcQVvK65BApV35455BmjADem19?=
 =?us-ascii?q?UYkmQZI19eZBKGj5TmO1HJIPziC/e/mE6jnC1kx/DBIL3tGo/NIWTbkLf9Yb?=
 =?us-ascii?q?Z97FZRxxA2zdBe/ZJZCL8MIPP3WkLqu9zYCwU2Mw2ww+r9FNp90YYeU3qVAq?=
 =?us-ascii?q?CFKKPSrUOI5uU3LumUfoAVpTL9JuM95/H0kH85nUYRfayu3ZsQcnC3AO5qLF?=
 =?us-ascii?q?meYXrpmt0BC3sFvhIiTOz2j12PSSVTaGi2X6I94DE7FY2nAJzdRoCinrOBxj?=
 =?us-ascii?q?23Hp5IaWBcDFCDD3Poe5+DW/cWZyKYOtVhnSAcVbi9V48h0gmjtAv7y7phM+?=
 =?us-ascii?q?rV9TQUtYn929dp+u3TjxAy9SB0DsiE1mGNSHx7nn4MRzAox61/v0N9xUmZ0a?=
 =?us-ascii?q?RigPxXC8ZT5/VXXQc+L5LcyPZ6C9/qUALbYtiJUEqmQsmhATwpStIxwtkOY1?=
 =?us-ascii?q?tyGtm7gBDDxDelDKELl7OVAJw56bzc33fvKMZn0XrG17cuj0MgQsRRMW2qnK?=
 =?us-ascii?q?l/9xLcB4TRiUWWi76qdbgA3C7K7GqM0GqOvEZWUQFuVaXFWWsfa1DMrdvn+0?=
 =?us-ascii?q?zCT6WhCag9PgRdzs6CL7NAasf1glVeWPfjJNPebnqzm2iqGRmIxaiBbJH3e2?=
 =?us-ascii?q?UGwirRElQLkgEL93acKQc+Hjuho37ZDDF2F1LvZkTs8fNkqHO6VU851AeKYF?=
 =?us-ascii?q?dk17Wr+x4Zn/ucS+kc3rgcoicuty10HEqh39LRE9eAowthfKNBYdIy+VtH1n?=
 =?us-ascii?q?zWtxZ7PpO+K6BvnUAecwtpsEP0zRl3CZtPkdIsrHw0yAp+M6WY0ElOd2DQ4Z?=
 =?us-ascii?q?elE7jWMCHd+xSjcLLb21eWhN+T+71Qs/U8g1rmtQCtUEEl9iM0/cNS1i6174?=
 =?us-ascii?q?/NCkI9VpP9X0J/oxFxqLbbbiQV+5Lf1XoqN7K99DDFxYR6V6Me1h+8coIHY+?=
 =?us-ascii?q?u/HwjoHphfXpX/JQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C2AACOHiZd/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WwqgTsBMiiEHJJdTQEBAQEBAQaBCQgliV2RFAkBAQEBAQEBAQE0AQIBAYRAA?=
 =?us-ascii?q?oJOIzcGDgEDAQEBBAEBAQEEAQFshUiCOikBgmYBAQEBAgEjBBE/AgULCxgCA?=
 =?us-ascii?q?h8HAgJXBg0GAgEBglMMP4F3BQ+uCX8zhUeDLIFHgQwoAYteF3iBB4E4DIIqN?=
 =?us-ascii?q?T6DfhIYgyaCWASMGIInhimVbgmCG4tEiD0GG4Isiy6KKKcAIoFYKwgCGAghD?=
 =?us-ascii?q?4MngRGBZ44pIwMwgQYBAYxcgkMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jul 2019 17:25:57 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6AHPujT002820;
        Wed, 10 Jul 2019 13:25:57 -0400
Subject: Re: [Non-DoD Source] Re: [RFC PATCH] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
 <CAOQ4uxhKP9AUHqYN24ELP5OcyaJQcpS9hdzuZOm5uJpokFAXvg@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <d6dd622a-6371-d69a-f925-58ba9893edb0@tycho.nsa.gov>
Date:   Wed, 10 Jul 2019 13:25:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhKP9AUHqYN24ELP5OcyaJQcpS9hdzuZOm5uJpokFAXvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/19 10:55 AM, Amir Goldstein wrote:
> On Wed, Jul 10, 2019 at 4:34 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>
>> As of now, setting watches on filesystem objects has, at most, applied a
>> check for read access to the inode, and in the case of fanotify, requires
>> CAP_SYS_ADMIN. No specific security hook or permission check has been
>> provided to control the setting of watches. Using any of inotify, dnotify,
>> or fanotify, it is possible to observe, not only write-like operations, but
>> even read access to a file. Modeling the watch as being merely a read from
>> the file is insufficient. Furthermore, fanotify watches grant more power to
>> an application in the form of permission events. While notification events
>> are solely, unidirectional (i.e. they only pass information to the
>> receiving application), permission events are blocking. Permission events
>> make a request to the receiving application which will then reply with a
>> decision as to whether or not that action may be completed.
>>
>> In order to solve these issues, a new LSM hook is implemented and has been
>> placed within the system calls for marking filesystem objects with inotify,
>> fanotify, and dnotify watches. These calls to the hook are placed at the
>> point at which the target inode has been resolved and are provided with
>> both the inode and the mask of requested notification events. The mask has
>> already been translated into common FS_* values shared by the entirety of
>> the fs notification infrastructure.
>>
>> This only provides a hook at the point of setting a watch, and presumes
>> that permission to set a particular watch implies the ability to receive
>> all notification about that object which match the mask. This is all that
>> is required for SELinux. If other security modules require additional hooks
>> or infrastructure to control delivery of notification, these can be added
>> by them. It does not make sense for us to propose hooks for which we have
>> no implementation. The understanding that all notifications received by the
>> requesting application are all strictly of a type for which the application
>> has been granted permission shows that this implementation is sufficient in
>> its coverage.
>>
>> Fanotify further has the issue that it returns a file descriptor with the
>> file mode specified during fanotify_init() to the watching process on
>> event. This is already covered by the LSM security_file_open hook if the
>> security module implements checking of the requested file mode there.
>>
>> The selinux_inode_notify hook implementation works by adding three new
>> file permissions: watch, watch_reads, and watch_with_perm (descriptions
>> about which will follow). The hook then decides which subset of these
>> permissions must be held by the requesting application based on the
>> contents of the provided mask. The selinux_file_open hook already checks
>> the requested file mode and therefore ensures that a watching process
>> cannot escalate its access through fanotify.
>>
>> The watch permission is the baseline permission for setting a watch on an
>> object and is a requirement for any watch to be set whatsoever. It should
>> be noted that having either of the other two permissions (watch_reads and
>> watch_with_perm) does not imply the watch permission, though this could be
>> changed if need be.
>>
>> The watch_reads permission is required to receive notifications from
>> read-exclusive events on filesystem objects. These events include accessing
>> a file for the purpose of reading and closing a file which has been opened
>> read-only. This distinction has been drawn in order to provide a direct
>> indication in the policy for this otherwise not obvious capability. Read
>> access to a file should not necessarily imply the ability to observe read
>> events on a file.
>>
>> Finally, watch_with_perm only applies to fanotify masks since it is the
>> only way to set a mask which allows for the blocking, permission event.
>> This permission is needed for any watch which is of this type. Though
>> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
>> trust to root, which we do not do, and does not support least privilege.
>>
>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>> ---
>>   fs/notify/dnotify/dnotify.c         | 14 +++++++++++---
>>   fs/notify/fanotify/fanotify_user.c  | 11 +++++++++--
>>   fs/notify/inotify/inotify_user.c    | 12 ++++++++++--
>>   include/linux/lsm_hooks.h           |  2 ++
>>   include/linux/security.h            |  7 +++++++
>>   security/security.c                 |  5 +++++
>>   security/selinux/hooks.c            | 22 ++++++++++++++++++++++
>>   security/selinux/include/classmap.h |  2 +-
>>   8 files changed, 67 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
>> index 250369d6901d..e91ce092efb1 100644
>> --- a/fs/notify/dnotify/dnotify.c
>> +++ b/fs/notify/dnotify/dnotify.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/sched/signal.h>
>>   #include <linux/dnotify.h>
>>   #include <linux/init.h>
>> +#include <linux/security.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/slab.h>
>>   #include <linux/fdtable.h>
>> @@ -288,6 +289,16 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>>                  goto out_err;
>>          }
>>
>> +       /*
>> +        * convert the userspace DN_* "arg" to the internal FS_*
>> +        * defined in fsnotify
>> +        */
>> +       mask = convert_arg(arg);
>> +
>> +       error = security_inode_notify(inode, mask);
>> +       if (error)
>> +               goto out_err;
>> +
>>          /* expect most fcntl to add new rather than augment old */
>>          dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>>          if (!dn) {
>> @@ -302,9 +313,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>>                  goto out_err;
>>          }
>>
>> -       /* convert the userspace DN_* "arg" to the internal FS_* defines in fsnotify */
>> -       mask = convert_arg(arg);
>> -
>>          /* set up the new_fsn_mark and new_dn_mark */
>>          new_fsn_mark = &new_dn_mark->fsn_mark;
>>          fsnotify_init_mark(new_fsn_mark, dnotify_group);
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index a90bb19dcfa2..c0d9fa998377 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -528,7 +528,7 @@ static const struct file_operations fanotify_fops = {
>>   };
>>
>>   static int fanotify_find_path(int dfd, const char __user *filename,
>> -                             struct path *path, unsigned int flags)
>> +                             struct path *path, unsigned int flags, __u64 mask)
>>   {
>>          int ret;
>>
>> @@ -567,8 +567,15 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>>
>>          /* you can only watch an inode if you have read permissions on it */
>>          ret = inode_permission(path->dentry->d_inode, MAY_READ);
>> +       if (ret) {
>> +               path_put(path);
>> +               goto out;
>> +       }
>> +
>> +       ret = security_inode_notify(path->dentry->d_inode, mask);
>>          if (ret)
>>                  path_put(path);
>> +
>>   out:
>>          return ret;
>>   }
>> @@ -1014,7 +1021,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>>                  goto fput_and_out;
>>          }
>>
>> -       ret = fanotify_find_path(dfd, pathname, &path, flags);
>> +       ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
>>          if (ret)
>>                  goto fput_and_out;
>>
> 
> So the mark_type doesn't matter to SELinux?

Good catch regarding the mark_type, I overlooked that as an issue. The 
recursive setting of watches--for everything under the mount, in the 
case of the mount type, and for all the contents of the 
superblock--warrants further security checks.

> You have no need for mount_noitify and sb_notify hooks?

While I fully agree that there needs to be separate logic to handle 
security checks for inode, mount, and superblock notifications, I don't 
see the need for additional hooks. I believe that it would be sufficient 
to pass down the mark_type into the existing hook and create two new 
permissions--one for watching sb's and the other for mounts--which will 
be checked based on the type.

> A watch permission on the mount/sb root inode implies permission
> (as CAP_SYS_ADMIN) to watch all events in mount/sb?

This would be true for the new watch_mount and watch_sb permissions. In 
the case of sb's we can also apply check against the sb security label. 
For mounts there is no other security information, so there's likely no 
reason to pass it to the hook. Hence, my reasoning for editing the 
existing hook in favor of creating new ones.

> 
> [...]
> 
>> +static int selinux_inode_notify(struct inode *inode, u64 mask)
>> +{
>> +       u32 perm = FILE__WATCH; // basic permission, can a watch be set?
>> +
>> +       struct common_audit_data ad;
>> +
>> +       ad.type = LSM_AUDIT_DATA_INODE;
>> +       ad.u.inode = inode;
>> +
>> +       // check if the mask is requesting ability to set a blocking watch
>> +       if (mask & (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | FS_ACCESS_PERM))
> 
> Better ALL_FSNOTIFY_PERM_EVENTS

Thanks, you will see this in v2!

> 
> Thanks,
> Amir.

-- 
Aaron
