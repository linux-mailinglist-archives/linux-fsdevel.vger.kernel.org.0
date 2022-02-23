Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7B4C0E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 09:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiBWIta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 03:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbiBWIta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:49:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33B6E344
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 00:49:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BA3B6160D
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 08:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B69AC340E7;
        Wed, 23 Feb 2022 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645606142;
        bh=770CUvvN9Ai+K0KtRIK6O2zc47V87Om7eP/MWo2EMHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzsqZ51/VDrjnsRSWdvGGbwt7RdNTvOF78MrWCZF1M3qxHaQOBNjdVNYBBczbsoRw
         qQ/TwVL8cqIRsDjf11mMAlsK3Lk8ZJJAlb1u1uoy5qe0w/IKMd9c3uk2eiqNGIK8qT
         Z/fgoVipXA9CmD+kBRTyU6wy2uBwBsPNhw/kz5Hy26znKhfoDhOrVTOH58rSQ25eOM
         VE6DG4GUFqs5sDSpbiopXVXn/IEA76T7+pmsDQRmuo0XVd4LwBoArL7Gpz2ebFhKxN
         v4PpswytKS/8+VubN1kkFpaJymvm2vyqmAkI4aXduk9cWCKPXA7aQoJTW9I0u62vBv
         wockFj0JhrA5A==
Date:   Wed, 23 Feb 2022 09:48:58 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/22] namei: Merge page_symlink() and __page_symlink()
Message-ID: <20220223084858.iypgijkd33ue3g23@wittgenstein>
References: <20220222194820.737755-1-willy@infradead.org>
 <20220222194820.737755-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222194820.737755-7-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:48:04PM +0000, Matthew Wilcox wrote:
> There are no callers of __page_symlink() left, so we can remove that
> entry point.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
