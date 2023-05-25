Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBE711942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 23:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbjEYVkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjEYVkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 17:40:31 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260E99
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 14:40:30 -0700 (PDT)
Date:   Thu, 25 May 2023 17:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685050828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+ot0AHqnS5E+xCikYR4N4Mm0zTlTHiB9/eZ4hj/nKQ=;
        b=bgVbqH2sNiatTcUKoebvVBT8dnaVnnqUY4yWSwOOxRYtmvJXVKJQs5YzdvQrJxXnvjHKqZ
        JzFkhsjqa5E0K9MOrPxLFldzMlN7Vc+5PtduYo5uw9MY5djYXJY8G4aNNRq/f2i3rE2Djt
        TuZqkgL3HmEh2XY/zkreqWy7ImGqNW8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, cluster-devel@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZG/VyvdvM2l1kBnm@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <ZGzrV5j7OUU6rYij@moria.home.lan>
 <ZG2yFFcpE7w/Glge@infradead.org>
 <ZG3GHoNnJJW4xX2H@moria.home.lan>
 <ZG8jJRcwtx3JQf6Q@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG8jJRcwtx3JQf6Q@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 01:58:13AM -0700, Christoph Hellwig wrote:
> On Wed, May 24, 2023 at 04:09:02AM -0400, Kent Overstreet wrote:
> > > Well, it seems like you are talking about something else than the
> > > existing cases in gfs2 and btrfs, that is you want full consistency
> > > between direct I/O and buffered I/O.  That's something nothing in the
> > > kernel has ever provided, so I'd be curious why you think you need it
> > > and want different semantics from everyone else?
> > 
> > Because I like code that is correct.
> 
> Well, start with explaining your definition of correctness, why everyone
> else is "not correct", an how you can help fixing this correctness
> problem in the existing kernel.  Thanks for your cooperation!

BTW, if you wanted a more serious answer, just asking for the commit
message to be expanded would be a better way to ask...
