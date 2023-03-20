Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B246C0942
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 04:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCTDSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 23:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCTDS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:18:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651514EBC;
        Sun, 19 Mar 2023 20:18:24 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pg0Gv3lnVz17M2V;
        Mon, 20 Mar 2023 11:15:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 11:18:22 +0800
Subject: Re: ubi0 error: ubi_open_volume: cannot open device 0, volume 6,
 error -16
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
References: <CAOuPNLgTWNMSaZmE4UzOq8UhsLWnBzyt0xwsO=dS9NpQxh-h_g@mail.gmail.com>
 <CAOuPNLiu+40HREtXFL_yMaXiaRtnZSbW9VvZRZmEpNXvZWzaQw@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5d0e0518-267c-7445-5d6a-b28b6000b033@huawei.com>
Date:   Mon, 20 Mar 2023 11:18:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLiu+40HREtXFL_yMaXiaRtnZSbW9VvZRZmEpNXvZWzaQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
> Hi,
> 
> Sorry, for missing the subject last time.
> 
> On Wed, 15 Feb 2023 at 23:06, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>>
>> Hi,
>>
>> We are seeing below "ubi errors" during booting.
>> Although this does not cause any functionality break, I am wondering
>> if there is any way to fix it ?
>> We are using Kernel 4.14 with UBI and squashfs (ubiblock) as volumes,
>> and with systemd.
>>
>> Anybody have experienced the similar logs with ubi/squashfs and
>> figured out a way to avoid it ?
>> It seems like these open volumes are called twice, thus error -16
>> indicates (device or resource busy).
>> Or, are these logs expected because of squashfs or ubiblock ?
>> Or, do we need to add anything related to udev-rules ?
>>
>> {
>> ....
>> [  129.394789] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 6, error -16
>> [  129.486498] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 7, error -16
>> [  129.546582] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 8, error -16
>> [  129.645014] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 9, error -16
>> [  129.676456] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 6, error -16
>> [  129.706655] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 10, error -16
>> [  129.732740] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 7, error -16
>> [  129.811111] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 8, error -16
>> [  129.852308] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 9, error -16
>> [  129.923429] ubi0 error: ubi_open_volume: cannot open device 0,
>> volume 10, error -16
>>
>> }
>>
> 
> I see that the errors are reported by systemd-udevd and other processes.
> Is there a way to fix it by some means ?
> These logs actually consume lots of boot up time...

I guess that systemd-udevd and mtd_probe are racing to open the same 
volume with mode UBI_EXCLUSIVE or UBI_READWRITE, and these error 
messages are in expected. How about temporarily shutting down 
systemd-udevd during booting?

