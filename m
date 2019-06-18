Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92D749967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfFRGwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 02:52:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbfFRGwm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:52:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43AAFAF366D1653AD995;
        Tue, 18 Jun 2019 14:52:38 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 14:52:28 +0800
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
 <20190617203609.GA22034@kroah.com>
 <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
 <20190618054709.GA4271@kroah.com>
 <df18d7f9-f65a-5697-c7c4-edb1ad846c3e@huawei.com>
 <20190618064523.GA6015@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <2a6abbf9-20a9-c1dd-0091-d8e3009037eb@huawei.com>
Date:   Tue, 18 Jun 2019 14:52:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190618064523.GA6015@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/6/18 14:45, Greg Kroah-Hartman wrote:
> On Tue, Jun 18, 2019 at 02:18:00PM +0800, Gao Xiang wrote:
>>
>>
>> On 2019/6/18 13:47, Greg Kroah-Hartman wrote:
>>> On Tue, Jun 18, 2019 at 09:47:08AM +0800, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2019/6/18 4:36, Greg Kroah-Hartman wrote:
>>>>> On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
>>>>>> At last, this is RFC patch v1, which means it is not suitable for
>>>>>> merging soon... I'm still working on it, testing its stability
>>>>>> these days and hope these patches get merged for 5.3 LTS
>>>>>> (if 5.3 is a LTS version).
>>>>>
>>>>> Why would 5.3 be a LTS kernel?
>>>>>
>>>>> curious as to how you came up with that :)
>>>>
>>>> My personal thought is about one LTS kernel one year...
>>>> Usually 5 versions after the previous kernel...(4.4 -> 4.9 -> 4.14 -> 4.19),
>>>> which is not suitable for all historical LTSs...just prepare for 5.3...
>>>
>>> I try to pick the "last" kernel that is released each year, which
>>> sometimes is 5 kernels, sometimes 4, sometimes 6, depending on the
>>> release cycle.
>>>
>>> So odds are it will be 5.4 for the next LTS kernel, but we will not know
>>> more until it gets closer to release time.
>>
>> Thanks for kindly explanation :)
>>
>> Anyway, I will test these patches, land to our commerical products and try the best
>> efforts on making it more stable for Linux upstream to merge.
> 
> Sounds great.
> 
> But why do you need to add compression to get this code out of staging?
> Why not move it out now and then add compression and other new features
> to it then?

Move out of staging could be over several linux versions since I'd like to get
majority fs people agreed to this.

Decompression inplace is an important part of erofs to show its performance
benefits over existed compress filesystems and I tend to merge it in advance.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
