Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40971318EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhBKPlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhBKPja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:39:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF4C061788;
        Thu, 11 Feb 2021 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=fB39imcLsV4m8j47uUz7LYp4JK
        y5C9g1Yi7Fs5hlPNKjrdaEIOKbF8Xxfxh3A4nKY296rM6FCkum3SfyejWIJi/cFROoUWVC994wC1Z
        Sa4FYEvfSlWuQKT1qUO7PdqjznuIhCQsdiM0FIzS+j2nPZpTgYCScmHchdBB0oqZYRqUlacGaO7oO
        r6E1d5Ubmccdm/ZcUzyXFURHRZBGaZwBbHuxOPFECZidtox2XFN0J3v6CN5f9im1K+9XGMGd9k2RL
        fdIjEA6qst0ENxdm7z5U7YDHnJSOMJe6niAy9dp5tpGQ7BhHozZnKTqTtcHDHmnV2G6lUEX7DKhIg
        NA7+aRHA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAE3D-00APk7-VY; Thu, 11 Feb 2021 15:38:41 +0000
Date:   Thu, 11 Feb 2021 15:38:39 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/2] quota: wire up quotactl_path
Message-ID: <20210211153839.GB2480649@infradead.org>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
 <20210211153024.32502-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153024.32502-3-s.hauer@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
