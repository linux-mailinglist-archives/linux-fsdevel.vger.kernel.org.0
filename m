Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8983D2957D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 07:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507865AbgJVFTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 01:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437018AbgJVFTR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:19:17 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3542145D;
        Thu, 22 Oct 2020 05:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603343956;
        bh=AzJmVMo5bUTZn0rWFhmYbe4LLj90dDUn7CorUzcxEE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A45eiXQDEQHZSU3qpky+Lib6UIb+r/i7Io8YwYs0B0N0wtY8+fW9CC7zasD5z/b2U
         hLnwSi4FiSS8IbbXeQQOlDtvQeaIQag0rD+cH27MlkejR2+1g9Ba37jC/kDL51fLnx
         sVHVYhNITgwH/G+25LRO9jR5TzzqWxN4Xdz4bb2M=
Date:   Wed, 21 Oct 2020 22:19:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [RESEND PATCH v18 0/4] overlayfs override_creds=off & nested get
 xattr fix
Message-ID: <20201022051914.GI857@sol.localdomain>
References: <20201021151903.652827-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021151903.652827-1-salyzyn@android.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 08:18:59AM -0700, Mark Salyzyn wrote:
> Mark Salyzyn (3):
>   Add flags option to get xattr method paired to __vfs_getxattr
>   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>   overlayfs: override_creds=off option bypass creator_cred
> 
> Mark Salyzyn + John Stultz (1):
>   overlayfs: inode_owner_or_capable called during execv
> 
> The first three patches address fundamental security issues that should
> be solved regardless of the override_creds=off feature.
> 
> The fourth adds the feature depends on these other fixes.

FYI, I didn't receive patch 4, and neither https://lkml.kernel.org/linux-fsdevel
nor https://lkml.kernel.org/linux-unionfs have it either.

- Eric
