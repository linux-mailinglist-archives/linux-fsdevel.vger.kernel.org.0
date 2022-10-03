Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB965F2BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiJCIfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 04:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJCIek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:34:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80C6BD5C
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Oct 2022 01:06:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so13437729eda.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Oct 2022 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cTF3AiWCQzUZJV3DQOd8YpyAQ0uZN+oT26/EmVI5Gno=;
        b=DvdRFGG3GDv+8INZlnRFdJ/8sk5eEa7AareONRXiJEau+xbhzZax6uLRyfYITFWbZf
         3NqpZEEzMP/hKmEkCARYJ5G9gzbOE0q7McTWIAngIxaTuYC1o8lT6E0RUJP/MLnLpZ7d
         Qu+1Vd0FUnf6Z7BDCSiXfOB3Lp6wjhae3evjWtqy1Hvhcufb4H2zsgnTlazKt2OEhd79
         BA6ZEelvKbFypTSJOPXKwWi6F96cJdE1vUQrd76EmQ0Smui1y+dlW96zT/pi7JhI5c/2
         8NZeHRiN3xgZc7P9e5p+GcKW4B3xAZ9Q9xeU6JSlAtM3mdUAbXU1rYpnUGpgYkW0Wdos
         uORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cTF3AiWCQzUZJV3DQOd8YpyAQ0uZN+oT26/EmVI5Gno=;
        b=A2jnI1L1435GZgoQk0nwNN1HWRTDuK6wUJBSYbCKHz1EgZchxFyk8p6rUkGH5IALeh
         lRJ2i5w+1ZRQJBP/Q952Lm0q/ITQjqvXGrfVyg4HvZyoHrhCDuigMhbz8dJfjCwxRj2B
         3IEztSk3e93bM+ajbhFSY6QbG1gD1M2tfjKRY4Ki3Kn5PD9W1KMApzJjVGVH7lQ/EyQ3
         Ugz4AbusUDsVDWUmN6qxjVWeYzwLtLzWqnSgk9XBYeg+krBkJPNOLeJCNuRJafnoeCRp
         Xq9h0gxzN5DKPn+Q5UiRgbU205b9GG85BMzdlCmreaXb5x6tnEkCMQvzFweJOrYrgwPW
         hkXw==
X-Gm-Message-State: ACrzQf3fESXlX0afIz1ySKH/wlt3hQOJPrGw8N654MQdLeujvoXjH18I
        UqTsnjUlAmq5fLDBbpBNQFlHm8BPtrSi7alrRU8uhM6qj3stuzX/
X-Google-Smtp-Source: AMsMyM54UDKb/wQylYbThizMTNEzG/N4GHFJjCY1YMNV55ssdwv1emM1/33fLKcW7+Q244fzhfIJ6l3JiIpmQNO4rxw=
X-Received: by 2002:a05:6512:261b:b0:4a1:abd7:3129 with SMTP id
 bt27-20020a056512261b00b004a1abd73129mr7271284lfb.637.1664782430012; Mon, 03
 Oct 2022 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <CA+EHjTyrexb_LX7Jm9-MGwm4DBvfjCrADH4oumFyAvs2_0oSYw@mail.gmail.com>
 <20220930162301.i226o523teuikygq@box.shutemov.name>
In-Reply-To: <20220930162301.i226o523teuikygq@box.shutemov.name>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 3 Oct 2022 08:33:13 +0100
Message-ID: <CA+EHjTyphrouY1FV2NQOBLDG81JYhiHFGBNKjT1K2j+pVNij+A@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

On Fri, Sep 30, 2022 at 5:23 PM Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Fri, Sep 30, 2022 at 05:14:00PM +0100, Fuad Tabba wrote:
> > Hi,
> >
> > <...>
> >
> > > diff --git a/mm/memfd_inaccessible.c b/mm/memfd_inaccessible.c
> > > new file mode 100644
> > > index 000000000000..2d33cbdd9282
> > > --- /dev/null
> > > +++ b/mm/memfd_inaccessible.c
> > > @@ -0,0 +1,219 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "linux/sbitmap.h"
> > > +#include <linux/memfd.h>
> > > +#include <linux/pagemap.h>
> > > +#include <linux/pseudo_fs.h>
> > > +#include <linux/shmem_fs.h>
> > > +#include <uapi/linux/falloc.h>
> > > +#include <uapi/linux/magic.h>
> > > +
> > > +struct inaccessible_data {
> > > +       struct mutex lock;
> > > +       struct file *memfd;
> > > +       struct list_head notifiers;
> > > +};
> > > +
> > > +static void inaccessible_notifier_invalidate(struct inaccessible_data *data,
> > > +                                pgoff_t start, pgoff_t end)
> > > +{
> > > +       struct inaccessible_notifier *notifier;
> > > +
> > > +       mutex_lock(&data->lock);
> > > +       list_for_each_entry(notifier, &data->notifiers, list) {
> > > +               notifier->ops->invalidate(notifier, start, end);
> > > +       }
> > > +       mutex_unlock(&data->lock);
> > > +}
> > > +
> > > +static int inaccessible_release(struct inode *inode, struct file *file)
> > > +{
> > > +       struct inaccessible_data *data = inode->i_mapping->private_data;
> > > +
> > > +       fput(data->memfd);
> > > +       kfree(data);
> > > +       return 0;
> > > +}
> > > +
> > > +static long inaccessible_fallocate(struct file *file, int mode,
> > > +                                  loff_t offset, loff_t len)
> > > +{
> > > +       struct inaccessible_data *data = file->f_mapping->private_data;
> > > +       struct file *memfd = data->memfd;
> > > +       int ret;
> > > +
> > > +       if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > +               if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > +                       return -EINVAL;
> > > +       }
> > > +
> > > +       ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> >
> > I think that shmem_file_operations.fallocate is only set if
> > CONFIG_TMPFS is enabled (shmem.c). Should there be a check at
> > initialization that fallocate is set, or maybe a config dependency, or
> > can we count on it always being enabled?
>
> It is already there:
>
>         config MEMFD_CREATE
>                 def_bool TMPFS || HUGETLBFS
>
> And we reject inaccessible memfd_create() for HUGETLBFS.
>
> But if we go with a separate syscall, yes, we need the dependency.

I missed that, thanks.

>
> > > +       inaccessible_notifier_invalidate(data, offset, offset + len);
> > > +       return ret;
> > > +}
> > > +
> >
> > <...>
> >
> > > +void inaccessible_register_notifier(struct file *file,
> > > +                                   struct inaccessible_notifier *notifier)
> > > +{
> > > +       struct inaccessible_data *data = file->f_mapping->private_data;
> > > +
> > > +       mutex_lock(&data->lock);
> > > +       list_add(&notifier->list, &data->notifiers);
> > > +       mutex_unlock(&data->lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(inaccessible_register_notifier);
> >
> > If the memfd wasn't marked as inaccessible, or more generally
> > speaking, if the file isn't a memfd_inaccessible file, this ends up
> > accessing an uninitialized pointer for the notifier list. Should there
> > be a check for that here, and have this function return an error if
> > that's not the case?
>
> I think it is "don't do that" category. inaccessible_register_notifier()
> caller has to know what file it operates on, no?

The thing is, you could oops the kernel from userspace. For that, all
you have to do is a memfd_create without the MFD_INACCESSIBLE,
followed by a KVM_SET_USER_MEMORY_REGION using that as the private_fd.
I ran into this using my port of this patch series to arm64.

Cheers,
/fuad


> --
>   Kiryl Shutsemau / Kirill A. Shutemov
