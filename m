Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED784731BF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbjFOO60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjFOO6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:58:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5162946
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 07:58:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso10695a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686841094; x=1689433094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFEMMsnaVMMTN+MNrLJhPSERf9Iz01XRTKYXqWbDbKw=;
        b=q94/N+S0ANP0qfo3iED0X3GUvb12lTH4j3QOzDNGtZE/B+3GOiOiLpIeZ54MPTMd4f
         lwLiM6RyD3FqWgDXOqXvCeLoOQaVfjgXUPDwGWebKkwKb+YuJPikfarnPzMI4LtrmcBp
         y847xtkBebIRxzn8FikqQYnBHrlWutgujnpGaE4VZgsOJWgOTV689TI6qVQ1qvBNqLgG
         4jfDLEuUCHIPmbOpUc2Dhetj7azg6cB+6vZsd/ovfnkOyGmWoR6xsqduCMHyySUhvtDp
         zjwhO1KKBFysS18i7RB4CCsDxAjV2kRP6wynwyVEZExck+itLa+oePesLzVuvAxDNsOi
         g2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686841094; x=1689433094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFEMMsnaVMMTN+MNrLJhPSERf9Iz01XRTKYXqWbDbKw=;
        b=GjuqhnTw2/64P1o3Ravu5QcparPnDTzkOCM8g7Dx9YZo0wty6cdGRCWyKSkJkropuv
         7Qmy3UEAGpIhQIAOE+M/EqLFYNIp3sQ2PxqiD37g+Nod72GPu2hOAG1OHD1YQvbR+k+U
         c+un1FPm264vf7/YrS0WQbXyKtrIQtOQX5qrIkHB9B59ROsEl8wEpqsCJz91sQwmIU3Y
         jG/boO9amrIbMiDTNfEBp2CQlp4/H6XqGRQNbF0PbdpN9bL1dxKnvA7DABXm8E85XOZD
         1tz0o9aIevA6VOx/mShJ3f/Eb37bJO5FVhwLhhZByv19dfzIqLSw+W8UBoOPEogQ55I+
         aiHA==
X-Gm-Message-State: AC+VfDzQEsjmVPvmLB30jyC2whyZWMJZaRq/Zy9ReOI1cUIe9hx6alsI
        I2GHofMEtb9/mq6/ugd5EeMtZ/AXC1uvKKBQfRzCxw==
X-Google-Smtp-Source: ACHHUZ4WXsDVRmMbD5nLQbERxBnWATUeJeVD98IO3VjjPOWmZCV24bKxbxwmLV9CtMkgeyPYIeCORQhTu7shXQ2gF+w=
X-Received: by 2002:a50:9faf:0:b0:514:92e4:ab9f with SMTP id
 c44-20020a509faf000000b0051492e4ab9fmr69956edf.7.1686841093992; Thu, 15 Jun
 2023 07:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com> <CABb0KFHWnbrf2ythvO0OKsd1ZS9b4D9BNzwBCbn6g9OX4n6ZOg@mail.gmail.com>
 <0db01d90-09d6-08a4-bbb8-70670d3baa94@collabora.com> <CABb0KFEn5TU480A=YiN82nLRtGyKMABi8cZjuiGUU_jFZZo+8g@mail.gmail.com>
 <34203acf-7270-7ade-a60e-ae0f729dcf70@collabora.com> <CABb0KFFaXgJD99pWfx3MC+qrq5jUaPis_kZo6U8yL_8xdp0GJA@mail.gmail.com>
 <96b7cc00-d213-ad7d-1b48-b27f75b04d22@collabora.com> <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
In-Reply-To: <CABb0KFEy_mRaT86TEOQ-BoTe_XOVw3Kp5VdzOfEEaiZJuT754g@mail.gmail.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 15 Jun 2023 16:58:02 +0200
Message-ID: <CABb0KFGuqoDh-+FKcsZXxpSFWSM3mcLVQkotGE3RcNiFKh-a2g@mail.gmail.com>
Subject: Re: [PATCH v18 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Jun 2023 at 16:52, Micha=C5=82 Miros=C5=82aw <emmir@google.com> =
wrote:
> On Thu, 15 Jun 2023 at 15:58, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> > I'll send next revision now.
> > On 6/14/23 11:00=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > > (A quick reply to answer open questions in case they help the next ve=
rsion.)
> > >
> > > On Wed, 14 Jun 2023 at 19:10, Muhammad Usama Anjum
> > > <usama.anjum@collabora.com> wrote:
> > >> On 6/14/23 8:14=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > >>> On Wed, 14 Jun 2023 at 15:46, Muhammad Usama Anjum
> > >>> <usama.anjum@collabora.com> wrote:
> > >>>>
> > >>>> On 6/14/23 3:36=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > >>>>> On Tue, 13 Jun 2023 at 12:29, Muhammad Usama Anjum
> > >>>>> <usama.anjum@collabora.com> wrote:
> > >>>>> For flags name: PM_REQUIRE_WRITE_ACCESS?
> > >>>>> Or Is it intended to be checked only if doing WP (as the current =
name
> > >>>>> suggests) and so it would be redundant as WP currently requires
> > >>>>> `p->required_mask =3D PAGE_IS_WRITTEN`?
> > >>>> This is intended to indicate that if userfaultfd is needed. If
> > >>>> PAGE_IS_WRITTEN is mentioned in any of mask, we need to check if
> > >>>> userfaultfd has been initialized for this memory. I'll rename to
> > >>>> PM_SCAN_REQUIRE_UFFD.
> > >>>
> > >>> Why do we need that check? Wouldn't `is_written =3D false` work for=
 vmas
> > >>> not registered via uffd?
> > >> UFFD_FEATURE_WP_ASYNC and UNPOPULATED needs to be set on the memory =
region
> > >> for it to report correct written values on the memory region. Withou=
t UFFD
> > >> WP ASYNC and UNPOUPULATED defined on the memory, we consider UFFD_WP=
 state
> > >> undefined. If user hasn't initialized memory with UFFD, he has no ri=
ght to
> > >> set is_written =3D false.
> > >
> > > How about calculating `is_written =3D is_uffd_registered() &&
> > > is_uffd_wp()`? This would enable a user to apply GET+WP for the whole
> > > address space of a process regardless of whether all of it is
> > > registered.
> > I wouldn't want to check if uffd is registered again and again. This is=
 why
> > we are doing it only once every walk in pagemap_scan_test_walk().
>
> There is no need to do the checks repeatedly. If I understand the code
> correctly, uffd registration is per-vma, so it can be communicated
> from test_walk to entry/hole callbacks via a field in
> pagemap_scan_private.

Actually... this could be exposed as a page category for the filter
(e.g. PAGE_USES_UFFD_WP) and then you could just make the ioctl() to
work for your usecase without tracking the ranges at the userspace
side.

Best Regards
Micha=C5=82 Miros=C5=82aw
