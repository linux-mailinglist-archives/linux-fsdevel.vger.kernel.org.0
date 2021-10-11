Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8242994E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 00:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhJKWHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJKWH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 18:07:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FEAC061570;
        Mon, 11 Oct 2021 15:05:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so79277718lfk.7;
        Mon, 11 Oct 2021 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t//VfIkjwQXqxb3+6HcAZOI39YFeCdYqc5EmeEugUiM=;
        b=LRfZYb2oYtFdaCGAqgENP68VqIS3FtOaa4y00ZpjQ73DyqKx7qpIoRptdFkkzi8IZw
         CvgHnxi6Eiv0ACcze7BW+YCVhYoCTTagnPQID5x//kANR4A5nKGKRIXXDOi/B3Q1aH2c
         PYhDxJ9n6L0zOr/5pO8hEaBCevc2O3XODIu4F89fi0KCYmaCssnae6gdUZBjTAXG8hyo
         tqkeBrStIJHUOkQW0iA8RvG7bDWRPzTpg79jaJAEGR2bGAv9EFMbVHsStIjkOv7MNzVm
         Kcm63wz6L+c0RuJbMV7NWHC7ItQQHdMkmkfS+j26MzU4kWu0nrR/9GrnneWiDzk8kB2y
         0IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t//VfIkjwQXqxb3+6HcAZOI39YFeCdYqc5EmeEugUiM=;
        b=VPZNUkIQ1Thu/q3sScRyJyokcyK0vmBnsk1YFTuSwHV0Uc/6yhHFKNEenukDU20GCI
         iCUWb46Ycg3iDO0+qYKDGHC/9Dr/LkrF+pYckCM1r7chvbg2diPeNR8qtfhsRa253yDx
         RFuGtzJU26CX29MJLM5oO42bDRd8rh1EB5AKJmMx1rE1LwUJzLCNGnvGrksGSWoXx5/o
         x4SxFTenvNobkz7cs/uKngJ2XNNY/aoODkP/rGhvm0lNYiPshppk9S22g9EpgGm5DxZf
         cUs/ANB6ux8xYrlMCJ0/cO3R9wcV4pYE5rGK2CV4e6/LpyyVYPlJv8zNquoH+W3BlFqz
         3vNA==
X-Gm-Message-State: AOAM532mWYw+8aryDjLH+ZixUht2yB+zkyJZuT9hAVmhFsAMyF1ykB7E
        4noLNozteHBCnJsCyATOZa4=
X-Google-Smtp-Source: ABdhPJzE2xywrVGoYO6jnH0X0hlidV7nukzzc/FaBfvY3s6ir9rBtVz7eOExZMKV3Bomawxik3twkw==
X-Received: by 2002:ac2:4e02:: with SMTP id e2mr30412482lfr.264.1633989926514;
        Mon, 11 Oct 2021 15:05:26 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b9sm844307lfe.85.2021.10.11.15.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:05:26 -0700 (PDT)
Date:   Tue, 12 Oct 2021 01:05:24 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, ntfs3@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 7/9] fs/ntfs3: Add iocharset= mount option as alias
 for nls=
Message-ID: <20211011220524.azcaxs7y5zgd2uwz@kari-VirtualBox>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
 <20210907153557.144391-8-kari.argillander@gmail.com>
 <20210908190938.l32kihefvtfw5tjp@pali>
 <20211009114252.jn2uehmaveucimp5@pali>
 <20211009143327.mqwwwlc4bgwtpush@kari-VirtualBox>
 <204a5be9-f0a2-1c85-d3a8-3011578b9299@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <204a5be9-f0a2-1c85-d3a8-3011578b9299@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:14:28PM +0300, Konstantin Komarov wrote:
> 
> 
> On 09.10.2021 17:33, Kari Argillander wrote:
> > Choose to add Linus to CC so that he also knows whats coming.
> > 
> > On Sat, Oct 09, 2021 at 01:42:52PM +0200, Pali Rohár wrote:
> >> Hello!
> >>
> >> This patch have not been applied yet:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ntfs3/super.c#n247
> >>
> >> What happened that in upstream tree is still only nls= option and not
> >> this iocharset=?
> > 
> > Very valid question. For some reason Konstantin has not sended pr to
> > Linus. I have also address my concern that pr is not yet sended and he
> > will make very massive "patch dumb" to rc6/rc7. See thread [1]. There is
> > about 50-70 patch already which he will send to rc6/rc7. I have get also
> > impression that patches which are not yet even applied to ntfs3 tree [2]
> > will be also sended to rc6/rc7. There is lot of refactoring and new
> > algorithms which imo are not rc material. I have sended many message to
> > Konstantin about this topic, but basically ignored.
> > 
> > Basically we do not have anything for next merge window and every patch
> > will be sended for 5.15.
> > 
> > [1] lore.kernel.org/lkml/20210925082823.fo2wm62xlcexhwvi@kari-VirtualBox
> > [2] https://github.com/Paragon-Software-Group/linux-ntfs3/commits/master
> > 
> >   Argillander
> > 
> 
> Hello.
> 
> I was planning to send pull request on Friday 08.10.
> But there is still one panic, that wasn't resolved [1].
> It seems to be tricky, so I'll be content even with quick band-aid [2].
> After confirming, that it works, I plan on sending pull request.
> I don't want for this panic to remain in 5.15.

Of course we won't want panic to remain 5.15, but that does not mean you
can't send pr for other patches. You can still send other pr later for
other rc's. If you will send pr late it might be that Linus will not
apply any of them because it will be too big pr for late rc. I'm sure he
will be resonable in first time because ntfs3 is new driver and will
accept pr in this case, but this cannot come habbit.

Normally rc cycle is for this kind of things. We fix things we broke
during merge window, but right now it is real danger that we introduce
many bugs because people cannot test ntfs3 because you hold on patches.
They belong to also to Linus tree not just to linux-next. Many user use
Linus tree and there are many who send good bug reports.

But do not take this too harsh. I'm just personally worried here. Also I
think you as maintainer had improved well in short time.

> [1]: https://lore.kernel.org/ntfs3/f9de5807-2311-7374-afb0-bc5dffb522c0@gmail.com/
> [2]: https://lore.kernel.org/ntfs3/7e5b8dc9-9989-0e8a-9e8d-ae26b6e74df4@paragon-software.com/
> 
> >>
> >> On Wednesday 08 September 2021 21:09:38 Pali Rohár wrote:
> >>> On Tuesday 07 September 2021 18:35:55 Kari Argillander wrote:
> >>>> Other fs drivers are using iocharset= mount option for specifying charset.
> >>>> So add it also for ntfs3 and mark old nls= mount option as deprecated.
> >>>>
> >>>> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> >>>
> >>> Reviewed-by: Pali Rohár <pali@kernel.org>
> >>>
> >>>> ---
> >>>>  Documentation/filesystems/ntfs3.rst |  4 ++--
> >>>>  fs/ntfs3/super.c                    | 18 +++++++++++-------
> >>>>  2 files changed, 13 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> >>>> index af7158de6fde..ded706474825 100644
> >>>> --- a/Documentation/filesystems/ntfs3.rst
> >>>> +++ b/Documentation/filesystems/ntfs3.rst
> >>>> @@ -32,12 +32,12 @@ generic ones.
> >>>>  
> >>>>  ===============================================================================
> >>>>  
> >>>> -nls=name		This option informs the driver how to interpret path
> >>>> +iocharset=name		This option informs the driver how to interpret path
> >>>>  			strings and translate them to Unicode and back. If
> >>>>  			this option is not set, the default codepage will be
> >>>>  			used (CONFIG_NLS_DEFAULT).
> >>>>  			Examples:
> >>>> -				'nls=utf8'
> >>>> +				'iocharset=utf8'
> >>>>  
> >>>>  uid=
> >>>>  gid=
> >>>> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> >>>> index 729ead6f2fac..503e2e23f711 100644
> >>>> --- a/fs/ntfs3/super.c
> >>>> +++ b/fs/ntfs3/super.c
> >>>> @@ -226,7 +226,7 @@ enum Opt {
> >>>>  	Opt_nohidden,
> >>>>  	Opt_showmeta,
> >>>>  	Opt_acl,
> >>>> -	Opt_nls,
> >>>> +	Opt_iocharset,
> >>>>  	Opt_prealloc,
> >>>>  	Opt_no_acs_rules,
> >>>>  	Opt_err,
> >>>> @@ -245,9 +245,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> >>>>  	fsparam_flag_no("hidden",		Opt_nohidden),
> >>>>  	fsparam_flag_no("acl",			Opt_acl),
> >>>>  	fsparam_flag_no("showmeta",		Opt_showmeta),
> >>>> -	fsparam_string("nls",			Opt_nls),
> >>>>  	fsparam_flag_no("prealloc",		Opt_prealloc),
> >>>>  	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> >>>> +	fsparam_string("iocharset",		Opt_iocharset),
> >>>> +
> >>>> +	__fsparam(fs_param_is_string,
> >>>> +		  "nls", Opt_iocharset,
> >>>> +		  fs_param_deprecated, NULL),
> >>>>  	{}
> >>>>  };
> >>>>  
> >>>> @@ -346,7 +350,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
> >>>>  	case Opt_showmeta:
> >>>>  		opts->showmeta = result.negated ? 0 : 1;
> >>>>  		break;
> >>>> -	case Opt_nls:
> >>>> +	case Opt_iocharset:
> >>>>  		kfree(opts->nls_name);
> >>>>  		opts->nls_name = param->string;
> >>>>  		param->string = NULL;
> >>>> @@ -380,11 +384,11 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
> >>>>  	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
> >>>>  	if (IS_ERR(new_opts->nls)) {
> >>>>  		new_opts->nls = NULL;
> >>>> -		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
> >>>> +		errorf(fc, "ntfs3: Cannot load iocharset %s", new_opts->nls_name);
> >>>>  		return -EINVAL;
> >>>>  	}
> >>>>  	if (new_opts->nls != sbi->options->nls)
> >>>> -		return invalf(fc, "ntfs3: Cannot use different nls when remounting!");
> >>>> +		return invalf(fc, "ntfs3: Cannot use different iocharset when remounting!");
> >>>>  
> >>>>  	sync_filesystem(sb);
> >>>>  
> >>>> @@ -528,9 +532,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> >>>>  	if (opts->dmask)
> >>>>  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> >>>>  	if (opts->nls)
> >>>> -		seq_printf(m, ",nls=%s", opts->nls->charset);
> >>>> +		seq_printf(m, ",iocharset=%s", opts->nls->charset);
> >>>>  	else
> >>>> -		seq_puts(m, ",nls=utf8");
> >>>> +		seq_puts(m, ",iocharset=utf8");
> >>>>  	if (opts->sys_immutable)
> >>>>  		seq_puts(m, ",sys_immutable");
> >>>>  	if (opts->discard)
> >>>> -- 
> >>>> 2.25.1
> >>>>
