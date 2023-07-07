Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54F74A96B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGGDpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 23:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGDpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE761FD7;
        Thu,  6 Jul 2023 20:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 791C5616E2;
        Fri,  7 Jul 2023 03:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F81C433C7;
        Fri,  7 Jul 2023 03:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688701532;
        bh=jwPJXoJAdHQJBru2swhErx1bfOnD9aZyRfelifLuhQI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=j1mkyaP7+aT0mvHVJZearLVE47F25pWwW+m2KZ2fpSN9zl9pdaNFVEoW3WibUDtII
         beNurO49W+gyrgHrq32vWzqoj0f+A428didQQVdKysTF5zTqLlhUF+JwrUe/3UU9dl
         ad/ZJa4fmFj2Cg4FDfenzeG1NodOvT4cjkSv2wcBuF4Ap7Md68FfbMXUkfMbmgLZ+4
         82cIUbaqznuPWEnHp6Lo2dwVGEHcQw4G/eP99yp5JyLo2pLy9Gx8+MDsZUspZVXz0z
         rJbZdEPWmTkUYTCKGPOV4vO/5CvWJMUpDJDFdwEZmV+CllUtqDwAnuyPz9l9iQ18rI
         49IuG9pnU92Dw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1b0719dd966so1450046fac.1;
        Thu, 06 Jul 2023 20:45:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLa/bt93zO+2xWHvClj2VtTpS0brrLNI9BVhWIgwBXGsTgFQRRIg
        tFOfIk2bif/Zv2LjHZXJqwaTH4tWYyCMpWB8wRM=
X-Google-Smtp-Source: APBJJlHn7Wv4m3FFQlRG/SvZNbRq8WQVV9Mg+m3mwSfaR7Hc1MVFNAmqf4l9ViBMl6GKrrH2aleIvuIMPmOFFJcfp5I=
X-Received: by 2002:a05:6870:c887:b0:180:b716:9825 with SMTP id
 er7-20020a056870c88700b00180b7169825mr4490698oab.57.1688701531841; Thu, 06
 Jul 2023 20:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e07:0:b0:4e8:f6ff:2aab with HTTP; Thu, 6 Jul 2023
 20:45:31 -0700 (PDT)
In-Reply-To: <1e196b9bc884495fb43bbb0975d88226@hihonor.com>
References: <4cec63dcd3c0443c928800ffeec9118c@hihonor.com> <CAKYAXd89OqqqSPNBZjggexWCrnBD6V7rWE547iKejmeihHFAiw@mail.gmail.com>
 <1e196b9bc884495fb43bbb0975d88226@hihonor.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 7 Jul 2023 12:45:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9XvMuicGASQ6dvMCPnuTvw0xdLB7dp3MRGK6O6Mvht_A@mail.gmail.com>
Message-ID: <CAKYAXd9XvMuicGASQ6dvMCPnuTvw0xdLB7dp3MRGK6O6Mvht_A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBleGZhdDogdXNlIGt2bWFsbG9jX2FycmF5L2t2ZnJlZQ==?=
        =?UTF-8?B?IGluc3RlYWQgb2Yga21hbGxvY19hcnJheS9rZnJlZQ==?=
To:     gaoming <gaoming20@hihonor.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        "open list:EXFAT FILE SYSTEM" <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        fengbaopeng <fengbaopeng@hihonor.com>,
        gaoxu <gaoxu2@hihonor.com>,
        wangfei 00014658 <wangfei66@hihonor.com>,
        shenchen 00013118 <harry.shen@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-07 11:27 GMT+09:00, gaoming <gaoming20@hihonor.com>:
> exfat_get_dentry_set could be called after the u-disk have been inserted,
> through exfat_find, __exfat_write_inode functions.
> This could happen at any time, which scenario can not guarantee the
> continuity of physical memory.
> This bugfix will enhance the robustness of exfat.
I'm sorry, but I understood that it was changed even though you didn't
find any particular problem. I think there will not be issues like
allocation-bitmap allocation failures. I will delete this code and
apply it. If you don't agree, please explain how much memory is
allocated here.
Thanks.
>
> Thanks.
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Namjae Jeon <linkinjeon@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B47=E6=9C=887=E6=97=A5 7=
:10
> =E6=94=B6=E4=BB=B6=E4=BA=BA: gaoming <gaoming20@hihonor.com>
> =E6=8A=84=E9=80=81: Sungjong Seo <sj1557.seo@samsung.com>; open list:EXFA=
T FILE SYSTEM
> <linux-fsdevel@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>=
;
> fengbaopeng <fengbaopeng@hihonor.com>; gaoxu <gaoxu2@hihonor.com>; wangfe=
i
> 00014658 <wangfei66@hihonor.com>; shenchen 00013118
> <harry.shen@hihonor.com>
> =E4=B8=BB=E9=A2=98: Re: [PATCH] exfat: use kvmalloc_array/kvfree instead =
of
> kmalloc_array/kfree
>
> 2023-07-05 18:15 GMT+09:00, gaoming <gaoming20@hihonor.com>:
>> The call stack shown below is a scenario in the Linux 4.19 kernel.
>> Allocating memory failed where exfat fs use kmalloc_array due to
>> system memory fragmentation, while the u-disk was inserted without
>> recognition.
>> Devices such as u-disk using the exfat file system are pluggable and
>> may be insert into the system at any time.
>> However, long-term running systems cannot guarantee the continuity of
>> physical memory. Therefore, it's necessary to address this issue.
>>
>> Binder:2632_6: page allocation failure: order:4,
>> mode:0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=3D(null) Call trace:
>> [242178.097582]  dump_backtrace+0x0/0x4 [242178.097589]
>> dump_stack+0xf4/0x134 [242178.097598]  warn_alloc+0xd8/0x144
>> [242178.097603]  __alloc_pages_nodemask+0x1364/0x1384
>> [242178.097608]  kmalloc_order+0x2c/0x510 [242178.097612]
>> kmalloc_order_trace+0x40/0x16c [242178.097618]  __kmalloc+0x360/0x408
>> [242178.097624]  load_alloc_bitmap+0x160/0x284 [242178.097628]
>> exfat_fill_super+0xa3c/0xe7c [242178.097635]  mount_bdev+0x2e8/0x3a0
>> [242178.097638]  exfat_fs_mount+0x40/0x50 [242178.097643]
>> mount_fs+0x138/0x2e8 [242178.097649]  vfs_kern_mount+0x90/0x270
>> [242178.097655]  do_mount+0x798/0x173c [242178.097659]
>> ksys_mount+0x114/0x1ac [242178.097665]  __arm64_sys_mount+0x24/0x34
>> [242178.097671]  el0_svc_common+0xb8/0x1b8 [242178.097676]
>> el0_svc_handler+0x74/0x90 [242178.097681]  el0_svc+0x8/0x340
>>
>> By analyzing the exfat code,we found that continuous physical memory
>> is not required here,so kvmalloc_array is used can solve this problem.
>>
>> Signed-off-by: gaoming <gaoming20@hihonor.com>
>> ---
>>  fs/exfat/balloc.c | 4 ++--
>>  fs/exfat/dir.c    | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c index
>> 9f42f25fab92..a183558cb7a0 100644
>> --- a/fs/exfat/balloc.c
>> +++ b/fs/exfat/balloc.c
>> @@ -69,7 +69,7 @@ static int exfat_allocate_bitmap(struct super_block
>> *sb,
>>  	}
>>  	sbi->map_sectors =3D ((need_map_size - 1) >>
>>  			(sb->s_blocksize_bits)) + 1;
>> -	sbi->vol_amap =3D kmalloc_array(sbi->map_sectors,
>> +	sbi->vol_amap =3D kvmalloc_array(sbi->map_sectors,
>>  				sizeof(struct buffer_head *), GFP_KERNEL);
>>  	if (!sbi->vol_amap)
>>  		return -ENOMEM;
>> @@ -84,7 +84,7 @@ static int exfat_allocate_bitmap(struct super_block
>> *sb,
>>  			while (j < i)
>>  				brelse(sbi->vol_amap[j++]);
>>
>> -			kfree(sbi->vol_amap);
>> +			kvfree(sbi->vol_amap);
>>  			sbi->vol_amap =3D NULL;
>>  			return -EIO;
>>  		}
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>> 957574180a5e..5cbb78d0a2a2 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -649,7 +649,7 @@ int exfat_put_dentry_set(struct
>> exfat_entry_set_cache *es, int sync)
>>  			brelse(es->bh[i]);
>>
>>  	if (IS_DYNAMIC_ES(es))
>> -		kfree(es->bh);
>> +		kvfree(es->bh);
>>
>>  	return err;
>>  }
>> @@ -888,7 +888,7 @@ int exfat_get_dentry_set(struct
>> exfat_entry_set_cache *es,
>>
>>  	num_bh =3D EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb=
);
>>  	if (num_bh > ARRAY_SIZE(es->__bh)) {
>> -		es->bh =3D kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
>> +		es->bh =3D kvmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
> Could you please elaborate why you change this to kvmalloc_array also?
>
> Thanks.
>>  		if (!es->bh) {
>>  			brelse(bh);
>>  			return -ENOMEM;
>> --
>> 2.17.1
>>
>>
>
