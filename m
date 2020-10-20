Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2023629364B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgJTH6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgJTH6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:58:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57071C061755;
        Tue, 20 Oct 2020 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8cjwyMNC5wKWzE2wjj/VJutVXiTsFmR9iUtdzOodivQ=; b=k1FvfVs9fYjGP2z5GITVz8r8pE
        1djSWaYoskUYFXCOhHKHJFRZgpaAxOz4CL/+n/fFcq8mR4LzjgFDkAYik19KOYCGdAGEQJ/8trtFh
        foEn3s1maAzTGANNvC/nwqcoz41Bba2mIiF6Tt+Utn1qprxxZeQwVK5HDNhapJNwL0+sO7faJjHc5
        T1wFoMEIWWWmmtp01fkRlklXwNDTjppkwF1Fs6Js2zDCr7oTO6v4B066zhvbzZgssnLNIEgMvfS6L
        mIuNyuLD/+YXLgRTWU4teb4NUoUPZWquCYAPWeNRJj/o+o5ppIIT6iZfgpOoJkZgVHRFskrrBZNHJ
        IQJLS8gQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUmX7-0005GI-Re; Tue, 20 Oct 2020 07:58:13 +0000
Date:   Tue, 20 Oct 2020 08:58:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH 1/2] cifs: convert to add_to_page_cache()
Message-ID: <20201020075813.GA18793@infradead.org>
References: <20201019185911.2909471-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019185911.2909471-1-kent.overstreet@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	rc = add_to_page_cache(page, mapping,
> +			       page->index, gfp);

This trivially fits onto a single line.
