Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C382C50E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbgKZJIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 04:08:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8124 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbgKZJId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:08:33 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChX3X0ynYz15S2C;
        Thu, 26 Nov 2020 17:08:08 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 17:08:22 +0800
Subject: Re: [PATCH] fs: export vfs_stat() and vfs_fstatat()
To:     Christoph Hellwig <hch@lst.de>
References: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com>
 <20201126071848.GA17990@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <696f0e06-4f4d-0a61-6e13-f5af433594bf@hisilicon.com>
Date:   Thu, 26 Nov 2020 17:08:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201126071848.GA17990@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On 2020/11/26 15:18, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 03:15:48PM +0800, Yicong Yang wrote:
>> The public function vfs_stat() and vfs_fstatat() are
>> unexported after moving out of line in
>> commit 09f1bde4017e ("fs: move vfs_fstatat out of line"),
>> which will prevent the using in kernel modules.
>> So make them exported.
> And why would you want to use them in kernel module?  Please explain
> that in the patch that exports them, and please send that patch in the
> same series as the patches adding the users.

we're using it in the modules for testing our crypto driver on our CI system.
is it mandatory to upstream it if we want to use this function?

Thanks,
Yicong


> .
>

