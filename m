Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5652EE7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350484AbiETOuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbiETOuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 10:50:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A9163F47
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 07:50:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z3so6429826pgn.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=YlMUufwr0l9tO9rVDIxOV/soI8WTUMwn/+RPr0+aDoU=;
        b=cz0wk8lcDszKFG3qX7rWCqzlqco9Sek/q86lTVGXVgDOoWtHf6JHnKv52/V1kI8GsY
         tNhwHBCWrGXadYVN5kY78XCACyEuD+6h2Hi4/M3ErbKa5FZxFDBExxTLIs+GXtyLB+mE
         rpPWbcyQ4DRaczSqCmY9GcIY644HfOExpwuZ1zTxkdZlJksBjavAN0Yx1JMdObEEoMfq
         FwKDI9pJX77DEPyEmJ3qlksOG7v2PfcBVqSE0yDqwcXVEI65BIuXZT+qiJtNDO7ov/g6
         JnGxVhPaVYO1ZDjM8zlutZROY7BlGoiyfmC57e8wywTsviMatf6ek/1z4itHFNcDOiHn
         7rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=YlMUufwr0l9tO9rVDIxOV/soI8WTUMwn/+RPr0+aDoU=;
        b=vEwhZrLz34ssBG/JNYVchW8ifk/AzgW8z85RwbeAd7Y0XsVfnw+k6wsolpbcfEt6yh
         XYUebsxXpGppvMFke9TzPm56T4RIIbXktvwWAV/gaKhCidUjNIlbro4AgRt8mUWyyfmB
         wFEDWA1wIUHH6thTllJXVYlECJSc5ERMKhewznXcLUp/5HGMYCo2s+Okf14O/yMRDkVf
         CwYRlM5kB6yVLncTy1lNUZ4ZNt6N1OmDPEA/IAklaAT8cx38SJ6zvc+CLqilDlEKmdgj
         loCSU0Go5JAqzmHJF75wT4qDvtwqe2Bbs9xmkgg2b6ALQvC1tAbRv9nw/J8/nrMIlFjb
         CVKg==
X-Gm-Message-State: AOAM531QsvOJXivrchEXj4BfM/LJLX73L10KTY7s08SBa1EZBGpTN0Ib
        BPMaGnxCto4U6ehw63oZADttUQ==
X-Google-Smtp-Source: ABdhPJy1cIKEs7ndrkw7m80u2H+7m8NPgK6uDNE3lOEbmri0iW/ey3hMLMu3ycAdyZmLlukUP0c5QQ==
X-Received: by 2002:a63:fc04:0:b0:3f6:4b2b:9d36 with SMTP id j4-20020a63fc04000000b003f64b2b9d36mr6451721pgi.206.1653058221601;
        Fri, 20 May 2022 07:50:21 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0015ea9aabd19sm5892769pln.241.2022.05.20.07.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:50:21 -0700 (PDT)
Message-ID: <983bb802-d883-18d4-7945-dbfa209c1cc8@linaro.org>
Date:   Fri, 20 May 2022 07:50:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <49ac1697-5235-ca2e-2738-f0399c26d718@linaro.org>
 <20220519122353.eqpnxiaybvobfszb@quack3.lan>
 <e9ccb919-1616-f94f-c465-7024011ad8e5@linaro.org>
 <20220520095028.rq4ef2o5nwetzog3@quack3>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: kernel BUG in ext4_writepages
In-Reply-To: <20220520095028.rq4ef2o5nwetzog3@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/20/22 02:50, Jan Kara wrote:
> On Thu 19-05-22 16:14:17, Tadeusz Struk wrote:
>> On 5/19/22 05:23, Jan Kara wrote:
>>> Hi!
>>>
>>> On Tue 10-05-22 15:28:38, Tadeusz Struk wrote:
>>>> Syzbot found another BUG in ext4_writepages [1].
>>>> This time it complains about inode with inline data.
>>>> C reproducer can be found here [2]
>>>> I was able to trigger it on 5.18.0-rc6
>>>>
>>>> [1] https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
>>>> [2] https://syzkaller.appspot.com/text?tag=ReproC&x=129da6caf00000
>>>
>>> Thanks for report. This should be fixed by:
>>>
>>> https://lore.kernel.org/all/20220516012752.17241-1-yebin10@huawei.com/
>>
>>
>> In case of the syzbot bug there is something messed up with PAGE DIRTY flags
>> and the way syzbot sets up the write. This is what triggers the crash:
> 
> Can you tell me where exactly we hit the bug? I've now noticed that this is
> on 5.10 kernel and on vanilla 5.10 there's no BUG_ON on line 2753.

We are hiting this bug:
https://elixir.bootlin.com/linux/latest/source/fs/ext4/inode.c#L2707
Syzbot found it in v5.10, but I recreated it on 5.18-rc7, that's why
the line number mismatch. But this is the same bug.
On 5.10 it's in line 2739:
https://elixir.bootlin.com/linux/v5.10.117/source/fs/ext4/inode.c#L2739

> 
>> $ ftrace -f ./repro
>> ...
>> [pid  2395] open("./bus", O_RDWR|O_CREAT|O_SYNC|O_NOATIME, 000 <unfinished ...>
>> [pid  2395] <... open resumed> )        = 6
>> ...
>> [pid  2395] write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 22 <unfinished ...>
>> ...
>> [pid  2395] <... write resumed> )       = 22
>>
>> One way I could fix it was to clear the PAGECACHE_TAG_DIRTY on the mapping in
>> ext4_try_to_write_inline_data() after the page has been updated:
>>
>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>> index 9c076262770d..e4bbb53fa26f 100644
>> --- a/fs/ext4/inline.c
>> +++ b/fs/ext4/inline.c
>> @@ -715,6 +715,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
>>   			put_page(page);
>>   			goto out_up_read;
>>   		}
>> +		__xa_clear_mark(&mapping->i_pages, 0, PAGECACHE_TAG_DIRTY);
>>   	}
>>   	ret = 1;
>>
>> Please let me know it if makes sense any I will send a proper patch.
> 
> No, this looks really wrong... We need to better understand what's going
> on.

So I was afraid. I'm trying to diverge the ext4_writepages() to go to the
out_writepages path before we hit this BOG_ON().
Any hints will be much appreciated.

-- 
Thanks,
Tadeusz
