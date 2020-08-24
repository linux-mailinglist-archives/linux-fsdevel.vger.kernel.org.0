Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F999250872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHXSr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 14:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXSrz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:47:55 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8884820738;
        Mon, 24 Aug 2020 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598294875;
        bh=LrBvL/lvgaw9oM+bfag92o0XOBwU/bnJJbi2/vNaqgM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g/kN+3NBLlEe62ILTawYQsb0fceIegB6ymJBDZCBntruwEFQRK1siflzwOcb/gOEG
         /nEKc2+l1vOKTSplNt0BHG2F/NZ40meo3/Uwzzs5IA59tYV2Ufft7g9d3jgtSy/opH
         8I8uNUIft0ianKn10BsEc5P2U8TQOOztH6aGJnBk=
Message-ID: <af70d334271913a6b09bfd818bc3d81eef5a19b2.camel@kernel.org>
Subject: Re: [PATCH 5/5] fs/ceph: use pipe_get_pages_alloc() for pipe
From:   Jeff Layton <jlayton@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Aug 2020 14:47:53 -0400
In-Reply-To: <c943337b-1c1e-9c85-4ded-39931986c6a3@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
         <20200822042059.1805541-6-jhubbard@nvidia.com>
         <048e78f2b440820d936eb67358495cc45ba579c3.camel@kernel.org>
         <c943337b-1c1e-9c85-4ded-39931986c6a3@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-24 at 10:54 -0700, John Hubbard wrote:
> On 8/24/20 3:53 AM, Jeff Layton wrote:
> > This looks fine to me. Let me know if you need this merged via the ceph
> > tree. Thanks!
> > 
> > Acked-by: Jeff Layton <jlayton@kernel.org>
> > 
> 
> Yes, please! It will get proper testing that way, and it doesn't have
> any prerequisites, despite being part of this series. So it would be
> great to go in via the ceph tree.
> 
> For the main series here, I'll send a v2 with only patches 1-3, once
> enough feedback has happened.
> 

Ok, I'll plan to pick it up providing no one has issues with exporting that symbol.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

