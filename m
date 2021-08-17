Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0887D3EED1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhHQNLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 09:11:32 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53551 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235463AbhHQNLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:11:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 444E1580B2A;
        Tue, 17 Aug 2021 09:10:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 17 Aug 2021 09:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=xtNL7MKvR9ER8Xw7XRE1SJsC55Q
        OmDv7otUyicJm4bA=; b=zer8n5c3j65hjKCHqkCGfl7KA/KMsl5U8k7Gkzel8tR
        TB9PI4MLkW/CsWyttCV718/Ezeg2KfSbE33Bmy+N03zQwuYViIzqWajW6HhFYAMB
        T41t+W4D8rMMtfjW2XkfwJ8zNCeTUZ6mFAOzGABBfEignNnGKN/QHd6u2L6yxgjg
        +ehHVphHjSSTCzdhTGiOhB9cB2xq/fqCtvTc6wacj2OA5IiF1YgwFDicoutu3irW
        jgZJU1oVUqY0X49hcNkqyGadiWyt+WtFQxe2gNEeLNB1wPMnKO2/2Kgu0KYOs4ya
        86F69zuBMaulEEvZVL1RPQ3Y66VyW/AWB4/8UdKN7Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xtNL7M
        KvR9ER8Xw7XRE1SJsC55QOmDv7otUyicJm4bA=; b=IU/RH3WYRX9P+Jn+dkkuT7
        EnXAX2O/xHkvrYUHdZz98lZlo0GdmrLa5HFuXS1UEUgK9+iGc5vlzJKfh0ExfE10
        kEgU+s9elo8x/Glle06gMwI4/EYiclv5hbLPNV7wpWR81lO2xGXHA1QFR5LJpK7j
        83GTufZQ01ZoL6624wL7nl4fksfoL0otcGbCkkrYz6aWpeAH/TNhU/v1IY7/l+ff
        pdu/a20hpeZFkbrXzl9djWdO/DSfvor6FgTJH2BzAYJfY1iA/pzRJ1dfjfxVxTu+
        0hY1VlH4kLev0OveuoxsSYdvCHMWET2WJ/4amZ+FHAq5ZYxU230ST7MoOvmVE8nQ
        ==
X-ME-Sender: <xms:W7UbYXkXz1mNG4J3L4VevBCW7wBAC2mDvKSHjuLsVcKOeiHHAsPgXw>
    <xme:W7UbYa3QxSV-P89lhoDi9siFRC30TI09CkEYvQPeHPIjNcDAtutDygDVQbKGjEh6J
    3tp13HYufkIWQ>
X-ME-Received: <xmr:W7UbYdqfkSuiS6CCeDvxOgEk9CHGuH81JpR_YuLNR96d90Yifphuqc7F7v71elMWvChmgrX90BeFSfuMVWfHSubuA1MG8807>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleefgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:W7UbYflXehCXBOklU-0G37vBlXBPdTZuSDHH_nrKNU6iC_GBDCNPcQ>
    <xmx:W7UbYV3v8DIwmaiwnox9y_cHAlXfKggU_odGNHlQ8yM5rD1fUnzFqA>
    <xmx:W7UbYesURvgWKauLhOo5gPvWnVQmJI2vs64LFeQTh4B5i0vmBaJOPA>
    <xmx:XrUbYQ0juNV9Td0BZ3gsdfZytA5Vfox6EvMokvxxPhkCTRtE1TeNhw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Aug 2021 09:10:50 -0400 (EDT)
Date:   Tue, 17 Aug 2021 15:10:48 +0200
From:   Greg KH <greg@kroah.com>
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com
Subject: Re: [PATCH 4/7] block: Introduce a new ioctl for simple copy
Message-ID: <YRu1WFImFulfpk7s@kroah.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
 <20210817101423.12367-5-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817101423.12367-5-selvakuma.s1@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 03:44:20PM +0530, SelvaKumar S wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> to a destination in the device. COPY ioctl accepts a 'copy_range'
> structure that contains destination (in sectors), no of sources and
> pointer to the array of source ranges. Each source range is represented by
> 'range_entry' that contains start and length of source ranges (in sectors)
> 
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> 
> Example code, to issue BLKCOPY:
> /* Sample example to copy three source-ranges [0, 8] [16, 8] [32,8] to
>  * [64,24], on the same device */
> 
> int main(void)
> {
> 	int ret, fd;
> 	struct range_entry source_range[] = {{.src = 0, .len = 8},
> 		{.src = 16, .len = 8}, {.src = 32, .len = 8},};
> 	struct copy_range cr;
> 
> 	cr.dest = 64;
> 	cr.nr_range = 3;
> 	cr.range_list = (__u64)&source_range;
> 
> 	fd = open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 
> 	ret = ioctl(fd, BLKCOPY, &cr);
> 	if (ret < 0) printf("copy failure\n");
> 
> 	close(fd);
> 
> 	return ret;
> }
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  block/ioctl.c           | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/fs.h |  8 ++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index eb0491e90b9a..2af56d01e9fe 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -143,6 +143,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  				    GFP_KERNEL, flags);
>  }
>  
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg)
> +{
> +	struct copy_range crange;
> +	struct range_entry *rlist;
> +	int ret;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> +		return -EFAULT;
> +
> +	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> +			GFP_KERNEL);

No error checking for huge values of nr_range?  Is that wise?  You
really want userspace to be able to allocate "all" of the kernel memory
in the system?

thanks,

greg k-h
