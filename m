Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF9A9256
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfIDTbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 15:31:33 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:43374 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729803AbfIDTbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1567625491;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=PcFJmgXphXAgMTzEqtGAmyZoYWFr5XRnp0kHdbyqz4s=;
        b=GwHMsNh0TlGnNbVoMm7+dx7dxoBn/weDacqBs00YnSm/6FPhetXhaKq4djrf5Unz
        rYFSYQZdou6MsJEjMIKrMRLWImApiZkCjzrC6D96ACCVw+/tdIOrAjBncyGYXS5n0Lj
        /4YdNYH/kmEZmxPCMoUxC3iDBf/wOYGWtdPgu+z4=
Date:   Wed, 4 Sep 2019 19:31:31 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
In-Reply-To: <20190903205312.GK29434@bombadil.infradead.org>
Message-ID: <0100016cfdc2b4a1-355182af-3d27-4ae8-94f3-e3b6e8cc6814-000000@email.amazonses.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com> <20190828194607.GB6590@bombadil.infradead.org> <20190829073921.GA21880@dhcp22.suse.cz>
 <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com> <20190901005205.GA2431@bombadil.infradead.org> <0100016cf8c3033d-bbcc9ba3-2d59-4654-a7c2-8ba094f8a7de-000000@email.amazonses.com>
 <20190903205312.GK29434@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.09.04-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 3 Sep 2019, Matthew Wilcox wrote

> > Its enabled in all full debug session as far as I know. Fedora for
> > example has been running this for ages to find breakage in device drivers
> > etc etc.
>
> Are you telling me nobody uses the ramdisk driver on fedora?  Because
> that's one of the affected drivers.

How do I know? I dont run these tests.

> > decade now) I am having a hard time believing the stories of great
> > breakage here. These drivers were not tested with debugging on before?
> > Never ran with a debug kernel?
>
> Whatever is being done is clearly not enough to trigger the bug.  So how
> about it?  Create an option to slab/slub to always return misaligned
> memory.

It already exists

Add "slub_debug" on the kernel command line.

