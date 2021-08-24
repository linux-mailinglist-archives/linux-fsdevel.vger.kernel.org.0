Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C83F598F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhHXIAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 04:00:14 -0400
Received: from verein.lst.de ([213.95.11.211]:50658 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234954AbhHXIAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:00:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 757AD67373; Tue, 24 Aug 2021 09:59:28 +0200 (CEST)
Date:   Tue, 24 Aug 2021 09:59:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 2/6] fs/ntfs3: Remove unnecesarry remount flag
 handling
Message-ID: <20210824075928.GB26733@lst.de>
References: <20210819002633.689831-1-kari.argillander@gmail.com> <20210819002633.689831-3-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-3-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
