Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4432785D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 08:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhCAHlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 02:41:18 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:34593 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232574AbhCAHlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:41:17 -0500
IronPort-SDR: tGvBDWbOft83eNsQjRioYLiVBVz1iyTh5nEUdQtY/rAjCbWstI0P576mQxG76VXSQw4xGhrL2O
 4pwBXFGLFfhyEbZhAR/Mgsk0Y5Jr5w8MEPfKH8NLh/OX8XS0Nr1OYGhwmOZpX+d7dbK3mK+0Zu
 k6MIMtLyZivYsUNlCwnuq4wnqvQFqUY3d/d+V53NnFfS+l32tQyX/4P0l4NjWnCus3LwP1B33G
 r72yxnXbCv2gEGqjmBh+qABH4oGmwPuvAC4E8deFIwy0n12gZGnaDb5KFX3wnOvJPF3pKE4Q81
 sgE=
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="20943770"
X-IronPort-AV: E=Sophos;i="5.81,214,1610377200"; 
   d="scan'208";a="20943770"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Mar 2021 16:26:47 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id CC3C2E60A7;
        Mon,  1 Mar 2021 16:26:46 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D3CCE15331;
        Mon,  1 Mar 2021 16:26:45 +0900 (JST)
Received: from [10.133.113.145] (VPC-Y08P0560117.g01.fujitsu.local [10.133.113.145])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id A473F2A7;
        Mon,  1 Mar 2021 16:26:45 +0900 (JST)
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia>
 <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
From:   Yasunori Goto <y-goto@fujitsu.com>
Message-ID: <556921a1-456c-c24d-6d47-e8b15c1d9972@fujitsu.com>
Date:   Mon, 1 Mar 2021 16:26:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Dan-san,

On 2021/02/27 4:24, Dan Williams wrote:
> On Fri, Feb 26, 2021 at 11:05 AM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
>>> Hi, guys
>>>
>>> Beside this patchset, I'd like to confirm something about the
>>> "EXPERIMENTAL" tag for dax in XFS.
>>>
>>> In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
>>> when we mount a pmem device with dax option, has been existed for a
>>> while.  It's a bit annoying when using fsdax feature.  So, my initial
>>> intention was to remove this tag.  And I started to find out and solve
>>> the problems which prevent it from being removed.
>>>
>>> As is talked before, there are 3 main problems.  The first one is "dax
>>> semantics", which has been resolved.  The rest two are "RMAP for
>>> fsdax" and "support dax reflink for filesystem", which I have been
>>> working on.
>>
>> <nod>
>>
>>> So, what I want to confirm is: does it means that we can remove the
>>> "EXPERIMENTAL" tag when the rest two problem are solved?
>>
>> Yes.  I'd keep the experimental tag for a cycle or two to make sure that
>> nothing new pops up, but otherwise the two patchsets you've sent close
>> those two big remaining gaps.  Thank you for working on this!
>>
>>> Or maybe there are other important problems need to be fixed before
>>> removing it?  If there are, could you please show me that?
>>
>> That remains to be seen through QA/validation, but I think that's it.
>>
>> Granted, I still have to read through the two patchsets...
> 
> I've been meaning to circle back here as well.
> 
> My immediate concern is the issue Jason recently highlighted [1] with
> respect to invalidating all dax mappings when / if the device is
> ripped out from underneath the fs. I don't think that will collide
> with Ruan's implementation, but it does need new communication from
> driver to fs about removal events.
> 
> [1]: http://lore.kernel.org/r/CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com
> 

I'm not sure why there is a race condition between unbinding operation 
and accessing mmaped file on filesystem dax yet.

May be silly question, but could you tell me why the "unbinding" 
operation of the namespace which is mounted by filesystem dax must be
allowed?
If "unbinding" is rejected when the filesystem is mounted with dax 
enabled, what is inconvenience?

I can imagine if a device like usb memory stick is removed surprisingly, 
kernel/filesystem need to reject writeback at the time, and discard page 
cache. Then, I can understand that unbinding operation is essential for 
such case.
But I don't know why PMEM device/namespace allows unbinding operation 
like surprising removal event.

Thanks,

-- 
Yasunori Goto
