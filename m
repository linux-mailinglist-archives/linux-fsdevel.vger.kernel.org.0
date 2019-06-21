Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D644E190
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfFUIFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 04:05:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfFUIFB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:05:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D1A0B333FA117BA7165;
        Fri, 21 Jun 2019 16:04:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 16:04:48 +0800
Subject: Re: [PATCH v2 4/8] staging: erofs: move stagingpage operations to
 compress.h
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-5-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b1e06903-98de-42a8-8736-bd20293fce5a@huawei.com>
Date:   Fri, 21 Jun 2019 16:04:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620160719.240682-5-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/21 0:07, Gao Xiang wrote:
> stagingpages are behaved as bounce pages for temporary use.
> Move to compress.h since the upcoming decompressor will
> allocate stagingpages as well.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
