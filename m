Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7FE47CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408030AbfJYJuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 05:50:08 -0400
Received: from verein.lst.de ([213.95.11.211]:50264 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407918AbfJYJuI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:50:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 652C168AFE; Fri, 25 Oct 2019 11:50:05 +0200 (CEST)
Date:   Fri, 25 Oct 2019 11:50:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: add generic UNRESVSP and ZERO_RANGE ioctl
 handlers
Message-ID: <20191025095005.GA9613@lst.de>
References: <20191025023609.22295-1-hch@lst.de> <20191025023609.22295-3-hch@lst.de> <20191025054452.GF913374@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025054452.GF913374@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:44:52PM -0700, Darrick J. Wong wrote:
> >  	case XFS_IOC_FREESP:
> > -	case XFS_IOC_UNRESVSP:
> >  	case XFS_IOC_ALLOCSP64:
> > -	case XFS_IOC_FREESP64:
> > -	case XFS_IOC_UNRESVSP64:
> > -	case XFS_IOC_ZERO_RANGE: {
> > +	case XFS_IOC_FREESP64: {
> 
> Ok, so this hoists everything to the vfs except for ALLOCSP and FREESP,
> which seems to be ... "set new size; allocate between old and new EOF if
> appropriate"?
> 
> I'm asking because I was never really clear on what those things are
> supposed to do. :)

Yes. ALLOCSP/FREESP have so weird semantics that we never added the
equivalent functionality to fallocate.
