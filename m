Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6A141AD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 02:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgASBRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 20:17:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51814 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgASBRM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:17:12 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC87ACED00AE71D06D4D;
        Sun, 19 Jan 2020 09:17:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 09:17:01 +0800
Subject: Re: [RFC] iomap: fix race between readahead and direct write
To:     Jan Kara <jack@suse.cz>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200116153206.GF8446@quack2.suse.cz>
 <ce4bc2f3-a23e-f6ba-0ef1-66231cd1057d@huawei.com>
 <20200117110536.GE17141@quack2.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <976d09e1-e3b5-a6a6-d159-9bdac3a7dc84@huawei.com>
Date:   Sun, 19 Jan 2020 09:17:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200117110536.GE17141@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/17 19:05, Jan Kara wrote:
> provide
> allocation for each page separately

Thank you for your response!

I do understand there will be additional CPU overhead. But page is 
allocated in __do_page_cache_readahead(), which is called before
iomap_begin(). And I did not change that.

Thanks!
Yu Kuai

