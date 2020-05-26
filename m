Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883ED1E2F2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbgEZTiC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:38:02 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47009 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389155AbgEZTiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:38:02 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 365B5C0004;
        Tue, 26 May 2020 19:37:56 +0000 (UTC)
Date:   Tue, 26 May 2020 21:37:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: Re: mmotm 2020-05-25-16-56 uploaded
 (mtd/nand/raw/arasan-nand-controller)
Message-ID: <20200526213754.251009fc@xps13>
In-Reply-To: <8bc47bd8-d504-2c7b-6279-e908cef987c5@infradead.org>
References: <20200525235712.VqEFGWfKu%akpm@linux-foundation.org>
        <8bc47bd8-d504-2c7b-6279-e908cef987c5@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

Randy Dunlap <rdunlap@infradead.org> wrote on Mon, 25 May 2020 23:56:53
-0700:

> On 5/25/20 4:57 PM, Andrew Morton wrote:
> > The mm-of-the-moment snapshot 2020-05-25-16-56 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.  
> 
> on i386:
> 
> ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_detach_chip':
> arasan-nand-controller.c:(.text+0x872): undefined reference to `bch_free'
> ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_read_page_hw_ecc':
> arasan-nand-controller.c:(.text+0x18ec): undefined reference to `bch_decode'
> ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_attach_chip':
> arasan-nand-controller.c:(.text+0x214d): undefined reference to `bch_init'
> 
> 
> Full randconfig file is attached.
> 
> Maybe select BCH?
> 
> If that doesn't work, sometimes in lib/Makefile, the target has to be
> in lib- instead of in obj-.
> 
> 

It's fixed now, indeed I forgot to select BCH in Kconfig, thanks for
the warning!

Cheers,
Miquèl
