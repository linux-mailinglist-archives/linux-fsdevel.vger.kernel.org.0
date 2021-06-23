Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFDD3B174C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFWJzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:55:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7206CC061756;
        Wed, 23 Jun 2021 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=J9mgPXdvXORScsOi8uWJd9geju
        wuUQkOXT6wTIENilZsr633QdcOu9PGh0Tsfd2bt8GmoydleiYr+E0iGCNuOo2M1RfKWtwKnV5j6ZO
        YOsNVOAfhn0hwkPXBI+Z7o4087WJO2D/aXaPissJ4b4hO5pJE4vWPTUGVAdSBWV1Zd3Kk+KlvumYS
        GjlTNfWD6+ZSClBcdjkRqVMEcGp0yWeizoLN6HHa1PC0UqD5xd7pK/rwO0kVg1T7mWsxZ+zX7nCyD
        dJfZGjwv6b/idTFzhFxqstqs8nF8VYA4645MMjyjcAlHrtaubHxw4pHaPZ7iN8CN7ky2gCpX29OP0
        AaJNrteQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzYx-00FHl7-7e; Wed, 23 Jun 2021 09:52:59 +0000
Date:   Wed, 23 Jun 2021 11:52:50 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 37/46] mm/workingset: Convert workingset_refault() to
 take a folio
Message-ID: <YNMEcmNXTNqmuAta@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-38-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-38-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
