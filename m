Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A67123F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbjEZJqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEZJqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:46:36 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C7A4;
        Fri, 26 May 2023 02:46:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QSKX24sdvz9xFbR;
        Fri, 26 May 2023 17:34:58 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3R17Yf3Bk2oXbAg--.2346S2;
        Fri, 26 May 2023 10:46:12 +0100 (CET)
Message-ID: <58cebdd9318bd4435df6c0cf45318abd3db0fff8.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Mahoney <jeffm@suse.com>
Date:   Fri, 26 May 2023 11:45:57 +0200
In-Reply-To: <CAHC9VhRoj3muyD0+pTwpJvCdmzz25C8k8eufWcjc8ZE4e2AOew@mail.gmail.com>
References: <000000000000be039005fc540ed7@google.com>
         <00000000000018faf905fc6d9056@google.com>
         <CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com>
         <813148798c14a49cbdf0f500fbbbab154929e6ed.camel@huaweicloud.com>
         <CAHC9VhRoj3muyD0+pTwpJvCdmzz25C8k8eufWcjc8ZE4e2AOew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3R17Yf3Bk2oXbAg--.2346S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw43XF1UtFW5tr1fGryfJFb_yoW3CFWxpF
        WUtF1qkrWktr1UCrn7t3Z8J3WY9rnYvay7J34xGryjvanYgFnxJw4xKrW3G3yDXrs3CFZr
        XFs5A3y2vw1rWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4nAMwABsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-24 at 17:57 -0400, Paul Moore wrote:
> On Wed, May 24, 2023 at 11:50 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2023-05-24 at 11:11 -0400, Paul Moore wrote:
> > > On Wed, May 24, 2023 at 5:59 AM syzbot
> > > <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com> wrote:
> > > > syzbot has bisected this issue to:
> > > > 
> > > > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Date:   Fri Mar 31 12:32:18 2023 +0000
> > > > 
> > > >     reiserfs: Add security prefix to xattr name in reiserfs_security_write()
> > > > 
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c39639280000
> > > > start commit:   421ca22e3138 Merge tag 'nfs-for-6.4-2' of git://git.linux-..
> > > > git tree:       upstream
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=13c39639280000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15c39639280000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0a684c061589dcc30e51
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14312791280000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da8605280000
> > > > 
> > > > Reported-by: syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com
> > > > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")
> > > > 
> > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > 
> > > Roberto, I think we need to resolve this somehow.  As I mentioned
> > > earlier, I don't believe this to be a fault in your patch, rather that
> > > patch simply triggered a situation that had not been present before,
> > > likely because the reiserfs code always failed when writing LSM
> > > xattrs.  Regardless, we still need to fix the deadlocks that sysbot
> > > has been reporting.
> > 
> > Hi Paul
> > 
> > ok, I will try.
> 
> Thanks Roberto.  If it gets to be too challenging, let us know and we
> can look into safely disabling the LSM xattrs for reiserfs, I'll be
> shocked if anyone is successfully using LSM xattrs on reiserfs.

Ok, at least I know what happens...

+ Jan, Jeff

I'm focusing on this reproducer, which works 100% of the times:

https://syzkaller.appspot.com/text?tag=ReproSyz&x=163079f9280000

This is the last lock, before things go wrong:

Thread 5 hit Breakpoint 2, reiserfs_write_lock (s=s@entry=0xffff888066e28000) at fs/reiserfs/lock.c:24
24	{
(gdb) bt
#0  reiserfs_write_lock (s=s@entry=0xffff888066e28000) at fs/reiserfs/lock.c:24
#1  0xffffffff821a559a in reiserfs_get_block (inode=inode@entry=0xffff888069fd0190, block=block@entry=15, bh_result=bh_result@entry=0xffff888075940000, create=create@entry=1) at fs/reiserfs/inode.c:680
#2  0xffffffff81f50254 in __block_write_begin_int (folio=0xffffea00019a9180, pos=pos@entry=61440, len=len@entry=1, get_block=get_block@entry=0xffffffff821a5390 <reiserfs_get_block>, iomap=iomap@entry=0x0 <fixed_percpu_data>) at fs/buffer.c:2064
#3  0xffffffff81f5165a in __block_write_begin (page=page@entry=0xffffea00019a9180, pos=pos@entry=61440, len=len@entry=1, get_block=get_block@entry=0xffffffff821a5390 <reiserfs_get_block>) at ./arch/x86/include/asm/jump_label.h:27
#4  0xffffffff821a3e3d in reiserfs_write_begin (file=<optimized out>, mapping=<optimized out>, pos=61440, len=1, pagep=<optimized out>, fsdata=<optimized out>) at fs/reiserfs/inode.c:2779
#5  0xffffffff81aec252 in generic_perform_write (iocb=iocb@entry=0xffffc9002130fb60, i=i@entry=0xffffc9002130fd00) at mm/filemap.c:3923
#6  0xffffffff81b0604e in __generic_file_write_iter (iocb=iocb@entry=0xffffc9002130fb60, from=from@entry=0xffffc9002130fd00) at mm/filemap.c:4051
#7  0xffffffff81b06383 in generic_file_write_iter (iocb=0xffffc9002130fb60, from=0xffffc9002130fd00) at mm/filemap.c:4083
#8  0xffffffff81e3240b in call_write_iter (file=0xffff888012692d00, iter=0xffffc9002130fd00, kio=0xffffc9002130fb60) at ./include/linux/fs.h:1868
#9  do_iter_readv_writev (filp=filp@entry=0xffff888012692d00, iter=iter@entry=0xffffc9002130fd00, ppos=ppos@entry=0xffffc9002130fe90, type=type@entry=1, flags=flags@entry=0) at fs/read_write.c:735
#10 0xffffffff81e33da4 in do_iter_write (flags=0, pos=0xffffc9002130fe90, iter=0xffffc9002130fd00, file=0xffff888012692d00) at fs/read_write.c:860
#11 do_iter_write (file=0xffff888012692d00, iter=0xffffc9002130fd00, pos=0xffffc9002130fe90, flags=0) at fs/read_write.c:841
#12 0xffffffff81e34611 in vfs_writev (file=file@entry=0xffff888012692d00, vec=vec@entry=0x20000480, vlen=vlen@entry=1, pos=pos@entry=0xffffc9002130fe90, flags=flags@entry=0) at fs/read_write.c:933
#13 0xffffffff81e34fd6 in do_pwritev (fd=fd@entry=5, vec=vec@entry=0x20000480, vlen=vlen@entry=1, pos=pos@entry=61440, flags=flags@entry=0) at fs/read_write.c:1030
#14 0xffffffff81e3b61f in __do_sys_pwritev2 (pos_h=<optimized out>, flags=0, pos_l=61440, vlen=1, vec=0x20000480, fd=5) at fs/read_write.c:1089
#15 __se_sys_pwritev2 (pos_h=<optimized out>, flags=0, pos_l=61440, vlen=1, vec=536872064, fd=5) at fs/read_write.c:1080
#16 __x64_sys_pwritev2 (regs=0xffffc9002130ff58) at fs/read_write.c:1080
#17 0xffffffff880dd279 in do_syscall_x64 (nr=<optimized out>, regs=0xffffc9002130ff58) at arch/x86/entry/common.c:50
#18 do_syscall_64 (regs=0xffffc9002130ff58, nr=<optimized out>) at arch/x86/entry/common.c:80
#19 0xffffffff8820008b in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:120
#20 0x0000000000406e00 in ?? ()
#21 0x00007f99e21b5000 in ?? ()
#22 0x0000000000000000 in ?? ()

After that, there is a very long loop doing:

Thread 5 hit Breakpoint 3, reiserfs_read_bitmap_block (sb=sb@entry=0xffff888066e28000, bitmap=bitmap@entry=1) at fs/reiserfs/bitmap.c:1417
1417	{
(gdb) c
Continuing.

Thread 5 hit Breakpoint 3, reiserfs_read_bitmap_block (sb=sb@entry=0xffff888066e28000, bitmap=bitmap@entry=2) at fs/reiserfs/bitmap.c:1417
1417	{
(gdb) 
Continuing.

and so on...

[  628.589974][ T6003] REISERFS warning (device loop0): sh-2029: %s: bitmap block (#%u) reading failed reiserfs_read_bitmap_block: reiserfs_read_bitmap_block

This message appears because we are here:

struct buffer_head *reiserfs_read_bitmap_block(struct super_block *sb,
                                               unsigned int bitmap)
{

[...]

	bh = sb_bread(sb, block);
	if (bh == NULL)
		reiserfs_warning(sb, "sh-2029: %s: bitmap block (#%u) "
		                 "reading failed", __func__, block);

The hanging task (kthread) is trying to hold the same lock, which
unfortunately is not going to be released soon:

static int reiserfs_sync_fs(struct super_block *s, int wait)
{

[...]

	reiserfs_write_lock(s);

I didn't get yet if the reason of this long loop is because we cannot
flush at this point, or just because of the test. I tried to
synchronously flush, but didn't make any difference.

I did a very simple change, which can be totally wrong:

@@ -94,7 +96,7 @@ static void flush_old_commits(struct work_struct *work)
         * trylock as reiserfs_cancel_old_flush() may be waiting for this work
         * to complete with s_umount held.
         */
-       if (!down_read_trylock(&s->s_umount)) {
+       if (sbi->lock_owner || !down_read_trylock(&s->s_umount)) {
                /* Requeue work if we are not cancelling it */
                spin_lock(&sbi->old_work_lock);
                if (sbi->work_queued == 1)


If the lock is held, instead of waiting, reschedule the flush.

Anyway, at least this report does not seem to be related to fixing
security xattrs.

Roberto

