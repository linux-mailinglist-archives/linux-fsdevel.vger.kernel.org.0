Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440002DDCB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 02:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbgLRBwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 20:52:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16830 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729402AbgLRBwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 20:52:55 -0500
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400"; 
   d="scan'208";a="102687556"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 09:52:07 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id D6EE84CE4BCB;
        Fri, 18 Dec 2020 09:52:06 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 09:52:06 +0800
Subject: Re: [RFC PATCH v3 8/9] md: Implement ->corrupted_range()
To:     Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <david@fromorbit.com>, <hch@lst.de>,
        <song@kernel.org>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
 <100fcdf4-b2fe-d77d-e95f-52a7323d7ee1@oracle.com>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <8742889a-c967-d899-ff32-f4a4ebcde7ad@cn.fujitsu.com>
Date:   Fri, 18 Dec 2020 09:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <100fcdf4-b2fe-d77d-e95f-52a7323d7ee1@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: D6EE84CE4BCB.A18A3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/12/16 下午1:43, Jane Chu wrote:
> On 12/15/2020 4:14 AM, Shiyang Ruan wrote:
>>   #ifdef CONFIG_SYSFS
>> +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t 
>> off,
>> +                   size_t len, void *data);
>>   int bd_link_disk_holder(struct block_device *bdev, struct gendisk 
>> *disk);
>>   void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk 
>> *disk);
>>   #else
>> +int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t 
>> off,
> 
> Did you mean
>    static inline int bd_disk_holder_corrupted_range(..
> ?

Yes, it's my fault.  Thanks a lot.


--
Thanks,
Ruan Shiyang.

> 
> thanks,
> -jane
> 
>> +                   size_t len, void *data)
>> +{
>> +    return 0;
>> +}
>>   static inline int bd_link_disk_holder(struct block_device *bdev,
>>                         struct gendisk *disk)
> 
> 


