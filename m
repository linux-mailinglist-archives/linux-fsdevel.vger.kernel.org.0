Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708AF87E5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436727AbfHIPpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 11:45:33 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:27340 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436676AbfHIPpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:45:33 -0400
X-EEMSG-check-017: 10709605|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,364,1559520000"; 
   d="scan'208";a="10709605"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Aug 2019 15:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565365531; x=1596901531;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iAwPIyCv6EMhtrpUiGtE4QQ+Ii514WgfVvyDq94vE68=;
  b=MPtRUHNFRONx9sXINxTpi87+wa22VJklgDt5fjF91kMep1X66IGQL4NH
   flKv9/ACaHO2xVytwiV/LX/Mo+jjneCHD7wEDcb5JwUkOXWC31iXPnZ4X
   iGQllhrwoyT3OSn6vASrbgmutWm9e+s3ot+ubG9OBSjYvp4kE6sbgflMt
   E2ccgP3mq5BD9hGYq3ZeamwefCxN3bU2tI44auKy8OKiH4Fq/94f+8pJk
   5FM5rW/OcqzqIYm6fMCeM1801muXNsKZ4lZvRqGciDPOBF6rmTp8vYOb/
   RiLP4ZQQMZIJn5Ota7UPy9aJOWAW6QJ4b+7Bz/TF14DdAht4JuCwd0b5y
   w==;
X-IronPort-AV: E=Sophos;i="5.64,364,1559520000"; 
   d="scan'208";a="26635903"
IronPort-PHdr: =?us-ascii?q?9a23=3ABBP9uRHBnVZkvUA+RSMK1J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pM+zbnLW6fgltlLVR4KTs6sC17OM9fm5BidQsN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdutQUjIdtKas8zg?=
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
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfJUauDP8K/g/5fPjg345mVsGcKmm2JsYcnG4HvB8L0?=
 =?us-ascii?q?qFZnrsh88LEX0WsQomUOzqlFqCXCZIZ3msW6I85zc7CJ+pDIrYWICtj6KO3D?=
 =?us-ascii?q?2hEp1VeG9GEFaMHmnsd4meXPcMci2SKNd7kjMYTbihV5Mh1Ra2uQ/+yrpnKP?=
 =?us-ascii?q?fU+yIBuZL4ytd6+/DTlQsz9TxoD8WRymSNT2ZpkWMVQz85wrtyoVJyylidy6?=
 =?us-ascii?q?h0mf9YGsJJ5/NPTAg6MYTQz+tgC9D9QgjBZMuGSE66QtW6BjE8VtYxw94IY0?=
 =?us-ascii?q?ZgFNSulx7D3zG3DLALibyEGpg0/7nC33j+Ocl90WzK1Ko/gFk8RMtAK2mmir?=
 =?us-ascii?q?R49wjJCI7Di1+ZmLqydaQAwC7N83+OwneOvEFfXg9/T6HFXXQEZkbNt9T2+F?=
 =?us-ascii?q?7NT7+0BrQ7KAdO1cmCKq5SYN3zkVpGXOvjOMjZY2+pmWe/HwqHxrCXYYrxZm?=
 =?us-ascii?q?UdxzvSBFIYnAES5XyGLxQxBj+9o2LCCzxjDVDvY0br8elksnO7T1Q0whqMb0?=
 =?us-ascii?q?J70rq65B8VieabS/MJ0bIOoD0hpClsHFahw9LWDMKNpw5gfKVafNM8705L1W?=
 =?us-ascii?q?HHuAxnOJyvMaRii0UAcwR4oUzuzQ97CoZensgwqnMl0g5yJbif0FNbeDPLla?=
 =?us-ascii?q?z3b4XeN2262ReocaOejknXzdK+4q4S7LE9rFL5sUeiEU90tz1O1thPm1Sb4p?=
 =?us-ascii?q?nREAcTV9qlW0M27UchprXybSw05oeS3nppZ/qaqDjHjvsgHuwjgjmnfttSNO?=
 =?us-ascii?q?vQHQT9FMwWCuCyOecqnB6vdRtCM+dMov1nd/i6fueLjfb4dN1rmyir2CEeu9?=
 =?us-ascii?q?Fw?=
X-IPAS-Result: =?us-ascii?q?A2AcBwBtlE1d/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoE+A?=
 =?us-ascii?q?TIqhB6PcwEBAQEBBoEJLX6IXQ6RIQkBAQEBAQEBAQE0AQIBAYQ/AoJhIzgTA?=
 =?us-ascii?q?QQBAQEEAQEDAQkBAWyFM4I6KQGCZwECAyMVNgkCEAsYAgIfBwICITYGAQwGA?=
 =?us-ascii?q?gEBglMMP4FrAwkUq12BMoVJgkcNX4FJgQwoi2QXeIEHgREngjY1PoIagWQSG?=
 =?us-ascii?q?IMnglgEjluFYF2VbUAJgh+LXIRag3MGG4Iwhy+EFIpFjVGJVpA4IYFYKwgCG?=
 =?us-ascii?q?AghDzuCbIJ6jikjAzCBBgEBizcNFweCJQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Aug 2019 15:44:40 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x79FicR2012207;
        Fri, 9 Aug 2019 11:44:38 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Paul Moore <paul@paul-moore.com>,
        Amir Goldstein <amir73il@gmail.com>
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
 <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <03ad3773-bea7-77de-0a1f-4bd6f41d3211@tycho.nsa.gov>
Date:   Fri, 9 Aug 2019 11:44:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/9/19 8:55 AM, Paul Moore wrote:
> On Fri, Aug 9, 2019 at 5:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
>> On Thu, Aug 8, 2019 at 9:33 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Wed, Jul 31, 2019 at 11:35 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>>> As of now, setting watches on filesystem objects has, at most, applied a
>>>> check for read access to the inode, and in the case of fanotify, requires
>>>> CAP_SYS_ADMIN. No specific security hook or permission check has been
>>>> provided to control the setting of watches. Using any of inotify, dnotify,
>>>> or fanotify, it is possible to observe, not only write-like operations, but
>>>> even read access to a file. Modeling the watch as being merely a read from
>>>> the file is insufficient for the needs of SELinux. This is due to the fact
>>>> that read access should not necessarily imply access to information about
>>>> when another process reads from a file. Furthermore, fanotify watches grant
>>>> more power to an application in the form of permission events. While
>>>> notification events are solely, unidirectional (i.e. they only pass
>>>> information to the receiving application), permission events are blocking.
>>>> Permission events make a request to the receiving application which will
>>>> then reply with a decision as to whether or not that action may be
>>>> completed. This causes the issue of the watching application having the
>>>> ability to exercise control over the triggering process. Without drawing a
>>>> distinction within the permission check, the ability to read would imply
>>>> the greater ability to control an application. Additionally, mount and
>>>> superblock watches apply to all files within the same mount or superblock.
>>>> Read access to one file should not necessarily imply the ability to watch
>>>> all files accessed within a given mount or superblock.
>>>>
>>>> In order to solve these issues, a new LSM hook is implemented and has been
>>>> placed within the system calls for marking filesystem objects with inotify,
>>>> fanotify, and dnotify watches. These calls to the hook are placed at the
>>>> point at which the target path has been resolved and are provided with the
>>>> path struct, the mask of requested notification events, and the type of
>>>> object on which the mark is being set (inode, superblock, or mount). The
>>>> mask and obj_type have already been translated into common FS_* values
>>>> shared by the entirety of the fs notification infrastructure. The path
>>>> struct is passed rather than just the inode so that the mount is available,
>>>> particularly for mount watches. This also allows for use of the hook by
>>>> pathname-based security modules. However, since the hook is intended for
>>>> use even by inode based security modules, it is not placed under the
>>>> CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
>>>> modules would need to enable all of the path hooks, even though they do not
>>>> use any of them.
>>>>
>>>> This only provides a hook at the point of setting a watch, and presumes
>>>> that permission to set a particular watch implies the ability to receive
>>>> all notification about that object which match the mask. This is all that
>>>> is required for SELinux. If other security modules require additional hooks
>>>> or infrastructure to control delivery of notification, these can be added
>>>> by them. It does not make sense for us to propose hooks for which we have
>>>> no implementation. The understanding that all notifications received by the
>>>> requesting application are all strictly of a type for which the application
>>>> has been granted permission shows that this implementation is sufficient in
>>>> its coverage.
>>>>
>>>> Security modules wishing to provide complete control over fanotify must
>>>> also implement a security_file_open hook that validates that the access
>>>> requested by the watching application is authorized. Fanotify has the issue
>>>> that it returns a file descriptor with the file mode specified during
>>>> fanotify_init() to the watching process on event. This is already covered
>>>> by the LSM security_file_open hook if the security module implements
>>>> checking of the requested file mode there. Otherwise, a watching process
>>>> can obtain escalated access to a file for which it has not been authorized.
>>>>
>>>> The selinux_path_notify hook implementation works by adding five new file
>>>> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
>>>> (descriptions about which will follow), and one new filesystem permission:
>>>> watch (which is applied to superblock checks). The hook then decides which
>>>> subset of these permissions must be held by the requesting application
>>>> based on the contents of the provided mask and the obj_type. The
>>>> selinux_file_open hook already checks the requested file mode and therefore
>>>> ensures that a watching process cannot escalate its access through
>>>> fanotify.
>>>>
>>>> The watch, watch_mount, and watch_sb permissions are the baseline
>>>> permissions for setting a watch on an object and each are a requirement for
>>>> any watch to be set on a file, mount, or superblock respectively. It should
>>>> be noted that having either of the other two permissions (watch_reads and
>>>> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
>>>> permission. Superblock watches further require the filesystem watch
>>>> permission to the superblock. As there is no labeled object in view for
>>>> mounts, there is no specific check for mount watches beyond watch_mount to
>>>> the inode. Such a check could be added in the future, if a suitable labeled
>>>> object existed representing the mount.
>>>>
>>>> The watch_reads permission is required to receive notifications from
>>>> read-exclusive events on filesystem objects. These events include accessing
>>>> a file for the purpose of reading and closing a file which has been opened
>>>> read-only. This distinction has been drawn in order to provide a direct
>>>> indication in the policy for this otherwise not obvious capability. Read
>>>> access to a file should not necessarily imply the ability to observe read
>>>> events on a file.
>>>>
>>>> Finally, watch_with_perm only applies to fanotify masks since it is the
>>>> only way to set a mask which allows for the blocking, permission event.
>>>> This permission is needed for any watch which is of this type. Though
>>>> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
>>>> trust to root, which we do not do, and does not support least privilege.
>>>>
>>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>>> ---
>>>>   fs/notify/dnotify/dnotify.c         | 15 +++++++--
>>>>   fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
>>>>   fs/notify/inotify/inotify_user.c    | 13 ++++++--
>>>>   include/linux/lsm_hooks.h           |  9 +++++-
>>>>   include/linux/security.h            | 10 ++++--
>>>>   security/security.c                 |  6 ++++
>>>>   security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>>>>   security/selinux/include/classmap.h |  5 +--
>>>>   8 files changed, 120 insertions(+), 12 deletions(-)
>>>
>>> Other than Casey's comments, and ACK, I'm not seeing much commentary
>>> on this patch so FS and LSM folks consider this your last chance - if
>>> I don't hear any objections by the end of this week I'll plan on
>>> merging this into selinux/next next week.
>>
>> Please consider it is summer time so people may be on vacation like I was...
> 
> This is one of the reasons why I was speaking to the mailing list and
> not a particular individual :)
> 
>> First a suggestion, take it or leave it.
>> The name of the hook _notify() seems misleading to me.
>> naming the hook security_path_watch() seems much more
>> appropriate and matching the name of the constants FILE__WATCH
>> used by selinux.
> 
> I guess I'm not too bothered by either name, Aaron?  FWIW, if I was
> writing this hook, I would probably name it
> security_fsnotify_path(...).
> 

While I'm not necessarily attached to the name, I feel as though 
"misleading" is too strong a word here. Notify seems to be an 
appropriate enough term to me as every call to the hook, and thus all 
the logic to which the hook adds security, lives in the notify/ subtree.

-- 
Aaron
