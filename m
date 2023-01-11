Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95CE66511F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 02:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjAKBdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 20:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAKBdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:33:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E75FA1;
        Tue, 10 Jan 2023 17:33:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A75D1619BD;
        Wed, 11 Jan 2023 01:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B58C433D2;
        Wed, 11 Jan 2023 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673400828;
        bh=6QUoJAQNC1uVecfsm5vFY6CFv07nGqtUpgbp0uvkPxI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=clKktXjT5b4SZywaz+PmhHCCKHtePWX8NXSdTGO+ISyRDPwTyhdeEAw3M1veBWSOZ
         F+004FVNSll9tJDHA4u+IrON2HSuUDG1fArCV+Yw7Jczi9bFQ2KDVgPNzTq8Bu+0QM
         o1J89fl2Hk/e+IgeuLpv82/sXjjTDRDnElS1JYmYV9UbNIHYO+q4lNz3+O4RdwCiWl
         jMiZVoXD1FjmOxC4JOvrfmweeHXrnLR5wTV3MDjY2AlFK7sTy4UszL653bG80SK7Vv
         4kcSAmJmArygRhH6LaCtkEDCvIMYgLEGttjmYfCLKSaFHGgwpoiKm3vSUE5dS8KaMm
         de4SUrs9bo5qg==
Message-ID: <b38ad39f0572f31d27479f04bf085bd678887dc2.camel@kernel.org>
Subject: Re: [PATCH] fs: remove locks_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 10 Jan 2023 20:33:45 -0500
In-Reply-To: <Y7375Zo5pE7g4P4H@ZenIV>
References: <20230110104501.11722-1-jlayton@kernel.org>
         <Y7375Zo5pE7g4P4H@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-01-10 at 23:59 +0000, Al Viro wrote:
> On Tue, Jan 10, 2023 at 05:44:59AM -0500, Jeff Layton wrote:
> > locks_inode was turned into a wrapper around file_inode in de2a4a501e71
> > (Partially revert "locks: fix file locking on overlayfs"). Finish
> > replacing locks_inode invocations everywhere with file_inode.
>=20
> Looks good to me.  Which tree do you want that to go through?

I'll take it via the file locking tree, if that's ok. Let me know if
you'd rather pick it up though.
--=20
Jeff Layton <jlayton@kernel.org>
