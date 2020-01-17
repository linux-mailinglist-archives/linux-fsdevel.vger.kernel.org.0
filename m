Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7610914066D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 10:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAQJjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 04:39:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgAQJjQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:39:16 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF6A24FE3E33B497B782;
        Fri, 17 Jan 2020 17:39:13 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 17:39:04 +0800
Subject: Re: [RFC] iomap: fix race between readahead and direct write
To:     Jan Kara <jack@suse.cz>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200116153206.GF8446@quack2.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <ce4bc2f3-a23e-f6ba-0ef1-66231cd1057d@huawei.com>
Date:   Fri, 17 Jan 2020 17:39:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200116153206.GF8446@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/16 23:32, Jan Kara wrote:
> Thanks for the report and the patch. But the data integrity when mixing
> buffered and direct IO like this is best effort only. We definitely do not
> want to sacrifice performance of common cases or code complexity to make
> cases like this work reliably.

In the patch, the only thing that is diffrent is that iomap_begin() will
be called for each page. However, it seems the performance in sequential
read didn't get worse. Is there a specific case that the performance
will get worse?

Thanks!
Yu Kuai!

