Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E816B1B2CD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgDUQi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 12:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUQi6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:38:58 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A821206D5;
        Tue, 21 Apr 2020 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587487137;
        bh=Z+iXSNoxMMh6k0ZZ96p69jLyHmPAVJrD+POZJQ+L2rQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RgIYok+CEJ2RoIptu0si1PEi+Dz3iNTBreOTnCK4qOY2Zlz4c30hmoKV4g7WOrONM
         +VkKUdzNGq+l49INAs5Azf1Lt0hf7GAsQcMJBClcHJ22jyu1kGqQz+ogcdwgRM59pL
         mEvnkxoNGYoA56ewNidm70NrDcOT+kHeMwXM30Go=
Date:   Tue, 21 Apr 2020 18:38:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/34] docs: filesystems: rename path-lookup.txt file
Message-ID: <20200421183852.133b3a09@coco.lan>
In-Reply-To: <20200416020006.GC816@sol.localdomain>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
        <ddee231f968fcf8a9558ff39f251fdd7b2357ff2.1586960617.git.mchehab+huawei@kernel.org>
        <20200416020006.GC816@sol.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Wed, 15 Apr 2020 19:00:06 -0700
Eric Biggers <ebiggers@kernel.org> escreveu:

> On Wed, Apr 15, 2020 at 04:32:35PM +0200, Mauro Carvalho Chehab wrote:
> > There are two files called "patch-lookup", with different contents:
> > one is a ReST file, the other one is the text.
> > 
> > As we'll be finishing the conversion of filesystem documents,
> > let's fist rename the text one, in order to avoid messing with
> > the existing ReST file.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../filesystems/{path-lookup.txt => path-walking.txt}       | 0
> >  Documentation/filesystems/porting.rst                       | 2 +-
> >  fs/dcache.c                                                 | 6 +++---
> >  fs/namei.c                                                  | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> >  rename Documentation/filesystems/{path-lookup.txt => path-walking.txt} (100%)  
> 
> Wouldn't it make more sense to consolidate path-lookup.rst and path-lookup.txt
> into one file?  The .txt one is less detailed and hasn't been updated since
> 2011, so maybe it should just be deleted?  Perhaps there's something useful in
> it that should be salvaged, though.

I'll keep this (and the next patch) on a separate branch. I'll try to take
a look on it later and see if I can help checking if there are something
there still useful, merging at path-lookup.rst.

Thanks,
Mauro
