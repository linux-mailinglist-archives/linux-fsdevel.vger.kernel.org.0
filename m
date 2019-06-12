Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF4E41D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407719AbfFLG6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 02:58:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:45279 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390376AbfFLG6i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:58:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 23:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; 
   d="scan'208";a="184148897"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2019 23:58:34 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
In-Reply-To: <Pine.LNX.4.44L0.1906110950440.1535-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1906110950440.1535-100000@iolanthe.rowland.org>
Date:   Wed, 12 Jun 2019 09:58:33 +0300
Message-ID: <87h88v1e92.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 11 Jun 2019, Felipe Balbi wrote:
>
>> >> >> > So for "severe" issues, yes, we should do this, but perhaps not for all
>> >> >> > of the "normal" things we see when a device is yanked out of the system
>> >> >> > and the like.
>> >> >> 
>> >> >> Then what counts as a "severe" issue?  Anything besides enumeration 
>> >> >> failure?
>> >> >
>> >> > Not that I can think of at the moment, other than the other recently
>> >> > added KOBJ_CHANGE issue.  I'm sure we have other "hard failure" issues
>> >> > in the USB stack that people will want exposed over time.
>> >> 
>> >> From an XHCI standpoint, Transaction Errors might be one thing. They
>> >> happen rarely and are a strong indication that the bus itself is
>> >> bad. Either bad cable, misbehaving PHYs, improper power management, etc.
>> >
>> > Don't you also get transaction errors if the user unplugs a device in 
>> > the middle of a transfer?  That's not the sort of thing we want to sent 
>> > notifications about.
>> 
>> Mathias, do we get Transaction Error if user removes cable during a
>> transfer? I thought we would just get Port Status Change with CC bit
>> cleared, no?
>
> Even if xHCI doesn't give Transaction Errors when a cable is unplugged 
> during a transfer, other host controllers do.  Sometimes quite a lot -- 
> they continue to occur until the kernel polls the parent hub's 
> interrupt ep and learns that the port is disconnected, which can take 
> up to 250 ms.

my comment was specific about XHCI. It even started with "From an XHCI
standpoint" :-)

-- 
balbi
