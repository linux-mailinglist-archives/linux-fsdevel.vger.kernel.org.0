Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E946A4A76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 20:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjB0TAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 14:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjB0TAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:00:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6CEFAC;
        Mon, 27 Feb 2023 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zLPGMkcWXfCfOOnp85OlLx+HZPE/5pZ9ewGcmPgZu10=; b=PMBJhDCAkDTNM/2fNd5xGsRdjh
        KTIS/DMOzLcI71r2ttnHhtA3Zk+RP/HFb8HBL1Ys6qjha1HuHAjVApiUEA3EN8q+cxX3dcAoeZ/8Y
        H0K3j7+Aag0o0L6CPARjialy0hTMD/kvELEc9yoADqWYRbqf9eX6SrN5o/Xz5NsahiUealGFkPBMD
        fqLaTwEDHMwGSac1XPjOos82XZ9cSYUsNG1/hMYce1ku93cSqnDrb/EpPJs+vki0NbFP31ZiNzTOh
        L3o+4OgW9owGWnQ4ByNPabmU0u4uIRifRiOH/v+XPUePy2YkRhkJHE04/3caMSzz20PBlmGvaKiM9
        etvt155g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWiix-000KqT-0L; Mon, 27 Feb 2023 18:59:47 +0000
Date:   Mon, 27 Feb 2023 18:59:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Glenn Washburn <development@efficientek.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Correct missing "d_" prefix for dentry_operations
 member d_weak_revalidate
Message-ID: <Y/z9ogV8AvwGNZPr@casper.infradead.org>
References: <20230227184042.2375235-1-development@efficientek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227184042.2375235-1-development@efficientek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:40:42PM -0600, Glenn Washburn wrote:
> The details for struct dentry_operations member d_weak_revalidate is
> missing a "d_" prefix.
> 
> Fixes: af96c1e304f7 (docs: filesystems: vfs: Convert vfs.txt to RST)
> Signed-off-by: Glenn Washburn <development@efficientek.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
