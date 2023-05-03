Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8C6F5520
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjECJqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjECJpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:45:42 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A925B92;
        Wed,  3 May 2023 02:45:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74de7182043so222613985a.3;
        Wed, 03 May 2023 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107101; x=1685699101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu1/caV96gPScaPWMCtnkWIUIUcxiUGOiQt9hLifgPw=;
        b=VhDxBqzjRGO4xEvrUoTELhpqFpNqdt+CVDZ+RfOG21FgkmixgwMMdwK/NneQ7mOOcc
         yhGPzgIBNau3G+2U9K7Xt4a9gdggrYOnkpWS/wNla11FYYg09l2IaImcnU5+b9MibRcR
         k9v90h1Rsd7vskA6KQe8SRuvpU0sLUxitSFfsDPXj87uFGSdWAnrfcOx/eIuqMMyzqhk
         CZB3LVF8x3HzsHEtVrXZagn8mwxC1GFztjcfWkPZzT8tLdcTHbvRug9Ltx2dxhrAfuC2
         +waxUOke8lDu/8kEPIx91rOnvSt36w2a70UZk/8uywir3znA4RllKMN+w9ENvaPVPtXq
         x7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107101; x=1685699101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu1/caV96gPScaPWMCtnkWIUIUcxiUGOiQt9hLifgPw=;
        b=B3rVo2uyw06jIberJgxw43HzLzO4oU0txTf58pTEOVkuzv445C5CQHeivCqRJK94DQ
         zD5AyFJZov2lAQQu1/Dhc7NbRJJ330IK2Lq99VgBitm4x17uBTbrdyzBeNcbAWLzJEbj
         4aVa6+n6lTGk3QCbYOObdORizIVMNMFMNewrjvhcymlPPXzkPXcH1nSrX8cVPYkEzcNu
         +KY7b7C7R3fV0HI1N7zSAYqkk8dDcfcKjypNU96IbgDY2mEzr/8GmCiBd6IkBH4LFkA0
         c9v2DjK91/Ap/5QwyT/0befUib0/vyUw7AomNa7UpRnxEDPfNlVRo8oqqwYJvbK6I9Zk
         RSZQ==
X-Gm-Message-State: AC+VfDzF6LSYZDCts26/4+JsGxyqFtn4dr663WhBpBquw7oGtcNkiQ1u
        e78G/GJPDafpfsxqQMf2VOZlzqiEpB7Er+8gECg=
X-Google-Smtp-Source: ACHHUZ6yi+LLZmqHyLDaoBpk27DTVexvbnD/0m840PDBVgRRMFVAguYf3NnMhxz4oEixavoWuRx1ThmZystGlNmkfIs=
X-Received: by 2002:a05:6214:2629:b0:61b:17bd:c603 with SMTP id
 gv9-20020a056214262900b0061b17bdc603mr10563566qvb.9.1683107101117; Wed, 03
 May 2023 02:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan> <2f5ebe8a9ce8471906a85ef092c1e50cfd7ddecd.camel@HansenPartnership.com>
 <20230502225016.GJ2155823@dread.disaster.area> <b6857aad-4cfc-4961-df54-6e658fca7f75@suse.cz>
In-Reply-To: <b6857aad-4cfc-4961-df54-6e658fca7f75@suse.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 May 2023 12:44:24 +0300
Message-ID: <CAHp75VddBGrrkRGQcU=ZOXANaj2SznPGG4eQ8Q2NrGYbLK7Xog@mail.gmail.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's output
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?B?Tm9yYWxmIFRyw6/Cv8K9bm5lcw==?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 12:28=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 5/3/23 00:50, Dave Chinner wrote:
> > On Tue, May 02, 2023 at 07:42:59AM -0400, James Bottomley wrote:
> >> On Mon, 2023-05-01 at 23:17 -0400, Kent Overstreet wrote:
> >> > On Mon, May 01, 2023 at 10:22:18PM -0400, James Bottomley wrote:
> >> > > It is not used just for debug.  It's used all over the kernel for
> >> > > printing out device sizes.  The output mostly goes to the kernel
> >> > > print buffer, so it's anyone's guess as to what, if any, tools are
> >> > > parsing it, but the concern about breaking log parsers seems to be
> >> > > a valid one.
> >> >
> >> > Ok, there is sd_print_capacity() - but who in their right mind would
> >> > be trying to scrape device sizes, in human readable units,
> >>
> >> If you bother to google "kernel log parser", you'll discover it's quit=
e
> >> an active area which supports a load of company business models.
> >
> > That doesn't mean log messages are unchangable ABI. Indeed, we had
> > the whole "printk_index_emit()" addition recently to create
> > an external index of printk message formats for such applications to
> > use. [*]
> >
> >> >  from log messages when it's available in sysfs/procfs (actually, is
> >> > it in sysfs? if not, that's an oversight) in more reasonable units?
> >>
> >> It's not in sysfs, no.  As aren't a lot of things, which is why log
> >> parsing for system monitoring is big business.
> >
> > And that big business is why printk_index_emit() exists to allow
> > them to easily determine how log messages change format and come and
> > go across different kernel versions.
> >
> >> > Correct me if I'm wrong, but I've yet to hear about kernel log
> >> > messages being consider a stable interface, and this seems a bit out
> >> > there.
> >>
> >> It might not be listed as stable, but when it's known there's a large
> >> ecosystem out there consuming it we shouldn't break it just because yo=
u
> >> feel like it.
> >
> > But we've solved this problem already, yes?
> >
> > If the userspace applications are not using the kernel printk format
> > index to detect such changes between kernel version, then they
> > should be. This makes trivial issues like whether we have a space or
> > not between units is completely irrelevant because the entry in the
> > printk format index for the log output we emit will match whatever
> > is output by the kernel....
>
> If I understand that correctly from the commit changelog, this would have
> indeed helped, but if the change was reflected in format string. But with
> string_get_size() it's always an %s and the change of the helper's or a
> switch to another variant of the helper that would omit the space, wouldn=
't
> be reflected in the format string at all? I guess that would be an argume=
nt
> for Andy's suggestion for adding a new %pt / %pT which would then be

(Note, there is no respective %p extension for string_get_size() yet.
%pt is for time and was used as an example when its evolution included
a change like this)

> reflected in the format string. And also more concise to use than using t=
he
> helper, fwiw.



--=20
With Best Regards,
Andy Shevchenko
