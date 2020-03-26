Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13B119370C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 04:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZDcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 23:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbgCZDcQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:32:16 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A16420714;
        Thu, 26 Mar 2020 03:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585193535;
        bh=H8MDjdXMw4UeC+MDo5AJWCDIbLhr8JiIlIAwI10Z+3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdxCTCnYYLrmrKMHD7/C7aC7RtVoeokIKBRmSJcTFqfSg9L9He24K/ah36MPQA3J8
         hNdqhPOPnhM8LjHvJeo+1gCJB8VLyKZxaHrhIfFzALZHKEGtdbRmyD29DexWUDhKHI
         7oPVsvCKfts7FBULpKTEy/kFk+tw/RlESgcqi/y0=
Date:   Wed, 25 Mar 2020 20:32:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 00/11] Inline Encryption Support
Message-ID: <20200326033214.GA858@sol.localdomain>
References: <20200326030702.223233-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:06:51PM -0700, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to the block layer,
> UFS, fscrypt, f2fs and ext4.
> 

This patch series can also be retrieved from

        Repo: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
        Tag: inline-encryption-v9

I based it on v5.6-rc2 (same base commit as v7 and v8) since it still applies
cleanly to it.  You can see what changed from v8 by:

        git diff inline-encryption-v8..inline-encryption-v9

or from v7 by:

        git diff inline-encryption-v7..inline-encryption-v9

- Eric
