Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A75502C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfFXHIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:08:06 -0400
Received: from verein.lst.de ([213.95.11.211]:52929 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfFXHIG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:08:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0254F68B02; Mon, 24 Jun 2019 09:07:35 +0200 (CEST)
Date:   Mon, 24 Jun 2019 09:07:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, david@fromorbit.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190624070734.GB3675@lst.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de> <20190621192828.28900-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621192828.28900-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfs will need to be updated to fill in the additional iomap for the
COW case.  Has this series been tested on xfs?

I can't say I'm a huge fan of this two iomaps in one method call
approach.  I always though two separate iomap iterations would be nicer,
but compared to that even the older hack with just the additional
src_addr seems a little better.
