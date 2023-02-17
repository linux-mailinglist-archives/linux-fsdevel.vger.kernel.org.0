Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ADC69B392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 21:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBQUNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 15:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQUNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:13:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C955A3B0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ockG/VebYDhZIp62yI2wxrE61b7mutpBnLpXiWBMyrA=; b=D2o2tiIBtVEJz5qdLMd5z4DBKd
        +xlroTuz4PlH0lkC8XolPD7Gbfp4d2Nz5YQ6gY05dASziqo8csu/tZ0GPAARzzDsPMy4pw/szzu8b
        ooYXiT8bhT4ccvt3glDEX2Fn0KSWrYnlEheUnzdEMWk5AEBFaHA57pBIZT9zWRlBae4BRGEe6fqc7
        H2psQKS30OanyQKuPhoXkx6FYdZutSoGNZ7AKcTqjzUYbc/geI5ft80+chAYyLYApif72F3CFjHXM
        JfCeUO7l7s0tSz1FXIZeCYT0KpEN4MTOXIs90KPtW1b8vVaZSA02PuhELUYWxNhPd+jKtdXAVUAPh
        EtUa6mTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT770-009bbH-Lh; Fri, 17 Feb 2023 20:13:42 +0000
Date:   Fri, 17 Feb 2023 20:13:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] Scalable Pagefaults
Message-ID: <Y+/f9slIaK195fRX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should continue the conversation from last year on the topic of page
fault scalability.  I presume that by the time of the conference Suren's
current patches for per-VMA locks [1] [2] will be at least in Andrew's
tree, even if not quite upstream yet.  We will then be in a good place
to discuss enhancements:

 - File-backed VMAs
 - UFFD
 - Swap
 - Improve performance for low-thread-count apps
 - Full RCU handling of (some) page faults

Suren Baghdasaryan, Liam Howlett, Michel Lespinasse, Laurent Dufour,
Peter Xu would all be good participants.

[1] https://lore.kernel.org/linux-mm/20230216051750.3125598-1-surenb@google.com/
[2] https://lwn.net/Articles/906852/

