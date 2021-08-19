Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D749B3F167E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhHSJqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHSJqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:46:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A94C061575;
        Thu, 19 Aug 2021 02:45:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q21so10488092ljj.6;
        Thu, 19 Aug 2021 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BrXKGMzqijVQZn/f58vr8NIjJOffkrppE1HzLO0vAY8=;
        b=EHzQI/2G1hZ7WJQM0DWDLCL65c7KdzUy/PFwT33fNHbd9BsCbcYrfn4wN+FprTd6E1
         9eesGe7XPS4z0Rdf6Ankj42OrR7YXSzmGOIkfrF+GScUNVcNB4bQg2lfuIud59mJcAa+
         jtJUAcYdrO73UoTlca+IiSpgihmaLmqP7im5Qsu24dYsrCEm/zglzyAUP/ockwt3cPA9
         ctliD9PrKBtaWa0PZgJqeUf3Uh1WSbiu10CmxSNItSN3GfhQgnLcv1hRpCi+q3rW7Dno
         uOHh0DtvbMg8kAlIZ7QDB5YVa5AWlW4ZF45J+48s+lkLqswnnBcvVAVtP1PkKyrBMru9
         vBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BrXKGMzqijVQZn/f58vr8NIjJOffkrppE1HzLO0vAY8=;
        b=aD326a68wYbahkzFPht0z7SpDw0cfNQ2JETInZNDOJZ/fPCdh1eTroP/Cdfq5sgVlH
         wsjMTA2AZ1W/LX/z9zUmSMC83ndjSmTPtIsJWEzZ++H7PCO8Z5bxzTnUW4ha+RB1Zlm6
         YLv5ust7riKVmnS3SFPpQ1JFCIS6Ajp39Ko3bAHGZ/Wu9Z2aXTnKOIo2sfIC5U8LbGyn
         QcXYJlPWXYKIHoc0lr0wriImKr10xH4M1bk9JfSWsyq50GqqPExCAhA0fWBa02tHjaLY
         1IKhbq8H0H4wuNU8BcW5CooNw0ZuiTIZUYJX3qT5swTQYKvRuVWLYb1GEYs4MFSZLVbm
         IQ7w==
X-Gm-Message-State: AOAM531mSZEq65cEQ/PYSjapAUc/XuH8HBF9BIwNn42iizbuiL6sMaXF
        77tMxRYkIaozrYGFfkb+Z2E=
X-Google-Smtp-Source: ABdhPJzt7Bk95ub/i9ygnyg1azGIQMbqruNMzuHc8tfR09/mZ4krVY2ObR9mTXTJyeUxEu3e33vLaQ==
X-Received: by 2002:a2e:2414:: with SMTP id k20mr11370781ljk.482.1629366335460;
        Thu, 19 Aug 2021 02:45:35 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id k15sm239284lja.72.2021.08.19.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:45:34 -0700 (PDT)
Date:   Thu, 19 Aug 2021 12:45:32 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 5/6] fs/ntfs3: Add iocharset= mount option as alias
 for nls=
Message-ID: <20210819094532.7uardf2q2u5w24yt@kari-VirtualBox>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-6-kari.argillander@gmail.com>
 <20210819082658.4xu6zmoro5xxdk5a@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819082658.4xu6zmoro5xxdk5a@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 10:26:58AM +0200, Pali Rohár wrote:
> On Thursday 19 August 2021 03:26:32 Kari Argillander wrote:
> > Other fs drivers are using iocharset= mount option for specifying charset.
> > So add it also for ntfs3 and mark old nls= mount option as deprecated.
> > 
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > ---
> >  Documentation/filesystems/ntfs3.rst |  4 ++--
> >  fs/ntfs3/super.c                    | 12 ++++++++----
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> > index af7158de6fde..ded706474825 100644
> > --- a/Documentation/filesystems/ntfs3.rst
> > +++ b/Documentation/filesystems/ntfs3.rst
> > @@ -32,12 +32,12 @@ generic ones.
> >  
> >  ===============================================================================
> >  
> > -nls=name		This option informs the driver how to interpret path
> > +iocharset=name		This option informs the driver how to interpret path
> >  			strings and translate them to Unicode and back. If
> >  			this option is not set, the default codepage will be
> >  			used (CONFIG_NLS_DEFAULT).
> >  			Examples:
> > -				'nls=utf8'
> > +				'iocharset=utf8'
> >  
> >  uid=
> >  gid=
> > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > index 8e86e1956486..c3c07c181f15 100644
> > --- a/fs/ntfs3/super.c
> > +++ b/fs/ntfs3/super.c
> > @@ -240,7 +240,7 @@ enum Opt {
> >  	Opt_nohidden,
> >  	Opt_showmeta,
> >  	Opt_acl,
> > -	Opt_nls,
> > +	Opt_iocharset,
> >  	Opt_prealloc,
> >  	Opt_no_acs_rules,
> >  	Opt_err,
> > @@ -259,9 +259,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> >  	fsparam_flag_no("hidden",		Opt_nohidden),
> >  	fsparam_flag_no("acl",			Opt_acl),
> >  	fsparam_flag_no("showmeta",		Opt_showmeta),
> > -	fsparam_string("nls",			Opt_nls),
> >  	fsparam_flag_no("prealloc",		Opt_prealloc),
> >  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> > +	fsparam_string("iocharset",		Opt_iocharset),
> > +
> > +	__fsparam(fs_param_is_string,
> > +		  "nls", Opt_iocharset,
> > +		  fs_param_deprecated, NULL),
> 
> Anyway, this is a new filesystem driver. Therefore, do we need to have
> for it since beginning deprecated option?

I have also thought about this. In my mind this is new driver to our tree.
But is been available from Paragon. Their customers may migrate to this
so let's give them easy path to it. They also have free version and
there is many Linux user who will switch to this when this is available.

Another thing what I been thinking is that how we will switch from
ntfs->ntfs3. To give easy path to this driver then we should in some
point add ntfs driver mount options to this one. Maybe not totally
funtional, but so that mounting is possible. Current ntfs driver had nls
option so it makes sense to add it here. We might even like to think
ntfs-3g mount options because that is more used.

Of course we can just drop this. But I like that user experience is good
with kernel. And if we can make that little more pleasent with couple
line of trivial code then imo let's do it. We just need to make sure we
drop these in one point of time. It is too often these kind of things
will live in kernel "internity".

> 
> >  	{}
> >  };
> >  
> > @@ -332,7 +336,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
> >  	case Opt_showmeta:
> >  		opts->showmeta = result.negated ? 0 : 1;
> >  		break;
> > -	case Opt_nls:
> > +	case Opt_iocharset:
> >  		opts->nls_name = param->string;
> >  		param->string = NULL;
> >  		break;
> > @@ -519,7 +523,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> >  	if (opts->dmask)
> >  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> >  	if (opts->nls_name)
> > -		seq_printf(m, ",nls=%s", opts->nls_name);
> > +		seq_printf(m, ",iocharset=%s", opts->nls_name);
> >  	if (opts->sys_immutable)
> >  		seq_puts(m, ",sys_immutable");
> >  	if (opts->discard)
> > -- 
> > 2.25.1
> > 
> 
