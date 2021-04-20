Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5712C364FCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 03:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhDTBVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 21:21:14 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:55250 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhDTBVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:21:13 -0400
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 477922EA15D;
        Mon, 19 Apr 2021 21:20:42 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id 1qZYRuf+pZPQ; Mon, 19 Apr 2021 21:01:03 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 9818B2EA124;
        Mon, 19 Apr 2021 21:20:41 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone
 files
To:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
 <20210419064529.GA19041@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <9a4d5090-1a70-129a-72f7-3699db0038a1@interlog.com>
Date:   Mon, 19 Apr 2021 21:20:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210419064529.GA19041@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-19 2:45 a.m., Christoph Hellwig wrote:
> On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:
>> Synchronous writes to sequential zone files cannot use zone append
>> operations if the underlying zoned device queue limit
>> max_zone_append_sectors is 0, indicating that the device does not
>> support this operation. In this case, fall back to using regular write
>> operations.
> 
> Zone append is a mandatory feature of the zoned device API.

So a hack required for ZNS and not needed by ZBC and ZAC becomes
a "mandatory feature" in a Linux API. Like many hacks, that one might
come back to bite you :-)

Doug Gilbert

