Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F675FF3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGXSlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGXSlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:41:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C9E56
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RGEv92YhQQpuYKQkWpnK7eBal4DRU2xJEDF+23r9Yn4=; b=bhhIME+G2vzor+xUP6CPNa/538
        zep/kajMS4tosJFtUpcbjgxLX86lHRXT5gUBnEi5n+ngp6wO/SpijJQBnwOCpYfFBAExrFd8nkK4u
        XlkmrUkNllWk2JwLHamhaIYNvYJjkl1YFQLzfHhTtnv4xIOj1Hl+EhGnFw3RrqAL+wO8/CSVqmKeU
        9k3bfjRtQFaNlMzLtbK1AXFralzvThQtqLCx8kjfABrA88tMm9VyUBB6ghW+6AHyK1TFijuMZkeYo
        u5PSpqJacFmld8TkMXc+Tz7DouqaluD4I9K6riBfUjTlmZD0SwtSUV0feJ5c/PADKiDRps63pnTss
        Li2AhmEA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO0UP-005Dqa-1i;
        Mon, 24 Jul 2023 18:41:01 +0000
Date:   Mon, 24 Jul 2023 11:41:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-hotfixes] tmpfs: fix Documentation of noswap and huge
 mount options
Message-ID: <ZL7FvSghPza2vPrg@bombadil.infradead.org>
References: <986cb0bf-9780-354-9bb-4bf57aadbab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986cb0bf-9780-354-9bb-4bf57aadbab@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 23, 2023 at 01:55:00PM -0700, Hugh Dickins wrote:
> The noswap mount option is surely not one of the three options for sizing:
> move its description down.
> 
> The huge= mount option does not accept numeric values: those are just in
> an internal enum.  Delete those numbers, and follow the manpage text more
> closely (but there's not yet any fadvise() or fcntl() which applies here).
> 
> /sys/kernel/mm/transparent_hugepage/shmem_enabled is hard to describe, and
> barely relevant to mounting a tmpfs: just refer to transhuge.rst (while
> still using the words deny and force, to help as informal reminders).
> 
> Fixes: d0f5a85442d1 ("shmem: update documentation")
> Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org> 

Thanks for fixing this and addressing the preference you wanted for
master documentation, I'll follow up again with the style fixes for the
man pages.

  Luis
