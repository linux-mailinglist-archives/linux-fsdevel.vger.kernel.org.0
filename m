Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3711267BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSRNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 12:13:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSRNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:13:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F082053B;
        Thu, 19 Dec 2019 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576775624;
        bh=jUparBvQsW8M+YEToL7Ck5iK+E2oINazJ3dWX8wTHqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYTOwOr8zUB3CtVY/km68f5K8rSXgOz9WyrilaEUlR+HAXDbuA978CvgemIH0xnQc
         2wbRtAYeZUHOIAgsrrSwKiU6Dm3IT2PVWvR3cT5Fz6Tsm+G+nihJfEqPv/vIkWSpwX
         A4WMg6cRTTBMHY08HKX0+hHGEUYFnd1Q+PvAGIdU=
Date:   Thu, 19 Dec 2019 18:13:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Preis <julian.preis@fau.de>
Cc:     devel@driverdev.osuosl.org, =valdis.kletnieks@vt.edu,
        Johannes Weidner <johannes.weidner@fau.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/staging/exfat/exfat_super.c: Clean up
 ffsCamelCase function names
Message-ID: <20191219171342.GA2080752@kroah.com>
References: <y>
 <20191218074722.3338-1-julian.preis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218074722.3338-1-julian.preis@fau.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:47:22AM +0100, Julian Preis wrote:
> Rename every instance of <ffsCamelCaseExample> to <camel_case_example>
> in file exfat_super.c. Fix alignment.
> 
> Co-developed-by: Johannes Weidner <johannes.weidner@fau.de>
> Signed-off-by: Johannes Weidner <johannes.weidner@fau.de>
> Signed-off-by: Julian Preis <julian.preis@fau.de>
> 
> ---
> Changes in v3:
> - Change renaming from <ffs_camel_case_example> to <camel_case_example>
> 
> Changes in v2:
> - Add email recipients according to get_maintainer.pl
> - Add patch versions
> - Use in-reply-to
> 
>  drivers/staging/exfat/exfat_super.c | 98 ++++++++++++++---------------
>  1 file changed, 49 insertions(+), 49 deletions(-)

This patch breaks the build horribly :(

Did you test it?

Please always do so, otherwise it makes maintainers grumpy :(

greg k-h
