Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E416F8D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 07:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGVFZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 01:25:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfGVFZX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:25:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8750EAB3666A593AD324;
        Mon, 22 Jul 2019 13:25:20 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 13:25:13 +0800
Subject: Re: [PATCH v3 01/24] erofs: add on-disk layout
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-2-gaoxiang25@huawei.com>
 <20190722132616.60edd141@canb.auug.org.au> <20190722050522.GA11993@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <98b70190-a7d8-6251-84d9-599ca115f42b@huawei.com>
Date:   Mon, 22 Jul 2019 13:24:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190722050522.GA11993@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On 2019/7/22 13:05, Greg Kroah-Hartman wrote:
> On Mon, Jul 22, 2019 at 01:26:16PM +1000, Stephen Rothwell wrote:
>> Hi Gao,
>>
>> On Mon, 22 Jul 2019 10:50:20 +0800 Gao Xiang <gaoxiang25@huawei.com> wrote:
>>>
>>> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
>>> new file mode 100644
>>> index 000000000000..e418725abfd6
>>> --- /dev/null
>>> +++ b/fs/erofs/erofs_fs.h
>>> @@ -0,0 +1,316 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
>>
>> I think the preferred tag is now GPL-2.0-only (assuming that is what is
>> intended).
> 
> Either is fine, see the LICENSE/preferred/GPL-2.0 file for the list of
> valid ones.

Yes, I noticed the LICENSE text before and I can do in the either way (use
GPL-2.0 or GPL-2.0-only). This modification won't take too much time...
If it is needed, I am happy to do that... That is fine :)

Thanks,
Gao Xiang
