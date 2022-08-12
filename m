Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED532590D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiHLIVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:21:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F71BE1A;
        Fri, 12 Aug 2022 01:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CF3BB82251;
        Fri, 12 Aug 2022 08:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E563C433D7;
        Fri, 12 Aug 2022 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660292461;
        bh=uAdZ2mX9autS/TPR3fwjWPumvc0LXFJUv+fe7PHSj5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXGP1rYB3XPG3JK+tTB4qp9MTOdoPA+XUGl1ueCLJaBe7UQGhA4fk9gJpsUCOTR90
         GXEGs/Pr/rhCcgoW0Fz61plmIqrwiE0dCbtHTOvClIiHWKXYdpukSiVejlbYv+V/nR
         5y668gf1B2AiKQqBMgwZXTOmZ/S+CfjOhtbX6CYqZ2pHYSNriai3gmaC99TNTEKWgF
         SC6Z0TYJOgadBtiLWQS2EE4HHHaj240DZh8TZho9AKlKxoQDgMx5UmFSUJrQFPnTEt
         tyhYP2gLWArYX8S9nnLzbebo+Y7bgk+rXIAeqvAZWca1VvqKJpdptpv5BxJLDp8sH8
         f5a+hZ9T4a80A==
Date:   Fri, 12 Aug 2022 10:20:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/shmem: tmpfs fallocate use file_modified()
Message-ID: <20220812082056.2khjud7dme3yc6nn@wittgenstein>
References: <39c5e62-4896-7795-c0a0-f79c50d4909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39c5e62-4896-7795-c0a0-f79c50d4909@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:55:36PM -0700, Hugh Dickins wrote:
> 5.18 fixed the btrfs and ext4 fallocates to use file_modified(), as xfs
> was already doing, to drop privileges: and fstests generic/{683,684,688}
> expect this.  There's no need to argue over keep-size allocation (which
> could just update ctime): fix shmem_fallocate() to behave the same way.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
