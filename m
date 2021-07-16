Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC553CB088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 03:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhGPBlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 21:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232269AbhGPBlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626399487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFq05Mxb6wfhQF2PLXbGbBSyezSecvtSC13kxNCwXC0=;
        b=faTxjTgB93Pdd5puGMdVMkEOWfRD/mVdruvK+zhq52wR+EyIT/7kC54Z8ic9Oe2J0mi8eO
        uzJjLWI9g02PXRMDGfmigKs6zGkX5hMwHx9PngOpuYga4sK4Yk8EsgJzOKO6S/ujOuUXXu
        RYupWLNAGOm37ysp5LkGBRgdZCYZm18=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-FDHIv7mENJaWytLlj_fEig-1; Thu, 15 Jul 2021 21:38:05 -0400
X-MC-Unique: FDHIv7mENJaWytLlj_fEig-1
Received: by mail-pj1-f72.google.com with SMTP id u12-20020a17090abb0cb029016ee12ec9a1so4441055pjr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 18:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFq05Mxb6wfhQF2PLXbGbBSyezSecvtSC13kxNCwXC0=;
        b=dFLqAKEXRZ0DzqXHt9umWjUDvAJCNhrCm0OcC8dV8EGKVrm1yuLtK9eTNs6VG99JV7
         o9D0Nq7jrZBZNCgSH3X9y+JXe3CeAwXb8vZIzZKlyBYxv9KuMUvbxNe9DLWsUCsD/tyQ
         KmY8D8eyeY3+d0hAur5zzSelydSaAdX088bDt9Obcr+tR7euakNOkcZtAG7MOu3oGJLR
         4Ghz/1pV1TpW1TP0h7DyIWYaZkLrCqUMTdjPfuImoINXSiUIqLRgiHyGiisb6mcmsMPu
         oRY6U1HDKugc0H9/+H6JA5Bn6LdcSJnS3KVrKfGIOuyxrZPa0ZZRJLXw9QdR1eqQ6Yff
         vfFg==
X-Gm-Message-State: AOAM532p/asT/HEauH48gw6O+3p1olRpoWrd9LcuojTe55jv+t9xXuUv
        /Wgsra90AYH2FQ6+PFttvuCq8hlwU6yTqpd9aMKC3ca7QmS2ZMvKgQy0gLxhYA2heHfXGsrNS54
        UW2JIwkxaYKYgLtG/pbLf7HHGVUbaIiH73eI0HLvHxQ==
X-Received: by 2002:a63:e046:: with SMTP id n6mr7363485pgj.15.1626399484929;
        Thu, 15 Jul 2021 18:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxksG1LprG44DVv5AkYfzW+1cBntUbMakRkqZdQjvbfQI367/Jdv1FMZaGLepM/Gb9USWZ09TzSvc9yW9JiJo=
X-Received: by 2002:a63:e046:: with SMTP id n6mr7363460pgj.15.1626399484597;
 Thu, 15 Jul 2021 18:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com> <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz> <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO93VTcLDNisdHRf@carbon.dhcp.thefacebook.com> <CAHLe9YaNtmJ8xx=A+6Ki+Fc2Kx=5jL745NJ8PL+w95-WhJrG3g@mail.gmail.com>
 <20210715093117.GD9457@quack2.suse.cz> <YPBcqIAjaGtTAskK@carbon.dhcp.thefacebook.com>
In-Reply-To: <YPBcqIAjaGtTAskK@carbon.dhcp.thefacebook.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Fri, 16 Jul 2021 09:37:53 +0800
Message-ID: <CAHLe9YYBPudWU9rwkhN7OkXFF=gSmqxD8eBcUjBLiM+y6kErPQ@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:05 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jul 15, 2021 at 11:31:17AM +0200, Jan Kara wrote:
> > On Thu 15-07-21 09:42:06, Boyang Xue wrote:
> > > On Thu, Jul 15, 2021 at 7:46 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > > > > Hi Jan,
> > > > >
> > > > > On Wed, Jul 14, 2021 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> > > > > > > Hi Roman,
> > > > > > >
> > > > > > > On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > I'm not sure if this is the right place to report this bug, please
> > > > > > > > > correct me if I'm wrong.
> > > > > > > > >
> > > > > > > > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > > > > > > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > > > > > > > it looks like the bug had been introduced by the commit
> > > > > > > > >
> > > > > > > > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > > > > > > > >
> > > > > > > > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > > > > > > > was performed with the latest xfstests, and the bug can be reproduced
> > > > > > > > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> > > > > > > >
> > > > > > > > Hello Boyang,
> > > > > > > >
> > > > > > > > thank you for the report!
> > > > > > > >
> > > > > > > > Do you know on which line the oops happens?
> > > > > > >
> > > > > > > I was trying to inspect the vmcore with crash utility, but
> > > > > > > unfortunately it doesn't work.
> > > > > >
> > > > > > Thanks for report!  Have you tried addr2line utility? Looking at the oops I
> > > > > > can see:
> > > > >
> > > > > Thanks for the tips!
> > > > >
> > > > > It's unclear to me that where to find the required address in the
> > > > > addr2line command line, i.e.
> > > > >
> > > > > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > > > > <what address here?>
> > > >
> > > > You can use $nm <vmlinux> to get an address of cleanup_offline_cgwbs_workfn()
> > > > and then add 0x320.
> > >
> > > Thanks! Hope the following helps:
> >
> > Thanks for the data!
> >
> > > static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > > {
> > >         struct bdi_writeback *wb;
> > >         LIST_HEAD(processed);
> > >
> > >         spin_lock_irq(&cgwb_lock);
> > >
> > >         while (!list_empty(&offline_cgwbs)) {
> > >                 wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> > >                                       offline_node);
> > >                 list_move(&wb->offline_node, &processed);
> > >
> > >                 /*
> > >                  * If wb is dirty, cleaning up the writeback by switching
> > >                  * attached inodes will result in an effective removal of any
> > >                  * bandwidth restrictions, which isn't the goal.  Instead,
> > >                  * it can be postponed until the next time, when all io
> > >                  * will be likely completed.  If in the meantime some inodes
> > >                  * will get re-dirtied, they should be eventually switched to
> > >                  * a new cgwb.
> > >                  */
> > >                 if (wb_has_dirty_io(wb))
> > >                         continue;
> > >
> > >                 if (!wb_tryget(wb))  <=== line#679
> > >                         continue;
> >
> > Aha, interesting. So it seems we crashed trying to dereference
> > wb->refcnt->data. So it looks like cgwb_release_workfn() raced with
> > cleanup_offline_cgwbs_workfn() and percpu_ref_exit() got called from
> > cgwb_release_workfn() and then cleanup_offline_cgwbs_workfn() called
> > wb_tryget(). I think the proper fix is to move:
> >
> >         spin_lock_irq(&cgwb_lock);
> >         list_del(&wb->offline_node);
> >         spin_unlock_irq(&cgwb_lock);
> >
> > in cgwb_release_workfn() to the beginning of that function so that we are
> > sure even cleanup_offline_cgwbs_workfn() cannot be working with the wb when
> > it is being released. Roman?
>
> Yes, it sounds like the most reasonable explanation.
> Thank you!
>
> Boyang, would you mind to test the following patch?

No problem. I'm testing it. Thanks for the patch.

>
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 271f2ca862c8..f5561ea7d90a 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -398,12 +398,12 @@ static void cgwb_release_workfn(struct work_struct *work)
>         blkcg_unpin_online(blkcg);
>
>         fprop_local_destroy_percpu(&wb->memcg_completions);
> -       percpu_ref_exit(&wb->refcnt);
>
>         spin_lock_irq(&cgwb_lock);
>         list_del(&wb->offline_node);
>         spin_unlock_irq(&cgwb_lock);
>
> +       percpu_ref_exit(&wb->refcnt);
>         wb_exit(wb);
>         WARN_ON_ONCE(!list_empty(&wb->b_attached));
>         kfree_rcu(wb, rcu);
>

