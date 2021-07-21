Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09C3D1160
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhGUNwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhGUNwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:52:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFFC061575;
        Wed, 21 Jul 2021 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WbAy6DqFkDK/H1Tdt40cNZWRwcSg1s+aS3yHsxK8yvo=; b=oDO1Y7Ya8lGL9a/LT4NBBFY+RY
        SGEQzZ/bQoVHouF+q/n2uiDwq0kYHeS+VX3y4aYfTJR9JxGfLCB6mszyLx7EdekRg7fbJ7NIgN7RK
        ykLLh8lvJkAXJqXOT4VO6HDVpRb/1K5I0+ClWcBrfXyPduomBe+KXE8QcQnhAE821rI+sifsjh00i
        b5U6ORy7MUf1EdBkWe1FCfofGt7i/cqoM9AOAE3SbLHsgDnQUnYsvq+Slf+rW09K0aQBqNoR8xIY2
        AFm62AFyiH+a0TV80BGaHHqZZrqxMa1qx3Xb0g2Wwly4TpwUKFL9upHkhYpSVJSUNBNyiaUHg5dZ5
        4oOouCfw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6DGz-009HqA-5R; Wed, 21 Jul 2021 14:32:37 +0000
Date:   Wed, 21 Jul 2021 15:32:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Message-ID: <YPgwATAQBfU2eeOk@infradead.org>
References: <20210721135926.602840-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721135926.602840-1-nborisov@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This seems to have lost the copyright notices from glibc.
