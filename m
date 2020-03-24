Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77CF191607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCXQSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 12:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCXQSx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:18:53 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59DD2073E;
        Tue, 24 Mar 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585066733;
        bh=uDZ6xONe7hN/cEt7/U9oDokxJ0lmH4fwXrNK8vvyKVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AcvVmc3x3bcZ5BQ/b8glBwgfTorqH4jecAYdlA2CmUJBin3jpPVoHRCdor/hsgnzI
         UT3pA7P6R3FsxdDqbLqCB4P2XTXb1XjGp87E51omh9yC/O7WSgoHyXq3SmeyK1WrQq
         jmtsxpEy7vig+QCl2e1G4hFbG0Y1GJbqGJoKA/5M=
Date:   Tue, 24 Mar 2020 11:18:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-pci <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
Message-ID: <20200324161851.GA2300@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62819368-150e-6b49-3ab3-9a2ab28481b3@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 08:16:34AM -0700, Randy Dunlap wrote:
> On 3/23/20 9:30 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-03-23-21-29 has been uploaded to
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
> 
> 
> on x86_64:
> 
> ../drivers/pci/controller/dwc/pcie-tegra194.c: In function ‘tegra_pcie_dw_parse_dt’:
> ../drivers/pci/controller/dwc/pcie-tegra194.c:1160:24: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_phy_get’? [-Werror=implicit-function-declaration]
>   pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
>                         ^~~~~~~~~~~~~~
>                         devm_phy_get

Thanks a lot for the report!

This was found on mmotm, but I updated my -next branch with Lorenzo's
latest pci/endpoint branch (current head 775d9e68f470) and reproduced
this build failure with the .config you attached.

I dropped that branch from my -next branch for now and pushed it.

Bjorn
