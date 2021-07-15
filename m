Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F23C98C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhGOG3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOG3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA7C06175F;
        Wed, 14 Jul 2021 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=eKOXVPrmQ2rpPw/V9u/2gXCmeJ
        VO9zT35DaFQdXJEK2i73zRzTCAP35M5oK+x3RJ0x+pz7OCY3CICl78XC6m5FBxsgxh/+nLkEibBvT
        iUIQYgw0o99y2ZQv6M+5Gul8Yy1t54RVTtbMAP8Kz9jmGO/MIbIThCq0XJgKt8qATROJsNrWb2FAK
        Oem0xknGMMWo3IkiLynqbitvYP0nhL6JauAOGkmgoS2DslQixDcp/dzZewNFoq7005dbayIMk/T1C
        f/+rii5U1jyI9aICj19p/nSlcmc3KXJ7gD1RNF1DHh4k+Vg3RllKlCAjn9Q29+OWY6Ss66yqB+NVr
        ODrcG/ag==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3uoj-0033W5-DP; Thu, 15 Jul 2021 06:26:07 +0000
Date:   Thu, 15 Jul 2021 07:25:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] 9p: migrate from sync_inode to
 filemap_fdatawrite_wbc
Message-ID: <YO/U8fiQi5nhWdsE@infradead.org>
References: <cover.1626288241.git.josef@toxicpanda.com>
 <696f89db6b30858af65749cafb72a896552cfc44.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696f89db6b30858af65749cafb72a896552cfc44.1626288241.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
