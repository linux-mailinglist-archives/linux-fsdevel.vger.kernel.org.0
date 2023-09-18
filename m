Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFF7A5205
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjIRSZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRSZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:25:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECA5F7;
        Mon, 18 Sep 2023 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVG7Tz4mbiL7zFD9pXkZDz/RHS04WKOIQw8iJglOgVs=; b=BRoxodG+HQtU46yX99ln++ZjUI
        jDo2UFL72u1TGVgslvDMwhexkR9M4DBavYb8bCC3D8/fVCvGz/BdbTdj7miPIWikmQTRRBAag3r9H
        36LJxM8kvf9dk4YJ1q4vUlaQuz9OUn5BMa5gBVvXxMdt4Dg2dztGqSW8oBwRapHs5ES20kWpghRzK
        +U9LwiBlR8qYH36T3tQlmYQyThvUwdWs7LPjKVyou0rivoVU4dhe2lgTxGbUlKzzcCRV0+GiSNXvW
        vj7aG/B5Ti41ZqjIHbQlFJfW+HKQVLKEHT57VPok+JZhZAwdcHHA9+4Y3JLWLd8eX5Vwo4HDW9E6r
        iYU4wkHg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiIwH-00G4zG-2i;
        Mon, 18 Sep 2023 18:25:41 +0000
Date:   Mon, 18 Sep 2023 11:25:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com
Subject: Re: [RFC 05/23] filemap: align index to mapping_min_order in
 filemap_range_has_page()
Message-ID: <ZQiWJdjFPvVbCj1B@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-6-kernel@pankajraghav.com>
 <ZQS0UGQMbUCYr2t3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQS0UGQMbUCYr2t3@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:45:20PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:30PM +0200, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > page cache is mapping min_folio_order aligned. Use mapping min_folio_order
> > to align the start_byte and end_byte in filemap_range_has_page().
> 
> What goes wrong if you don't?  Seems to me like it should work.

Will drop from the series after confirming, thanks.

  Luis
