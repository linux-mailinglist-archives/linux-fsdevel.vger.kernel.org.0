Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBA59983A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347695AbiHSIzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347916AbiHSIzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:55:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9CBD21F1;
        Fri, 19 Aug 2022 01:55:12 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M8Fv23xTKz67y8J;
        Fri, 19 Aug 2022 16:54:54 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 10:55:10 +0200
Received: from [10.122.132.241] (10.122.132.241) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 09:55:09 +0100
Message-ID: <a8670f06-83ea-2a72-f13d-ac9f839dd1f8@huawei.com>
Date:   Fri, 19 Aug 2022 11:55:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 2/4] selftests/landlock: Selftests for file truncation
 support
Content-Language: ru
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        <linux-fsdevel@vger.kernel.org>,
        anton Sirazetdinov <anton.sirazetdinov@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <20220817203006.21769-3-gnoack3000@gmail.com>
 <e90aaa5d-d6c8-838a-db29-868a30fd8e37@digikod.net> <Yv8elmJ4qfk8/Mw7@nuc>
 <86b013ed-b809-f533-5764-60b22272dce9@digikod.net>
 <2e7afd64-d36f-f81d-2ae4-1a99769e173c@digikod.net>
From:   "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
In-Reply-To: <2e7afd64-d36f-f81d-2ae4-1a99769e173c@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.132.241]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



8/19/2022 11:36 AM, Mickaël Salaün пишет:
> FYI, my -next branch is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
> 
> Günther, let me know if everything is OK.
> 
> Konstantin, please rebase your work on it. It should mainly conflict
> with changes related to the Landlock ABI version.

   Ok. I will rebase. Thnaks. Do I need to keep my next versions on your 
-next branch?
> 
> 
> On 19/08/2022 10:15, Mickaël Salaün wrote:
>> Ok, it should be in -next soon. Thanks for your contribution!
>> 
>> Would you like to write a syzkaller test to cover this new access right?
>> You only need to update the landlock_fs_accesses file with a call to
>> truncate() returning EACCES and check that it covers
>> hook_path_truncate(). You can take inspiration from this PR:
>> https://github.com/google/syzkaller/pull/3133
>> Please CC me, I can help.
>> 
>> Regards,
>>    Mickaël
>> 
>> 
>> On 19/08/2022 07:24, Günther Noack wrote:
>>> On Thu, Aug 18, 2022 at 10:39:27PM +0200, Mickaël Salaün wrote:
>>>> On 17/08/2022 22:30, Günther Noack wrote:
>>>>> +/*
>>>>> + * Invokes creat(2) and returns its errno or 0.
>>>>> + * Closes the opened file descriptor on success.
>>>>> + */
>>>>> +static int test_creat(const char *const path, mode_t mode)
>>>>
>>>> This "mode" argument is always 0600. If it's OK with you, I hard code this
>>>> mode and push this series to -next with some small cosmetic fixes.
>>>
>>> Yes, absolutely. Please do these fixes and push it to -next. :)
>>>
>>> Thanks,
>>> —Günther
>>>
>>> --
> .
