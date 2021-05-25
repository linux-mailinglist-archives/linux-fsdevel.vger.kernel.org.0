Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9138FC32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhEYIJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:09:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhEYIJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:13 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq5kd73PSz1BRfP;
        Tue, 25 May 2021 15:46:49 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 15:49:40 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 15:49:40 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-fsdevel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 0/2] use DIV_ROUND_UP helper macro for calculations
Date:   Tue, 25 May 2021 16:15:18 +0800
Message-ID: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is replace open coded divisor calculations with the 
DIV_ROUND_UP kernel macro for better readability.

Wu Bo (2):
  crypto: af_alg - use DIV_ROUND_UP helper macro for calculations
  fs: direct-io: use DIV_ROUND_UP helper macro for calculations

 crypto/af_alg.c | 2 +-
 fs/direct-io.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.1

