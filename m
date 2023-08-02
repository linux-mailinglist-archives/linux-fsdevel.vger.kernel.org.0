Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946FB76D227
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjHBPgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjHBPgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:36:21 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4A30D8
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:35:41 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 184BB1C41B9
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 16:35:22 +0100 (IST)
Received: (qmail 28242 invoked from network); 2 Aug 2023 15:35:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Aug 2023 15:35:21 -0000
Date:   Wed, 2 Aug 2023 16:35:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/8] pgtable: improve pte_protnone() comment
Message-ID: <20230802153519.ryds4omveq5zbtex@techsingularity.net>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-6-david@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:41PM +0200, David Hildenbrand wrote:
> Especially the "For PROT_NONE VMAs, the PTEs are not marked
> _PAGE_PROTNONE" is wrong: doing an mprotect(PROT_NONE) will end up
> marking all PTEs on x86 as _PAGE_PROTNONE, making pte_protnone()
> indicate "yes".
> 
> So let's improve the comment, so it's easier to grasp which semantics
> pte_protnone() actually has.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
