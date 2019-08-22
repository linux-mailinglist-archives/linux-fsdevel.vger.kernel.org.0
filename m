Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE38988D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 03:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfHVA7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 20:59:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50302 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbfHVA7K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:59:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93DC02FD1EAE9DE1B0C8;
        Thu, 22 Aug 2019 08:59:07 +0800 (CST)
Received: from [127.0.0.1] (10.133.208.128) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 08:59:06 +0800
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
 <20190820091650.GE9855@stefanha-x1.localdomain>
 <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
 <20190821160551.GD9095@stefanha-x1.localdomain>
CC:     <linux-fsdevel@vger.kernel.org>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
From:   wangyan <wangyan122@huawei.com>
Message-ID: <954b5f8a-4007-f29c-f38e-dd5585879541@huawei.com>
Date:   Thu, 22 Aug 2019 08:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190821160551.GD9095@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.208.128]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/22 0:05, Stefan Hajnoczi wrote:
> On Wed, Aug 21, 2019 at 09:51:20AM +0200, Miklos Szeredi wrote:
>> On Tue, Aug 20, 2019 at 11:16 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>> On Thu, Aug 15, 2019 at 08:30:43AM +0800, wangyan wrote:
>>>> Hi all,
>>>>
>>>> I met a performance problem when I tested buffer write compared with 9p.
>>>
>>> CCing Miklos, FUSE maintainer, since this is mostly a FUSE file system
>>> writeback question.
>>
>> This is expected.   FUSE contains lots of complexity in the buffered
>> write path related to preventing DoS caused by the userspace server.
>>
>> This added complexity, which causes the performance issue, could be
>> disabled in virtio-fs, since the server lives on a different kernel
>> than the filesystem.
>>
>> I'll do a patch..
>
> Great, thanks!  Maybe wangyan can try your patch to see how the numbers
> compare to 9P.
>
> Stefan
>
I will test it when I get the patch, and post the compared result with
9p.

Thanks,
Yan Wang

