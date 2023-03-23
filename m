Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4B6C6B2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCWOgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCWOgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:36:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAA12724
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:36:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEaMVT012103
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679582184; bh=2PSG6kT36CkBgT8ei5K71qzuiLAw9IbqghpRjidCjVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YNMEWSEK/bpf4wrXU9PCz+Cs9x578xeEeRj8/aSRvYm6/q1R41hDWeh9K35tdPW7t
         Xm6c7HPXVUm51FTDYw8Yjf486KHMGFN46uJfca8hUvxcxfyBiDB+47HL6adcWMEQPc
         IeUY9ouonFKpoSTBEqIoJ3qMNs7Nh2HFKvrb5h7LO8lTaPTLDyzW34DPiVRcX8laAp
         YU7kgko7ggR67GmhDalP3S874Yb5MnrIYsaEvocj+YKp+Y3Lo5GEffptlLiINroZ08
         nogJ9LbA9TGGgdleLsIecmmt5CaS6nPd4R8mlkgztJf8SCWgrajm3xs8onVrC5f3N6
         VEWYIXSsr69+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0EDD815C4279; Thu, 23 Mar 2023 10:36:22 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:36:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230323143622.GE136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-4-krisman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:45:59PM -0400, Gabriel Krisman Bertazi wrote:
> Introduce a dentry revalidation helper to be used by case-insensitive
> filesystems to check if it is safe to reuse a negative dentry.
> 
> A negative dentry is safe to be reused on a case-insensitive lookup if
> it was created during a case-insensitive lookup and this is not a lookup
> that will instantiate a dentry. If this is a creation lookup, we also
> need to make sure the name matches sensitively the name under lookup in
> order to assure the name preserving semantics.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
