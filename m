Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DEF6C1F03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 19:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCTSGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCTSFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:05:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3E26860;
        Mon, 20 Mar 2023 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZaUtmcLQ1kSP0Cxrkc3O9pult9O0MJARNLjBYCVRb5A=; b=uKBWzetlcBHn3Hhpnd06xxoEBA
        juQiu9tabxPnM7efpV4lg58nC+VBwrlJJPx7UEU3ydpykf93pjv6v5C2WN1BpSyERWO1C6F8yrFX2
        3+j5THNTciX2k0X7pl2A/8VWrUswxMFD2RaFSSwldpMDO/+fYrS52/Isw9t9LOadYZJEVL2c3p+Ql
        PkohrPYGSfL9AIWYeaDGEdDkuBjx+31SyAtWUnhN9mngGeodBOyN1zWIo8LTfJBmkj9d5Zl2WtMhh
        g0kvkknWC7262x6COP3QthcyAsE9P/xHlX68RNIY/ct7iPwhkgEqAZEOe9WKuZ8tCJH2N48bg/VyA
        EwDJNMZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peJmZ-00A4IC-0w;
        Mon, 20 Mar 2023 17:58:55 +0000
Date:   Mon, 20 Mar 2023 10:58:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memory-failure: Move memory failure sysctls to
 its own file
Message-ID: <ZBie370lvwNbKZLH@bombadil.infradead.org>
References: <20230320074010.50875-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320074010.50875-1-wangkefeng.wang@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:40:10PM +0800, Kefeng Wang wrote:
> The sysctl_memory_failure_early_kill and memory_failure_recovery
> are only used in memory-failure.c, move them to its own file.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks, queued up onto sysctl-next.

If you have time, feel free to help move each of the rest of kernel/sysctl.c
vm_table to be split into their own respective files as you did with the last
one.

  Luis
