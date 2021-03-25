Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62141349A21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCYTYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCYTY0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:24:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF6A61A14;
        Thu, 25 Mar 2021 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616700265;
        bh=v2b29AUs3Bj/0T+rnMHy1+6cbej0x22tQEJGkL//C2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKekDYOHQGkQrJyiIor6517Zyy72wryWiMa63GsFEKRAmvlFTHCyND4FYrVxI9E2s
         5WcmtWrMrq55/IEN/Fj1e7sF5TD9Y8+m6Ch1TonvaNjWx09asB+b8Kor3DBqkVs/3S
         pR1mRJ8GJcr7QfJ9psJ3KWDHoTOCA/p5QIMiKLjhpmNle9BnDRt7ivFuMheGSbVkfl
         QzBLEgzYJmPhmekTUOovHtpywzqvAVo7eOrIQa8Ew13NlqF7hTJnWUyDyd1Lh2dLFB
         NPYdg73QaAmle3YLwj/1pycssLmnLZWeqoxTO2ELxeBvpjJe4o7x9C6irGJvniqDXF
         KlFcvoHbXjHEw==
Date:   Thu, 25 Mar 2021 12:24:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v4 3/5] fs: unicode: Rename function names from utf8 to
 unicode
Message-ID: <YFzjZ7u31PtAB9vQ@sol.localdomain>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-4-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325000811.1379641-4-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:38:09AM +0530, Shreeya Patel wrote:
> Rename the function names from utf8 to unicode for taking the first step
> towards the transformation of utf8-core file into the unicode subsystem
> layer file.
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Can you add some more explanation about why this change is beneficial?  The
functions still seem tied to UTF-8 specifically.

- Eric
