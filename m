Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C357572B819
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjFLGdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFLGdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:33:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64121985;
        Sun, 11 Jun 2023 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C57FyCt4CRCDjZL14oYvXlpnAQ8G4WQRCFNwmK9CzOM=; b=LAmOOvi9qr0AHJW/iFSZQE5I9C
        XzJ58aLU7U6sQm4uFKYqSkVmnakZqgiqn82N1EcETKIpQl3yH2/woRTQXjFi8HaKT/OfWFIktz5kH
        meLwEpVMyXsF4fumXsH4aQ2II/aSYFIoUV6zwvsjk+cb9tW2PATDtzRYDIo2+9rS6OMQLQScWK91h
        seUkpAIwewzeVe3ZycP6RlfutMj9OwCA69DmAOQ+XNoshrRVyhdEF25Efh8MpRqbI6iE/unHt8g23
        a8xMtmzb8eSC7yZo+LCOFi7Uo4T6VsJg+RB0m3mqft8rw6hBruWDWPvJfP+WnYad2QbFyjCjguru/
        L1qCrdBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8b00-002lBX-1J;
        Mon, 12 Jun 2023 06:25:56 +0000
Date:   Sun, 11 Jun 2023 23:25:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 4/6] iomap: Refactor iomap_write_delalloc_punch()
 function out
Message-ID: <ZIa6dD5HZ6etVIe+@infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62950460a9e78804df28c548327d779a8d53243f.1686395560.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 10, 2023 at 05:09:05PM +0530, Ritesh Harjani (IBM) wrote:
> This patch factors iomap_write_delalloc_punch() function out. This function
> is resposible for actual punch out operation.
> The reason for doing this is, to avoid deep indentation when we bring punch-out
> of individual non-dirty blocks within a dirty folio in a later patch
> (which adds per-block dirty status handling to iomap) to avoid delalloc block
> leak.

A bunch of overly long lines in the commit message here,
but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

