Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0067FCE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 06:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjA2Fjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 00:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Fjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:39:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8514D20D31
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 21:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6WJ9Pu74OAlot46PM38EuI7lj/TpOZqZHOu/KspnF9w=; b=W1O8m0315I48Dl+JTrJxTYwjPh
        kDwE18XwtobCnIu46KB5V8K+XdIF9blU9FLEx6Z/CUtRwuvwlK7EIjRJOp/U2RokLjuYsDUc+EK9A
        nfimd2rr1ixP67VA1b6iq0AQem8FkZBWCRemkJh/xJKc5BSQEWXqoWpFUu3xM3FAQdv0KEL/S88ZL
        MqGB6Ba/5/+nFYxL5X8qaGePByoHkb1zPLPLllmY27zF3BFkRZt+NhckJO0mENtUeaBXAwmmHSiRp
        tSqPaA6bDQr5EZPGHn6FIgh7BLY5gxMbfxZ/5TRBNricgjFxZVq5zuAiYmKsc5o4/73d2F7bwg1ka
        +bLW1/Ng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pM0PY-0014oo-UZ; Sun, 29 Jan 2023 05:39:28 +0000
Date:   Sat, 28 Jan 2023 21:39:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y9YGkEFH5GNihJk/@bombadil.infradead.org>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9X+5wu8AjjPYxTC@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 29, 2023 at 05:06:47AM +0000, Matthew Wilcox wrote:
> There's maybe a
> separate discussion to be had for "What should the API be for filesystems
> to access metadata on the block device" because I don't believe the
> page-cache based APIs are easy for fs authors to use.

OK sure, and *why* that would be good, yes sure. Perhaps that should be
dicussed first though as then it I think may be easier to possibly
celebrate IOMAP.

> Maybe some related topics are
> "What testing should we require for some of these ancient filesystems?"

Oh yes....

> "Whose job is it to convert these 35 filesystems anyway, can we just
> delete some of them?"

> "Is there a lower-performance but easier-to-implement API than iomap
> for old filesystems that only exist for compatibiity reasons?"

Yes...

  Luis
