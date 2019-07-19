Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC36E0CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 07:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGSF7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 01:59:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGSF7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YL6bF1lCV/u18iEbHKkcttQ1IqtcYX9eDlzmkJjoLf8=; b=VEFK2gUsNM+QPdwmELguxBVep
        WqoDbVJr+dbNt4KUNYZFrDjz7bvGqZnTzzQakjWRLKYV4mXkhWMoz1my1EXTN7EnEXJvWfJ29Ocmb
        IDAeybLfaNDkw+qE4+fNY2cyWGsHQEV+NgKZC78+b1qCRO9P8dxwlDSYV+ZrA80fSJ8ubHXA16uuw
        NeXxVy4ZueHplQU9L9UZWNLzWTvdTim584aojeOBarFdQaJ45l0NnynXyiK3iQKfzqlUn8t4xrdyM
        bcDM5OfAb6bvTkudvzKiaevy4dJf+yapgbveIWtB5RsXYTaOeSFuGcGbPsz05g9ApeKSwc3acdcO3
        9jIh/s61w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoLux-0007mr-2e; Fri, 19 Jul 2019 05:58:55 +0000
Date:   Thu, 18 Jul 2019 22:58:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
Message-ID: <20190719055855.GB29082@infradead.org>
References: <20190718125509.775525-1-arnd@arndb.de>
 <20190718125703.GA28332@lst.de>
 <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com>
 <20190718130835.GA28520@lst.de>
 <20190718142525.GE7116@magnolia>
 <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:19:15AM +0900, Masahiro Yamada wrote:
> I started to think
> compiling all headers is more painful than useful.
> 
> 
> MW is closing, so I am thinking of disabling it for now
> to take time to re-think.

For now this seems like the best idea.  In the long run maybe we can
limit the tests to certain configs, e.g.


headers-$(CONFIG_IOMAP)		+= iomap.h

in include/linux/Kbuild

and base it off that?
