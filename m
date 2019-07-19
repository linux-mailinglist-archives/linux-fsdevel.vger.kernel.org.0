Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDCC6ECB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 01:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfGSX31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 19:29:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40436 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfGSX30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:29:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so15092169pgj.7;
        Fri, 19 Jul 2019 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xFsjVUh1cYKg3P3r+idJqwHGzAbhITKYp8eFdRNC/aY=;
        b=Z5SBZdPFzpc3Hh5RiYul07BoZeRKMi22eWvoTF8aS5WRfmUaDBkej7recw8anPJ3L4
         YL9TWXO6eFlVFb9Lu2dlaYT0hPiARNTTKsjUciQNiCPcjV77nVbrYlNROLOmJnW9Cq+b
         IeDGSsRRODwgjcqAm5JBr/6w6tWDlT7cN3Qu6mH1qHxo2CL4rzTQVMXqEjccOFaL9rqt
         4orKJ1tgkDrbTYCasUKb2ogyFGo1DJEwdjWV4vvKXmf5KerIcSyBHssPB0ZnfHYYLYZQ
         GUbCAmNnLQ88gj2372fgIsClhVd+j8MoKD7y/W411wx5bMy3w69Xp5IB4M0ODvlzzbYO
         xyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFsjVUh1cYKg3P3r+idJqwHGzAbhITKYp8eFdRNC/aY=;
        b=lYB0w/xAdGFwp6LEC8N3OrOCgnemjYaDNfODMxK1525iv4kjgc5hAxaVNAK1rXnWWz
         uL0kADvwA3RBxXvI4n/UAMnpTJJja6wBEM3jjw4trukdYTljaR5GerRXwZVcjYkKLOzj
         R80wv6WTSAG0SIzx4ezMopbxeIcYRIB4acb9A/vgKv7TwOOLU8R8MYbE2qFYirReglAs
         9bpRtTXgCuYHsUnfP8kWhBrAobuVcpo69yWyPddkcJ/ZMeyIgmwoZOsVfmEiJb9HSxzQ
         42ZEWHYlg6qXM1kUm0NddfIujWgmp58BdLQrT2AJqegc0cC82EkinuCGM5DdoIc9ZrC/
         qTJw==
X-Gm-Message-State: APjAAAUayu6HhhxGCqmatQj4Zvi+uR5FX5wmfctZUcDgZo1zm0hK7M5k
        OytdXjE7w9uCwSCYbVPQyn8CBcPEbBYjYQ==
X-Google-Smtp-Source: APXvYqzw9fEvtrH9y3c6C1H7gIHw03EHIWSlUtfYfRIIaNC7YXQnWW0azw+u08M04QqWQjHdSAr5yg==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr56316433pgc.328.1563578966213;
        Fri, 19 Jul 2019 16:29:26 -0700 (PDT)
Received: from fyin-linux ([103.121.208.202])
        by smtp.gmail.com with ESMTPSA id s66sm33330864pfs.8.2019.07.19.16.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 16:29:25 -0700 (PDT)
From:   YinFengwei <nh26223.lmm@gmail.com>
X-Google-Original-From: YinFengwei <fyin@fyin-linux>
Date:   Sat, 20 Jul 2019 07:29:20 +0800
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yin Fengwei <nh26223.lmm@gmail.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, tglx@linutronix.de,
        kstewart@linuxfoundation.org
Subject: Re: [PATCH] fs: fs_parser: avoid NULL param->string to kstrtouint
Message-ID: <20190719232920.GB27852@fyin-linux>
References: <20190719124329.23207-1-nh26223.lmm@gmail.com>
 <20190719173811.GA4765@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719173811.GA4765@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 07:38:11PM +0200, Greg KH wrote:
> On Fri, Jul 19, 2019 at 08:43:29PM +0800, Yin Fengwei wrote:
> > syzbot reported general protection fault in kstrtouint:
> > https://lkml.org/lkml/2019/7/18/328
> > 
> > >From the log, if the mount option is something like:
> >    fd,XXXXXXXXXXXXXXXXXXXX
> > 
> > The default parameter (which has NULL param->string) will be
> > passed to vfs_parse_fs_param. Finally, this NULL param->string
> > is passed to kstrtouint and trigger NULL pointer access.
> > 
> > Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
> > Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")
> > 
> > Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
> > ---
> >  fs/fs_parser.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index d13fe7d797c2..578e6880ac67 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -210,6 +210,10 @@ int fs_parse(struct fs_context *fc,
> >  	case fs_param_is_fd: {
> >  		switch (param->type) {
> >  		case fs_value_is_string:
> > +			if (result->has_value) {
> > +				goto bad_value;
> > +			}
> 
> Always run checkpatch.pl so grumpy maintainers do not tell you to go run
> checkpatch.pl :)

Thanks a lot for kindly reminder. Will be careful for future patch. :)

Regards
Yin, Fengwei
