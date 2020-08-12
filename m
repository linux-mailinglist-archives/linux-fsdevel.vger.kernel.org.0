Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2F2425DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHLHNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLHNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:13:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD679C06174A;
        Wed, 12 Aug 2020 00:13:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h21so776464qtp.11;
        Wed, 12 Aug 2020 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bR9Mjz2MSKMtLofIMu9kpQ50I2mmXBxYQjcRO1d1+ic=;
        b=ogAHVsF4k9826ncKgfwB3w8sOpUpmpiXTNlpo35rzCOauhsgsnM73jQwe4vzxlfAWX
         QK4fffGhMSN1vtu6O8mSD/ahDkeDP6Fw8sh5IH4cRZYY1pfuBucSmBQz4OJZFLVUHwbc
         Nx0ccsINFymGnfXfPX9cYLFHy7+IN2HfcSa0yHqBAaLgyVkFeQh/IdsxFCCE60C2Ka7F
         Ru3XxdkQO6M/UA3FjHpq/6tKklPtt/txLmiVIW/t7dhzbYIUdwA6vtXjc+WFXqlbULJi
         hIK9Hd9a1PSrX9Va4m5qNOLxWmvTcGayoGUE4Gn7WKdimONvqpmcrR2+PEZtsGMqiIzZ
         nKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bR9Mjz2MSKMtLofIMu9kpQ50I2mmXBxYQjcRO1d1+ic=;
        b=ZGWcKkd/5qej8TBB8O61cMbmS6OwtKVALWOy5cQ9JhCtKmel4m8n/ty/yWGFTcp6GY
         Ejd06tDax2zTWPgm68IfSKmxQk715mojfSGdbfJ49h/yVZHqHGwXAGTVeHtOztVOFiIw
         ZF30j9iwIAyX0ezLUV8CIWDHVx80U1yYYeLZo/wlhd3HWH0vBIezz2UwFKYLOvFtvvyT
         NIN/pJOWGvLtioRT1/VSaVrVC27ZP4RDp8OBDLEE7UVnXBYqCkxS7ibRcuUZ8K8Xtre7
         8BkYZsgZ4YaajYICqRNeVQEXtjYEyX/8tRl2vVyv4HyqroQG09icorYIggqieBHvhEae
         1bQw==
X-Gm-Message-State: AOAM530xBeel/NH8sif53n7lFWRhW0ky5BZeZs85Pch/Y+LQC1DlrbGV
        Qc6yGozYQnsTDjGDsmeb1aBCwJE=
X-Google-Smtp-Source: ABdhPJyFnUSYc7AaO6sSE9ipUyhn/r5BfcOVESM7CPj+qN7j9ms5xjUtBES05y1B4QalEADanzOhwQ==
X-Received: by 2002:ac8:3868:: with SMTP id r37mr4688956qtb.95.1597216389166;
        Wed, 12 Aug 2020 00:13:09 -0700 (PDT)
Received: from PWN (146-115-88-66.s3894.c3-0.sbo-ubr1.sbo.ma.cable.rcncustomer.com. [146.115.88.66])
        by smtp.gmail.com with ESMTPSA id i20sm1342859qka.17.2020.08.12.00.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:13:08 -0700 (PDT)
Date:   Wed, 12 Aug 2020 03:13:06 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812071306.GA869606@PWN>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812070827.GA1304640@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 09:08:27AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 12, 2020 at 02:55:56AM -0400, Peilin Ye wrote:
> > Prevent hfs_find_init() from dereferencing `tree` as NULL.
> > 
> > Reported-and-tested-by: syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > ---
> >  fs/hfs/bfind.c     | 3 +++
> >  fs/hfsplus/bfind.c | 3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> > index 4af318fbda77..880b7ea2c0fc 100644
> > --- a/fs/hfs/bfind.c
> > +++ b/fs/hfs/bfind.c
> > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
> >  {
> >  	void *ptr;
> >  
> > +	if (!tree)
> > +		return -EINVAL;
> > +
> >  	fd->tree = tree;
> >  	fd->bnode = NULL;
> >  	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index ca2ba8c9f82e..85bef3e44d7a 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
> >  {
> >  	void *ptr;
> >  
> > +	if (!tree)
> > +		return -EINVAL;
> > +
> 
> How can tree ever be NULL in these calls?  Shouldn't that be fixed as
> the root problem here?

I see, I will try to figure out what is going on with the reproducer.

Thank you,
Peilin Ye
