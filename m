Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0636A8A216
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHLPQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 11:16:15 -0400
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:37148 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfHLPQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:16:15 -0400
X-EEMSG-check-017: 4177337|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,377,1559520000"; 
   d="scan'208";a="4177337"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Aug 2019 15:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565622968; x=1597158968;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oLXSOup7D9SbGeHFA+Z9b7rEN1zW79SLimwJPsZH2bM=;
  b=iSzVIOVbmWuJ79HS4vVOL0lbxJgKOQl/RmzjQPBjSrBzJaVYPVahbz1R
   J4CjvZOWBZiu0ToFlptGL/nZqGHFnwzkmE1YvpXMF7gvTtuPhq/qVwzOp
   74+/VURt/yVUbRLl/Rxoj9iwubGigwQs3OqZK9QUSw48Ov00sSuGr70aK
   chcglAPf/ik1XQPvvDbC1opjmXHkJcpGEG8R7QfCgBuIUZoKOVjlvFbMg
   FgvkQytliqrY1k6IB4h/xHqqYjW8fVoaW0KrHhOvKzVVz/FCOloszyDYn
   pe2SECsPWkN3YvtTbIPSd4zenH+AStZ1sKIFj0/5sEcekwsU/hSS93GqQ
   w==;
X-IronPort-AV: E=Sophos;i="5.64,377,1559520000"; 
   d="scan'208";a="26691771"
IronPort-PHdr: =?us-ascii?q?9a23=3AEEADOBGF6ahE5Tzd/jjuPJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pMWzbnLW6fgltlLVR4KTs6sC17OM9fm6BSdQvN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdutcZjIdtKas8yg?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEzGgzflFWQrorlNC6U2OQKsmiU8vRvVeaygGMgsQ5+vjevxsAtio?=
 =?us-ascii?q?bUmI0Y0UzE9CVlz4Y1It20Ukh7YcW+H5dKuCGaMJV2T9okTmp1uyg60qULtY?=
 =?us-ascii?q?O0cSUF0pgqxwPTZ+aZf4WH/B7vTvudLDFlj3x/Yr2/nQy98U24x+35Ucm7zU?=
 =?us-ascii?q?hFozJektnJqnANzxvT6tWbSvdl/keuxzKP1wfL5+FYO080j6vbK4M6wrIqip?=
 =?us-ascii?q?oSsVjMHi/xmEnsiq+Zal4k9fSy5+TiY7XmooeQN45yig7gLqQjgtGzDOs3Pw?=
 =?us-ascii?q?QUX2WX5P6w2KPs8EHnWrlGk+U6kqzDv5DbIcQbqLS5AwhQ0os78RmwEzim0N?=
 =?us-ascii?q?MZnXYaMl1IYw6Hjoj1NFHOJ/D0F/G/g0+2nztxyPDGOaPhDo3XLnffiLfhYa?=
 =?us-ascii?q?p960lExQor199f+pZUB6oZIP3pR0/xsMXUDho+Mwyz2eboFs9x2Z8ZWWKKGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfJQVtyj5K/gk4f7ukHA4lEQDfammw5QXcmq0Hvd4LE?=
 =?us-ascii?q?WDZ3rjnNMBHX0NvgokQ+zgkEeCXiJLZ3auQ6I84Sk2CIanDYfFW4Csj6WN3D?=
 =?us-ascii?q?ylEZJKe2BGEFGMEWvodomdXvcMbz+dItJlkjMaTrWhVYAh2g+0tAPgyLpoMP?=
 =?us-ascii?q?DU+isGupLnztR14PfTlR4q/zxuE8udy32NT31znm4QQz823aZ/oVFyy1ua36?=
 =?us-ascii?q?h4mOFXGsJN5/xXVgc3LoDcz+NkBNDoQA7BfcmGSEygQtq4BTE9VNUxw8UBY0?=
 =?us-ascii?q?xlAdWtkgjD3za2A78Sj7GEGZw08qXS3nfvI8Z9z23G2bI7j1Y4X8RPNXephr?=
 =?us-ascii?q?Jl+wfPAI7Jll2Tl7y2eqQEwC7N6GCDwHKMvE5CTAFwUr7IXWsCZkvNs9v1/F?=
 =?us-ascii?q?/NTr62A7Q9LgRB0dKCKrdNatDxl1pGQfbjOM7cbm+/mmewAQ2FxryJbIXwem?=
 =?us-ascii?q?Ud2D/RB1QDkwAW5XyGLxQxBj+9o2LCCzxjDVDvY0br8elksnO7T1Q0whqMb0?=
 =?us-ascii?q?J70rq65B8VieabS/MJ0bIOoD0hpClsHFahw9LWDMKNpw5gfKVafNM8705L1W?=
 =?us-ascii?q?HHuAxnOJyvMaRii0UAcwR4oUzuzQ97CoZensgwqnMl0g5yJbif0FNbeDOSxY?=
 =?us-ascii?q?rwNaHPKmnu4BCvbLbb1U3E39aN5KgO6O81q07/swGpDEUi7ntn091L3HuG/5?=
 =?us-ascii?q?nFEBAdXYjtXUYw8hgp743dNxE0+oec8HprK6T85ifLxtYBHOI4zlOleNBFPe?=
 =?us-ascii?q?WPEwqkV4UhG8W2KOEs02OsZxYAMfEaoLU4JOu6ZvCG3+itJ+8mkzW42zdp+o?=
 =?us-ascii?q?d4h2uF7S16AsHP3poIx7nM1wCIUDbwgX+9o8v3nsZCfjhUEW2hn3u3TLVNb7?=
 =?us-ascii?q?F/KN5YQVylJNe6k5An3M/g?=
X-IPAS-Result: =?us-ascii?q?A2A8CAAqglFd/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoE/M?=
 =?us-ascii?q?iqEHo92AQEGgTaJapEhCQEBAQEBAQEBATQBAgEBhD8Cgm4jOBMBBAEBAQQBA?=
 =?us-ascii?q?QMBCQEBbIUzgjopAYJnAQIDIwQRDzACEAsYAgIfBwICVwYBDAYCAQGCUww/g?=
 =?us-ascii?q?XcUq21/M4MvghqDIYFJgQwogVqKChd4gQeBOII2NT6DfhIYgyeCWASUPF2WL?=
 =?us-ascii?q?gmCH4tfiE0GG4Iwhy+EFopIjVWaEiGBWCsIAhgIIQ+DJ4JOFxVvAQ6NKyMDM?=
 =?us-ascii?q?IEGAQGMBw0XB4IlAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Aug 2019 15:16:06 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7CFG1Pf005408;
        Mon, 12 Aug 2019 11:16:01 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH v2] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20190809181401.7086-1-acgoide@tycho.nsa.gov>
 <CAHC9VhTXjvUHQsZT9Fd6m=yzdBTDAzf1SpfMxQ_qwjy6zbJZLg@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <e3f8f7bc-57df-742d-133a-756b58de3ca4@tycho.nsa.gov>
Date:   Mon, 12 Aug 2019 11:16:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTXjvUHQsZT9Fd6m=yzdBTDAzf1SpfMxQ_qwjy6zbJZLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/19 11:06 AM, Paul Moore wrote:
> On Fri, Aug 9, 2019 at 2:14 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>> As of now, setting watches on filesystem objects has, at most, applied a
>> check for read access to the inode, and in the case of fanotify, requires
>> CAP_SYS_ADMIN. No specific security hook or permission check has been
>> provided to control the setting of watches. Using any of inotify, dnotify,
>> or fanotify, it is possible to observe, not only write-like operations, but
>> even read access to a file. Modeling the watch as being merely a read from
>> the file is insufficient for the needs of SELinux. This is due to the fact
>> that read access should not necessarily imply access to information about
>> when another process reads from a file. Furthermore, fanotify watches grant
>> more power to an application in the form of permission events. While
>> notification events are solely, unidirectional (i.e. they only pass
>> information to the receiving application), permission events are blocking.
>> Permission events make a request to the receiving application which will
>> then reply with a decision as to whether or not that action may be
>> completed. This causes the issue of the watching application having the
>> ability to exercise control over the triggering process. Without drawing a
>> distinction within the permission check, the ability to read would imply
>> the greater ability to control an application. Additionally, mount and
>> superblock watches apply to all files within the same mount or superblock.
>> Read access to one file should not necessarily imply the ability to watch
>> all files accessed within a given mount or superblock.
>>
>> In order to solve these issues, a new LSM hook is implemented and has been
>> placed within the system calls for marking filesystem objects with inotify,
>> fanotify, and dnotify watches. These calls to the hook are placed at the
>> point at which the target path has been resolved and are provided with the
>> path struct, the mask of requested notification events, and the type of
>> object on which the mark is being set (inode, superblock, or mount). The
>> mask and obj_type have already been translated into common FS_* values
>> shared by the entirety of the fs notification infrastructure. The path
>> struct is passed rather than just the inode so that the mount is available,
>> particularly for mount watches. This also allows for use of the hook by
>> pathname-based security modules. However, since the hook is intended for
>> use even by inode based security modules, it is not placed under the
>> CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
>> modules would need to enable all of the path hooks, even though they do not
>> use any of them.
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
>> Security modules wishing to provide complete control over fanotify must
>> also implement a security_file_open hook that validates that the access
>> requested by the watching application is authorized. Fanotify has the issue
>> that it returns a file descriptor with the file mode specified during
>> fanotify_init() to the watching process on event. This is already covered
>> by the LSM security_file_open hook if the security module implements
>> checking of the requested file mode there. Otherwise, a watching process
>> can obtain escalated access to a file for which it has not been authorized.
>>
>> The selinux_path_notify hook implementation works by adding five new file
>> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
>> (descriptions about which will follow), and one new filesystem permission:
>> watch (which is applied to superblock checks). The hook then decides which
>> subset of these permissions must be held by the requesting application
>> based on the contents of the provided mask and the obj_type. The
>> selinux_file_open hook already checks the requested file mode and therefore
>> ensures that a watching process cannot escalate its access through
>> fanotify.
>>
>> The watch, watch_mount, and watch_sb permissions are the baseline
>> permissions for setting a watch on an object and each are a requirement for
>> any watch to be set on a file, mount, or superblock respectively. It should
>> be noted that having either of the other two permissions (watch_reads and
>> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
>> permission. Superblock watches further require the filesystem watch
>> permission to the superblock. As there is no labeled object in view for
>> mounts, there is no specific check for mount watches beyond watch_mount to
>> the inode. Such a check could be added in the future, if a suitable labeled
>> object existed representing the mount.
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
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>> v2:
>>    - move initialization of obj_type up to remove duplicate work
>>    - convert inotify and fanotify flags to common FS_* flags
>>   fs/notify/dnotify/dnotify.c         | 15 +++++++--
>>   fs/notify/fanotify/fanotify_user.c  | 19 ++++++++++--
>>   fs/notify/inotify/inotify_user.c    | 14 +++++++--
>>   include/linux/lsm_hooks.h           |  9 +++++-
>>   include/linux/security.h            | 10 ++++--
>>   security/security.c                 |  6 ++++
>>   security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>>   security/selinux/include/classmap.h |  5 +--
>>   8 files changed, 113 insertions(+), 12 deletions(-)
> 
> ...
> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index f77b314d0575..a47376d1c924 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3261,6 +3263,50 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>>          return -EACCES;
>>   }
>>
>> +static int selinux_path_notify(const struct path *path, u64 mask,
>> +                                               unsigned int obj_type)
>> +{
>> +       int ret;
>> +       u32 perm;
>> +
>> +       struct common_audit_data ad;
>> +
>> +       ad.type = LSM_AUDIT_DATA_PATH;
>> +       ad.u.path = *path;
>> +
>> +       /*
>> +        * Set permission needed based on the type of mark being set.
>> +        * Performs an additional check for sb watches.
>> +        */
>> +       switch (obj_type) {
>> +       case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
>> +               perm = FILE__WATCH_MOUNT;
>> +               break;
>> +       case FSNOTIFY_OBJ_TYPE_SB:
>> +               perm = FILE__WATCH_SB;
>> +               ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
>> +                                               FILESYSTEM__WATCH, &ad);
>> +               if (ret)
>> +                       return ret;
>> +               break;
>> +       case FSNOTIFY_OBJ_TYPE_INODE:
>> +               perm = FILE__WATCH;
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
> 
> Sigh.
> 
> Remember when I said "Don't respin the patch just for this, but if you
> have to do it for some other reason please fix the C++ style
> comments."?  In this particular case it is a small thing, but a
> failure to incorporate all the feedback is one of the things that
> really annoys me (mostly because it makes me worry about other things
> that may have been missed).  It isn't as bad as submitting code which
> doesn't compile, but it's a close second.
> 
> At this point I'm going to ask you to respin the patch to get rid of
> those C++ style comments.  I'm also going to get a bit more nitpicky
> about those comments too (more comments below).
> 
>> +       // check if the mask is requesting ability to set a blocking watch
>> +       if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
>> +               perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
> 
> What is the point of that trailing comment "if so, check that
> permission"?  Given the code, and the comment two lines above this
> seems obvious, does it not?  If you want to keep it, that's fine with
> me, but let's combine the two comments so they read a bit better, for
> example:
> 
>    /* blocking watches require the file:watch_with_perm permission */
>    if (...)
>      perm |= FILE__WATCH_WITH_PERM;
> 
>> +       // is the mask asking to watch file reads?
>> +       if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
>> +               perm |= FILE__WATCH_READS; // check that permission as well
> 
> Here the "check that permission as well" adds no additional useful
> information, it's just noise in the code, drop it from the patch.
> 
> I am a believer in the old advice that good comments explain *why* the
> code is doing something, where bad comments explain *what* the code is
> doing.  I would kindly ask that you keep that in mind when submitting
> future SELinux patches.
> 

Paul,
I was so focused on Amir's comments that it didn't occur to me to 
include the comment changes in that patch, expect a new version to 
follow very shortly. My bad.

-- 
Aaron
