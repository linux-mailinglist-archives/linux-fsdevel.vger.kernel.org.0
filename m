Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D7B3D5AC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhGZNOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 09:14:33 -0400
Received: from verein.lst.de ([213.95.11.211]:45289 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhGZNOc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:14:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7104B67373; Mon, 26 Jul 2021 15:54:59 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:54:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fs: remove generic_block_fiemap
Message-ID: <20210726135459.GB8496@lst.de>
References: <20210720133341.405438-1-hch@lst.de> <20210720133341.405438-5-hch@lst.de> <20210726135256.GF20621@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726135256.GF20621@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 03:52:56PM +0200, Jan Kara wrote:
> On Tue 20-07-21 15:33:41, Christoph Hellwig wrote:
> > Remove the now unused generic_block_fiemap helper.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Nice. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Do you just want to pick the whole series up through the ext2 tree?
