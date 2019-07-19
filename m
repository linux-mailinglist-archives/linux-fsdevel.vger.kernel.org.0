Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68E86E0F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 08:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfGSGTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 02:19:19 -0400
Received: from verein.lst.de ([213.95.11.211]:37293 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSGTT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:19:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EEABB68B02; Fri, 19 Jul 2019 08:19:16 +0200 (CEST)
Date:   Fri, 19 Jul 2019 08:19:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
Message-ID: <20190719061916.GA18977@lst.de>
References: <20190718125509.775525-1-arnd@arndb.de> <20190718125703.GA28332@lst.de> <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com> <20190718130835.GA28520@lst.de> <20190718142525.GE7116@magnolia> <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com> <20190719055855.GB29082@infradead.org> <CAK7LNAQrPRKUCbTY9pSWrUTw=kshhE2CSz5jqXOuD7ziChdsGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQrPRKUCbTY9pSWrUTw=kshhE2CSz5jqXOuD7ziChdsGg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 03:16:55PM +0900, Masahiro Yamada wrote:
> > headers-$(CONFIG_IOMAP)         += iomap.h
> 
> I cannot find CONFIG_IOMAP.
> 
> Do you mean
> 
> header-test-$(CONFIG_BLOCK) += iomap.h

Yeah, we could use CONFIG_BLOCK.
