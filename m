Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A900D29EF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgJ2PL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgJ2PL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E1C0613CF;
        Thu, 29 Oct 2020 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=TXCT1KHmeuEaCJQN+RT5BrkcIv
        sIHtbrSb3oIvNbBblJm5fa3YVP6YFQZCriCzNKTdWH0CxuTZ3OeDqAeVZZV5Jl9kMkPbe2mWlEN8n
        a7bvPCw2IoAPF1KAyhxNl061s1G8B79cs2rjp13wPfaE2mDgef6AleAavbeGDNPrjP+dRujSoKf21
        DrI0h+7YTwseBXK5fscWsdyizb8YKcdfIJQJbSp6uT9UlSZ9gXIRdzfMXE0uQYLntoDz0j5D0HmA2
        b6Euow9IjqnkMmdpIrfX7y7MLPHYU+cDvcCHz7pcPnP4Vk3V3fCJSzacVL3p0wTqIKzfEedCBnHm2
        4kNl5iDQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY9aG-00067f-1b; Thu, 29 Oct 2020 15:11:24 +0000
Date:   Thu, 29 Oct 2020 15:11:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iomap: clean up writeback state logic on
 writepage error
Message-ID: <20201029151123.GC21018@infradead.org>
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-4-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029132325.1663790-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
