Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F563B1595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFWITs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWITr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:19:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD4BC061574;
        Wed, 23 Jun 2021 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ylx8VRLf0Cfe9lr6TBuxiLcTF+cT78GnznhSHPdmDc=; b=fIbKE6YstBTgl7AOS0TiV8TLpm
        aP2SbP5CcaTVcLGIs8i12aMgARqDRxIbtwLCkWglCiKI2ovk0E9J2HWL9LM0R28sHZfUieKwDV/G1
        K5O1VU5SM4Nhfbzfyo4/dqAryTHwEcdf5ldzkHhG27rpi1+g2Cx84kEvFmr22OUui+Ow+kMzeHtNy
        huWrAItwNtO96a7rwp/wRP2itZKjlntAdR5KDBHOp5cggLnrLwW05moyu+S1lKuTGkmsR13rXez+r
        uJ4C1BJoWfR+gRzlMNpJ31e/DUMkFWnVPSB3XHG1mgsEvtOZEdNWLCG5X0VEY9Hxh+bqFOBBDfRIr
        2jNgpDeA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy3j-00FCQ1-Cw; Wed, 23 Jun 2021 08:16:41 +0000
Date:   Wed, 23 Jun 2021 10:16:30 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/46] mm/memcg: Add folio_uncharge_cgroup()
Message-ID: <YNLt3pTSeZA7y3nN@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:20PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement mem_cgroup_uncharge() as a wrapper around
> folio_uncharge_cgroup().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
