Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B6430EED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhJREis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 00:38:48 -0400
Received: from verein.lst.de ([213.95.11.211]:60351 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhJREir (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:38:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FC5867373; Mon, 18 Oct 2021 06:36:33 +0200 (CEST)
Date:   Mon, 18 Oct 2021 06:36:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 7/8] xfs: support CoW in fsdax mode
Message-ID: <20211018043633.GA23493@lst.de>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com> <20210928062311.4012070-8-ruansy.fnst@fujitsu.com> <20211014170622.GB24333@magnolia> <CAPcyv4gGxpHBBjB8e23WEQyVfo4R=vT=1syrJXx1tWymCDV51w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gGxpHBBjB8e23WEQyVfo4R=vT=1syrJXx1tWymCDV51w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:50:00AM -0700, Dan Williams wrote:
> The other blocker was enabling mounting dax filesystems on a
> dax-device rather than a block device. I'm actively refactoring the
> nvdimm subsystem side of that equation, but could use help with the
> conversion of the xfs mount path. Christoph, might you have that in
> your queue?

It's in my queue.  I'm about to send your a series of prep patches
and plan to tackle the actual mounting next merge window.
