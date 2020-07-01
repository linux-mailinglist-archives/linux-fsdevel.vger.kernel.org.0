Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE5210559
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 09:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGAHuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 03:50:09 -0400
Received: from verein.lst.de ([213.95.11.211]:39033 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgGAHuJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:50:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C347F68B05; Wed,  1 Jul 2020 09:50:05 +0200 (CEST)
Date:   Wed, 1 Jul 2020 09:50:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, david@fromorbit.com,
        darrick.wong@oracle.com, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Message-ID: <20200701075005.GA29884@lst.de>
References: <20200629192353.20841-1-rgoldwyn@suse.de> <20200629192353.20841-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629192353.20841-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:23:48PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Convert wait_for_completion boolean to flags so we can pass more flags
> to iomap_dio_rw()

FYI, when I did this a while ago for a stalled patch series I used
a single namespace for the flags passed to iomap_dio_rw and the flags
store in dio->flag, which at that point seemed a bit cleaner to me:

http://git.infradead.org/users/hch/xfs.git/commitdiff/1733619fefab1b0020d3ab91ebd0a72ccec982af
