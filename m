Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F702FA2F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 15:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392865AbhAROZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 09:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404955AbhAROZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:25:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DA3C061575;
        Mon, 18 Jan 2021 06:24:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u25so24337011lfc.2;
        Mon, 18 Jan 2021 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yzGPQHJyJrZ9ltTCbmSP8D0KGxFbljRtwv+aoMP5SnA=;
        b=Vi3UrjWycuWNIjdW9WPNwwFLKLO4cVYSKgvRNZXAiJdg5DrJ4BhAIROrjnz7QDDM8C
         pI9gS++OPTnlOxSvp4K41zl7KfpGx6lCmgRPih0dqi4UkvaPdKrlT/4zvwi8iLAIPshG
         GvtHZUI3a81iCqKXSVJNpzHcJ6QB/+ZuUEwB57rBj68ZfrkaTPakWOwSXnwfBJzLpa4B
         Urwf2gcNGSf8IJc98sz8y0X4wvFgjxFwJAd2xleDBEGm3o89JVJWTIipClr3TlYBdd+j
         eJWCIzYBZ4i8JpGluPa/fyTuK8xmHPzItIsEqPGnPFlHuWTl/Q/D9Qy9VDSNI62X73d7
         DzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yzGPQHJyJrZ9ltTCbmSP8D0KGxFbljRtwv+aoMP5SnA=;
        b=ARCvbXEFR5FAkBdqI+Klj6n3oAnsNZ9euClDAdky+I/6dPBBLKlkkOTZ61bNAIcsPO
         5qPrYoAmukI2o5Q1pYZOK4ZQdi18tfit7fH8C0ybpRpAwZI82JI9SvWtDOdTpiopiUKN
         G1H+HlMjwKxXyJKiW9fj4Glvx/RhT7SBNUaygmPCHlzJxEgeqATSL0y9poyHyUt6DhLh
         osQhURZOSp9/ntYUjPIvOZOp/KmK2UrIuoKYDZrLrs89rATUgAvL0Loumz5oVjygyPqV
         NMoqdu6jN8wzQbk8E4WdHYDlrOvijxJiJ4JbksGDJsSzVjqaYnImQoiAAscsNh75XgHm
         78+w==
X-Gm-Message-State: AOAM531j0sJH9Sf34qQ5WDWchtVUkh2IDP3CgY6ZwsMeynON9tXQbbOr
        bRBvXP4WZrjsD4YdoIkjFRU=
X-Google-Smtp-Source: ABdhPJw+B1oWzDyTE/Q47yHVmjUMwotouMlJKNJVC8Bp5ALYZYTd4fue4N4mSUcemavdLpDhD4U86A==
X-Received: by 2002:ac2:59ce:: with SMTP id x14mr11932677lfn.545.1610979883078;
        Mon, 18 Jan 2021 06:24:43 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id l1sm1917257lfk.201.2021.01.18.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:24:41 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:24:39 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v17 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210118142439.p24chxfa4eq3ogsa@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
 <20210103215732.vbgcrf42xnao6gw2@kari-VirtualBox>
 <cf76ecec5ec1419eacf4c170df65a57d@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf76ecec5ec1419eacf4c170df65a57d@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:00:53AM +0000, Konstantin Komarov wrote:
> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Monday, January 4, 2021 12:58 AM
> > On Thu, Dec 31, 2020 at 06:23:55PM +0300, Konstantin Komarov wrote:
 
> > > +static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
> > > +{

> > > +	/* Return error if mode is not supported */
> > > +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> > > +		     FALLOC_FL_COLLAPSE_RANGE))
> > > +		return -EOPNOTSUPP;

> > > +
> > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {

> > > +	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {

> > > +	} else {

> > > +		if (mode & FALLOC_FL_KEEP_SIZE) {
> > 
> > Isn't this hole else already (mode & FALLOC_FL_KEEP_SIZE?
> 
> Sorry, can you please clarify your question? Not sure, understood it.

I have hide unrelevant code now. So maybe now you see better what I
mean. Last else have to be already FALLOC_FL_KEEP_SIZE so if statment is
not needed.
