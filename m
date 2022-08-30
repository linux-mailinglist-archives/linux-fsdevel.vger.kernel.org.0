Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA88F5A7049
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiH3WCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiH3WBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:01:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454E79C526;
        Tue, 30 Aug 2022 14:57:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27ULutcM017607
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 17:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1661896617; bh=e6ECjud0RvU+17l0f8ers2t/ZahEM9K2CEQ8DVNTkhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=n12BuM4kMIcAtdJ+mN0a3TcF7JAtsz6qkzrCHycY9C77IPBuP1QeuTx3F9IxiXtS/
         Jf2UdxXOl4lWg8ti1rY/0refzzBzhzHOjyb/N3zV6gEsUbz8wmQcei1H5id9mKQMdP
         DkswDdUi97sFdw/8zYV6uRLvoPbtiJn4RUPb6uJqbdeo6txLWhpYA5DAEfGY1w24Jw
         Rk4iO+p39tkxHRDwj1HLmvhfxv3b8/GuGfmCQbEZ0y/p1FAk7hIB1BDNPSG20e2q4e
         kkw9FDKLA4tSlJvloxDEzePU47rxkLRagsyRDdR0ZEyp4QlgzBTOEm9R3pTLlizQ1X
         uXoI07k5kUPbg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5303315C3434; Tue, 30 Aug 2022 17:56:55 -0400 (EDT)
Date:   Tue, 30 Aug 2022 17:56:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH] Documentation: filesystems: correct possessive "its"
Message-ID: <Yw6Hp8l/7p3wbiGq@mit.edu>
References: <20220829235429.17902-1-rdunlap@infradead.org>
 <Yw56rVwBRg0LbC41@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw56rVwBRg0LbC41@ZenIV>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:01:33PM +0100, Al Viro wrote:
> On Mon, Aug 29, 2022 at 04:54:29PM -0700, Randy Dunlap wrote:
> >  compress_log_size=%u	 Support configuring compress cluster size, the size will
> > -			 be 4KB * (1 << %u), 16KB is minimum size, also it's
> > +			 be 4KB * (1 << %u), 16KB is minimum size, also its
> >  			 default size.
> 
> That one doesn't look like possesive to me - more like "default size is 16KB and
> values below that are not allowed"...

That being said, it could also be rewritten to be easier to
understand.  e.g., "The default and minimum size is 16kb."

	     	   		    	    	 - Ted




