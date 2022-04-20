Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5650805E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 07:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349823AbiDTFFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 01:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349475AbiDTFFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:05:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57CF25EB9;
        Tue, 19 Apr 2022 22:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F1TRa4GgWFl5NwS3j0g57cX1Szs0+a429bfPNvd6Wh4=; b=aow36qpIfTmkQVZ/a9t+WjO2d2
        PhZtl5g7RNxNlhtI5UlFdR66JnzwggDW6PsWbhoLPy5f5IwPfnmF0v4fsuxHK6xtm64njV5vIvPGR
        F1FujOdhxeM6acg+Q/xUltl/5ypMm13ihS8rGHV/ADfGpCeRwAASaNW2JoQPrQWiqNrvoUFqDn5Ux
        vPWBBcg5xsGz88zvtjoiz1OxFK7Tw+mV0nfTPv8EZF7GV6x8MS1ypxQiHFXUMOA0VcrJbYb8aqeWZ
        3LJTtcJfW7ua+Rudi7PZpBSUmF5KpeeQXshTabkJiNFNWGDtDaGB4YALHwYbF7cEuy3Ob7JDPnIQu
        wT/DtFWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh2Ts-007MLW-TQ; Wed, 20 Apr 2022 05:02:20 +0000
Date:   Tue, 19 Apr 2022 22:02:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 1/4] lib/printbuf: New data structure for heap-allocated
 strings
Message-ID: <Yl+T3Mx408HiC6dS@infradead.org>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419203202.2670193-2-kent.overstreet@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:31:59PM -0400, Kent Overstreet wrote:
> This adds printbufs: simple heap-allocated strings meant for building up
> structured messages, for logging/procfs/sysfs and elsewhere. They've
> been heavily used in bcachefs for writing .to_text() functions/methods -
> pretty printers, which has in turn greatly improved the overall quality
> of error messages.

How does this use case differ from that of lib/seq_buf.c?
