Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B1707084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 20:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEQSPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 14:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQSPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 14:15:21 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA597ED0;
        Wed, 17 May 2023 11:15:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VitiUur_1684347313;
Received: from 30.13.129.94(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VitiUur_1684347313)
          by smtp.aliyun-inc.com;
          Thu, 18 May 2023 02:15:16 +0800
Message-ID: <85c61aae-6716-9936-1533-91624f70eefe@linux.alibaba.com>
Date:   Thu, 18 May 2023 02:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [syzbot] [erofs?] general protection fault in erofs_bread (2)
To:     syzbot <syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com>,
        chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
References: <000000000000d03b0805fbe71d55@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <000000000000d03b0805fbe71d55@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/18 10:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=114aa029280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6beb6ffe4f59ef2a
> dashboard link: https://syzkaller.appspot.com/bug?extid=bbb353775d51424087f2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd834e280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167ef106280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4adf207e9d5e/disk-f1fcbaa1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9e7cce92f611/vmlinux-f1fcbaa1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cfd911b80f89/bzImage-f1fcbaa1.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a2583fbaaf14/mount_2.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bbb353775d51424087f2@syzkaller.appspotmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
