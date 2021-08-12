Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8043E9ECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhHLGtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 02:49:43 -0400
Received: from verein.lst.de ([213.95.11.211]:43083 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHLGtm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:49:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 39FE567373; Thu, 12 Aug 2021 08:49:15 +0200 (CEST)
Date:   Thu, 12 Aug 2021 08:49:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 11/30] iomap: add the new iomap_iter model
Message-ID: <20210812064914.GA27145@lst.de>
References: <20210809061244.1196573-1-hch@lst.de> <20210809061244.1196573-12-hch@lst.de> <20210811003118.GT3601466@magnolia> <20210811053856.GA1934@lst.de> <20210811191708.GF3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811191708.GF3601443@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:17:08PM -0700, Darrick J. Wong wrote:
> > iter.c is also my preference, but in the end I don't care too much.
> 
> Ok.  My plan for this is to change this patch to add the new iter code
> to apply.c, and change patch 24 to remove iomap_apply.  I'll add a patch
> on the end to rename apply.c to iter.c, which will avoid breaking the
> history.

What history?  There is no shared code, so no shared history and.

> 
> I'll send the updated patches as replies to this series to avoid
> spamming the list, since I also have a patchset of bugfixes to send out
> and don't want to overwhelm everyone.

Just as a clear statement:  I think this dance is obsfucation and doesn't
help in any way.  But if that's what it takes..
