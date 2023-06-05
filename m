Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A37722625
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjFEMmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjFEMmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:42:51 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8422FDA;
        Mon,  5 Jun 2023 05:42:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QZY076XM8z9yhr6;
        Mon,  5 Jun 2023 20:32:23 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwA3muUp2H1kqFsRAw--.4008S2;
        Mon, 05 Jun 2023 13:42:27 +0100 (CET)
Message-ID: <6a9f6314f21c5e4dd2960c12626e14c4ce8c8163.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>,
        Jeff Mahoney <jeffm@suse.com>
Date:   Mon, 05 Jun 2023 14:42:13 +0200
In-Reply-To: <20230605123604.7juo5siuooy2dip2@quack3>
References: <000000000000be039005fc540ed7@google.com>
         <00000000000018faf905fc6d9056@google.com>
         <CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com>
         <813148798c14a49cbdf0f500fbbbab154929e6ed.camel@huaweicloud.com>
         <CAHC9VhRoj3muyD0+pTwpJvCdmzz25C8k8eufWcjc8ZE4e2AOew@mail.gmail.com>
         <58cebdd9318bd4435df6c0cf45318abd3db0fff8.camel@huaweicloud.com>
         <20230530112147.spvyjl7b4ss7re47@quack3>
         <20230605123604.7juo5siuooy2dip2@quack3>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwA3muUp2H1kqFsRAw--.4008S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7AFWxuw18Zr1UCF15urg_yoW5trWrpr
        WUGF1YkFs8tr1Utr40qF1DGwnFgrWrtrW7X3yUtr18ua1vqrnrJr4I9r47urWDGr1DCF90
        yF15Z343Zr1ru37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4o6XQAAsJ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-06-05 at 14:36 +0200, Jan Kara wrote:
> On Tue 30-05-23 13:21:47, Jan Kara wrote:
> > On Fri 26-05-23 11:45:57, Roberto Sassu wrote:
> > > On Wed, 2023-05-24 at 17:57 -0400, Paul Moore wrote:
> > > > On Wed, May 24, 2023 at 11:50 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Wed, 2023-05-24 at 11:11 -0400, Paul Moore wrote:
> > > > > > On Wed, May 24, 2023 at 5:59 AM syzbot
> > > > > > <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com> wrote:
> > > > > > > syzbot has bisected this issue to:
> > > > > > > 
> > > > > > > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > > > > > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > Date:   Fri Mar 31 12:32:18 2023 +0000
> > > > > > > 
> > > > > > >     reiserfs: Add security prefix to xattr name in reiserfs_security_write()
> > > > > > > 
> > > > > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c39639280000
> > > > > > > start commit:   421ca22e3138 Merge tag 'nfs-for-6.4-2' of git://git.linux-..
> > > > > > > git tree:       upstream
> > > > > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=13c39639280000
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15c39639280000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0a684c061589dcc30e51
> > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14312791280000
> > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da8605280000
> > > > > > > 
> > > > > > > Reported-by: syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com
> > > > > > > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")
> > > > > > > 
> > > > > > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > > > > 
> > > > > > Roberto, I think we need to resolve this somehow.  As I mentioned
> > > > > > earlier, I don't believe this to be a fault in your patch, rather that
> > > > > > patch simply triggered a situation that had not been present before,
> > > > > > likely because the reiserfs code always failed when writing LSM
> > > > > > xattrs.  Regardless, we still need to fix the deadlocks that sysbot
> > > > > > has been reporting.
> > > > > 
> > > > > Hi Paul
> > > > > 
> > > > > ok, I will try.
> > > > 
> > > > Thanks Roberto.  If it gets to be too challenging, let us know and we
> > > > can look into safely disabling the LSM xattrs for reiserfs, I'll be
> > > > shocked if anyone is successfully using LSM xattrs on reiserfs.
> > > 
> > > Ok, at least I know what happens...
> > > 
> > > + Jan, Jeff
> > > 
> > > I'm focusing on this reproducer, which works 100% of the times:
> > > 
> > > https://syzkaller.appspot.com/text?tag=ReproSyz&x=163079f9280000
> > 
> > Well, the commit d82dcd9e21b ("reiserfs: Add security prefix to xattr name
> > in reiserfs_security_write()") looks obviously broken to me. It does:
> > 
> > char xattr_name[XATTR_NAME_MAX + 1] = XATTR_SECURITY_PREFIX;
> > 
> > Which is not how we can initialize strings in C... ;)
> 
> I'm growing old or what but indeed string assignment in initializers in C
> works fine. It is only the assignment in code that would be problematic.
> I'm sorry for the noise.

Cool, thanks!

It seems the difference with just doing memcpy() is that the compiler
fully initializes the array (256 bytes), instead of copying the
required amount.

Roberto

