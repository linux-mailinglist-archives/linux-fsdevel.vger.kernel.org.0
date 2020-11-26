Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F802C523E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbgKZKpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 05:45:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7738 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbgKZKpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:45:04 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChZBq1KFKzkgRv;
        Thu, 26 Nov 2020 18:44:35 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 18:44:55 +0800
Subject: Re: [PATCH] fs: export vfs_stat() and vfs_fstatat()
To:     Christoph Hellwig <hch@lst.de>
References: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com>
 <20201126071848.GA17990@lst.de>
 <696f0e06-4f4d-0a61-6e13-f5af433594bf@hisilicon.com>
 <20201126091537.GA21957@lst.de>
 <79b19660-f418-f5ac-943c-bc49a88eb949@hisilicon.com>
 <20201126095004.GA23930@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <6178eb60-7a84-4939-ddbf-107b16d27a42@hisilicon.com>
Date:   Thu, 26 Nov 2020 18:44:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201126095004.GA23930@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/26 17:50, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 05:48:25PM +0800, Yicong Yang wrote:
>> Sorry for not describing the issues I met correctly in the commit message.
>> Actually we're using inline function vfs_stat() for getting the
>> attributes, which calls vfs_fstatat():
> Again, there generally isn't much need to look at the stat data
> for an in-kernel caller.  But without you submitting the code I can't
> really help you anyway.
> .

sure. we'll check to see whether it's necessary or there is other way. 

many thanks!



