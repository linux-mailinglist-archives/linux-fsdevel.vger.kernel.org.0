Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6987A762F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfICVaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:30:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47681 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbfICVaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:30:46 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x83LUUn0009589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 17:30:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3341E42049E; Tue,  3 Sep 2019 17:30:30 -0400 (EDT)
Date:   Tue, 3 Sep 2019 17:30:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903213030.GE2899@mit.edu>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903135024.GA8274@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:50:24AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 02:48:32PM +0100, Al Viro wrote:
> > Not sure what would be the best way to do it...  I don't mind breaking
> > the out-of-tree modules, whatever their license is; what I would rather
> > avoid is _quiet_ breaking of such.
> 
> Any out of tree module running against an upstream kernel will need
> a recompile for a new version anyway.  So I would not worry about it
> at all.

I'm really confused.  What out-of-tree module are people needing to
use when doing linux-next testing?   That seems like a recipe for disaster...

    	       		  	     	  	- Ted
