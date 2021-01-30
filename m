Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412BF309265
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 07:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhA3GET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 01:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhA3GDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 01:03:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F37C061574;
        Fri, 29 Jan 2021 22:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=bvzM1c2En76vY2+BplfWkvZysd
        +tTc9FkNwLTd2mKbpZhEcCRfBvtIc0ANedjhANK9NNDTuypr7gTeixNBo9D/0QLx+G4yWnbN33xKM
        DA5rIIeKGE4deeZ0QnDZLT4Ql7sAls6ZSD9BZZNVIGMlGZWrz9WoTs+KKVDy9pA+bFHSOhq9KnOem
        SUELjNYrs1uBI/kgl28nLqOPyQWTUcNKcg6uT49Xc0ZDiW1DDWE48K8x9++Fh54aOQr8dvE//+UXl
        93lqn92+ZWff8cac+rMLmN1SA2eL07eW1DjKE/YBJBuxOHHaQ6X6cYNr9Wt349G8Kbw6B93tCEHky
        70KNK4fA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l5jKg-00AlLx-KH; Sat, 30 Jan 2021 06:02:06 +0000
Date:   Sat, 30 Jan 2021 06:02:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/2 v2] nfs: use change attribute for NFS re-exports
Message-ID: <20210130060206.GA2564543@infradead.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
 <20210129192629.GC8033@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129192629.GC8033@fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
