Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675556FE39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfGVK7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 06:59:18 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30]:36753
        "EHLO sonic308-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728508AbfGVK7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563793157; bh=xtrUUH0sctj2tsSsDpr3PVuynzXM8HieJ7bbdupoyGk=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=UeOjUFhrgs5val+8BtBvi2iUTigq/lvOtgLqQvpUxDO1/sBXwh3SURLFEoYM98GJXZcnhiOYrkRw435yNT9gBX5GEjgaYzhjPHabba2dSW9VShK212fEWl+/CxUo160I2Kmq6oUwdZq68VXFXXceuuCoPBhtvtp3zIpZOLR3wb0mXVRy1IogqjkM2PuGToHL6ssD3QgWsPoqTJITh3UOJGo5sy0XKA942G7YARBH1jrw6s7e+NLwi2UntxHvMADXiPSLB7WHgRL8RvMw9aFcC2zZ2hqGlG+MXUjig52fqaEHGKL1n/wNkfuRFMLK9ZtQQrAx3kroZAYuSFu6HxEenQ==
X-YMail-OSG: Vjc7HoMVM1ng7VzLKgTAtT.ifUxJxTn_RKrPGgSZKTfRzA0woryFcUEkZ90F8F7
 Lat3BrYZQ_gm1IHA4jEedhefTJvOyQe.U2nhSCMyzxZr1JEDl1wlhfvsqzqAndJkiP4dFAr.R4dY
 oUKaRgnHIX6X7kwLfj2.s96GDi.CTEuAhHQn4GIjZj5yaCQAOR0LXTt84LauH17rfwssfJW9nwL9
 ai4xQv8M11j4cJ8CBes5yEzavGza92VYtFgqJqUeWWT6XxV3K088rzTV6JK.ub8z_4JS2jqCJ7Tc
 K7paDKhq4_m67GlMlmhnmL5Nakuo.FmcTB9vWDY25eMr.TcX843l94AmJdBBwQjjSgn4T2vjo4wR
 Yz0ApsTdr9SKwePM_TETo7OvT_vPQT6.zzNcJW.Yf0hXzWJi53kMlOX_awBxjYniafX_Isa407dv
 ZinTxkKovphYTWIAkjA7fl81KNi_oI2Rbq8wU8ODsH2Phw4jqh4smcewrpwlf5Nu3CcEK98dAact
 3TH17tH_Czax1rFNGs8Cieuv5ojqzinGaEQOSl3oODV9DxalLm4_HSYajgKi5yTNQuFtLkFKL2eI
 Twzk6SZeaegB8SM4zb.Kvw753SsAMVLS5FV3Ai0y8_V8Hkzw1oOcd297g7e_f_JovzeuOLm0KbcH
 a7TCTal..N_gfC714HIaLMfabvTDN6RnC8HI4hM_fpkJGdra6FmMYDytaP16gGvQgPM4aFupPQss
 zmW7L.iHCOILw6w7AmJmuK82zGpoMAPA0m7f7DBqdVDbIqpMN25HPrhtRBJ_GEGXDclSjebO5Yag
 EIkjmX40herrCsP5eatmfuOLouremz1P2BGRTbSioIKNXzgcvjGguAfWTclEPi58BHi9BwKwirCZ
 K.v0kwzOqEM4NIN4PJK4kKFulrEnSHRrrjRSj8ihslyDrbiRMPwQ5dzk_Sl4KNqwDLbId0ZoPNVp
 AuPl0KvG0rKn8h.Nh.PMGg0DhVmPXNbJN85SnC.qCBAD.rMsZSN4HHsMZuLrTKgzBlKtRoDJtXxC
 Rs1NTXJC7GGQ0rPRPK1Xyehit14.kxTQbtNxEBFWo83r3Ryj5_R4embRsUn_6QCy1U5_LZPWlMmL
 DtzW5AptGuSCSA42yfyQzV0txXqme51EbN5j9GF5NrUUKN.sqxdKqIC1LlYVMWLfL24uuZwQi8Jd
 SsivFaD1kyeJS1xvjseFmeabNPufv7quaY6eFT9Oag.EtNXbQpR6.AjM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 10:59:17 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b1cb3083fffce511e6c652e202262feb;
          Mon, 22 Jul 2019 10:59:15 +0000 (UTC)
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
To:     dsterba@suse.cz
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
 <20190722101818.GN20977@twin.jikos.cz>
From:   Gao Xiang <hsiangkao@aol.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Message-ID: <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
Date:   Mon, 22 Jul 2019 18:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722101818.GN20977@twin.jikos.cz>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On 2019/7/22 ????6:18, David Sterba wrote:
> On Mon, Jul 22, 2019 at 10:50:42AM +0800, Gao Xiang wrote:
>> +choice
>> +	prompt "EROFS Data Decompression mode"
>> +	depends on EROFS_FS_ZIP
>> +	default EROFS_FS_ZIP_CACHE_READAROUND
>> +	help
>> +	  EROFS supports three options for decompression.
>> +	  "In-place I/O Only" consumes the minimum memory
>> +	  with lowest random read.
>> +
>> +	  "Cached Decompression for readaround" consumes
>> +	  the maximum memory with highest random read.
>> +
>> +	  If unsure, select "Cached Decompression for readaround"
>> +
>> +config EROFS_FS_ZIP_CACHE_DISABLED
>> +	bool "In-place I/O Only"
>> +	help
>> +	  Read compressed data into page cache and do in-place
>> +	  I/O decompression directly.
>> +
>> +config EROFS_FS_ZIP_CACHE_READAHEAD
>> +	bool "Cached Decompression for readahead"
>> +	help
>> +	  For each request, it caches the last compressed page
>> +	  for further reading.
>> +	  It still does in-place I/O for the rest compressed pages.
>> +
>> +config EROFS_FS_ZIP_CACHE_READAROUND
>> +	bool "Cached Decompression for readaround"
>> +	help
>> +	  For each request, it caches the both end compressed pages
>> +	  for further reading.
>> +	  It still does in-place I/O for the rest compressed pages.
>> +
>> +	  Recommended for performance priority.
> 
> The number of individual Kconfig options is quite high, are you sure you
> need them to be split like that?

You mean the above? these are 3 cache strategies, which impact the
runtime memory consumption and performance. I tend to leave the above
as it-is...

> 
> Eg. the xattrs, acls and security labels seem to be part of the basic
> set of features so I wonder who does not want to enable them by default.
> I think you copied ext4 as a skeleton for the options, but for a new
> filesystem it's not necessary copy the history where I think features
> were added over time.

I have no idea... Okay, I will enable them by default.

> 
> Then eg. the option EROFS_FS_IO_MAX_RETRIES looks like a runtime
> setting, the config help text does not explain anything about the change
> in behaviour leaving the user with 'if not sure take the defaut'.

Agreed, you are right. EROFS_FS_IO_MAX_RETRIES is quite a runtime
setting. I will remove it in the next version (I think I will remove it
as the first step) or turn it to a mount option.

> 
> EROFS_FS_USE_VM_MAP_RAM is IMO a very low implementation detail, why
> does it need to be config option at all?

I'm not sure vm_map_ram() is always better than vmap() for all
platforms (it has noticeable performance impact). However that
seems true for my test machines (x86-64, arm64).

If vm_map_ram() is always the optimal choice compared with vmap(),
I will remove vmap() entirely, that is OK. But I am not sure for
every platforms though.

> 
> And so on. I'd suggest to go through all the options and reconsider them
> to be built-in, or runtime settings. Debugging features like the fault
> injections could be useful on non-debugging builds too, so a separate
> option is fine, otherwise grouping other debugging options under the
> main EROFS_FS_DEBUG would look more logical.

The remaining one is EROFS_FS_CLUSTER_PAGE_LIMIT. It impacts the total
size of z_erofs_pcluster structure. It's a hard limit, and should be
configured as small as possible. I can remove it right now since multi-block
compression is not available now. However, it will be added again after
multi-block compression is supported.

So, How about leave it right now and use the default value?

Thanks,
Gao Xiang
