Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98540400449
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 19:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbhICRte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 13:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhICRta (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:49:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8889360238;
        Fri,  3 Sep 2021 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630691309;
        bh=5KPQNzq7zcpnglX8kIXWMwgMGHFOk9mDXLUwIbAoveg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNzRIazyWLOCZLPXzW1GyQ/x+AXDbP3d5l4QGBGzRtReQrMW4G+MLh58XouNGQ6Ib
         opu8Z+jKPa8gRN8NoW7K1DcVp/9TLtOXlit+r8FOYelutpwNRkKwjKpJamBv/1uob6
         4PXY0o9xEaPeh3Li/ClPazwXgd35+bZqTrVlNbNNCy1jX0WoFCmKprYwPYpWmt1KQq
         t9ZGVCWJmuS765N9XSkCsMw7hRK1dcTZe5NTVDkllZfommMQFuV1G10AyHZl7IpoBx
         wdzpXlb5iUIdHfkuqjBoVrcEdRVzqHy5tF2xy9MS0nczjOtIr6eDTQ0d7NUrHzZhO+
         EtiXbDpvP5ivA==
Date:   Fri, 3 Sep 2021 10:48:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Szabolcs Szakacsits <szaka@tuxera.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: NTFS testing (was: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YTJf4lBjnliqhI4D@sol.localdomain>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
 <alpine.DEB.2.20.2109030047330.23375@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2109030047330.23375@tuxera.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 03, 2021 at 01:09:40AM +0300, Szabolcs Szakacsits wrote:
> User space drivers can have major disadvantages for certain workloads 
> however how relevant are those for NTFS users? Most people use NTFS for 
> file transfers in which case ntfs-3g read and write speed is about 15-20% 
> less compared to ext4. For example in some quick tests ext4 read was 
> 3.4 GB/s versus ntfs-3g 2.8 GB/s, and write was 1.3 GB/s versus 1.1 GB/s.

Your company's own advertising materials promoting your proprietary NTFS driver
(https://www.tuxera.com/products/tuxera-ntfs-embedded) claim that NTFS-3G is
much slower than ext4:

	Read:
		NTFS-3G: 63.4 MB/s
		ext4: 113.8 MB/s
		"Microsoft NTFS by Tuxera": 116 MB/s

	Write:
		NTFS-3G: 16.3 MB/s
		ext4: 92.4 MB/s
		"Microsoft NTFS by Tuxera": 113.3 MB/s

I'm not sure why anything you say should have any credibility when it
contradicts what your company says elsewhere, and your company has a vested
interest in not having proper NTFS support upstreamed to compete with their
proprietary driver.  (Note that Tuxera doesn't provide much support for NTFS-3G;
most of their efforts are focused on their proprietary driver.)

- Eric
