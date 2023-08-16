Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A2177E97E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbjHPTQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbjHPTP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F652701;
        Wed, 16 Aug 2023 12:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E86F625CE;
        Wed, 16 Aug 2023 19:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380DC433C7;
        Wed, 16 Aug 2023 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692213355;
        bh=72YlqPhkOdrbhyCp3YFbVRU56Qy6DgtXMIcnpb3LfUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmUg4WZvE56CBBpixX0YhC43+TGzHWtj8Ly1JmOeeef/GO/dl9RPsvAZOIT9anLlT
         Xuo/FYNFQMw/6UmVgLhevpIIVmaUzLxnF8YTTw0NMDvSSfjVTjWHGHIZbRoUnhaHXu
         dvGmt8QFVClqfUHcGS/ifXY+JgPBgDq6OOOlBP+U=
Date:   Wed, 16 Aug 2023 21:15:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget
Message-ID: <2023081621-mosaic-untwist-a786@gregkh>
References: <20230813055948.12513-1-ghandatmanas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813055948.12513-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:29:49AM +0530, Manas Ghandat wrote:
> Currently there is not check for ni->itype.compressed.block_size when
> a->data.non_resident.compression_unit is present and NInoSparse(ni) is
> true. Added the required check to calculation of block size.
> 
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
> Fix-commit-ID: upstream f40ddce88593482919761f74910f42f4b84c004b

What is this last tag for?  That's a kernel release version, what can be
done with that?

confused,

greg k-h
