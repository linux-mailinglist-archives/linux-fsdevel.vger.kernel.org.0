Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED33F0742
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbhHRO6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:58:51 -0400
Received: from verein.lst.de ([213.95.11.211]:34226 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238483AbhHRO6v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:58:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1787E67373; Wed, 18 Aug 2021 16:58:14 +0200 (CEST)
Date:   Wed, 18 Aug 2021 16:58:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 11/11] unicode: only export internal symbols for the
 selftests
Message-ID: <20210818145813.GA13343@lst.de>
References: <20210818140651.17181-1-hch@lst.de> <20210818140651.17181-12-hch@lst.de> <YR0fuyqe7NS+mCf9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR0fuyqe7NS+mCf9@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 03:56:59PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 18, 2021 at 04:06:51PM +0200, Christoph Hellwig wrote:
> > The exported symbols in utf8-norm.c are not needed for normal
> > file system consumers, so move them to conditional _GPL exports
> > just for the selftest.
> 
> Would it be better to use EXPORT_SYMBOL_NS_GPL()?

Maybe.  Even better would be the EXPORT_SYMBOL_FOR I've been prototyping
for a while but which is still not ready.
