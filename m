Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FA8E0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 00:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfHNWh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 18:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNWh3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:37:29 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5380A208C2;
        Wed, 14 Aug 2019 22:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565822247;
        bh=zZu436fUH/jVRbuBikAqFWcrS6iRdnYyiGm2WREqNhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kd+k8Kc/rEbGv/TrtNBMq15M+vYNbAt/FTQ+D0vmw7cYxvFayrGWgFSLnSnlbLdnn
         c7ZNIKcI1QJjSXqgnA9fVIOBWcef8YR0lm1z6vtXFe0kH+LJGNkdiwYmd0p4/fCjAe
         +BraiOijhZifnnC1UtWKoYgFI6mf0uxQ304q3m0o=
Date:   Wed, 14 Aug 2019 15:37:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH v8 00/20] fscrypt: key management improvements
Message-ID: <20190814223725.GF101319@gmail.com>
Mail-Followup-To: linux-fscrypt@vger.kernel.org,
        Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
References: <20190805162521.90882-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805162521.90882-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:25:01AM -0700, Eric Biggers wrote:
> Hello,
> 
> [Note: I'd like to apply this for v5.4.  Additional review is greatly
>  appreciated, especially of the API before it's set in stone.  Thanks!]
> 
> This patchset makes major improvements to how keys are added, removed,
> and derived in fscrypt, aka ext4/f2fs/ubifs encryption.  It does this by
> adding new ioctls that add and remove encryption keys directly to/from
> the filesystem, and by adding a new encryption policy version ("v2")
> where the user-provided keys are only used as input to HKDF-SHA512 and
> are identified by their cryptographic hash.
> 
> All new APIs and all cryptosystem changes are documented in
> Documentation/filesystems/fscrypt.rst.  Userspace can use the new key
> management ioctls with existing encrypted directories, but migrating to
> v2 encryption policies is needed for the full benefits.
> 

I've applied this patchset to the fscrypt tree for 5.4.

- Eric
