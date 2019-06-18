Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053784971E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 03:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfFRBrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 21:47:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRBrX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:47:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 60CF686CD082B136A475;
        Tue, 18 Jun 2019 09:47:21 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 09:47:11 +0800
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
 <20190617203609.GA22034@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
Date:   Tue, 18 Jun 2019 09:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190617203609.GA22034@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/6/18 4:36, Greg Kroah-Hartman wrote:
> On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
>> At last, this is RFC patch v1, which means it is not suitable for
>> merging soon... I'm still working on it, testing its stability
>> these days and hope these patches get merged for 5.3 LTS
>> (if 5.3 is a LTS version).
> 
> Why would 5.3 be a LTS kernel?
> 
> curious as to how you came up with that :)

My personal thought is about one LTS kernel one year...
Usually 5 versions after the previous kernel...(4.4 -> 4.9 -> 4.14 -> 4.19),
which is not suitable for all historical LTSs...just prepare for 5.3...

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
