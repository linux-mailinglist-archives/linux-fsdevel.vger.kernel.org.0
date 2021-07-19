Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8A3CCCD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 05:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhGSEA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 00:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhGSEA6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 00:00:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA6561019;
        Mon, 19 Jul 2021 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626667079;
        bh=74mnq9POIjkOzdX7U1+ISYLcUiJ47t2g2jJJCDgV+hU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nRaDse0mC/hTb8q4com9FwM6TYSCveSDnwapkUzlq618xbTMDaqVZGcpmfop7rRLM
         Mxjhfz2c9wjM09Qgw6ScPXtw2Ky6/GJnEpmdPHUYR9UyDc47sGhm/MWQSBeR7fWQi4
         uwUn29HQwAt6SRC/9w4x6z83pbgLCsQB4Ng9epwU=
Date:   Sun, 18 Jul 2021 20:57:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Folio tree for next
Message-Id: <20210718205758.65254408be0b2a17cfad7809@linux-foundation.org>
In-Reply-To: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
References: <YPTu+xHa+0Qz0cOu@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Jul 2021 04:18:19 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> Please include a new tree in linux-next:
> 
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
> aka
> git://git.infradead.org/users/willy/pagecache.git for-next
> 
> There are some minor conflicts with mmotm.  I resolved some of them by
> pulling in three patches from mmotm and rebasing on top of them.
> These conflicts (or near-misses) still remain, and I'm showing my
> resolution:

I'm thinking that it would be better if I were to base all of the -mm
MM patches on linux-next.  Otherwise Stephen is going to have a pretty
miserable two months...

