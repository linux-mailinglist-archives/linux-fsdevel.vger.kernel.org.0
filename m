Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19928355981
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 18:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhDFQp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 12:45:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34016 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232310AbhDFQp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:45:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 136GjSce029433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Apr 2021 12:45:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3057815C3B0C; Tue,  6 Apr 2021 12:45:28 -0400 (EDT)
Date:   Tue, 6 Apr 2021 12:45:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Message-ID: <YGyQKEamNgszxE+d@mit.edu>
References: <20210120160611.26853-1-jack@suse.cz>
 <YGdxtbun4bT/Mko4@mit.edu>
 <20210406121702.GB19407@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406121702.GB19407@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 02:17:02PM +0200, Jan Kara wrote:
> 
> Note that I did post v2 here:
> 
> https://lore.kernel.org/linux-fsdevel/20210208163918.7871-1-jack@suse.cz/
> 
> It didn't get much comments though. I guess I'll rebase the series, include
> the explanations I've added in my reply to Dave and resend.

Hmm, I wonder if it somehow got hit by the vger.kernel.org
instabilities a while back?  As near as I can tell your v2 patches
never were received by:

	http://patchwork.ozlabs.org/project/linux-ext4/

(There are no ext4 patches on patchwork.ozlabs.org on February 8th,
although I do see patches hitting patchwork on February 7th and 9th.)

Resending sounds like a plan.  :-)

	      	  	  	  	       - Ted
