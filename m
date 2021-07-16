Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015093CBA84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhGPQ3y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 12:29:54 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56096 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhGPQ3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:29:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C7A836169BB0;
        Fri, 16 Jul 2021 18:26:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id r4aiC90VSn-V; Fri, 16 Jul 2021 18:26:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4CE52616B593;
        Fri, 16 Jul 2021 18:26:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iZzCNoafkg8f; Fri, 16 Jul 2021 18:26:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1F0216169BB0;
        Fri, 16 Jul 2021 18:26:57 +0200 (CEST)
Date:   Fri, 16 Jul 2021 18:26:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Greg KH <greg@kroah.com>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Message-ID: <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
In-Reply-To: <YPGojf7hX//Wn5su@kroah.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com> <YPGojf7hX//Wn5su@kroah.com>
Subject: Re: MTD: How to get actual image size from MTD partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: How to get actual image size from MTD partition
Thread-Index: EX+isZbzvbtTKORywh51Mf2FxgrK+w==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Greg KH" <greg@kroah.com>
> An: "Pintu Agarwal" <pintu.ping@gmail.com>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-fsdevel"
> <linux-fsdevel@vger.kernel.org>, "Phillip Lougher" <phillip@squashfs.org.uk>, "Sean Nyekjaer" <sean@geanix.com>,
> "Kernelnewbies" <kernelnewbies@kernelnewbies.org>, "richard" <richard@nod.at>
> Gesendet: Freitag, 16. Juli 2021 17:41:01
> Betreff: Re: MTD: How to get actual image size from MTD partition

> On Fri, Jul 16, 2021 at 12:12:41PM +0530, Pintu Agarwal wrote:
>> Hi,
>> 
>> Our ARM32 Linux embedded system consists of these:
>> * Linux Kernel: 4.14
>> * Processor: Qualcomm Arm32 Cortex-A7
>> * Storage: NAND 512MB
>> * Platform: Simple busybox
>> * Filesystem: UBIFS, Squashfs
>> * Consists of nand raw partitions, squashfs ubi volumes.
>> 
>> My requirement:
>> To find the checksum of a real image in runtime which is flashed in an
>> MTD partition.
> 
> Try using the dm-verity module for ensuring that a block device really
> is properly signed before mounting it.  That's what it was designed for
> and is independent of the block device type.

MTDs are not block devices. :-)

Thanks,
//richard
