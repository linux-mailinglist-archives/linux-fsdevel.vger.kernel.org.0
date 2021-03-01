Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04197327647
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 04:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhCADCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 22:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhCADCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 22:02:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDBC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Feb 2021 19:01:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jx13so6638166pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Feb 2021 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GSiKByfZ5sqEV0qlOVhjWGxYdaWwaDIUdK2lORLzOS0=;
        b=ScCVJ0YypEy9MWpAu9R+ZNlfSdfwEpgJAxQFP/l3D0VDMmjBCQ3vzrVPFWhT25prCj
         QXpGyxHcSbNpVLiMISI/iCjxFsHc4dDIkA4EuVtGQmdynb1UUw3QA3C6177M7HJJpVdQ
         2oHKGLvEm/skQ9iXU55IE9jzrKshZDXrVsz50f78kRmzg/lL+MFtIFxR1Ep2Tyick7TF
         WFSl4S2UJPWN9MUz74NFEXEqpZNcJ8zRf4RchXpZ+64i22hXDYsJWA2BmFOuszbLCYWY
         r/jwOV0+WCDa7Onk+WEWPlrFNUFBH60Ids0G9DKUKvkOOAbTk4gN2Ri1da1QBerJFzlI
         dewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GSiKByfZ5sqEV0qlOVhjWGxYdaWwaDIUdK2lORLzOS0=;
        b=MOu8M7vlNWvSJQ8FDzHHNxRWfycKsPAfPVFxFTw06sPJkuixKXM81DjOIRdLFNC0jk
         c4d5kMcBQpqmnxUiOeeETSobvZNJ698GvWMJ0RUx9s64Q8amVeds0tBVxNrhTrfuMJi3
         XqkV42q2o8NdmULIVCqwxNrPqS3wEV6zNOQE5ZBP9iWG7vnReo9tYjvi1xCW1xVtyJAR
         5IZcwWDLtjjQnIBIJIRuYnDqTHfUjzWdV1O66Ix+Zhdvc9FWzhW1pf0fMXkwGVt58GVQ
         eyp/3NO7VzByXxoV86vOLA1B3f576yD0adwqx7mAX4w1AoS8zxT33pWLRTlge2J9uu0R
         /2+A==
X-Gm-Message-State: AOAM532gHAXBr4hk9vuTKM4dqnMuNV/l19a2t/3U7K/4+6mboU35sO/X
        8vxjDXP4ckpOEByjPV2nWTVybaaLWIHjjGcrtWfMfQ==
X-Google-Smtp-Source: ABdhPJwEVjHQ1fPeJFLixQCWUSnlzdl/87wWdv9p8yk+ouhkV58sQu0KSI0Fa2jLhHCKNFak15hUdD0cupv16k+ZTO4=
X-Received: by 2002:a17:902:e54e:b029:e3:9f84:db8e with SMTP id
 n14-20020a170902e54eb02900e39f84db8emr13640880plf.24.1614567719209; Sun, 28
 Feb 2021 19:01:59 -0800 (PST)
MIME-Version: 1.0
References: <FE7425D7-3006-4F31-AE41-07E4EB6D030F@contoso.com>
In-Reply-To: <FE7425D7-3006-4F31-AE41-07E4EB6D030F@contoso.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 1 Mar 2021 11:01:23 +0800
Message-ID: <CAMZfGtUY6z3g1_=mj8_LAWcxc_OKVfwPQq9vrdhdkjs=hyW5rQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 1/9] mm: memory_hotplug: factor out
 bootmem core functions to bootmem_info.c
To:     "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 2:06 AM Bodeddula, Balasubramaniam
<bodeddub@amazon.com> wrote:
>
> Tested-by: bodeddub@amazon.com

Very thanks for your test.

>
>
>
> We are interested in this patch and have tested an earlier version of thi=
s patch on 5.11-rc4 kernel version. I did a functional validation of the ch=
anges and saw that the total memory listed by free command increasing and m=
ore memory was made available when memory was allocated in hugepages. 1G hu=
gepages gave higher improvements compared to 2M, as expected. Is there a fo=
rmal way to publish the results? I can do the same as required (I am new to=
 Linux Kernel patching process).

I don=E2=80=99t know if there is a formal way. But maybe you can share
the test result directly through this thread. If someone knows
this, please let me know. Thanks.

>
>
>
> I have a few follow-up questions on this patch:
>
> 1. What is the overall status of this patch? What is the ballpark timelin=
e we are looking for this patch to be accepted.

There is only one patch of this patchset that has no reviewed-by tag.
I think it might be 5.13 in the best case But I don't have the right to
decide.

>
> 2. Why is this patch not working when memory is allocated as hugepages by=
 THP (transparent hugepages). THP uses AnonHugePages, doesn=E2=80=99t this =
patch generalize for all =E2=80=98type=E2=80=99 of hugepages?

Now it only supports HugeTLB pages. THP is a little different
and complex compared to HugeTLB. I need to investigate THP
in depth to determine the possible problems.

>
>
>
> Please let me know if there are any additional tasks that I can help. Hap=
py to help.
>
>
>
> Thanks.
