Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C971CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfGWQQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 12:16:23 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:29763 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWQQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:16:22 -0400
X-EEMSG-check-017: 612692|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,299,1559520000"; 
   d="scan'208";a="612692"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP; 23 Jul 2019 16:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1563898568; x=1595434568;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VzouGgOn7bxXwD7qWHawlSBqaPeVOs5RApSCI+ZHzBI=;
  b=YnYL2f0+4Z/nKFePQ+QUZEaS1/B9K1SpYEhEld2+XjmPJ3mhmFI0lZZu
   p1+UF79ya38n7LY6RzqvTrHuU1Gt1bLPIGDdmC8US+no/YGYK42l+880F
   t4gMCkOJ/osOaZJHuCXNpl2d5hjn9YaPISgJI57lbNpozNenhO9en7qY6
   /Swe5v9+eUS9kJT+8Yz2bHjnS7l9Ip05fM1lZaYrA/olPlBAkX2cneESj
   kvcOdwE/eInIJbGJA/DpYzkPUn/vWlElvcPLknx8Gw97qoFbNVJzQc8Lb
   Drbx4rOIqp3OBEk3BXeQZpH7U/fpthszw1UcqRK9isnmGpRUQS/BDKCL+
   A==;
X-IronPort-AV: E=Sophos;i="5.64,299,1559520000"; 
   d="scan'208";a="26002930"
IronPort-PHdr: =?us-ascii?q?9a23=3A8rDe7RNExpsWrz4t0Dgl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K//7pcbcNUDSrc9gkEXOFd2Cra4d0ayJ4+uxCSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Nhe7oAbeusQSgoZpN7o8xA?=
 =?us-ascii?q?bOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQbNXEDopPW?=
 =?us-ascii?q?Y15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RT?=
 =?us-ascii?q?iu86FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSW?=
 =?us-ascii?q?dHUMlRTShBCZ6iYYUJAeQKIOJUo5D9qlYKqBezAxSnCuHyxT9SnnL4wLM00+?=
 =?us-ascii?q?ohHw/F0gIvEd0Bv3bIo9v6L6oSTeK4wbPUwTnfYf5b2zHw45XIfBA7pvGMWK?=
 =?us-ascii?q?p9fNbLxkk1EAPFiEibp43iPzOUy+sCrWyb5PdnWO21l2EnpAZxojmyycgykY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ549wr8/ip?=
 =?us-ascii?q?oTsUPZEi/whEr2l7OZel8h+uip7+TrerTmppmCOI9okgzyL6sjl8OlDek4Lw?=
 =?us-ascii?q?QCRXaX9Oui2LH54EH1WLBKgec3kqndvpDaP8MbpquhDgBPzokj5BG/Dza739?=
 =?us-ascii?q?sGhnQHMFJEdw6Hj4juIV3OJuv4Au2lj1Sjlzdr2ejKPqf9DZXVMnjDjLDhcK?=
 =?us-ascii?q?5n5E5ZyQoz19JS6pxVCrEFO//zVUrxu8bZDh89KQC73+HnCNBl3IMERW2PGr?=
 =?us-ascii?q?OZML/VsVKQ/uIgOfSMZIsOtTblMfcl+vrugWY8mV8aeqmpx4UYZGqkEfRhJk?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/TniEacXj5XZnayWb885z4gBYK4AofMWJqtjKaC3C?=
 =?us-ascii?q?ilBJ1WYH5JClSWHXfvbYWEVO8GaDiOLc95jjwESb+hRpcl1RGvsg/61rVmIv?=
 =?us-ascii?q?PP+iIGqZ3jycJ15+zPlRAy7DB0CsOd3HyQT2FwgGwFXCE23K9hrkxn0FuD0r?=
 =?us-ascii?q?Z3g+ZeFdNN4/NFSAA6NYTTz+ZiEdD9RhrBfsuVSFahWtimBTAxTtQsw94Bek?=
 =?us-ascii?q?p9Fc6igQ3d0Cq0HbAVk6eGBII78q3CxXj9PcV9xGjc1KknkVYmRtFDNWq8hq?=
 =?us-ascii?q?5w7wLTHZLGk12Fl6a2cqQRxDPC9GeEzWuAok5YVApwUb7eUHAFeETZsNT56V?=
 =?us-ascii?q?neT7O0FbsnNQ5Bw9aYKqRWct3pkUlGRPD7NdTceW2+h2SwCA2TxrORd4rlZX?=
 =?us-ascii?q?8R0zncCUIciQAc4W6GNRQiBiemu2/eDjluFVX1Y0P28Ol+s2i2TkkuwAGPcU?=
 =?us-ascii?q?Jh1qC5+hkPhfyTU/kTxK4LuD89qzVoG1awx9bWC9uGpwp8c6RQeNA970ld1W?=
 =?us-ascii?q?LfqQN9OoetL75thlEAaQR7pUDu2AttCoVGj8cqqGkmzA1oKaKXgxt9cGax2J?=
 =?us-ascii?q?HqcpLQLmXp4B2ubeaC01TfyonN+6Mn5/ExqlGltwasQBkM6XJihvBcyXyarr?=
 =?us-ascii?q?rNDQYfVdqlW0048Bl2qpnGcyI94MXSznQqPq6q5GyRk+k1Dfcon07zN+xUN7?=
 =?us-ascii?q?mJQUqrTpwX?=
X-IPAS-Result: =?us-ascii?q?A2BqCgBGMjdd/wHyM5BmHQEBBQEHBQGBZ4FtKoE+ATIqh?=
 =?us-ascii?q?B2SFlABAQEGgQktiWKRFwkBAQEBAQEBAQE0AQIBAYRAAoJOIzgTAQMBAQEEA?=
 =?us-ascii?q?QEBAQUBAWyFKoI6KQGCZwECAyMEET8CEAsYAgIfBwICVwYNBgIBAYJfP4F3F?=
 =?us-ascii?q?Kp8fzOFR4MxgUiBDCiLXxd4gQeBOIJrPodPglgEjkWGLJVyCYIblAYGG4Ith?=
 =?us-ascii?q?yWEDIospxQhgVgrCAIYCCEPgyeBEoFnjikjAzCBBgEBjl4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 23 Jul 2019 16:16:08 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6NGG404027057;
        Tue, 23 Jul 2019 12:16:04 -0400
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190718143042.11059-1-acgoide@tycho.nsa.gov>
 <CAOQ4uxjCR76nbV_Lmoegaq6NqovWZD-XWEVS-X3e=BtDdjKkXQ@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <c74ad814-f188-37c6-9b3a-51178b538a2b@tycho.nsa.gov>
Date:   Tue, 23 Jul 2019 12:16:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjCR76nbV_Lmoegaq6NqovWZD-XWEVS-X3e=BtDdjKkXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/19 12:16 PM, Amir Goldstein wrote:
> On Thu, Jul 18, 2019 at 5:31 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index a90bb19dcfa2..9e3137badb6b 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops = {
>>   };
>>
>>   static int fanotify_find_path(int dfd, const char __user *filename,
>> -                             struct path *path, unsigned int flags)
>> +                             struct path *path, unsigned int flags, __u64 mask)
>>   {
>>          int ret;
>> +       unsigned int mark_type;
>>
>>          pr_debug("%s: dfd=%d filename=%p flags=%x\n", __func__,
>>                   dfd, filename, flags);
>> @@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>>
>>          /* you can only watch an inode if you have read permissions on it */
>>          ret = inode_permission(path->dentry->d_inode, MAY_READ);
>> +       if (ret) {
>> +               path_put(path);
>> +               goto out;
>> +       }
>> +
>> +       switch (flags & FANOTIFY_MARK_TYPE_BITS) {
>> +       case FAN_MARK_MOUNT:
>> +               mark_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
>> +               break;
>> +       case FAN_MARK_FILESYSTEM:
>> +               mark_type = FSNOTIFY_OBJ_TYPE_SB;
>> +               break;
>> +       case FAN_MARK_INODE:
>> +               mark_type = FSNOTIFY_OBJ_TYPE_INODE;
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       ret = security_inode_notify(path->dentry->d_inode, mask, mark_type);
> 
> If you prefer 3 hooks security_{inode,mount,sb}_notify()
> please place them in fanotify_add_{inode,mount,sb}_mark().
> 
> If you prefer single hook with path argument, please pass path
> down to fanotify_add_mark() and call security_path_notify() from there,
> where you already have the object type argument.
> 
I'm not clear on why you want me to move the hook call down to 
fanotify_add_mark(). I'd prefer to keep it adjacent to the existing 
inode_permission() call so that all the security checking occurs from 
one place. Moving it down requires adding a path arg to that entire call 
chain, even though it wouldn't otherwise be needed. And that raises the 
question of whether to continue passing the mnt_sb, mnt, or inode 
separately or just extract all those from the path inside of 
fanotify_add_*_mark().

It also seems to destroy the parallelism with fanotify_remove_*_mark(). 
I also don't see any real benefit in splitting into three separate 
hooks, especially as some security modules will want the path or inode 
even for the mount or superblock cases, since they may have no relevant 
security information for vfsmounts or superblocks.

-- 
Aaron
