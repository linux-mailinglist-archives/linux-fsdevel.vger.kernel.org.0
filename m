Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5157D45B479
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhKXGvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:51:00 -0500
Received: from verein.lst.de ([213.95.11.211]:35850 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhKXGu7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:50:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F54468AFE; Wed, 24 Nov 2021 07:47:46 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:47:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 17/29] fsdax: factor out a dax_memzero helper
Message-ID: <20211124064745.GA7075@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-18-hch@lst.de> <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:22:13PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Factor out a helper for the "manual" zeroing of a DAX range to clean
> > up dax_iomap_zero a lot.
> >
> 
> Small / optional fixup below:

Incorporated.
