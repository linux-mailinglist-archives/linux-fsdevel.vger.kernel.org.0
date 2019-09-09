Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44ADAD16C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfIIAmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 20:42:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:20874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731753AbfIIAmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 20:42:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 17:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,483,1559545200"; 
   d="scan'208";a="186351311"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga003.jf.intel.com with ESMTP; 08 Sep 2019 17:42:09 -0700
Subject: Re: [kbuild-all] [PATCH 3/3] mm: Allow find_get_page to be used for
 large pages
To:     Matthew Wilcox <willy@infradead.org>,
        kbuild test robot <lkp@intel.com>
Cc:     Song Liu <songliubraving@fb.com>, Johannes Weiner <jweiner@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, kbuild-all@01.org,
        linux-fsdevel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>
References: <20190905182348.5319-4-willy@infradead.org>
 <201909060632.Sn0F0fP6%lkp@intel.com>
 <20190905221232.GU29434@bombadil.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <4b8c3a4d-5a16-6214-eb34-e7a5b36aeb71@intel.com>
Date:   Mon, 9 Sep 2019 08:42:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190905221232.GU29434@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/6/19 6:12 AM, Matthew Wilcox wrote:
> On Fri, Sep 06, 2019 at 06:04:05AM +0800, kbuild test robot wrote:
>> Hi Matthew,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [cannot apply to v5.3-rc7 next-20190904]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> It looks like you're not applying these to the -mm tree?  I thought that
> was included in -next.

Hi,

Sorry for the inconvenience, we'll look into it. and 0day-CI introduced 
'--base' option to record base tree info in format-patch.
could you kindly add it to help robot to base on the right tree? please 
see https://stackoverflow.com/a/37406982

Best Regards,
Rong Chen

>
>
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all

