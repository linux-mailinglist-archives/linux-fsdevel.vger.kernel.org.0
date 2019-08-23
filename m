Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8E9B3D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436515AbfHWPrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 11:47:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36526 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbfHWPrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:47:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so5989321pgm.3;
        Fri, 23 Aug 2019 08:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VG8EIeMQItJhytyTZt7nzgktzvLNdb+gcPr4KWogGY0=;
        b=DWX3m/j5jA1S1fzML4FXE/s36gb8U4VTsNGyWhTuXG6EZzIhnGdFsjuLTff9Nu4MEj
         DhtWoxrU83KFhUzISM8t+AnffGfjIxdKCwG/AdsjwV/Rn+nmYIF2hzp0uQaIokSQG283
         xUZVOPZL+1/v2FV0vPX+pGqlf6iIa3m0swepxh3wkdiVXWCOxOG6O/PvU4cYwcNq31tX
         K7GDvG6vjfhPJiXu1xx0q+nF2Mi+Ano71w7iv8KjY5dgasaXD87HGq5dZg4L6mHnbHry
         SZbydGy1RtOcEcbC5J2Z+xvBvRYjZ8GnLcy8rdriGXNqMOO8CaQpmIhx3yvmtWsVHBiP
         O9vw==
X-Gm-Message-State: APjAAAX5dOeSMBELKIoUdvqgIayWVSobk5QslSux/z7s4liTjDcVXlN0
        JfKv1sWqecwCkqyZq7hYVPo=
X-Google-Smtp-Source: APXvYqx2aEQMUqVkTqsbD+0xiHRvSsAoHIE4H6Pq7ZIiWB6O8RWnN/wTCIn81fjnTKGbK94YkooGRA==
X-Received: by 2002:a65:614a:: with SMTP id o10mr4485949pgv.407.1566575243276;
        Fri, 23 Aug 2019 08:47:23 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 16sm5611763pfc.66.2019.08.23.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:47:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 52338404D5; Fri, 23 Aug 2019 15:47:21 +0000 (UTC)
Date:   Fri, 23 Aug 2019 15:47:21 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
Message-ID: <20190823154721.GV16384@42.do-not-panic.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <20190822194712.GG16384@42.do-not-panic.com>
 <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
 <20190822211220.GR16384@42.do-not-panic.com>
 <009295ce-bdc5-61d8-b450-5fcdae041922@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <009295ce-bdc5-61d8-b450-5fcdae041922@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 04:30:37PM -0700, Scott Branden wrote:
> On 2019-08-22 2:12 p.m., Luis Chamberlain wrote:
> > On Thu, Aug 22, 2019 at 01:07:41PM -0700, Scott Branden wrote:
> > > On 2019-08-22 12:47 p.m., Luis Chamberlain wrote:
> > > > This implies you having to change the other callers, and while currently
> > > > our list of drivers is small,
> > > Yes, the list is small, very small.
> > > 
> > > There is a single driver making a call to the existing API.
> > > 
> > > And, the maintainer of that driver wanted
> > > to start utilizing my enhanced API instead of the current API.
> > You mean in the near term future? Your change makes it use the full file.
> > Just checking.
> 
> The change in the patch keeps the existing functionality in the
> 

BTW for some reason your mailer keeps adding new lines per each line. I
trim them below. Also for future emails please Cc:

  Mimi Zohar <zohar@linux.ibm.com>

As she'll be interested in some of this from the IMA security perspective.

> qcom mdt_loader by reading the full file using the enhanced api.
> I don't know when Bjorn will switch to use the partial firmware load:
> 
> https://lkml.org/lkml/2019/5/27/9

OK I see he did he liked the approach. OK thanks! This will make
evolutions much easier.

> > > As such I think it is very reasonable to update the API right now.
> > I'd prefer to see it separate, and we fix the race *before* we introduce
> > the new functionality. I'll be poking at that shortly but I should note
> > that I leave on vacation this weekend and won't be back for a good while.
> > I already have an idea of how to approach this.
> > 
> > When the current user want to use the new API it can do so, and then we
> > just kill the older caller.
> 
> We can kill the older api right now as my patch in qcom mdt_loader
> calls the new API which allows reading of full or partial files?

Yes its possible, but more on this below.

> > > > following the history of the firmware API
> > > > and the long history of debate of *how* we should evolve its API, its
> > > > preferred we add yet another new caller for this functionality. So
> > > > please add a new caller, and use EXPORT_SYMBOL_GPL().
> > > > 
> > > > And while at it, pleaase use firmware_request_*() as the prefix, as we
> > > > have want to use that as the instilled prefix. We have yet to complete
> > > > the rename of the others older callers but its just a matter of time.
> > > > 
> > > > So something like: firmware_request_into_buf_offset()
> > > I would prefer to rename the API at this time given there is only a single
> > > user.
> > > 
> > > Otherwise I would need to duplicate quite a bit in the test code to support
> > > testing the single user of the old api and then enhanced API.
> > > Or, I can leave existing API in place and change the test case to
> > > just test the enhanced API to keep things simpler in the test code?
> > If the new user is going to move to the API once available I will be
> > happy to then leave out testing for the older API. That would make
> > sense.
> 
> I have switched the single user of the existing api to the new
> API in the patch already?

Right, but in the new approach you'd use a newer function name with
the new feature.

> And both full and partial reads using the new API are tested with this
> patch series.  If you really insist on keeping the old API for a
> single user I can drop that change from the patch series and have the
> old request_firmware_api call simply be a wrapper calling the new API.

Yes please.

> > But if you do want to keep testing for the old API, and allow an easy
> > removal for it on the test driver, wouldn't a function pointer suffice
> > for which API call to use based on a boolean?
> > 
> > But yeah if we're going to abandon the old mechanism I'm happy to skip
> > its testing.
> 
> We can skip right now then.  As enhanced API is a superset of old API.
> If you want the old API left in place I can just add the wrapper
> described and only test the newly named function and thus indirectly
> test the old request_firmware_into_buf.

Yes this makes sense. But I want to take a bit step back right now and
think about this a bit more. I'm starting to wonder if this whole sysfs
stuff should be replaced with a better scalable scheme. Consider all the
fancy things you can do in userspace with a block device. Offsets are
already supported, and so much more. So I'm starting to think that the
firmware fallback upload sysfs interface is much better suited as a
really simple block device long term.

I understand you want your solutions addressed upstream yesterday, but
this is the *sort of review* on architecture that should have been
done for the request_firmware_into_buf() long ago. But since you
probably don't want to wait for a revamp of the interface, a middle
ground might be in order for now, with the roadmap put in place to
evaluate scalable alternatives.

Either way, we should consider the current bug you ran into for the
solutions put forward, with the new functionality you are proposing.

The core of the issue you ran into was the duplicate named kobjects,
which are reflected also on the sysfs hierarchy. The directory name
created for each firmware request, when duplicate entries exist for
one device collide. Upon a secondary request for firmware using the
fallback interface, the kobject/directory already exists.

Its easier to understand this from a directory hierarchy perspective.
For instance the test driver uses:

/sys/devices/virtual/misc/test_firmware/

The test script for the test_firmware driver uses:

DIR=/sys/devices/virtual/misc/test_firmware/

To load firmware we use a directory underneath this firmware name for
the file name of the firmware requested, so to load firmware called
$name on the test script we use:

echo 1 >"$DIR"/"$name"/loading                                          
cat "$file" >"$DIR"/"$name"/data                                        
echo 0 >"$DIR"/"$name"/loading

An issue no one has cared for, and also we have not hit yet is that,
this implies no firmware names can be used which match other sysfs
attributes exported by a driver. I'm not too concerned for this right
now, but it is a worthy thing to consider long term under a new
solution.

So the issue is that the firmware loader will try to create two equally
named entries underneath the firmware loader directory. Yes we can
sledge hammer the API to act serially, but this is will just
just move one problem to another, your secondary call would have to
wait until the first one not only completes the call, but also
release_firmware() is called.

I'm looking at using a device name prefix if we do add a new API
or functionality. This way userspace can expend and knows what
extra tag to use other than the driver name.

  Luis
