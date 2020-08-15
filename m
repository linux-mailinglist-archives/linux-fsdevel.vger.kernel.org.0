Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746182452CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Aug 2020 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgHOVzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgHOVwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF150C004582;
        Sat, 15 Aug 2020 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XNnhqa1EUtqytFCfJSuJLhsT+WcSRC9k4ESXyMuhNTU=; b=snPX6e/0YVSp1IEqXQqMvaGXZs
        690Ej5IRXxO8q+ekbLWln56lZObyenBEZwB9gVI+Rgh/OVCz/ZK6rZ4jpBAcJvUQINLfYnI32NB5p
        Dl7iwSxgXobIfatecLrHb6exWfppgGaF3SGpXbQLu4fPe87kg12MUrlydN52Wf8nDfpUIrGdaWcm9
        nEkcMn9QTO9mtJWj80Edzz618rhyeqdm1gr9hKGSjB/YVI0REbzkZAS8LG+QCittA7Tuz1kyguuP9
        vu2LrGHht4+Mxd4hRkmteFllaPNl3oIQx7ZZSsMHMXUrA9YkY1I9D9vEraTU4PXR5N6qZ9FLEO40B
        Y0NFTu5w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k70pY-0004UB-36; Sat, 15 Aug 2020 18:23:00 +0000
Date:   Sat, 15 Aug 2020 19:23:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH 2/2] tree-wide: rename vmemdup_user to kvmemdup_user
Message-ID: <20200815182300.GZ17456@casper.infradead.org>
References: <2e717622-22ba-9947-c8df-520bdbb2e16f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e717622-22ba-9947-c8df-520bdbb2e16f@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 15, 2020 at 03:10:12PM +0200, Markus Elfring wrote:
> > This helper uses kvmalloc, not vmalloc, so rename it to kvmemdup_user to
> > make it clear we're using kvmalloc() and will need to use kvfree().
> 
> Can the renaming of this function name trigger software updates
> for any more source files?

Why don't you find out, and if there are, submit your own patch?

> Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/memdup_user.cocci?id=c9c9735c46f589b9877b7fc00c89ef1b61a31e18#n18
> 
> Regards,
> Markus
