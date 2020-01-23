Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C681463C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 09:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAWIpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 03:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWIpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:45:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4883C2073A;
        Thu, 23 Jan 2020 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579769101;
        bh=WGwiLbw2RYeEBF4QqvP2f4Ql8aF8IMEbAzwfkCSdVNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hx5NbUOphlTzFbzH/H3hS9BXrleVrdJQsHQ/lsEJiJX3HegGPHrhR7oTRh9iFo6Oi
         COXZ00HEFJooejGvMOEjIx+NTnqA3uQguK4Rva3cqt8B7y9BXPe5L2l4bQ+ZqjlZt0
         GqneE37efKf36SkZ3WPk/RnuIy7Iv75BvJJ6c348=
Date:   Thu, 23 Jan 2020 09:44:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH v2] staging: exfat: remove fs_func struct.
Message-ID: <20200123084459.GA434861@kroah.com>
References: <20200123083258.118854-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123083258.118854-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 05:32:58PM +0900, Tetsuhiro Kohada wrote:
> From: "Tetsuhiro Kohada" <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> 
> Remove 'fs_func struct' and change indirect calls to direct calls.
> 
> The following issues are described in exfat's TODO.
> > Create helper function for exfat_set_entry_time () and
> > exfat_set_entry_type () because it's sort of ugly to be calling the same functionn directly and other code calling through  the fs_func struc ponters ...
> 
> The fs_func struct was used for switching the helper functions of fat16/fat32/exfat.
> Now, it has lost the role of switching, just making the code less readable.
> 
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> ---
>  drivers/staging/exfat/exfat.h       |  79 +++++-----
>  drivers/staging/exfat/exfat_core.c  | 214 +++++++++++-----------------
>  drivers/staging/exfat/exfat_super.c | 119 ++++++++--------
>  3 files changed, 178 insertions(+), 234 deletions(-)

What changed from v1?

Always put that below the --- line, as the documentation asks you to, so
that we know what is happening here.

Please fix that up and send a v3.

thanks,

greg k-h
