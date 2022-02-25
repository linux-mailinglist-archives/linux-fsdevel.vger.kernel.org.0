Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C572A4C5056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 22:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiBYVJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiBYVJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:09:18 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDBD19AA;
        Fri, 25 Feb 2022 13:08:44 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21PL8MKV003913
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 16:08:23 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8655815C0038; Fri, 25 Feb 2022 16:08:22 -0500 (EST)
Date:   Fri, 25 Feb 2022 16:08:22 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] ext4: don't BUG if kernel subsystems dirty pages
 without asking ext4 first
Message-ID: <YhlFRoJ3OdYMIh44@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <Yhks88tO3Em/G370@mit.edu>
 <YhlBUCi9O30szf6l@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhlBUCi9O30szf6l@sol.localdomain>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:51:28PM -0800, Eric Biggers wrote:
> > 
> > [1] https://www.spinics.net/lists/linux-mm/msg142700.html
> 
> Can you use a lore link
> (https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/T/#u)?

Sure, thanks for finding the lore link!  I did try searching for it
last night, but for some reason I wasn't able to surface it.

> > +			/*
> > +			 * Should never happen but for buggy code in
> > +			 * other subsystemsa that call
> 
> subsystemsa => subsystems

Already fixed in my local version of the patch.

> > +			 * [1] https://www.spinics.net/lists/linux-mm/msg142700.html
> 
> Likewise, lore link here.

Ack.

						- Ted
