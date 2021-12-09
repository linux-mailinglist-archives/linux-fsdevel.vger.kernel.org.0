Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D846E253
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 07:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhLIGO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 01:14:56 -0500
Received: from verein.lst.de ([213.95.11.211]:34629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhLIGO4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:14:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7926C68B05; Thu,  9 Dec 2021 07:11:19 +0100 (CET)
Date:   Thu, 9 Dec 2021 07:11:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, dan.j.williams@intel.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into
 a ssize_t
Message-ID: <20211209061118.GA31368@lst.de>
References: <20211208091203.2927754-1-hch@lst.de> <20211209004846.GA69193@magnolia> <20211209005559.GB69193@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209005559.GB69193@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:55:59PM -0800, Darrick J. Wong wrote:
> Ok, so ... I don't know what I'm supposed to apply this to?  Is this
> something that should go in Christoph's development branch?

This is against the decouple DAX from block devices series, which also
decouples DAX zeroing from iomap buffered I/O zeroing.  It is in nvdimm.git
and has been reviewed by you as well:

https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending
