Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF754C8438
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 07:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiCAGmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 01:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiCAGmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:42:01 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0F0583B1;
        Mon, 28 Feb 2022 22:41:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2216f2HF022120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Mar 2022 01:41:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 646DC15C0038; Tue,  1 Mar 2022 01:41:02 -0500 (EST)
Date:   Tue, 1 Mar 2022 01:41:02 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gary Gunthorpe <jgg@nvidia.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] FOLL_PIN + file systems
Message-ID: <Yh2//uwOCPNVZPKB@mit.edu>
References: <c6e152ad-2b31-48cd-3d5e-c109d24a0e79@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e152ad-2b31-48cd-3d5e-c109d24a0e79@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:47:47PM -0800, John Hubbard wrote:
> By the time we meet for LSF/MM/BPF in May, the Direct IO layer will
> likely be converted to use FOLL_PIN page pinning (that is, changed from
> using get_user_pages_fast(), to pin_user_pages_fast()).
> 
> Direct IO conversion to FOLL_PIN was the last missing piece, and so the
> time is right to discuss how to use the output of all of this work
> (which is: the ability to call page_maybe_dma_pinned()), in order to fix
> one of the original problems that prompted FOLL_PIN's creation.
> 
> That problem is: file systems do not currently tolerate having their
> pages pinned and DMA'd to/from. See [1] for an extensive background of
> some 11 LWN articles since 2018.
> ....
> 
> I'll volunteer to present a few slides to provide the background and get
> the discussion started. It's critical to have filesystem people in
> attendance for this, such as Jan Kara, Dave Chinner, Christoph Hellwig,
> and many more that I won't try to list explicitly here. RDMA
> representation (Jason Gunthorpe, Leon Romanovsky, Chaitanya Kulkarni,
> and others) will help keep the file system folks from creating rules
> that break them "too much". And of course -mm folks. There are many
> people who have contributed to this project, so again, apologies for not
> listing everyone explicitly.

I'd definitely be interested in participating in this discussion,
following up on some e-mail threads that we've had on this subject.

Unfortunately a number of file system folks are listed above may not
be able to attend, so I really hope we can figure out some way to
allow remote participation for those people who aren't able to travel
due to various reasons, including corporate policies surrounding COVID.

       	       			  	    	     - Ted
