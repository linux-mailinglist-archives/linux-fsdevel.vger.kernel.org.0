Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26625F4023
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 06:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKHFvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 00:51:54 -0500
Received: from verein.lst.de ([213.95.11.211]:33002 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfKHFvy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:51:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F34868BE1; Fri,  8 Nov 2019 06:51:51 +0100 (CET)
Date:   Fri, 8 Nov 2019 06:51:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_bmap should check iomap_apply return value
Message-ID: <20191108055151.GA30144@lst.de>
References: <20191107025927.GA6219@magnolia> <20191107083050.GB9802@lst.de> <20191107153617.GB6219@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107153617.GB6219@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 07, 2019 at 07:36:17AM -0800, Darrick J. Wong wrote:
> On Thu, Nov 07, 2019 at 09:30:50AM +0100, Christoph Hellwig wrote:
> > On Wed, Nov 06, 2019 at 06:59:27PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > 
> > > Check the return value of iomap_apply and return 0 (i.e. error) if it
> > > didn't succeed.
> > 
> > And how could we set the bno value if we didn't succeed?
> 
> The iomap_bmap caller supplies an ->iomap_end that returns an error.
> 
> Granted there's only one caller and it doesn't, so we could dump this
> patch and just tell Coverity to shut up, but it's odd that this is the
> one place where we ignore the return value.
> 
> OTOH it's bmap which has been broken for ages; the more insane behavior
> seen in the wild, the better to scare away users. :P

Oh well.  I guess the patch is fine, it just isn't really needed as-is.

Reviewed-by: Christoph Hellwig <hch@lst.de>
