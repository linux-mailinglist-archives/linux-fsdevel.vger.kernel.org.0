Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14C764C4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfGJSjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 14:39:11 -0400
Received: from usfb19pa16.eemsg.mail.mil ([214.24.26.87]:19351 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfGJSjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:39:10 -0400
X-EEMSG-check-017: 217114496|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jul 2019 18:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562783947; x=1594319947;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tertWFHu7c0K8Wi1ZczguIWRnkVl2uYlTtjxzzE2u90=;
  b=Ev4q8slrjscCbHzX+mvJ42nPzH/Z2oRuXCfDyAQSBtLAJZH+sEZGI585
   7pXNmX+pQ78Z3dGbqKeh/tksWVP/zcw1T9VRSvzPoSgSV1L3dEkPCZObo
   x2zyCzdTuAndGGLqkT0KAdtGiG+GkvV59QnGrHdZtbDo+7QFrUEn1xTGF
   mEi1Yz0hjAMkg9hFkILViYRTL+2+ynHf2MW9j2B4qmxRNED/HPRrLETG4
   TiC8M0miuqRRwWHEofU2ikDcnKTfeeYnq4Bl0whsk96y+pwhng89Dfs+1
   YM1o+1DKkfECiVo+5HbnVX/EeXsBHiOnMnse4yMD3SJYobAmcym93EPV6
   w==;
X-IronPort-AV: E=Sophos;i="5.63,475,1557187200"; 
   d="scan'208";a="25574290"
IronPort-PHdr: =?us-ascii?q?9a23=3AXC0N0BeSUfK4bpLnwRpVJ1yylGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+ZRyN2/xhgRfzUJnB7Loc0qyK6vqmBTJLuMzR+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLucQbgIRuJrsvxh?=
 =?us-ascii?q?bKv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAmoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lo?=
 =?us-ascii?q?YTsEvfHi/2n1/6jKmKeUU/5uek8eHnYrTippOENo90jB/xMrg2l8CiDuk1PR?=
 =?us-ascii?q?ICUmiG9eimyrHu8lP1TK9XgvEul6nWqpHaJcAVpq6jBA9V154u6w2iADe9y9?=
 =?us-ascii?q?kYgXkGI05FeBKAlYTpPUrOL+riAfewhFSsji9nx+raMb35HpXNMn/Dna/9cr?=
 =?us-ascii?q?ln8E5T1goywMtE551ICrEOOu/zWkH1tNPGFB81KhC7zPz9BNph0YMeXHqFAr?=
 =?us-ascii?q?WFP6PKrV+I+uUvLvGUZIAPpTb9L+Mo5+b0gn8knV8RZKyp3ZwQaHCiAPtqOV?=
 =?us-ascii?q?mWYX3pgt0ZC2cFohI+TPD2iF2FSTNTfGi9X6Y95jE9FYKnApzORp6igLOfxi?=
 =?us-ascii?q?e3BJ5WaX5cClCKD3joc5+IW/AWaCKdOsVhiCALVaC9S4890hGjrAv6y7thLu?=
 =?us-ascii?q?rJ9SwUrInj28Zp6O3OjxEy9CB0DsSE32GISGF7g34IRzso061kv0x9xUmM0b?=
 =?us-ascii?q?Jij/xbC9NT/fVJXRk+NZLGyOx6Ed/yUBrbftiVUFamXsmmATYpQ9I1wt8OZV?=
 =?us-ascii?q?t9Gtq7ghDNxCqlHqEal6KVC5ww6a/cwXfxKNhny3rc16kukUMmQs1ROm2inK?=
 =?us-ascii?q?J/8BLTB4HRmUWDi6mqbbgc3DLK9Gqb0GWOvEZYUQBuXqXBWXAffVDbrc7n6U?=
 =?us-ascii?q?zfT7+hE6gnPhFdxs6FL6tAcsfpgkleRPf/JNTeZHq8m2WqChmUxbOBd5Hqe3?=
 =?us-ascii?q?gG3CrDEkQLjwES926cNQciHiehv37eDDt2GF31ZkPs8PN+pXG1Q081ywGHdE?=
 =?us-ascii?q?Jh17+v9R4UgfyQUe8c3rUBuC05sTV7AE69387KC9qHvwdhfqBcYdQn4Fdd1G?=
 =?us-ascii?q?LZrBdwPpq6IKBnmFEech57v0T01xV4Eo9Ai9QlrGs2zApuLqKVyFdBdzKe3Z?=
 =?us-ascii?q?DtNbzbM2ry8w61a67QxF7e1M2b+rkA6PsmsVXvpgKpGVQ483VhzdZV12GQ5p?=
 =?us-ascii?q?LQDAodAtrNVRMc/gN3tvnhaSk0+o3Q2GckZaK9qTLT88kiBOI4xBKtZZJUOe?=
 =?us-ascii?q?WPEwqkV4UzDtKpLqQFnFmlYxZMaOlZ+6k1M86Oa+qN2KntOv1p2j2hkzIDqJ?=
 =?us-ascii?q?h0z0ak7yNhTqvN2JEfzreT2Q7UeS37iQKars3vmY1CLQoXF267xDmsUJVdfY?=
 =?us-ascii?q?VubI0LDiGoOMTxydJg0c2+E0VE/UKuUgtVkPSifgCfOhmkgFxd?=
X-IPAS-Result: =?us-ascii?q?A2D8AAAZMCZd/wHyM5BlGwEBAQEDAQEBBwMBAQGBZ4FtK?=
 =?us-ascii?q?oE7ATIohByTKQEBAQEBAQaBCQglfohfkRQJAQEBAQEBAQEBNAECAQGEQAKCT?=
 =?us-ascii?q?iM4EwEDAQEBBAEBAQEEAQFshUiCOikBgmYBAQEBAgEjBBE/AgULCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBglMMP4F3BQ+uGn8zhUeDLIFHgQwoi18XeIEHgREnDIIqNT6Df?=
 =?us-ascii?q?hIYgyaCWASUDlqVAW0JghuCH4kliD0GG4IshyKEDIoojTCZUSGBWCsIAhgII?=
 =?us-ascii?q?Q+DJ4JNFxSOKSMDMIEGAQGMXIJDAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Jul 2019 18:39:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6AId4cQ025793;
        Wed, 10 Jul 2019 14:39:04 -0400
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, linux-kernel@vger.kernel.org
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
 <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8edfc3d7-9944-9aed-061b-b81f54ebddc3@tycho.nsa.gov>
Date:   Wed, 10 Jul 2019 14:39:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/19 12:38 PM, Casey Schaufler wrote:
> On 7/10/2019 6:34 AM, Aaron Goidel wrote:
>> As of now, setting watches on filesystem objects has, at most, applied a
>> check for read access to the inode, and in the case of fanotify, requires
>> CAP_SYS_ADMIN. No specific security hook or permission check has been
>> provided to control the setting of watches. Using any of inotify, dnotify,
>> or fanotify, it is possible to observe, not only write-like operations, but
>> even read access to a file. Modeling the watch as being merely a read from
>> the file is insufficient.
> 
> That's a very model-specific viewpoint. It is true for
> a fine-grained model such as SELinux, but not necessarily
> for a model with more traditional object definitions.
> I'm not saying you're wrong, I'm saying that stating it
> as a given assumes your model. You can do that all you want
> within SELinux, but it doesn't hold when you're talking
> about the LSM infrastructure.

I think you'll find that even for Smack, merely checking read access to 
the watched inode is insufficient for your purposes, because the watch 
permits more than just observing changes to the state of the inode.  The 
absence of a hook is a gap in LSM coverage, regardless of security 
model.  If you are just objecting to the wording choice, then I suppose 
that can be amended to "is insufficient for SELinux" or "is insufficient 
for some needs" or something.

> Have you coordinated this with the work that David Howells
> is doing on generic notifications?

We're following that work but to date it hasn't appeared to address 
dnotify/inotify/fanotify IIUC.  I think it is complementary; we are 
adding LSM control over an existing kernel notification mechanism while 
he is adding a new notification facility for other kinds of events along 
with corresponding LSM hooks.  It is consistent in that it provides a 
way to control setting of watches based on the watched object.

>> Furthermore, fanotify watches grant more power to
>> an application in the form of permission events. While notification events
>> are solely, unidirectional (i.e. they only pass information to the
>> receiving application), permission events are blocking. Permission events
>> make a request to the receiving application which will then reply with a
>> decision as to whether or not that action may be completed.
> 
> You're not saying why this is an issue.

It allows the watching application control over the process that is 
attempting the access.  Are you just asking for that to be stated more 
explicitly?

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
> 
> A reasonable approach. It would be *nice* if you had
> a look at the other security modules to see what they
> might need from such a hook or hook set.
> 
>> Fanotify further has the issue that it returns a file descriptor with the
>> file mode specified during fanotify_init() to the watching process on
>> event. This is already covered by the LSM security_file_open hook if the
>> security module implements checking of the requested file mode there.
> 
> How is this relevant?

It is part of ensuring complete control over fanotify.  Some existing 
security modules (like Smack, for example) currently do not perform this 
checking of the requested file mode and therefore are subject to this 
privilege escalation scenario through fanotify.  A watcher that only has 
read access to the file can get a read-write descriptor to it in this 
manner.  You may argue that this doesn't matter because fanotify 
requires CAP_SYS_ADMIN but even for Smack that isn't the same as 
CAP_MAC_OVERRIDE.

> 
>> The selinux_inode_notify hook implementation works by adding three new
>> file permissions: watch, watch_reads, and watch_with_perm (descriptions
>> about which will follow). The hook then decides which subset of these
>> permissions must be held by the requesting application based on the
>> contents of the provided mask. The selinux_file_open hook already checks
>> the requested file mode and therefore ensures that a watching process
>> cannot escalate its access through fanotify.
> 
> Thereby increasing the granularity of control available.

It isn't merely a question of granularity but also completeness and 
preventing privilege escalation.

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
>>   		goto out_err;
>>   	}
>>   
>> +	/*
>> +	 * convert the userspace DN_* "arg" to the internal FS_*
>> +	 * defined in fsnotify
>> +	 */
>> +	mask = convert_arg(arg);
>> +
>> +	error = security_inode_notify(inode, mask);
>> +	if (error)
>> +		goto out_err;
>> +
>>   	/* expect most fcntl to add new rather than augment old */
>>   	dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>>   	if (!dn) {
>> @@ -302,9 +313,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>>   		goto out_err;
>>   	}
>>   
>> -	/* convert the userspace DN_* "arg" to the internal FS_* defines in fsnotify */
>> -	mask = convert_arg(arg);
>> -
>>   	/* set up the new_fsn_mark and new_dn_mark */
>>   	new_fsn_mark = &new_dn_mark->fsn_mark;
>>   	fsnotify_init_mark(new_fsn_mark, dnotify_group);
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index a90bb19dcfa2..c0d9fa998377 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -528,7 +528,7 @@ static const struct file_operations fanotify_fops = {
>>   };
>>   
>>   static int fanotify_find_path(int dfd, const char __user *filename,
>> -			      struct path *path, unsigned int flags)
>> +			      struct path *path, unsigned int flags, __u64 mask)
>>   {
>>   	int ret;
>>   
>> @@ -567,8 +567,15 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>>   
>>   	/* you can only watch an inode if you have read permissions on it */
>>   	ret = inode_permission(path->dentry->d_inode, MAY_READ);
>> +	if (ret) {
>> +		path_put(path);
>> +		goto out;
>> +	}
>> +
>> +	ret = security_inode_notify(path->dentry->d_inode, mask);
>>   	if (ret)
>>   		path_put(path);
>> +
>>   out:
>>   	return ret;
>>   }
>> @@ -1014,7 +1021,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>>   		goto fput_and_out;
>>   	}
>>   
>> -	ret = fanotify_find_path(dfd, pathname, &path, flags);
>> +	ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
>>   	if (ret)
>>   		goto fput_and_out;
>>   
>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
>> index 7b53598c8804..47b079f20aad 100644
>> --- a/fs/notify/inotify/inotify_user.c
>> +++ b/fs/notify/inotify/inotify_user.c
>> @@ -39,6 +39,7 @@
>>   #include <linux/poll.h>
>>   #include <linux/wait.h>
>>   #include <linux/memcontrol.h>
>> +#include <linux/security.h>
>>   
>>   #include "inotify.h"
>>   #include "../fdinfo.h"
>> @@ -342,7 +343,8 @@ static const struct file_operations inotify_fops = {
>>   /*
>>    * find_inode - resolve a user-given path to a specific inode
>>    */
>> -static int inotify_find_inode(const char __user *dirname, struct path *path, unsigned flags)
>> +static int inotify_find_inode(const char __user *dirname, struct path *path,
>> +						unsigned int flags, __u64 mask)
>>   {
>>   	int error;
>>   
>> @@ -351,8 +353,14 @@ static int inotify_find_inode(const char __user *dirname, struct path *path, uns
>>   		return error;
>>   	/* you can only watch an inode if you have read permissions on it */
>>   	error = inode_permission(path->dentry->d_inode, MAY_READ);
>> +	if (error) {
>> +		path_put(path);
>> +		return error;
>> +	}
>> +	error = security_inode_notify(path->dentry->d_inode, mask);
>>   	if (error)
>>   		path_put(path);
>> +
>>   	return error;
>>   }
>>   
>> @@ -744,7 +752,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>>   	if (mask & IN_ONLYDIR)
>>   		flags |= LOOKUP_DIRECTORY;
>>   
>> -	ret = inotify_find_inode(pathname, &path, flags);
>> +	ret = inotify_find_inode(pathname, &path, flags, mask);
>>   	if (ret)
>>   		goto fput_and_out;
>>   
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 47f58cfb6a19..ef6b74938dd8 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
> 
> Hook description comment is missing.
> 
>> @@ -1571,6 +1571,7 @@ union security_list_options {
>>   	int (*inode_getxattr)(struct dentry *dentry, const char *name);
>>   	int (*inode_listxattr)(struct dentry *dentry);
>>   	int (*inode_removexattr)(struct dentry *dentry, const char *name);
>> +	int (*inode_notify)(struct inode *inode, u64 mask);
>>   	int (*inode_need_killpriv)(struct dentry *dentry);
>>   	int (*inode_killpriv)(struct dentry *dentry);
>>   	int (*inode_getsecurity)(struct inode *inode, const char *name,
>> @@ -1881,6 +1882,7 @@ struct security_hook_heads {
>>   	struct hlist_head inode_getxattr;
>>   	struct hlist_head inode_listxattr;
>>   	struct hlist_head inode_removexattr;
>> +	struct hlist_head inode_notify;
>>   	struct hlist_head inode_need_killpriv;
>>   	struct hlist_head inode_killpriv;
>>   	struct hlist_head inode_getsecurity;
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 659071c2e57c..50106fb9eef9 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -301,6 +301,7 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>>   void security_inode_getsecid(struct inode *inode, u32 *secid);
>>   int security_inode_copy_up(struct dentry *src, struct cred **new);
>>   int security_inode_copy_up_xattr(const char *name);
>> +int security_inode_notify(struct inode *inode, u64 mask);
>>   int security_kernfs_init_security(struct kernfs_node *kn_dir,
>>   				  struct kernfs_node *kn);
>>   int security_file_permission(struct file *file, int mask);
>> @@ -392,6 +393,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
>>   int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>>   int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>>   int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>> +
> 
> Please don't change whitespace unless it's directly adjacent to your code.
> 
>>   #else /* CONFIG_SECURITY */
>>   
>>   static inline int call_lsm_notifier(enum lsm_event event, void *data)
>> @@ -776,6 +778,11 @@ static inline int security_inode_removexattr(struct dentry *dentry,
>>   	return cap_inode_removexattr(dentry, name);
>>   }
>>   
>> +static inline int security_inode_notify(struct inode *inode, u64 mask)
>> +{
>> +	return 0;
>> +}
>> +
>>   static inline int security_inode_need_killpriv(struct dentry *dentry)
>>   {
>>   	return cap_inode_need_killpriv(dentry);
>> diff --git a/security/security.c b/security/security.c
>> index 613a5c00e602..57b2a96c1991 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1251,6 +1251,11 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
>>   	return evm_inode_removexattr(dentry, name);
>>   }
>>   
>> +int security_inode_notify(struct inode *inode, u64 mask)
>> +{
>> +	return call_int_hook(inode_notify, 0, inode, mask);
>> +}
>> +
>>   int security_inode_need_killpriv(struct dentry *dentry)
>>   {
>>   	return call_int_hook(inode_need_killpriv, 0, dentry);
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index c61787b15f27..1a37966c2978 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -92,6 +92,7 @@
>>   #include <linux/kernfs.h>
>>   #include <linux/stringhash.h>	/* for hashlen_string() */
>>   #include <uapi/linux/mount.h>
>> +#include <linux/fsnotify.h>
>>   
>>   #include "avc.h"
>>   #include "objsec.h"
>> @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>>   	return -EACCES;
>>   }
>>   
>> +static int selinux_inode_notify(struct inode *inode, u64 mask)
>> +{
>> +	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
> 
> We don't use // comments in the Linux kernel.
> 
>> +
>> +	struct common_audit_data ad;
>> +
>> +	ad.type = LSM_AUDIT_DATA_INODE;
>> +	ad.u.inode = inode;
>> +
>> +	// check if the mask is requesting ability to set a blocking watch
>> +	if (mask & (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | FS_ACCESS_PERM))
>> +		perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
>> +
>> +	// is the mask asking to watch file reads?
>> +	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
>> +		perm |= FILE__WATCH_READS; // check that permission as well
>> +
>> +	return inode_has_perm(current_cred(), inode, perm, &ad);
>> +}
>> +
>>   /*
>>    * Copy the inode security context value to the user.
>>    *
>> @@ -6797,6 +6818,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>   	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
>>   	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
>>   	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
>> +	LSM_HOOK_INIT(inode_notify, selinux_inode_notify),
>>   
>>   	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
>>   
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>> index 201f7e588a29..0654dd2fbebf 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -7,7 +7,7 @@
>>   
>>   #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
>>       "rename", "execute", "quotaon", "mounton", "audit_access", \
>> -    "open", "execmod"
>> +	"open", "execmod", "watch", "watch_with_perm", "watch_reads"
>>   
>>   #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>>       "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> 

