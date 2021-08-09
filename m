Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0D3E4995
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhHIQRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 12:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhHIQRc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C89A60F56;
        Mon,  9 Aug 2021 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628525831;
        bh=m7vz8d21YvgM97Zc8xDXGqr8lxsPtm8hfHCZhKbGpCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egKA3KD7B6v1ERvonhRjVesfgBDvdO2MhAem4ByYiMIzs3uwHP8qjIl6OfBg7CCUv
         DbNYINxgKfJK7L1ZvfgtpagYBjvsGqpSJ8MbpT7v50JVPdbJIB5CFL7tbZ+DQaTOZV
         0ptnZDZKvakvEJ7243AD2B3YtcNdmB3ZGmVuGqhuObkcBaP5WeXY1mx789JDbHzWDO
         qu2D/oGSJ29q6QKK8Hl25me6geokS7GuFdaipDHayaj6zIIHU41qMWxjGvM4ILFs8q
         m16i6ci9QnBYBCyvs42HTvcZu3t3s65xCMSxsy5+MeX/Ugwwb8DKthRipqqkwFAq1B
         2HZuAO+jLU/hA==
Date:   Mon, 9 Aug 2021 09:17:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 05/30] iomap: mark the iomap argument to
 iomap_inline_data_valid const
Message-ID: <20210809161711.GE3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:12:19AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/iomap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 560247130357b5..76bfc5d16ef49d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -109,7 +109,7 @@ static inline void *iomap_inline_data(const struct iomap *iomap, loff_t pos)
>   * This is used to guard against accessing data beyond the page inline_data
>   * points at.
>   */
> -static inline bool iomap_inline_data_valid(struct iomap *iomap)
> +static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  {
>  	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
>  }
> -- 
> 2.30.2
> 
