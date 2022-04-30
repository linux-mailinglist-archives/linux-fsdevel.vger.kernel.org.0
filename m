Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C99516014
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiD3T0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiD3T0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46771116F;
        Sat, 30 Apr 2022 12:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7450161073;
        Sat, 30 Apr 2022 19:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDD5C385AA;
        Sat, 30 Apr 2022 19:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651346557;
        bh=vYL+tI0U3M8WicVyPKlptZoD7ETGG/8uFx2R18Jlacc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QgFJFZRE2P5i701jNDYP/DU2xUa/xUiaiNkqIia4wooGJqiG2vx0i7uHI5zquJ8Do
         Dzzccq+DdPGxkhcBvomhWKb9nc2I4NN7pOnltgzbFrIsqF8kJSD4NBV7oJhV5cpkwm
         TnL/i/Ot4mivvfc/Vjmb8ynQJ1hFVONYIUuQFF2A=
Date:   Sat, 30 Apr 2022 12:22:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [GIT PULL] Rare page cache data corruption fix
Message-Id: <20220430122236.bd8301bcfe11c1f7e40c0517@linux-foundation.org>
In-Reply-To: <YmMF32RlCn2asAhc@casper.infradead.org>
References: <YmMF32RlCn2asAhc@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Apr 2022 20:45:35 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> XArray: Two fixes for 5.18
> 
>  - Fix the test suite build for kmem_cache_alloc_lru()
> 
>  - Fix a rare race between split and load

This commit did not have a cc:stable.  It has a Fixes:, but we've asked
Greg not to backport patches which weren't explicitly cc:stable.

If you think this should be backported I suggest you let Greg know.
