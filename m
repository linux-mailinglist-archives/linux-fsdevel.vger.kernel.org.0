Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBE8F020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfHOQHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 12:07:07 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59356 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOQHH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:07:07 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hyIHB-0001BN-TF; Thu, 15 Aug 2019 10:06:58 -0600
To:     Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-9-logang@deltatee.com>
 <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a6b9db95-a7f0-d1f6-1fa2-8dc13a6aa29e@deltatee.com>
Date:   Thu, 15 Aug 2019 10:06:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-08-15 6:36 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> This patch rejects any new connection to the passthru-ctrl if this
>> controller is already connected to a different host. At the time of
>> allocating the controller we check if the subsys associated with
>> the passthru ctrl is already connected to a host and reject it
>> if the hostnqn differs.
> 
> This is a big limitation.
> 
> Are we plan to enable many front-end ctrl's to connect to the single
> back-end ctrl in the future ?

Honestly, I don't know that it's really necessary, but the limitation
was requested by Sagi the first time this patch-set was submitted[1]
citing unspecified user troubles. If there's consensus to remove the
restriction I certainly can.

Logan

[1] http://lists.infradead.org/pipermail/linux-nvme/2018-April/016588.html

