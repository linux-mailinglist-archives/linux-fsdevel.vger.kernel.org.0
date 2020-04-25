Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF71B834A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 04:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYCq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 22:46:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44407 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgDYCq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:46:59 -0400
Received: by mail-io1-f66.google.com with SMTP id z2so12528161iol.11;
        Fri, 24 Apr 2020 19:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Pj3afjV5Qj8mX7qM7FlJgGFDjLluq/R+Lw5J5hb+Kw=;
        b=UBeagu/7o9FaNu3GeUNyIdK1PN8SPH5asf1CKRiF+vXciCKI1XDMmJ6SK+70VWnCVx
         +CO+0XzocAudezo0NRbCfLkMs4CjfS/DnWDr5WbIkRzcRQJEvgAZokvwTEl6PMukfD91
         qK+yiOY/r5Tnxbi2kfTcgaiZmWKaOcYAchPiSg9fFlzCa+uczUmxnqIBSV41Piqefh1N
         NNx5HNFswcvyAgN1GUogjDYQAFm2DShhJesY1xvPsVyui/K/UT3yRC9wyXY0OdmntGQj
         uqReKPa24kfpwaa+bGw6VnbcW0sx5SSysey87vC+fKuiLsbLbCAJpi5c21WA1UQpuLq3
         E8dg==
X-Gm-Message-State: AGi0PuarCDJA9vXeDAJ8Lt8+moKRcjbtNbB1bINeEfvoEUfy9sohZl/T
        JGBEm1jL3B8MiuySjORXMZoRJ8ibPLl1RE8MynE=
X-Google-Smtp-Source: APiQypKf9Cn4w+5zns7bDshCGdvmdkV/r30NuCSpzB9EJOet7H3hY2rSUpqZM5JI+Xc2FDNK13Bt79kISv3ZU0Q9CLg=
X-Received: by 2002:a05:6638:401:: with SMTP id q1mr10949165jap.50.1587782818750;
 Fri, 24 Apr 2020 19:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <1587716944-28250-1-git-send-email-chenhc@lemote.com> <20200424112721.GE13910@bombadil.infradead.org>
In-Reply-To: <20200424112721.GE13910@bombadil.infradead.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sat, 25 Apr 2020 10:54:23 +0800
Message-ID: <CAAhV-H4obH6BS7TNJzpZvxhBo6W8qRamOh8K92rk1OaB4PxosA@mail.gmail.com>
Subject: Re: [PATCH] fs/seq_file.c: Rename the "Fill" label to avoid build failure
To:     Matthew Wilcox <willy@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Matthew,

Thank you for your comments,

On Fri, Apr 24, 2020 at 7:27 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Apr 24, 2020 at 04:29:04PM +0800, Huacai Chen wrote:
> > MIPS define a "Fill" macro as a cache operation in cacheops.h, this
> > will cause build failure under some special configurations. To avoid
> > this failure we rename the "Fill" label in seq_file.c.
>
> You should rename the Fill macro in the mips header instead.
> I'd suggest Fill_R4000 of R4000_Fill.

Hi, Thomas,

What do you think about this? If you agree to rename the "Fill" macro
in cacheops.h, I want to rename it to Fill_I, because it has the same
coding style as other cache operations in cacheops.h.

Thanks,
Huacai
