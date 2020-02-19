Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C491164FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 21:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgBSUbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 15:31:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:36458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSUbO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:31:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20D97AF8C;
        Wed, 19 Feb 2020 20:31:13 +0000 (UTC)
Date:   Wed, 19 Feb 2020 14:31:09 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH] iomap: return partial I/O count on error in direct I/O
Message-ID: <20200219203109.scjjfat5kw4uaadj@fiona>
References: <20200213192503.17267-1-rgoldwyn@suse.de>
 <20200217131752.GA14490@infradead.org>
 <20200217134417.bxdw4yex5ky44p57@fiona>
 <20200217140250.GA21246@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217140250.GA21246@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  6:02 17/02, Christoph Hellwig wrote:
> On Mon, Feb 17, 2020 at 07:44:17AM -0600, Goldwyn Rodrigues wrote:
> > > Haven't we traditionally failed direct I/O syscalls that don't fully
> > > complete and never supported short writes (or reads)?
> > 
> > Yes, but I think that decision should be with the filesystem what to do
> > with it and not the iomap layer.
> 
> But then you also need to fix up the existing callers to do the
> conversion.

The error returned is set in iomap_dio_complete() which happens after.
I checked all instances and the the only place which uses
written in direct I/O is ext4. I will put in the change.

Thanks!

-- 
Goldwyn
