Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7B2C519D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgKZJuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 04:50:07 -0500
Received: from verein.lst.de ([213.95.11.211]:33696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732410AbgKZJuH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:50:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD50E68B02; Thu, 26 Nov 2020 10:50:04 +0100 (CET)
Date:   Thu, 26 Nov 2020 10:50:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] fs: export vfs_stat() and vfs_fstatat()
Message-ID: <20201126095004.GA23930@lst.de>
References: <1606374948-38713-1-git-send-email-yangyicong@hisilicon.com> <20201126071848.GA17990@lst.de> <696f0e06-4f4d-0a61-6e13-f5af433594bf@hisilicon.com> <20201126091537.GA21957@lst.de> <79b19660-f418-f5ac-943c-bc49a88eb949@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b19660-f418-f5ac-943c-bc49a88eb949@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:48:25PM +0800, Yicong Yang wrote:
> Sorry for not describing the issues I met correctly in the commit message.
> Actually we're using inline function vfs_stat() for getting the
> attributes, which calls vfs_fstatat():

Again, there generally isn't much need to look at the stat data
for an in-kernel caller.  But without you submitting the code I can't
really help you anyway.
