Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29E32A34EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKBUKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgKBUJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:09:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599DC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVs0L5lRvwGWFdFk+32L8kAt1nvc+7ExB/JaU7+DRGo=; b=NhXZmK3d8d82Pb8COcVRPISLHP
        xCOfeOwY1bJdC77W6nrCJTvWeATuyNRRi0R2lGOicFhtLU5v0tVenJd156Ud5Xw8tmOlju47y5bMq
        DW9L923ppplgpTiLRin4CLpuzL5PdmwRJI8kPqwoR0sTgWvCezT/PDo+aybTszaqeT1uMu3w3iNHA
        yUj91NEj3PzB5PfQI2hToF+IUke06uez+UG7QXluAr1rDMryA5HL3nhCszjZhBhpflpgvalnh12ii
        eQg70zhCrYE3xJxuMRCaGBglnrjfzZXjmSMQ++QX9m0zGBwQBojgYcppMRFBE+RZOb9rAXUwTY1/U
        HTFWrPLA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZg8n-0003gI-MV; Mon, 02 Nov 2020 20:09:21 +0000
Date:   Mon, 2 Nov 2020 20:09:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201102200921.GR27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-12-willy@infradead.org>
 <20201102195056.GO2123636@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102195056.GO2123636@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:50:56PM -0500, Kent Overstreet wrote:
> On Mon, Nov 02, 2020 at 06:43:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > Move the complicated condition and the calculations out of
> > filemap_update_page() into its own function.
> 
> You're missing a signed-off-by
> 
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Oops.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
