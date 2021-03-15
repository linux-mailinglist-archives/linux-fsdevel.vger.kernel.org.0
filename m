Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9067133C77D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCOUNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCOUNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:13:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E4C06174A;
        Mon, 15 Mar 2021 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dgs7psrYGQL+Unq74XNuKkHEyznQ/Y9spvfJtFMnHM0=; b=Xn91PDhQW1z2E6otmUZO98NrOc
        dGQuvQtdIFHzaK78AECvW89GDGCnqz6Mb73pf2FwpXStbziLATMEQqx18km8D8VXKb0WqFhCLtnbs
        yndGwM1A9yCPAxlBCJmppSBPqs5ZKtf4C1kJ14v3WuADUiyQpmhMXIiwWRJPhCxFZW7DtgRqNrAAS
        gZgjW01d8rJQrGiBCd4+sI8jZQoS2cStXvR6ydzfF3QLvVaHHXSuJUlMFmvT2is+nIzP2S6dG7hE5
        3LKK7hU58dHCBZLIuyfQnyZ49coNSjOJyF/orHsg++HZoSg4bEYEaGF0aFSnv8YoH0AHSkyri1sh4
        cRiwACuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLtal-000i0L-8i; Mon, 15 Mar 2021 20:13:35 +0000
Date:   Mon, 15 Mar 2021 20:13:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH -next 2/5] block: add ioctl to read the disk sequence
 number
Message-ID: <20210315201331.GA2577561@casper.infradead.org>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-3-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315200242.67355-3-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:02:39PM +0100, Matteo Croce wrote:
> +++ b/include/uapi/linux/fs.h
> @@ -184,6 +184,7 @@ struct fsxattr {
>  #define BLKSECDISCARD _IO(0x12,125)
>  #define BLKROTATIONAL _IO(0x12,126)
>  #define BLKZEROOUT _IO(0x12,127)
> +#define BLKGETDISKSEQ _IOR(0x12,128,__u64)
>  /*
>   * A jump here: 130-131 are reserved for zoned block devices
>   * (see uapi/linux/blkzoned.h)

Not your bug, but this is now 130-136.

+cc all the people who signed off on the commits that added those ioctl
numbers without updating this comment.  Perhaps one of them will figure
out how to stop this happening in future.
