Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6586428860
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhJKINE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJKINC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:13:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60694C061570;
        Mon, 11 Oct 2021 01:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BP6eUUSbwOPyI0isq5d0FBMejsSUlafct4Eau4uM694=; b=T5vi3b5cptNd4ihDGlBPfewoN7
        h/4t06vMAohvryQxbg832POhVNwqZ/TGil5obb01pmk6XbWTEhiK2BVad03JhiIXWaE7FDKwgVsnl
        DTErtvgpUaX/hTJwlsdojEdygH3HEcwqGePGkySsiaM3SEuTK3n4VR5wqfi8qlIexndYXcjoRUW0P
        3Cr97Wv3wI1etYtnIFjAy+AWxSAbNB0VNC+/cGvZBttY8LgpwVDNDCcv1Seq94brD8VN85Z+Ilvlv
        kfubtjyeHEE3Jpx9K/kzQCvNgGimYp0zayRcWY65W47ghvx40zQ9ymrbw3QqnY6rqrseynrXLciqB
        eXbvxLrA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZqKT-005M08-MP; Mon, 11 Oct 2021 08:07:48 +0000
Date:   Mon, 11 Oct 2021 09:06:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
Subject: Re: [PATCH 0/3] mm, thp: introduce a new sysfs interface to
 facilitate file THP for .text
Message-ID: <YWPwjTEfeFFrJttQ@infradead.org>
References: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can we please just get proper pagecache THP (through folios) merged
instead of piling hacks over hacks here?  The whole readonly THP already
was more than painful enough due to all the hacks involved.
