Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE72422681
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhJEM3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 08:29:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbhJEM3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:29:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 054E220020;
        Tue,  5 Oct 2021 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633436866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjGOU28aseIxzbgxmKKGBf+lfKA8napnrkp1mk29VtE=;
        b=Bzpre7weOsXJ/u0YLszAyXJT5NP2OpWOG4HD0n3NXs9HPxWb/XUtF8fVLg5+g0fPQL7LIJ
        J+ePJ6f5kRNWYMjcrWW79ogSqTmH18OMCLxa5kV7b9ZPYN+22E9C2nckip1BhlQLaiO4EX
        QPHzankMnoMtHNaLmhKTwWqqdxyCKDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633436866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjGOU28aseIxzbgxmKKGBf+lfKA8napnrkp1mk29VtE=;
        b=JcXixsvED2f4ufImevKRnrpIhO7jiSyFefYaC+44w0N5Nf8Va0GlAZnYmtiF0is3Ufq1tf
        FDf4ReDNhB2Fa1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2EE113C50;
        Tue,  5 Oct 2021 12:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aGXfKsFEXGHXawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 12:27:45 +0000
Message-ID: <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
Date:   Tue, 5 Oct 2021 14:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/5/21 13:09, Michal Hocko wrote:
> On Tue 05-10-21 11:20:51, Vlastimil Babka wrote:
> [...]
>> > --- a/include/linux/gfp.h
>> > +++ b/include/linux/gfp.h
>> > @@ -209,7 +209,11 @@ struct vm_area_struct;
>> >   * used only when there is no reasonable failure policy) but it is
>> >   * definitely preferable to use the flag rather than opencode endless
>> >   * loop around allocator.
>> > - * Using this flag for costly allocations is _highly_ discouraged.
>> > + * Use of this flag may lead to deadlocks if locks are held which would
>> > + * be needed for memory reclaim, write-back, or the timely exit of a
>> > + * process killed by the OOM-killer.  Dropping any locks not absolutely
>> > + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
>> > + * Using this flag for costly allocations (order>1) is _highly_ discouraged.
>> 
>> We define costly as 3, not 1. But sure it's best to avoid even order>0 for
>> __GFP_NOFAIL. Advising order>1 seems arbitrary though?
> 
> This is not completely arbitrary. We have a warning for any higher order
> allocation.
> rmqueue:
> 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

Oh, I missed that.

> I do agree that "Using this flag for higher order allocations is
> _highly_ discouraged.

Well, with the warning in place this is effectively forbidden, not just
discouraged.

>> >   */
>> >  #define __GFP_IO	((__force gfp_t)___GFP_IO)
>> >  #define __GFP_FS	((__force gfp_t)___GFP_FS)
>> > 
>> > 
>> > 
> 

