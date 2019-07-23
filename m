Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99F71935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfGWNad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 09:30:33 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com ([87.248.110.83]:42210
        "EHLO sonic302-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727924AbfGWNac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563888627; bh=c4EtERWmOlLnToAQZFFQ0tgD2PCoHHVP3KPET20i2Rc=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=hOJdM8Gt6pVCW6YyQ4XNXehelrl4JV9ErwYmtuxtnPNLyirHGF5FIg+8u7bp/3smfRPf0K2JXSfR3pQbMzzIzRzTW2sL80QGy3UPQOKTgxFtRcHaIoBey3zgH5d71CCHRi+mIWYiblGE0DCqQVLvdQq3LCDHY93VQ67jiZvuyKotHSxQv/lYoqJCG+zHqgl0hMQJkc3QVfrGAurWMF4pOPAogiYikej6rNV1KwvOFFmyXR6XLyl/3pNGPMMkegjjU0EFMCV657rZMgO1g4szXJTivxt+mPopzZ3S9xygr3dtBfNYg5p/V7sx7Kx6MmN7ih0m4zH/CrkwA09aHKn/vQ==
X-YMail-OSG: VoRN6A4VM1l4MgAqDai7A20BNgPpLNGiGMptXZ7gTvP5UI0rOPzpRWwlssVYXrV
 b2E9kl3T.Wep2Eta6JYh71obWB5nE_4KkNvxKwBYubwNj4qjqO3N0c_hjVcXuUmO.X3eRDMXlHan
 Jw.EBIKmd2apV8D9AeKyU2.vJ01GnaXNGTinjm5bXnwVwy8bwbNq7Lex6fEACpIMtr.dr9qwiw85
 AHsRu5PbYo.kV280ouRr0Cl2QbdJkNJAMAXhcd_Od0Ni5YOCMgLKuZRcFKN2W6Yr2BP4YFBiU5Z5
 K81E29DdBVU2oYN1pmyRHKkb_yPZfY4g_lJHOiKBEHA7b2_bCsTcsD1LcOOo9h495WONkuK8U6hh
 eXFhX_fZEcKJbPAWiGy2eejGfgAuGqXiQi0eG7FsXcSaHEa62haLXZXljFwbT.iz26WmW6.kysxp
 CzzT2DvIvEHT97cNsz5JpvB90wjzL68rAzFuximpb4SbxOSGylB_cMGY9r.Sexz8YeWTK3yF4Wjy
 ayyWk4zcBkqMlGIvdAbkopbDjwYBlf.UPb7jxF477PR598s4IoMIl.ZDw3MxPM717lpjK2EK7TjD
 dp85PXh5Io0twhxdXxLRXLaoM3jSqLuaHsg7XmrhZlD6aDeY7I2DXkvXJfRre6.ci_.rCENk7jmK
 er5H47j3qzn3xCY01rW8IeuXTpPlr8Jy8Ut7D2kNBVUPOPUJN.RLvDONW8iDxbYymQFMY_cS0fJ2
 jGOStknuyGmgUD5mxxZFPyNf.3tNXpYGOUsy7yNOQBWcqqT5Eqgf0gXcBClWL5TJ7nXsG9mXStz4
 SAfLWLcxGbdbvMaLk2oAFYGH5LqygXQNgipBJpaK0NVXMT7bf8hPkMJZPsx5Z499AwPqZQyR07J2
 Bmw3hEEuTC6s9lWwaQsAmUJMj9zDak6btygzElH64_KOYHbJy2QdIcxKPQ2YQ.fP6a.Llx56wYJ8
 ccgYJ7auCAxfuoF6tBokKZBReZn49XZ8trDUAekir3LmKEFuz7QnkTEA6JvQQHW31y0t4.5C9SSz
 HmYM5kRIBKhuPmnnbKj7LKzimeUIQZeRTFj.7Yvis6BNMrl4PuUJIpbPcJl1lRjUKorm0ZlrX2O6
 pherF28Haf5FWhVQo6Lmt_qs6S4RLYJDZYiOSs6OYLP6Lt788lwG9UBc8fIO1VC.MaHyos4iIeKB
 zzgYB_t4KlbsOTz2q3BpQ84Pqtde6eV6iJ4Yk4mkly0e.aNinRnDY
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Tue, 23 Jul 2019 13:30:27 +0000
Received: by smtp426.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2f2ae19cf287ab3910bb19c095c0ecd7;
          Tue, 23 Jul 2019 13:30:22 +0000 (UTC)
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
To:     dsterba@suse.cz
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
 <20190722101818.GN20977@twin.jikos.cz>
 <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
 <20190723123104.GB2868@twin.jikos.cz>
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
Message-ID: <b623d1bc-7cb5-e466-10e1-bb3bfefcae10@aol.com>
Date:   Tue, 23 Jul 2019 21:30:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723123104.GB2868@twin.jikos.cz>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/23 ????8:31, David Sterba wrote:
> On Mon, Jul 22, 2019 at 06:58:59PM +0800, Gao Xiang wrote:
>> On 2019/7/22 ????6:18, David Sterba wrote:
>>> On Mon, Jul 22, 2019 at 10:50:42AM +0800, Gao Xiang wrote:
>>>> +choice
>>>> +	prompt "EROFS Data Decompression mode"
>>>> +	depends on EROFS_FS_ZIP
>>>> +	default EROFS_FS_ZIP_CACHE_READAROUND
>>>> +	help
>>>> +	  EROFS supports three options for decompression.
>>>> +	  "In-place I/O Only" consumes the minimum memory
>>>> +	  with lowest random read.
>>>> +
>>>> +	  "Cached Decompression for readaround" consumes
>>>> +	  the maximum memory with highest random read.
>>>> +
>>>> +	  If unsure, select "Cached Decompression for readaround"
>>>> +
>>>> +config EROFS_FS_ZIP_CACHE_DISABLED
>>>> +	bool "In-place I/O Only"
>>>> +	help
>>>> +	  Read compressed data into page cache and do in-place
>>>> +	  I/O decompression directly.
>>>> +
>>>> +config EROFS_FS_ZIP_CACHE_READAHEAD
>>>> +	bool "Cached Decompression for readahead"
>>>> +	help
>>>> +	  For each request, it caches the last compressed page
>>>> +	  for further reading.
>>>> +	  It still does in-place I/O for the rest compressed pages.
>>>> +
>>>> +config EROFS_FS_ZIP_CACHE_READAROUND
>>>> +	bool "Cached Decompression for readaround"
>>>> +	help
>>>> +	  For each request, it caches the both end compressed pages
>>>> +	  for further reading.
>>>> +	  It still does in-place I/O for the rest compressed pages.
>>>> +
>>>> +	  Recommended for performance priority.
>>>
>>> The number of individual Kconfig options is quite high, are you sure you
>>> need them to be split like that?
>>
>> You mean the above? these are 3 cache strategies, which impact the
>> runtime memory consumption and performance. I tend to leave the above
>> as it-is...
> 
> No, I mean all Kconfig options, they're scattered over several patches,
> best seen in the checked out branch. The cache strategies are actually
> just one config option (choice).

I will change the cache strategy at runtime as Ted suggested.
The cost is actually that erofs will always need a managed_cache inode
even though users just use in-place IO for their products.

However, I notice that using separated Kconfig will make test harder,
so that it leads to more bugs, that is what I really care about.

Therefore I think making it at runtime is OK for me.

> 
>> I'm not sure vm_map_ram() is always better than vmap() for all
>> platforms (it has noticeable performance impact). However that
>> seems true for my test machines (x86-64, arm64).
>>
>> If vm_map_ram() is always the optimal choice compared with vmap(),
>> I will remove vmap() entirely, that is OK. But I am not sure for
>> every platforms though.
> 
> You can select the implementation by platform, I don't know what are the
> criteria like cpu type etc, but I expect it's something that can be
> determined at module load time. Eventually a module parameter can be the
> the way to set it.

OK, module parameter makes sense for me, and the overhead may be
unnoticeable. I think it is fine to me.

> 
>>> And so on. I'd suggest to go through all the options and reconsider them
>>> to be built-in, or runtime settings. Debugging features like the fault
>>> injections could be useful on non-debugging builds too, so a separate
>>> option is fine, otherwise grouping other debugging options under the
>>> main EROFS_FS_DEBUG would look more logical.
>>
>> The remaining one is EROFS_FS_CLUSTER_PAGE_LIMIT. It impacts the total
>> size of z_erofs_pcluster structure. It's a hard limit, and should be
>> configured as small as possible. I can remove it right now since multi-block
>> compression is not available now. However, it will be added again after
>> multi-block compression is supported.
>>
>> So, How about leave it right now and use the default value?
> 
> From the Kconfig and build-time settings perspective I think it's
> misplaced. This affects testing, you'd have to rebuild and reinstall the
> module to test any change, while it's "just" a number that can be either
> module parameter, sysfs knob, mount option or special ioctl.
> 
> But I may be wrong, EROFS is a special purpose filesystem, so the
> fine-grained build options might make sense (eg. due to smaller code).
> The question should be how does each option affect typical production
> build targets. Fewer is IMHO better.
I have to admit, EROFS still has some special stuffs now (since we still
have some TODO), However, I don't think EROFS cannot be effectively used
for many productive uses right now.

Considering that using linux-staging stuff is dangerous / unsuitable for
most of companies, out of staging is better...

And we still have to improve it to be more generic by time like what other fses do
(IMO, writing a generic compression fs is not hard, many fses are there.
I need to think more carefully in case of some performance loss which is out of
too straight-forward generic code)...

To be more specific, as for EROFS_FS_CLUSTER_PAGE_LIMIT...

In the long term, I can introduce "struct biovec_slab"-like to erofs as
in block/bio.c to support variable-sized z_erofs_pcluster.

In the short term, I think EROFS_FS_CLUSTER_PAGE_LIMIT can be better set to
the default value. It is a hard uplimit of the structure z_erofs_pcluster,
which will greatly impact the memory consumption...

Even if EROFS_FS_CLUSTER_PAGE_LIMIT is removed in the later Linux version
by introducing biovec_slab-like stuff, I think it will have little influence
to users? so I think that is a minor thing? Or I misunderstand something?

Thanks,
Gao Xiang
