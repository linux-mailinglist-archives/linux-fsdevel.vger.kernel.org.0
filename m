Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31B3EA1EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhHLJWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 05:22:32 -0400
Received: from verein.lst.de ([213.95.11.211]:43616 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236069AbhHLJWb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:22:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A512367373; Thu, 12 Aug 2021 11:22:04 +0200 (CEST)
Date:   Thu, 12 Aug 2021 11:22:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
Message-ID: <20210812092204.GB4827@lst.de>
References: <20210811070542.3403116-1-jhubbard@nvidia.com> <20210811070542.3403116-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811070542.3403116-4-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:05:42AM -0700, John Hubbard wrote:
> -		if (unlikely(!try_get_page(page)))
> +		if (unlikely(try_get_compound_head(page, 1) == NULL))

Why not a simple ! instead of the == NULL?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
