Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289556E49FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDQNeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjDQNeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:34:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B85B9D;
        Mon, 17 Apr 2023 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGErT9A8CxHcMriaKC3F2mVwSFHGz9/faB9ZBAMyuAg=; b=lPtqsE1FCeRxH1Khu2gNEry45u
        FBqs9t0VqNZv6e9LehYl5d5ruGWoSBQ/9d9AtHVCHuJiB49gcGYsoqJ8DycH6FHKT2F4yGXLCoW3a
        hGyF8yu42PiIiqJ7Ly+LHtAaNmSOcjQyBJ8pOYuKYZuZdZLfUlQu+oVPGbKpUQzsLCdqgkZQHqkbU
        MUjuKzuczozdNFV2qF8bqEmYqo1s3500FaK6UbadB5krUVbox25PzYSBnusWtiuVM1WkrZDkh2JNi
        k5B3Sr/YxYIVbdP0SqLtzEF9o3OpQNep/vPj4RHP5GgSz86b1dATgZfwdCXSx06/VkBjSnnYhPNsg
        rWnt9RmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poOz6-00BNSM-R9; Mon, 17 Apr 2023 13:33:32 +0000
Date:   Mon, 17 Apr 2023 14:33:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        gost.dev@samsung.com
Subject: Re: [PATCH 3/4] fs/buffer: add folio_create_empty_buffers helper
Message-ID: <ZD1KrHDotmqn5UBA@casper.infradead.org>
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78@eucas1p2.samsung.com>
 <20230417123618.22094-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417123618.22094-4-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 02:36:17PM +0200, Pankaj Raghav wrote:
> Folio version of create_empty_buffers(). This is required to convert
> create_page_buffers() to folio_create_buffers() later in the series.
> 
> It removes several calls to compound_head() as it works directly on folio
> compared to create_empty_buffers(). Hence, create_empty_buffers() has
> been modified to call folio_create_empty_buffers().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
