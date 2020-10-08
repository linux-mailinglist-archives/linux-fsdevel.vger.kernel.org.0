Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35E92879F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgJHQ1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 12:27:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbgJHQ1v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:27:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A80FABF4;
        Thu,  8 Oct 2020 16:27:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D1A131E1305; Thu,  8 Oct 2020 18:27:49 +0200 (CEST)
Date:   Thu, 8 Oct 2020 18:27:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RESEND^2 PATCH v3 0/3] Clean up and fix error handling in DIO
Message-ID: <20201008162749.GC14976@quack2.suse.cz>
References: <20201008062620.2928326-1-krisman@collabora.com>
 <20201008093213.GB3486@quack2.suse.cz>
 <b8e122ef-d36b-c107-dae6-29fce6a69e26@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e122ef-d36b-c107-dae6-29fce6a69e26@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-10-20 10:16:07, Jens Axboe wrote:
> On 10/8/20 3:32 AM, Jan Kara wrote:
> > On Thu 08-10-20 02:26:17, Gabriel Krisman Bertazi wrote:
> >> Hi,
> >>
> >> Given the proximity of the merge window and since I haven't seen it pop
> >> up in any of the trees, and considering it is reviewed and fixes a bug
> >> for us, I'm trying another resend for this so it can get picked up in
> >> time for 5.10.
> >>
> >> Jan, thanks again for the review and sorry for the noise but is there
> >> any one else that should be looking at this?
> > 
> > If you can't catch attention of Al Viro, then Jens Axboe is sometimes
> > merging direct IO fixes as well through his tree. Added to CC. If that
> > doesn't work out, I can also take the changes through my tree and send them
> > to Linus in a separate pull request...
> 
> For this case, probably best if you take it, Jan. I looked over the
> patches and they look good to me, feel free to add:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Ok, I'll pull them into my tree. Thanks for review Jens!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
