Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4944AAD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbhKIJwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 04:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbhKIJv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:51:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F18C06120D
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 01:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jsS0lGut1qfZ+/AkiWbOQXcgSt41Ny/tSIB2eI2K1t8=; b=nBw2PrRGJsqw8kgZAF5MZgHCli
        Fe2Bi44tsKqANk7x0ae/KYXKlk7E6i6sDOPLNkYCxct0b1iIYR+gYSiBfTi65aN8SGd+p6Z+qizzR
        MRtJo18p9a1tVOzVcfKyAOW/Ix/PlNfqA1alTWpDswNp1Al+jrkrscYN/d46wIJrMzTjY+MD228Yg
        C7x2P/eaU6opQUnxzRV2MVOqpIk30syCKlMvSKfyU8pAmSbmtXZfOhqsD9QEFW+9lAZIfshJCS/ZW
        l3ISvbQ3ZVUg6iuqWvrwXftXq/Rv1Afri9+Bbs4EJBHyhaeCrD8gdoibAYXZfS19OD2QLZT6pYpyk
        5KMAOrqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkNkZ-001JfQ-Do; Tue, 09 Nov 2021 09:49:07 +0000
Date:   Tue, 9 Nov 2021 01:49:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE: anyway to return different stat::st_dev inside one
 filesystem?
Message-ID: <YYpEE+Mi7msHCebP@infradead.org>
References: <a5c2941f-b3df-b811-a8a9-860309b03c32@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c2941f-b3df-b811-a8a9-860309b03c32@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 10:22:16AM +0800, Qu Wenruo wrote:
> For kernel btrfs, it's not a big deal, as we will return different
> st_dev for each subvolume.

It is a big deal, as that behavior does break things and has been the
source of constant troubnle and discussion.  It needs to be fixed in
btrfs eventually and absolutely not spread any further.
