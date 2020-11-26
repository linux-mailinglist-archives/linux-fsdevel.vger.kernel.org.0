Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964942C4F1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgKZHFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:05:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7991 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbgKZHFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:05:02 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ChTK73XWYzhhl6;
        Thu, 26 Nov 2020 15:04:43 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 26 Nov
 2020 15:04:56 +0800
Subject: Re: [PATCH 2/9] f2fs: remove f2fs_dir_open()
To:     Eric Biggers <ebiggers@kernel.org>, <linux-fscrypt@vger.kernel.org>
CC:     <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-mtd@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-3-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9522461b-b854-76ac-29c7-160f0f078823@huawei.com>
Date:   Thu, 26 Nov 2020 15:04:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201125002336.274045-3-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/25 8:23, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since encrypted directories can be opened without their encryption key
> being available, and each readdir tries to set up the key, trying to set

readdir -> readdir/lookup?

> up the key in ->open() too isn't really useful.
> 
> Just remove it so that directories don't need an ->open() method
> anymore, and so that we eliminate a use of fscrypt_get_encryption_info()
> (which I'd like to stop exporting to filesystems).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
