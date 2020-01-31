Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F080714E870
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgAaFaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:30:00 -0500
Received: from verein.lst.de ([213.95.11.211]:43019 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgAaF37 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:29:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFEA068B20; Fri, 31 Jan 2020 06:29:56 +0100 (CET)
Date:   Fri, 31 Jan 2020 06:29:56 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200131052956.GA17457@lst.de>
References: <20200118011734.GD295250@vader> <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader> <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com> <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk> <20200123071639.GA7216@dread.disaster.area> <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com> <20200124212546.GC7216@dread.disaster.area> <20200131052454.GA6868@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131052454.GA6868@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:24:54PM -0800, Darrick J. Wong wrote:
> Or the grumpy maintainer who will have to digest all of this.
> 
> Can we update the documentation to admit that many people will probably
> want to use this (and rename) as atomic swap operations?
> 
> "The filesystem will commit the data and metadata of all files and
> directories involved in the link operation to stable storage before the
> call returns."

That sounds horrible, because it is so different from any other metadata
operation.  Maybe requiring fsync to stabilize metadata ops wasn't the
best idea ever, but having some varinats of linkat behave from others
is just stupid.  We've been beating the fact that you shall fsync into
peoples heads for years.  No reason to make an exception for an obscure
operation now.
