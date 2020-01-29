Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09414C92A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 11:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2K6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 05:58:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33708 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2K6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:58:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so8660917pgk.0;
        Wed, 29 Jan 2020 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnkKDo9E340IryD18Mp59JG+Dgi6azYeZD8jX7vqjKk=;
        b=h0UpekPFyzxi+v1iRWR5YC2RvbXSeusjVTn7wf/YaVrrybMkP8jgwBIRDMsmEUe9kk
         RRDUGeYBXoOz/BeWYSBwkgkM5N/Ly2zZxXca5gZASIy9hnC0Dy2gbzg4MZ+XSs2P+RaK
         jhUXL3VpHSnpsBrDYauaxbzq9HxJTGylyWQRm8AZ0ew5wVONgG+e87t8kw7PoxPfVYYQ
         u2B3PVH0mejnI7yJ+FYFEQRJNRS9gczuf4FtQV3X2WN2P+qUE9lvf1dU5Us9UWHUr3bP
         L+Jt0n98Fz+Wky1b/3ule6nHDWXXM+YmMNG88IlCwffRA+rMTY0hitEm+m59qiA4p2A1
         KlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnkKDo9E340IryD18Mp59JG+Dgi6azYeZD8jX7vqjKk=;
        b=ozbmIzjg1EgUHqiNfmeNFAeG1VSu8C133gQaY349jMxB9pdlFnh4Fm3y+lhi5v00Mq
         j/ens5T7VR0DeK1Y5k8O+1QTfn2kKXu2Xl4aIm0V2LbuhqQ/Z89illvmyE+MyJEis4L6
         Ok+7ScXcwwZgqQDUgr40jAP+mwY/jmmJtAOWQL4ioRvZgJX9ilkmyzo5Nwhd+epKdiy+
         XHZqYsatyYZ+peCXQrgkH0KcnQfBHGh//AgnyEpeAmck+zCsQN+3wcs37gfm18X5YbeQ
         g7ikOg+8tzAp02M/HmQCpCaabZiwlVW4RyAfzwTf2si4/M0/jssS93tmlA7DkvVQSxzc
         hZmQ==
X-Gm-Message-State: APjAAAUio8cD7G5UsAwNIZu2LwaJ0ZygkUvGv4+O2lszEN/w7pjulcn7
        hs7ZUUzwlHfH+MKUhT4r4J6dcVTKFvo=
X-Google-Smtp-Source: APXvYqzZIzh+PS0Ileykyhf/P+2UFPNgdQpMZqkFXaJKSAhkm311VSj7Fq+pMup+H+KY4PzIzZsfww==
X-Received: by 2002:a62:1c88:: with SMTP id c130mr8768170pfc.195.1580295525577;
        Wed, 29 Jan 2020 02:58:45 -0800 (PST)
Received: from pragat-GL553VD ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.googlemail.com with ESMTPSA id y75sm2384448pfb.116.2020.01.29.02.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 02:58:44 -0800 (PST)
Message-ID: <0eac2eebe812a42fd447edfeff3d2791276b655a.camel@gmail.com>
Subject: Re: [PATCH 09/22] staging: exfat: Rename variable "Size" to "size"
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, valdis.kletnieks@vt.edu,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 29 Jan 2020 16:28:37 +0530
In-Reply-To: <20200129105012.GA3884393@kroah.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
         <20200127101343.20415-10-pragat.pandya@gmail.com>
         <20200127115741.GA1847@kadam>
         <287916429826dd2f14d82f9b7b6b15a9cace2734.camel@gmail.com>
         <20200129105012.GA3884393@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-01-29 at 11:50 +0100, Greg KH wrote:
> On Wed, Jan 29, 2020 at 04:10:39PM +0530, Pragat Pandya wrote:
> > On Mon, 2020-01-27 at 14:57 +0300, Dan Carpenter wrote:
> > > On Mon, Jan 27, 2020 at 03:43:30PM +0530, Pragat Pandya wrote:
> > > > Change all the occurences of "Size" to "size" in exfat.
> > > > 
> > > > Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> > > > ---
> > > >  drivers/staging/exfat/exfat.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/staging/exfat/exfat.h
> > > > b/drivers/staging/exfat/exfat.h
> > > > index 52f314d50b91..a228350acdb4 100644
> > > > --- a/drivers/staging/exfat/exfat.h
> > > > +++ b/drivers/staging/exfat/exfat.h
> > > > @@ -233,7 +233,7 @@ struct date_time_t {
> > > >  
> > > >  struct part_info_t {
> > > >  	u32      offset;    /* start sector number of the
> > > > partition */
> > > > -	u32      Size;      /* in sectors */
> > > > +	u32      size;      /* in sectors */
> > > >  };
> > > 
> > > We just renamed all the struct members of this without changing
> > > any
> > > users.  Which suggests that this is unused and can be deleted.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > Can I just drop this commit from this patchset and do a separate
> > patch
> > to remove the unused structure?
> 
> Drop this one, and the other ones that touch this structure, and do a
> separate patch.  This series needs fixing up anyway, I can't take it
> as-is.
> 
> thanks,
> 
> greg k-h

Ok, will do that.

Regards,
pragat pandya

