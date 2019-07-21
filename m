Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380436F488
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2019 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfGUSGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 14:06:16 -0400
Received: from sonic306-20.consmr.mail.sg3.yahoo.com ([106.10.241.140]:40105
        "EHLO sonic306-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfGUSGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563732371; bh=bKspz2z5LdcfzRwIjp5lvZV0YVBZdJWkncHQoxY5JGs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fKo/Lkz+QyX6NblFRGYdHRS3oP6JovL6T9mHZAYdqz/WFj4XDudHDud0iyo84i1gB1ElRY6TN/RlPpwINxmKotU4HHW/IOCyU8TraMmL/Q2mnV9zMhr+BCMOaS5jwQMaUeVnZv3KxyaWvtKUpIOdyin2/4oJt6LTSrpkFrJjBRxdgxYef7MzNIneSpI3gm1Iw8UtpVFRh37kK3HijL6x9sZck5YT0sa8ik4VTwuv9XzbjunXrBjZUqN2+9j/JjKe9T9BgIbQZqFTwlAw9RpHwa+RFq+dkKzT490riJ8IyAIZq5wIJ81pi+bfJoi1bFGKuM/zU2jr/ypgL0jFRMq0fg==
X-YMail-OSG: 29DCwqcVM1kiMnek769nOg6zmsH69SAkgin4GvbnIDpBPEvHqhqHoYbohbUuYuZ
 KiPBmNbNnJ7wOtR__hBdBHLYeG9LkBUS7PIzho8w3939MGPpTdXd6FyAzt_vAGVb977sDnadMzvX
 k654msA0DDwFg5fKOhoEAkr3UBemUHLNliDwEggBuc_9V40nIyS8sNGE4an37Aw97Z7ilsSYaJiw
 Rb1Mzn0Klp0ma_KpARhb241j9tlMjqBVCmPlT.iym8Nm.aXTD0y7ZJB1v7Z_IefLUTUVAbQ_WRTi
 smo1c9Iko8QH.U_JOI4r9ElPgqasZzL.nfSIRICPjj5n1V6E.cayl_xWFEASwEV0AD9Ho4lxLJdu
 iSkJFpIw5T26L893VFePsopb1R2HhiPN37pZcnAQFBL22xF6GybMKk6kwEJiCF.fHwoaS5Mqzp0D
 9mEsJN0Rj0Jt2H8NhZ2rk.yarPKABt0h0imB1zOy2X4Nk0swvQMwu07R1oEAaY7VujH65y4TIHZN
 gIc4wQghx4VZnCPf.VyWTN1j3KNFDGoVTx6I32iVHHJ1pb6qHv7pohxP84LB2yI8W2ssTFsCggsF
 qqj9FGAW2kROaO_f61Za69nU55V1o39szuvJ5l5KQUxUBYT7M7ywSerbNGLfaVNo2AgmJS8J98nD
 HCORE3j0F3rK0Johq4iLiXolzkxjchKtkjIQKMYihlV7dCnhQ4As5..5lB_voCeQmbQW4Uahxje_
 TIC4g4HY_PYzZ_WURoJVvKJMg3aZ8z_bEbOwpnQhnO46S1piOxIbuA4JvK7VB1HyX0iZaqJ7pq.P
 bsOPdlvn_Svo7v1rEu5g_vx15Nsy.P1MrOkbkDjXfUrpZ1UebiK7ZUhP_bL14monw08pw6CmZGHz
 m6oF3I0b9KAHcjRUDQUeGk97AivQrZuoCzSSRORycvbwCi16PvbWbHBn.EylsRi4m9WMGSp3Ca5l
 eRzh.ikoxPrvOOIvzsvT7X7YeN4I4an3Sby7fTRnFYLri2u2wsge2FVSaYkwiZE_LW0IWjsRqLFy
 lgxkhJ7NnhuwKYwVpbVaKQLudEw5SOK3cnuJjnfK5ZOXhdsmaAStwQtegB1APN5ct3JeBwmv2Eqs
 KQQnEk3O.3SaHW_Y91SA41aLEPL.fYFDi1EWc3NgdKOOQfuuB.nugkv7V4DY..t3o7zuuGYQTEAn
 kSJxoQWTMfQU6agQWZKdHqZUXAevty3g9jmdxsHSePaylPvypYGbc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Sun, 21 Jul 2019 18:06:11 +0000
Received: by smtp407.mail.sg3.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bc39f46653b953fba0fd5e90440d1fc6;
          Sun, 21 Jul 2019 18:06:06 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] erofs: add super block operations
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190711145755.33908-4-gaoxiang25@huawei.com>
 <20190720224955.GD17978@ZenIV.linux.org.uk>
 <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
 <20190721040547.GF17978@ZenIV.linux.org.uk>
 <7774f181-a41c-f30a-3b2a-02d7438d3509@huawei.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <bb571231-c080-a219-8368-855ff10055b8@aol.com>
Date:   Mon, 22 Jul 2019 02:05:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7774f181-a41c-f30a-3b2a-02d7438d3509@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019/7/21 ??????12:12, Gao Xiang wrote:
> 
> 
> On 2019/7/21 12:05, Al Viro wrote:
>> On Sun, Jul 21, 2019 at 11:08:42AM +0800, Gao Xiang wrote:
>>
>>> It is for debugging use as you said below, mainly for our internal
>>> testers whose jobs are
>>> to read kmsg logs and catch kernel problems. sb->s_id (device number)
>>> maybe not
>>> straight-forward for them compared with dev_name...
>>
>> Huh? ->s_id is something like "sdb7" - it's bdev_name(), not a device
>> number...
> 
> You are right. Forgive me, actually we use /dev/block/by-name/system
> to mount fs... we have to do some lookup if using sdbX instead.
> 
> 
>>
>>> The initial purpose of erofs_mount_private was to passing multi private
>>> data from erofs_mount
>>> to erofs_read_super, which was written before fs_contest was introduced.
>>
>> That has nothing to do with fs_context (well, other than fs_context conversions
>> affecting the code very close to that).
> 
> OK. That is fine.
> 
>>
>>> I agree with you, it seems better to just use s_id in community and
>>> delete erofs_mount_private stuffs...
>>> Yet I don't look into how to use new fs_context, could I keep using
>>> legacy mount interface and fix them all?
>>
>> Sure.
>>
>>> I guess if I don't misunderstand, that is another suggestion -- in
>>> short, leave all destructors to .kill_sb() and
>>> cleanup fill_super().
>>
>> Just be careful with that iput() there - AFAICS, if fs went live (i.e.
>> if ->s_root is non-NULL), you really need it done only from put_super();
>> OTOH, for the case of NULL ->s_root ->put_super() won't be called at all,
>> so in that case you need it directly in ->kill_sb().
> 
> I got it. I will do a quick try now :) But in case of introducing issues,
> I guess I need to do some fault injection by hand.....

I try to fix them in

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/tree/fs/erofs/super.c?h=erofs-outofstaging

, including:

1) remove unneeded sbi->dev_name;

2) remove all destructors in fill_super()
349         /* get the root inode */
350         inode = erofs_iget(sb, ROOT_NID(sbi), true);
351         if (IS_ERR(inode))
352                 return PTR_ERR(inode);
353
354         if (unlikely(!S_ISDIR(inode->i_mode))) {
355                 errln("rootino(nid %llu) is not a directory(i_mode %o)",
356                       ROOT_NID(sbi), inode->i_mode);
357                 iput(inode);
358                 return -EINVAL;
359         }
360
361         sb->s_root = d_make_root(inode);
362         if (unlikely(!sb->s_root))
363                 return -ENOMEM;
364
365         erofs_shrinker_register(sb);
366 #ifdef EROFS_FS_HAS_MANAGED_CACHE
367         /* sb->s_umount is locked here, SB_BORN and SB_ACTIVE are not set */
368         mc = erofs_init_managed_cache(sb);
369         if (IS_ERR(mc))
370                 return PTR_ERR(mc);
371         sbi->managed_cache = mc;
372 #endif

...

385 /*
386  * could be triggered after deactivate_locked_super()
387  * is called, thus including umount and failed to initialize.
388  */
389 static void erofs_kill_sb(struct super_block *sb)
390 {
391         struct erofs_sb_info *sbi;
392
393         WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
394         infoln("unmounting erofs for %s", sb->s_id);
395
396         kill_block_super(sb);
397
398         sbi = EROFS_SB(sb);
399         if (!sbi)
400                 return;
401         kfree(sbi);
402         sb->s_fs_info = NULL;
403 }
404
405 /* called when ->s_root is non-NULL */
406 static void erofs_put_super(struct super_block *sb)
407 {
408         struct erofs_sb_info *const sbi = EROFS_SB(sb);
409
410         DBG_BUGON(!sbi);
411
412 #ifdef EROFS_FS_HAS_MANAGED_CACHE
413         iput(sbi->managed_cache);
414         sbi->managed_cache = NULL;
415 #endif
416         erofs_shrinker_unregister(sb);
417 }

...

and I injected some faults on error paths and it seems fine...
Could you kindly check whether it makes sense? (if I understand all correctly....)

The whole patchset will be resent this morning (a few hours later), I have to sleep...


Thanks,
Gao Xiang

