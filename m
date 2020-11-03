Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B32A48E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKCPEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgKCPCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:02:49 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059AC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:02:47 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id m143so9309081oig.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cSj1qyXPcAnIprjkzrJyn0tLU6UO+RSsAyudL3znpE=;
        b=A0ueR2whzabPvobC83uA8Ecpb5mhETm5xYuhVKX/pA6/uuZJeIrE5mL1i5k6/j08Cj
         I7tWWvYQNEL2QWJMcgLlTTUnhJjBemK4BMO1zlXGSjn6HI746Q24v/Hy7q+nIcInzY/o
         EO400+F8h0igJ9oUbr9dWb3553af6m95x/wsErcPJXszDlC6eGxbjuBNoSWfEqyd6ofK
         34mu8ffPfQwuNWC5r9UUu9H6OHzUkFfHnYfTFsI71yDNn9lwKHnU7FJ3/OjZrsgjGapG
         XNKcBIdfD4604AnahM/p9cqNIhv8cJWK5wIuclybFcjh3kzMO9YREsu8m3D67/hJqYJC
         E57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cSj1qyXPcAnIprjkzrJyn0tLU6UO+RSsAyudL3znpE=;
        b=NQ8KJWNh/Ab6WT3QbNf0rwGKJw/Aj8bX34lhY+uAb4HWCc39ce+5Nb0QFZeoHCRQRp
         su259s1Wt/3IcrFJuTtbwUyRA4sOBlcvrjKEtOxFEEOPo53Q4/B4OXlN5c26370wQFS7
         rQr9GSWfg9MbDQsxhyj3kHDxdE6mY6K7BddXpk6vARP8FUx2a/H6m/2ZpUVxHUvDbavZ
         /thgmi5xfsi3GDxZuTd38mCra0GJeGF5cumil8Byn1t7WMMVTMLDWaSx9RV/9fhEIMci
         odK/kvBf81/aepRy4cwJmNsEzBFcCWaCF7qBj53vSv0qXkkbZQ0CmDyNbyVenlK0tKxy
         l8MQ==
X-Gm-Message-State: AOAM531mMNLRBljvaqr7vTT4N5PsBRdkDpe0FcnzcLUsAD6QG6A4aQwz
        /+zx1EIagwluQ3e7H3I+9GIC54BAjZYKTAgSLAA/4CtY8t0=
X-Google-Smtp-Source: ABdhPJz3SXex+eqBK9cJWVNs2PeRmh1EbeSIyFf4MDZEYfI7pO6vgtipWtAumPk+ebuoP60Rj8x1+OzJPjyaZucz0VY=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr67114oig.161.1604415767222;
 Tue, 03 Nov 2020 07:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-2-willy@infradead.org>
 <20201103072700.GA8389@lst.de> <20201103145250.GX27442@casper.infradead.org>
In-Reply-To: <20201103145250.GX27442@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 07:02:36 -0800
Message-ID: <CAE1WUT4h6OcDo193Lur63AtK4zgcBJDVPuJP65dPfG1J19kZ8Q@mail.gmail.com>
Subject: Re: [PATCH 01/17] mm/filemap: Rename generic_file_buffered_read subfunctions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kent.overstreet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 6:53 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 03, 2020 at 08:27:00AM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 02, 2020 at 06:42:56PM +0000, Matthew Wilcox (Oracle) wrote:
> > > The recent split of generic_file_buffered_read() created some very
> > > long function names which are hard to distinguish from each other.
> > > Rename as follows:
> > >
> > > generic_file_buffered_read_readpage -> filemap_read_page
> > > generic_file_buffered_read_pagenotuptodate -> filemap_update_page
> > > generic_file_buffered_read_no_cached_page -> filemap_create_page
> > > generic_file_buffered_read_get_pages -> filemap_get_pages
> >
> > Find with me, although I think filemap_find_get_pages would be a better
> > name for filemap_get_pages.
>
> To me, 'find' means 'starting from this position, search forward in the
> array for the next page', but we don't want to do that, we just want to
> get a batch of pages starting _at_ this index.  Arguably it'd be better
> named filemap_get_or_create_batch().

filemap_get_or_crerate_batch() would be a better name, as to me, find
entails "begin here and continue looking for the next instance" (in this
case, an instance would be a page).

Best regards,
Amy Parker
(they/them)
