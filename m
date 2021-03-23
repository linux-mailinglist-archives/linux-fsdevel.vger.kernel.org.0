Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D735B346370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCWPvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 11:51:25 -0400
Received: from verein.lst.de ([213.95.11.211]:32946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232806AbhCWPvG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:51:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E20AE68B02; Tue, 23 Mar 2021 16:51:03 +0100 (CET)
Date:   Tue, 23 Mar 2021 16:51:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     chris.chiu@canonical.com
Cc:     viro@zeniv.linux.org.uk, hch@lst.de, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: clear GD_NEED_PART_SCAN later in
 bdev_disk_changed
Message-ID: <20210323155103.GA12791@lst.de>
References: <20210323085219.24428-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323085219.24428-1-chris.chiu@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
