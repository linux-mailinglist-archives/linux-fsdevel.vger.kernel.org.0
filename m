Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CC96CB582
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 06:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC1EtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 00:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1EtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:49:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D9F170D;
        Mon, 27 Mar 2023 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4mA4hNb6OnP32i3g1Gzqkt4KFpAv2bmnqekfA1Dpebg=; b=RZfF/gk6N7NwSA5ZMbzMhq518R
        PQWrrzu/y1F/IOryxWDqxgoXJtAZcKEs8RDss30GpaKVy2ehvBWsVFh3cXB1QtoLwAHT//y4t0x/R
        2k37KXaW2AgxQpTJfYglujXf9T+QajagrrxtwhJLPUX8k5XwVuqQqEEZkbCfEr8z9x7mYBnkxlRE9
        PCCh/nMxzZrm6lDiXBC+bqgjRRoAHYNbE/C49rNtzxARzT/RsPAzxX8uABmSzAqjb/GTrd3JF9JOA
        6ZRwDZwyVvWdI3bYIQW59yxYEAcyfhHiwLFbz4KTG9Iu9godnDU8FtEB4seOeX+OdEDv0nEEuBL3s
        3XhbuRkw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1Gi-00D8TU-15;
        Tue, 28 Mar 2023 04:49:12 +0000
Date:   Mon, 27 Mar 2023 21:49:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V7 1/2] mm: compaction: move compaction sysctl to its own
 file
Message-ID: <ZCJxyOX22ZeijBys@bombadil.infradead.org>
References: <202303281002046981494@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303281002046981494@zte.com.cn>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:02:04AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> This moves all compaction sysctls to its own file.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Your commit log did not improve as requested sadly. Please look at
the other kernel/sysctl.c changes and you can find much better
motivations documented before there.

For example a467257ffe4 ("kernel/kexec_core: move kexec_core sysctls
into its own file"). You can also now add the defconfig size results
you had mentioned last.

  Luis
