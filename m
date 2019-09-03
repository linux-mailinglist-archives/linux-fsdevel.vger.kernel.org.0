Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85684A744D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfICUKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:10:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:36778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfICUKM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:10:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4ABC4ACA8;
        Tue,  3 Sep 2019 20:10:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F314B1E15A8; Tue,  3 Sep 2019 22:10:10 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:10:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     zhengbin <zhengbin13@huawei.com>, amir73il@gmail.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: remove always false comparison in
 copy_fid_to_user
Message-ID: <20190903201010.GA8225@quack2.suse.cz>
References: <1567475654-6133-1-git-send-email-zhengbin13@huawei.com>
 <20190903112818.GC29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903112818.GC29434@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-09-19 04:28:21, Matthew Wilcox wrote:
> On Tue, Sep 03, 2019 at 09:54:14AM +0800, zhengbin wrote:
> > Fixes gcc warning:
> > 
> > fs/notify/fanotify/fanotify_user.c:252:19: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: zhengbin <zhengbin13@huawei.com>
> 
> When fixing bugs like this, please do a git log -p and cc the person
> responsible for introducing the code you're fixing.  Also add a Fixes:
> line.

Generally I agree although in this particular case it is just a cosmetic
fix so I don't find that very important. 

> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
