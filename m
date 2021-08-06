Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D553E26EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244323AbhHFJMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244258AbhHFJMx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECDA16113C;
        Fri,  6 Aug 2021 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628241158;
        bh=gVfakN+vVEJEkHVwWBvwIWcsbdvB9+grIspJr8mNPEU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Y+v10eWW1J89wUgq2yYaMGLzvwigXh/mmmmi9nVT//xG34nNrbe1IZkeBEVWz/8dI
         rToriWczbHQ6NH3KF8P375IE+zqapbU12B+we/ctGGbTy0nRUFtUsY6+d+7uKsmKKw
         w5Y4b4iEE7Ux/SwRRxl8iO/ES3cYyuv5n/Dei1BTtb8jZBXB+Mre5aVWMhermYLoRH
         0Tk3sfqfsvGChV2RseF5eF3vuewwbE/wqJO3N516fpFY5zJ7dgJzuVwoGCrezscflH
         U+NA4mkpd2cg1WsjaNztiAF1bOHjOT5ytPU2Ia9O7lFU9vIPBj1YhnO2lxo/Thbmhj
         y2MDDAqyFA01A==
Subject: Re: [PATCH v3 2/3] erofs: dax support for non-tailpacking regular
 file
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Tao Ma <boyu.mt@taobao.com>
References: <20210805003601.183063-1-hsiangkao@linux.alibaba.com>
 <20210805003601.183063-3-hsiangkao@linux.alibaba.com>
 <7aa650b8-a853-368d-7a81-f435194eec33@kernel.org>
 <YQtZ+CtvB3P+7Xim@B-P7TQMD6M-0146.local>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2bdaab77-c219-3f42-f50d-2af856386006@kernel.org>
Date:   Fri, 6 Aug 2021 17:12:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQtZ+CtvB3P+7Xim@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiang,

On 2021/8/5 11:24, Gao Xiang wrote:
> Thanks, it originally inherited from filesystems/ext2.rst, I will update
> this into
> dax, dax={always,never}      .....

Above change looks fine to me, thanks.

> 
> Since for such image vm-shared memory scenario, no need to add per-file
> DAX (at least for now.)

Agreed.

Thanks,
