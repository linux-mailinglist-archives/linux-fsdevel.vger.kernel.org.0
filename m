Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95D418D90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 03:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhI0BxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Sep 2021 21:53:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:21346 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhI0BxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:53:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HHlqt0NBZzRZJ4;
        Mon, 27 Sep 2021 09:47:06 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 09:51:21 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 09:51:21 +0800
Subject: Re: [PATCH] kernfs: fix the race in the creation of negative dentry
To:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
CC:     <viro@ZenIV.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210911021342.3280687-1-houtao1@huawei.com>
 <7b92b158200567f0bba26a038191156890921f13.camel@themaw.net>
 <6c8088411523e52fc89b8dd07710c3825366ce64.camel@themaw.net>
 <747aee3255e7a07168557f29ad962e34e9cb964b.camel@themaw.net>
 <e3d22860-f2f0-70c1-35ef-35da0c0a44d2@huawei.com>
 <077362887b4ceeb01c27fbf36fa35adae02967c9.camel@themaw.net>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <13592fb7-5bc1-41cf-f19d-150b1e634fb2@huawei.com>
Date:   Mon, 27 Sep 2021 09:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <077362887b4ceeb01c27fbf36fa35adae02967c9.camel@themaw.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/23/2021 10:50 AM, Ian Kent wrote:
> Great, although I was hoping you would check it worked as expected.
> Did you check?
> If not could you please do that check?
It fixes the race. I rerun the stress test of module addition and removal,
and the problem doesn't occur after 12 hours.

Regards,
Tao
