Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD9E41E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391413AbfJYC5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389230AbfJYC5D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:57:03 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E86421929;
        Fri, 25 Oct 2019 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571972223;
        bh=NPN4Lzq7O1KC2vVhwGJeYdnNqlHdVp9NAz4fHW8yYOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfirNwxIXa6/ivSQFS2SjYN3jeaI+NC0wVP3ralF6uRWq+E4ylaKBVmUib2tXL4yN
         LjbksyjRFPdRH3tY1zaKTE3iVr5cd7JRRaFrfpcoHPBackv+WKZPMiYdiygveN+NDr
         m8sV/IecqZD6a6ixWoUj3dH2rcmHVi9BevArNccc=
Date:   Thu, 24 Oct 2019 22:56:08 -0400
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] staging: exfat: Clean up return codes -
 FFS_FORMATERR
Message-ID: <20191025025608.GA445350@kroah.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
 <20191024155327.1095907-10-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024155327.1095907-10-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:53:20AM -0400, Valdis Kletnieks wrote:
> Convert FFS_FORMATERR to -EFSCORRUPTED
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> ---
>  drivers/staging/exfat/exfat.h       | 3 ++-
>  drivers/staging/exfat/exfat_core.c  | 4 ++--
>  drivers/staging/exfat/exfat_super.c | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

This causes build errors, maybe because I didn't take your other series.

So I'm stopping here, please rebase and resend.

thanks,

greg k-h
