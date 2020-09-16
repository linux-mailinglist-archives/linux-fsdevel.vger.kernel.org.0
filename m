Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7595E26BBD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIPFfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:35:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530ABC06174A;
        Tue, 15 Sep 2020 22:35:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so3319776pfg.2;
        Tue, 15 Sep 2020 22:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wg5xzTeDR6/ErfcIIGXE7hY+7jwGvkfmvZH4P0TmQu8=;
        b=TRKpzrw5M6Nut1NLIWdWvSdBlh8Je4QruSEH2TUSupr8VcsGv2wj6evavoR75mJbCB
         fw+RywoAtIOZwEaYNaexgU8HxtBPpQaBsjw9f9hk3ZD3QjTJQ4+Xob/AoJAHHI/zfko0
         +bxV5ge9z0vr4H0YVNeHeoUCBSTeaX9mp4/PcWC9iKgmI6zNH+ekEQIfkN0gtngX1sY5
         HSGAijMqpFnJOtD05tzEbRIoabw80OtHBoNNdFFMJwot8HS4f8dvcGZHeN8LQ+LX6cRK
         CLW6uQg8zGre0dlL/ArP6m5Bg+DchRnjKF7tONYkdNUlC73NXkyv9ew/0QI/+kYi446w
         8tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wg5xzTeDR6/ErfcIIGXE7hY+7jwGvkfmvZH4P0TmQu8=;
        b=CIkSjXoTHU0qWFo8e8RvqlmFIM5b7K/ZokTT7m7CPFVhk6o9JuqlDfgcBBy9B+bSka
         nhVKmd3Za0cr9JJfKSpWGjNV7HIBD81dn+iDis6QsDqw8VmFYOgtxON44m+vYR/uVYAG
         zWfnZhSNrmU95UBkkpuSSolcHkFF+Ryb94uyvvQZG55AZpiTsZyteCnQ7QXkabQ4ine5
         d3OrRKn6S0oECl2H153FX4kPVUFKs8T076Iiq7+OH6hGk9tkQ4JFgJeoEDyo3moWn+Wj
         DMpqbyDpfcFyrBqiBBt0l+tfU2TZM/NLft1CkOQnwXf43fm98V/OgFC9ARrMdyoKRBP0
         RalA==
X-Gm-Message-State: AOAM530D0XUU/gmzQ8n5CHWxD8HhXUrsJ6NT1csr8/c5c9BOiCNne3uN
        2YyffAlz3MltDFIQVm6juzYM3R41Zws=
X-Google-Smtp-Source: ABdhPJxpAMBtGINjtn+azSmi04H2qIg6QUqu9K9E7DvN51Vk9QBGo9q1od25IqsifasZed7VH8Tfbg==
X-Received: by 2002:aa7:8aca:0:b029:13e:d13d:a13e with SMTP id b10-20020aa78aca0000b029013ed13da13emr21144538pfd.38.1600234503152;
        Tue, 15 Sep 2020 22:35:03 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id c3sm13760607pfn.23.2020.09.15.22.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 22:35:02 -0700 (PDT)
Subject: Re: [PATCH] exfat: remove 'rwoffset' in exfat_inode_info
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200909075713epcas1p44c2503251f78baa2fde0ce4351bf936d@epcas1p4.samsung.com>
 <20200909075652.11203-1-kohada.t2@gmail.com>
 <000001d688c1$c329cad0$497d6070$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <0f9d3d3e-075f-511d-12e5-21346bca081e@gmail.com>
Date:   Wed, 16 Sep 2020 14:35:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <000001d688c1$c329cad0$497d6070$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/09/12 14:01, Sungjong Seo wrote:
>> Remove 'rwoffset' in exfat_inode_info and replace it with the
>> parameter(cpos) of exfat_readdir.
>> Since rwoffset of  is referenced only by exfat_readdir, it is not
>> necessary a exfat_inode_info's member.
>>
>> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
>> ---
>>   fs/exfat/dir.c      | 16 ++++++----------
>>   fs/exfat/exfat_fs.h |  2 --
>>   fs/exfat/file.c     |  2 --
>>   fs/exfat/inode.c    |  3 ---
>>   fs/exfat/super.c    |  1 -
>>   5 files changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>> a9b13ae3f325..fa5bb72aa295 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
> [snip]
>> sector @@ -262,13 +260,11 @@ static int exfat_iterate(struct file *filp,
>> struct dir_context *ctx)
>>   		goto end_of_dir;
>>   	}
>>
>> -	cpos = EXFAT_DEN_TO_B(ei->rwoffset);
>> -
>>   	if (!nb->lfn[0])
>>   		goto end_of_dir;
>>
>>   	i_pos = ((loff_t)ei->start_clu << 32) |
>> -		((ei->rwoffset - 1) & 0xffffffff);
>> +		(EXFAT_B_TO_DEN(cpos-1) & 0xffffffff);
> 
> Need to fix the above line to be:
> (EXFAT_B_TO_DEN(cpos)-1)) & 0xffffffff);


Here, we simply converted so that the calculation results would be the same.
But after reading it carefully again, I noticed.
  - Why use the previous entry?
  - Why does cpos point to stream dir-entry in entry-set?

For the former, there is no need to "++dentry" in exfat_readdir().
For the latter, I think cpos should point to the next to current entry-set.

I'll make V2 considering these.
How do you think?

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>

