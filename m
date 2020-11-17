Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E559B2B6966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 17:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKQQHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 11:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgKQQHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:07:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE15C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 08:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kaN+J1WZINlrXrlvvndISAlJqNXUgquV6PWAptTHyUs=; b=EF5cej4jNDCOmXbrvirN50hG1m
        8hyfR7FbS0bP6S0s6bFDB6GCUAlkoawNJGG+DBwwilzDFYuTypkKsHgw7kVF7i0C7x+z2w9Ik4mSi
        DyvOx38DuDQz+eMvI6FLBIKqUVkSboaEQp+/0STdi+gC/5cMvbsjLr6vXU45svpoCHgZoBSPca9lp
        v0JsQzrVWgVyTUF/CNBp5VTHlse/Sfr1JZIAZiZ5RDZFieHdCmbh8bbhiBvVaL0YkAbR7bt6G+YmU
        azI1u622zUnGK/nrKY/ihZqYhbBYJ5it9BeTYcrJpdfslYla9nLpraVAxcv7g7tjs7uj5LVW7395M
        cRs2g6Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf3WA-0008Iz-Ki; Tue, 17 Nov 2020 16:07:42 +0000
Date:   Tue, 17 Nov 2020 16:07:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v3 04/18] mm/filemap: Use THPs in
 generic_file_buffered_read
Message-ID: <20201117160742.GM29991@casper.infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
 <20201110033703.23261-5-willy@infradead.org>
 <52328F4C-897D-4A56-9677-2B857661A487@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52328F4C-897D-4A56-9677-2B857661A487@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:00:36AM -0500, Zi Yan wrote:
> Found the above two issues during compilation.

Yeah, I just found them too /o\


