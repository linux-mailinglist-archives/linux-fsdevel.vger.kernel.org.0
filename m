Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3C13AB88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 14:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgANN5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 08:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANN5Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:57:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F0C214AF;
        Tue, 14 Jan 2020 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579010235;
        bh=u1XftiISC3VBa0SoBrbPS2ShHLO3XvE3roqyoOX87GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPtiJgCzhe1v3amHUUlGh4oF6pt2nnJT6KaFzT/SKBJNJe6JoE9y75CEcHAabsKt5
         N8Z/3kYu6hEKHnozAK53tnr5s+IbOSTGGSLTDzSnYXfSDEX/hMkdLBwksbJb+P7rPf
         SzGD+8Wtxpdsd4BX18A+58S6yknRGWIEKyqt4FsM=
Date:   Tue, 14 Jan 2020 14:57:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Preis <julian.preis@fau.de>
Cc:     devel@driverdev.osuosl.org, valdis.kletnieks@vt.edu,
        Johannes Weidner <johannes.weidner@fau.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] drivers/staging/exfat/exfat_super.c: Clean up
 ffsCamelCase function names
Message-ID: <20200114135712.GA1679811@kroah.com>
References: <y>
 <20200107143337.11419-1-julian.preis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107143337.11419-1-julian.preis@fau.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 03:33:37PM +0100, Julian Preis wrote:
> Rename every instance of <ffsCamelCaseExample> to <ffs_camel_case_example>
> in file exfat_super.c. Fix resulting overlong lines.
> 
> Co-developed-by: Johannes Weidner <johannes.weidner@fau.de>
> Signed-off-by: Johannes Weidner <johannes.weidner@fau.de>
> Signed-off-by: Julian Preis <julian.preis@fau.de>

I get an odd error when trying to apply this patch, saying it is
corrupted.  Can you try to apply it on your side, and if it works,
resend?

thanks,

greg k-h
