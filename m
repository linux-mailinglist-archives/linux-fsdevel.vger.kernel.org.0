Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127983679DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhDVG0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 02:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhDVG0F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:26:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FFC06174A;
        Wed, 21 Apr 2021 23:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Htu27fcauCIeNAT1CNME/QOxZktPj64iBdmB2H8njcI=; b=lXK4RR4Pe60ylqYwFlXI3ChRDG
        hnSeO4/GoHq6M4ceNs1tOYvp3YWuD+GKnaJvIyIVtO/5o4GWvRXFS07DoScW4oAtcmps8EO6aRU1c
        VmosGKwwBKzJwQEV1mxrRpCca+iZxVVoPyqGbR0X6xfGWGhgUVLI1y52DpeHyC298ABQdVzSwAXBt
        Igmc+kY4Kf+jUbQpwCDifRqjEKCwHlpdFjC4pESppVPyYEoOu8OTUlYK04EbJflYwYRl1QQIy9WFF
        LJfj25QfbZ51TB4ExKQ0Tvkl1/qNEWp6iGCxcZLyyKjnh4nv947zhFCKOfWE9eSO9D7Le8Xe2pPq8
        tNHCH/xw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZSlm-00HWdr-8a; Thu, 22 Apr 2021 06:25:02 +0000
Date:   Thu, 22 Apr 2021 07:24:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210422062458.GA4176641@infradead.org>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
 <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> Can you get in the habit of not replying inline with new patches like
> this? Collect the review feedback, take a pause, and resend the full
> series so tooling like b4 and patchwork can track when a new posting
> supersedes a previous one. As is, this inline style inflicts manual
> effort on the maintainer.

Honestly I don't mind it at all.  If you shiny new tooling can't handle
it maybe you should fix your shiny new tooling instead of changing
everyones workflow?
