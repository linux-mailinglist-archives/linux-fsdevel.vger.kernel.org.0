Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C879B42D83D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJNLed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 07:34:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhJNLec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:34:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9EA0C2198B;
        Thu, 14 Oct 2021 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634211146;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RwKkctM2kYfnsQns9zuzmOBOyPsbRBTF9oUmtbr7Ms=;
        b=dpiQAn/loFlbz4yWiqf186W/BaqzQq9wvfy5P7pQQ1YrtwhY4ufluqbf2MexpVoslqCG8e
        MnM3sydeHKUdJc1AbzfqBMzsGW6Ly1Sg+PmPpNgdc7AyB5L6z7/AA6K8BPr3qyzHz+iPBb
        TP9uHMHgprnT9qOl8YvF76iMrdiV2+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634211146;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RwKkctM2kYfnsQns9zuzmOBOyPsbRBTF9oUmtbr7Ms=;
        b=8EZMvlC6qiw4OcFd+TAafSCyudqB11qMFpd0Qesz9Y+PPuSVxGlI/40rwudPGqcnOs/NrS
        swhsaH/NDSrcMhBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7593FA3B81;
        Thu, 14 Oct 2021 11:32:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CAC6DDA7A3; Thu, 14 Oct 2021 13:32:01 +0200 (CEST)
Date:   Thu, 14 Oct 2021 13:32:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Message-ID: <20211014113201.GA19582@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>
 <20211008223649.GJ54211@dread.disaster.area>
 <YWQmsESyyiea0zle@dhcp22.suse.cz>
 <20211013023231.GV2361455@dread.disaster.area>
 <YWaYUsXgXS6GXM+M@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWaYUsXgXS6GXM+M@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 10:26:58AM +0200, Michal Hocko wrote:
> > crap like this (found in btrfs):
> > 
> >                 /*                                                               
> >                  * We're holding a transaction handle, so use a NOFS memory      
> >                  * allocation context to avoid deadlock if reclaim happens.      
> >                  */                                                              
> >                 nofs_flag = memalloc_nofs_save();                                
> >                 value = kmalloc(size, GFP_KERNEL);                               
> >                 memalloc_nofs_restore(nofs_flag);                                
> 
> Yes this looks wrong indeed! If I were to review such a code I would ask
> why the scope cannot match the transaction handle context. IIRC jbd does
> that.

Adding the transaction start/end as the NOFS scope is a long term plan
and going on for years, because it's not a change we would need in
btrfs, but rather a favor to MM to switch away from "GFP_NOFS everywhere
because it's easy".

The first step was to convert the easy cases. Almost all safe cases
switching GFP_NOFS to GFP_KERNEL have happened. Another step is to
convert GFP_NOFS to memalloc_nofs_save/GFP_KERNEL/memalloc_nofs_restore
in contexts where we know we'd rely on the transaction NOFS scope in the
future. Once this is implemented, the memalloc_nofs_* calls are deleted
and it works as expected.  Now you may argue that the switch could be
changing GFP_NOFS to GFP_KERNEL at that time but that is not that easy
to review or reason about in the whole transaction context in all
allocations.

This leads to code that was found in __btrfs_set_acl and called crap
or wrong, because perhaps the background and the bigger plan is not
immediately obvious. I hope the explanation above it puts it to the
right perspective.

The other class of scoped NOFS protection is around vmalloc-based
allocations but that's for a different reason, would be solved by the
same transaction start/end conversion as well.

I'm working on that from time to time but this usually gets pushed down
in the todo list. It's changing a lot of code, from what I've researched
so far cannot be done at once and would probably introduce bugs hard to
hit because of the external conditions (allocator, system load, ...).

I have a plan to do that incrementally, adding assertions and converting
functions in small batches to be able to catch bugs early, but I'm not
exactly thrilled to start such endeavour in addition to normal
development bug hunting.

To get things moving again, I've refreshed the patch adding stubs and
will try to find the best timing for merg to avoid patch conflicts, but
no promises.
