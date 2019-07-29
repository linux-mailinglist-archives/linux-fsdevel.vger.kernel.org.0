Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECD7909A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbfG2QR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 12:17:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58892 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbfG2QR2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:17:28 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hs8Ks-0001XX-8O; Mon, 29 Jul 2019 10:17:18 -0600
To:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
 <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
 <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
 <6DF00EEF-5A9D-49C9-A27C-BE34E594D9A9@raithlin.com>
 <322df1b1-dbba-2018-44da-c108336f8d55@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f4e551fe-f081-26d2-5a6a-46f826640189@deltatee.com>
Date:   Mon, 29 Jul 2019 10:17:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <322df1b1-dbba-2018-44da-c108336f8d55@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: maxg@mellanox.com, Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hare@suse.de, sbates@raithlin.com, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v6 00/16] nvmet: add target passthru commands support
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-07-29 10:15 a.m., Sagi Grimberg wrote:
> 
>>> This is different from multipath on say a multi-controller PCI device
>>> and trying to expose both those controllers through passthru. this is
>>> where the problems we are discussing come up.
>>
>> I *think* there is some confusion. I *think* Sagi is talking about network multi-path (i.e. the ability for the host to connect to a controller on the target via two different network paths that fail-over as needed). I *think* Logan is talking about multi-port PCIe NVMe devices that allow namespaces to be accessed via more than one controller over PCIe (dual-port NVMe SSDs being the most obvious example of this today).
> 
> Yes, I was referring to fabrics multipathing which is somewhat
> orthogonal to the backend pci multipathing (unless I'm missing
> something).

Yes, so if we focus on the fabrics multipathing, the only issue I see is
that only one controller can be connected to a passthru target (I
believe this was at your request) so two paths simply cannot exist to
begin with. I can easily remove that restriction.

Logan
