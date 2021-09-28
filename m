Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2E41A46D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 02:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhI1A7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 20:59:01 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54075 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238379AbhI1A7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:59:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5A767580410;
        Mon, 27 Sep 2021 20:57:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Sep 2021 20:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aMTOwy
        1kRDglv9bWeV4pQeESYMtX8UBlRbYC0yXYRgQ=; b=ZOuzWiffGLc+sX04l19gVI
        YY7DB3F4UXso43esbO2BFAmGjtbUBmJrMhgHl4Fd4/lP1389NVGKiry/eU8DymQu
        1YWx0FyxfMdNGl2+hMg3S1+BYOoPXz0iuv+o/CabL6FncacKte1kSmv/QFcq2FHn
        1xi7LMekdnXTfgame6h/F8oo74ECuK5k1aubF5xuZ+D21osluDhHLH8s4hp7uJb5
        PhhKkWS703MBMpMsGFLvfMibC9pyeZZVFcs75aEy8IAzwOw2I44j+Ud3S+iIaSrp
        GjrX7GClyfWkWUEWAciNfw1iX0TwKthVfI2IoF/0ITpk+1cbfK2eeCRtmXkLhQbA
        ==
X-ME-Sender: <xms:cGhSYWo8LSaDS5CBcz8z2agNcO9RsgY4NFePO2R6WjZn1FbcQs4TIQ>
    <xme:cGhSYUoROMuzQmTz7R1XF9w1PeOqNrp9XJZ58SY61SJsFZUD2uxtmBRit9tE-aWCw
    IvO5nYnLuIP-qgsOIs>
X-ME-Received: <xmr:cGhSYbMwAPqrJDPdUwn1qe4zIVqBIbetrlYFfo8K-g__-eSsleWq3aqc3QuUGIC_qzXJN52XBHe-0bdCf5JVbjfxta15FGTKnK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvufgjkfhfgggtsehttdertd
    dttddvnecuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidq
    mheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpeffudfhgeefvdeitedugfelueeghe
    ekkeefveffhfeiveetledvhfdtveffteeuudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorh
    hg
X-ME-Proxy: <xmx:cGhSYV76vAE2s40-9N8gMALgTFevL4U99REmSJRJxxbuEhKrlwsr1g>
    <xmx:cGhSYV7SUhVurhNb-_7AcydzfVg_o7Bj9UjG2nu_TcYCTsjbDgAmww>
    <xmx:cGhSYVii0nBY_c8x90Xd2494z3rjIGeXZe4VJSWC2kwwcePJlerKiA>
    <xmx:cWhSYcqI3kg4T2UcS-3xqpq_X1J9yeXvC8nWLZyY-XMIZB_gDdhJ5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Sep 2021 20:57:18 -0400 (EDT)
Date:   Tue, 28 Sep 2021 10:57:18 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2 1/2] block: make __register_blkdev() return an error
In-Reply-To: <20210927220332.1074647-2-mcgrof@kernel.org>
Message-ID: <2ac2e05f-327a-b66f-aaa0-276db2e46730@linux-m68k.org>
References: <20210927220332.1074647-1-mcgrof@kernel.org> <20210927220332.1074647-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 Sep 2021, Luis Chamberlain wrote:

> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index 5dc9b3d32415..be0627345b21 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1989,24 +1989,34 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
>  
>  static DEFINE_MUTEX(ataflop_probe_lock);
>  
> -static void ataflop_probe(dev_t dev)
> +static int ataflop_probe(dev_t dev)
>  {
>  	int drive = MINOR(dev) & 3;
>  	int type  = MINOR(dev) >> 2;
> +	int err = 0;
>  
>  	if (type)
>  		type--;
>  
> -	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
> -		return;
> +	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	mutex_lock(&ataflop_probe_lock);
>  	if (!unit[drive].disk[type]) {
> -		if (ataflop_alloc_disk(drive, type) == 0) {
> -			add_disk(unit[drive].disk[type]);
> +		err = ataflop_alloc_disk(drive, type);
> +		if (err == 0) {
> +			err = add_disk(unit[drive].disk[type]);
> +			if (err)
> +				blk_cleanup_disk(unit[drive].disk[type]);
>  			unit[drive].registered[type] = true;
>  		}
>  	}
>  	mutex_unlock(&ataflop_probe_lock);
> +
> +out:
> +	return err;
>  }
>  
>  static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)

I think the change to ataflop_probe() would be more clear without adding 
an 'out' label, like your change to floppy.c:

> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 0434f28742e7..95a1c8ef62f7 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4517,21 +4517,27 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
>  
>  static DEFINE_MUTEX(floppy_probe_lock);
>  
> -static void floppy_probe(dev_t dev)
> +static int floppy_probe(dev_t dev)
>  {
>  	unsigned int drive = (MINOR(dev) & 3) | ((MINOR(dev) & 0x80) >> 5);
>  	unsigned int type = (MINOR(dev) >> 2) & 0x1f;
> +	int err = 0;
>  
>  	if (drive >= N_DRIVE || !floppy_available(drive) ||
>  	    type >= ARRAY_SIZE(floppy_type))
> -		return;
> +		return -EINVAL;
>  
>  	mutex_lock(&floppy_probe_lock);
>  	if (!disks[drive][type]) {
> -		if (floppy_alloc_disk(drive, type) == 0)
> -			add_disk(disks[drive][type]);
> +		if (floppy_alloc_disk(drive, type) == 0) {
> +			err = add_disk(disks[drive][type]);
> +			if (err)
> +				blk_cleanup_disk(disks[drive][type]);
> +		}
>  	}
>  	mutex_unlock(&floppy_probe_lock);
> +
> +	return err;
>  }
>  
>  static int __init do_floppy_init(void)

In floppy_probe(), I think you should return the potential error result 
from floppy_alloc_disk(), like you did in ataflop.c.
