Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4270FAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjEXPui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEXPuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:50:37 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58D93;
        Wed, 24 May 2023 08:50:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QRFj419Ltz9xFZy;
        Wed, 24 May 2023 23:39:04 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDXVQEvMm5kDA3ZAg--.2184S2;
        Wed, 24 May 2023 16:50:18 +0100 (CET)
Message-ID: <813148798c14a49cbdf0f500fbbbab154929e6ed.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>
Date:   Wed, 24 May 2023 17:50:03 +0200
In-Reply-To: <CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com>
References: <000000000000be039005fc540ed7@google.com>
         <00000000000018faf905fc6d9056@google.com>
         <CAHC9VhTM0a7jnhxpCyonepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDXVQEvMm5kDA3ZAg--.2184S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7ZFW8GryfJryxArW3GFg_yoW8Kw18pr
        WrGFnIkrsYvr1jyFn2vF1DWw1I9rZ5CrW7J3yDtryj9anaqrnrtrs29F4fW3yDCr4DCF90
        v3W3uwn5Xwn5u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj42dyAADso
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-24 at 11:11 -0400, Paul Moore wrote:
> On Wed, May 24, 2023 at 5:59 AM syzbot
> <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com> wrote:
> > syzbot has bisected this issue to:
> > 
> > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > Date:   Fri Mar 31 12:32:18 2023 +0000
> > 
> >     reiserfs: Add security prefix to xattr name in reiserfs_security_write()
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c39639280000
> > start commit:   421ca22e3138 Merge tag 'nfs-for-6.4-2' of git://git.linux-..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=13c39639280000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15c39639280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0a684c061589dcc30e51
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14312791280000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da8605280000
> > 
> > Reported-by: syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com
> > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Roberto, I think we need to resolve this somehow.  As I mentioned
> earlier, I don't believe this to be a fault in your patch, rather that
> patch simply triggered a situation that had not been present before,
> likely because the reiserfs code always failed when writing LSM
> xattrs.  Regardless, we still need to fix the deadlocks that sysbot
> has been reporting.

Hi Paul

ok, I will try.

Roberto

> Has anyone dug into the reiserfs code to try and resolve the deadlock?
>  Considering the state of reiserfs, I'm guessing no one has, and I
> can't blame them; I personally would have a hard time justifying
> significant time spent on reiserfs at this point.  Unless someone has
> any better ideas, I'm wondering if we shouldn't just admit defeat with
> reiserfs and LSM xattrs and disable/remove the reiserfs LSM xattr
> support?  Given the bug that Roberto was fixing with the patch in
> question, it's unlikely this was working anyway.
> 
> --
> paul-moore.com

