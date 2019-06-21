Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6634E179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 09:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfFUH5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 03:57:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19051 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfFUH5h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:57:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A874EE5D04EAB5D6FD2;
        Fri, 21 Jun 2019 15:57:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 15:57:25 +0800
Subject: Re: [PATCH v2 3/8] staging: erofs: move per-CPU buffers
 implementation to utils.c
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-4-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1d296b86-69e2-4888-2ac9-1d77f38ac3e3@huawei.com>
Date:   Fri, 21 Jun 2019 15:57:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620160719.240682-4-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/21 0:07, Gao Xiang wrote:
> +static inline void *erofs_get_pcpubuf(unsigned int pagenr)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}

[snip]

> +	percpu_data = erofs_get_pcpubuf(0);

If erofs_get_pcpubuf may return error once EROFS_PCPUBUF_NR_PAGES equals to
zero, we'd better to check the error number here.

Thanks,
