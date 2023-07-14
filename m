Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26047534FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 10:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjGNIXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 04:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjGNIWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:22:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1C10EA;
        Fri, 14 Jul 2023 01:22:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 322191FD8E;
        Fri, 14 Jul 2023 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689322968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7U9jUF//TCqil9xrbm8NTLesb5H0SPnbb7S2hPWe0E=;
        b=isuvTE3gNjhP2CPcap0fU2xnpGSeqarFm1Cd1rLGHUkgn+zz/cbRsT+MDhha9SGPhh4k7w
        Up5mOBmC6DWPPNWJ187LXRUFuGPbPu2MNEESqlrMWo3jRaCJX09wAmo3nq0sXGVVKdw+pZ
        2JBkH4mV5yN3GQFo6pPkQP+/sm8LKXw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8E5A2C142;
        Fri, 14 Jul 2023 08:22:47 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:22:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     huzhi001@208suo.com
Cc:     tglx@linutronix.de, senozhatsky@chromium.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Fix four errors in kmsg.c
Message-ID: <ZLEF16qgcTOaLMIk@alley>
References: <tencent_053A1A860EFB7AAD92B2409B9D5AE06AB507@qq.com>
 <2f88487fa9f29eeb5a5bd4b6946a7e4c@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f88487fa9f29eeb5a5bd4b6946a7e4c@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 2023-07-14 14:57:59, huzhi001@208suo.com wrote:
> The following checkpatch errors are removed:
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: "foo * bar" should be "foo *bar"

Please, do not do fix these cosmetic issues reported by checkpatch.pl.
It is not worth the effort. In fact, it is contra productive.
It complicates the git history, backports.

I suggest to find an area in the kernel which might be interesting
for you (any driver or subsystem, ...) and try to fix a real bug
there or implement a real feature.

You might start with reading the related discussions on lkml or
related mailing list, reviewing or testing patches, ...

Best Regards,
Petr
