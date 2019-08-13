Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15DE8AD2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 05:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfHMDkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 23:40:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfHMDkw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:40:52 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 90EE0B75969977179D59;
        Tue, 13 Aug 2019 11:40:50 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 13 Aug 2019 11:40:49 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 13
 Aug 2019 11:40:49 +0800
Date:   Tue, 13 Aug 2019 11:57:57 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Fang Wei" <fangwei1@huawei.com>
Subject: Re: [PATCH 3/3] staging: erofs: xattr.c: avoid BUG_ON
Message-ID: <20190813035754.GA23614@138>
References: <20190813023054.73126-1-gaoxiang25@huawei.com>
 <20190813023054.73126-3-gaoxiang25@huawei.com>
 <84f50ca2-3411-36a6-049a-0d343d8df325@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84f50ca2-3411-36a6-049a-0d343d8df325@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

On Tue, Aug 13, 2019 at 11:20:22AM +0800, Chao Yu wrote:
> On 2019/8/13 10:30, Gao Xiang wrote:
> > Kill all the remaining BUG_ON in EROFS:
> >  - one BUG_ON was used to detect xattr on-disk corruption,
> >    proper error handling should be added for it instead;
> >  - the other BUG_ONs are used to detect potential issues,
> >    use DBG_BUGON only in (eng) debugging version.
> 
> BTW, do we need add WARN_ON() into DBG_BUGON() to show some details function or
> call stack in where we encounter the issue?

Thanks for kindly review :)

Agreed, it seems much better. If there are no other considerations
here, I can submit another patch addressing it later or maybe we
can change it in the next linux version since I'd like to focusing
on moving out of staging for this round...

Thanks,
Gao Xiang

> 
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
