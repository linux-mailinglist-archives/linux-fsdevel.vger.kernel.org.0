Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C33FEA25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbhIBHoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:44:44 -0400
Received: from verein.lst.de ([213.95.11.211]:50319 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243361AbhIBHon (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:44:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF11268B05; Thu,  2 Sep 2021 09:43:43 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:43:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v8 7/7] xfs: Add dax dedupe support
Message-ID: <20210902074342.GF13867@lst.de>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com> <20210829122517.1648171-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829122517.1648171-8-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 08:25:17PM +0800, Shiyang Ruan wrote:
> Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
> who are going to be deduped.  After that, call compare range function
> only when files are both DAX or not.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
