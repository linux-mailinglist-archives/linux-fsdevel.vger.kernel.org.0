Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28083AAE37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFQH7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 03:59:55 -0400
Received: from verein.lst.de ([213.95.11.211]:57666 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFQH7z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:59:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB49668C4E; Thu, 17 Jun 2021 09:57:45 +0200 (CEST)
Date:   Thu, 17 Jun 2021 09:57:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] pstore/blk: Include zone in pstore_device_info
Message-ID: <20210617075745.GC899@lst.de>
References: <20210616164043.1221861-1-keescook@chromium.org> <20210616164043.1221861-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616164043.1221861-6-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:40:43AM -0700, Kees Cook wrote:
> Information was redundant between struct pstore_zone_info and struct
> pstore_device_info. Use struct pstore_zone_info, with member name "zone".
> 
> Additionally untangle the logic for the "best effort" block device
> instance.

I'd still prefer to kill off struct pstore_device_info, but this is
already a huge improvement:

Reviewed-by: Christoph Hellwig <hch@lst.de>
