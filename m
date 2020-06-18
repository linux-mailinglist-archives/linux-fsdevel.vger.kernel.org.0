Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05FF1FFBDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgFRTfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 15:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRTfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:35:24 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B3D2070A;
        Thu, 18 Jun 2020 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592508924;
        bh=M6NwrIk8NEqDFtZ1LIjdjdGZVm45nmjh1JS/p9T1PV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0s/GzQDavX3Bi6wq70IJY7QVFsGQxpHsC7VUkp4Wov3iEMW2eBO/5ufyuBA9CWcZZ
         VmDjkfo9bWPEAzSAtHWLCHRv8Xq8RykzeAMnLnHKU8xAhOqdzC9pgUEI3g8QwibjVq
         dCB5TpvrgaFTipvY1DbgwEnKKvu6QpnQf6CeBHmo=
Date:   Thu, 18 Jun 2020 12:35:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Satya Tangirala <satyat@google.com>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] f2fs: add inline encryption support
Message-ID: <20200618193522.GD2957@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
 <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
 <20200618181357.GC2957@sol.localdomain>
 <20200618192804.GA139436@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618192804.GA139436@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:28:04PM -0700, Jaegeuk Kim wrote:
> > 
> > It would be helpful if there was an f2fs mount option to auto-enable compression
> > on all files (similar to how test_dummy_encryption auto-enables encryption on
> > all files) so that it could be tested more easily.
> 
> Eric, you can use "-o compress_extension=*".
> 

Okay, great!  This isn't mentioned in the documentation:

compress_extension=%s  Support adding specified extension, so that f2fs can enable
                       compression on those corresponding files, e.g. if all files
                       with '.ext' has high compression rate, we can set the '.ext'
                       on compression extension list and enable compression on
                       these file by default rather than to enable it via ioctl.
                       For other files, we can still enable compression via ioctl.
