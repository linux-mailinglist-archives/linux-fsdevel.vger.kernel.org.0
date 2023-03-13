Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4766B84A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 23:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCMWRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCMWRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBAD8C822;
        Mon, 13 Mar 2023 15:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 988A5614F1;
        Mon, 13 Mar 2023 22:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EE5C433EF;
        Mon, 13 Mar 2023 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678745870;
        bh=INaHVbl7ixdOi1NsOn+7HYfFqqNPUGFYQtn80pPPDKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lE/NADRFUTKbkwWVHMD+KKs4k9J+dIrxKta06me0F/R2gzq8UK3j5fVIP789xIt31
         aHzMy3KqQgrkw39E1lZ3z1wJdh/1M4SLMRMgw5cHC0cPq6vMCkYVrvSFyv237XvJbz
         C81mfqgbYoJp/Z3oiP1Y4q6Q/20Ki9TBPH5I1oJiv6md00RW5gvxUhSXjC+TnbjZHH
         elq2sLypxZfiwpuwye3y4ik61DU+p+HBbMkbjMdBnn9539L1nGIQFq/0MfTvzAtrZ/
         jr/uBFkYBoErAJeAzH6k6Mmp2VkgQBMCnaI/1WFCpqXP+kku6ihzwklCM4warNfkSd
         Wdj/jMDYTbTQw==
Date:   Mon, 13 Mar 2023 15:17:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+93e495f6a4f748827c88@syzkaller.appspotmail.com>
Cc:     jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [fscrypt?] WARNING in fscrypt_destroy_keyring
Message-ID: <ZA+hDI+bIx2H7QYz@sol.localdomain>
References: <00000000000044651705f6ca1e30@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000044651705f6ca1e30@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 08:53:55AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe15c26ee26e Linux 6.3-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e2d88ac80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=93e495f6a4f748827c88
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16171188c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ac08dac80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/89d41abd07bd/disk-fe15c26e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fa75f5030ade/vmlinux-fe15c26e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/590d0f5903ee/Image-fe15c26e.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/bf3b409baf10/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+93e495f6a4f748827c88@syzkaller.appspotmail.com
> 
> EXT4-fs (loop0): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 without journal. Quota mode: writeback.
> fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-ce"
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5945 at fs/crypto/keyring.c:237 fscrypt_destroy_keyring+0x164/0x240 fs/crypto/keyring.c:237

Very impressive find by syzbot!  fscrypt_destroy_keyring() needs to be called
after security_sb_delete(), not before.  Fix is
https://lore.kernel.org/linux-fscrypt/20230313221231.272498-2-ebiggers@kernel.org

- Eric
