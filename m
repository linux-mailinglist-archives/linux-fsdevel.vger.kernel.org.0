Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C77443863
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKBW1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 18:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhKBW1b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:27:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 935266103C;
        Tue,  2 Nov 2021 22:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635891895;
        bh=93ugh0/BharcNUSuO+AJG4ohymbTtkSYR9JCqKEs5M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcQUCOBO5p4PfBwfe7iqQTP0rDNmMuNFAy+MfUl4JStO0J7EHdgibkSlSVRlQd1UW
         Jx9GCgP+4ZCri5XjnvSeoQgS2VIrGkIaljYiZaU0vUpO5RACU0gvntOLh9tOal1VAE
         ZbrQ1ukoRnjjC+J3D+ZCdkykrTY4mtwQm1BtMAgthGbsKK5un9MkR1M+erh4Mztuyg
         sXilXG01WL2wapo6rn98FxDbxx/F/7qgozdEoVGwqku9A9N+2tYnjmd5OcRsamwIRi
         51nXgMTQahWK1ljnl//OyuT/BC5ZikAGm6Gok7puHca30dsJDmbI4YzuphHIJi1Rkc
         NuE9GRuifODyw==
Date:   Tue, 2 Nov 2021 15:24:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/21] block: Add bio_for_each_folio_all()
Message-ID: <20211102222455.GI24307@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-4-willy@infradead.org>
 <YYDlEmcpkTrph5HI@infradead.org>
 <YYGebqvswvJBdxuc@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYGebqvswvJBdxuc@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 08:24:14PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 02, 2021 at 12:13:22AM -0700, Christoph Hellwig wrote:
> > On Mon, Nov 01, 2021 at 08:39:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > > +static inline
> > > +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> > 
> > Please fix the weird prototype formatting here.
> 
> I dunno, it looks weirder this way:
> 
> -static inline
> -void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> +static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
> +               int i)
> 
> Anyway, I've made that change, but I still prefer it the way I had it.

I /think/ Christoph meant:

static inline void
bio_first_folio(...)

Though the form that you've changed it to is also fine.

--D

> > Otherwise looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
