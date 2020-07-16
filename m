Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58C8222414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGPNi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:38:57 -0400
Received: from verein.lst.de ([213.95.11.211]:34717 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgGPNi4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:38:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D936868BEB; Thu, 16 Jul 2020 15:38:53 +0200 (CEST)
Date:   Thu, 16 Jul 2020 15:38:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neil@brown.name>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/23] md: rewrite md_setup_drive to avoid ioctls
Message-ID: <20200716133853.GA18326@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-10-hch@lst.de> <87365sxrqe.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87365sxrqe.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:50:49AM +1000, NeilBrown wrote:
> I'd be more comfortable if you added something like
> 	if (WARN(bdev->bd_disk->fops != md_fops,
>                  "Opening block device %x resulted in non-md device\"))
>                 return;
> here.  However even without that
> 
> Reviewed-by: NeilBrown <neilb@suse.de>

Ok, I've added that.
