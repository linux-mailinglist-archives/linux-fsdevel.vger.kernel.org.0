Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8804259E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbhJGRwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhJGRwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:52:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5BC061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 10:50:37 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u32so15152635ybd.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZcdFdLklF2D8wG5a28IWE28EnK8YrlZxMIkR94gcXg=;
        b=ii4rM8LzrLeipvkrLI6sF2XMP2pYN1zP2MMXV9cnIwjuzdbJHr0PQpeFOd3KTC+40n
         daj4ueJa2JF/8jd+7KE8ZpdESfFGK5l4m+2s8U8LxGYrHX3x2VnHVb6hcN50EYm5gTpM
         b15jPV6rJ1CCYg/qLLGgQltU7yUdmfasW7NkOnV9MZdefsJJgTwXpLQwCUZ0cvTxYu4b
         FM0XFSlN0hRSDl5ECN2ziCzhqY8CIM7jdFMI6hhJQTQQlt6bdbIr+oONLgaiJRJ2+bwz
         bV6byWHhxCzFT5G1xzBWvTFIQOn3OnOsIl8tjkX58LjAx81lAkDOzCb/AbEjkB4ITKcI
         LjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZcdFdLklF2D8wG5a28IWE28EnK8YrlZxMIkR94gcXg=;
        b=os/GYRPNTS1toRilFVWCmF1LoRLFoP1Uo8gnQdmSUDztsdA69MzoI7UmDmA0GLFnsI
         ht1Y3jKE91NZ69fGO+5uGwX4faPAdv81jpeqk6VSIKGbQXht0PczbPxhYzAFKmDH3ChO
         CxqwBqCl0tMuUCPcbA/Ul+EmnHSyRCV/m/ijaldqxCA6hyOsziuMXm+T2MsSV7VHLjpk
         H+pXB1Am3YfOnpSevH+OEY+QOL3M7VGUFeyVCwysClTIvbfQAiBhJE0GE4YTTqvKknUk
         9fJH5tcIhWBY1j1b4HTdLfe3+2GdDN3+rIUlUSln3sFdh/sfS64fSnW8ux/TCf6+RNxg
         wuuQ==
X-Gm-Message-State: AOAM533ZHTy6mjgiJifZreq5YefZXCnxDrl3nswT6uxBpZSnGiXOUWk0
        48HCp97tTrU6Y2HW8NC6rFDdQR9GFXHLbx/tVJBnsg==
X-Google-Smtp-Source: ABdhPJzonqs+AS4DlbvO/k8YV4nKIvqr0EcskkQ9+A+HIiE+vy9vaOXsKpto3iotn3+zxTci6VKhVWtr6PxcbeG6eUs=
X-Received: by 2002:a25:8411:: with SMTP id u17mr6232017ybk.376.1633629035946;
 Thu, 07 Oct 2021 10:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz> <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz> <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
In-Reply-To: <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 10:50:24 -0700
Message-ID: <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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

On Thu, Oct 7, 2021 at 10:31 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-10-21 09:58:02, Suren Baghdasaryan wrote:
> > On Thu, Oct 7, 2021 at 9:40 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> > > > On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > > >> Hmm, so the suggestion is to have some directory which contains files
> > > > > > >> representing IDs, each containing the string name of the associated
> > > > > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > > > > >> would have to scan that directory, check all files and see if any of
> > > > > > >> them contain the name we want to reuse the same ID.
> > > > > > >
> > > > > > > I believe Pavel meant something as simple as
> > > > > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > > > > $ touch $YOUR_FILE
> > > > > > > $ stat -c %i $YOUR_FILE
> > > >
> > > > Ah, ok, now I understand the proposal. Thanks for the clarification!
> > > > So, this would use filesystem as a directory for inode->name mappings.
> > > > One rough edge for me is that the consumer would still need to parse
> > > > /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> > > > just dumping the content for the user. Would it be acceptable if we
> > > > require the ID provided by prctl() to always be a valid inode and
> > > > show_map_vma() would do the inode-to-filename conversion when
> > > > generating maps/smaps files? I know that inode->dentry is not
> > > > one-to-one mapping but we can simply output the first dentry name.
> > > > WDYT?
> > >
> > > No. You do not want to dictate any particular way of the mapping. The
> > > above is just one way to do that without developing any actual mapping
> > > yourself. You just use a filesystem for that. Kernel doesn't and
> > > shouldn't understand the meaning of those numbers. It has no business in
> > > that.
> > >
> > > In a way this would be pushing policy into the kernel.
> >
> > I can see your point. Any other ideas on how to prevent tools from
> > doing this id-to-name conversion themselves?
>
> I really fail to understand why you really want to prevent them from that.
> Really, the whole thing is just a cookie that kernel maintains for memory
> mappings so that two parties can understand what the meaning of that
> mapping is from a higher level. They both have to agree on the naming
> but the kernel shouldn't dictate any specific convention because the
> kernel _doesn't_ _care_. These things are not really anything actionable
> for the kernel. It is just a metadata.

The desire is for one of these two parties to be a human who can get
the data and use it as is without additional conversions.
/proc/$pid/maps could report FD numbers instead of pathnames, which
could be converted to pathnames in userspace. However we do not do
that because pathnames are more convenient for humans to identify a
specific resource. Same logic applies here IMHO.

>
> --
> Michal Hocko
> SUSE Labs
