Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9DE1DF29E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgEVXAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 19:00:31 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40814 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgEVXAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 19:00:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id ci23so5685766pjb.5;
        Fri, 22 May 2020 16:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZG19gxtSnwF4OfMCJJ0fWxVFvMUt3ZeSnHyhNVnYhB4=;
        b=PK1eMmMBgxVceoY5DQ7qzIg8F8oR4L4dUacTwSKe+NKaleAxgbmf9Odga8ud8sfNsH
         OWMG8snhIb/btS9Kew7cgeAiHEAkZVybMOSguEhOLKAA2CqNtTR5jsw7bXAOFmsUs4n/
         9XqFU5Dyhwkf1eXtyRz8cwuJopBjWj+P8v9MosHGyh8LnHVJ3y+kiF4AF0gJPB1AnJ7/
         azeRNk24V+d4sqLU8bkK51plGoy+o87bhjH9/jpMTRMNL/U/AL67CsfHDAZXi8QyTtpI
         JA08+jeR098wyo0DBDCVr1K65L2fsOHuQk7cGY6bTsoUoX5zOfEzdTSVl8/6VMr1Mtaj
         sKDA==
X-Gm-Message-State: AOAM5320m1pyY4r98Qc2mgLGlz8WQtnv/CvFNOUX8UKhvVeMvmJ/Fup+
        Pc5j4gyW6ZWzJIr8fQg0Vsg=
X-Google-Smtp-Source: ABdhPJy1qKXu3QDSO8pj0idPHIsYYpQwWugzLB2YvPVVO+JH7NvM3P4UUl3224GhwITNiU3AHOGpEQ==
X-Received: by 2002:a17:90a:738e:: with SMTP id j14mr7066474pjg.107.1590188428483;
        Fri, 22 May 2020 16:00:28 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k18sm7736105pfg.217.2020.05.22.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:00:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E5F3A40321; Fri, 22 May 2020 23:00:25 +0000 (UTC)
Date:   Fri, 22 May 2020 23:00:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20200522230025.GG11244@42.do-not-panic.com>
References: <20200522214658.12722-1-scott.branden@broadcom.com>
 <20200522224508.GE11244@42.do-not-panic.com>
 <d87aabd0-1195-64ae-d871-b0771be832a8@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87aabd0-1195-64ae-d871-b0771be832a8@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 03:49:05PM -0700, Scott Branden wrote:
> Hi Luis,
> 
> On 2020-05-22 3:45 p.m., Luis Chamberlain wrote:
> > On Fri, May 22, 2020 at 02:46:58PM -0700, Scott Branden wrote:
> > >   /**
> > > - * enum fw_opt - options to control firmware loading behaviour
> > > + * fw_opt - options to control firmware loading behaviour
> > >    *
> > >    * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
> > >    *	when the firmware is not found. Userspace is in charge to load the
> > > @@ -33,15 +33,13 @@
> > >    *	the platform's main firmware. If both this fallback and the sysfs
> > >    *      fallback are enabled, then this fallback will be tried first.
> > >    */
> > > -enum fw_opt {
> > > -	FW_OPT_UEVENT			= BIT(0),
> > > -	FW_OPT_NOWAIT			= BIT(1),
> > > -	FW_OPT_USERHELPER		= BIT(2),
> > > -	FW_OPT_NO_WARN			= BIT(3),
> > > -	FW_OPT_NOCACHE			= BIT(4),
> > > -	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
> > > -	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
> > > -};
> > > +#define FW_OPT_UEVENT			BIT(0)
> > > +#define FW_OPT_NOWAIT			BIT(1)
> > > +#define FW_OPT_USERHELPER		BIT(2)
> > > +#define FW_OPT_NO_WARN			BIT(3)
> > > +#define FW_OPT_NOCACHE			BIT(4)
> > > +#define FW_OPT_NOFALLBACK_SYSFS		BIT(5)
> > > +#define FW_OPT_FALLBACK_PLATFORM	BIT(6)
> > Everything looked good up to here. The enum defines each flag.
> > We just want to use an enum for *one* flag represetnation, not
> > a bundle.
>
> I do not know exactly what you are looking for then.  The FW_OPT_*
> values are OR'd together in the code.  You still want the fw_opt enum
> above left in place entirely and then the values used in OR'd
> together?

Yes, exactly. If they are combined then we just use a u32 to represent
these are then flags combined. An enum represents just *one* flag, not
a set which are OR'd together. Let me know if this is still not clear.

  Luis
