Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261B675BBDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 03:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGUBia convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 21:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGUBi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:38:28 -0400
X-Greylist: delayed 580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 18:38:26 PDT
Received: from powerslave.purple-cat.net (powerslave.purple-cat.net [182.54.165.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A022727;
        Thu, 20 Jul 2023 18:38:26 -0700 (PDT)
Received: from smtpclient.apple (138.76.224.49.dyn.cust.vf.net.nz [49.224.76.138])
        (Authenticated sender: mike@purple-cat.net)
        by powerslave.purple-cat.net (Postfix) with ESMTPA id 36002114006B;
        Fri, 21 Jul 2023 13:28:37 +1200 (NZST)
Authentication-Results: powerslave.purple-cat.net;
        auth=pass smtp.auth=mike@purple-cat.net smtp.mailfrom=mike@purple-cat.net
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Mike Hosken <mike@purple-cat.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Date:   Fri, 21 Jul 2023 13:28:25 +1200
Message-Id: <933DF777-0CE9-4DFE-B7C7-AF095919E4F0@purple-cat.net>
References: <CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jeffrey Walton <noloader@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>,
        torvalds@linux-foundation.org
In-Reply-To: <CAHk-=wg7DSNsHY6tWc=WLeqDBYtXges_12fFk1c+-No+fZ0xYQ@mail.gmail.com>
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removing support for a file system and dam the user base who happily and actively use the file system is never the right option. 

There are always a lot of users who use so called obsolete hardware and various software to support their needs every day. They don’t subscribe to mailing lists or are in no way active in the community and they depend on Linux continuing to support them. Changing the status quo for a particularly narrow attack surface should never be taken. 

Not having a maintainer is not ideal but the code has been very reliable and as the saying goes if it’s not broken ……..

If a serious problem did come up with this file system there are a number of developers that could do a fix and not be its full time maintainer. 

Calling for the removal is just nonsensical to me. 

Mike Hosken 
Sent via my iPhone 

> On 21/07/2023, at 11:12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> ﻿On Thu, 20 Jul 2023 at 15:37, Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> I think you're missing the context.  There are bugs in how this filesystem
>> handles intentionally-corrupted filesystems.  That's being reported as
>> a critical bug because apparently some distributions automount HFS/HFS+
>> filesystems presented to them on a USB key.  Nobody is being paid to fix
>> these bugs.  Nobody is volunteering to fix these bugs out of the kindness
>> of their heart.  What choice do we have but to remove the filesystem,
>> regardless of how many happy users it has?
> 
> You're being silly.
> 
> We have tons of sane options. The obvious one is "just don't mount
> untrusted media".
> 
> Now, the kernel doesn't know which media is trusted or not, since the
> kernel doesn't actually see things like /etc/mtab and friends. So we
> in the kernel can't do that, but distros should have a very easy time
> just fixing their crazy models.
> 
> Saying that the kernel should remove a completely fine filesystem just
> because some crazy use-cases that nobody cares about are broken, now
> *that* just crazy.
> 
> Now, would it be good to have a maintainer for hgs? Obviously. But no,
> we don't remove filesystems just because they don't have maintainers.
> 
> And no, we have not suddenly started saying "users don't matter".
> 
>          Linus
> 
