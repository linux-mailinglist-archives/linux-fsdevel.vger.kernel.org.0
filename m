Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB715401E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiFGO5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343669AbiFGO51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:57:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D521C;
        Tue,  7 Jun 2022 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AfL2iuaKMIW3GEEXa7GrCIERYid9+IWuPeOvvtY3ld4=; b=fRSk5WhSy4yx86ABGN8DAKmWjC
        5IdJfhP/2tfrBb3qOP67dWCLnwarcUWbjvi3CSZox73Cc2Y1PIwGlfqeGnF3Uxyt0mbA5Mg3BbAic
        u8C1w1Bg+HnPIgHl9bpnhpAGnvXoNlM/riGdn7iNiA4dEw1cH8c3GLB6l+j+CAh8jR4QCRLgjeJYJ
        KjvzVwo8asMupiPKaBH9YNKuxq1ZqBG33mo7YsQtWCkEXiw/2CPMhM29QfN4S2WqjmyhTpN+ujECh
        HLTSFWPPBpUYWjBGjh365kLciirfPTZ2IaAsMeDnES6CMIrk6IVPXnxuuFSWcG0n8eXm6dw3XUxLO
        bUTOI4Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyadh-00Bioa-Tk; Tue, 07 Jun 2022 14:57:01 +0000
Date:   Tue, 7 Jun 2022 15:57:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 04/20] mm/migrate: Convert buffer_migrate_page() to
 buffer_migrate_folio()
Message-ID: <Yp9nPSwPEWoX7Ml+@casper.infradead.org>
References: <20220606204050.2625949-5-willy@infradead.org>
 <202206071139.aWSx4GHH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206071139.aWSx4GHH-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:37:45AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> mm/migrate.c:775: warning: expecting prototype for buffer_migrate_folio_noref(). Prototype was for buffer_migrate_folio_norefs() instead

No good deed (turning documentation into kerneldoc) goes unpunished ...
thanks, fixed.
