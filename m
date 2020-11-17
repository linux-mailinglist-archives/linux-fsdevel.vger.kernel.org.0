Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C892B6DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgKQSxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 13:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgKQSxU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:53:20 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACCC924199;
        Tue, 17 Nov 2020 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605639200;
        bh=oOfml8XNbcpuAFTYEYouX3wjSebLzC0EbBcqdMG0evQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/lhA7NhkxdXRpkr9r4LzAXwXv5c8gii8rE5PpYq7CcAPe5OzkV6aNvC+Hw/NHJYK
         aoaoWzXqxUykv/E4wx6bzZ0QOHyWYoOMSn5ZwXKX3poseARTLGZTA7BEu8zOZ0dNLv
         8ePryzPsKPyW6e7s8YJ2JZhusbFugsu1L36m5IHs=
Date:   Tue, 17 Nov 2020 10:53:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/3] Add support for Encryption and Casefolding in F2FS
Message-ID: <X7QcHmarXZOgfjzz@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117040315.28548-1-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:03:12AM +0000, Daniel Rosenberg wrote:
> I've included one ext4 patch from the previous set since it isn't in the f2fs
> branch, but is needed for the fscrypt changes.

Note that this is no longer the case, as this ext4 patch was merged in 5.10
(commit f8f4acb6cded: "ext4: use generic casefolding support").

- Eric
