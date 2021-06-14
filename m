Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB843A6C95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhFNRDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhFNRC7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FE6611C1;
        Mon, 14 Jun 2021 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623690056;
        bh=7iMl6YWN5AAOYzZBpWX/eEVFpy+IzMJ9khgpokIOPyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpBtaTRL2kH+P7hq4lH5uSTVhat+kchmH3KHZkk8D09fXytlYCzjwbp6qo0EqqfeS
         P74Orzf4PorJCN+DwYaNasW9xG2oBIF1FPYyfNQCAB1mUNngHKqx8mCXS+aps/KMFz
         6oklC/0YoJwkpZDQTFB6FbKp1EWHG0wwR3YN+xNc=
Date:   Mon, 14 Jun 2021 19:00:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] driver core: Allow showing cpu as offline if not
 valid in cpuset context
Message-ID: <YMeLRfBNX00SAUqs@kroah.com>
References: <20210614152306.25668-1-longman@redhat.com>
 <20210614152306.25668-5-longman@redhat.com>
 <YMd7PEU0KPulsgMz@kroah.com>
 <ad33a662-7ebe-fb92-4459-5dd85a013501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad33a662-7ebe-fb92-4459-5dd85a013501@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:32:01PM -0400, Waiman Long wrote:
> On 6/14/21 11:52 AM, Greg KH wrote:
> > On Mon, Jun 14, 2021 at 11:23:06AM -0400, Waiman Long wrote:
> > > Make /sys/devices/system/cpu/cpu<n>/online file to show a cpu as
> > > offline if it is not a valid cpu in a proper cpuset context when the
> > > cpuset_bound_cpuinfo sysctl parameter is turned on.
> > This says _what_ you are doing, but I do not understand _why_ you want
> > to do this.
> > 
> > What is going to use this information?  And now you are showing more
> > files than you previously did, so what userspace tool is now going to
> > break?
> 
> One reason that is provided by the customer asking for this functionality is
> because some applications use the number of cpu cores for licensing purpose.
> Even though the applications are running in a container with a smaller set
> of cpus, they may still charge as if all the cpus are available. They ended
> up using a bind mount to mount over the cpuX/online file.

Great, then stick with the bind mount for foolish things like that.

There's no technical reason for doing this then, just marketing?

thanks,

greg k-h
