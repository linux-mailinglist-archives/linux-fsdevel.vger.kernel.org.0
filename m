Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF81073D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKVOHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 09:07:30 -0500
Received: from verein.lst.de ([213.95.11.211]:52175 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVOH3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:07:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 82C3E68C4E; Fri, 22 Nov 2019 15:07:27 +0100 (CET)
Date:   Fri, 22 Nov 2019 15:07:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, sandeen@sandeen.net
Subject: Re: [PATCH 1/5] fs: Enable bmap() function to properly return
 errors
Message-ID: <20191122140727.GA26654@lst.de>
References: <20191122085320.124560-1-cmaiolino@redhat.com> <20191122085320.124560-2-cmaiolino@redhat.com> <20191122133701.GA25822@lst.de> <20191122140257.vd2lytosz7y2xqr4@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122140257.vd2lytosz7y2xqr4@orion>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> 
> Yeah, I forgot to move the changelogs under --- while formatting the patches, I
> didn't mean to send them on the commit log.
> 
> This signed-off-by was meant to be a reviewed-by? I'm not sure if I got what you
> meant with the sign-off here.

Yes, sorry.  Same for any other patch in case I messed that up.
