Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513DB2C0539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 13:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgKWMIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 07:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgKWMID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:08:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0702C061A4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 04:08:01 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so14062857pgg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 04:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZwLi5KRkc7YH23f9Wv8M0kLSaVg1GJ6vD+Tr6xYwho=;
        b=IiUZbN+TSyDav/TFnZlOF5BIoECPnwKi34wOtfJVV1hSgL+63lDNLN21fJQbf4qfTK
         kPJsh7mr3uR8ks+wZdJUQXpbGOaI17hhT5b+kxEmFN+7FTu3V4n3A4QEpTwdYQuU6Xdf
         gs4xdupO8MqvBj2FWG4FK38qeNXAMUKhG3VkJNaKEEsD8HOIpI44K4WdIS9TsDQrd+zg
         hUCAHvsszcnML/J61XtxKF5JHyhepM7V5vd4Eu4By5qvkhygu9T2Fx+E7E8Ht5ycDFKS
         uKAMckJC7GOTiLxKFZEg5qNJWunods6f001aPP+OudqhXD7Kk5uXwFxyiWwgT192KQR3
         8cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZwLi5KRkc7YH23f9Wv8M0kLSaVg1GJ6vD+Tr6xYwho=;
        b=Ga9mBVA8zeERiAfBRGhcZ7On1dpAiVPSG5cUfONZNtMmkf5jt5ygPOU/dtIE7zRbZ1
         AdpePvPebUGHDAZps4lq51bTqpPwiEaXxkpFd8e+sC+l9c34vDd5syRZZ1Yy+fME/aVv
         xtOe0Z+6ZY11Ok724M6cWTZ+CAFoh3k7jYJX2QIyrjTOkU/M9mHEB/wnqIbQWDNZr6Yp
         d3heUUZHoDJoEEE7wbwSpOUQ+DdxZrV+QwPMhB/W50h4Gs3fGyjEZxQjFCQRQ0kRN9kc
         pQb0oP4Pqz6xNYQ+8oR61ddjMnw2GbechCY340RenYE9Zpf8V6aFp1bD6upBiUMST4Fe
         6pxQ==
X-Gm-Message-State: AOAM530Wg0JoL3kAbv7M9ecOJvnU9DMBmkGW9Dib5J4v6oH1g9+IuPW9
        OqI1JbqUbO6zy0ls7MWml8viqqK2ZzEOgbtW1HUloA==
X-Google-Smtp-Source: ABdhPJyt/oW7jZAXAavquDzFIuIBuPiB0sOvy5NAGzdC1kKO5etcNhkUOoZ96fOKjlyJJA3BsgbAHkP+UpOtIt47xjE=
X-Received: by 2002:a63:ff18:: with SMTP id k24mr26483211pgi.273.1606133281419;
 Mon, 23 Nov 2020 04:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120084202.GJ3200@dhcp22.suse.cz> <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz> <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz> <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
 <20201123094344.GG27488@dhcp22.suse.cz> <CAMZfGtUjsAKuQ_2NijKGPZYX7OBO_himtBDMKNkYb_0_o5CJGA@mail.gmail.com>
 <20201123104258.GJ27488@dhcp22.suse.cz> <CAMZfGtVzv0qPaK8GALaf8CiaPf2Z9+js24gFtFv5_RfhAyXaRA@mail.gmail.com>
 <20201123113208.GL27488@dhcp22.suse.cz>
In-Reply-To: <20201123113208.GL27488@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 20:07:23 +0800
Message-ID: <CAMZfGtXUNXdqse-tsCFyqePJ65L-1EgkYW416+Hu+_6OVu7FjA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 7:32 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-11-20 19:16:18, Muchun Song wrote:
> > On Mon, Nov 23, 2020 at 6:43 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 23-11-20 18:36:33, Muchun Song wrote:
> > > > On Mon, Nov 23, 2020 at 5:43 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 23-11-20 16:53:53, Muchun Song wrote:
> > > > > > On Mon, Nov 23, 2020 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Fri 20-11-20 23:44:26, Muchun Song wrote:
> > > > > > > > On Fri, Nov 20, 2020 at 9:11 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri 20-11-20 20:40:46, Muchun Song wrote:
> > > > > > > > > > On Fri, Nov 20, 2020 at 4:42 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri 20-11-20 14:43:04, Muchun Song wrote:
> > > > > > > > > > > [...]
> > > > > > > > > > >
> > > > > > > > > > > Thanks for improving the cover letter and providing some numbers. I have
> > > > > > > > > > > only glanced through the patchset because I didn't really have more time
> > > > > > > > > > > to dive depply into them.
> > > > > > > > > > >
> > > > > > > > > > > Overall it looks promissing. To summarize. I would prefer to not have
> > > > > > > > > > > the feature enablement controlled by compile time option and the kernel
> > > > > > > > > > > command line option should be opt-in. I also do not like that freeing
> > > > > > > > > > > the pool can trigger the oom killer or even shut the system down if no
> > > > > > > > > > > oom victim is eligible.
> > > > > > > > > >
> > > > > > > > > > Hi Michal,
> > > > > > > > > >
> > > > > > > > > > I have replied to you about those questions on the other mail thread.
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > One thing that I didn't really get to think hard about is what is the
> > > > > > > > > > > effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> > > > > > > > > > > invalid when racing with the split. How do we enforce that this won't
> > > > > > > > > > > blow up?
> > > > > > > > > >
> > > > > > > > > > This feature depends on the CONFIG_SPARSEMEM_VMEMMAP,
> > > > > > > > > > in this case, the pfn_to_page can work. The return value of the
> > > > > > > > > > pfn_to_page is actually the address of it's struct page struct.
> > > > > > > > > > I can not figure out where the problem is. Can you describe the
> > > > > > > > > > problem in detail please? Thanks.
> > > > > > > > >
> > > > > > > > > struct page returned by pfn_to_page might get invalid right when it is
> > > > > > > > > returned because vmemmap could get freed up and the respective memory
> > > > > > > > > released to the page allocator and reused for something else. See?
> > > > > > > >
> > > > > > > > If the HugeTLB page is already allocated from the buddy allocator,
> > > > > > > > the struct page of the HugeTLB can be freed? Does this exist?
> > > > > > >
> > > > > > > Nope, struct pages only ever get deallocated when the respective memory
> > > > > > > (they describe) is hotremoved via hotplug.
> > > > > > >
> > > > > > > > If yes, how to free the HugeTLB page to the buddy allocator
> > > > > > > > (cannot access the struct page)?
> > > > > > >
> > > > > > > But I do not follow how that relates to my concern above.
> > > > > >
> > > > > > Sorry. I shouldn't understand your concerns.
> > > > > >
> > > > > > vmemmap pages                 page frame
> > > > > > +-----------+   mapping to   +-----------+
> > > > > > |           | -------------> |     0     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     1     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     2     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     3     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     4     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     5     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     6     |
> > > > > > +-----------+                +-----------+
> > > > > > |           | -------------> |     7     |
> > > > > > +-----------+                +-----------+
> > > > > >
> > > > > > In this patch series, we will free the page frame 2-7 to the
> > > > > > buddy allocator. You mean that pfn_to_page can return invalid
> > > > > > value when the pfn is the page frame 2-7? Thanks.
> > > > >
> > > > > No I really mean that pfn_to_page will give you a struct page pointer
> > > > > from pages which you release from the vmemmap page tables. Those pages
> > > > > might get reused as soon sa they are freed to the page allocator.
> > > >
> > > > We will remap vmemmap pages 2-7 (virtual addresses) to page
> > > > frame 1. And then we free page frame 2-7 to the buddy allocator.
> > >
> > > And this doesn't really happen in an atomic fashion from the pfn walker
> > > POV, right? So it is very well possible that
> >
> > Yeah, you are right. But it may not be a problem for HugeTLB pages.
> > Because in most cases, we only read the tail struct page and get the
> > head struct page through compound_head() when the pfn is within
> > a HugeTLB range. Right?
>
> Many pfn walkers would encounter the head page first and then skip over
> the rest. Those should be reasonably safe. But there is no guarantee and
> the fact that you need a valid page->compound_head which might get
> scribbled over once you have the struct page makes this extremely
> subtle.

In this patch series, we can guarantee that the page->compound_head
is always valid. Because we reuse the first tail page. Maybe you need to
look closer at this series. Thanks.


>
> --
>
> SUSE Labs



--
Yours,
Muchun
