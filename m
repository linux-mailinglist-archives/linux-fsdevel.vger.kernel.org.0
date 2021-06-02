Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555153993D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhFBTtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 15:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBTtx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 806BE60C40;
        Wed,  2 Jun 2021 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622663289;
        bh=tdHgSjjfMfZFgIVHsQ8gh3hvYxrNPsXVpFVsD8TzOlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/eVCwHW8Ctr3xN1Ano0nvP8T7+5v/P2n7/2xaXzz/qkrBmIDLx1AAOU3IKdjVJNF
         q7gYz6VrcI3B4ypfSVcxYe/c4zq8jfhgYToPprPHcXQ2dx1lfvHFTnjwcDDpY8nT0E
         E2QiUBNLmdPDbCPs1xLgP4tD11nDVVNYUAtODECS10wAa1YnWw2bE4vAXc1o4JYjY3
         ea3XNfH0LuN8CdTnDceKqiO2ara1BEUT9FTTV1/5Pe+qvU6ssJ+WIQW+jyzzWA0dvJ
         ROWi8zB6GLxpYIoYAlDVg9dojEyKGvbGn0UXvYbQeIj8hox1uorDE0UJrL+KGCpC2j
         M7hcss8F4VDgA==
Date:   Wed, 2 Jun 2021 12:48:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH] ext4: Correct encrypted_casefold sysfs entry
Message-ID: <YLfgeDOhEA4borYZ@sol.localdomain>
References: <20210602040100.121327-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602040100.121327-1-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:01:00AM +0000, Daniel Rosenberg wrote:
> Encrypted casefolding is only supported when both encryption and
> casefolding are both enabled in the config.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Looks good, but please include Fixes and Cc stable tags.

- Eric
