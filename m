Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939F8A5B7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfIBQnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 12:43:35 -0400
Received: from verein.lst.de ([213.95.11.211]:51602 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfIBQnf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:43:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8EAE868AFE; Mon,  2 Sep 2019 18:43:31 +0200 (CEST)
Date:   Mon, 2 Sep 2019 18:43:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, david@fromorbit.com,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v3 0/15] Btrfs iomap
Message-ID: <20190902164331.GE6263@lst.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901200836.14959-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 03:08:21PM -0500, Goldwyn Rodrigues wrote:
> This is an effort to use iomap for btrfs. This would keep most
> responsibility of page handling during writes in iomap code, hence
> code reduction. For CoW support, changes are needed in iomap code
> to make sure we perform a copy before the write.
> This is in line with the discussion we had during adding dax support in
> btrfs.

This looks pretty good modulo a few comments.

Can you please convert the XFS code to use your two iomaps for COW
approach as well to validate it?

Also the iomap_file_dirty helper would really benefit from using the
two iomaps, any chance you could look into improving it to use your
new infrastructure?
