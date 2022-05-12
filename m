Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2567524CC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiELM1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiELM1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 08:27:19 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C69C13F5C;
        Thu, 12 May 2022 05:27:17 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A2J3H0ahOgBolD7Tcll9Sgf2TX161nREKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUBzjEZXTvTPPbeMWWmc91/bYm//UNVsZHWzdBiQQpv/nw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl7ZXDnhaYKRMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTTuhqg8UqK8nmFIMCs25tzHfSCvNOaZDIQ43L49FC1?=
 =?us-ascii?q?Ts9j8wIGuzRD+IGaD5rfTzBZRNVM1saAZ54m/2n7lHzejseqhSKpK4z4mHW1yR?=
 =?us-ascii?q?w1qTgNJzefdnibclXgUGeqUrF8n7/DxVcM8aQoRKB83SxlqrKmAv4RosZF/u/7?=
 =?us-ascii?q?PECqFSQ3mk7DBwQSEv+r/6kjEK3R9NYLQoT4CVGha4s+E2uS/H5XgakuziAvxg?=
 =?us-ascii?q?BS5xcHvNSwAeEzbvdpQaeHGkLUzVBafQgucRwTjsvvneLltXkQzdvrZWSU3uW8?=
 =?us-ascii?q?rrSpjS3UQAPImgGaTAVSyMe/sLu5o0+5jrLT9B+AOu7ldH4Bzz06y6FoTJ4hLg?=
 =?us-ascii?q?Ji8MPkaKh8jjvhzOqu4iMTQMv4AjTdnyq4xk/Z4O/YYGsr1/B4p5oKIefU0nEr?=
 =?us-ascii?q?HYfs9aR4fpIDpyXkiGJBuIXE9mB+fefNxXOjFhuAd8l9jKw6zikZ48W/TIWGav?=
 =?us-ascii?q?DGq7oYhewOAmK51wXv8QVYROXgWZMS9rZI6wXIWLITLwJjszpU+c=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMdotua02tTX0AwwoyLJmZwqjBFYkLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvbo9fxG+85rrCMc6QxhPk3I9uruBEDtewK5yXcx2/h3AV7AZmfbUQ?=
 =?us-ascii?q?mTQL2KhLGKq1aLdhEWtNQtsJuIGJIfNDSfNykYsS+32miF+sgbsaS62ZHtleHD?=
 =?us-ascii?q?1G1sUA0vT6lh6j1yAgGdHlYefng8ObMJUIqb+tFcpyetPVAebsGADHEDWOTZ4/?=
 =?us-ascii?q?LRkpaOW299OzcXrBmJkSiz6KP3VzyR3hIlWTtJxrs4tUjp+jaJnpmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124189362"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 May 2022 20:27:17 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 0124C4D1716B;
        Thu, 12 May 2022 20:27:13 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 12 May 2022 20:27:13 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 12 May 2022 20:27:10 +0800
Message-ID: <32f51223-c671-1dc0-e14a-8887863d9071@fujitsu.com>
Date:   Thu, 12 May 2022 20:27:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
To:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
 <20220511000352.GY27195@magnolia>
 <20220511014818.GE1098723@dread.disaster.area>
 <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
 <20220510192853.410ea7587f04694038cd01de@linux-foundation.org>
 <20220511024301.GD27195@magnolia>
 <20220510222428.0cc8a50bd007474c97b050b2@linux-foundation.org>
 <20220511151955.GC27212@magnolia>
 <CAPcyv4gwV5ReuCUbJHZPVPUJjnaGFWibCLLsH-XEgyvbn9RkWA@mail.gmail.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <CAPcyv4gwV5ReuCUbJHZPVPUJjnaGFWibCLLsH-XEgyvbn9RkWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 0124C4D1716B.A2F85
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/5/11 23:46, Dan Williams 写道:
> On Wed, May 11, 2022 at 8:21 AM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> Oan Tue, May 10, 2022 at 10:24:28PM -0700, Andrew Morton wrote:
>>> On Tue, 10 May 2022 19:43:01 -0700 "Darrick J. Wong" <djwong@kernel.org> wrote:
>>>
>>>> On Tue, May 10, 2022 at 07:28:53PM -0700, Andrew Morton wrote:
>>>>> On Tue, 10 May 2022 18:55:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>>>>>
>>>>>>> It'll need to be a stable branch somewhere, but I don't think it
>>>>>>> really matters where al long as it's merged into the xfs for-next
>>>>>>> tree so it gets filesystem test coverage...
>>>>>>
>>>>>> So how about let the notify_failure() bits go through -mm this cycle,
>>>>>> if Andrew will have it, and then the reflnk work has a clean v5.19-rc1
>>>>>> baseline to build from?
>>>>>
>>>>> What are we referring to here?  I think a minimal thing would be the
>>>>> memremap.h and memory-failure.c changes from
>>>>> https://lkml.kernel.org/r/20220508143620.1775214-4-ruansy.fnst@fujitsu.com ?
>>>>>
>>>>> Sure, I can scoot that into 5.19-rc1 if you think that's best.  It
>>>>> would probably be straining things to slip it into 5.19.
>>>>>
>>>>> The use of EOPNOTSUPP is a bit suspect, btw.  It *sounds* like the
>>>>> right thing, but it's a networking errno.  I suppose livable with if it
>>>>> never escapes the kernel, but if it can get back to userspace then a
>>>>> user would be justified in wondering how the heck a filesystem
>>>>> operation generated a networking errno?
>>>>
>>>> <shrug> most filesystems return EOPNOTSUPP rather enthusiastically when
>>>> they don't know how to do something...
>>>
>>> Can it propagate back to userspace?
>>
>> AFAICT, the new code falls back to the current (mf_generic_kill_procs)
>> failure code if the filesystem doesn't provide a ->memory_failure
>> function or if it returns -EOPNOSUPP.  mf_generic_kill_procs can also
>> return -EOPNOTSUPP, but all the memory_failure() callers (madvise, etc.)
>> convert that to 0 before returning it to userspace.
>>
>> I suppose the weirder question is going to be what happens when madvise
>> starts returning filesystem errors like EIO or EFSCORRUPTED when pmem
>> loses half its brains and even the fs can't deal with it.
> 
> Even then that notification is not in a system call context so it
> would still result in a SIGBUS notification not a EOPNOTSUPP return
> code. The only potential gap I see are what are the possible error
> codes that MADV_SOFT_OFFLINE might see? The man page is silent on soft
> offline failure codes. Shiyang, that's something to check / update if
> necessary.

According to the code around MADV_SOFT_OFFLINE, it will return -EIO when 
the backend is NVDIMM.

Here is the logic:
  madvise_inject_error() {
      ...
      if (MADV_SOFT_OFFLINE) {
          ret = soft_offline_page() {
              ...
              /* Only online pages can be soft-offlined (esp., not 
ZONE_DEVICE). */
              page = pfn_to_online_page(pfn);
              if (!page) {
                  put_ref_page(ref_page);
                  return -EIO;
              }
              ...
          }
      } else {
          ret = memory_failure()
      }
      return ret
  }


--
Thanks,
Ruan.


