Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E883159AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhBIWsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234495AbhBIW2g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:28:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8B164DCF;
        Tue,  9 Feb 2021 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612909676;
        bh=V7Iq2MJuV2nJQhBbI4sM1ZZI7bcEwWqqw2xuVzyi8PY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XE9MqjdG9wH0kxBZEZ2vm8yy12jHFRwSDiXgJgisg1a3XVKvpL+NwP/Wdnx9wh0yT
         7ZuYTkeRudsKKZQ8xArr/kKHgibDwKgG6qQ8QXO76O8r1gkrgD+W1mzuMhTrMoYgvb
         Gpt9ZIz6jOGBqFTjNKXqhU4fVmSvdWGl4SR/Z6Ps=
Date:   Tue, 9 Feb 2021 14:27:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-Id: <20210209142755.d85949a7fd1d200bc432d763@linux-foundation.org>
In-Reply-To: <20210209220329.GF2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
        <20210209151123.GT1993@suse.cz>
        <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
        <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
        <20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org>
        <20210209215229.GC2975576@iweiny-DESK2.sc.intel.com>
        <20210209135837.055cfd1df4e5829f2da6b062@linux-foundation.org>
        <20210209220329.GF2975576@iweiny-DESK2.sc.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 9 Feb 2021 14:03:29 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Feb 09, 2021 at 01:58:37PM -0800, Andrew Morton wrote:
> > On Tue, 9 Feb 2021 13:52:29 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > > 
> > > > Let's please queue this up separately.
> > > 
> > > Ok can I retain your Ack on the move part of the patch?
> > 
> > I missed that.
> > 
> > >  Note that it does change kmap_atomic() to kmap_local_page() currently.
> > > 
> > > Would you prefer a separate change for that as well?
> > 
> > Really that should be separated out as well, coming after the move, to
> > make it more easily reverted.  With a standalone changlog for this.
> > 
> > All a bit of a pain, but it's best in the long run.
> 
> Consider it done.
> 
> Ira
> 
> BTW does anyone know the reason this thread is not making it to lore?  I don't
> see any of the emails between Andrew and me?
> 
> 	https://lore.kernel.org/lkml/20210205232304.1670522-1-ira.weiny@intel.com/


https://lkml.kernel.org/r/20210209220329.GF2975576@iweiny-DESK2.sc.intel.com
works OK.  It found the message in the linux-fsdevel archive.
