Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B217F4B5312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 15:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiBNOTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 09:19:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiBNOTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:19:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D854A3FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oh0ZC90dzkWCQb6fWiZ/kAtd8RuZemK2R35rRg8rykc=; b=rN3UNF2JUblJostcOW11pY/Ups
        42o6cWhJVRqhli7rBwmuGO2NAddfmk3G5Gk2mAGMNNC8/+/taduuehAn/CDFbZz6wy7YE5W6l/7hd
        kLNwmyibZhqf/NElt2HMEe/ysYndXGQoeYThWUEJXE/7paL+oRxDluG6FQIXTZ5/bEl3W8SwmFQWT
        swOUg9wn6hxKTIWxz8GMABhAERxJXQAmKSjiH+v+ZI9o6A27tzriuxIpOLUeth0UBMFFaWVz29viQ
        xj02OkMIXGCnGOZxCOE9Iy36JL8s8ZeI9/CUJ9FyqpXO8uNspReFBQqe21hgotOpELaCm4MxLGOTk
        jlb9iUgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJcCZ-00Cyhr-Uz
        for linux-fsdevel@vger.kernel.org; Mon, 14 Feb 2022 14:19:39 +0000
Date:   Mon, 14 Feb 2022 14:19:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/56] Filesystem folio conversions for 5.18
Message-ID: <Ygpk+ys4SOu6uTrN@casper.infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:21:19PM +0000, Matthew Wilcox (Oracle) wrote:
> As I threatened ;-) previously, here are a number of filesystem changes
> that I'm going to try to push into 5.18.
> 
> Trond's going to take the first two through the NFS tree, so I'll drop
> them as soon as they appear in -next.  I should probably send patches 3
> and 6 as bugfixes before 5.18.  Review & testing appreciated.  This is
> all against current Linus tree as of today.  xfstests running now against
> xfs, with a root of ext4, so that's at least partially tested.  I probably
> shan't do detailed testing of any of the filesystems I modified here since
> it's pretty much all mechanical.

I've been asked if I pushed this to git anywhere; I hadn't, but
here it is:

git://git.infradead.org/users/willy/pagecache.git fs-folio
or on the web:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/fs-folio

