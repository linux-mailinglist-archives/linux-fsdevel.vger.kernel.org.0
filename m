Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61874765B3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 20:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjG0SOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 14:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjG0SOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:14:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548130F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 11:14:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-115-64.bstnma.fios.verizon.net [173.48.115.64])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36RIDdNJ032404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 14:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690481621; bh=YhV95XsKE5ygKImXHE1eq93G7xXd76r7xSZbt1Eo2yM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Jk0wiFKtbRC5O3WJWjnZ2xh+xyCKHrTjzINuGBBeD8UVxpWB8GV44VbRpWwgLz0qo
         ejRW0dZrPurHOSBaYdlvb0JS1/cwU8SRMjF+jexEYelgK2JklChrQfMebrl044UnRW
         6q2UPLMYTpdTcFMbVAK4NvzHAyB4+sbOOdc4z5U7CWXEpf5w24hu5ziSqNy24pBphd
         mB2nr87xwE3PHYrVxZKzv0GIoJ86UlTyBu69wdfMBiSsGBgdeKDf7ydGLPtAM9Sxw4
         ilCU/kBrrs5nqJ+acgWcdOOF17qi7JfXWlGTOEpVJ0aHmFwy/b5ghndVr6hHp8pfbg
         jDoMewJBrFQMQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 30B1A15C04EF; Thu, 27 Jul 2023 14:13:39 -0400 (EDT)
Date:   Thu, 27 Jul 2023 14:13:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, ebiggers@kernel.org,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 0/7] Support negative dentries on case-insensitive
 ext4 and f2fs
Message-ID: <20230727181339.GH30264@mit.edu>
References: <20230727172843.20542-1-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727172843.20542-1-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:28:36PM -0400, Gabriel Krisman Bertazi wrote:
> This is the v4 of the negative dentry support on case-insensitive
> directories.  It doesn't have any functional changes from v1. It applies
> Eric's comments to bring the flags check closet together, improve the
> documentation and improve comments in the code.  I also relooked at the
> locks to ensure the inode read lock is indeed enough in the lookup_slow
> path.

Al, Christian, any thoughts or preferences for how we should handle
this patch series?  I'm willing to take it through the ext4 tree, but
since it has vfs, ext4, and f2fs changes (and the bulk of the changes
are in the vfs), perhaps it should go through the vfs tree?

Also, Christian, I notice one of the five VFS patches in the series
has your Reviewed-by tag, but not the others?  Is that because you
haven't had a chance to make a final determination on those patches,
or you have outstanding comments still to be addressed?

Cheers,

					- Ted
