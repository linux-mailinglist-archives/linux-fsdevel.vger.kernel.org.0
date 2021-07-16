Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3E3CB327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhGPHTJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 03:19:09 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48144 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbhGPHTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:19:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8AD12616B568;
        Fri, 16 Jul 2021 09:16:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wXv3S29yopAW; Fri, 16 Jul 2021 09:16:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2C4C56169BB9;
        Fri, 16 Jul 2021 09:16:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tSjbk7sNumXT; Fri, 16 Jul 2021 09:16:13 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F31C9616B568;
        Fri, 16 Jul 2021 09:16:12 +0200 (CEST)
Date:   Fri, 16 Jul 2021 09:16:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Message-ID: <456614823.32530.1626419772792.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: How to get actual image size from MTD partition
Thread-Index: wRfeFLQcDSd8DiGHIt8B6zS4rgdF6w==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pintu,

----- Ursprüngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> My requirement:
> To find the checksum of a real image in runtime which is flashed in an
> MTD partition.
> 
> Problem:
> Currently, to find the checksum, we are using:
> $ md5sum /dev/mtd14
> This returns the proper checksum of the entire partition.
> But we wanted to find the checksum only for the actual image data
> which will be used by our C utility to validate the image.
> Here, we don't know the actual image size.
> We only know the "partition-size" and "erasesize".
> 
> So, is there a mechanism to somehow find the image size at runtime?

not really, UBI manages the MTD and does wearleveling, auto growing of volumes, etc...
So as soon you attach the image once, it is changed and the checksum won't match.
It may work if you don't attach UBI and your flash program tool keeps track of
what pages it wrote.

Thanks,
//richard
