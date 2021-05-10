Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BDC3796AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhEJR6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhEJR6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 13:58:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D647C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=c0ZwbnhFVoCk929FgGDRj8ko+T8cDeec7sHo4RIz+uI=; b=Z9S2TNxx6b4XeU8jWBLCTVSg0s
        xcit5G3G2rPeFaCHjZMXsvzrFqXr4MJDt0rlvv91O25DMV61QIkLvU6A1BEHng3KgQ+qX3kEaUjXg
        8foC7eQSKqZVun9af7RTMniGCLDZ5MfrhP98WO5uPplCaxLYSDO8tdhaAPH3Zl21GnhCMSDv2JMNf
        GHJFzT16aQO0IAeHlldxXFOg7nnBm2RWjPLIDcLr34BUSqDUlEZUNRb8RWS1ebGcp+hWcz8e4lxev
        sQf+iUlNlxPKEvV3BZrNykKhZ2eEwvVp3wIcAjLAETNHaBO1V+LvOGyY9QekAh8Ad8AJRu8UpsSAE
        5vr7q3/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgA8f-006RTy-Qq; Mon, 10 May 2021 17:56:30 +0000
Date:   Mon, 10 May 2021 18:56:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Memory folios
Message-ID: <YJlzwcADaxO/JHRE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't know exactly how much will be left to discuss about supporting
larger memory allocation units in the page cache by December.  In my
ideal world, all the patches I've submitted so far are accepted, I
persuade every filesystem maintainer to convert their own filesystem
and struct page is nothing but a bad memory by December.  In reality,
I'm just not that persuasive.

So, probably some kind of discussion will be worthwhile about
converting the remaining filesystems to use folios, when it's worth
having filesystems opt-in to multi-page folios, what we can do about
buffer-head based filesystems, and so on.

Hopefully we aren't still discussing whether folios are a good idea
or not by then.

