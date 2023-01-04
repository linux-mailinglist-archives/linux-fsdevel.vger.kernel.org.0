Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0763165E0AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 00:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjADW7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 17:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjADW7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:59:03 -0500
X-Greylist: delayed 949 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 14:58:29 PST
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C435485A7;
        Wed,  4 Jan 2023 14:58:28 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pDCSl-002aIy-VA; Wed, 04 Jan 2023 23:42:23 +0100
Received: from p57bd94ed.dip0.t-ipconnect.de ([87.189.148.237] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pDCSl-001ZIc-OQ; Wed, 04 Jan 2023 23:42:23 +0100
Message-ID: <41b7b553-e7e7-58ae-532e-37234f21b80d@physik.fu-berlin.de>
Date:   Wed, 4 Jan 2023 23:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-m68k@lists.linux-m68k.org
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
Content-Language: en-US
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.237
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Arnd!

On 1/4/23 23:33, Arnd Bergmann wrote:
> Adding Viacheslav Dubeyko to Cc, he's at least been reviewing
> patches for HFS and HFS+ somewhat recently. The linux-m68k
> list may have some users dual-booting old MacOS.

HFS/HFS+ is also used by PowerPC users on PowerMac hardware for both
exchanging data between MacOS and Linux as well as for booting Linux
using GRUB with a HFS/HFS+ /boot partition.

Debian's grub-installer creates an HFS partition from which GRUB loads
the kernel and the initrd [1]. In order to be able to update kernel and
initrd, the running Linux system needs to be able to read/write HFS/HFS+
partitions which is used for the /boot partition.

Adrian

> [1] https://salsa.debian.org/installer-team/grub-installer/-/blob/master/grub-installer#L918

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

