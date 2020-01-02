Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77012E629
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgABMdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:33:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728274AbgABMdn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:33:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 57C7544130DFD2F920B1;
        Thu,  2 Jan 2020 20:33:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 2 Jan 2020
 20:33:38 +0800
Subject: Re: [PATCH] erofs: correct indentation of an assigned structure
 inside a function
To:     Vladimir Zapolskiy <vladimir@tuxera.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        "Anton Altaparmakov" <anton@tuxera.com>
References: <20200102120232.15074-1-vladimir@tuxera.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <09a203da-1f08-3ea0-e457-dfb1d251e08c@huawei.com>
Date:   Thu, 2 Jan 2020 20:33:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200102120232.15074-1-vladimir@tuxera.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/1/2 20:02, Vladimir Zapolskiy wrote:
> Trivial change, the expected indentation ruled by the coding style
> hasn't been met.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
