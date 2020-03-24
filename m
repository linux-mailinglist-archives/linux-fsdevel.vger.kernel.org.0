Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EED190386
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 03:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCXCTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 22:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgCXCTw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:19:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D87B2073E;
        Tue, 24 Mar 2020 02:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585016391;
        bh=vduWTFksrOFfgwb0iKF5e7S99WEgL6/xYx3L1moJ7rI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qRCD/epJxQ5bcFip17CPuH933GL/jn46/df+04SKi60FJLpe/R8lmVTvbV7Gtcw5D
         Qvk3cR5tt2ozpLCNCAAMi2W+FTpMFZUnM+etJHOyyJxzS2kX9ZKWhVS//zN2hX0oor
         eHwxCJI7b+IkUV7RgxqFreyplLXZ4gU7RNFmeqRs=
Date:   Mon, 23 Mar 2020 19:19:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] hibernate: Allow uswsusp to write to swap
Message-Id: <20200323191950.7aae4e0135da7f9419d993bb@linux-foundation.org>
In-Reply-To: <20200323152105.GB29351@magnolia>
References: <20200304170646.GA31552@dumbo>
        <5202091.FuziMeULnI@kreacher>
        <20200322112314.GA22738@dumbo>
        <20200323152105.GB29351@magnolia>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Mar 2020 08:21:05 -0700 "Darrick J. Wong" <darrick.wong@oracle.com> wrote:

> > > Has it been taken care of already, or am I expected to apply it?
> > 
> > I don't know who is supposed to take it, I did not receive any notification.
> 
> Hmmm.  I thought it had been picked up by akpm (see "[alternative-merged]
> vfs-partially-revert-dont-allow-writes-to-swap-files.patch removed from
> -mm tree" from 5 March), but it's not in mmotm now,

oop.  Things which are advertised as "hibernate: ..." tend not to
survive my morning email triage :(

> so I'll put this in my
> vfs tree for 5.7.

Thanks.  But I assume that "it turns out that userspace hibernation
requires the ability to write the hibernation image to a swap device"
means we've regressed userspace hibernation.

So I'd say either "5.6 with a cc:stable" or "5.7-rc1 with a cc:stable"
if we're being more cautious.

