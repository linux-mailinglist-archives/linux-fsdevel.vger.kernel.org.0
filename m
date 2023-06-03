Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10521720E15
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 08:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFCGUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 02:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCGUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 02:20:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9DE58;
        Fri,  2 Jun 2023 23:20:40 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QY8qn0xkpzTkkG;
        Sat,  3 Jun 2023 14:20:21 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 14:20:35 +0800
Message-ID: <eb35999d-dc81-44d1-fbe2-a7aa6d5f01b3@huawei.com>
Date:   Sat, 3 Jun 2023 14:20:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] Monthly ext4 report (May 2023)
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     syzbot <syzbot+list5ea887c46d22b2acf805@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>,
        yangerkun <yangerkun@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <000000000000834af205fce87c00@google.com>
 <df5e7e7d-875c-8e5d-1423-82ec58299b1b@huawei.com>
 <20230602210639.GA1154817@mit.edu>
 <d9be3fbf-023c-ac55-5097-ea3f43a946b4@huawei.com>
 <20230603043028.GE1128875@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230603043028.GE1128875@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/3 12:30, Theodore Ts'o wrote:
> On Sat, Jun 03, 2023 at 10:05:44AM +0800, Baokun Li wrote:
>> There are many sources of syzkaller issues, and the patches I send out
>> to fix syzkaller issues add Reported-by to all but the ones that fix issues
>> reported by our internal syzbot.
>> However, there may be multiple syzbot reports for the same issue.
> Yes, that happens a lot especially for Lockdep reports; depending on
> how the reproducer triggers the locks in which order, there can often
> be multiple different lockdep signatures, and Syzkaller can't tell
> that they are all the same thing.
>
> I tend to focus on syzbot reproducers on the upstream Linux instance,
> rather than the Android-5.15 syzkaller instance.  And that allows me
> to use the ext4 subsystem dashboard available at:
>
> 	https://syzkaller.appspot.com/upstream/s/ext4
>
> It's against this list of reports that the Monthly ext4 report is
> generated.  So if people who are submitting fixes against syzkaller
> reports, it would be nice if they were to check the ext4 dashboard
> above to look for syzbot reports that might be also relevant to your
> patch.
>
> Thanks,
>
> 					- Ted
>
OK, later to fix any ext4 issue, I will check if the issue is in the ext4
subsystem dashboard.

Thanks!
-- 
With Best Regards,
Baokun Li
.
