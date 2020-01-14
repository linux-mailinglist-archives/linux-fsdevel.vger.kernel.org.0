Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4012713B502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 23:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgANWEA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 17:04:00 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51108 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgANWD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:03:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F0AC160A0741;
        Tue, 14 Jan 2020 23:03:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a8MQp3-WUMm1; Tue, 14 Jan 2020 23:03:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8FE95609D2D5;
        Tue, 14 Jan 2020 23:03:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2oyOLMSheoPF; Tue, 14 Jan 2020 23:03:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6CE04609D2C7;
        Tue, 14 Jan 2020 23:03:56 +0100 (CET)
Date:   Tue, 14 Jan 2020 23:03:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fscrypt <linux-fscrypt@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1925918130.21041.1579039436354.JavaMail.zimbra@nod.at>
In-Reply-To: <20200114220016.GL41220@gmail.com>
References: <20191209222325.95656-1-ebiggers@kernel.org> <20200114220016.GL41220@gmail.com>
Subject: Re: [PATCH 0/2] ubifs: fixes for FS_IOC_GETFLAGS and
 FS_IOC_SETFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: fixes for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS
Thread-Index: mWPSwcJiuwlSeT6UhNkSjlyF2M4a4g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Eric Biggers" <ebiggers@kernel.org>
> An: "richard" <richard@nod.at>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-fscrypt" <linux-fscrypt@vger.kernel.org>, "linux-fsdevel"
> <linux-fsdevel@vger.kernel.org>
> Gesendet: Dienstag, 14. Januar 2020 23:00:17
> Betreff: Re: [PATCH 0/2] ubifs: fixes for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS

> On Mon, Dec 09, 2019 at 02:23:23PM -0800, Eric Biggers wrote:
>> On ubifs, fix FS_IOC_SETFLAGS to not clear the encrypt flag, and update
>> FS_IOC_GETFLAGS to return the encrypt flag like ext4 and f2fs do.
>> 
>> Eric Biggers (2):
>>   ubifs: fix FS_IOC_SETFLAGS unexpectedly clearing encrypt flag
>>   ubifs: add support for FS_ENCRYPT_FL
>> 
>>  fs/ubifs/ioctl.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> Richard, have you had a chance to review these?  I'm intending that these be
> taken through the UBIFS tree too.

It is in my review queue. Didn't I update the patch state in patchwork (me double checks)?

Thanks,
//richard
