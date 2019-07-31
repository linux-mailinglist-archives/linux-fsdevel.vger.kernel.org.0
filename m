Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54F7C321
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfGaNRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 09:17:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:63732 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbfGaNRl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:17:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 06:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="191241302"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2019 06:17:36 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        mm-commits@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, mhocko@suse.cz,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
In-Reply-To: <CAK7LNATF+D5TgTZijG3EPBVON5NmN+JcwmCBvnvkMFyR+3wF2A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org> <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org> <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com> <CAK7LNASLfyreDPvNuL1svvHPC0woKnXO_bsNku4DMK6UNn4oHw@mail.gmail.com> <5e5353e2-bfab-5360-26b2-bf8c72ac7e70@infradead.org> <CAK7LNATF+D5TgTZijG3EPBVON5NmN+JcwmCBvnvkMFyR+3wF2A@mail.gmail.com>
Date:   Wed, 31 Jul 2019 16:21:58 +0300
Message-ID: <87v9vimj9l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 05 Jul 2019, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> On Fri, Jul 5, 2019 at 12:23 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 7/4/19 8:09 PM, Masahiro Yamada wrote:
>> > On Fri, Jul 5, 2019 at 12:05 PM Masahiro Yamada
>> > <yamada.masahiro@socionext.com> wrote:
>> >>
>> >> On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> >>>
>> >>> On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
>> >>>> The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
>> >>>>
>> >>>>    http://www.ozlabs.org/~akpm/mmotm/
>> >>>>
>> >>>> mmotm-readme.txt says
>> >>>>
>> >>>> README for mm-of-the-moment:
>> >>>>
>> >>>> http://www.ozlabs.org/~akpm/mmotm/
>> >>>
>> >>> I get a lot of these but don't see/know what causes them:
>> >>>
>> >>> ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
>> >>> make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
>> >>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
>> >>> make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
>> >>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
>> >>>
>> >>
>> >> I checked next-20190704 tag.
>> >>
>> >> I see the empty file
>> >> drivers/gpu/drm/i915/oa/Makefile
>> >>
>> >> Did someone delete it?
>> >>
>> >
>> >
>> > I think "obj-y += oa/"
>> > in drivers/gpu/drm/i915/Makefile
>> > is redundant.
>>
>> Thanks.  It seems to be working after deleting that line.
>
>
> Could you check whether or not
> drivers/gpu/drm/i915/oa/Makefile exists in your source tree?
>
> Your build log says it was missing.
>
> But, commit 5ed7a0cf3394 ("drm/i915: Move OA files to separate folder")
> added it.  (It is just an empty file)
>
> I am just wondering why.

I've sent patches adding some content, and they'll make their way
upstream eventually. I am not sure why the empty file was added
originally. Perhaps as a placeholder, seemed benign enough.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
