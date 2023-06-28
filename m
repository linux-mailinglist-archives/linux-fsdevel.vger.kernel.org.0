Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6577418E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF1Tbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjF1TbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:31:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10332130;
        Wed, 28 Jun 2023 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y1lQXgvLhKz2uwA90lAmdOyo6e6ocRMq8Jut7hM8PI0=; b=RfnbdeeyPhIxn35JVJGmLhUK8Z
        A0VdojkwXbMit0g3BIo3JDptKPe1Aj8XRd0Hz0dUqFxS8Sw7fEZE+1qyYr3u/rpt+T532MW4kU4sn
        8LDUzKGniLRLKUh8/8beB32n+yqMTLkvf5uGOFDkP0Y5JR1knbjf3RbpDmpM8riXwrT2VkFvwVfnV
        70fWSDyYnoTFYnyJdOgtQcQ2P8v3shTwyYkFsaqt+oGjpE6Ru853enTCxN9hLA2YQcqi+ypyhPqr2
        +TVJf1dm9fMi1IwDKlXuFCKblFplYqvu/G2V/Lipe0Hd9zPFVK4zIKzDuRAxJA9R7zVB2Vme8Vq0Q
        f2ZheKjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEasb-00491A-H3; Wed, 28 Jun 2023 19:31:05 +0000
Date:   Wed, 28 Jun 2023 20:31:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
Message-ID: <ZJyKef22444mooNE@casper.infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <3130123.1687863182@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3130123.1687863182@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:53:02AM +0100, David Howells wrote:
> Do you have this on a branch somewhere?

I just pushed it out to https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/writeback-iter

Running it through xfstests now.  This includes one of Christoph's
suggestions, a build fix for Linus's tree, and a bugfix I noticed last
night, so it's not quite the same as the emails that were sent out in
this thread.  I doubt it'll be what I send out for v2 either.

I'm looking at afs writeback now.
