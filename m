Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99550740C4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjF1JEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjF1IuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7862956;
        Wed, 28 Jun 2023 01:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E4661260;
        Wed, 28 Jun 2023 08:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA6FC433C8;
        Wed, 28 Jun 2023 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687942014;
        bh=a7qYYMfvhrkx8GjWo17aDb5hBm4by7dQQM443cV8Zng=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=BLeDWM/ynvXrBgTAarLsb/JRDmY8GGAr9/YtCTnzMOVELGRQ7ebxSs05lhERYNOr0
         NrUpPUw6MkZJQ2NVW4Gizlury5z21Z+aTBZeplCjB6k3e3sZxZYBba/adjmSHCW7La
         5XaWs6vFI2MxatVH7QTAj1BTI7Mu9jVO5XlNJ7Am5scGvlYcCR27MD4POBmx4lt0RB
         dVR4O8WEvaerJbHtobCC+gFc7ecLAL+kZaV5JIOmtioxMuXNqh8Ek+e389UtlnEpzI
         QfRa62rA6DPoI6DFwwF1ijn039snDraz5u3tYbWMzorixSukg7Z8mjpjrZSbKfeCmf
         3Gi5GncuKI2dQ==
Message-ID: <55a80df7-0725-d36c-566b-24cdf2dfd6da@kernel.org>
Date:   Wed, 28 Jun 2023 16:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_fiemap
Content-Language: en-US
To:     syzbot <syzbot+dd6352699b8027673b35@syzkaller.appspotmail.com>,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000ded70105fef7cd35@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000ded70105fef7cd35@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/26 1:45, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15e71592dbae Add linux-next specific files for 20230621
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=101c827b280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4e51841f618f374
> dashboard link: https://syzkaller.appspot.com/bug?extid=dd6352699b8027673b35
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6b6464ef4887/disk-15e71592.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/81eba5775318/vmlinux-15e71592.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bc7983587629/bzImage-15e71592.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dd6352699b8027673b35@syzkaller.appspotmail.com
> 
> loop4: detected capacity change from 0 to 40427
> F2FS-fs (loop4): Found nat_bits in checkpoint
> F2FS-fs (loop4): Mounted with checkpoint version = 48b305e5
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.4.0-rc7-next-20230621-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.4/7658 is trying to acquire lock:
> ffff888012869e20 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0xb2/0x190 mm/memory.c:5716
> 
> but task is already holding lock:
> ffff8880865b1a10 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
> ffff8880865b1a10 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: f2fs_fiemap+0x1e3/0x1670 fs/f2fs/data.c:1998

This was caused by the patch
"f2fs: fix to avoid mmap vs set_compress_option case"
(https://lore.kernel.org/linux-f2fs-devel/20230529104709.2560779-1-chao@kernel.org/)
which has been dropped.

#syz set subsystems: f2fs
#syz invalid
