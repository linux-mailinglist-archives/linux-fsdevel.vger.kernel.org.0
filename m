Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635163FBCC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhH3TKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhH3TKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:10:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD175C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=n5rr/V8aQeSDsSBFbyXDEXStmEOuYsrsdEp7tMArK5k=; b=GMp+WKirJIuwAIJCtNG9By0sYd
        yG6iYwot9DVXgsHTAgKK6qQ2MvfaOe0fd3kmOPbTqji5SXtaB05kT3RyH1K/LmfW7wJC5KPwrqLFT
        ZmPFyV8+IySqR6++YQQgrmB0cRknuaryvhq0j68pN1nIqS34UhgID/2BwDJXOBDqrtmMmQ+CtFxfP
        +hW+zZzgbyAi6helTP2hXFTUB7sCMi2KKdcQi5pQuVT8Qf6r5dsbanejcCese1zuCjxxHXncF/U/S
        fbEbiS2HELKKghZhjw2vbD8Qx5+GRwG8iQWzM2qIWbGbXHAryg2W2keMtFceOfqa8/7w76u9PGeOl
        71P9VgjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKmf4-000SLy-GB; Mon, 30 Aug 2021 19:09:42 +0000
Date:   Mon, 30 Aug 2021 20:09:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jean-Pierre =?iso-8859-1?Q?Andr=E9?= 
        <jean-pierre.andre@wanadoo.fr>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        ntfs-3g-devel <ntfs-3g-devel@lists.sourceforge.net>,
        ntfs-3g-news <ntfs-3g-news@lists.sourceforge.net>
Subject: Re: Stable NTFS-3G + NTFSPROGS 2021.8.22 Released
Message-ID: <YS0s8oEjE6gRN6XT@casper.infradead.org>
References: <d343b1d7-6587-06a5-4b60-e4c59a585498@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d343b1d7-6587-06a5-4b60-e4c59a585498@wanadoo.fr>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:59:17PM +0200, Jean-Pierre André wrote:
> The NTFS-3G project globally aims at providing a stable NTFS driver. The
> project's advanced branch has specifically aimed at developing, maturing,
> and releasing features for user feedback prior to feature integration into
> the project's main branch.

So do I understand correctly ...

 - We have an NTFS filesystem from Anton Altaparmakov in fs/ntfs which was
   merged in 1997 and is read only.
 - We have Paragon's NTFS3 in the process of being merged
 - We have Tuxera's NTFS-3G hosted externally on Github that uses FUSE

Any other implementations of NTFS for Linux that we should know about?
Is there any chance that the various developers involved can agree to
cooperate on a single implementation?
