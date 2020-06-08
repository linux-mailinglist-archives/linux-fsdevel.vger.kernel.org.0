Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0633E1F1108
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 03:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFHB2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 21:28:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727972AbgFHB2w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:28:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CC09978E1AF52A4C9A6;
        Mon,  8 Jun 2020 09:28:50 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 09:28:40 +0800
Subject: Re: [PATCH v3] block: Fix use-after-free in blkdev_get()
To:     Jan Kara <jack@suse.cz>
CC:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hulk Robot <hulkci@huawei.com>
References: <20200605104558.16686-1-yanaijie@huawei.com>
 <20200605143710.GA13248@quack2.suse.cz>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3c9298bd-6406-6815-09d2-ca4fdd732b79@huawei.com>
Date:   Mon, 8 Jun 2020 09:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200605143710.GA13248@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



ÔÚ 2020/6/5 22:37, Jan Kara Ð´µÀ:
> No need for braces here after you remove bdput(). With this fixed, feel
> free to add:
> 
> Reviewed-by: Jan Kara<jack@suse.cz>

Thanks, I will fix it in v4.

Jason

