Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BD55E0DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiF1DVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiF1DU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:20:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640ED1EC68;
        Mon, 27 Jun 2022 20:20:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LX8sX5NpyzTgC7;
        Tue, 28 Jun 2022 11:17:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 11:20:49 +0800
Subject: Re: [PATCH] filemap: minor cleanup for filemap_write_and_wait_range
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220627132351.55680-1-linmiaohe@huawei.com>
 <Yrpve403Pz2MmwM+@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cb08ed3c-a7ff-03c4-29b8-8f6d9e5bd0d9@huawei.com>
Date:   Tue, 28 Jun 2022 11:20:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yrpve403Pz2MmwM+@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/6/28 11:03, Matthew Wilcox wrote:
> On Mon, Jun 27, 2022 at 09:23:51PM +0800, Miaohe Lin wrote:
>> Restructure the logic in filemap_write_and_wait_range to simplify the code
>> and make it more consistent with file_write_and_wait_range. No functional
>> change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Looks OK to me at a quick glance.  I'll look at it more closely next
> week when I'm back from holiday.

Thanks for your time. Enjoy your holiday. ;)

> 
> .
> 

