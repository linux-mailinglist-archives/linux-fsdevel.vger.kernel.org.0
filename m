Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B813AFF32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFVI0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 04:26:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVI0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:26:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6A02E1FD45;
        Tue, 22 Jun 2021 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624350277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARvxoAVeDbwGt5PokyDvAZieyTEiRL6VGBAfsGVKb60=;
        b=b8zytakSjU01aEZDC+Et0pLKO+pbrlWrucvpT8GsEVY91qLNg2rnJKPI9QpnnL4dERSUAl
        oOec01KN1aVTw/1s6Bd8MsYyzAlrYt5dT2hBN5JcD4oD0t2nSWaUnluMamwkR7sJlHJTK8
        504PCPbNn95xv9cy+8csSYgCb6tlQ24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624350277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARvxoAVeDbwGt5PokyDvAZieyTEiRL6VGBAfsGVKb60=;
        b=cIMSsHITcT8uyBMpFDk+uK3kXpPNm+XO8PMwCu42kZHGeuywi971wJWJ9y+FgzunkG+cj7
        QoUHLFpqdwoAWQAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9D644A3B84;
        Tue, 22 Jun 2021 08:24:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 383F71E1515; Tue, 22 Jun 2021 10:24:36 +0200 (CEST)
Date:   Tue, 22 Jun 2021 10:24:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, david@fromorbit.com
Subject: Re: [RFC PATCH v4 0/8] ext4, jbd2: fix 3 issues about
 bdev_try_to_free_page()
Message-ID: <20210622082436.GB14261@quack2.suse.cz>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <YMsagbQqxJo4y2FR@infradead.org>
 <YNCvWfPkauVIz2eP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCvWfPkauVIz2eP@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-06-21 16:25:13, Christoph Hellwig wrote:
> On Thu, Jun 17, 2021 at 10:48:49AM +0100, Christoph Hellwig wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Just curious: does anyone plan to pick this up for 5.14?  Getting rid
> of the layering violation on the block device mapping would really help
> with some changes I am working on.

AFAIK Ted was planning on picking this up for the merge window...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
