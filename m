Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C982719061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 04:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjFACJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 22:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFACI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 22:08:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3E0123;
        Wed, 31 May 2023 19:08:55 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QWqF94Sn8zqTb3;
        Thu,  1 Jun 2023 10:04:13 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 10:08:53 +0800
Message-ID: <df5e7e7d-875c-8e5d-1423-82ec58299b1b@huawei.com>
Date:   Thu, 1 Jun 2023 10:08:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Baokun Li <libaokun1@huawei.com>
Subject: Re: [syzbot] Monthly ext4 report (May 2023)
To:     syzbot <syzbot+list5ea887c46d22b2acf805@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>
CC:     Baokun Li <libaokun1@huawei.com>, yangerkun <yangerkun@huawei.com>
References: <000000000000834af205fce87c00@google.com>
Content-Language: en-US
In-Reply-To: <000000000000834af205fce87c00@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/5/30 20:38, syzbot wrote:
> Hello ext4 maintainers/developers,
>
> This is a 31-day syzbot report for the ext4 subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/ext4
>
> During the period, 3 new issues were detected and 10 were fixed.
> In total, 46 issues are still open and 106 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 124     Yes   kernel BUG in ext4_do_writepages
>                    https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
> <2> 48      No    WARNING in ext4_write_inode (2)
>                    https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
> <3> 8       Yes   WARNING in ext4_da_update_reserve_space (2)
>                    https://syzkaller.appspot.com/bug?extid=a1232eabd7a3d43d4fb5
> <4> 8       Yes   kernel BUG in __ext4_journal_stop
>                    https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
> <5> 7       Yes   kernel BUG in ext4_write_inline_data
>                    https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
>
> ---
>

Hello, Theodore!

Patch "[PATCH v2] ext4: fix race condition between buffer write and 
page_mkwrite​"
in maillist fixes issues <1>,<4>,<5>.

Patch set "[PATCH v4 00/12] ext4: fix WARNING in 
ext4_da_update_reserve_space"
in maillist fixes issues <3>.

These patches have been reviewed, could you have time to merge them in?
I would appreciate it if you could.

Thanks!
-- 
With Best Regards,
Baokun Li
.
