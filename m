Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B1E7DA6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfHALjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 07:39:04 -0400
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:40043 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHALjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:39:04 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 07:39:03 EDT
X-EEMSG-check-017: 7178377|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="7178377"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA40.eemsg.mail.mil with ESMTP; 01 Aug 2019 11:31:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1564659115; x=1596195115;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ietWyA6ux13vDOA/KZIWzyZETEWUHnJEtSgCJnccnaA=;
  b=JqfhBOqBlKJcYsqi/ERZO1F/V9IPUFXN0niZOSe+DnpDp8GYR2cU9aGU
   OAuja/51BkgGonHVAFMz5Uu+4cVa1VPQpl4vMHo7dSalpOho5grfQmlQv
   NI2xggWFVLruZzkt/4B+yMV8hj03FiFmt3//vuw/4W/bWSO3EhPMrdgYp
   rcni5h3LkRnKQisoC8OStjYPC9PTcCYviPBxThD3rbkQ1fMd5eXSdaj+P
   FTrMc49rFDjBA2F81P81H6UMQe1JwCtGfDIp70XRjt/e5F/si6PmEJELE
   JmOVHyokW4r/T28NDQikCKFaHEZErQtB4ON0sfFqJjXyfnts9wE0dBnWC
   g==;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="26333716"
IronPort-PHdr: =?us-ascii?q?9a23=3AtYlGvBeyhcvIqB4FcitRNMQ6lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+ZhCN2/xhgRfzUJnB7Loc0qyK6vqmCDNLusjJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/Vu8QUjodvJKc8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXsxezAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/TW9ovyM6xacHuZ?=
 =?us-ascii?q?69ZCUKzJcnxxvba/CddIiI+B3jWeCMKjl7nHJoYK+zihm9/ES6yuDwS9O43E?=
 =?us-ascii?q?hFoyZbiNXAq3YA3AHJ5MedUPty5EKh1C6K1wDU9+5LP1g5lbHeK5492r4wkY?=
 =?us-ascii?q?cTsVjbEi/2hkr2iKiWe104+uey8eTnY6jmpoSGO49oigDxLqQumsulDeQ+Lg?=
 =?us-ascii?q?cORHSU9f651L3i+U31WLRKjvsonanFqJ3WOMsWq6GjDwJVz4ov8QizAji43N?=
 =?us-ascii?q?gCgHULNFdFdwiGj4jtNVHOOvf4DfKnjlS3jThr3OvLPqHhA5rRLnjDl63tfb?=
 =?us-ascii?q?Bm60FG0gYzwtdf54xMBrEbPP3zQlPxtMDfDhIhKwy72fvnCNFm24MGQ22PH6?=
 =?us-ascii?q?uZPLrXsV+P4eIvOfeDaJUJtzb6Lvgv/+TugmMhmV8BYamp2oMaZ2yiEfR9PU?=
 =?us-ascii?q?qYYWHhgswdHmcKpAU+UeLqiFmcXj5Jfnq9Q7gz6isnB4KhCIfJXpqtj6CZ3C?=
 =?us-ascii?q?enAp1WYXhLCkuSHnfsdoWEXeoMaS2JL89/nTwLS6KhR5Ui1R6wrg/6zaRoLu?=
 =?us-ascii?q?7O9i0fr5Lj28B/5/fPmhEq6Tx0E8Od3nmJT2F1mGMIWjA30LlkoUNj1liDzL?=
 =?us-ascii?q?J4g/1EFd1T/v9JVwA6OoPBz+x+Fd//QRzBftiXR1a8WNmmAi8+Tsg3w9AQZ0?=
 =?us-ascii?q?ZxAdKijgrM3yCyGb8ai6SLBIAo8qLbx3XxI8d9y3Db1KgullUmTNBPOnC4ia?=
 =?us-ascii?q?5h6QfTA5XEk1uWl6m0b6QQxi3N+3mZzWqIok5YVBR8UaLfXXAQfkHWt8j25l?=
 =?us-ascii?q?veT7+yDrQqKhZOyc6FKqpEdNLpiVFGROz4NdTEfW2+hmewCgyUxr+WcIXqfG?=
 =?us-ascii?q?Ad1j3HCEcYiwAT4WqGNQ8mCyejuW3RED9uGEn0Y0Px6ulxtmm3QVM1zguSdU?=
 =?us-ascii?q?1uy6K1+gIJhfybU/4cxLcEuCY7qzh2Elu93tbWBsGPpwpkZqpcYNc97E1b2m?=
 =?us-ascii?q?Lesgx3JoagILx6hl4CbwR3uFvj1xdyCoVHi8gqtnIqzBFpJKKeylxBci2X3Z?=
 =?us-ascii?q?HqNr3QMGny8wila7TK1VHGzNaW5qAP5ew8q1XiugGpC0Uj/2xk09ZLyXuc4I?=
 =?us-ascii?q?vFDA4JXJLvXUY46QJ6q6vZYiYj/YPU02NjMa2uvj/FwdIpC7ht9hH1R95CNO?=
 =?us-ascii?q?uhEwjoHoVOH8GzLMQykkWtKxcDO/pfsqUzOpXiP9CPw6O6dN1rnDu7g2BK+s?=
 =?us-ascii?q?gp2UuX+jtUUeXI1osLx/yCmwCOETz7iQHynNrwnNV/eTwKHme5gRPhDYpVa7?=
 =?us-ascii?q?w6KZ0HEk+yMsa3wZN4nJerVHlGog3wT2ga0dOkLELBJ2f22hddgAFO+y2q?=
X-IPAS-Result: =?us-ascii?q?A2A6AgDwzEJd/wHyM5BlHgEGBwaBVgYLAYFtKm1SMiqEH?=
 =?us-ascii?q?pAJAQEBAQEBBoE2fohlkR0JAQEBAQEBAQEBJw0BAgEBhEACglQjNwYOAQMBA?=
 =?us-ascii?q?QEEAQEBAQUBAWyFHgyCOikBgmYBAQEBAgEjBBE/AhALGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCUww/AYF2BQ8PrCF/M4QzAYEUgyeBQgaBDCiLYBd4gQeBESeCNjU+gkiBN?=
 =?us-ascii?q?hIYgyeCWASMWYgslg4JghyCH4Q9hHSIRQYbgi6HKIQOijSNQodRjR+FAyKBW?=
 =?us-ascii?q?CsIAhgIIQ87gmwfglqIToVbIwMwgQYBAYpODRcHgiUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Aug 2019 11:31:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x71BVowv016577;
        Thu, 1 Aug 2019 07:31:50 -0400
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
 <1c62c931-9441-4264-c119-d038b2d0c9b9@schaufler-ca.com>
 <CAHC9VhS6cfMw5ZUkOSov6hexh9QpnpKwipP7L7ZYGCVLCHGfFQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <66fbc35c-6cc8-bd08-9bf9-aa731dc3ff09@tycho.nsa.gov>
Date:   Thu, 1 Aug 2019 07:31:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS6cfMw5ZUkOSov6hexh9QpnpKwipP7L7ZYGCVLCHGfFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/19 8:27 PM, Paul Moore wrote:
> On Wed, Jul 31, 2019 at 1:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 7/31/2019 8:34 AM, Aaron Goidel wrote:
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
>>
>> I can't say that I accept your arguments that this is sufficient,
>> but as you point out, the SELinux team does, and if I want more
>> for Smack that's my fish to fry.
>>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> Thanks Aaron.  Thanks Casey.
> 
> I think we also want an ACK from the other LSMs, what say all of you?
> Can you live with the new security_path_notify() hook?
> 
> Aaron, you'll also need to put together a test for the
> selinux-testsuite to exercise this code.  If you already sent it to
> the list, my apologies but I don't see it anywhere.  If you get stuck
> on the test, let me know and I'll try to help out.
> 
> Oh, one more thing ...
> 
>>> +static int selinux_path_notify(const struct path *path, u64 mask,
>>> +                                             unsigned int obj_type)
>>> +{
>>> +     int ret;
>>> +     u32 perm;
>>> +
>>> +     struct common_audit_data ad;
>>> +
>>> +     ad.type = LSM_AUDIT_DATA_PATH;
>>> +     ad.u.path = *path;
>>> +
>>> +     /*
>>> +      * Set permission needed based on the type of mark being set.
>>> +      * Performs an additional check for sb watches.
>>> +      */
>>> +     switch (obj_type) {
>>> +     case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
>>> +             perm = FILE__WATCH_MOUNT;
>>> +             break;
>>> +     case FSNOTIFY_OBJ_TYPE_SB:
>>> +             perm = FILE__WATCH_SB;
>>> +             ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
>>> +                                             FILESYSTEM__WATCH, &ad);
>>> +             if (ret)
>>> +                     return ret;
>>> +             break;
>>> +     case FSNOTIFY_OBJ_TYPE_INODE:
>>> +             perm = FILE__WATCH;
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     // check if the mask is requesting ability to set a blocking watch
> 
> ... in the future please don't use "// XXX", use "/* XXX */" instead :)
> 
> Don't respin the patch just for this, but if you have to do it for
> some other reason please fix the C++ style comments.  Thanks.

This was discussed during the earlier RFC series but ultimately someone 
pointed to:
https://lkml.org/lkml/2016/7/8/625
where Linus blessed the use of C++/C99 style comments.  And checkpatch 
accepts them these days.

Obviously if you truly don't want them in the SELinux code, that's your 
call.  But note that all files now have at least one such comment as a 
result of the mass SPDX license headers that were added throughout the 
tree using that style.

> 
>>> +     if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
>>> +             perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
>>> +
>>> +     // is the mask asking to watch file reads?
>>> +     if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
>>> +             perm |= FILE__WATCH_READS; // check that permission as well
>>> +
>>> +     return path_has_perm(current_cred(), path, perm);
>>> +}
> 

