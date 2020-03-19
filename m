Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB018B907
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgCSOMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgCSOMq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:12:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8126420CC7;
        Thu, 19 Mar 2020 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584627166;
        bh=2Zqf9W/KTFDdCNMpUfDEgtc6u1k7w31Q3fyzmD0cjPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pORtBDWf/0NEM82XInF+pCLPglEjoPNPxPO6iN9YkqQPjtjV3Rc6YWB3757dhQjYV
         ZndcnUzkJ0H/NZsTICf9G5riMYibrGF8am2KPCMN03YFB/IrRilTEW8qcxJ1JS7NgR
         /PPKk5wQBqAU+IIABOR+AJQ6L8FsKeCpGhFftye0=
Date:   Thu, 19 Mar 2020 15:12:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aravind Ceyardass <aravind.pub@gmail.com>
Cc:     valdis.kletnieks@vt.edu, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: exfat: Fix checkpatch.pl camelcase issues
Message-ID: <20200319141243.GA30888@kroah.com>
References: <20200319140647.3926-1-aravind.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319140647.3926-1-aravind.pub@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:06:47AM -0400, Aravind Ceyardass wrote:
> Fix ffsCamelCase function names and mixed case enums
> 
> Signed-off-by: Aravind Ceyardass <aravind.pub@gmail.com>
> ---
>  drivers/staging/exfat/TODO          |   1 -
>  drivers/staging/exfat/exfat.h       |  12 +-
>  drivers/staging/exfat/exfat_super.c | 222 ++++++++++++++--------------
>  3 files changed, 117 insertions(+), 118 deletions(-)

These files are not in linux-next, or in my tree, anymore.

Please always work against the latest development tree so you do not
waste duplicated effort.

thanks,

greg k-h
