Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0539A50E97A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiDYTa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiDYTa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:30:58 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 12:27:51 PDT
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC31110978;
        Mon, 25 Apr 2022 12:27:51 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id D0F9FE0F7E;
        Mon, 25 Apr 2022 19:22:36 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id B304460284;
        Mon, 25 Apr 2022 19:22:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id PaBD9BfcMjTl; Mon, 25 Apr 2022 19:22:36 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 535B860958;
        Mon, 25 Apr 2022 19:22:35 +0000 (UTC)
Message-ID: <bc0b2c10-10e6-a1d9-4139-ac93ad3512b2@interlog.com>
Date:   Mon, 25 Apr 2022 15:22:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: dgilbert@interlog.com
Subject: Re: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Content-Language: en-CA
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org> <YmJDqceT1AiePyxj@infradead.org>
 <YmLEeUhTImWKIshO@bombadil.infradead.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <YmLEeUhTImWKIshO@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-04-22 11:06, Luis Chamberlain wrote:
> On Thu, Apr 21, 2022 at 10:56:57PM -0700, Christoph Hellwig wrote:
>> On Thu, Apr 21, 2022 at 10:53:30AM -0700, Luis Chamberlain wrote:
>>> Moving this discussion to the lists as we need to really think
>>> about how testing on fstests and blktests uses scsi_debug for
>>> a high confidence in baseline without false positives on failures
>>> due to the inability to the remove scsi_debug module.
>>>
>>> This should also apply to other test debug modules like null_blk,
>>> nvme target loop drivers, etc, it's all the same long term. But yeah
>>> scsi surely make this... painful today. In any case hopefully folks
>>> with other test debug drivesr are running tests to ensure you can
>>> always rmmod these modules regardless of what is happening.
>>
>> Maybe fix blktests to not rely on module removal  I have such a hard
>> time actually using blktests because it is suck a f^^Y% broken piece
>> of crap that assumes everything is modular.  Stop making that whole
>> assumption and work fine with built-in driver as a first step.  Then
>> start worrying about module removal.
> 
> It begs the question if the same wish should apply to fstests.
> 
> If we want to *not* rely on module removal then the right thing to do I
> think would be to replace module removal on these debug modules
> (scsi_debug) with an API as null_blk has which uses configfs to *add* /
> *remove* devices.

The scsi_debug driver has been around for a while, I started maintaining it
around 1998. It was always assumed that it would be used as a module while
testing, then removed. You might wonder why the number of SCSI hosts simulated
by scsi_debug is called "add_hosts"? That is because it is also a sysfs
read-write parameter that can take a positive or negative integer to add or
remove that number of SCSI hosts at runtime, without removing the module.
See /sys/bus/pseudo/drivers/scsi_debug where about 2/3 of the parameters
are writable. Perhaps configfs capability could be added to scsi_debug,
patches welcome ...

If you want a cheap ram disk to back file system tests then null_blk is the
way to go.

The scsi_debug driver is a SCSI low level driver (LLD) controlling a
simulated HBA (on the "pseudo" bus) that has zero or more SCSI devices
(e.g. disks) attached to it. It is designed to back sd, st, ses Linux
devices (e.g. /dev/sdb). And it can simulate various types of storage
that are found in the real world, for example storage with associated
protection information and more recently with zoned storage. It can also
simulate errors and/or a _lot_ of devices (say 10,000) by sharing the
backing ram behind each device.

So the fact that the scsi_debug driver can support blktests could be seen
as a bit of an accident, that is not its primary purpose.

Doug Gilbert


