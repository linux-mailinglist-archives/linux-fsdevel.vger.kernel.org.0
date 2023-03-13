Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9678E6B7975
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCMNuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 09:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCMNuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679123D925;
        Mon, 13 Mar 2023 06:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2438612C4;
        Mon, 13 Mar 2023 13:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B980C433EF;
        Mon, 13 Mar 2023 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715450;
        bh=jjJBYyK32CZD3TPJIaHH1R48sBMGIt3Gh69XgbPzF+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXNm8dO4zSw95Y1eqX7WiMNNJpt90pENduYu3bsaPePbuEU2tJgoCzs1WpuyVQc8X
         D/UjtyTCp58NlEA1YCl7g0FUvJ7jHOQOumZA+EbKayp7DtPajlOl7xmd27klpNEIA5
         J80/K/DPwMXRXPw05gLS6g61yZnypdMFHZHzFFJwLGSea4GRL/bPJ5YFT6Y5A/3WvS
         wSqS52BWIrjK37OpvOk4+mL1OmgOt5zb3bEwLXWU4iz7HnDGjAsBM214NAaUl+x8ha
         3OGcUGTL+1c2Ig8lCTta68par9R+eyTs6xr75HewNc/HmDIKgXMJiAgHELzoMjbeSW
         PKiO+Fdu4wb1w==
Date:   Mon, 13 Mar 2023 14:50:45 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     corbet@lwn.net, Eric Biggers <ebiggers@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: filesystems: vfs: actualize struct
 super_operations description
Message-ID: <20230313135045.diycgwbwzxvnnjub@wittgenstein>
References: <20230313130718.253708-1-aleksandr.mikhalitsyn@canonical.com>
 <20230313130718.253708-3-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230313130718.253708-3-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:07:18PM +0100, Alexander Mikhalitsyn wrote:
> Added/updated descriptions for super_operations:
> - free_inode method
> - evict_inode method
> - freeze_super/thaw_super method
> - show_{devname,path,stats} procfs-related methods
> - get_dquots method
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
