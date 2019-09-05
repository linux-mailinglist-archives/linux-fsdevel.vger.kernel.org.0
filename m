Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930ADAA90B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfIEQdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:33:11 -0400
Received: from verein.lst.de ([213.95.11.211]:50188 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbfIEQdK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:33:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2E0468BE1; Thu,  5 Sep 2019 18:33:07 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:33:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 14/15] btrfs: update inode size during bio completion
Message-ID: <20190905163307.GF22450@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-15-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-15-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:06:49AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Update the inode size for dio writes during bio completion.
> This ties the success of the underlying block layer
> whether to increase the size of the inode. Especially for
> in aio cases.

Doesn't this belong into the patch adding the new direct I/O code?
Or did the old code get this wrong and this is an additional bug
fix?
