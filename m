Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB23993ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFBTxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 15:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhFBTxJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20799613E9;
        Wed,  2 Jun 2021 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622663486;
        bh=WoUDHWRbujn0Iki89pXBJOyg67xP8j8eBWAryTISx14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkeskjhFXgCj3qznXkc6hBjg5T8VZdEt6t26XftS9IahPA1BnbTfA6XyD+EtvqJFt
         zGTM5ZKVyAavV6Gzw0uuQtbAD3N/8L/dqBtUoaANVqqAwAA+4V2N42HWcfWmOzDxeN
         Qchde7eZziwuwyo4wovfbL6CyjoLt9mXwOafdEBfh+ZFOdueuQCBrypm0G3IgBkIx2
         G6moGaN0lSckBmHU5CDeN3x5p9UZ3jCbEPGRY9q+jNXmNwM4G0fPhWMAZspuFOoelt
         ye4j/K32EIVC1mJp+y9S3/c5047UaWa5JYySABHfQFJ1ueIHg7gkXXEgPfsvw6t3gu
         j6paMNQ0eymHw==
Date:   Wed, 2 Jun 2021 12:51:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] f2fs: Show casefolding support only when supported
Message-ID: <YLfhPBI0DmEfkC+B@sol.localdomain>
References: <20210602041539.123097-1-drosen@google.com>
 <20210602041539.123097-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602041539.123097-2-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:15:38AM +0000, Daniel Rosenberg wrote:
> The casefolding feature is only supported when CONFIG_UNICODE is set.
> This modifies the feature list f2fs presents under sysfs accordingly.
> 
> Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Can you add a Cc stable tag?

- Eric
