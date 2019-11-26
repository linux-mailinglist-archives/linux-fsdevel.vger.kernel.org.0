Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685C010A02B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfKZOUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 09:20:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46896 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbfKZOUq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:20:46 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BF5FE7323DC23217EC1;
        Tue, 26 Nov 2019 22:20:42 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.145) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 26 Nov 2019
 22:20:35 +0800
Subject: Re: [PATCH v2] posix_acl: fix memleak when set posix acl.
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
References: <20191126133809.2082-1-zhangxiaoxu5@huawei.com>
 <20191126140138.GA228491@architecture4>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <1b6e4ac1-b377-03e7-d7b2-904d00768206@huawei.com>
Date:   Tue, 26 Nov 2019 22:20:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126140138.GA228491@architecture4>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.145]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

please ignore this patch.
the problem is exist in centos kernel.


ÔÚ 2019/11/26 22:01, Gao Xiang Ð´µÀ:
> IMO, variable acl in this function won't be affected, yes?
> Am I missing something?

