Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7F3009AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbhAVRYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbhAVRTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:19:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34FC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fixooYTMZDDPhjwrPhetGmMcASfSzGrU62XEmkBdlKU=; b=fG910HWrmClFzdbwaNl1ijhw0l
        QB9nfn13Yy4nncxWe+BhVV80d+rr2PVBcTJ5sEZgE3Eon4fx7vofuoGHga+V4l9xn5FKP8SPUqfL/
        sNMWiWgQLoumLNLJVaRi3U9x/GRzljs246AaHklLRpvE1pmWI7bV8Ndz91ytD+jgATA1gsgGj395j
        0AKlrU7Mjd5Dt+bJ808m0cFIe3Pz1tzG+jxTSAXGcdoXguEXqeyszjP1bqzgBP+4AWwiuVDfcq/u3
        e0hCUldI8d85APolx5y6WWma8t1dIwTV14syHAjxwJIRfVCDLUV09N5YYvCONIExglIKGvfFN+TYs
        hTUu8UFw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3052-0010Nj-5a; Fri, 22 Jan 2021 17:18:42 +0000
Date:   Fri, 22 Jan 2021 17:18:40 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 3/8] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
Message-ID: <20210122171840.GB237653@infradead.org>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-4-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122151536.7982-4-s.hauer@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 04:15:31PM +0100, Sascha Hauer wrote:
> +	if (xflags & FS_XFLAG_APPEND)
> +		iflags |= UBIFS_APPEND_FL;
> +
> +        return iflags;

This uses spaces for indentation

> +	if (flags & UBIFS_SYNC_FL)
> +		xflags |= FS_XFLAG_SYNC;
> +	if (flags & UBIFS_IMMUTABLE_FL)
> +		xflags |= FS_XFLAG_IMMUTABLE;
> +	if (flags & UBIFS_APPEND_FL)
> +		xflags |= FS_XFLAG_APPEND;
> +
> +        return xflags;

Same here.
