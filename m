Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10344388D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKBWkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 18:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhKBWkI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7631B60E78;
        Tue,  2 Nov 2021 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635892652;
        bh=5Avz5CJ4k89VParLUaa1lNAvTbXfbJafWtAgcmx0Tj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTFmwz7a9dicRb8a1+owkax+gGPfSAp3XN+l5CITG9/bkbBDXHmiBAJqS+n3Zz6ka
         rKV6TkN6uTFDGblhw1aOJWqc4JOE8vxqfUiKPWRGv/651UHfVSq9SQcGp0CScWQnDp
         5Lm0K0RhtuF4LFOCYFTHkTGsfu4rPyRnVDob6N5aOwWBY6E4ayqk4MEId57As28Wb8
         ddqWyKqjXu0Tc2muvLIFWEMZwoZ4TXEiy5MNhZddoaC2hD1CaFS+xX2W1BydpA3Pnw
         ZRfDMlbNkDZoaF63YY/Xw/srARRoC4kFbrcizhY7ZvqPEsz454NJv2FzuX3Qw6dve/
         rZpYQ1H9ObJcQ==
Date:   Tue, 2 Nov 2021 15:37:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/21] block: Add bio_for_each_folio_all()
Message-ID: <20211102223732.GE2237511@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-4-willy@infradead.org>
 <YYDlEmcpkTrph5HI@infradead.org>
 <YYGebqvswvJBdxuc@casper.infradead.org>
 <20211102222455.GI24307@magnolia>
 <4ce6fb05-fe8d-6e4c-364a-0e2c9e8ee4ed@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce6fb05-fe8d-6e4c-364a-0e2c9e8ee4ed@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:33:39PM -0600, Jens Axboe wrote:
> On 11/2/21 4:24 PM, Darrick J. Wong wrote:
> > On Tue, Nov 02, 2021 at 08:24:14PM +0000, Matthew Wilcox wrote:
> >> On Tue, Nov 02, 2021 at 12:13:22AM -0700, Christoph Hellwig wrote:
> >>> On Mon, Nov 01, 2021 at 08:39:11PM +0000, Matthew Wilcox (Oracle) wrote:
> >>>> +static inline
> >>>> +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> >>>
> >>> Please fix the weird prototype formatting here.
> >>
> >> I dunno, it looks weirder this way:
> >>
> >> -static inline
> >> -void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> >> +static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
> >> +               int i)
> >>
> >> Anyway, I've made that change, but I still prefer it the way I had it.
> > 
> > I /think/ Christoph meant:
> > 
> > static inline void
> > bio_first_folio(...)
> > 
> > Though the form that you've changed it to is also fine.
> 
> I won't speak for Christoph, but basically everything else in block
> follows the:
> 
> static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
>                                    int i)
> {
> }
> 
> format, and this one should as well.

Durrr, /me forgot he was looking at block patches, not fs/iomap/. :(

Sorry for the noise.

--D

> -- 
> Jens Axboe
> 
