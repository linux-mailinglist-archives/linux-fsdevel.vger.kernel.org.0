Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8665B5C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfGAHic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 03:38:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfGAHic (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:38:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EA764B785CAED1DB02A;
        Mon,  1 Jul 2019 15:38:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019
 15:38:20 +0800
Subject: Re: [PATCH RFC] iomap: introduce IOMAP_TAIL
To:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
CC:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gaoxiang25@huawei.com>, <chao@kernel.org>
References: <20190629073020.22759-1-yuchao0@huawei.com>
 <20190630231932.GI1404256@magnolia> <20190701060847.GA24797@infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <93d85b90-1323-f0b7-bed3-60b3131cad00@huawei.com>
Date:   Mon, 1 Jul 2019 15:38:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701060847.GA24797@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/1 14:08, Christoph Hellwig wrote:
> On Sun, Jun 30, 2019 at 04:19:32PM -0700, Darrick J. Wong wrote:
>> On Sat, Jun 29, 2019 at 03:30:20PM +0800, Chao Yu wrote:
>>> Some filesystems like erofs/reiserfs have the ability to pack tail
>>> data into metadata, however iomap framework can only support mapping
>>> inline data with IOMAP_INLINE type, it restricts that:
>>> - inline data should be locating at page #0.
>>> - inline size should equal to .i_size
>>
>> Wouldn't it be easier simply to fix the meaning of IOMAP_INLINE so that
>> it can be used at something other than offset 0 and length == isize?
>> IOWs, make it mean "use the *inline_data pointer to read/write data
>> as a direct memory access"?
> 
> Yes.  I vaguely remember Andreas pointed out some issues with a

@Andreas, could you please help to explain which issue we may encounter without
those limits?

Thanks,

> general scheme, which is why we put the limits in.  If that is not just
> me making things up we'll need to address them.  Either way just copy
> and pasting code isn't very helpful.
> .
> 
