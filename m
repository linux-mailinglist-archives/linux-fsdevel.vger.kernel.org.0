Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63208232A80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 05:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgG3Dju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 23:39:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgG3Dju (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:39:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8A30C1EE9F9AFAA22382;
        Thu, 30 Jul 2020 11:39:46 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.103) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 11:39:38 +0800
Subject: Re: [RFC PATCH] iomap: add support to track dirty state of sub pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200730011901.2840886-1-yukuai3@huawei.com>
 <20200730031934.GA23808@casper.infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <98b561be-5aca-148f-5f69-2fd2b5dedff4@huawei.com>
Date:   Thu, 30 Jul 2020 11:39:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200730031934.GA23808@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.103]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/7/30 11:19, Matthew Wilcox wrote:
> Maybe let the discussion on removing the ->uptodate array finish
> before posting another patch for review?

Hi, Matthew!

Of course, I missed the discussion thread before sending this path.
And thanks for your suggestions.

Best regards,
Yu Kuai

