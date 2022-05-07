Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D651E6C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbiEGMJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446313AbiEGMIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 08:08:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97F13E30
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 05:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC51DB80011
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 12:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF2EC385A9;
        Sat,  7 May 2022 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651925102;
        bh=Onuqa8NS9qwt1Ous7hjvKMaH1AI9GVXNSw3Y+BG5DAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+wDD5q79t33YumVK2bAe8SaknNfxt1WDsf5oXlvLtznSw42STk+VKKfMP1wyrvLo
         NVS0EVz4e/DiuZ23bNmtmANvZ+I48WdwB4D+o5OzAQqMaPnkgwbUDYDV4jzbr8/Xwg
         DDfZXa9cbnwgavBtFwxhCx22akVZWUILcC758fAaQ0ibnobIt6c/DE9QIKfbofKILW
         WA6t0m+C/pHhVJRYMAxs45VfVdnl6vY3LhlM2tcA0kvt91HfOt9/3TxaaSUuwpbz1c
         7wWAq6gEGwONCnYZXDLdMBkGtQL7wZXfiLxDefYqHPujhqar3jByo53ichRC+n+dVr
         jnRxd1Lol7MGg==
Date:   Sat, 7 May 2022 14:04:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: Add small intro to idmap examples
Message-ID: <20220507120453.py54ujoizzxgvjbr@wittgenstein>
References: <20220429135748.481301-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429135748.481301-1-rodrigo@sdfg.com.ar>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:57:48PM +0200, Rodrigo Campos wrote:
> When reading the documentation, I didn't understand why this list
> examples of things that fail without using the mount idmap feature.
> It seems pretty pointless and I doubted if I was missing something,
> until I finished the examples, the next section and saw the examples
> revisited.  After that, it all made sense.
> 
> Let's add one small sentence before, so the reader knows where this is
> going and why examples that don't might seem relevant are used.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Good idea. Thank you!
(Will pick up next week. Just back from LSFMM.)
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
