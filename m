Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB9188869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 15:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgCQO5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 10:57:47 -0400
Received: from verein.lst.de ([213.95.11.211]:60355 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgCQO5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:57:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 83CB168C65; Tue, 17 Mar 2020 15:57:44 +0100 (CET)
Date:   Tue, 17 Mar 2020 15:57:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: move the posix_acl_fix_xattr_{to_from}_user out of
 xattr code
Message-ID: <20200317145744.GA15941@lst.de>
References: <20200221173722.538788-1-hch@lst.de> <CAHc6FU5RM5c0dopuJmCEJmPkwM6TUy60xnSWRpH2qHdX09B1pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5RM5c0dopuJmCEJmPkwM6TUy60xnSWRpH2qHdX09B1pw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:42:50PM +0100, Andreas Gruenbacher wrote:
> Miklos,
> 
> On Fri, Feb 21, 2020 at 7:01 PM Christoph Hellwig <hch@lst.de> wrote:
> > There is no excuse to ever perform actions related to a specific handler
> > directly from the generic xattr code as we have handler that understand
> > the specific data in given attrs.  As a nice sideeffect this removes
> > tons of pointless boilerplate code.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> can you please review this change from an overlayfs point of view?

ping?
