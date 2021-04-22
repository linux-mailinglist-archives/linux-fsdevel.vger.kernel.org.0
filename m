Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372E43687AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 22:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbhDVUI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 16:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237047AbhDVUI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619122072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+hZdBQQle+5F2SpSAhi/uqo7A+r/YVViB1bDRhu/Gc=;
        b=GoPTCebweoAUXd5uoZ9fdB3/1nqBDwnnAw7cAuF0KtituTijHHDDj22qN8dj83ReG+I7u9
        +HP3Pm3yMB8fCBhLV7xPMliljjgrH5Ju8F4fAuqgAZbtgru5yG9zaQRqQWgceyxpTMy21l
        lzxzTlMPtFqmRoJuvddyJRuPeX7MlGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-TEk5jmxrPV2ZVunGxe5gUw-1; Thu, 22 Apr 2021 16:07:48 -0400
X-MC-Unique: TEk5jmxrPV2ZVunGxe5gUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ABAD107ACF3;
        Thu, 22 Apr 2021 20:07:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-206.rdu2.redhat.com [10.10.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70E8563BA7;
        Thu, 22 Apr 2021 20:07:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EEFEB220BCF; Thu, 22 Apr 2021 16:07:42 -0400 (EDT)
Date:   Thu, 22 Apr 2021 16:07:42 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210422200742.GG1627633@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
 <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
 <20210422062458.GA4176641@infradead.org>
 <CAPcyv4h42yPKmWByBVkjgL_0LjBg3ZNYKLBJKgjixsdTzOpaiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h42yPKmWByBVkjgL_0LjBg3ZNYKLBJKgjixsdTzOpaiA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 01:01:15PM -0700, Dan Williams wrote:
> On Wed, Apr 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> > > Can you get in the habit of not replying inline with new patches like
> > > this? Collect the review feedback, take a pause, and resend the full
> > > series so tooling like b4 and patchwork can track when a new posting
> > > supersedes a previous one. As is, this inline style inflicts manual
> > > effort on the maintainer.
> >
> > Honestly I don't mind it at all.  If you shiny new tooling can't handle
> > it maybe you should fix your shiny new tooling instead of changing
> > everyones workflow?
> 
> I think asking a submitter to resend a series is par for the course,
> especially for poor saps like me burdened by corporate email systems.
> Vivek, if this is too onerous a request just give me a heads up and
> I'll manually pull out the patch content from your replies.

I am fine with posting new version. Initially I thought that there
were only 1-2 minor cleanup comments so I posted inline, thinking
it might preferred method instead of posting full patch series again.

But then more comments came along. So posting another version makes
more sense now.

Thanks
Vivek

