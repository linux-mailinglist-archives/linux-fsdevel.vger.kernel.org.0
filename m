Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A530B1DF543
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 08:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbgEWGso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 02:48:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37297 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgEWGso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 02:48:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id x10so5304787plr.4;
        Fri, 22 May 2020 23:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NpNzKiRERZoLVhj+jDvGzomV5rdbxMN4yOkmuyXrsqc=;
        b=dfSjIyfKRCEdcQDSYFHtXy52a4IusV7vOl3zfbH0GuzpOUbLjPhksRISHxozp792wY
         /eELU7qVZEOyRRBXJ3y/cGXu/A9fNm3cXpZT7PklU/LxySn/PgilSup+KaXxR8LK6Zap
         OERMiyxxeKiVBoEb/+E9C8eiT9QvC7IsOT4Gcc3vmiI3tfDobU1B10Kbs1bdDQzFtJmb
         HB7IQGUHXoBB6n4aTYfVxpaTJt8m0910imxNLzBlsInYg6+Hk9o17ZpA+TJyjMwJ/FbH
         ncPunslXALS8j98l6ujGrIEWnQq5MgxZFkosMW4eVS67RaGLfn1nCGOFkXBk6BIo5fok
         jHUw==
X-Gm-Message-State: AOAM532uAwFwhKytexhN2ubbcKHf2qpUF7TwlDXvuz2WIv3141EjCWl3
        1mNkz0yOVw0Y07vzJ4WIwgI=
X-Google-Smtp-Source: ABdhPJwTc/h4nDTy2YuDCAXvaLPEjLXQmwxq1dkA9Y4zNiWHgma1YWCSf2CT4PnncLtLKjIlyguZFw==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr18209345plz.179.1590216523391;
        Fri, 22 May 2020 23:48:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k24sm8362342pfk.134.2020.05.22.23.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 23:48:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 32F45404B0; Sat, 23 May 2020 06:48:41 +0000 (UTC)
Date:   Sat, 23 May 2020 06:48:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] firmware_loader: change enum fw_opt to u32
Message-ID: <20200523064841.GJ11244@42.do-not-panic.com>
References: <20200522214658.12722-1-scott.branden@broadcom.com>
 <20200522224508.GE11244@42.do-not-panic.com>
 <d87aabd0-1195-64ae-d871-b0771be832a8@broadcom.com>
 <20200522230025.GG11244@42.do-not-panic.com>
 <20200523060548.GA3124611@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200523060548.GA3124611@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 23, 2020 at 08:05:48AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 22, 2020 at 11:00:25PM +0000, Luis Chamberlain wrote:
> > On Fri, May 22, 2020 at 03:49:05PM -0700, Scott Branden wrote:
> > > Hi Luis,
> > > 
> > > On 2020-05-22 3:45 p.m., Luis Chamberlain wrote:
> > > > On Fri, May 22, 2020 at 02:46:58PM -0700, Scott Branden wrote:
> > > > >   /**
> > > > > - * enum fw_opt - options to control firmware loading behaviour
> > > > > + * fw_opt - options to control firmware loading behaviour
> > > > >    *
> > > > >    * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
> > > > >    *	when the firmware is not found. Userspace is in charge to load the
> > > > > @@ -33,15 +33,13 @@
> > > > >    *	the platform's main firmware. If both this fallback and the sysfs
> > > > >    *      fallback are enabled, then this fallback will be tried first.
> > > > >    */
> > > > > -enum fw_opt {
> > > > > -	FW_OPT_UEVENT			= BIT(0),
> > > > > -	FW_OPT_NOWAIT			= BIT(1),
> > > > > -	FW_OPT_USERHELPER		= BIT(2),
> > > > > -	FW_OPT_NO_WARN			= BIT(3),
> > > > > -	FW_OPT_NOCACHE			= BIT(4),
> > > > > -	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
> > > > > -	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
> > > > > -};
> > > > > +#define FW_OPT_UEVENT			BIT(0)
> > > > > +#define FW_OPT_NOWAIT			BIT(1)
> > > > > +#define FW_OPT_USERHELPER		BIT(2)
> > > > > +#define FW_OPT_NO_WARN			BIT(3)
> > > > > +#define FW_OPT_NOCACHE			BIT(4)
> > > > > +#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
> > > > > +#define FW_OPT_FALLBACK_PLATFORM	BIT(6)
> > > > Everything looked good up to here. The enum defines each flag.
> > > > We just want to use an enum for *one* flag represetnation, not
> > > > a bundle.
> > >
> > > I do not know exactly what you are looking for then.  The FW_OPT_*
> > > values are OR'd together in the code.  You still want the fw_opt enum
> > > above left in place entirely and then the values used in OR'd
> > > together?
> > 
> > Yes, exactly. If they are combined then we just use a u32 to represent
> > these are then flags combined. An enum represents just *one* flag, not
> > a set which are OR'd together. Let me know if this is still not clear.
> 
> If this is the case, why have an enum at all?  What difference is it
> from a #define like was done here?

If used on a switch to test for cases the compiler will error if you
miss one, and it is easier to use kdoc for them.

  Luis
