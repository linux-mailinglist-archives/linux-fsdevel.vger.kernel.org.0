Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4413F16EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhHSKCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbhHSKCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:02:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D87C061575;
        Thu, 19 Aug 2021 03:01:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f2so10605603ljn.1;
        Thu, 19 Aug 2021 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2cL/kIS6p4aIzzhUBR+U0xZgdJ0R2i9add4dnTAHrZs=;
        b=vNjFmzqoH/KKyce63ZJFwoXYgRQP6+TTCCgtE8h8Ybn9aoPdDjpucXtJ5SdzjcCjpD
         ytW0GuSAj8x7SLzPOjdQJayEV8NWJQ6Lvj/iOqkFcyv4fmSNMeQGuG5ZKZ0YEI7AwS3r
         n9CuK8kGG0YwTTG0vV2w7aRkNBQDoLA3/ttI44guAZLGPSSaiaWxg62wfS90DzsdPqBy
         4qKYggYcme7pP6YD254UBlcyGzdGz4xfTfVZmfk+WPhq21lcWxByr2M+t48SSWANhnax
         mf5gwyaGRueByzgbP9Pty3XQKasRFA5ocmXlgGoq/ofCSvVQxcml1KyOo1jdu9jcI/+4
         wxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2cL/kIS6p4aIzzhUBR+U0xZgdJ0R2i9add4dnTAHrZs=;
        b=ctx8OXv12hLJ8l3BgcE6pWm17fjHCPdRzqVg5mGY8GEcR0RMjPXD7ZCuXyVL8I+jfS
         3OsZskcb1d2V5ZUFBltucCVt9BlSEcZ8sNMCQAW/Xx3ibiVmebE04eDOh0uykHWt4abb
         NZ0HG1/7cbpRjt5A/kbM9MOuPPXW7lvzZc+DEC7cjyU+9bLPig10YxPoy0jp9reMz3+K
         IqE18weWZtSVzqTwUcgZSNK8Yp8cV+PvhJte4fz+72jtKDCa7V7zfR/9RDdHZCjmaKfO
         nblWSB/nMuU4bKVxhiTLHYjHzJhCZnRivObfdmoYg8bhuHrfRrtLIx8pLrfZehOX4aTC
         uzdQ==
X-Gm-Message-State: AOAM5328Jf46RpmVdsXel/ftLdznfCrTDTBwSWwmPSDvn6HSdrCXopVs
        kO7w5sB0nBxftJrOHcfDAZ0=
X-Google-Smtp-Source: ABdhPJzDs8yVZFmyam3hm0ByKmiHAlqGasNP2Pwe/ePVFpzy/cc6fBCqLVZE0ZcHoJf3HoHlt2jjLQ==
X-Received: by 2002:a05:651c:1190:: with SMTP id w16mr11373932ljo.327.1629367300118;
        Thu, 19 Aug 2021 03:01:40 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id v16sm220089ljc.138.2021.08.19.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 03:01:39 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:01:37 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 3/6] fs/ntfs3: Use new api for mounting
Message-ID: <20210819100137.5se3otjz5ngcfswz@kari-VirtualBox>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-4-kari.argillander@gmail.com>
 <20210819081828.zdlejcujqmpzpzif@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819081828.zdlejcujqmpzpzif@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 10:18:28AM +0200, Pali Rohár wrote:
> Hello! I have there one comment:
> 
> On Thursday 19 August 2021 03:26:30 Kari Argillander wrote:
> > @@ -545,10 +518,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
> >  		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
> >  	if (opts->dmask)
> >  		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> > -	if (opts->nls)
> > -		seq_printf(m, ",nls=%s", opts->nls->charset);
> > -	else
> > -		seq_puts(m, ",nls=utf8");
> > +	if (opts->nls_name)
> > +		seq_printf(m, ",nls=%s", opts->nls_name);
> 
> Please always print correct "nls=". Obviously ntfs driver (which
> internally stores filenames in UTF-16) must always use some conversion
> to null-term bytes. And if some kernel/driver default conversion is used
> then userspace should know it, what exactly is used (e.g. to ensure that
> would use correct encoding name argument of open(), stat()... syscalls).

Thanks. That was actually my intention, but it seems that there is bug
from my part and it will be fixed in v3. Thanks for reviewing.

> 
> >  	if (opts->sys_immutable)
> >  		seq_puts(m, ",sys_immutable");
> >  	if (opts->discard)
> > @@ -619,7 +590,6 @@ static const struct super_operations ntfs_sops = {
> >  	.statfs = ntfs_statfs,
> >  	.show_options = ntfs_show_options,
> >  	.sync_fs = ntfs_sync_fs,
> > -	.remount_fs = ntfs_remount,
> >  	.write_inode = ntfs3_write_inode,
> >  };
> 
