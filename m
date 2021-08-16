Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317943ED3C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhHPMSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 08:18:53 -0400
Received: from verein.lst.de ([213.95.11.211]:54198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhHPMSw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:18:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA9DB68AFE; Mon, 16 Aug 2021 14:18:18 +0200 (CEST)
Date:   Mon, 16 Aug 2021 14:18:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 2/4] fs/ntfs3: Remove unnecesarry mount option
 noatime
Message-ID: <20210816121818.GB16815@lst.de>
References: <20210816024703.107251-1-kari.argillander@gmail.com> <20210816024703.107251-3-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816024703.107251-3-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:47:01AM +0300, Kari Argillander wrote:
> Remove unnecesarry mount option noatime because this will be handled
> by VFS. Our function ntfs_parse_param will never get opt like
> this.

Looks good, but I'd move this to the front of your series.
