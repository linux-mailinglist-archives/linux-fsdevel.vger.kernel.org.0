Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E23D62AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhGZPh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 11:37:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41844 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhGZPhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:37:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0695C1FEBD;
        Mon, 26 Jul 2021 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627316270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDGXGSd77lV/uvhR9hFZQltyCymEGgvfAqrIymCVPFQ=;
        b=Wp0Q4uahopy8wXWlBNh++ntZktkIazxsP74CGGfdqdg1MyAlYJd8dEZamBQ2oIUl63j+CV
        9SLQZ1GmDkjd912lHDFIs9dW7EFwHptS4MVaS/jVPrr1/mlAEQ1NhaeH8OUl0FHh/NdJe4
        YA/5okW6WATFIx8Y3YJ75mWa4iDJhqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627316270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDGXGSd77lV/uvhR9hFZQltyCymEGgvfAqrIymCVPFQ=;
        b=Je2KjW2SKW7/t0WrADUIWqan6BSrDp8RmrHuafqG+pMdDWMbHMqtw0cncoxrNwraPaU/Iq
        Y20ut/DrkjOTMXAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id ED85BA3BB4;
        Mon, 26 Jul 2021 16:17:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD49D1E3B13; Mon, 26 Jul 2021 18:17:49 +0200 (CEST)
Date:   Mon, 26 Jul 2021 18:17:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fs: remove generic_block_fiemap
Message-ID: <20210726161749.GI20621@quack2.suse.cz>
References: <20210720133341.405438-1-hch@lst.de>
 <20210720133341.405438-5-hch@lst.de>
 <20210726135256.GF20621@quack2.suse.cz>
 <20210726135459.GB8496@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726135459.GB8496@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-07-21 15:54:59, Christoph Hellwig wrote:
> On Mon, Jul 26, 2021 at 03:52:56PM +0200, Jan Kara wrote:
> > On Tue 20-07-21 15:33:41, Christoph Hellwig wrote:
> > > Remove the now unused generic_block_fiemap helper.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Nice. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Do you just want to pick the whole series up through the ext2 tree?

Sure. I've queued it up (generic_block_fiemap removal branch, pulled in
for_next branch).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
