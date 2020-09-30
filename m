Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C808327DF1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 06:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgI3EBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 00:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3EBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 00:01:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE76C061755;
        Tue, 29 Sep 2020 21:01:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l18so131011pjz.1;
        Tue, 29 Sep 2020 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42YC7idKSuE9VIQ2Cmvfnm09gGVcZvWgkg4U0sEtmTE=;
        b=Df4eVSpE7tdqSg8YZJZ+IGpFp+EbsMEPKSPtMKcaOMwe7ZdmnfzgoS+Rs99Gb2MUo4
         UcVe1/NIGmfYfVtXG4j9gz0E3LA3owjiP5hwS6FBc9rIntHsWlPiAjoM3uHq6Mq8qf3+
         cUFLEeUsV56tUfK/kO0FGj0umA5J8uvNxrbvzXlBxilSFDvZ8EzC/2PPCJbIIY0lgwSz
         qkrlalVVRDT7U62H0/uBQaGXfO/IZ9R6PO9oqSLuLjkKr770ZEs+2qgaslW+w3rXfP+C
         rhT6HM72fpdCyXC9n291tbs8c/p4ftTqtRQ5BX253wnoagG4ySfWs9z4g3bIiFCZ6wCm
         gO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42YC7idKSuE9VIQ2Cmvfnm09gGVcZvWgkg4U0sEtmTE=;
        b=kSguYofCOhEtjqwV5MMH1RkILEtwoSX8WIKdUAxizBauVDroGHrUznFWpqaFeJivgx
         bShPFwEzOORp+XXxSWkAgGT9kmLJY+jRywCmtoB7RboF0JdFNFW+pXy/0XpXaEojR2D+
         EVSDLEuH4RA9KkkTwlLryDMITOHCLe6a2BYh908hAwIJQXrs1pRwP2+rq4pYfKr8rZqv
         +w8O9uNtHBq4U5e+vmkGSOgtylFRZXOQ2kA4vXt3TMzJebgtSwFSeU+NH9c6gdaMkCQ3
         xMUfKigj9cqigyJmYPi+HBG5Eo4m1H5TO+2eBAajpThFWl1iglMrFW+9eoIvAm+n5a1/
         yjbQ==
X-Gm-Message-State: AOAM53283Y5/7Gk4iNB+GG31/WYFlLod/JceJNHhuaVqEDwE935wF4sF
        sXjmuwax4lHhQsRXcezzVFPKoPVVcRBnUQ==
X-Google-Smtp-Source: ABdhPJwg8aWBdrP7cx7RX+VeJTbDwVezVtLo3XsPznf67tS9tPbXjUP57tnHkUB/E0y1v0v9FfsOrQ==
X-Received: by 2002:a17:90b:898:: with SMTP id bj24mr718909pjb.145.1601438510521;
        Tue, 29 Sep 2020 21:01:50 -0700 (PDT)
Received: from [192.168.1.200] (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id gb17sm421526pjb.15.2020.09.29.21.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 21:01:50 -0700 (PDT)
Subject: Re: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
 <20200911044506.13912-1-kohada.t2@gmail.com>
 <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
 <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
 <8c9701d6956a$13898560$3a9c9020$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <afb45c4c-5ebd-5250-1265-4f485c3dcaad@gmail.com>
Date:   Wed, 30 Sep 2020 13:01:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8c9701d6956a$13898560$3a9c9020$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> It might check if the cluster numbers are same between source entry
>>> and target directory.
>>
>> This checks if newdir is the move target itself.
>> Example:
>>     mv /mnt/dir0 /mnt/dir0/foo
>>
>> However, this check is not enough.
>> We need to check newdir and all ancestors.
>> Example:
>>     mv /mnt/dir0 /mnt/dir0/dir1/foo
>>     mv /mnt/dir0 /mnt/dir0/dir1/dir2/foo
>>     ...
>>
>> This is probably a taboo for all layered filesystems.
>>
>>
>>> Could you let me know what code you mentioned?
>>> Or do you mean the codes on vfs?
>>
>> You can find in do_renameat2(). --- around 'fs/namei.c:4440'
>> If the destination ancestors are itself, our driver will not be called.
> 
> I think, of course, vfs has been doing that.
> So that code is unnecessary in normal situations.
> 
> That code comes from the old exfat implementation.

It could be a remnant of another system.
Once upon a time, I moved the dir to a descendant dir without implementing this check
and it disappeared forever.
linux-VFS fixed this issue immediately, but some systems still need to be checked by
the driver itself. (ex.Windows-IFS)


> And as far as I understand, it seems to check once more "the cluster number"
> even though it comes through vfs so that it tries detecting abnormal of on-disk.
> 
> Anyway, I agonized if it is really needed.
> In conclusion, old code could be eliminated and your patch looks reasonable.

It's easy to add, but it's really hard to remove the ancient code.


BTW
I have a question for you.
Now, I'm trying to optimize exfat_get_dentry().
However, exfat_get_dentry() is used a lot, so the patch is also large.
In such a case
-Replace old implementation with new ones with a single patch.
-Devide multiple patches in which old functions and new functions (ex. exfat_get_dentry2) coexist temporarily. And finally clean up.

I understand that a small patch is desirable, but the latter has "two similar functions".
Which is better for you to review the patch?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
  
