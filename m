Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3F1F51CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgFJKEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 06:04:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgFJKEE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:04:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76F2DAC51;
        Wed, 10 Jun 2020 10:04:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A2DA1E1283; Wed, 10 Jun 2020 12:04:02 +0200 (CEST)
Date:   Wed, 10 Jun 2020 12:04:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ted Tso <tytso@mit.edu>, Martijn Coenen <maco@android.com>,
        tj@kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] writeback: Lazytime handling fix and cleanups
Message-ID: <20200610100402.GA25104@quack2.suse.cz>
References: <20200601091202.31302-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601091202.31302-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 01-06-20 11:18:54, Jan Kara wrote:
> Hello,
> 
> this patch series fixes an issue with handling of lazy inode timestamp
> writeback which could result in missed background writeback of an inode
> or missed update of inode timestamps during sync(2). It also somewhat
> simplifies the writeback code handling of lazy inode timestamp updates.
> Review is welcome!

OK, nobody has replied to this and I have positive feedback from Martijn so
I guess I'll pickup the patches to my tree so that they get some testing in
linux-next and push them to Linus sometime next week.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
