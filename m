Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61BA3D5A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhGZMtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 08:49:42 -0400
Received: from verein.lst.de ([213.95.11.211]:45205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233194AbhGZMtm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:49:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 49D6767373; Mon, 26 Jul 2021 15:30:07 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:30:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210726133006.GB6535@lst.de>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com> <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com> <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com> <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local> <20210726110611.459173-1-agruenba@redhat.com> <YP6rTi/I3Vd+pbeT@casper.infradead.org> <CAHc6FU6RhzfRSaX3qB6i6F+ELPZ=Q0q-xA0Tfu_MuDzo77d7zQ@mail.gmail.com> <YP60zLP13Hqi5iL+@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP60zLP13Hqi5iL+@B-P7TQMD6M-0146.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 09:12:44PM +0800, Gao Xiang wrote:
> I tend to leave it as another new story and can be resolved with
> another patch to improve it (or I will stuck in this, I need to do
> my own development stuff instead of spinning with this iomap patch
> since I can see this already work well for gfs2 and erofs), I will
> update the patch Andreas posted with Christoph's comments.

Yes, let's do the minimal work for erofs needs in a first step.
After that I hope I can get the iomap_iter change in and then we
can start the next projects.  That being said moving the copy back
to the inline data to writepage does seem very useful, as does the
"small" blocksize support from Matthew.
