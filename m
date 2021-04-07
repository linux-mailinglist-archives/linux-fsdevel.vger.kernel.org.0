Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC49357628
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhDGUg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhDGUg1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00ABE6108B;
        Wed,  7 Apr 2021 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827776;
        bh=ugr+drc7bf7S8IBKqVOw+nPN9jCbdOI8SZ6o5VM7fwY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jctupu8ssSv9vuAXQCQ7FIycZ12H5N98RhHey567kgxlZMZTaHivBDFa8n8CUsPFA
         zylBOz7GSkLbEedxd2ePdSvte8QDLug3MTlzrJnV2yfEAzVILjqqo2MPyDRnKt/SCQ
         jya/dcYqvV2xAf7GFwsYNY3YDEHZUGJjJdyVetUwDbCdVTrFwU00wtngiHGw12yIOd
         i/ycYjSQgG7eqE4mx/2Z0z52nN/8w3nsNloKW0QrF31fJN2vYoflWCuL7Y02KGzzpW
         nmrFQMurfQuMK8szVsvSy24473mXID/KGHSThQXjDYS9fQh9MjnOUCZoODlhMvgIkJ
         FwMOl2d6fO0AQ==
Message-ID: <0df4fd45c51dd8e87aa2a0869d81c39c9af83b31.camel@kernel.org>
Subject: Re: [PATCH 0/5] netfs: Fixes for the netfs lib
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:36:14 -0400
In-Reply-To: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
References: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-07 at 16:46 +0100, David Howells wrote:
> Hi Jeff,
> 
> Here's a bunch of fixes plus a tracepoint for the netfs library.  I'm going
> to roll them into other patches, but I'm posting them here for separate
> review.
> 
> David
> ---
> David Howells (5):
>       netfs: Fix a missing rreq put in netfs_write_begin()
>       netfs: Call trace_netfs_read() after ->begin_cache_operation()
>       netfs: Don't record the copy termination error
>       netfs: Fix copy-to-cache amalgamation
>       netfs: Add a tracepoint to log failures that would be otherwise unseen
> 
> 
>  fs/cachefiles/io.c           | 17 ++++++++++
>  fs/netfs/read_helper.c       | 58 +++++++++++++++++++---------------
>  include/linux/netfs.h        |  6 ++++
>  include/trace/events/netfs.h | 60 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 116 insertions(+), 25 deletions(-)
> 
> 

Thanks David,

I rebased onto your branch and gave ceph a spin with fscache and it all
worked fine. Let me know when you get those rolled into your branch and
I'll rebase the ceph/testing branch on top of it.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

