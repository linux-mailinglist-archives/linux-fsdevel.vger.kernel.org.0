Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6445A3CFFF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhGTQcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 12:32:24 -0400
Received: from smtp02.tmcz.cz ([93.153.104.113]:43816 "EHLO smtp02.tmcz.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235157AbhGTQ2v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:28:51 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 12:28:50 EDT
Received: from leontynka.twibright.com (109-183-129-149.customers.tmcz.cz [109.183.129.149])
        by smtp02.tmcz.cz (Postfix) with ESMTPS id 537D4402AA;
        Tue, 20 Jul 2021 19:02:11 +0200 (CEST)
Received: from mikulas (helo=localhost)
        by leontynka.twibright.com with local-esmtp (Exim 4.92)
        (envelope-from <mikulas@twibright.com>)
        id 1m5t8E-0007EN-Q6; Tue, 20 Jul 2021 19:02:10 +0200
Date:   Tue, 20 Jul 2021 19:02:10 +0200 (CEST)
From:   Mikulas Patocka <mikulas@twibright.com>
X-X-Sender: mikulas@leontynka
To:     Christoph Hellwig <hch@lst.de>
cc:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: remove generic_block_fiemap
In-Reply-To: <20210720133341.405438-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.2107201857100.27763@leontynka>
References: <20210720133341.405438-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 20 Jul 2021, Christoph Hellwig wrote:

> Hi all,
> 
> this series removes the get_block-based generic_block_fiemap helper
> by switching the last two users to use the iomap version instead.
> 
> The ext2 version has been tested using xfstests, but the hpfs one
> is only compile tested due to the lack of easy to run tests.

Hi

You can download a test HPFS partition here:
http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/test-hpfs-partition.gz

Mikulas


> diffstat:
>  fs/ext2/inode.c        |   15 +--
>  fs/hpfs/file.c         |   51 ++++++++++++
>  fs/ioctl.c             |  203 -------------------------------------------------
>  include/linux/fiemap.h |    4 
>  4 files changed, 58 insertions(+), 215 deletions(-)
> 
