Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA171F3FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFAUji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFAUjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:39:37 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D3128;
        Thu,  1 Jun 2023 13:39:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QXHKs4mKPz9xyNB;
        Fri,  2 Jun 2023 04:09:53 +0800 (CST)
Received: from [10.81.220.232] (unknown [10.81.220.232])
        by APP1 (Coremail) with SMTP id LxC2BwCX79pf_XhkTA8AAw--.3309S2;
        Thu, 01 Jun 2023 21:19:55 +0100 (CET)
Message-ID: <8a48ede1-3a45-7c3c-39e9-36001ac09283@huaweicloud.com>
Date:   Thu, 1 Jun 2023 22:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
Content-Language: en-US
To:     syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>,
        hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com, Jan Kara <jack@suse.cz>,
        Jeff Mahoney <jeffm@suse.com>
References: <00000000000000964605faf87416@google.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <00000000000000964605faf87416@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCX79pf_XhkTA8AAw--.3309S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8Zw4rAF45Kry5tFWfAFb_yoW5Xw47pr
        WrKryDKwsYvr1DWr1kt3WDuw10qryak347JrnrKryv9anrXwnrtFWIv3yfGrs5trWDGFZ3
        Ja1jk3yUAw4fuwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4oC1gAAsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/2023 10:51 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> Author: Roberto Sassu <roberto.sassu@huawei.com>
> Date:   Fri Mar 31 12:32:18 2023 +0000
> 
>      reiserfs: Add security prefix to xattr name in reiserfs_security_write()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14403182280000
> start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://githu..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16403182280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12403182280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12442414280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176a7318280000
> 
> Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com
> Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -689,7 +689,9 @@ static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
         reiserfs_update_inode_transaction(inode);
         reiserfs_update_inode_transaction(dir);

+       reiserfs_write_unlock(dir->i_sb);
         d_instantiate_new(dentry, inode);
+       reiserfs_write_lock(dir->i_sb);
         retval = journal_end(&th);

  out_failed:
@@ -773,7 +775,9 @@ static int reiserfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
                 goto out_failed;
         }

+       reiserfs_write_unlock(dir->i_sb);
         d_instantiate_new(dentry, inode);
+       reiserfs_write_lock(dir->i_sb);
         retval = journal_end(&th);

  out_failed:
@@ -874,7 +878,9 @@ static int reiserfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
         /* the above add_entry did not update dir's stat data */
         reiserfs_update_sd(&th, dir);

+       reiserfs_write_unlock(dir->i_sb);
         d_instantiate_new(dentry, inode);
+       reiserfs_write_lock(dir->i_sb);
         retval = journal_end(&th);
  out_failed:
         reiserfs_write_unlock(dir->i_sb);
@@ -1191,7 +1197,9 @@ static int reiserfs_symlink(struct mnt_idmap *idmap,
                 goto out_failed;
         }

+       reiserfs_write_unlock(parent_dir->i_sb);
         d_instantiate_new(dentry, inode);
+       reiserfs_write_lock(parent_dir->i_sb);
         retval = journal_end(&th);
  out_failed:
         reiserfs_write_unlock(parent_dir->i_sb);

