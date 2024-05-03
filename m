Return-Path: <linux-fsdevel+bounces-18586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F088BAA2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB481C21C56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CB14F9E3;
	Fri,  3 May 2024 09:51:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D313959C;
	Fri,  3 May 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729879; cv=none; b=ZwAHAVyNwkJyK2poKGUc5nN195J65IbfbxU01dfaMNwD9Lm8Sgz+x/hfLJHa7A+1HudsdN8Mb8Cj8009WARsTbbhvjUN0Xi3SDcuHNfiRkLb9UH/I/zZsN3D6uB8O/VWMSP1mSXw+fB2a+D8uvoMyFyGe1uNSFOq/liSxvDYOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729879; c=relaxed/simple;
	bh=nl8IYhxxn7R72hjVZ+8gasR48TtifZBriO+2gTzBRmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JRn8WvwP9juPUzSr34YRsbBl/Z6LIMVJztvbsTDtzLNHEc61rB8+Yl/Q70r77Oy+S0VCm2AKXCCdP2v/RRzcbyjUJbGu9gWoQJ9ZwPkGpRHvzfiVn9lpJ43T7paDW/F2g8ERi+QQRBJOxnELZ+cTtuWgHFi8+XzvtQlei6foj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VW5bH28w9zyNMT;
	Fri,  3 May 2024 17:48:27 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 83A431403D2;
	Fri,  3 May 2024 17:51:08 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 17:51:07 +0800
Message-ID: <dca44ba5-5c33-05ef-d9de-21a84f9d7eaa@huawei.com>
Date: Fri, 3 May 2024 17:51:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, <tytso@mit.edu>, syzbot
	<syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <nathan@kernel.org>, <ndesaulniers@google.com>,
	<ritesh.list@gmail.com>, <syzkaller-bugs@googlegroups.com>,
	<trix@redhat.com>, Baokun Li <libaokun1@huawei.com>, yangerkun
	<yangerkun@huawei.com>
References: <00000000000072c6ba06174b30b7@google.com>
 <0000000000003bf5be061751ae70@google.com>
 <20240502103341.t53u6ya7ujbzkkxo@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240502103341.t53u6ya7ujbzkkxo@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Hi Honza,

On 2024/5/2 18:33, Jan Kara wrote:
> On Tue 30-04-24 08:04:03, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
>> Author: Baokun Li <libaokun1@huawei.com>
>> Date:   Thu Jun 16 02:13:56 2022 +0000
>>
>>      ext4: fix use-after-free in ext4_xattr_set_entry
> So I'm not sure the bisect is correct since the change is looking harmless.
Yes, the root cause of the problem has nothing to do with this patch,
and please see the detailed analysis below.
> But it is sufficiently related that there indeed may be some relationship.
> Anyway, the kernel log has:
>
> [   44.932900][ T1063] EXT4-fs warning (device loop0): ext4_evict_inode:297: xattr delete (err -12)
> [   44.943316][ T1063] EXT4-fs (loop0): unmounting filesystem.
> [   44.949531][ T1063] ------------[ cut here ]------------
> [   44.955050][ T1063] WARNING: CPU: 0 PID: 1063 at fs/mbcache.c:409 mb_cache_destroy+0xda/0x110
>
> So ext4_xattr_delete_inode() called when removing inode has failed with
> ENOMEM and later mb_cache_destroy() was eventually complaining about having
> mbcache entry with increased refcount. So likely some error cleanup path is
> forgetting to drop mbcache entry reference somewhere but at this point I
> cannot find where. We'll likely need to play with the reproducer to debug
> that. Baokun, any chance for looking into this?
>
> 								Honza
As you guessed, when -ENOMEM is returned in ext4_sb_bread(),
the reference count of ce is not properly released, as follows.

ext4_create
  __ext4_new_inode
   security_inode_init_security
    ext4_initxattrs
     ext4_xattr_set_handle
      ext4_xattr_block_find
      ext4_xattr_block_set
       ext4_xattr_block_cache_find
         ce = mb_cache_entry_find_first
             __entry_find
             atomic_inc_not_zero(&entry->e_refcnt)
         bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
         if (PTR_ERR(bh) == -ENOMEM)
             return NULL;

Before merging into commit 67d7d8ad99be("ext4: fix use-after-free
in ext4_xattr_set_entry"), it will not return early in 
ext4_xattr_ibody_find(),
so it tries to find it in iboy, fails the check in xattr_check_inode() and
returns without executing ext4_xattr_block_find(). Thus it will bisect
the patch, but actually has nothing to do with it.

ext4_xattr_ibody_get
  xattr_check_inode
   __xattr_check_inode
    check_xattrs
     if (end - (void *)header < sizeof(*header) + sizeof(u32))
       "in-inode xattr block too small"

Here's the patch in testing, I'll send it out officially after it is tested.
(PS:  I'm not sure if propagating the ext4_xattr_block_cache_find() 
errors would be better.)

Regards,
Baokun


From: Baokun Li <libaokun1@huawei.com>
Date: Fri, 3 May 2024 16:51:43 +0800
Subject: [PATCH] ext4: fix mb_cache_entry's e_refcnt leak in
  ext4_xattr_block_cache_find()

Syzbot reports a warning as follows:

============================================
WARNING: CPU: 0 PID: 5075 at fs/mbcache.c:419 mb_cache_destroy+0x224/0x290
Modules linked in:
CPU: 0 PID: 5075 Comm: syz-executor199 Not tainted 6.9.0-rc6-gb947cc5bf6d7
RIP: 0010:mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
Call Trace:
  <TASK>
  ext4_put_super+0x6d4/0xcd0 fs/ext4/super.c:1375
  generic_shutdown_super+0x136/0x2d0 fs/super.c:641
  kill_block_super+0x44/0x90 fs/super.c:1675
  ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7327
[...]
============================================

This is because when finding an entry in ext4_xattr_block_cache_find(), if
ext4_sb_bread() returns -ENOMEM, the ce's e_refcnt, which has already grown
in the __entry_find(), won't be put away, and eventually trigger the above
issue in mb_cache_destroy() due to reference count leakage. So correct the
handling of the -ENOMEM error branch to avoid the above issue.

Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM 
cases")
Cc: stable@kernel.org # v5.0-rc1
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
  fs/ext4/xattr.c | 7 +++----
  1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b67a176bfcf9..5c9e751915fd 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3113,11 +3113,10 @@ ext4_xattr_block_cache_find(struct inode *inode,

          bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
          if (IS_ERR(bh)) {
-            if (PTR_ERR(bh) == -ENOMEM)
-                return NULL;
+            if (PTR_ERR(bh) != -ENOMEM)
+                EXT4_ERROR_INODE(inode, "block %lu read error",
+                         (unsigned long)ce->e_value);
              bh = NULL;
-            EXT4_ERROR_INODE(inode, "block %lu read error",
-                     (unsigned long)ce->e_value);
          } else if (ext4_xattr_cmp(header, BHDR(bh)) == 0) {
              *pce = ce;
              return bh;
-- 
2.39.2


