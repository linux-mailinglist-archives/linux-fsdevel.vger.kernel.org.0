Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852A435599A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbhDFQvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 12:51:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35093 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244338AbhDFQvD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:51:03 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 136GomPx031788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Apr 2021 12:50:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9266C15C3B0C; Tue,  6 Apr 2021 12:50:48 -0400 (EDT)
Date:   Tue, 6 Apr 2021 12:50:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fs: Hole punch vs page cache filling races
Message-ID: <YGyRaOgCBP5zdLzz@mit.edu>
References: <20210120160611.26853-1-jack@suse.cz>
 <YGdxtbun4bT/Mko4@mit.edu>
 <20210406121702.GB19407@quack2.suse.cz>
 <YGyQKEamNgszxE+d@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyQKEamNgszxE+d@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:45:28PM -0400, Theodore Ts'o wrote:
> 
> Hmm, I wonder if it somehow got hit by the vger.kernel.org
> instabilities a while back?  As near as I can tell your v2 patches
> never were received by:
> 
> 	http://patchwork.ozlabs.org/project/linux-ext4/
> 
> (There are no ext4 patches on patchwork.ozlabs.org on February 8th,
> although I do see patches hitting patchwork on February 7th and 9th.)

I just noticed that the V2 patches were only sent to linux-fsdevel and
not cc'ed to linux-ext4.  So that explains why I didn't see it on
patchwork.  :-)

						- Ted
