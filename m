Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880D0425EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbhJGVeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhJGVeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:34:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D1C061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 14:32:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q189so16574225ybq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLOXetc7YBsFaoXhbAiQwjFQGKVuF+LsdrpZkpJ+Yn8=;
        b=I7CD544nPG2Zflz/Gmzk0gLTZ7/XyNqM8T4Eficx6meLX3T7YHuRuP9RVKBBvNs/P2
         mhyB+AAsIFAsz1EGzZuY3ezfjym+9cyyXdAXexeO5MF5zTh5JVDgUEdfeHi14X2IJ8l7
         5lDTy2C1wHckIghEmN/nVKQeMWg6GqUrXa4AQrOs55U0gAhE+XcLoCfbJkQfpfZRI1Nu
         dsLeERidXU0RJ4NSQYbaySX/CsVAG6TVC615Am35UMCjL6hrFjEx70Z27rFSJu7+qRzM
         OfblfwbTiIipcqehK3HiWYnpFL3J6FGlnwT9QlijReFRI62FoG06AFMdZdDpoUIWIAZu
         7sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLOXetc7YBsFaoXhbAiQwjFQGKVuF+LsdrpZkpJ+Yn8=;
        b=UYzY3wdRkpvMeTGg/fDx67wCNT6CRqZSkP7kU73E7tTH5GNVUCp5Ytli0ovYif2LY5
         911XCZrO9J6trSjiOxtDRmj+wvJCa4kj6KzybiCQM9v1Kdo6ALjXIrIxaMxfQXzLvN2L
         MNci0O1gijEJmzPcnCREFDsVkEQ5xWE6imqjSSIw2Gfa2BgDzsypq2USXt4TQHRhi+yx
         W/JDhy7ngJkyToDBMNnPLTcM3TZUG6Xjyq6ZbiZNsKXn3stDcplLic9e8KbF/1ZnPVuY
         mDAk9ky9JTCIcU9hjuyDqqLAAKeXDthXtq9H0FlvBa0Q/nDIdSsetfBAWywjuVPdcD7G
         5qQQ==
X-Gm-Message-State: AOAM533g2mL6oDB0FyZlc6K0s1YXDkZQX4eDfZKU0IzXgVKmv+dWd3Bb
        5w5Vk9eJApRoDPYecPdMaPfxBsOy7keNGP78CObZiw==
X-Google-Smtp-Source: ABdhPJw+6Zfp/de4q4PUFURmsm27H9dUiP8PYD3C452O9dUP9v1kYwwmNSfCZmVsZsUTThCuCkm06GukPScYtl8lfN0=
X-Received: by 2002:a25:3:: with SMTP id 3mr7689141yba.418.1633642337263; Thu,
 07 Oct 2021 14:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211006175821.GA1941@duo.ucw.cz> <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz> <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
 <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
In-Reply-To: <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 14:32:06 -0700
Message-ID: <CAJuCfpHJmDeyTXdsO8T5tTLgcNT22b15hj41EBNCDXBAoCdpog@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 7, 2021 at 12:03 PM 'John Hubbard' via kernel-team
<kernel-team@android.com> wrote:
>
> On 10/7/21 11:50, Suren Baghdasaryan wrote:
> ...
> >>>>>>>>>> I believe Pavel meant something as simple as
> >>>>>>>>>> $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> >>>>>>>>>> $ touch $YOUR_FILE
> >>>>>>>>>> $ stat -c %i $YOUR_FILE
> >>>>>>>
> >>>>>>> Ah, ok, now I understand the proposal. Thanks for the clarification!
> >>>>>>> So, this would use filesystem as a directory for inode->name mappings.
> >>>>>>> One rough edge for me is that the consumer would still need to parse
> >>>>>>> /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> >>>>>>> just dumping the content for the user. Would it be acceptable if we
> >>>>>>> require the ID provided by prctl() to always be a valid inode and
> >>>>>>> show_map_vma() would do the inode-to-filename conversion when
> >>>>>>> generating maps/smaps files? I know that inode->dentry is not
> >>>>>>> one-to-one mapping but we can simply output the first dentry name.
> >>>>>>> WDYT?
> >>>>>>
> >>>>>> No. You do not want to dictate any particular way of the mapping. The
> >>>>>> above is just one way to do that without developing any actual mapping
> >>>>>> yourself. You just use a filesystem for that. Kernel doesn't and
> >>>>>> shouldn't understand the meaning of those numbers. It has no business in
> >>>>>> that.
> >>>>>>
> >>>>>> In a way this would be pushing policy into the kernel.
> >>>>>
> >>>>> I can see your point. Any other ideas on how to prevent tools from
> >>>>> doing this id-to-name conversion themselves?
> >>>>
> >>>> I really fail to understand why you really want to prevent them from that.
> >>>> Really, the whole thing is just a cookie that kernel maintains for memory
> >>>> mappings so that two parties can understand what the meaning of that
> >>>> mapping is from a higher level. They both have to agree on the naming
> >>>> but the kernel shouldn't dictate any specific convention because the
> >>>> kernel _doesn't_ _care_. These things are not really anything actionable
> >>>> for the kernel. It is just a metadata.
> >>>
> >>> The desire is for one of these two parties to be a human who can get
> >>> the data and use it as is without additional conversions.
> >>> /proc/$pid/maps could report FD numbers instead of pathnames, which
> >>> could be converted to pathnames in userspace. However we do not do
> >>> that because pathnames are more convenient for humans to identify a
> >>> specific resource. Same logic applies here IMHO.
> >>
> >> Yes, please. It really seems like the folks that are interested in this
> >> feature want strings. (I certainly do.) For those not interested in the
> >> feature, it sounds like a CONFIG to keep it away would be sufficient.
> >> Can we just move forward with that?
> >
> > Would love to if others are ok with this.
> >
>
> If this doesn't get accepted, then another way forward would to continue
> the ideas above to their logical conclusion, and create a new file system:
> vma-fs.  Like debug-fs and other special file systems, similar policy and
> motivation. Also protected by a CONFIG option.

TBH, I would prefer to have the current simple solution protected with
a CONFIG option.

>
> Actually this seems at least as natural as the procfs approach, especially
> given the nature of these strings, which feel more like dir+file names, than
> simple strings.
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
