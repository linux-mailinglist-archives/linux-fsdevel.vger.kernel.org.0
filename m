Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D432D61387F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiJaN5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiJaN5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:57:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D110561;
        Mon, 31 Oct 2022 06:57:02 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N1F4c2S2fzJnPk;
        Mon, 31 Oct 2022 21:54:08 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:57:00 +0800
Subject: Re: [PATCH] fs: fix undefined behavior in bit shift for SB_NOUSER
To:     Christoph Hellwig <hch@infradead.org>
CC:     <viro@zeniv.linux.org.uk>, <dhowells@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221029071745.2836665-1-cuigaosheng1@huawei.com>
 <Y1/KdOyExwCdfCqb@infradead.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <80107081-1c24-19d3-9a34-0ee61ac7c99d@huawei.com>
Date:   Mon, 31 Oct 2022 21:56:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y1/KdOyExwCdfCqb@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Let's mark all of the flags as unsigned instead of just one so that
> we don't mix types.  s_flags is already unsigned (although for some
> reason long) already.
>
> And while you touch this please add the proper whitespaces around the
> shift operator everywhere.

Thanks for taking time to review this patch, I have made patch v2 and submit it.

On 2022/10/31 21:15, Christoph Hellwig wrote:
> Let's mark all of the flags as unsigned instead of just one so that
> we don't mix types.  s_flags is already unsigned (although for some
> reason long) already.
>
> And while you touch this please add the proper whitespaces around the
> shift operator everywhere.
