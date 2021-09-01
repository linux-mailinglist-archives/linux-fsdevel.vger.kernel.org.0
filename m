Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778E33FDE45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 17:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbhIAPMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbhIAPMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:12:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D81DC061575;
        Wed,  1 Sep 2021 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=OYQUqvAmts4cX/ntkiXZU2arw8
        p0znEhtw02ofYEPeoo2ZiA4wzLcgbIsgqi3feo77xBHLsrD4dVbBFKt7ZRs3+L4kUiBP/wfeotPE9
        E48tLopvQ7MWIrg8TwbcsDu9HTs60jgd2fV35zfMDRgv2Yq3YdrGT8L26Cc/talkev1lxoqgs9h0O
        JtT0YOeznrO5fQBz4o4Jf/BCmz6k6RUSm7CInn0WvOgOyDl3HaLL9+SiH/5/3DXlw9wBbSYI2pqNc
        GckStlacUmNqO5LLY1WhDcAcEEfZ5HaVwhQXe+MJ+aaQ/h2jC+65V1ht8dNHnGMNWnmpDE3xd+pBQ
        wK1Hx24A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLRrP-002Suh-81; Wed, 01 Sep 2021 15:09:20 +0000
Date:   Wed, 1 Sep 2021 16:09:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] namei: get rid of unused filename_parentat()
Message-ID: <YS+XkxQMb5Yz2F5x@infradead.org>
References: <20210901150040.3875227-1-dkadashev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901150040.3875227-1-dkadashev@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
