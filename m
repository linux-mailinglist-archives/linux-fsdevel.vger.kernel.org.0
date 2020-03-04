Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A8C17939F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgCDPgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:36:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbgCDPgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ZkDQD/gXsq4Miba6qKflSejN3oeW5itWC9h2S3iLyw=; b=q717ZKrcpoWstmRLskLocacA6j
        U7iWfUf2nP2Y/OuIlhgan6iUfXhfiaEbsNNHl0qVgp6IVam4bne7HPMI1sb+nL54qVxpACGeWUSvL
        LjYib4/HT3Mi7T0bBsyfHoA0XpUvCWGua/jitW6xQg13i6MVjJ1dvcS6x3ucTzefRnXzDnxQDHmtq
        cSH8Haf8qLWSQZukD/1TANNOlhNt84Y6AJDFKlnLVGNCdjMTmhNCdIxZ449k3l+uSO6lIIDvEMLnQ
        YGJ6XlXLn3/F49eW5K+pb7pwjzckrYHmjZuIngz1sHZE7juIEXvHtmxJq2torW8MLjPsfKcAxibs8
        wqUqU4Fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9W40-0004Cy-Gp; Wed, 04 Mar 2020 15:36:00 +0000
Date:   Wed, 4 Mar 2020 07:36:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] iomap: Fix writepage tracepoint pgoff
Message-ID: <20200304153600.GA16079@infradead.org>
References: <20200304142259.GF29971@bombadil.infradead.org>
 <20200304152515.GA23148@infradead.org>
 <20200304153400.GG29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304153400.GG29971@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:34:00AM -0800, Matthew Wilcox wrote:
> I covered that -- "We're already returning the number of bytes from the
> beginning of the file in the 'offset' parameter, so correct the pgoff
> to be what was apparently intended."
> 
> I mean, we could just delete the pgoff instead.  Apparently nobody's
> using it, or they would surely have noticed.

Let's just kill it.
