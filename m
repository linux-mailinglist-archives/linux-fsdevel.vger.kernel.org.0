Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDB618478
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiKCQbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiKCQaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2C18392;
        Thu,  3 Nov 2022 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5PQSGj46emORhgqUGtr0hTIjmIvlY1AkXmhC02LCPAA=; b=gmwmoIZ2h1Xz9z9c9NybrgM2bl
        PivdbbtviFzLY3YDWmixp1SdgarKlthl/De5brg2Vv8wH9CpzxHighzFfPfOsOand50+W3Kfp6Dw0
        is+TuL+R/vZisl2uucsH1N2L/iYPsIjYM6dt42PPcMnIPfcWdXOsb7DZLmmTwOj894wRDryxdKlWC
        s7L57HT3NwJ4GnMxDjFZUSSeXJW/PllNIq0sUj7bH37Ae+NymznwohCjhAECS8wn5kzD7/Qs2+3s2
        AVu69TV/nqh9/uoMIMzcY16a3ChjXSaO5VToiac0sI/D4oATurt5OXSKkGA/+h+fML1WishsdWiZT
        nAe4PhlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqd73-006bLA-1d; Thu, 03 Nov 2022 16:30:41 +0000
Date:   Thu, 3 Nov 2022 16:30:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv2] iomap: directly use logical block size
Message-ID: <Y2PssKdUUtmWNvTW@casper.infradead.org>
References: <20221103154339.2150274-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103154339.2150274-1-kbusch@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:43:39AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Don't transform the logical block size to a bit shift only to shift it
> back to the original block size. Just use the size.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
