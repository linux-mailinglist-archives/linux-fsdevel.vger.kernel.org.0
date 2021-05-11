Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28862379EA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 06:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKEh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKEh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 00:37:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9780C061574;
        Mon, 10 May 2021 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+LTUHNeE94R2O+bXANYuERUrQYGZz1p62AmaYL7iaa0=; b=PpezK03OB1C8eJRbNdZYTJmHU2
        YxbOUgtOt0V/rQha8ZqXlibpnp+YftcHnNgOLUQLAlOi3VeRiXaY0063okKKZvwXPwyJNguaaK1rZ
        UdSK5B7Kzbl/ITLs7uwYebhy0zBDHIOzE3Fo5BeNq5LwjuMAhZ7b1TT8NzW5xoViWmxIS7QOVoXT5
        jtWz0+pf6tJJaV4mRLIKZt/09eoLkay840VzOzmzr+B/H6LGqW+isqgpLa+yI3BxFnbAFW/UjgOVh
        G/uOcpTscOBvaeezfId6QazbqH51Ap/i1ATpWCMA/xK68Fzs3VZ9MLDAMxSngDC8VnnABhoNRnJSe
        UbtwTE2g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgK7b-006uVb-KJ; Tue, 11 May 2021 04:35:54 +0000
Date:   Tue, 11 May 2021 05:35:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        ebiggers@google.com, drosen@google.com, ebiggers@kernel.org,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YJoJp1FnHxyQc9/2@infradead.org>
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
 <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu>
 <87bl9z937q.fsf@collabora.com>
 <YIlta1Saw7dEBpfs@mit.edu>
 <87mtti6xtf.fsf@collabora.com>
 <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 02:17:00AM +0530, Shreeya Patel wrote:
> Theodore / Christoph, since we haven't come up with any final decision with
> this discussion, how do you think we should proceed on this?

I think loading it as a firmware-like table is much preferable to
a module with all the static call magic papering over that it really is
just one specific table.
