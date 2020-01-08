Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3C11349D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgAHRwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 12:52:49 -0500
Received: from verein.lst.de ([213.95.11.211]:50493 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgAHRwt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:52:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6E5C68BFE; Wed,  8 Jan 2020 18:52:46 +0100 (CET)
Date:   Wed, 8 Jan 2020 18:52:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com
Subject: Re: [PATCH v9 04/13] exfat: add directory operations
Message-ID: <20200108175246.GB14009@lst.de>
References: <20200102082036.29643-1-namjae.jeon@samsung.com> <CGME20200102082402epcas1p22cdd763b3c72166c0a91f9ba8db6a9b8@epcas1p2.samsung.com> <20200102082036.29643-5-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-5-namjae.jeon@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:20:27PM +0800, Namjae Jeon wrote:
> This adds the implementation of directory operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
