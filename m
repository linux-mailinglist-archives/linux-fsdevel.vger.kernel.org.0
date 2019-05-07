Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45E41610F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEGJf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 05:35:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2951 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfEGJf6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 05:35:58 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D90EFAF7B7ACD094EBBE;
        Tue,  7 May 2019 17:35:54 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 7 May 2019 17:35:46 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 7 May 2019 17:35:45 +0800
Subject: Re: [RFC PATCH 0/4] Inline Encryption Support
To:     Satya Tangirala <satyat@google.com>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
References: <20190506223544.195371-1-satyat@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cc46e6b5-229e-d108-3675-fdba478a33ce@huawei.com>
Date:   Tue, 7 May 2019 17:35:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-1-satyat@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/7 6:35, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to the block layer,
> fscrypt and f2fs.

Err.. it should send to f2fs mailing list.
