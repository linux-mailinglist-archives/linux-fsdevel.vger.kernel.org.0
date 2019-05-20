Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B712332C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfETMFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 08:05:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730557AbfETMFl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 08:05:41 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 0FF453AF2DC1640FA183;
        Mon, 20 May 2019 20:05:39 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 May 2019 20:05:38 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 20 May 2019 20:05:37 +0800
Subject: Re: [PATCH v2 1/1] f2fs: ioctl for removing a range from F2FS
To:     Matthew Wilcox <willy@infradead.org>,
        sunqiuyang <sunqiuyang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <miaoxie@huawei.com>,
        <fangwei1@huawei.com>, <stummala@codeaurora.org>
References: <20190517021647.43083-1-sunqiuyang@huawei.com>
 <20190517025628.GF31704@bombadil.infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ce0b747e-6e3d-6285-7f20-f4ecd6c4df6c@huawei.com>
Date:   Mon, 20 May 2019 20:05:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190517025628.GF31704@bombadil.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/17 10:56, Matthew Wilcox wrote:
> On Fri, May 17, 2019 at 10:16:47AM +0800, sunqiuyang wrote:
>> +++ b/fs/f2fs/f2fs.h
>> @@ -423,6 +423,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>>  #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
>>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
>> +#define F2FS_IOC_SHRINK_RESIZE		_IOW(F2FS_IOCTL_MAGIC, 16,	\
>> +						struct f2fs_resize_param)
> 
> Why not match ext4?
> 
> fs/ext4/ext4.h:#define EXT4_IOC_RESIZE_FS               _IOW('f', 16, __u64)

Agreed, Qiuyang, could you consider to implement this interface as ext4's, in
addition, changing parameter from shrunk bytes to new block count of fs?

F2FS_IOC_RESIZE_FS		_IOW('f', 16, __u64)

if (copy_from_user(&block_count, (__u64 __user *)arg, sizeof(__u64)))

Thanks,

> 
> .
> 
