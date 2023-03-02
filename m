Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051536A8864
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCBSPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCBSPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:15:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94BF3D0B3;
        Thu,  2 Mar 2023 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0pzEbyxWupYXQxPq+gfWm6Mh+nvCQI3qn0hiI+xWTE0=; b=aI4lo52aisyZ5SQbKxcbzGQIwB
        FzLQHnzciSWZCNOI8oePZ090FRnYOrOfojddDRSQoSUNlRzxvosJb5PRPD3I4TJxGcLvwK8qL9dje
        phDGvkkZgVlD3hWuypdVLgT1OugMaQgVSR+dbvFaeTGkeOmG94ybG+eYiwkT8rDPnAoFLIoI3Y2gb
        TaftRYdA351FtGVN0zu1GStcSSMp3LxI36qdnGQJDtF41n+SphTkXV2uSWE10NMdSLrCqYs0W0ZkH
        LOWpOUbr2R2HfiFjgcNLVkHHCfDYHA6Nx8TvuvATt5exNqpMuGApOaKPDo7OTJwVQd5TSznd0Zhza
        WvF1kSWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXnSF-00DN1a-2x;
        Thu, 02 Mar 2023 18:14:59 +0000
Date:   Thu, 2 Mar 2023 18:14:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] locks: avoid usage of list iterator after loop in
 generic_delete_lease()
Message-ID: <ZADno9G+y32cCl73@ZenIV>
References: <20230301-locks-avoid-iter-after-loop-v1-1-4d0529b03dc7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301-locks-avoid-iter-after-loop-v1-1-4d0529b03dc7@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:20:18PM +0100, Jakob Koschel wrote:
> 'victim' and 'fl' are ensured to be equal at this point. For consistency
> both should use the same variable.
> 
> Additionally, Linus proposed to avoid any use of the list iterator
> variable after the loop, in the attempt to move the list iterator
> variable declaration into the marcro to avoid any potential misuse after
> the loop [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>

Looks sane.  Jeff, which tree do you want that to go through?
