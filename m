Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19723CF845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhGTKFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhGTKE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCC5C061766
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kw5qJ9mHZtQZy8JGCShJAX0qxC24RPXU4QQbUpepc+U=; b=TWeYeyBHQScInGYXlBu1aB+IZ8
        HNF+diAmrjQC2LAJaMmwuTtEKPmdfoZ5djiOrKzm/NZ5d40t76EVePwIPJ6tU+nCZceVJQuhdbBIY
        GGaPyoI2skAKDvb2L6Z/+W4ucaRl/R0bqw/ZPqSyjjEM5GA0MbXzCWGqtoUfJRuy/7oOApPLakdFW
        E8F3PzRByt9LtCtZQ3b1NBwsWS2aCOT9WVD/jMu8YWlaWMPgcnu8hzwhaKDlOMN/gvz77nR1yHU+T
        /5Urco/ogdRMm8SWU97xv+m636lrjxKxLODfyGxXwQxDlFmJbUE4WBE6szSzYfpErsZdWVcBkecGS
        juJ2arBw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5nEO-0080n0-SF; Tue, 20 Jul 2021 10:44:34 +0000
Date:   Tue, 20 Jul 2021 11:44:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, cem@redhat.com
Subject: Re: [PATCH 1/1] exfat: Add fiemap support
Message-ID: <YPao+CL6Cm1ZetBs@infradead.org>
References: <20210720093748.180714-1-preichl@redhat.com>
 <20210720093748.180714-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720093748.180714-2-preichl@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please don't add new callers of generic_block_fiemap, as that function
should go away ASAP.  Please use iomap_fiemap instead.
