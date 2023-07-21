Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413675BDA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGUFHj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 01:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUFHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:07:37 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B0B3;
        Thu, 20 Jul 2023 22:07:36 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qMiML-003uNu-Uj; Fri, 21 Jul 2023 07:07:21 +0200
Received: from p57bd98fd.dip0.t-ipconnect.de ([87.189.152.253] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qMiML-0015U5-MU; Fri, 21 Jul 2023 07:07:21 +0200
Message-ID: <5ef77167046ad0a3e6d05433411c995c245464a8.camel@physik.fu-berlin.de>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        debian-powerpc <debian-powerpc@lists.debian.org>
Date:   Fri, 21 Jul 2023 07:07:20 +0200
In-Reply-To: <47a12957-9d9b-4134-0736-bedb15428627@gmail.com>
References: <000000000000dbce4e05f170f289@google.com>
         <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
         <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
         <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
         <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
         <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
         <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
         <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
         <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
         <ZLlvII/jMPTT32ef@casper.infradead.org>
         <b93ff5ca1ecd40084cd7a18e8490bf4e421fd6b9.camel@physik.fu-berlin.de>
         <47a12957-9d9b-4134-0736-bedb15428627@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.152.253
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Michael!

On Fri, 2023-07-21 at 07:05 +1200, Michael Schmitz wrote:
> Installing a new kernel to the HFS filesystem, or a boot loader like 
> yaboot, might be another matter. But there still is an user space option 
> like hfsutils or hfsplus.

Both won't work with GRUB. grub-install expects the boot partition to be
mounted while hfsutils/hfsplus don't use the VFS layer.

> That said, in terms of the argument about USB media with corrupt HFS 
> filesystems presenting a security risk, I take the view that once you 
> have physical access to a system, all bets are off. Doubly so if 
> auto-mounting USB media is enabled.

I also don't understand why this was brought up. There are so many other
potential options for attacking computer, even remotely. We also didn't
drop x86 support after all these CPU vulnerabilities were discovered, did
we?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
