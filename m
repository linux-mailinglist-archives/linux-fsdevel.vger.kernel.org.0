Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ACE3CBAAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 18:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhGPQqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 12:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGPQqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:46:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35961613D0;
        Fri, 16 Jul 2021 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626453793;
        bh=4cf1AnF6M65jEKCZ4DUvlF+jXCvIQBpF34YgrerdDE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER33OScu5jXxJL4bBbchkSb43icKDsitlTLzz/ULEuCKhDyvzfruACZnB7KEth/Ea
         CrHL2LSiOdJ48FNoGdUcRJPztvvlN2R9q/wJJKcgnB4F1BFPAddcRBz30NPyaVNVA/
         c13g+u1kfK1sYm4jZTlXTgZiWA4uk6IRkbh//2Bk3gR4M1niUW7g70cN+zj01sKUw5
         w11NLDR1ohyuzzNvoiRCItpM7Kwmua6Mzwh8IqK6FDO3uAqgbL4KU/TlVuM6lEEHgQ
         owdro4sa6g8ZVQZprvohZ8U0qKtbPZRfpQ+EtiAyzSrv0hMzf/nWGpv1wM1Qur2p+u
         KJcRDYSgBrojg==
Date:   Fri, 16 Jul 2021 09:43:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/14 v10] fs: Hole punch vs page cache filling races
Message-ID: <20210716164311.GA22357@magnolia>
References: <20210715133202.5975-1-jack@suse.cz>
 <YPEg63TU0pPzK5xB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPEg63TU0pPzK5xB@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 07:02:19AM +0100, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 03:40:10PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > here is another version of my patches to address races between hole punching
> > and page cache filling functions for ext4 and other filesystems. The only
> > change since the last time is a small cleanup applied to changes of
> > filemap_fault() in patch 3/14 based on Christoph's & Darrick's feedback (thanks
> > guys!).  Darrick, Christoph, is the patch fine now?
> 
> Looks fine to me.

Me too.

--D
