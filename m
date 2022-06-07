Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27DC540202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiFGPDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343804AbiFGPDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:03:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73565EC;
        Tue,  7 Jun 2022 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4jzHTv5Sc0MldAT+k988WZMZ/PcoJBlwM2totgWZy1o=; b=kAmWthY2O8UluBnxjle5Z4b8CR
        wMBrQhwOGev5bLR4SD2g4KFCVqn0rNm7UKcacjYNHOp4Zi9DN4hFNNpg/rdYnkQ2Bitnt2jS/8yep
        J4RQx8E76Apo84LVth+zXy/EGiNNhGntaPmOyPt7MAf32pEy9j0ya4oCKAyveSeAvj+/Bahjw/WS5
        PkxrMT8th9jzoXK8Ozl9TZiDmysXQUNCSiVKvMvkBzEn1CjwgpXgRMlrbmn3RA54WDQPV+9+5Dfdw
        DH8s3QnSLteEcLhDUV0m22q0hL+gDPGr4PGZVl9no1Krcd/RbUTmqDuxBUlxLXzpM46q69eZL4xIc
        YyTs3kwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyajP-00Bj6v-LJ; Tue, 07 Jun 2022 15:02:55 +0000
Date:   Tue, 7 Jun 2022 16:02:55 +0100
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
Subject: Re: [PATCH 14/20] hugetlb: Convert to migrate_folio
Message-ID: <Yp9on0GvbGbdN+cv@casper.infradead.org>
References: <20220606204050.2625949-15-willy@infradead.org>
 <202206071414.41wGG8fp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206071414.41wGG8fp-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:13:26PM +0800, kernel test robot wrote:
>    fs/hugetlbfs/inode.c: In function 'hugetlbfs_migrate_folio':
> >> fs/hugetlbfs/inode.c:990:17: error: implicit declaration of function 'folio_migrate_copy' [-Werror=implicit-function-declaration]
>      990 |                 folio_migrate_copy(dst, src);
>          |                 ^~~~~~~~~~~~~~~~~~
> >> fs/hugetlbfs/inode.c:992:17: error: implicit declaration of function 'folio_migrate_flags'; did you mean 'folio_mapping_flags'? [-Werror=implicit-function-declaration]
>      992 |                 folio_migrate_flags(dst, src);
>          |                 ^~~~~~~~~~~~~~~~~~~
>          |                 folio_mapping_flags
>    cc1: some warnings being treated as errors

Thanks, fixed.
