Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA75B6C76F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCXFVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjCXFVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:21:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D201A48D;
        Thu, 23 Mar 2023 22:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YTAhaq5ytV358L4VcK1oscf2Tc7ZdoiPYpWpL7/l6MM=; b=UvOe+puKuKDuEPQvHkI0sYJL8t
        p/iMPytS1f582JKtyEEyxIFVhsggfoHbMjc1pEJWVirwe269swiljNyeSe9dyGE7DzYfTxYLFeV3I
        YsRP3Df0v4aeksbFBsSidZQ45QxwsCpNimh9b6GADzvViHQeH+FeTbF0EaRNcff5GtRZWgU2UHHXc
        cCizAN9Xr5jrd1IFNksG/2/ox5OU8OgUpe5KGVF9l4ha1h2+4LkprvjuTyVvLTNjd78SvpN+va4IM
        0roeigi3/XzGjnwb0FiXvFEcjxGL4zHUkrP/tZEs6X8rPv/v7SttN8Phelv+5mGXIQQz5oiKF0Lz1
        jjix0tSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfZr8-004baj-5t; Fri, 24 Mar 2023 05:20:50 +0000
Date:   Fri, 24 Mar 2023 05:20:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC v3 1/3] file: Introduce iterate_fd_locked
Message-ID: <ZB0zMolmWJ5nEDmh@casper.infradead.org>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324051526.963702-1-aloktiagi@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:15:24AM +0000, aloktiagi wrote:
> Callers holding the files->file_lock lock can call iterate_fd_locked instead of
> iterate_fd

You no longer call iterate_fd_locked() in patch 3/3, so this patch can
be dropped?
