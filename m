Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E3730D0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 04:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbjFOCPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 22:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFOCPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:15:14 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CC1BE8;
        Wed, 14 Jun 2023 19:15:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QhQqH4HGcz4f3knX;
        Thu, 15 Jun 2023 10:15:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHLaEodIpkxertLg--.6998S3;
        Thu, 15 Jun 2023 10:15:06 +0800 (CST)
Subject: Re: [syzbot] [reiserfs?] general protection fault in rcu_core (2)
To:     syzbot <syzbot+b23c4c9d3d228ba328d7@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        "yukuai (C)" <yukuai3@huawei.com>
References: <000000000000556d9605fe1e5c40@google.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1cb93e56-f3e3-c972-1232-bbb67ad4f672@huaweicloud.com>
Date:   Thu, 15 Jun 2023 10:15:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000556d9605fe1e5c40@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHLaEodIpkxertLg--.6998S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1fuFy7ur47Ar1fuFy8Krg_yoWrGw4xpF
        45Kw42yr9YyrWUJwnFkF15ua4I9Fn8WFW7WrW7WrZ2vanIqrnxXa1Iyr43uFWUur4Fy34k
        Jw1DC3Z3tw1rZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

在 2023/06/15 6:20, syzbot 写道:
> syzbot has bisected this issue to:
> 
> commit 2acf15b94d5b8ea8392c4b6753a6ffac3135cd78
> Author: Yu Kuai <yukuai3@huawei.com>
> Date:   Fri Jul 2 04:07:43 2021 +0000
> 
>      reiserfs: add check for root_inode in reiserfs_fill_super
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1715ffdd280000

git log:

13d257503c09 reiserfs: check directory items on read from disk
2acf15b94d5b reiserfs: add check for root_inode in reiserfs_fill_super

The bisect log shows that with commit 13d257503c09:
testing commit 13d257503c0930010ef9eed78b689cec417ab741 gcc
compiler: gcc (GCC) 10.2.1 20210217, GNU ld (GNU Binutils for Debian) 2.35.2
kernel signature: 
fc456e669984fb9704d9e1d3cb7be68af3b83de4bb55124257ae28bb39a14dc7
run #0: basic kernel testing failed: possible deadlock in fs_reclaim_acquire
run #1: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #2: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #3: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #4: crashed: KASAN: use-after-free Read in leaf_insert_into_buf
run #5: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #6: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #7: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #8: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer
run #9: crashed: KASAN: out-of-bounds Read in leaf_paste_in_buffer

and think this is bad, then bisect to the last commit:
testing commit 2acf15b94d5b8ea8392c4b6753a6ffac3135cd78 gcc
compiler: gcc (GCC) 10.2.1 20210217, GNU ld (GNU Binutils for Debian) 2.35.2
kernel signature: 
6d0d5f26a4c0e15188c923383ecfb873ae57ca6a79f592493d6e9ca507949985
run #0: crashed: possible deadlock in fs_reclaim_acquire
run #1: OK
run #2: OK
run #3: OK
run #4: OK
run #5: OK
run #6: OK
run #7: OK
run #8: OK
run #9: OK
reproducer seems to be flaky
# git bisect bad 2acf15b94d5b8ea8392c4b6753a6ffac3135cd78

It seems to me the orignal crash general protection fault is not related
to this commit. Please kindly correct me if I'm wrong.

For the problem of lockdep warning, it first appeared in bisect log:
testing commit 406254918b232db198ed60f5bf1f8b84d96bca00 gcc
compiler: gcc (GCC) 10.2.1 20210217, GNU ld (GNU Binutils for Debian) 2.35.2
kernel signature: 
1c83f3c8b090a4702817c527e741a35506bc06911c71962d4c5fcef577de2fd3
run #0: basic kernel testing failed: BUG: sleeping function called from 
invalid context in stack_depot_save
run #1: basic kernel testing failed: possible deadlock in fs_reclaim_acquire
run #2: OK
run #3: OK
run #4: OK
run #5: OK
run #6: OK
run #7: OK
run #8: OK
run #9: OK
# git bisect good 406254918b232db198ed60f5bf1f8b84d96bca00

And I don't understand why syzbot thinks this is good, and later for the
same result, syzbot thinks 2acf15b94d5b is bad.

Thanks,
Kuai
> start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1495ffdd280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1095ffdd280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
> dashboard link: https://syzkaller.appspot.com/bug?extid=b23c4c9d3d228ba328d7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1680f7d1280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fad50d280000
> 
> Reported-by: syzbot+b23c4c9d3d228ba328d7@syzkaller.appspotmail.com
> Fixes: 2acf15b94d5b ("reiserfs: add check for root_inode in reiserfs_fill_super")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> .
> 

