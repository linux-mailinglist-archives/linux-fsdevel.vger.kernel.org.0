Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C049F579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiA1Ilc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 03:41:32 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32071 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243195AbiA1Il2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:41:28 -0500
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JlW6d65NRz1FClW;
        Fri, 28 Jan 2022 16:37:29 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:41:26 +0800
Subject: Re: [QUESTION] Question about 'epoll: do not insert into poll queues
 until all,sanity checks are done'
To:     yebin <yebin10@huawei.com>, <viro@zeniv.linux.org.uk>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <yeweihua4@huawei.com>
References: <61F29CE1.5010500@huawei.com> <61F3504C.8060001@huawei.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <5e19830c-8653-e575-78db-ddcfc76839cc@huawei.com>
Date:   Fri, 28 Jan 2022 16:41:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <61F3504C.8060001@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC linux-kernel@vger.kernel.org and linux-fsdevel@vger.kernel.org mail list.

On 2022/1/28 10:09, yebin wrote:
> Hi, AL.
> I'm sorry to bother you.
> Now there is a CVE(CVE-2021-39634) which discription is "In fs/eventpoll.c, there is a possible use after free".
> The information disclosed now shows that fix patch is "epoll: do not insert into poll queues until all
> sanity checks are done" which you submitted.
> According to the patch modification, I reverse analyze how to generate use-after-free .After analysis for several days,
> I tried to reproduce it, but I didn't find any use-after-free.
> Do you have any suggestions for the use-after-free described by CVE-2021-39634?
