Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD066780C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 17:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjAWQDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 11:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjAWQDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:03:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A06B44E
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 08:03:33 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30NG37qq020715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674489790; bh=EXK4HWxguanCnWaNmAc/k1AK4Y+TRvhBmSc5HlQjr1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=R1G1eVOGPf/1/FfxMKdinpFWxmnEbeByNKdffGzYv1d9dDwHkBVllBw5+qZ+/URAH
         ANE7Gn6sj0qTdB+zw0HwWAXsjBGQA7c+TdG0ahlTg0KHzYPmySBZhSRSXF8QAB0yBT
         WrLSn8OZ+lbrqJ4Ry4zDkksFdDgSXarD/SnvnN8Z70dlWjf0Hge1MEn/YBjujK1jPB
         AobCGEJYbMeLXGdGuD4h2+Yoar4sM5Oh0iNUzOTtqJ7JMwNbfqW4tCVTtqvEG4Co2e
         9VaIofVsMC0py0BPctcMkS7SN8P6NIbhuGcYe3vfJ12mcycC2ETOKBnHoB7b7gY+Y7
         GorBla5yEsVIg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6F63415C469B; Mon, 23 Jan 2023 11:03:07 -0500 (EST)
Date:   Mon, 23 Jan 2023 11:03:07 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] gfs2 writepage fix
Message-ID: <Y86vu2WSGWCHpdJL@mit.edu>
References: <20230122090115.1563753-1-agruenba@redhat.com>
 <CAHk-=wgjMNbNG0FMatHtmzEZPj0ZmQpNRsnRvH47igJoC9TBww@mail.gmail.com>
 <20230123100556.qxdjdmcms5ven52v@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123100556.qxdjdmcms5ven52v@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:05:56AM +0100, Jan Kara wrote:
> Thanks for the heads up. So we had kind of a similar issue for ext4 but it
> got caught by Ted during his regression runs so we've basically done what
> GFS2 is doing for the merge window and now there's patchset pending to
> convert the data=journal path as well because as Andreas states in his
> changelog of the revert that's a bit more tricky. But at least for ext4
> the conversion of data=journal path resulted in much cleaner and shorter
> code.

https://thunk.org/tytso/images/firestarter-fs-development-without-testing.jpg

:-)

							- Ted
