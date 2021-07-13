Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E903C71AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhGMOCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 10:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236774AbhGMOCL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:02:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9FB461279;
        Tue, 13 Jul 2021 13:59:18 +0000 (UTC)
Date:   Tue, 13 Jul 2021 15:59:16 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/24] btrfs: support idmapped mounts
Message-ID: <20210713135916.qzlvtu5kcsb2z3ve@wittgenstein>
References: <20210713111344.1149376-1-brauner@kernel.org>
 <14addf76-b6f7-11ab-119b-4a1138bbd458@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14addf76-b6f7-11ab-119b-4a1138bbd458@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:23:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/13 下午7:13, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Hey everyone,
> > 
> > This series enables the creation of idmapped mounts on btrfs.
> 
> Any doc on the "idmapped" part?

Yes, I've written a long manpage for it that hasn't been merged for
manpages yet. Things seem to move a little slow there currently:
https://lore.kernel.org/linux-man/20210301093459.1876707-1-christian.brauner@ubuntu.com/

For an easily readable version you can also see:
https://github.com/brauner/mount-idmapped

> 
> Not familiar with that, the only thing I can thing of is from NFSv4
> idmapd, is that related or a completely new thing?

Unrelated.
