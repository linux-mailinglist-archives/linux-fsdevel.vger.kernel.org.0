Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECF242758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHLJTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgHLJTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:19:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09026C06174A;
        Wed, 12 Aug 2020 02:19:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ep8so799372pjb.3;
        Wed, 12 Aug 2020 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WlYNV8beXV5Vw0HrTWkAMqyzmumvTyxegzIkSbtVuJU=;
        b=otUc5QtbHy7kSIt/M4/LTuSA7YXiAmNUh/C6x+qCsRMC+jHpMil50LbBQ66xbLUoK5
         ANyJpms8NTqA2y2HNhSmJCPHemnYZ24bH4oL2YCG/0dfyZONk+21niOfiHqTS9Bs4Ee0
         cuXQZx6DGGCitx0uGhzzciCgWNp6GDKlgVGoQXmjonC1E4My2mvoVq2SHFToX3IGX7/4
         QfABa7yCRo7HRx9EaMRc5jnwjrmX8pUHfo0KlsaPP2XpHv9osdH9FaQCIDdCwIjYBr7M
         78iEoZ1FHgbHOs8OIefPtO6gVULNk/37oTCJ6ngCJWuogz+F6QVWG9hteoTz1Iua/oWZ
         uGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WlYNV8beXV5Vw0HrTWkAMqyzmumvTyxegzIkSbtVuJU=;
        b=krbOnybZkujp4g1fk25NpqaKUSwF+mT0Kzr004fUMo2TBZ78ecO+7jrPq5ZYUlp2u9
         EAVwapnL1MrcoWptHBZA3L6+3eDCUS8+Nr2ldy7T1LfZdQby/7Cp+XNhvXqZvrds7dhl
         +MABI/OxJlCDIzgR1avqqqnbXU1XIn24xpaCxFKeCPBbFCuBZveRnQ/7S7DVFD4rkxX5
         gJ6HgMHQQxCWUy6yUNP+YOd2lbp+nz6gds8vpft8seqkceBkRft/5rNV+iOhr4dG+YJU
         cU2JeSL8FdmzeLKtCE1guko1JBCOdBYCYpTe1KbDRvdDVsvXxq5pHu457OAkvrCShMlF
         gThA==
X-Gm-Message-State: AOAM533nCxtFa0uw+SZgVzftUkM2XUOql9XwQsXmEBvA1U2uYzzLJSv6
        JUHCvB8o4plAV/cZJkNH7PUGvGZb
X-Google-Smtp-Source: ABdhPJwg0+HFJ8i6X7IWQ/Zh+9/ChDwvFwCzWXvenqIcYkwbUVHcFMe5kA4mMnitN5qkPu1+crVkbQ==
X-Received: by 2002:a17:90a:e551:: with SMTP id ei17mr5091349pjb.214.1597223975013;
        Wed, 12 Aug 2020 02:19:35 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:5c24:508b:d8c0:f3b? ([2404:7a87:83e0:f800:5c24:508b:d8c0:f3b])
        by smtp.gmail.com with ESMTPSA id 205sm1758873pfy.9.2020.08.12.02.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 02:19:34 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
 <20200616021808.5222-1-kohada.t2@gmail.com>
 <414101d64477$ccb661f0$662325d0$@samsung.com>
 <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
 <500801d64572$0bdd2940$23977bc0$@samsung.com>
 <c635e965-6b78-436a-3959-e4777e1732c1@gmail.com>
 <000301d66dac$07b9fc00$172df400$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <490837eb-6765-c7be-bb80-b30fe34adb55@gmail.com>
Date:   Wed, 12 Aug 2020 18:19:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000301d66dac$07b9fc00$172df400$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>
>> When should VOL_DIRTY be cleared?
>>
>> The current behavior is ...
>>
>> Case of  mkdir, rmdir, rename:
>>     - set VOL_DIRTY before operation
>>     - set VOL_CLEAN after operating.
>> In async mode, it is actually written to the media after 30 seconds.
>>
>> Case of  cp, touch:
>>     - set VOL_DIRTY before operation
>>     - however, VOL_CLEAN is not called in this context.
>> VOL_CLEAN will call by sync_fs or unmount.
>>
>> I added VOL_CLEAN in last of __exfat_write_inode() and exfat_map_cluster().
>> As a result, VOL_DIRTY is cleared with cp and touch.
>> However, when copying a many files ...
>>    - Async mode: VOL_DIRTY is written to the media twice every 30 seconds.
>>    - Sync mode: Of course,  VOL_DIRTY and VOL_CLEAN to the media for each
>> file.
>>
>> Frequent writing VOL_DIRTY and VOL_CLEAN  increases the risk of boot-
>> sector curruption.
>> If the boot-sector corrupted, it causes the following serious problems  on
>> some OSs.
>>    - misjudge as unformatted
>>    - can't judge as exfat
>>    - can't repair
>>
>> I want to minimize boot sector writes, to reduce these risk.
>>
>> I looked vfat/udf implementation, which manages similar dirty information
>> on linux, and found that they ware mark-dirty at mount and cleared at
>> unmount.
>>
>> Here are some ways to clear VOL_DIRTY.
>>
>> (A) VOL_CLEAN after every write operation.
>>     :-) Ejectable at any time after a write operation.
>>     :-( Many times write to Boot-sector.
>>
>> (B) dirty at mount, clear at unmount (same as vfat/udf)
>>     :-) Write to boot-sector twice.
>>     :-( It remains dirty unless unmounted.
>>     :-( Write to boot-sector even if there is no write operation.
>>
>> (C) dirty on first write operation, clear on unmount
>>     :-) Writing to boot-sector is minimal.
>>     :-) Will not write to the boot-sector if there is no write operation.
>>     :-( It remains dirty unless unmounted.
>>
>> (D) dirty on first write operation,  clear on sync-fs/unmount
>>    :-) Writing to boot-sector can be reduced.
>>    :-) Will not write to the boot-sector if there is no write operation.
>>    :-) sync-fs makes it clean and ejectable immidiately.
>>    :-( It remains dirty unless sync-fs or unmount.
>>    :-( Frequent sync-fs will  increases writes to boot-sector.
>>
>> I think it should be (C) or(D).
>> What do you think?
>>
> 
> First of all, I'm sorry for the late reply.
> And thank you for the suggestion.

Thanks for thinking on this complicated issue.


> Most of the NAND flash devices and HDDs have wear leveling and bad sector replacement algorithms applied.
> So I think that the life of the boot sector will not be exhausted first.

I'm not too worried about the life of the boot-sector.
I'm worried about write failures caused by external factors.
(power failure/system down/vibration/etc. during writing)
They rarely occur on SD cards, but occur on many HDDs, some SSDs and USB storages by 0.1% or more.
Especially with AFT-HDD, not only boot-sector but also the following multiple sectors become unreadable.
It is not possible to completely solve this problem, as long as writing to the boot-sector.
(I think it's a exFAT's specification defect)
The only effective way to reduce this problem is to reduce writes to the boot-sector.


> Currently the volume dirty/clean policy of exfat-fs is not perfect,

Thank you for sharing the problem with you.


> but I think it behaves similarly to the policy of MS Windows.

On Windows10, the dirty flag is cleared after more than 15 seconds after all write operations are completed.
(dirty-flag is never updated during the write operation continues)


> Therefore,
> I think code improvements should be made to reduce volume flag records while maintaining the current policy.

Current policy is inconsistent.
As I wrote last mail, the problem with the current implementation is that the dirty-flag may not be cleared
after the write operation.(even if sync is enabled or disabled)
Because, some write operations clear the dirty-flag but some don't clear.
Unmount or sync command is the only way to ensure that the dirty-flag is cleared.
This has no effect on clearing the dirty-flag after a write operations, it only increases risk of destroying
the boot-sector.
  - Clear the dirty-flag after every write operation.
  - Never clear the dirty-flag after every write operation.
Unless unified to either one,  I think that sync policy cannot be consistent.

How do you think?


BR
---
etsuhiro Kohada <kohada.t2@gmail.com>

