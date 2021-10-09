Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB9427AD8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhJIOfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhJIOfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:35:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA32C061570;
        Sat,  9 Oct 2021 07:33:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r19so49596871lfe.10;
        Sat, 09 Oct 2021 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QDp2yNokFdoQ44aXDJPVFLwnE9qYqpLQcn22DBoeZOk=;
        b=Fas4aZoC3qmO5paWn3GZzJkxnC0ssfYOr4r9OTDqiDOqtUR49T+MU1HWmn8RoBVmSd
         Ncd7BwML/OUUOyaBFHGQiNR1lcVtp4VAwhGL47ejFCSnCUx7XOxmzGqfety1zghSENCQ
         lSRean/XqtseEKR2jTqHiwOoZ+du4nPwuZSiiZg97qjci/HF1RgM1MpZDJL/uMmIbijL
         Fs1U6/YB0d0xAKZItb2r5s/M/6CWIxtAcxWS+Y+TZgLqDh29OFf4odYh4XNxefOw7foE
         S/KWg6OCY/arK4QT5iTP0ambDQ0IFLUM5XENvHuy55frFghUM1asYfZYcCGaLly0/2t6
         wuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QDp2yNokFdoQ44aXDJPVFLwnE9qYqpLQcn22DBoeZOk=;
        b=1Op/eWFdjKRPmgirFwivacRCjtR86UJLTZEQJFS0jKNSpxY1NLyBOeG6SMaov1zZuI
         Rhh5V2Dsc7WR1un76va/gVe36p/T/GpvY2MYX7HVhAL6ISDDIy1mdyOkD2xBVHzBHvW/
         +KsoiK85BPEETlzKNVYBmPMp/fZnRqcTnxhWaZ3IrSNf8673azwHjqdL8JcgpCVsyGxR
         iwdgnqUdm57PBsVHLLsEF2ZH1Zr+DlYhHTJUdw1JtkwiLf00lgl+Vcao9TNsyrtAb1EU
         +ViepwDTZSvQ3v0UH/NppRTZVM1tuuK2wSU5OG5TP+e2Fs+AWkXvtqFg14q9y7qATYVT
         XKkA==
X-Gm-Message-State: AOAM532/cTw+oC/fA5niCW79xKuT8FyV2wKi3Iu0UL13V1GDQ7/SYSrd
        HHj2bQrNDy5vRdvNhRcI3XM=
X-Google-Smtp-Source: ABdhPJy6UPZVuas4ohCJgQ0pRn0sijAXEhKsOjup9vra8T5xskPRL4ywsqMRXNLV5TB00CFiTdh7VQ==
X-Received: by 2002:a2e:8743:: with SMTP id q3mr10543641ljj.280.1633790010481;
        Sat, 09 Oct 2021 07:33:30 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id w16sm221263lfq.272.2021.10.09.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 07:33:30 -0700 (PDT)
Date:   Sat, 9 Oct 2021 17:33:27 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 7/9] fs/ntfs3: Add iocharset= mount option as alias
 for nls=
Message-ID: <20211009143327.mqwwwlc4bgwtpush@kari-VirtualBox>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
 <20210907153557.144391-8-kari.argillander@gmail.com>
 <20210908190938.l32kihefvtfw5tjp@pali>
 <20211009114252.jn2uehmaveucimp5@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211009114252.jn2uehmaveucimp5@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Choose to add Linus to CC so that he also knows whats coming.

On Sat, Oct 09, 2021 at 01:42:52PM +0200, Pali Rohár wrote:
> Hello!
> 
> This patch have not been applied yet:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ntfs3/super.c#n247
> 
> What happened that in upstream tree is still only nls= option and not
> this iocharset=?

Very valid question. For some reason Konstantin has not sended pr to
Linus. I have also address my concern that pr is not yet sended and he
will make very massive "patch dumb" to rc6/rc7. See thread [1]. There is
about 50-70 patch already which he will send to rc6/rc7. I have get also
impression that patches which are not yet even applied to ntfs3 tree [2]
will be also sended to rc6/rc7. There is lot of refactoring and new
algorithms which imo are not rc material. I have sended many message to
Konstantin about this topic, but basically ignored.

Basically we do not have anything for next merge window and every patch
will be sended for 5.15.

[1] lore.kernel.org/lkml/20210925082823.fo2wm62xlcexhwvi@kari-VirtualBox
[2] https://github.com/Paragon-Software-Group/linux-ntfs3/commits/master

  Argillander

> 
> On Wednesday 08 September 2021 21:09:38 Pali Rohár wrote:
> > On Tuesday 07 September 2021 18:35:55 Kari Argillander wrote:
> > > Other fs drivers are using iocharset= mount option for specifying charset.
> > > So add it also for ntfs3 and mark old nls= mount option as deprecated.
> > > 
> > > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > 
> > Reviewed-by: Pali Rohár <pali@kernel.org>
> > 
> > > ---
> > >  Documentation/filesystems/ntfs3.rst |  4 ++--
> > >  fs/ntfs3/super.c                    | 18 +++++++++++-------
> > >  2 files changed, 13 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> > > index af7158de6fde..ded706474825 100644
> > > --- a/Documentation/filesystems/ntfs3.rst
> > > +++ b/Documentation/filesystems/ntfs3.rst
> > > @@ -32,12 +32,12 @@ generic ones.
> > >  
> > >  ===============================================================================
> > >  
> > > -nls=name		This option informs the driver how to interpret path
> > > +iocharset=name		This option informs the driver how to interpret path
> > >  			strings and translate them to Unicode and back. If
> > >  			this option is not set, the default codepage will be
> > >  			used (CONFIG_NLS_DEFAULT).
> > >  			Examples:
> > > -				'nls=utf8'
> > > +				'iocharset=utf8'
> > >  
> > >  uid=
> > >  gid=
> > > diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> > > index 729ead6f2fac..503e2e23f711 100644
> > > --- a/fs/ntfs3/super.c
> > > +++ b/fs/ntfs3/super.c
> > > @@ -226,7 +226,7 @@ enum Opt {
> > >  	Opt_nohidden,
> > >  	Opt_showmeta,
> > >  	Opt_acl,
> > > -	Opt_nls,
> > > +	Opt_iocharset,
> > >  	Opt_prealloc,
> > >  	Opt_no_acs_rules,
> > >  	Opt_err,
> > > @@ -245,9 +245,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> > >  	fsparam_flag_no("hidden",		Opt_nohidden),
> > >  	fsparam_flag_no("acl",			Opt_acl),
> > >  	fsparam_flag_no("showmeta",		Opt_showmeta),
> > > -	fsparam_string("nls",			Opt_nls),
> > >  	fsparam_flag_no("prealloc",		Opt_prealloc),
> > >  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> > > +	fsparam_string("iocharset",		Opt_iocharset),
> > > +
> > > +	__fsparam(fs_param_is_string,
> > > +		  "nls", Opt_iocharset,
> > > +		  fs_param_deprecated, NULL),
> > >  	{}
> > >  };
> > >  
> > > @@ -346,7 +350,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
> > >  	case Opt_showmeta:
> > >  		opts->showmeta = result.negated ? 0 : 1;
> > >  		break;
> > > -	case Opt_nls:
> > > +	case Opt_iocharset:
> > >  		kfree(opts->nls_name);
> > >  		opts->nls_name = param->string;
> > >  		param->string = NULL;
> > > @@ -380,11 +384,11 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
> > >  	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
> > >  	if (IS_ERR(new_opts->nls)) {
> > >  		new_opts->nls = NULL;
> > > -		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
> > > +		errorf(fc, "ntfs3: Cannot load iocharset %s", new_opts->nls_name);
> > >  		return -EINVAL;
> > >  	}
> > >  	if (new_opts->nls != sbi->options->nls)
> > > -		return invalf(fc, "ntfs3: Cannot use different nls when remounting!");
> > > +		return invalf(fc, "ntfs3: Cannot use different iocharset when remounting!");
> > >  
> > >  	sync_filesystem(sb);
> > >  
> > > @@ -528,9 +532,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> > >  	if (opts->dmask)
> > >  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> > >  	if (opts->nls)
> > > -		seq_printf(m, ",nls=%s", opts->nls->charset);
> > > +		seq_printf(m, ",iocharset=%s", opts->nls->charset);
> > >  	else
> > > -		seq_puts(m, ",nls=utf8");
> > > +		seq_puts(m, ",iocharset=utf8");
> > >  	if (opts->sys_immutable)
> > >  		seq_puts(m, ",sys_immutable");
> > >  	if (opts->discard)
> > > -- 
> > > 2.25.1
> > > 
