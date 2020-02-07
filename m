Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2022155500
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGJr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgBGJr1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:47:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4002622314;
        Fri,  7 Feb 2020 09:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581068846;
        bh=STDDAhSbeinx11QVofYzcpT5d2ybVmuuDFwiPmfqa1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9ZZ4OUJ9gYn3AXHXtwXGtFs6h4p/nv3Z+4OjjOIukFt/R4RtcMgFI4jaDnHvfklE
         xVxyHn7Xi25UmXgchQDPtLexq5dwcp2ig0S0ZpHanHjbLQgxpbl9eD1CWS863GFS/7
         Up9gHdCIwIL5L1yD49bmI3MAH40L1NFKtgxnyqbg=
Date:   Fri, 7 Feb 2020 10:47:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200207094724.GA564661@kroah.com>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> remove 'dos_name','ShortName' and related definitions.
> 
> 'dos_name' and 'ShortName' are definitions before VFAT.
> These are never used in exFAT.
> 
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> ---
>  drivers/staging/exfat/exfat.h       | 52 +++--------------------------
>  drivers/staging/exfat/exfat_core.c  | 47 +++++++++-----------------
>  drivers/staging/exfat/exfat_super.c | 38 ++++++++-------------
>  3 files changed, 34 insertions(+), 103 deletions(-)

Patch does not apply to my tree, can you rebase this series and resend?

thanks,

greg k-h
