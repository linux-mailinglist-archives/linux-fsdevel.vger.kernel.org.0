Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66F63E4E70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhHIV0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 17:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhHIV0T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 893AB60EB9;
        Mon,  9 Aug 2021 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628544358;
        bh=OVk9UHdUYnGUAQ/9b5LQEesj/Z+2icrT45MDhBuum7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3zkEbpe3SR2ifocQzBNaNV4JTESvreRYDOITb5EhKP8EF1VxpwWoy+RBCTjiYmKG
         v1qC5xH3ZnW5mGznhtox5enskOXyHSnXgsen3YDz0BndDX9twm/bgcx4pfzEYCaSTN
         4XTcBM/zRN4/bJViHUON4w3GNQslKscKPWCGx7Q3xYbB4TUm3Wqi2t6+RAMDLGRuAN
         gRWcEfpioDK297C83BT0zf/omKPI/Lqh9aO/PfhsA5pH+7K1y0OV5zWmYsuYhYuCTk
         gmaJUaIsg0ijm4gpMEBQFUZBGw5V4pZFH6p1K+X46nz64ONI6umzfOUp2j44Pu+/X7
         AbZ/qMVdtS+AQ==
Received: by pali.im (Postfix)
        id 41BACC7C; Mon,  9 Aug 2021 23:25:56 +0200 (CEST)
Date:   Mon, 9 Aug 2021 23:25:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 02/20] hfsplus: Add iocharset= mount option as alias
 for nls=
Message-ID: <20210809212556.3ygj6atbc5ma642m@pali>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-3-pali@kernel.org>
 <20210809204921.3ovrnbtzywsui4pt@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809204921.3ovrnbtzywsui4pt@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 09 August 2021 23:49:21 Kari Argillander wrote:
> On Sun, Aug 08, 2021 at 06:24:35PM +0200, Pali Rohár wrote:
> > Other fs drivers are using iocharset= mount option for specifying charset.
> > So add it also for hfsplus and mark old nls= mount option as deprecated.
> 
> It would be good to also update Documentation/filesystems/hfsplus.rst.

Good point! I'm making a note.
