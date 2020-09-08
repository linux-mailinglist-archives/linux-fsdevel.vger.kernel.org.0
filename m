Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6938B2612DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgIHOjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 10:39:13 -0400
Received: from verein.lst.de ([213.95.11.211]:52978 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbgIHO0K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32A6668C65; Tue,  8 Sep 2020 16:23:35 +0200 (CEST)
Date:   Tue, 8 Sep 2020 16:23:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     antlists <antlists@youngman.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/19] gdrom: use bdev_check_media_change
Message-ID: <20200908142334.GA7344@lst.de>
References: <20200902141218.212614-1-hch@lst.de> <20200902141218.212614-12-hch@lst.de> <0b8fa1fe-f2d5-bf18-2e8a-ad13e343629d@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8fa1fe-f2d5-bf18-2e8a-ad13e343629d@youngman.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:00:05PM +0100, antlists wrote:
> On 02/09/2020 15:12, Christoph Hellwig wrote:
>> The GD-ROM driver does not have a ->revalidate_disk method, so it can
>       ^^ (sic)

No, this really is the GD-ROM and not the CD-ROM driver!
