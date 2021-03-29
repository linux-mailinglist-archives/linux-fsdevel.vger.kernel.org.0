Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3213234DC60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 01:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhC2XYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 19:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhC2XYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:24:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A00C061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 16:24:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so21982228ejv.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XF4To2Y7zgtF2QAVYiT7BBwCvauONTod77W3/2lXGW8=;
        b=Vsx9drBV7ccArQSqmDPqC+lTIb/A77ziMCx5iPDxYzAHz5bdXrgSzOciH2G+olKEzH
         JH+aiwgu7Hdc7Js/CFjZeYUNpwx0+EJ4WO1eE2x1fsFGzMOLBuWvUcrIpPIC/BzArvmG
         SoSbsrr1a84pxS45T+LCHCPrZ4YT1EgHckSDx8IT4d9M/APuB7pnuC8BPH8hgLx1YKnX
         8mmS8RFApDIqRbHB5XlYzw5cDHp5hIR3/bxLlGci8wVKnPeuvAPgpq7rHtbNCE/aUyzk
         mUztjRYlXDhIeGmczBxkjzDSdIyVqVIUQsrF4xS7Qy5pZtzbw/waLYA0DM0/VC+iNd0Y
         Zt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF4To2Y7zgtF2QAVYiT7BBwCvauONTod77W3/2lXGW8=;
        b=OweDHvla568kaAT0/t0U7+Tj++x7nsOtZz+SiXkURyxlIIZM5xxNPCYd/4PY4j07Wg
         JZd1Spha2WRcfxDejEpSc5mcMOPgO2Kt94GIvNNxTq4uGSxm7+lhlAJ596WUD2u9PlRr
         KYD6GWSgX8vJ6LZeQ/QNyEFb4AFnLBIs8Vqzv3egFtCXSNqTHJ+uIGN6Xm0PSFOJZNuo
         q64yCZjkvgV8AZ9zH7mhl+jXxfktTooOzG4l++zx0aOLaGo7/6T+tFaTxNbAANAXivBt
         dCZE2KwWzLLYKPqy8gfQISeJtFKZMOqhyanZpRlG1T5trrSFS5QQorJMerbzkfhHdxTh
         zY/w==
X-Gm-Message-State: AOAM531SvOIIaWf8CZCUnZSW0q/fcaUe3C2fip/ihlP4ee5G1vfT0YtJ
        3Nk+TZlL61yDuXzAjJ4gWoKx5aEMl8kSIGniSE+G4A==
X-Google-Smtp-Source: ABdhPJzf7VrSfLTELhnrW6mwobm/98+lZofBo3iswIzq94rBp2GFqTi32x/lL+dUXpEu98/zFDAR5BEkXvlHn9IcDz4=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr29769425ejb.264.1617060270344;
 Mon, 29 Mar 2021 16:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com> <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
 <20210325143419.GK2710221@ziepe.ca>
In-Reply-To: <20210325143419.GK2710221@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Mar 2021 16:24:19 -0700
Message-ID: <CAPcyv4hHHFD4cvdRmajWgYbXU5-o-jF-o6D5ud-rg4dWNqt5Ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 7:34 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 18, 2021 at 10:03:06AM -0700, Dan Williams wrote:
> > Yes. I still need to answer the question of whether mapping
> > invalidation triggers longterm pin holders to relinquish their hold,
> > but that's a problem regardless of whether gup-fast is supported or
> > not.
>
> It does not, GUP users do not interact with addres_space or mmu
> notifiers
>

Ok, but the SIGKILL from the memory_failure() will drop the pin?

Can memory_failure() find the right processes to kill if the memory
registration has been passed by SCM_RIGHTS?
