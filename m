Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B514F561
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 01:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBAAZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 19:25:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgBAAZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fpw6+UEhfuhuXeKhNiLAOcNkyHMzaziNThRDurB0olw=; b=QxOHj2pZg+W0B5HIBaNQ2a1dF
        X0NQclBE2kGZleLQjTuffWwMMANrl04KeOOHt8+bcQ6CQD6k2oHx72uYHBStQflRNHip10UsC+bUF
        Fg7POZ4hQfjJ8LdBtpUUHaKx+Rje32bllb90LUXDP3WyQ/fVujZZviLRgFeAT7YsCrvLqGXY/BB/w
        XtqUGknjOioO7AGDFc7lDe+R24v4E+kG9joislUUkwVb8+Hoia9E/hsFJJBvG1VKjELdCeSa0PDu1
        rNSDke9vxTqSCLFjMRvKxnwwh4Y0P6CGwh+9iPiDkrlTR0ogML9akzWOAnGVQjmF854vphMnQomW5
        k9hsWWB1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixgbW-0005u5-47; Sat, 01 Feb 2020 00:25:42 +0000
Date:   Fri, 31 Jan 2020 16:25:42 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 04/12] mm: Add readahead address space operation
Message-ID: <20200201002542.GA20648@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
 <4e28eb80-d602-47e6-51ec-63bb39e1a296@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e28eb80-d602-47e6-51ec-63bb39e1a296@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 07:57:40PM -0800, Randy Dunlap wrote:
> > +``readahead``
> > +	called by the VM to read pages associated with the address_space
> > +	object.  The pages are consecutive in the page cache and are
> > +        locked.  The implementation should decrement the page refcount after
> > +        attempting I/O on each page.  Usually the page will be unlocked by
> > +        the I/O completion handler.  If the function does not attempt I/O on
> > +        some pages, return the number of pages which were not read so the
> > +        common code can unlock the pages for you.
> > +
> 
> Please use consistent indentation (tabs).

This turned out to be not my fault.  The vim rst ... mode?  plugin?
Whatever it is, it's converting tabs to spaces!  To fix it, I had to
rename the file to .txt, make the edits, then rename it back.  This is
very poor behaviour.
