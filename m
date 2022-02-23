Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE704C0E74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiBWIsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 03:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiBWIsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:48:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A86D961
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 00:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6A9BB81EA6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 08:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889B0C340E7;
        Wed, 23 Feb 2022 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645606086;
        bh=dZQBzQqoWjybn8E+ugppXc4lg+00k1wwploVtYnDfDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5RcuXbi/Wl6DLe6Q7clMt2epj+XxiG5HtTnchzF7Kh+GUAHvmfKtz/Vqlv/wLMQO
         aPitmT4qN4pG5jWn425c5eI9RvLQarRQxgA+yS51c9QDLxY4LaB6ZH4wKudb+HFgXm
         IHQc021omG5dcJ30ux+6LaHo2YboWC5p2nnUtmM1SzGyBhpQUxBVxUcZyHQHY1W/5m
         fznBnEph6p02QiqGfSJSV46r/fd4W1I5BftxG+A+AmcZMZMEgE32P02q2O8AzsNf4M
         E0eaaYXkIhly8Ekamtzl0cPspro3bZp2yC/0aLgndYGCu9Gs1DJJE1MXdavvcnvAJj
         unXd4oSMC3I4w==
Date:   Wed, 23 Feb 2022 09:47:57 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/22] fs: Move pagecache_write_begin() and
 pagecache_write_end()
Message-ID: <20220223084757.eoykdzdqplvmavij@wittgenstein>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-3-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:00PM +0000, Matthew Wilcox wrote:
> These functions are now simple enough to be static inlines.  They
> should also be in pagemap.h instead of fs.h because they're
> pagecache functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Good to see the header shrink further!
Reviewed-by: Christian Brauner <brauner@kernel.org>
