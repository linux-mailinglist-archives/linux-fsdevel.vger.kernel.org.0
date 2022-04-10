Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398C4FAC47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 08:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiDJG2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiDJG2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 02:28:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BD5A08F;
        Sat,  9 Apr 2022 23:26:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E057168AFE; Sun, 10 Apr 2022 08:26:20 +0200 (CEST)
Date:   Sun, 10 Apr 2022 08:26:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, Jens Axboe <axboe@kernel.dk>,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Message-ID: <20220410062620.GA16234@lst.de>
References: <20220409045043.23593-1-hch@lst.de> <20220409045043.23593-25-hch@lst.de> <72e9bd34-3380-e305-65f0-a17306f5bd08@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72e9bd34-3380-e305-65f0-a17306f5bd08@linbit.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 09, 2022 at 10:15:33AM +0200, Christoph Böhmwalder wrote:
> On 09.04.22 06:50, Christoph Hellwig wrote:
>> Just use a non-zero max_discard_sectors as an indicator for discard
>> support, similar to what is done for write zeroes.
>>
>> The only places where needs special attention is the RAID5 driver,
>> which must clear discard support for security reasons by default,
>> even if the default stacking rules would allow for it.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [btrfs]
>
> I think you may have a typo there: my ACK was for drbd, not btrfs.

Indeed, sorry.
