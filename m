Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E934A4976
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiAaOjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiAaOjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:39:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CEAC061714;
        Mon, 31 Jan 2022 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=64GM3aeGmnYGSAoPVpZyjdgL6Jwc3lNO37u/YY0MNaQ=; b=SEyFDIRmSSjAdYm2D7gbhH9NDv
        IPSXWRTkhCri4BeWlk33tjx2Zq2swhI30nMnXhm6u1lZaFbgWZVOQYjjlrZwQR4TZrhfxXDEqIxP8
        JOMcYDWdJW5u3ztcWSCC3QTG/fseCGqNAO0D0K4KHllR37NsDkd85pzG5eQA/7kPtSJ8gOBI78kpR
        DWPuLFGNCIA6vLqV0F5p+mRXzJTM71/q6vT61OA7Ss5ftqOrUEJZnaFXxoKzz7JDKj4P8mTnmqTBf
        Li0H6iwhlPM2arEHMtIVbPmEkzZCdJne7BZ2Xh9VMHqXj2nBLnPQT4TIXs1+OwDMK8/oFzx+8VlQn
        hfBtcKTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEXpt-009ylI-FJ; Mon, 31 Jan 2022 14:39:17 +0000
Date:   Mon, 31 Jan 2022 14:39:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] Convert NFS from readpages to readahead
Message-ID: <Yff0la2VAOewGrhI@casper.infradead.org>
References: <20220122205453.3958181-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122205453.3958181-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 22, 2022 at 08:54:52PM +0000, Matthew Wilcox (Oracle) wrote:
> NFS is one of the last two users of the deprecated ->readpages aop.
> This conversion looks straightforward, but I have only compile-tested
> it.

These patches still apply to -rc2.
