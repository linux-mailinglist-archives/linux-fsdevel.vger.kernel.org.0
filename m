Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1B67C685
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 10:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbjAZJB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 04:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbjAZJB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:01:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E883EE;
        Thu, 26 Jan 2023 01:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16739B81CB7;
        Thu, 26 Jan 2023 09:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82744C433EF;
        Thu, 26 Jan 2023 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674723712;
        bh=wBnjmjQh2vLWg8ruFlIrkQaOOJ5szfKc3c80Hf2YGls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6+mNiTYoKjZFk6ChDgw205RkAxTiEvA918Ls9UD8TNdXbePY+8N3GLlKJMTUBSLr
         YZjf5zenz8WVg00G+oVRwOU9dA+bGq9oMZ1fTip1CU6qzW98y/CmmJFGBpsHShBfOc
         h8YfW/f41aIOXqCaQcvohOiD+SNpO4L3U/3OrF8DV4pvZZqQBh8yvxi5vVaEdDE15b
         zMZgiApO0O2YyQhIs8Nh5ibDULjBiW8wtEf5y0cMkQv+y/PlzBrcU4DtHTZGp+Pxro
         VeyjuNCyVX+f70635HUBJhgvwWBF+a/Hwh2TRqlfB7v2RtbKEcTOzLTg+Llgexc4fy
         cNfCZVp+AUmSg==
Date:   Thu, 26 Jan 2023 10:01:44 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Subject: Re: [PATCH v8 RESEND 2/8] fs: clarify when the i_version counter
 must be updated
Message-ID: <20230126090144.elcyprja23wmgcit@wittgenstein>
References: <20230124193025.185781-1-jlayton@kernel.org>
 <20230124193025.185781-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124193025.185781-3-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:30:19PM -0500, Jeff Layton wrote:
> The i_version field in the kernel has had different semantics over
> the decades, but NFSv4 has certain expectations. Update the comments
> in iversion.h to describe when the i_version must change.
> 
> Cc: Colin Walters <walters@verbum.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
