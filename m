Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370F453C2C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 04:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiFCBgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 21:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiFCBgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:36:39 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5305133A04;
        Thu,  2 Jun 2022 18:36:38 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ArwVZJ64Dro/DWqQeyRqkjgxRtMXGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0mcEmzQcX2nXaKuPZGv0ct9zPY+y905XucTdx4djQFc5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyTh4ZTMkBOun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6La6TOxtj8MjIeHrIYoAt3AmxjbcZd4mSpDrQqPE/9ZU0?=
 =?us-ascii?q?T48wMdUEp72eMsdbStHbRLOeRRDN14bTpUkk4+AinD5NT8et1ORoas+5nP7zQp?=
 =?us-ascii?q?t3byrO93QEvSGR9pSmEmwpW/c+Wn9RBYAO7S3zTuD72Lpg+rnnj3yU4FUE6e3n?=
 =?us-ascii?q?tZjg0WW7mgSDgAGEFW8vP+1g1K/XNQZLFYbkgIos6Qz8UmDStjmQwb+pH+Cow5?=
 =?us-ascii?q?aV9dOe8U84Qacw+zU5ByYCXUPTj9pbtEt8sQxQFQC1FaPkpXiBSFHt6ecQnaQs?=
 =?us-ascii?q?LyTqFuaIycSKWMddCksVhYe7p/vrekbihPJU8YmHrW5g8P4HRnuzD2Q6isznbM?=
 =?us-ascii?q?eiYgMzarT1VTGhS+845vEVAg44i3JUW+/qAB0foioY8qv81ezxfJBKpuJC0mPp?=
 =?us-ascii?q?1AalMWEquMDF5eAkGqKWuplNK+o/fGtIjDagEApG5gn6iTr/GSsO51TiAySjm8?=
 =?us-ascii?q?B3t0sIGevORGM/1gKosI7AZdjVocvC6rZNijg5fGI+QzZa83p?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtJB6VqFW5lr8p9qlpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124680776"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 09:36:37 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id D86C64D68A22;
        Fri,  3 Jun 2022 09:36:36 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 09:36:35 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 09:36:37 +0800
Received: from [10.167.201.2] (10.167.201.2) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 09:36:36 +0800
Message-ID: <73a4d378-ea7d-1423-778c-c757bdc631c4@fujitsu.com>
Date:   Fri, 3 Jun 2022 09:36:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
 <20220602115640.69f7f295e731e615344a160a@linux-foundation.org>
 <09048a58-65ea-b92c-5586-dc337bf18d1a@fujitsu.com>
In-Reply-To: <09048a58-65ea-b92c-5586-dc337bf18d1a@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: D86C64D68A22.A0F03
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/6/3 9:07, Shiyang Ruan 写道:
> 
> 
> 在 2022/6/3 2:56, Andrew Morton 写道:
>> On Sun, 8 May 2022 22:36:06 +0800 Shiyang Ruan 
>> <ruansy.fnst@fujitsu.com> wrote:
>>
>>> This is a combination of two patchsets:
>>>   1.fsdax-rmap: 
>>> https://lore.kernel.org/linux-xfs/20220419045045.1664996-1-ruansy.fnst@fujitsu.com/ 
>>>
>>>   2.fsdax-reflink: 
>>> https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/ 
>>>
>>
>> I'm getting lost in conflicts trying to get this merged up.  Mainly
>> memory-failure.c due to patch series "mm, hwpoison: enable 1GB hugepage
>> support".
>>
>> Could you please take a look at what's in the mm-unstable branch at
>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm a few hours from
>> now?  Or the next linux-next.

OK, let me rebase this patchset on your mm-unstable branch.


--
Thanks,
Ruan.

>>
>> And I suggest that converting it all into a single 14-patch series
>> would be more straightforward.
> 
> The patchset in this thread is the 14-patch series.  I have solved many 
> conflicts.  It's an updated / newest version, and a combination of the 2 
> urls quoted above.  In an other word, instead of using this two:
> 
>  >> This is a combination of two patchsets:
>  >>   1.fsdax-rmap: https://...
>  >>   2.fsdax-reflink: https://...
> 
> you could take this (the url of the current thread):
> https://lore.kernel.org/linux-xfs/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/ 
> 
> 
> My description misleaded you.  Sorry for that.
> 
> 
> -- 
> Thanks,
> Ruan.
> 
>>
>> Thanks.
> 
> 
> 


