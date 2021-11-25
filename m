Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2245E171
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 21:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356919AbhKYUSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 15:18:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33662 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356920AbhKYUQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:16:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C5CB1FD37;
        Thu, 25 Nov 2021 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637871186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUwE/fL8S7u4X1EewISLP2RtdvML4jlwK3VChSTOuRE=;
        b=WrX+FBgRdfgjJ7eUxZ3408Y0gWzmuKAtvafppndjsqfLkXJoDwwXAZxtfRwXxJljKka6E2
        cEaQM/yILshQkazdFeudNPFiyYsSR6geI2wWmZtROKVeWyqO4ujPvULm1gdXD5OYtZ2lgz
        LG3Pc1BzCRogSchMsW4RG1o5jdEEN30=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 66315A3B85;
        Thu, 25 Nov 2021 20:13:06 +0000 (UTC)
Date:   Thu, 25 Nov 2021 21:13:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ/uUR1SGuMbEtzm@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ6cfoQah8Wo1eSZ@pc638.lan>
 <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
 <CA+KHdyUFjqdhkZdTH=4k=ZQdKWs8MauN1NjXXwDH6J=YDuFOPA@mail.gmail.com>
 <YZ/i1Dww6rUTyIdD@dhcp22.suse.cz>
 <YZ/sC/N+fHUREjo0@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/sC/N+fHUREjo0@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-11-21 21:03:23, Uladzislau Rezki wrote:
> On Thu, Nov 25, 2021 at 08:24:04PM +0100, Michal Hocko wrote:
> > On Thu 25-11-21 19:02:09, Uladzislau Rezki wrote:
> > [...]
> > > Therefore i root for simplification and OOM related concerns :) But
> > > maybe there will be other opinions.
> > 
> > I have to say that I disagree with your view. I am not sure we have
> > other precedence where an allocator would throw away the primary
> > allocation just because a metadata allocation failure.
> > 
> Well, i tried to do some code review and raised some concerns and
> proposals.

I do appreciate your review! No question about that.

I was just surprised by your reaction that your review feedback had been
ignored because I do not think this is the case.

We were in a disagreement and that is just fine. It is quite normal to
disagree. The question is whether that disagreement is fundamental and
poses a roadblock for merging. I definitely do not want and mean to push
anything by force. My previous understanding was that your concerns are
mostly about aesthetics rather than blocking further progress.
-- 
Michal Hocko
SUSE Labs
