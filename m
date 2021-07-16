Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063263CBAD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGPRAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 13:00:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhGPRAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:00:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 490BB22B0B;
        Fri, 16 Jul 2021 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626454644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pxtS5Oudgec4rEwV+dOqiY1lV684Qv1oXIm2Do6XZfk=;
        b=hiFNsQSKFHqkGL/hKshmGNpZ5ZjicXOhEN/YtCsK88lEdh0idp4zsblQzEdVglXoiKYrdc
        p6thMlpmVE41Yxl0KhkO7rimQTZLZLGojpDdoiJ9mLxNfdVo5NksjmOqEElW2p9FcTO/dc
        rWtidrEtmI2xNoBjWEUHSwW4bb+gIwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626454644;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pxtS5Oudgec4rEwV+dOqiY1lV684Qv1oXIm2Do6XZfk=;
        b=s2c+8kdjfyur3gk7j7C5XyvF5JLV7mAnIM52+3ast7hDDkz7BxCQcxzHI0oLCb040Bok4p
        kH2nrdw58zKz0qCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3725FA3BB9;
        Fri, 16 Jul 2021 16:57:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 12D411E0BF2; Fri, 16 Jul 2021 18:57:24 +0200 (CEST)
Date:   Fri, 16 Jul 2021 18:57:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/14 v10] fs: Hole punch vs page cache filling races
Message-ID: <20210716165724.GH31920@quack2.suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
 <YPEg63TU0pPzK5xB@infradead.org>
 <20210716164311.GA22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716164311.GA22357@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-07-21 09:43:11, Darrick J. Wong wrote:
> On Fri, Jul 16, 2021 at 07:02:19AM +0100, Christoph Hellwig wrote:
> > On Thu, Jul 15, 2021 at 03:40:10PM +0200, Jan Kara wrote:
> > > Hello,
> > > 
> > > here is another version of my patches to address races between hole punching
> > > and page cache filling functions for ext4 and other filesystems. The only
> > > change since the last time is a small cleanup applied to changes of
> > > filemap_fault() in patch 3/14 based on Christoph's & Darrick's feedback (thanks
> > > guys!).  Darrick, Christoph, is the patch fine now?
> > 
> > Looks fine to me.
> 
> Me too.

Thanks guys! I've pushed the patches to linux-next.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
