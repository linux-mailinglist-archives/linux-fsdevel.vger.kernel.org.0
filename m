Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5947DFB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346897AbhLWHnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:43:04 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16854 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhLWHnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:43:03 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JKMbR2ftMz91nw;
        Thu, 23 Dec 2021 15:42:11 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 15:43:02 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 15:43:01 +0800
Subject: Re: [PATCH] chardev: fix error handling in cdev_device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <logang@deltatee.com>,
        <dan.j.williams@intel.com>, <hans.verkuil@cisco.com>,
        <alexandre.belloni@free-electrons.com>
References: <20211012130915.3426584-1-yangyingliang@huawei.com>
 <1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com>
 <YcQh+M/7STAG/4Ka@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <ca8f58ad-033b-4350-6715-0d54efdbfc3e@huawei.com>
Date:   Thu, 23 Dec 2021 15:43:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YcQh+M/7STAG/4Ka@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021/12/23 15:15, Greg KH wrote:
> On Thu, Dec 23, 2021 at 09:41:03AM +0800, Yang Yingliang wrote:
>> ping...
> ping of what?  You suddenly added a bunch of people that were not on the
> original thread here with no context :(
> .
This patch has been in mail list for a while time, I add the author and 
reviewer of fixed patch
to this thread,  I would like to get some advice. Should I resend the 
patch with cc those people ?

Thanks,
Yang
