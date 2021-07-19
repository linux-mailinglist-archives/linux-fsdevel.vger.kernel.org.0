Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D412C3CE28C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348256AbhGSPav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 11:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348024AbhGSPYR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 268EC613ED;
        Mon, 19 Jul 2021 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626710450;
        bh=AyDppAbQr+ozfywAjYIPhhIzoe8rAsZVoJN4/3CPOIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wnl3yXmLuWrHkJUM12djk5eyKICfd2Mb5AFrsLl01gUKn8MPzQFQUWfZcq98UIBC7
         Jb23Oov3tZv20IdGYkxV67dHUrU2IX4KiGv8h09kZ3VRF9NxSRTF1JRIAEHhHp/rPm
         ZggjeP6kD5oT45pykGXdv5VG95PnJZm9ZofAdfbKh/xJK+bfMc40JwAcZIrcj1a401
         hElKVPQ2J/Xk0dpYS18OES3ZXQIvl+C4tZC9NIH+v0kQtSB8p7jGam4W88F8J75Mmz
         VtNFcRUHRSrNuVLvucYfQzCXOf0no6enfG96vlwZmGyIr3bMdkif0Ub7ZIAnZwKmPl
         HjRU2/Fi04RMw==
Date:   Mon, 19 Jul 2021 09:00:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 01/27] iomap: fix a trivial comment typo in trace.h
Message-ID: <20210719160049.GC22402@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:34:54PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index fdc7ae388476f5..e9cd5cc0d6ba40 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (c) 2009-2019 Christoph Hellwig
>   *
> - * NOTE: none of these tracepoints shall be consider a stable kernel ABI
> + * NOTE: none of these tracepoints shall be considered a stable kernel ABI
>   * as they can change at any time.
>   */
>  #undef TRACE_SYSTEM
> -- 
> 2.30.2
> 
