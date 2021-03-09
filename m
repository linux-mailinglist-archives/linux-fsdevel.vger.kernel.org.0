Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B30332BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 17:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhCIQTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 11:19:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCIQSt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:18:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8065AF0C;
        Tue,  9 Mar 2021 16:18:47 +0000 (UTC)
Date:   Tue, 9 Mar 2021 10:19:06 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210309161906.jjd7iw2y6hcst5c3@fiona>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiang,

Thanks for picking up this work.

On  8:20 26/02, Shiyang Ruan wrote:
> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.

How does this work for read sequence for two different files
mapped to the same extent, both residing in DAX?

If two different files read the same shared extent, which file
would resultant page->mapping->host point to?

This problem is listed as a TODO over dax_associate_entry() and is
still not fixed.

<snip>

-- 
Goldwyn
