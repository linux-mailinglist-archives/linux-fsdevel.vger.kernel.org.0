Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43304E1F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfFUIdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 04:33:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfFUIdE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:33:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C084FA8D8536B19F0AEB;
        Fri, 21 Jun 2019 16:33:01 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 16:32:52 +0800
Subject: Re: [PATCH v2 3/8] staging: erofs: move per-CPU buffers
 implementation to utils.c
To:     Chao Yu <yuchao0@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-4-gaoxiang25@huawei.com>
 <1d296b86-69e2-4888-2ac9-1d77f38ac3e3@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <abe96e3d-cda7-e71e-68b1-9669fe2f2241@huawei.com>
Date:   Fri, 21 Jun 2019 16:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1d296b86-69e2-4888-2ac9-1d77f38ac3e3@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

On 2019/6/21 15:57, Chao Yu wrote:
> On 2019/6/21 0:07, Gao Xiang wrote:
>> +static inline void *erofs_get_pcpubuf(unsigned int pagenr)
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
>> +}
> 
> [snip]
> 
>> +	percpu_data = erofs_get_pcpubuf(0);
> 
> If erofs_get_pcpubuf may return error once EROFS_PCPUBUF_NR_PAGES equals to
> zero, we'd better to check the error number here.

decompressor.c will be built-in only when decompression is enabled
and if decompression is enabled EROFS_PCPUBUF_NR_PAGES is not zero.

But I think introducing some error handling logic is not bad as well.
Will fix in the next version.

Thanks,
Gao Xiang

> 
> Thanks,
> 
