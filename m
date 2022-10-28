Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB436115A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJ1PQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJ1PQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:16:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DF1C25E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mtCOQ8IfyHNs2cs7G6wJOr9WNbsBhcSPT1YWn3us/V0=; b=MCGtB0qRQ8ViEJrz1aYuwGINnz
        N7Yc80x5HukY8Qnxw4GESN8I4TZQ6I2iKNfIXEOcdVMfJDWJ2iXGTiEcWuIuG/Wi5LAQLKRjc07Kc
        00nr1eYZ1fz5EK7+wF9bi6acaFJ2VI9V2oPNp5st01F4XpmhcVFg9HshZ1VQsXddhJV7jEzQ34kcs
        RnSjL11/r7191jL9kxshRNhnW+wVivVzl2RPkr38FuP0sdpPCjNXBFiroJGsl4UaF/U1Gu2jiseF3
        TUY6xg/P7veFOMmFqRRwhvOR5Y/5d7A+5r13/LJp2cHkSsdpWQc9vWHYI1mrayMSIsD/EqRv3VTAq
        gN9yDzmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooR4x-001LAI-Mi; Fri, 28 Oct 2022 15:15:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/1] Mapping an entire folio
Date:   Fri, 28 Oct 2022 16:15:25 +0100
Message-Id: <20221028151526.319681-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I had intended to write and test one user before sending this out,
but Dave Howells says he has a user now that wants this functionality,
so here we go.  It is only compile tested.

Earlier thread on this: https://lore.kernel.org/all/YvvdFrtiW33UOkGr@casper.infradead.org/

Matthew Wilcox (Oracle) (1):
  mm: Add folio_map_local()

 include/linux/highmem.h | 40 ++++++++++++++++++++++++++++++++-
 include/linux/vmalloc.h |  6 +++--
 mm/vmalloc.c            | 50 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 3 deletions(-)

-- 
2.35.1

