Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDADA2742E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVN0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:26:11 -0400
Received: from verein.lst.de ([213.95.11.211]:44649 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgIVN0L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:26:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8F9A67373; Tue, 22 Sep 2020 15:26:08 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:26:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 08/15] btrfs: Introduce btrfs_write_check()
Message-ID: <20200922132608.GF20432@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-9-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144353.31319-9-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		size_t nocow_bytes = count;
> +
> +		/*
> +		 * We will allocate space in case nodatacow is not set,
> +		 * so bail
> +		 */
> +		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes)
> +		    <= 0)

This could easily be:

		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes) <= 0)

as it perfectly fits withing 80 characters.
