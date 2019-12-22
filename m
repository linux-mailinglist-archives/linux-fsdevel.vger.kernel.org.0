Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22EF128C75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2019 04:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfLVDQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 22:16:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37639 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfLVDQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 22:16:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so17390741otn.4;
        Sat, 21 Dec 2019 19:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXe+XyghJ3jT79+ErouNH+8TEIPALo+7YH6r7qsLX7A=;
        b=tAevvl82/1W9hAGST3vIDtDD8gUUXIE4j/27y1nsFwbE739ec0YF6BdaL88IJE8akI
         XbtA2Dq111LZLJLJCfgMWlP6AJYD7fofJEus6AuKq7OgCMNa/Xib5rKdTJxkRaNHghDS
         GRBcdewHT2K2+1shGnOVi8hnFajstQphYnMWcEP6bJcWwJHbnGnybRFglZDFp81NuEJT
         yF3Yn+ekfu7D3Vi2C0eS82GKfomovvHsu/PPlBLIRDSIalPMO4QVrdR7jA9XhNyxTe1V
         vg2Qu8QUGieBXQHxtpUoPxHioU25C0731/NcEuMVku5kxLQCYm8ysph+wvTygBE6EIMZ
         5lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXe+XyghJ3jT79+ErouNH+8TEIPALo+7YH6r7qsLX7A=;
        b=pWLDbkAvLorc9LatKv+/iKDW6M5kuttXOjqO5PEGCpfWPve5I69vWbLJ9xzxS8KMQ6
         32rpKKFXecJlToFK1xouAnPFdnKGgqbtW/FV8hnkULZPPmCmHDKWLjmZGa/+rWdRF66h
         Kt+Ms7MkA2JowiemVuy9wDmJbi736K3znU8vF14CrAYmV2wF+kngVpmS90KLSVaIXZJQ
         e9nx0Hse34lvSYfCDl4sN0siJhSqwJRq6h57Mb76q+QXGAW8nrP85zN9IZ6vBrUdh/cd
         8s7UnycvocTdVuIJGtPxeOCShbBChkZLRUML0jYyUvyQbwDVUuLQLUHZLzPWrYhALcOP
         Zdcw==
X-Gm-Message-State: APjAAAWSb4D/nRIRxUM0SQGWf1v+lgMM7L9HkyaP5UNj9iXRLqDZ7mV1
        X27GJifv9M23FMC2RqN4xrE=
X-Google-Smtp-Source: APXvYqzrV5dFrDR2jbG5W6MU+wuzXi7CrjpVDIQyWd65CW4mv/3c3JhRkwmevhphHpHnJgiMY9/Elw==
X-Received: by 2002:a05:6830:3cb:: with SMTP id p11mr1304242otc.160.1576984598569;
        Sat, 21 Dec 2019 19:16:38 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r25sm5470695otk.2.2019.12.21.19.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 19:16:37 -0800 (PST)
Date:   Sat, 21 Dec 2019 20:16:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] vfs: Adjust indentation in remap_verify_area
Message-ID: <20191222031636.GA43673@ubuntu-m2-xlarge-x86>
References: <20191218035055.GG4203@ZenIV.linux.org.uk>
 <20191218051635.38347-1-natechancellor@gmail.com>
 <20191218110437.GJ3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218110437.GJ3929@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:04:37PM +0100, David Sterba wrote:
> On Tue, Dec 17, 2019 at 10:16:35PM -0700, Nathan Chancellor wrote:
> > Clang's -Wmisleading-indentation caught an instance in remap_verify_area
> > where there was a trailing space after a tab. Remove it to get rid of
> > the warning.
> > 
> > Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/828
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > 
> > v1 -> v2:
> > 
> > * Trim warning and simplify patch explanation.
> > 
> >  fs/read_write.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 5bbf587f5bc1..c71e863163bd 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1757,7 +1757,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
> >  	if (unlikely(pos < 0 || len < 0))
> >  		return -EINVAL;
> >  
> > -	 if (unlikely((loff_t) (pos + len) < 0))
> > +	if (unlikely((loff_t) (pos + len) < 0))
> 
> Instead of just fixing whitespace, can we please fix the undefined
> behaviour on this line? pos and len are signed types, there's a helper
> to do that in a way that's UB-safe.
> 
> And btw here's a patch:
> 
> https://lore.kernel.org/linux-fsdevel/20190808123942.19592-1-dsterba@suse.com/

I do not particularly care how this warning gets fixed, just that it
does. I will review that patch like Nick did.

Cheers,
Nathan
