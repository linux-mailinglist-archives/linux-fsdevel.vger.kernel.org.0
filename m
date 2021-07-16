Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766AE3CBA04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhGPPoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 11:44:03 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36785 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233204AbhGPPoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:44:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id DED222B0114C;
        Fri, 16 Jul 2021 11:41:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 16 Jul 2021 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=7rpQy7cK945KPDHB9fAMedItGO9
        DCvVgGKwgFBhRTL4=; b=z07LD/Sc4IjJInG0ZyddT+NeYXZ3dZ5loRDMB8xK6rL
        f7qz7CzY4Pd9sswoWVUHkUlKW0EX6cssYVlGoIibTduzKhNdXJ035iw3rZRDEwm0
        7W2BxC7IqhSBWm7d5zMmOCTo1isIpBpgQWIrJOPkTenOd11pIizYfbS+kXlk3TKT
        PHSKNm6beOOfJwK3NetjCnrotG1KkmdrEbsea4j+qIwGO/f/guHM7wgvuYEr0JFz
        phrWqYM0BH5lwq/AuDM3L9e0P35em97uoxHsUUEA9O95VKArBvrOal2Plt8iW0ss
        hX/F/wp3+z9gF0BTsSdG35GwcyQ6D9FYXrnDRkzCGuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7rpQy7
        cK945KPDHB9fAMedItGO9DCvVgGKwgFBhRTL4=; b=QrO/klS2mTNqNvRJpuNlv5
        dDuJdqQxAtU65IHyoz7w53LnDHC+JJwTwYlFIXffXNKIHjY5xq/Ltuz/Bfw1MHte
        Wf1NELZyGydfhbR/o4O/SiesuSHN9OcwnRccItPh3zs/HInoVSAAuC18OUCgAsWR
        2VEzErNdHfuiI9h04TgwBQXhV8PdfTG/yIxatVITm8+P6/cZOOqGYrzRR5VwHJqw
        duvCgiLZRiWvPLLVdnmFQBwvETwBnYPDJfTzDbaklxW+ar2x8g/uTZa4213O6lhZ
        vrbufqyDMTMBvgMtzhIOi+BV7bkJJyg3LZE6Htpk1MemhmxsPeg0Ne8BcbtYtMzw
        ==
X-ME-Sender: <xms:kajxYDs766EKkCxP-7JskpPHTCXyKR1N48CwlkWqk5KZrwbtXtrbNA>
    <xme:kajxYEdWuVTBmU_cIMh2Y7EV23hjL5yIm7Cxh97J5jQrMUWHWw_ehzIToUh-FkxmZ
    df6yOpsJJ3RbA>
X-ME-Received: <xmr:kajxYGzeQakP04serziomrliNRZt9Jy0IQXcbrNe5_WQPDd5QoqufKIiG1X2zCHj6czpWLWCJ75hfRy64Cb9IkrrJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:kajxYCMoVDcKLse0a0_nUhhpd6EyYt1RF_hvc9IywyeEMspbMP_Ivg>
    <xmx:kajxYD9NbMEdwqZNO_ErI4moQ1BYFozPEZE9XmF8xCtyEW3e8yDt8Q>
    <xmx:kajxYCUafgG2ypTbNTje2bQKvcXqsipX8PgNWxJjB5vOMpAJQi9etQ>
    <xmx:kqjxYHW4lakU7lhVITm1gXR-DB3gNvmwV-K4Ix-tlixXyK_jP6wqRGCZEkY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jul 2021 11:41:04 -0400 (EDT)
Date:   Fri, 16 Jul 2021 17:41:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: MTD: How to get actual image size from MTD partition
Message-ID: <YPGojf7hX//Wn5su@kroah.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:12:41PM +0530, Pintu Agarwal wrote:
> Hi,
> 
> Our ARM32 Linux embedded system consists of these:
> * Linux Kernel: 4.14
> * Processor: Qualcomm Arm32 Cortex-A7
> * Storage: NAND 512MB
> * Platform: Simple busybox
> * Filesystem: UBIFS, Squashfs
> * Consists of nand raw partitions, squashfs ubi volumes.
> 
> My requirement:
> To find the checksum of a real image in runtime which is flashed in an
> MTD partition.

Try using the dm-verity module for ensuring that a block device really
is properly signed before mounting it.  That's what it was designed for
and is independent of the block device type.

good luck!

greg k-h
