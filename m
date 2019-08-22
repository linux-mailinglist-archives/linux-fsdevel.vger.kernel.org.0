Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685149A1CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 23:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbfHVVMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 17:12:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44468 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbfHVVMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:12:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so4156963plr.11;
        Thu, 22 Aug 2019 14:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B9ygC6cTImqzdO3iTZYzOtFqP+MjCXvwJo65jt0WJr4=;
        b=NM8bPoeLLJW/fC+iPP8V211qvYjnJYq3IJYqWU23V2PpUgXwj63F9HnA3IfPRRMFDk
         gePN3VQ+Hzc3qDhfAVLndHcn59tWvEQDyaVNVO9wRT+R3853GFwJ2J0MZ7ynTgx6UpBR
         6b9IZ45QZP1Q+KGSMHYtNcBWqsahTOCfkBkmhLqp/tvnm8Buz/ufVpbuFHdcHDxSEDrb
         ta8DSaPETfCYiDKff4hD82Uw0/UjZwjQBNAwcPpElRuryvtImrg02ssIAFMKNykfP14n
         mhB0hibfu2mfvlid2Y602XVFclvt+NNE4EDXuYP+cl633SvvYfJlJYhKfKXTR5wnP0tK
         NF6w==
X-Gm-Message-State: APjAAAWJWbspwwyQjVPt4a9v9M8lirryidpPhgMdOwt5jZHNhAMWpddW
        bv0bUiH/DnLaWprV3TsTd2elBxN3
X-Google-Smtp-Source: APXvYqxSixNF8opcBdEl7Nryz+3OzHHuwJM7J2aAcf+EdilTKvc7C6wwX00WvkSHef+/zXk9naZJdw==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr920461plp.100.1566508342878;
        Thu, 22 Aug 2019 14:12:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b24sm315586pfd.91.2019.08.22.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 14:12:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 02E09403DC; Thu, 22 Aug 2019 21:12:20 +0000 (UTC)
Date:   Thu, 22 Aug 2019 21:12:20 +0000
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
Message-ID: <20190822211220.GR16384@42.do-not-panic.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <20190822194712.GG16384@42.do-not-panic.com>
 <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:07:41PM -0700, Scott Branden wrote:
> On 2019-08-22 12:47 p.m., Luis Chamberlain wrote:
> > This implies you having to change the other callers, and while currently
> > our list of drivers is small,
> 
> Yes, the list is small, very small.
> 
> There is a single driver making a call to the existing API.
> 
> And, the maintainer of that driver wanted
> to start utilizing my enhanced API instead of the current API.

You mean in the near term future? Your change makes it use the full file.
Just checking.

> As such I think it is very reasonable to update the API right now.

I'd prefer to see it separate, and we fix the race *before* we introduce
the new functionality. I'll be poking at that shortly but I should note
that I leave on vacation this weekend and won't be back for a good while.
I already have an idea of how to approach this.

When the current user want to use the new API it can do so, and then we
just kill the older caller.

> > following the history of the firmware API
> > and the long history of debate of *how* we should evolve its API, its
> > preferred we add yet another new caller for this functionality. So
> > please add a new caller, and use EXPORT_SYMBOL_GPL().
> > 
> > And while at it, pleaase use firmware_request_*() as the prefix, as we
> > have want to use that as the instilled prefix. We have yet to complete
> > the rename of the others older callers but its just a matter of time.
> > 
> > So something like: firmware_request_into_buf_offset()
> 
> I would prefer to rename the API at this time given there is only a single
> user.
> 
> Otherwise I would need to duplicate quite a bit in the test code to support
> testing the single user of the old api and then enhanced API.

> Or, I can leave existing API in place and change the test case to
> just test the enhanced API to keep things simpler in the test code?

If the new user is going to move to the API once available I will be
happy to then leave out testing for the older API. That would make
sense.

But if you do want to keep testing for the old API, and allow an easy
removal for it on the test driver, wouldn't a function pointer suffice
for which API call to use based on a boolean?

But yeah if we're going to abandon the old mechanism I'm happy to skip
its testing.

  Luis
