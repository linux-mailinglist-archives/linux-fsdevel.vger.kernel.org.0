Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506C4421884
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 22:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhJDUlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhJDUlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:41:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC093C061745;
        Mon,  4 Oct 2021 13:39:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so69645557edv.12;
        Mon, 04 Oct 2021 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZN0FZqiP/tSKJWvjzWYzmirjI6tOAf0Xm/PBKsW4sfw=;
        b=h2cfSXzFHnOs2RG1zFw4/Hbm0AsiK7htA4HPaBZzTiqOkkC3SsuOxhfpfYgJdjbeZZ
         0Rx/ZMcFwwk02BW2clsVJqhOz0cOddt9jLQ+/H1AU9jww3pndDE9YCmK84V9/ovlU2VV
         NNb5TIYvTmQkmMTX3nHQaNC6jXKk66GtEEOLoPxrOYnlMwWgT8slfN7L+zzUlqDhaTxq
         VO6TfJTfIAfpEI9ZccJnv4D9hAJspWOuPcD3ry7gmxB6GOzNigj2JhEemV8o3bnHeH6n
         70mVCV1ABHlu+RK/LKv39BFz0GYBZltup8FMu4Lj01acOYR/kH8/7bsmW5KbJntRmUp/
         /HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZN0FZqiP/tSKJWvjzWYzmirjI6tOAf0Xm/PBKsW4sfw=;
        b=FPVTlKtYr0tX+B5rliKFiXIrq/Wru6xOq4+ObCrBFYRssGOn09kDvb7eWzHL2mWaKz
         qQPWDbhSncVwqkLobNBsWmfo15v1ygvfGwJjxMONN36S9QzOAITvzP8qCUG7mS9SshCG
         P4ne1OEIUHU0VhCu0SvTFvqr9Kkr0ocP4S3qbL0xZF0ffk9TJxa1RyQzzx8n91keyrPR
         gZj88C2QzG+GWwNcmp93WyY31M7GfL76+tVBQHkIO4TsuBHfaroT/+fmX66SnLjS1KVw
         ruqFW4Yxd0jRODry6KRX+I8Sw6pLiEDDmbIm33jx/FOZwNzZrcXhLegwbpXMzNhQBa3U
         3YNg==
X-Gm-Message-State: AOAM532+kigPDnxb3LgHfuo5/3yY4VRLgMbwROYbxN3UUUKfgrQOG/ox
        66VbsmooSDGu512r4aZvd4k=
X-Google-Smtp-Source: ABdhPJwZYA4EE+PMu0+hSaaxzWRZvxH2qJ1DMJkDue1lDN5kb4rMvrSJsvb4b5GwxG9ohUGTYwoOMg==
X-Received: by 2002:a17:906:7ce:: with SMTP id m14mr19702350ejc.192.1633379988142;
        Mon, 04 Oct 2021 13:39:48 -0700 (PDT)
Received: from [192.168.0.163] ([37.239.218.18])
        by smtp.gmail.com with ESMTPSA id dn10sm7559243edb.84.2021.10.04.13.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:39:47 -0700 (PDT)
Message-ID: <c892016c-3e50-739b-38d2-010f02d52019@gmail.com>
Date:   Mon, 4 Oct 2021 23:39:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
 <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
In-Reply-To: <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/3/21 20:50, Kari Argillander wrote:
> On Wed, Sep 29, 2021 at 07:35:43PM +0300, Konstantin Komarov wrote:
>> This can be reason for reported panic.
>> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> I see that you have include this to devel branch but you did not send V2
> [1]. I also included Mohammad Rasim to this thread. Maybe they can test
> this patch. Rasim can you test [2] if your problem will be fixed with
> this tree. Or just test this patch if you prefer that way.
>
> [1]: github.com/Paragon-Software-Group/linux-ntfs3/commit/35afb70dcfe4eb445060dd955e5b67d962869ce5
> [2]: github.com/Paragon-Software-Group/linux-ntfs3/tree/devel

Yeah unfortunately the problem still exist, moving the buildroot git 
tree from my nvme ext4 partition to my wd ntfs partition still causes 
the panic.

Note that i used the master branch if that matters but it contains the 
same commit


Regards

>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> ---
>>   fs/ntfs3/frecord.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>> index 9a53f809576d..007602badd90 100644
>> --- a/fs/ntfs3/frecord.c
>> +++ b/fs/ntfs3/frecord.c
>> @@ -3080,7 +3080,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>>                          const struct EA_INFO *info;
>>   
>>                          info = resident_data_ex(attr, sizeof(struct EA_INFO));
>> -                       dup->ea_size = info->size_pack;
>> +                       /* If ATTR_EA_INFO exists 'info' can't be NULL. */
>> +                       if (info)
>> +                               dup->ea_size = info->size_pack;
>>                  }
>>          }
>>   
>> -- 
>> 2.33.0
>>
