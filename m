Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417E6E4A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDQNiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDQNiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:38:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0A9030;
        Mon, 17 Apr 2023 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BguCKMeL6dXXCPqY4hz3jv3kBzWAosWqDFcpQ/LRUrQ=; b=vQNRhePQaNdr7QN+Upu9ryf4q9
        fKkQS8YeH5GDTFbFX7f0pw1B8RK6sEuztjFaDoC8zGgBSUhzazMKkpy0Q8Q5rxTOVZntbE/xG4/8X
        KcLXSYo30gHZoqsalnrl0iBjVlFGYtBYKrscWjGfEgH4Nkboc6W8btSmsayqqgqDJypUt46Rhd4CI
        fqgFhlkQ4HXGxH+eVq5ejkxYq9WjvpDPfu1Reg0vr44lot1itPmQmJV+PkB0mXFLLsUI56oXBgy/W
        BMGVTHUlYuSMxGyqttwewHbhN7f7pBHjoX8VI+S6LzTHg6Zc481YE42GwsL8kJpP1kgBOWJ/UA88E
        kLvZq1RA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poP3D-00BNde-5K; Mon, 17 Apr 2023 13:37:47 +0000
Date:   Mon, 17 Apr 2023 14:37:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        gost.dev@samsung.com
Subject: Re: [PATCH 4/4] fs/buffer: convert create_page_buffers to
 folio_create_buffers
Message-ID: <ZD1LqyAms0y6ZW+2@casper.infradead.org>
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8@eucas1p2.samsung.com>
 <20230417123618.22094-5-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417123618.22094-5-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:36:18PM +0200, Pankaj Raghav wrote:
> fs/buffer do not support large folios as there are many assumptions on
> the folio size to be the host page size. This conversion is one step
> towards removing that assumption. Also this conversion will reduce calls
> to compound_head() if folio_create_buffers() calls
> folio_create_empty_buffers().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
