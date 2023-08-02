Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F576D7C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHBTbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHBTbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4617123;
        Wed,  2 Aug 2023 12:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E2D61943;
        Wed,  2 Aug 2023 19:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19E6C433C8;
        Wed,  2 Aug 2023 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691004710;
        bh=YeFBxSvKGH9CU1xslMg3sZ8WizlwWRb1yiMkUBF/SGE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GX7DW2rFOjsVHKypyeuvlt6jXoJ1jJitQ6nFBCwHwrf9qMdKVMKwyRT2dzwv1fkZM
         CHbKTNPpEMp/DXsvr2y/SrYTRzF/rR/iEQEmAaBY6RexWouABnPj0QQeYqJHDhynig
         MAPT9D3VFTPnT07rsWH+H0mosI7weQ9swJn/nG19wWLcxC6sKDm8i4iaPECHYJksJU
         4YFkVXbF4Wy7jLNOh+q/oUlFVZ4qtAwYSY2Ol3cignbGn0qwsKCGKNKXnNCkfQoqmh
         QGez2kGTMjI+9OYTc1F18e8MyO6MuSVHxf2MI6wwc4yHy/jERrJwvHRlwuDXEYxLyj
         aScjxdwrdHuCw==
Date:   Wed, 2 Aug 2023 12:31:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     corbet@lwn.net, Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        amir73il@gmail.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCHSET 0/3] xfs: maintainer transition for 6.6
Message-ID: <20230802193150.GD11352@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:58:15PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> I do not choose to continue as maintainer.

It seems I have to clarify my previous message.  I'm stepping down as XFS
maintainer.  I'm /continuing/ as a senior developer and reviewer for XFS.

I've really enjoyed my work developing XFS and bringing new online
capabilities to the filesystem.  I've struggled with the role of
maintainer for many years though, as it's impossible for one person to
do all the things that are expected of a maintainer.

I recognize that some of the stress I've put on myself, by trying to
ensure that every patch has a Reviewed-By, and I'm usually the one who
has to do that review.  It hasn't been fair.

I'm excited to continue development on XFS, and am leaving the
maintainership in capable hands.  I'm /very/ excited about online
repair, as part 2 is almost complete and ready to be sent out!

Thanks Chandan!

--D

> 
> My final act as maintainer is to write down every thing that I've been
> doing as maintainer for the past six years.  There are too many demands
> placed on the maintainer, and the only way to fix this is to delegate
> the responsibilities.  I also wrote down my impressions of the unwritten
> rules about how to contribute to XFS.
> 
> The patchset concludes with my nomination for a new release manager to
> keep things running in the interim.  Testing and triage; community
> management; and LTS maintenance are all open positions.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D
> ---
>  Documentation/filesystems/index.rst                |    1 
>  .../filesystems/xfs-maintainer-entry-profile.rst   |  192 ++++++++++++++++++++
>  .../maintainer/maintainer-entry-profile.rst        |    1 
>  MAINTAINERS                                        |    4 
>  4 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/filesystems/xfs-maintainer-entry-profile.rst
> 
