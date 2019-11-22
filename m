Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846C3106685
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 07:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKVGdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 01:33:06 -0500
Received: from verein.lst.de ([213.95.11.211]:49975 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfKVGdG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:33:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C08068BFE; Fri, 22 Nov 2019 07:33:03 +0100 (CET)
Date:   Fri, 22 Nov 2019 07:33:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v4 03/13] exfat: add inode operations
Message-ID: <20191122063303.GA16886@lst.de>
References: <20191121052618.31117-1-namjae.jeon@samsung.com> <CGME20191121052916epcas1p3f00c8e510eb53f53f4e082848bd325d0@epcas1p3.samsung.com> <20191121052618.31117-4-namjae.jeon@samsung.com> <38716ae8-a056-4ee3-285a-a3c1ac8307a5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38716ae8-a056-4ee3-285a-a3c1ac8307a5@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:40:28AM +0100, Markus Elfring wrote:
> > +	err = exfat_map_cluster(inode, clu_offset, &cluster,
> > +		*create & BMAP_ADD_CLUSTER);
> 
> I find an other indentation more appropriate.
> Please align the last parameter below (or besides) the opening parenthesis.

It is great that you find that, but I think we can leave this to
the code author.  We have plenty of example for opening brace aligned,
one or two tabs alignments in the code, and it is up to the author /
maintainer to chose one.  No need to to nitpick their choices inside the
boundaries of the normal coding space.

> > +	if (err) {
> > +		if (err != -ENOSPC)
> > +			return -EIO;
> > +		return err;
> > +	}
> 
> Can such source code become more succinct?
> 
> +	if (err)
> +		return err != -ENOSPC ? -EIO : err;

If it sufficient but a lot harder to follow.
