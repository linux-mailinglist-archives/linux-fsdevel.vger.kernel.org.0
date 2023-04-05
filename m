Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF66D75DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 09:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjDEHtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 03:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjDEHtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E446AE;
        Wed,  5 Apr 2023 00:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3663A63960;
        Wed,  5 Apr 2023 07:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895D0C433D2;
        Wed,  5 Apr 2023 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680680979;
        bh=Weq5xIt7NaRy390+BxKr0DPL+Sx0J9wKSXtMC/5JUh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5Flc0M5e8GB39z9f8BFJ5ebxS8y3KvMmKQItlraREhf8AkpnxMWHlz+JXp8p7uI1
         Kljlt0scTB58bQpEmq4GK+eEA+W3BOPA5cN1xWCrA68FuXwrY3GmcIErMd7I6tygyc
         V9JzsMXQMyO0n9SdIkQE39mGNJMhI4Juz/LKaq5zFFseVa5v/r1CJgL8buDMvRme/M
         V60YaWT3OGRM2C3c4p9BXErpUiMxTPWmcEsEkzEZBNsBmiLmJeuYqKxc6IXyHEJcg/
         oPvvLtbmc/+Gs5xXnYjOU/toIg6/1FGapaFmAgQB8BCmWBhC4ZrbJ8UgmFtFOJlHgF
         qh4BFYcRworMg==
Date:   Wed, 5 Apr 2023 09:49:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, amir73il@gmail.com, djwong@kernel.org,
        anand.jain@oracle.com
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Message-ID: <20230405-bazillus-nanotechnologie-a8cf619d8454@brauner>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> The fstests supports different kind of fs testing, better to cc
> specific fs mailing list for specific fs testing, to get better
> reviewing points. So record these mailing lists and files related
> with them in MAINTAINERS file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> If someone mailing list doesn't want to be in cc list of related fstests
> patch, please reply this email, I'll remove that line.
> 
> Or if I missed someone mailing list, please feel free to tell me.
> 
> Thanks,
> Zorro
> 
>  MAINTAINERS | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09b1a5a3..620368cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -107,6 +107,83 @@ Maintainers List
>  	  should send patch to fstests@ at least. Other relevant mailing list
>  	  or reviewer or co-maintainer can be in cc list.
>  
> +BTRFS
> +L:	linux-btrfs@vger.kernel.org
> +S:	Supported
> +F:	tests/btrfs/
> +F:	common/btrfs
> +
> +CEPH
> +L:	ceph-devel@vger.kernel.org
> +S:	Supported
> +F:	tests/ceph/
> +F:	common/ceph
> +
> +CIFS
> +L:	linux-cifs@vger.kernel.org
> +S:	Supported
> +F:	tests/cifs
> +
> +EXT4
> +L:	linux-ext4@vger.kernel.org
> +S:	Supported
> +F:	tests/ext4/
> +F:	common/ext4
> +
> +F2FS
> +L:	linux-f2fs-devel@lists.sourceforge.net
> +S:	Supported
> +F:	tests/f2fs/
> +F:	common/f2fs
> +
> +FSVERITY
> +L:	fsverity@lists.linux.dev
> +S:	Supported
> +F:	common/verity
> +
> +FSCRYPT
> +L:      linux-fscrypt@vger.kernel.org
> +S:	Supported
> +F:	common/encrypt
> +
> +FS-IDMAPPED
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Supported
> +F:	src/vfs/

Same suggestion as earlier, make that section VFS as it covers generic
functionality,

Acked-by: Christian Brauner <brauner@kernel.org>
