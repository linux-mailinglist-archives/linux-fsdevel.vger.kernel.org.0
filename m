Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66761587C64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiHBM05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 08:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHBM04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:26:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B83D85;
        Tue,  2 Aug 2022 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i+Zl91q4t+AZoHrEuNohjOyc7HDaxjH2xIeIWp7puuQ=; b=wBqS2CGpTw57Y88TURyJ4aTzj8
        8rA9zlyUQVdeZi0SP6WeltO8x64WM2LPUJbZVVC9vyEvcTQAvLSqpCU4SHM0zaQY9o9OrcdaBHZUh
        chmVGrmleKNL5N3TDrjg+ibrLYbwS53UAzvK3KElODt+f7h/w5gi+6ldrpx7Tm/yeEUiofU0dBDeX
        FbHeAzOiq9gf3BwXU38L2H1pGh5PUVyhGn6vnq+zYqs/YA3Pvf7oi7Z7cPZG0u/xpO9Hz/Tp1HGwz
        oL5k2sD1WrQc2lLN3YLU266NK2sWUfhJXbwwljK9tqmKmI8tRrOhN3HJGG+3q4+Epob0XnjfJ2x5S
        xfW/iZZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIqz1-008LTX-CP; Tue, 02 Aug 2022 12:26:47 +0000
Date:   Tue, 2 Aug 2022 13:26:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        live-patching@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/31] Rust support
Message-ID: <YukYByl76DKqa+iD@casper.infradead.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:49:47AM +0200, Miguel Ojeda wrote:
> Some of the improvements to the abstractions and example drivers are:
> 
>   - Filesystem support (`fs` module), including:
> 
>       + `INode` type (which wraps `struct inode`).
>       + `DEntry` type (which wraps `struct dentry`).
>       + `Filename` type (which wraps `struct filename`).
>       + `Registration` type.
>       + `Type` and `Context` traits.
>       + `SuperBlock` type (which wraps `struct super_block` and takes
>         advantage of typestates for its initialization).
>       + File system parameters support (with a `Value` enum; `Spec*`
>         and `Constant*` types, `define_fs_params!` macro...).
>       + File system flags.
>       + `module_fs!` macro to simplify registering kernel modules that
>         only implement a single file system.
>       + A file system sample.

None of this (afaict) has been discussed on linux-fsdevel.  And I may
have missed somethiing, but I don't see the fs module in this series
of patches.  Could linux-fsdevel be cc'd on the development of Rust
support for filesystems in the future?
