Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6692E34DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 08:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL1Hyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 02:54:55 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4125 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgL1Hyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:54:55 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D48tf4cW4zXsnv;
        Mon, 28 Dec 2020 15:53:30 +0800 (CST)
Received: from [10.174.177.103] (10.174.177.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 28 Dec 2020 15:54:12 +0800
Subject: can the idle value of /proc/stat decrease?
From:   "xuqiang (M)" <xuqiang36@huawei.com>
To:     <adobriyan@gmail.com>, <christian.brauner@ubuntu.com>,
        <michael.weiss@aisec.fraunhofer.de>, <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
References: <1ad49a62-41dd-cdcc-2f8c-b7a2ad67c3b6@huawei.com>
Message-ID: <a32dfe3c-8821-77c3-23dd-809b659d2e4f@huawei.com>
Date:   Mon, 28 Dec 2020 15:54:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1ad49a62-41dd-cdcc-2f8c-b7a2ad67c3b6@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.103]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Our recent test shows that the idle value of /proc/stat can decrease.
Is this an unreported bug? or it has been reported and the solution is 
waiting to get merged.

The results of the two readings from /proc/stat are shown as below, the 
interval between the two readings is 150 ms:

cat /proc/stat
cpu0 5536 10 14160 4118960 0 0 227128 0 0 0

cat /proc/stat
cpu0 5536 10 14160 4118959 0 0 227143 0 0 0
