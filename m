Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3443F4593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhHWHF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 03:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhHWHF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:05:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBBC061575;
        Mon, 23 Aug 2021 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=rH7TUlJiCube3aHCyMv6G8vYp9
        Kmt7mLR2//9FY8fyNqUqF3d4elZZIID71HbIUAZZjLingFEfhWVK7u0nGDOKUzxJCOhs4vybBnpbV
        376rqfQ7hKr1QmKUWbNKqBow6rFFuUW0OASExBcd+k7C5otqKLgv0eOC6XM5e6B2VIfb4Lyb9O0Mg
        I+3G1R3pT9CuLhgYd5SKdHERxo8hiRCzAkgi1Nl9NM7PwvqEGcM34371rmVW9tzCdCXADr7PkPZZb
        FiKstDrG8ikQHbM0mezum/qQ89o23XVeQRXSz7Lsw/121qI1w9RjEAk9tugyaJAeT9GRGYvi11sy4
        Spg3AVcQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI3ze-009P3v-Vc; Mon, 23 Aug 2021 07:03:47 +0000
Date:   Mon, 23 Aug 2021 08:03:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: standardize tracepoint formatting and storage
Message-ID: <YSNISnsgGPBUpt+4@infradead.org>
References: <20210822023223.GY12640@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822023223.GY12640@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
