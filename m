Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB2BAE47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfIWHFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 03:05:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728002AbfIWHFO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:05:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2B199A78823A2977EAA0;
        Mon, 23 Sep 2019 15:05:13 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 23 Sep
 2019 15:05:04 +0800
Subject: Re: [PATCH 1/1] f2fs: check total_segments from devices in raw_super
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>
References: <20190923042235.37286-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c9ab08c2-cc87-1dbd-694b-e014a2029f9a@huawei.com>
Date:   Mon, 23 Sep 2019 15:04:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190923042235.37286-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/23 12:22, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> For multi-device F2FS, we should check if the sum of total_segments from
> all devices matches segment_count.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
