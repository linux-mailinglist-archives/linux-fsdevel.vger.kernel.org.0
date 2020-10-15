Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E028EF13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgJOJGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgJOJGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:06:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2DAC061755;
        Thu, 15 Oct 2020 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eAQ03fyofDh/dAkzXvYvtJBzdj+En3zTAxHnDGWSjwc=; b=NMumZN8r+h7wwLDxvcuANP4oPP
        qHfBFzc05V59Oy5GabxGM3+WgA26CwOGTt4TG+mvQ3gMgqnuP6cS5W7DnbTZ6rtgVuLxuIUgNC80u
        LnIiUsoAdXrPOwj9YCy1hHe8T4zBc9WYAVDiEdWTGIBh8hwntQ1+X8CTtAydgI97lyRhRCff81YBA
        JY7iBTWLjhUVjMLn22KqLhBc7XD2em3PZtzIogKWFr3AMnS3N1wzVyj5il3gUeobIQnFRM4vAWRtN
        /fVaPN1YAiVqbZnbH6WnH+xd63HhCnpwxoBoQ8aPSor2vCkcY/rF2XtCEveacrQsCk4w1vExKrWHm
        QIcnEz2g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSzDn-0003kt-N1; Thu, 15 Oct 2020 09:06:51 +0000
Date:   Thu, 15 Oct 2020 10:06:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 01/16] mm: Add AOP_UPDATED_PAGE return value
Message-ID: <20201015090651.GB12879@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't we also need to handle the new return value in a few other places
like cachefiles_read_reissue swap_readpage?  Maybe those don't get
called on the currently converted instances, but just leaving them
without handling AOP_UPDATED_PAGE seems like a time bomb.
