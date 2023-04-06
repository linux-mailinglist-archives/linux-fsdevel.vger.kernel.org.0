Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082BE6D90CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjDFHt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 03:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjDFHtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AED76A8;
        Thu,  6 Apr 2023 00:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D831364326;
        Thu,  6 Apr 2023 07:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1181EC4339B;
        Thu,  6 Apr 2023 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680767385;
        bh=pTJhI0yYRUJs1O41yQd/6bUEgjshxHgncrhB1vlecdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAhfc4qyWpox4NKl5KD86A0woLYnAOrmbRQOd+PYUYu43R9gg7aGMqkCgZf4rnHCu
         uRTwRbmpWp7edAjl7OaDWJJbgwII6Vg/nQKY6n48zMqJco/rm3oeQgxF3w9u7F4r+o
         WMc4oRL+nS8ct8pb6td8z82WPa2T25ISVgk0lAgR+gI/E7iB3Unyo6wbkaRbiHWcV1
         SxdQZyQoD5kTRKn+xVTbmkP9JC2IFMDdRlTRjftT/88hgan6tOwNTbNNSZmkLuKYua
         KQbKP0fJQ/oEyrWrRXCt6aBk0Qys+dzuNYBHAuVM3eUMae9pHCSKjInMsvTr0h93MA
         2TfIbDOtSAGLQ==
Date:   Thu, 6 Apr 2023 09:49:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
Message-ID: <20230406-amputation-eiern-a55f52bbf32c@brauner>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-5-zlang@kernel.org>
 <20230405-idolisieren-sperren-3c7042b9ed1f@brauner>
 <20230406050228.5ujhuamrqqdjqu77@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230406050228.5ujhuamrqqdjqu77@zlang-mailbox>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 01:02:28PM +0800, Zorro Lang wrote:
> On Wed, Apr 05, 2023 at 09:47:55AM +0200, Christian Brauner wrote:
> > On Wed, Apr 05, 2023 at 01:14:10AM +0800, Zorro Lang wrote:
> > > Some people contribute to someone specific fs testing mostly, record
> > > some of them as Reviewer.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > > 
> > > If someone doesn't want to be in cc list of related fstests patch, please
> > > reply this email, I'll remove that reviewer line.
> > > 
> > > Or if someone else (who contribute to fstests very much) would like to a
> > > specific reviewer, nominate yourself to get a review.
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  MAINTAINERS | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 620368cb..0ad12a38 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -108,6 +108,7 @@ Maintainers List
> > >  	  or reviewer or co-maintainer can be in cc list.
> > >  
> > >  BTRFS
> > > +R:	Filipe Manana <fdmanana@suse.com>
> > >  L:	linux-btrfs@vger.kernel.org
> > >  S:	Supported
> > >  F:	tests/btrfs/
> > > @@ -137,16 +138,19 @@ F:	tests/f2fs/
> > >  F:	common/f2fs
> > >  
> > >  FSVERITY
> > > +R:	Eric Biggers <ebiggers@google.com>
> > >  L:	fsverity@lists.linux.dev
> > >  S:	Supported
> > >  F:	common/verity
> > >  
> > >  FSCRYPT
> > > +R:	Eric Biggers <ebiggers@google.com>
> > >  L:      linux-fscrypt@vger.kernel.org
> > >  S:	Supported
> > >  F:	common/encrypt
> > >  
> > >  FS-IDMAPPED
> > 
> > I'd just make this VFS since src/vfs/ covers generic vfs functionality.
> > 
> > But up to you,
> 
> Sure, it can be "VFS". I didn't use "VFS" directly due to vfs is larger, current
> src/vfs only tests a small part of it, more tests are under tests/generic directory.
> And we don't have many vfs tests, e.g. we don't test new mount API in fstests.
> 
> We need a way to sort out "VFS" only files/tests (e.g. group tag), and if we use
> "VFS" at here, would you like to be a reviewer of all vfs tests?

Sure, I can try and help.
