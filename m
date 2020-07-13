Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C706521D571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGML7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgGML7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:59:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C78C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zc1wyjmwUyNjlkanvz8p/hKZVnLJCywS7UkZaCHJfbE=; b=loRHfCGfv+HLZsoTw7sELq8rgp
        Rd1n+rFlsPiNoVhPbOR4YE0GRResyHIT5xtshRVR5sO5IyPfFajSxGZYLQyFH32CfvCpm4YsI1JVd
        hmnjSjlNZBaiBdFtCyC3hgTu56+qsyZGc2o0XXZQss7ZeLZ1gVhoeLhKA2YDaQSIGk6uYs3GFXHhB
        zCTik8rl//hJ0foVUBmvPCdJOUzMT/Zeyk4kF70Was9ppG2EuQ+zsWdD2gE427Ny+zT5u9321JbuW
        A/sejfp9Z684nHJMcSAyHOTsiiP7Oln46nxFYHssYvRHSbaoEKZwD0g+8CjFCT2oryc1TqSL8W40D
        PisA1Jkw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jux7b-0004pp-5F; Mon, 13 Jul 2020 11:59:47 +0000
Date:   Mon, 13 Jul 2020 12:59:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: define inode flags using bit numbers
Message-ID: <20200713115947.GX12769@casper.infradead.org>
References: <20200713030952.192348-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713030952.192348-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:09:52PM -0700, Eric Biggers wrote:
> Define the VFS inode flags using bit numbers instead of hardcoding
> powers of 2, which has become unwieldy now that we're up to 65536.

If you're going to change these, why not use the BIT() macro?

