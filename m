Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B255827B272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgI1QsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 12:48:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:53199 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgI1QsD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:48:03 -0400
IronPort-SDR: 03sIbRzvAm2pqeY8sOkmI2e9IVDqsmIOIN9U2VbSQutL4WCKaBjMRKzi8mbJN86RA37zyaprXW
 YVPztBF27k6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141432582"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="141432582"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:42:00 -0700
IronPort-SDR: XQbWhO6KAZk/NW7/DnVHmkDsi3NHvQJUZzp4VEntXkFgINs7ch4KuI5QCRR6CzELcCW1goYtZE
 QtmsawxwcH1A==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488651317"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:42:00 -0700
Date:   Mon, 28 Sep 2020 09:42:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] man/statx: Add STATX_ATTR_DAX
Message-ID: <20200928164200.GA459459@iweiny-DESK2.sc.intel.com>
References: <20200505002016.1085071-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505002016.1085071-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 05:20:16PM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Linux 5.8 is slated to have STATX_ATTR_DAX support.
> 
> https://lore.kernel.org/lkml/20200428002142.404144-4-ira.weiny@intel.com/
> https://lore.kernel.org/lkml/20200504161352.GA13783@magnolia/
> 
> Add the text to the statx man page.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Have I sent this to the wrong list?  Or perhaps I have missed a reply.

I don't see this applied to the man-pages project.[1]  But perhaps I am looking
at the wrong place?

Thank you,
Ira

[1] git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

> ---
>  man2/statx.2 | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index 2e90f07dbdbc..14c4ab78e7bd 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -468,6 +468,30 @@ The file has fs-verity enabled.
>  It cannot be written to, and all reads from it will be verified
>  against a cryptographic hash that covers the
>  entire file (e.g., via a Merkle tree).
> +.TP
> +.BR STATX_ATTR_DAX (since Linux 5.8)
> +The file is in the DAX (cpu direct access) state.  DAX state attempts to
> +minimize software cache effects for both I/O and memory mappings of this file.
> +It requires a file system which has been configured to support DAX.
> +.PP
> +DAX generally assumes all accesses are via cpu load / store instructions which
> +can minimize overhead for small accesses, but may adversely affect cpu
> +utilization for large transfers.
> +.PP
> +File I/O is done directly to/from user-space buffers and memory mapped I/O may
> +be performed with direct memory mappings that bypass kernel page cache.
> +.PP
> +While the DAX property tends to result in data being transferred synchronously,
> +it does not give the same guarantees of O_SYNC where data and the necessary
> +metadata are transferred together.
> +.PP
> +A DAX file may support being mapped with the MAP_SYNC flag, which enables a
> +program to use CPU cache flush instructions to persist CPU store operations
> +without an explicit
> +.BR fsync(2).
> +See
> +.BR mmap(2)
> +for more information.
>  .SH RETURN VALUE
>  On success, zero is returned.
>  On error, \-1 is returned, and
> -- 
> 2.25.1
> 
