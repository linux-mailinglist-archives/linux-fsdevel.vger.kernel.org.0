Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637A2A47F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKCOW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgKCOVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:21:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C85C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kfUUrj+aJVGlR7esLpu7JEW4MN/Y1d7zXtMy7Xu9oXQ=; b=eDbIAtozNsTIPYxO/5KRMusmWK
        G3a9Do+AVFxN7KnJaiMMg/waLoBfx5mDfOlhqlm72v8MsIhhgapFED0nHdS0hB7hF+CtwA+XouOFQ
        v6TGOdLJHhzjTvYt2Gj2Gz908C9XvkLEGx+SSC162BJAQp/+kAQvsbtrJc5/0HoSrXAUwY/PyYNp/
        etyddE0f2PYuAnXV2YqK5+f13o3y/RGM3i5PqKRDIhOVUEoTNHg4Vrf+4kgzVZcIGWybljAhxif4O
        H4WmvqR+BqG2R2q6b8T/4rFMXcEHveFUxlhntObFf2jf8UvG7Mh2rhTxnm9gvN5zLTHetjJDwqhzO
        i7x1icBg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxBv-0001mx-Rz; Tue, 03 Nov 2020 14:21:43 +0000
Date:   Tue, 3 Nov 2020 14:21:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fuse: fix panic in __readahead_batch()
Message-ID: <20201103142143.GT27442@casper.infradead.org>
References: <20201103124349.16722-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103124349.16722-1-vvghjk1234@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:43:49PM +0900, Wonhyuk Yang wrote:
> According to xarray.h, xas_for_each's entry can be RETRY_ENTRY.
> RETRY_ENTRY is defined as 0x402 and accessing that address
> results in panic.

Oh, I sent a patch to fix this to David Sterba back in July.
I guess he didn't merge it.  I'll resend to Andrew.
