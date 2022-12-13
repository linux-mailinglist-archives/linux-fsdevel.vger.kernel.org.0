Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E264BD5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiLMTeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiLMTd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:33:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A0B868;
        Tue, 13 Dec 2022 11:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCD5614D7;
        Tue, 13 Dec 2022 19:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650E1C433EF;
        Tue, 13 Dec 2022 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670960036;
        bh=xDfy76WPvUiI9NW5O+KVtoaGIA40PH1420HVharcVJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lyaf1iEKludQzosSQ3j8HJEPqdRGtqXE39wA2C6/dXhDF6R1uEdcX8DqS/QaZ6wLx
         La1Wo4sOxDCJOvQX2WdIcU+EN6JVjnkZdbY+SOs9VT5kh00zyq4MAi/LCp3COTvPhP
         Pxx3L9ZceTyFGLkmjslB0vAWAGB8VsqTiyqpwVGQaGKKjGfbKZmYYJP2gBExoNyKJN
         aqzz1i+AQGZDYEQ7t/QDjCPOJ0Z0BM3Fm8KBaBTBT11inlSs5oE29/1bRlOhCDGoA2
         ilS6c7lcmowi7OTTB/Dm1zmNcqC9ULjZAIAWj3muC8HgFJDTYDwr4DbPlCjJYfAS0Y
         BuR5cNxLxUqYg==
Date:   Tue, 13 Dec 2022 11:33:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios()
 wrapper
Message-ID: <Y5jTosRngrhzPoge@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-3-aalbersh@redhat.com>
 <Y5i8igBLu+6OQt8H@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5i8igBLu+6OQt8H@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 05:55:22PM +0000, Matthew Wilcox wrote:
> I'm happy to work with you to add support for large folios to verity.
> It hasn't been high priority for me, but I'm now working on folio support
> for bufferhead filesystems and this would probably fit in.

I'd be very interested to know what else is needed after commit 98dc08bae678
("fsverity: stop using PG_error to track error status") which is upstream now,
and
https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u
("fsverity: support for non-4K pages") which is planned for 6.3.

- Eric
