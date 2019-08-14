Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5278CF41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfHNJWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 05:22:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfHNJWb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:22:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D101664A8DDC451216D5;
        Wed, 14 Aug 2019 17:22:25 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 17:22:19 +0800
Subject: Re: [PATCH RESEND 1/2] staging: erofs: introduce EFSCORRUPTED and
 more logs
To:     Gao Xiang <gaoxiang25@huawei.com>, Pavel Machek <pavel@denx.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190814042525.4925-2-gaoxiang25@huawei.com>
 <20190814043208.15591-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <db0e0d1d-9018-5c2c-93d0-b718e7e6853c@huawei.com>
Date:   Wed, 14 Aug 2019 17:22:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190814043208.15591-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/14 12:32, Gao Xiang wrote:
> Previously, EROFS uses EIO to indicate that filesystem is
> corrupted as well, but other filesystems tend to use
> EUCLEAN instead, let's follow what others do right now.
> 
> Also, add some more prints to the syslog.
> 
> Suggested-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
