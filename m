Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37706C451A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 09:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCVIgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVIfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:35:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD205DC89;
        Wed, 22 Mar 2023 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=scGQwlZSm2am6XcIFMQR5FAyHspPLWT/pphajCsVLAM=; b=NZpopG0ww/9PG2arH/g8svd+su
        MkHAA6xnjEz8GvbL4kxv0uBXV0VhiVpROSp+2jUDYy5e+EwUwe9ENwghNvrohKZJ1ENHudSNjOg9I
        C2OuaWzfhP2vZXkpmvZKizy5PzN+oVn2FTnWfjsZFSmJ8Zga/lt5TTQVzbwhL2lkGEkbNnVYdhUc2
        +dxz5m+UDuzxc4Tmclsmt2cWltp7KHWlX9PUs4nw6fHGXJBYsulB8xOUs1RAqsmZYR90pMBI2423/
        8aWjWrMsbbcM6WyQFTRBEFNxMZmzgrF1EaBSz7sM66vEUK+BnYsPh6IDMv/gjFx5LH8V93T9LHbeZ
        flUJ7Dug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1petw1-00FCw8-03;
        Wed, 22 Mar 2023 08:35:05 +0000
Date:   Wed, 22 Mar 2023 01:35:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ye.xingchen@zte.com.cn
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own
 file
Message-ID: <ZBq9uO6wLI1fX1x/@infradead.org>
References: <202303221046286197958@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303221046286197958@zte.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:46:28AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> This moves all compaction sysctls to its own file.

So there's a whole lot of these 'move sysctrls to their own file'
patches, but no actual explanation of why that is desirable.  Please
explain why we'd want to split code that is closely related, and now
requires marking symbols non-static just to create a new tiny source
file.
