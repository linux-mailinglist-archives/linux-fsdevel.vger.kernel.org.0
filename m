Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3314E872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAaFby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:31:54 -0500
Received: from verein.lst.de ([213.95.11.211]:43031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgAaFbx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:31:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7890468B20; Fri, 31 Jan 2020 06:31:50 +0100 (CET)
Date:   Fri, 31 Jan 2020 06:31:50 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200131053150.GB17457@lst.de>
References: <20200117222212.GP8904@ZenIV.linux.org.uk> <20200117235444.GC295250@vader> <20200118004738.GQ8904@ZenIV.linux.org.uk> <20200118011734.GD295250@vader> <20200118022032.GR8904@ZenIV.linux.org.uk> <20200121230521.GA394361@vader> <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com> <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk> <2173869.1580222138@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2173869.1580222138@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:35:38PM +0000, David Howells wrote:
> I'm using direct I/O, so I'm assuming I don't need to fsync().

Direct I/O of course requires fsync.  What makes you think different?
