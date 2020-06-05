Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE891EF3AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgFEJGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 05:06:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbgFEJGD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:06:03 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D7864A6F1FE7CED70B1D;
        Fri,  5 Jun 2020 17:06:00 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 5 Jun 2020
 17:05:53 +0800
Subject: Re: [PATCH v2] block: Fix use-after-free in blkdev_get()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <hulkci@huawei.com>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
Date:   Fri, 5 Jun 2020 17:05:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Markus

Thanks for the review.

Sorry for the wording because I'm not an English native speaker.

在 2020/6/5 16:30, Markus Elfring 写道:

> 
> Would you like to add the tag “Fixes” to the commit message?
> 

I tried to find the commit in the git history which introduced this 
issue, but I am not sure which one is it. It seems existed there for a 
long time.

Thanks,
Jason


> Regards,
> Markus
> 

