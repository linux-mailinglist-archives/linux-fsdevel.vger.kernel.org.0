Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7F443899
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 23:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhKBWlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 18:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhKBWlx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:41:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F67F61058;
        Tue,  2 Nov 2021 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635892758;
        bh=O/fJB1Su3Q6+W+ASLuT2yZYyhlwKE3dR8/QUTtPvjD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDNEFCkbG7NaEdirxQosgbQhsoyCtLel9OaEYYfvNmxtI8yX/CZlxBmSL764KxLTa
         uHTNSiRzacCfGvwV/W+jty7ZIKkVyuNKDewNUF+mKzl37QxFHJhysHodVYfnF5zReL
         QPpOi4p71CAaVlJatpUgYLh6o4dDYPjXk+FAUWdbkerflcu14JScXRFtwV6ge2pepd
         CMiVVqkNqVC3NNrEj2OSjSzmREhrhHrBD5Hti2CONiWwMIL2fhHAc3+oIkyDvEYGto
         cAzOjK0TJunxjBkAy0du4DTrl3FKDnEfUAE9AMpzV7w8ago4dm6alC2ZK1kiqPPzsh
         /RxIY56CKwu+g==
Date:   Tue, 2 Nov 2021 15:39:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/21] iomap: Convert iomap_releasepage to use a folio
Message-ID: <20211102223918.GF2237511@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-8-willy@infradead.org>
 <YYDlWz8eHOzrQ29Y@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYDlWz8eHOzrQ29Y@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 12:14:35AM -0700, Christoph Hellwig wrote:
> On Mon, Nov 01, 2021 at 08:39:15PM +0000, Matthew Wilcox (Oracle) wrote:
> > This is an address_space operation, so its argument must remain as a
> > struct page, but we can use a folio internally.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This seems reasonable to me too.

Even if my MTA saw "This is an ad" and spat it out. ;)

That has now been fixed, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

