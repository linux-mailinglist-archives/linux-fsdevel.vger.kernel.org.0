Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7433F4A8571
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350888AbiBCNnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiBCNnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:43:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A4CC061714;
        Thu,  3 Feb 2022 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L9MWc8UYxZnjnohmZnAuC5FiqjE2vmDPkIzVES+QO4s=; b=NvNnFAQXNhVp4BKwlT1g9pXVlX
        i++xG4vlBUFNHxnL4GjhrzQveqhT1mAiSRmm5iK5SvqJF/c0HLndoNz2WHwAGPHCxoi2KKGCe2MpD
        axH1YG3ygbSCv8eVb5ahb+RY6+Bu/jfle+dYzF3DUhoxJs3Lqm1TDr56/Rn4OhQYstWEt/H5G7BX9
        QZVlChvvAWkTxENz9Tu8zXfoZovZZ8DSmpbF5xplo5xbiT71v7zrMrEzVFcuXBiF3YL+PgrLs879Y
        7PLWZUFiI+zdGr8+0Ndi0m2NDmPpqKNRYfAA0yKMK5IGaKxlUuN0GEWwqr1LgNOQL13CE2fonU9fV
        YJVOLC0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFcOA-001Sld-Su; Thu, 03 Feb 2022 13:43:06 +0000
Date:   Thu, 3 Feb 2022 05:43:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Message-ID: <Yfvb6l/8AJJhRXKs@infradead.org>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-3-jane.chu@oracle.com>
 <YfqFuUsvuUUUWKfu@infradead.org>
 <45b4a944-1fb1-73e2-b1f8-213e60e27a72@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b4a944-1fb1-73e2-b1f8-213e60e27a72@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 09:27:42PM +0000, Jane Chu wrote:
> Yeah, I see.  Would you suggest a way to pass the indication from
> dax_iomap_iter to dax_direct_access that the caller intends the
> callee to ignore poison in the range because the caller intends
> to do recovery_write? We tried adding a flag to dax_direct_access, and 
> that wasn't liked if I recall.

To me a flag seems cleaner than this magic, but let's wait for Dan to
chime in.
