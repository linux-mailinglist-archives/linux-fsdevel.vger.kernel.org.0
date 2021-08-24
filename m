Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9303F5CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhHXLSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 07:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231980AbhHXLSK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 282FE6120A;
        Tue, 24 Aug 2021 11:17:22 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:17:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/6] fs/ntfs3: Remove unnecesarry remount flag handling
Message-ID: <20210824111720.jzg2cf32ag54dibk@wittgenstein>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-3-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-3-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:26:29AM +0300, Kari Argillander wrote:
> Remove unnecesarry remount flag handling. This does not do anything for
> this driver. We have already set SB_NODIRATIME when we fill super. Also
> noatime should be set from mount option. Now for some reson we try to
> set it when remounting.
> 
> Lazytime part looks like it is copied from f2fs and there is own mount
> parameter for it. That is why they use it. We do not set lazytime
> anywhere in our code. So basically this just blocks lazytime when
> remounting.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---

Sounds good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
