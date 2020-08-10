Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47BB24066D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 15:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHJNI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 09:08:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42755 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgHJNIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597064904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbpPyMxeUTZufAlT4TB0KbZ9dM5w1NZ9B6YwnpXi1/s=;
        b=hJM2otlYUoPY7VxeCg+9S/SuDdXK/EMb63r95YBavEpwFYYx2bHe7xw5vabFMzkA9bv3aG
        GO+rnV5h9LFmhpGEzzGShn29p21HXvBnVGFrRX+y6S4jLgkre3rLGiwT2g0SAsWo7octz4
        xzEhTG6JX1B3/EzsojREJRmGfBPmSv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-bwrUS9gAOm6o0zWQN2BguA-1; Mon, 10 Aug 2020 09:08:21 -0400
X-MC-Unique: bwrUS9gAOm6o0zWQN2BguA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B63918A0F03;
        Mon, 10 Aug 2020 13:08:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.10.115.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5EAE10013C2;
        Mon, 10 Aug 2020 13:08:10 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3286022036A; Mon, 10 Aug 2020 09:08:09 -0400 (EDT)
Date:   Mon, 10 Aug 2020 09:08:09 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 00/20] virtiofs: Add DAX support
Message-ID: <20200810130809.GA455528@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <CAJfpegtboe-XssmqrcvsJm1R0FBP8fYFrTMv5cuBhfmebiGfQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtboe-XssmqrcvsJm1R0FBP8fYFrTMv5cuBhfmebiGfQw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 09:29:47AM +0200, Miklos Szeredi wrote:
> On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> 
> > Most of the changes are limited to fuse/virtiofs. There are couple
> > of changes needed in generic dax infrastructure and couple of changes
> > in virtio to be able to access shared memory region.
> 
> So what's the plan for merging the different subsystems?  I can take
> all that into the fuse tree, but would need ACKs from the respective
> maintainers.

I am assuming for DAX patches we need ACK from Dan Williams and for
virtio patches we need ack from Michael S. Tsirkin.

Dan, Michael, can you please review the dax and virtio patches
respectively and if there are no concerns, please provide ACK. Or
suggest an alternative way of how these patches can be merged.

Thanks
Vivek

