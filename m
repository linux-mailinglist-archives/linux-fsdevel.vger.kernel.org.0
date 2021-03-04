Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAD32C519
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383035AbhCDATN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:13 -0500
Received: from verein.lst.de ([213.95.11.211]:36164 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356546AbhCCKrl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C1EF68BFE; Wed,  3 Mar 2021 10:29:37 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:29:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v2 04/10] fsdax: Introduce dax_iomap_cow_copy()
Message-ID: <20210303092936.GD12784@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <20210226002030.653855-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-5-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:20:24AM +0800, Shiyang Ruan wrote:
> +	if (!copy_edge) {
> +		ret = copy_mc_to_kernel(daddr, saddr, length);
> +		return ret;

No need for the ret variable here, this can be:

	if (!copy_edge)
		return copy_mc_to_kernel(daddr, saddr, length);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
