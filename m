Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C66CC622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjC1PYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjC1PX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:23:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21204A5F7;
        Tue, 28 Mar 2023 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OSlnzCNxt0KdotKHUVgrriB1TzoU+1B8CYF5yyGE4wY=; b=T3UwVlxbjnBe0qWhtVGyVsRai+
        ftMAaz0Kaey7nxYegHsY3Cb8ufJgIxLbwpIY8HzfdZ8ITqwItXQIo8aUziRO+hNeImCwCNXL9kmG9
        FE+JAZd9HPWwfFTcGZ4GAWWxbIi6BOYyQSfFjd2zXnH28i0EDQZibREpMI0RUQtbK30utgObbkDdO
        FjlNQZFB71JrwQW+b1nbus2B+ubac07Bw71ynwQTiRYW8pD1QkVCqpn52wkEMEk8aLdE0WhyQre1X
        eXMc+IRdQi8sP5NE6Ms9L9ObTbtNDbv097G4UbO1uiRlQ/J/C+BtNzjY2isjYDiI8gIUSeOJjvt3m
        zEiq5KZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phB8b-008XGU-KA; Tue, 28 Mar 2023 15:21:29 +0000
Date:   Tue, 28 Mar 2023 16:21:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        viro@zeniv.linux.org.uk, senozhatsky@chromium.org,
        brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        linux-mm@kvack.org, devel@lists.orangefs.org
Subject: Re: [PATCH 2/5] orangefs: use folios in orangefs_readahead
Message-ID: <ZCMF+QjynkdSHbn0@casper.infradead.org>
References: <20230328112716.50120-1-p.raghav@samsung.com>
 <CGME20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497@eucas1p2.samsung.com>
 <20230328112716.50120-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328112716.50120-3-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:27:13PM +0200, Pankaj Raghav wrote:
> Convert orangefs_readahead() from using struct page to struct folio.
> This conversion removes the call to page_endio() which is soon to be
> removed, and simplifies the final page handling.
> 
> The page error flags is not required to be set in the error case as
> orangefs doesn't depend on them.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Shouldn't Mike's tested-by be in here?
