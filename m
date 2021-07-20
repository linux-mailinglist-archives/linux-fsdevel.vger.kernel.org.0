Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4C3CF921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhGTLIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbhGTLGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:06:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48266C0613DB;
        Tue, 20 Jul 2021 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B8UeUwvPWcIbPtTv6nrA9hdl8FBMSvcAD7UNU1HxbHE=; b=dTe183mOvz2DghYt8e28vKt/Ix
        i6OcbKn4DMtq+Xb1yzaVplrZq773sF+SsV2oVctQ6383DCx2RtkCTu8WISFoTxgYoQVAbSvNvQy5H
        9zlpxa8ct3v0j6Q8MEv3oQHCEoF3YZy2t5N4hHL+US2l7cBhxTB1Mn1hvliTAvuDTx+BGRs1LyJAE
        Ll7p2rlrARAVtOD+PkK+fqVcR0KHZdg6r4W43SB9rxrhEaRuoOJIKzQYFenYnlFAK6r4JZnEX9gCg
        zxKlgzqwm/QygQfqnlcvcGOHa4zpYX2rO3dPVJlxbsvAYMHr5LuXaXsvbsayUNOcNAxSmm9kc6dnU
        JAhv4p/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5oBw-0083pn-2O; Tue, 20 Jul 2021 11:45:48 +0000
Date:   Tue, 20 Jul 2021 12:45:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 16/17] iomap: Convert iomap_add_to_ioend to take a
 folio
Message-ID: <YPa3ZDiMGBkrMKqt@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-17-willy@infradead.org>
 <YPZ5S35wRlp3lMqY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPZ5S35wRlp3lMqY@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 09:20:43AM +0200, Christoph Hellwig wrote:
> >  	/*
> > -	 * Walk through the page to find areas to write back. If we run off the
> > -	 * end of the current map or find the current map invalid, grab a new
> > -	 * one.
> > +	 * Walk through the folio to find areas to write back. If we
> > +	 * run off the end of the current map or find the current map
> > +	 * invalid, grab a new one.
> 
> Why the reformatting?

s/page/folio/ takes the first line over 80 columns, so pass the whole
comment to 'fmt -p \*'
