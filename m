Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF22FEC87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbhAUOAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 09:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbhAUNfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:35:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F4C061757;
        Thu, 21 Jan 2021 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Sw5nwOYuq5g6NnJ5/b/NhvW5bYwFEItPBVnvcj4cLI=; b=siJvlqlKMvVSufyZVowaIdIYC4
        dfpsJF8I9eb1/6jWJrmtKwXVWianXKsl4RB4xjHvoeYXkMrM6M1ESdTIg7PtJaY9SVVwB50gROBqU
        CVUW683EkzTxRpUaLVIhbEnPBPU5g7R2bJ6Ve6wIKlL6l/Ih8xppYEG9WP3o+mnzJLqgFJG76+jpN
        GjCvmeN7fzYFcxiJ4SG+kGQ3ImJWOkYYB0mHZzGFGpsB0cS5tga2QadnBRNKSo+OnPg7iDiCA2cf2
        sZRAAifRoNOUEfmjnGcZYCjp4xOz8JHpZSCx/fVLicrQTnafOuvgIi1yObGwbk9AtJff70DKO9Wrl
        CmhrItNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2a6A-00H6A7-4n; Thu, 21 Jan 2021 13:34:08 +0000
Date:   Thu, 21 Jan 2021 13:34:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] iov_iter: Add ITER_XARRAY
Message-ID: <20210121133406.GP2260413@casper.infradead.org>
References: <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
 <161118129703.1232039.17141248432017826976.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161118129703.1232039.17141248432017826976.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:21:37PM +0000, David Howells wrote:
> -#define iterate_all_kinds(i, n, v, I, B, K) {			\
> +#define iterate_all_kinds(i, n, v, I, B, K, X) {		\

Do you need to add the X parameter?  It seems to always be the same as B.

