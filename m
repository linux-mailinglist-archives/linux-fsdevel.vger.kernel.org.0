Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C193FEA14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhIBHfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:35:33 -0400
Received: from verein.lst.de ([213.95.11.211]:50285 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233401AbhIBHfc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:35:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D7B168B05; Thu,  2 Sep 2021 09:34:30 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:34:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v8 5/7] fsdax: Dedup file range to use a compare
 function
Message-ID: <20210902073429.GD13867@lst.de>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com> <20210829122517.1648171-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829122517.1648171-6-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +EXPORT_SYMBOL(vfs_dedupe_file_range_compare);

I don't see why this would need to be exported.

> @@ -370,6 +384,15 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(__generic_remap_file_range_prep);

Same here.
