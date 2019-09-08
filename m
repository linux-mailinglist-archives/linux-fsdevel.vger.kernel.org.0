Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7562CACC7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 13:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfIHLyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 07:54:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728667AbfIHLyU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 07:54:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E5BFA0EC41FADBD4B48;
        Sun,  8 Sep 2019 19:54:18 +0800 (CST)
Received: from [10.45.2.172] (10.45.2.172) by smtp.huawei.com (10.3.19.205)
 with Microsoft SMTP Server id 14.3.439.0; Sun, 8 Sep 2019 19:54:14 +0800
Subject: Re: [Virtio-fs] [PATCH 00/18] virtiofs: Fix various races and
 cleanups round 1
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, <virtio-fs@redhat.com>,
        <linux-fsdevel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
From:   piaojun <piaojun@huawei.com>
Message-ID: <866a1469-2c4b-59ce-cf3f-32f65e861b99@huawei.com>
Date:   Sun, 8 Sep 2019 19:53:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.2.172]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/9/6 19:52, Miklos Szeredi wrote:
> On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
>>> On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Michael Tsirkin pointed out issues w.r.t various locking related TODO
>>>> items and races w.r.t device removal.
>>>>
>>>> In this first round of cleanups, I have taken care of most pressing
>>>> issues.
>>>>
>>>> These patches apply on top of following.
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
>>>>
>>>> I have tested these patches with mount/umount and device removal using
>>>> qemu monitor. For example.
>>>
>>> Is device removal mandatory?  Can't this be made a non-removable
>>> device?  Is there a good reason why removing the virtio-fs device
>>> makes sense?
>>
>> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
>> much like removal to work from the beginning.
> 
> Can you give an example use case?

I think VirtFS migration need hot plugging, or it may cause QEMU crash
or some problems.

Thanks,
Jun
