Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9826C25DF73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDQMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDQMT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:12:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38292074D;
        Fri,  4 Sep 2020 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235939;
        bh=h74Mbn0tqg4NbPdj1MmkcAdFmYDGJuuFsRs//+UVTNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bf68lCXHk2r6aKN0OSdnnJL1WR/d7Hvvyi0ZBlz/e8McV43miJZLk3rlp92t4HvAI
         VK+NL/eIA7Ady24pUVyhJJGhN2LIBcMgKeMMi1L8d3n4ot8bXvEZ+cd3HhLVy/7u3v
         wANYK9nDQKgxnosrxje2AOCoxGitPopczybHaisc=
Date:   Fri, 4 Sep 2020 18:12:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     ap420073@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] debugfs: Fix module state check condition
Message-ID: <20200904161240.GA3730201@kroah.com>
References: <20200811150129.53343-1-vdronov@redhat.com>
 <20200904114207.375220-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904114207.375220-1-vdronov@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 01:42:07PM +0200, Vladis Dronov wrote:
> Hello,
> 
> Dear maintainers, could you please look at the above patch, that
> previously was sent during a merge window?
> 
> A customer which has reported this issue replied with a test result:
> 
> > I ran the same test.
> > Started ib_write_bw traffic and started watch command to read RoCE
> > stats : watch -d -n 1 "cat /sys/kernel/debug/bnxt_re/bnxt_re0/info".
> > While the command is running, unloaded roce driver and I did not
> > observe the call trace that was seen earlier.

Having this info, that this was affecting a user, would have been good
in the original changelog info, otherwise this just looked like a code
cleanup patch to me.

I'll go queue this up now, thanks.

greg k-h
