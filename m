Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51081329
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfHEH30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 03:29:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfHEH30 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:29:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F122C95E763F130677A6;
        Mon,  5 Aug 2019 15:29:02 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 5 Aug 2019
 15:28:56 +0800
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: fix the bug in reserve_new_block
To:     Lihong Kou <koulihong@huawei.com>, <jaegeuk@kernel.org>
CC:     <fangwei1@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1564989981-104324-1-git-send-email-koulihong@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <084ee838-3e09-70b1-904e-9b2e78794b49@huawei.com>
Date:   Mon, 5 Aug 2019 15:29:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1564989981-104324-1-git-send-email-koulihong@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/5 15:26, Lihong Kou wrote:
> if we new node block in fsck flow, we need to update
> the valid_node_cnt at the same time.
> 
> Signed-off-by: Lihong Kou <koulihong@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
