Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17086CED6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfGRN1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 09:27:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbfGRN1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:27:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E362C92388982DDB1E24;
        Thu, 18 Jul 2019 21:27:51 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 21:27:42 +0800
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        Chao Yu <yuchao0@huawei.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <chao@kernel.org>
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
 <20190711122831.3970-1-agruenba@redhat.com>
 <20190718123155.GA21252@infradead.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <cb859e68-1f7f-48a6-593b-4047963086ba@huawei.com>
Date:   Thu, 18 Jul 2019 21:27:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190718123155.GA21252@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/7/18 20:31, Christoph Hellwig wrote:
> That being said until the tail packing fs (erofs?) actually uses
> buffer_heads we should not need this hunk, and I don't think erofs
> should have any reason to use buffer_heads.

Yes, erofs will not use buffer_head to support sub-page blocksize
in the long term. too heavy and no need...

Thanks,
Gao Xiang
