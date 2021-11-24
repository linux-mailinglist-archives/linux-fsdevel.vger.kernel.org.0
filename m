Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1673C45B493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhKXGzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:55:42 -0500
Received: from verein.lst.de ([213.95.11.211]:35872 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239223AbhKXGzk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:55:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5343868AFE; Wed, 24 Nov 2021 07:52:28 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:52:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 18/29] fsdax: decouple zeroing from the iomap buffered
 I/O code
Message-ID: <20211124065228.GC7075@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-19-hch@lst.de> <20211123225315.GM266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123225315.GM266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:53:15PM -0800, Darrick J. Wong wrote:
> > -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> > +static loff_t dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
> 
> Shouldn't this return value remain s64 to match iomap_iter.processed?

I'll switch it over.  Given that loff_t is always the same as s64
it shouldn't really matter.

(same for the others)
