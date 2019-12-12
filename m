Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA311D37E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfLLRP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfLLRP1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:15:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E26205C9;
        Thu, 12 Dec 2019 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576170927;
        bh=Fyb6/fK2KFFxnJ/1P9lp7azi9Ofrz+pj2dxzPQw5ulU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFFmym/9D8glzkWKRe71tuNPdLZoFSRdcB9tHMQaveU/6IcN3e6XYfMY3Tkp/IQDd
         BqdBTeWrdSPqwqexM1vDyYzChBi9y8eF+kgvz/nxC8c/MuL8zn06vmEjx2CgqydcMh
         xKE90fqWSfbD91aaxzXx4/FtIuAXenetul2leFbo=
Date:   Thu, 12 Dec 2019 18:15:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        luto@kernel.org, adobriyan@gmail.com, akpm@linux-foundation.org,
        vbabka@suse.cz, peterz@infradead.org, bigeasy@linutronix.de,
        mhocko@suse.com, john.ogness@linutronix.de, nixiaoming@huawei.com
Subject: Re: [PATCH 4.4 0/7] fs/proc: Stop reporting eip and esp in
Message-ID: <20191212171505.GB1681017@kroah.com>
References: <20191202083519.23138-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202083519.23138-1-yi.zhang@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 04:35:12PM +0800, zhangyi (F) wrote:
> Reporting eip and esp fields on a non-current task is dangerous,
> so backport this series for 4.4 to fix protential oops and info leak
> problems. The first 3 patch are depended on the 6/7 patch.

Thanks for the backports, now queued up.

greg k-h
