Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22CA2C50F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbgKZJPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 04:15:41 -0500
Received: from verein.lst.de ([213.95.11.211]:33584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389172AbgKZJPl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:15:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4FAE68BEB; Thu, 26 Nov 2020 10:15:37 +0100 (CET)
Date:   Thu, 26 Nov 2020 10:15:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] fs: export vfs_stat() and vfs_fstatat()
Message-ID: <20201126091537.GA21957@lst.de>
References: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com> <20201126071848.GA17990@lst.de> <696f0e06-4f4d-0a61-6e13-f5af433594bf@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696f0e06-4f4d-0a61-6e13-f5af433594bf@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:08:26PM +0800, Yicong Yang wrote:
> > And why would you want to use them in kernel module?  Please explain
> > that in the patch that exports them, and please send that patch in the
> > same series as the patches adding the users.
> 
> we're using it in the modules for testing our crypto driver on our CI system.
> is it mandatory to upstream it if we want to use this function?

Yes.  And chances are that you do not actaully need these functions
either, but to suggest a better placement I need to actually see the
code.
