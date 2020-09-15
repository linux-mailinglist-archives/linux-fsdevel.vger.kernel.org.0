Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA615269A46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgIOAP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgIOAP2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:15:28 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD13208DB;
        Tue, 15 Sep 2020 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600128927;
        bh=JcWxn38ohkQ3HtrHwZ8STRWqx1OYN2z3yul87Nxi3dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POPszP+srYLBCONdOr6pW+IntY2HfuceSsNjVjR3E5pnoslQ9V4TtZFWi1qbpsXRm
         lqpv3YOW0mjYh51n11rgVwYjhFKLVb4DM8akbRNi3sUO/ji1h9ibuzskjkXou5FZIt
         LbHnJ/d3UJ7pD+YiC/P4hiIGVhgArRxC0wB0GOQA=
Date:   Mon, 14 Sep 2020 17:15:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 04/16] fscrypt: add fscrypt_context_for_new_inode
Message-ID: <20200915001526.GD899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-5-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:55PM -0400, Jeff Layton wrote:
>  	/*
>  	 * This may be the first time the inode number is available, so do any
> @@ -689,7 +711,6 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
>  
>  		fscrypt_hash_inode_number(ci, mk);
>  	}
> -
>  	return inode->i_sb->s_cop->set_context(inode, &ctx, ctxsize, fs_data);

Unnecessary whitespace change.

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index b547e1aabb00..a57d2a9869eb 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -148,6 +148,7 @@ int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
>  int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
>  int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
>  int fscrypt_set_context(struct inode *inode, void *fs_data);
> +int fscrypt_context_for_new_inode(void *ctx, struct inode *inode);

Please keep declarations in the same order as the definitions.
So, fscrypt_context_for_new_inode() before fscrypt_set_context().

- Eric
