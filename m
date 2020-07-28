Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CD23158C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 00:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgG1Wbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 18:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgG1Wbo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:31:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174322070B;
        Tue, 28 Jul 2020 22:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595975504;
        bh=USgsau1jLxsUh0IHHnxlGhKzEnC86ftOeMK0r3//QAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w6DNbqz1ACASZPLTQFqATBTvcfX7z8Wp8MzJ2gVrutu7ZBz9KYr8k45QR/LzhleZY
         avC9jAx6kc4nOkmCOqC4QEyN25wIMmrLVN2CEYgfntvT7y+MvPnmZSdFZTd6ahuCXP
         3E4a7+KaIoA/Pl1/kzR2OJlQsBt7TnCgHsPtChSk=
Date:   Tue, 28 Jul 2020 15:31:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
Message-Id: <20200728153143.c94d5af061b20db609511bf3@linux-foundation.org>
In-Reply-To: <20200729082053.6c2fb654@canb.auug.org.au>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
        <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
        <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
        <20200729082053.6c2fb654@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jul 2020 08:20:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Tue, 28 Jul 2020 14:55:53 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > config CONTIG_ALLOC
> >         def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
> > 
> > says this is an improper combination.  And `make oldconfig' fixes it up.
> > 
> > What's happening here?
> 
> CONFIG_VIRTIO_MEM selects CONFIG_CONTIG_ALLOC ...

Argh, select strikes again.

So I guess VIRTIO_MEM should also select COMPACTION?
