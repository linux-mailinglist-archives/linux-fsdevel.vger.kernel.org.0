Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74C4494D12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 12:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiATLdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 06:33:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17356 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiATLdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:33:22 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JfgMp0whkz9sJd;
        Thu, 20 Jan 2022 19:32:06 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 20 Jan 2022 19:33:20 +0800
Subject: Re: [PATCH] aio: Adjust the position of get_reqs_available() in
 aio_get_req()
To:     Christoph Hellwig <hch@infradead.org>
References: <1642660946-60244-1-git-send-email-chenxiang66@hisilicon.com>
 <YeklUcOCM4W38siT@infradead.org>
CC:     <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>, <linux-aio@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <65758fa9-92cb-6be8-0167-36191923fe8c@hisilicon.com>
Date:   Thu, 20 Jan 2022 19:33:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <YeklUcOCM4W38siT@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/20 17:03, Christoph Hellwig 写道:
> On Thu, Jan 20, 2022 at 02:42:26PM +0800, chenxiang wrote:
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> Right now allocating aio_kiocb is in front of get_reqs_available(),
>> then need to free aio_kiocb if get_reqs_available() is failed.
>> Put get_reqs_availabe() in front of allocating aio_kiocb to avoid
>> freeing aio_kiocb if get_reqs_available() is failed.
> Except for the fact that this completely missed undoing
> get_reqs_available, how is that order any better?
Forgot that put_reqs_avaiable() is required if so, and please ignore the 
patch.

