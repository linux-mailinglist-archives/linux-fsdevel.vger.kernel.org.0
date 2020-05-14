Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F021B1D2687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 07:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgENFK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 01:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgENFKz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 01:10:55 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36449206D4;
        Thu, 14 May 2020 05:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589433055;
        bh=+7Nv0uff65CHEgSOICQgU3aX0Fv+NjHfAe+0Cmtlgvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwp8gJPPTHeKccZV7k1yrahp5FPT66Y2DslfqT+lmRhxMP08GBwTz6gcKkzO/spv5
         dhRVa4d1xmYyCiUYotjlwDl+6Yx1Cl63diCalWTluZtVzGJY6PAaIGGs0O5HxHccw8
         N7KmznuBnLJh5eiG0UuJOhCVU3xxHn0DpMuEAsGQ=
Date:   Wed, 13 May 2020 22:10:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 00/12] Inline Encryption Support
Message-ID: <20200514051053.GA14829@sol.localdomain>
References: <20200514003727.69001-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514003727.69001-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 12:37:15AM +0000, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to the block layer,
> UFS, fscrypt, f2fs and ext4. It has been rebased onto linux-block/for-next.
> 
> Note that the patches in this series for the block layer (i.e. patches 1,
> 2, 3, 4 and 5) can be applied independently of the subsequent patches in
> this series.

Thanks, the (small) changes from v12 look good.  As usual, I made this available
in git at:

        Repo: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
        Tag: inline-encryption-v13

Jens, do you have any feedback on this patchset?  Is there any chance at taking
the block layer part (patches 1-5) for 5.8?  That part needs to go upstream
first, since patches 6-12 depend on them.  Then patches 6-12 can go upstream via
the SCSI and fscrypt trees in the following release.

- Eric
