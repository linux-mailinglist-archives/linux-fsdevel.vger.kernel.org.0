Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9E6B749F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCMKtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCMKty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:49:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79361C599;
        Mon, 13 Mar 2023 03:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6889EB80FF2;
        Mon, 13 Mar 2023 10:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F278FC433EF;
        Mon, 13 Mar 2023 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678704591;
        bh=9U/kjd7zTlI0yizAc0Bt8URDZmzyKq6pw8WWfsEWtG0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fsq1h7AdwwyBfjr+IR9/PTZvY3GiBKh6u/mFNrzOHiYoVtB9ivND1hJK+ao8S0btK
         +CZkIyh0Xq2OxWCz35BDpkpDg98F4YIj7vKJBelt5nYyQMwnhlsZnZjtL6af9mFD7v
         6V+MyYHo1Ps9S/l2TsRLy2Sy6SSIdegaGaU9twGaUu5MOmhczA8dceCdqzOmc92Mg1
         sPbCczrT/ZCw0BsilSgzEhUAtPJR2068xRsq7U3cZHQIqUv60lFvAZlN0UqcGpK3X0
         8oO8fjS0gENgXa+9/OMJFKcwpmHg8tN4z3kYdQvnnC+8mCihdJoEk9mFIrXDUqyUKC
         E+nxW28qFYNdg==
Message-ID: <a8eddd8bd56e4ff07ece72fe736e155b3e34cbae.camel@kernel.org>
Subject: Re: nfs/lockd: simplify sysctl registration
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Mar 2023 06:49:48 -0400
In-Reply-To: <20230310225842.3946871-1-mcgrof@kernel.org>
References: <20230310225842.3946871-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-03-10 at 14:58 -0800, Luis Chamberlain wrote:
> This is just following the work of the same sysctl registration [0] I
> just emailed you patches for sunprc but for nfs and lockd.
>=20
> Feel free to pick up or let me know if you want me to take them through
> my tree. I haven't even finished compile testing all these yet, but they
> are pretty trivial.
>=20
> I'm just dropping netdev on this series as its purely nfs/lockd stuff.
>=20
> [0] https://lkml.kernel.org/r/20230310225236.3939443-1-mcgrof@kernel.org
>=20
> Luis Chamberlain (3):
>   lockd: simplify two-level sysctl registration for nlm_sysctls
>   nfs: simplify two-level sysctl registration for nfs4_cb_sysctls
>   nfs: simplify two-level sysctl registration for nfs_cb_sysctls
>=20
>  fs/lockd/svc.c      | 20 +-------------------
>  fs/nfs/nfs4sysctl.c | 21 ++-------------------
>  fs/nfs/sysctl.c     | 20 +-------------------
>  3 files changed, 4 insertions(+), 57 deletions(-)
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
