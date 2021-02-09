Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7C314AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 09:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBIIyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 03:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBIIvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:51:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D0C061786;
        Tue,  9 Feb 2021 00:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u5y7wcDz5cdfoi3N3ubLyN1ln8h0zXfw3Maca96vMxg=; b=oUU2uouyJDP2Pw7iSgHdSjLJ4y
        89Y1sbCT0OAp1rAbMS2N09i4tWMzGl468F4s0Fcxd522PikM1Bmu4bQ0CWfjM+PkdpCAnXMC7aCBb
        i4o22HsB9LaM7oIOHLZpL3Im/L8DnreVZPEqxDsWhj0EjrlRr2FvtxafKgnHZIiyakFC/PD97BLKp
        SJGPMSPz7psfbyIRD2ohi93vQR8vibZ9zSbFOoakTQxVbCX0I2gwg3YPexAJOws5oRAA4HDdTP9D8
        8W5fQd3araNr/woBJRJEX9FBs8gfMpuaze6g41O5cDR+08qfFB0VFpollJm/U3hoJSE9KfupxiQOe
        gxWgkr1g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Ojd-007BnK-94; Tue, 09 Feb 2021 08:51:01 +0000
Date:   Tue, 9 Feb 2021 08:51:01 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210209085101.GA1710733@infradead.org>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
 <20210128141713.25223-2-s.hauer@pengutronix.de>
 <20210128143552.GA2042235@infradead.org>
 <20210202180241.GE17147@quack2.suse.cz>
 <20210204073414.GA126863@infradead.org>
 <20210204125350.GD20183@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204125350.GD20183@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:53:50PM +0100, Jan Kara wrote:
> Now quota data stored in a normal file is a setup we try to deprecate
> anyway so another option is to just leave quotactl_path() only for those
> setups where quota metadata is managed by the filesystem so we don't need
> to pass quota files to Q_QUOTAON?

I'd be perfectly fine with that.
