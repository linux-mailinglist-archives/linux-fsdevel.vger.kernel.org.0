Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57546D1225
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjC3WaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC3W37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:29:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468E1BE1;
        Thu, 30 Mar 2023 15:29:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j13so18658666pjd.1;
        Thu, 30 Mar 2023 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680215398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7V03//xrMoj2maIfgC2qsiNLnzTtZRlKFOvF+x+bJg=;
        b=mlMMJ39hyYXqt+JHj1LUKtCdNF3jPgcvR5YIbnZgjG2qBiSoA+kwmOTqtkW+KgUjT+
         f3e/T8MSaieLqfYE0dDEdexsiqrRYKBvODsqM2N1upFbF1vKGKnEQRNu6sm836+CwA5C
         ck0fVumW1XKGVaDTiJc1oZcOOCIV226dBsy+ORXRDdb3DqX9xOqXNxevXkMcMjtEUDFn
         3DS5IHtGgjR5BAJQeAORmm+Co3dYw4PAzJtKWdjXOIijVMdHsC+Mv7hna+osVcIUucg/
         sMDusNSOtuWu7xAgNPPArSDS5AjN3qPzyekWsD7Mi/qHO9lJ1NdSDNgcsKtE2ONpmI68
         vTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7V03//xrMoj2maIfgC2qsiNLnzTtZRlKFOvF+x+bJg=;
        b=6o7qy2ghE+jk/5ofPwYNeI4QpWdVyjYfDNSM0TQHZNE7sscvLiiPuD2c+UMvxkhkuh
         SmkJEdBWFmp2OWCIZjHJNgZscC4O+I5OQRswSS0rS1B3zscTxhSWSONNDTtsyyUpvSge
         PS8JqHSRRKX8AG1AUSdgDhOHcQ87lHS9kRRRPCcZjSKgJwKp7syX9Fr/1qvo3Xia6iCo
         hCnibPPIySq1TGdvhrIaz8WPVIjuCpmIdqpO3cHi6VEKue5t2CncB00p5BwgzHeN8r5T
         ErqeoaYXPlbH6Ygmw5NKp/OnqRuG+yLPzx4P+34hrX1MRyvNr4voKq7Au2VJ4Z4rTYvt
         8spg==
X-Gm-Message-State: AAQBX9e/4dn5WZ7tKJuxFTCb0GlGltJtdYyPCN6VZ/qUjfFSxUBc/9PY
        crpfzNTVJ37SwhiHZdhiwclp1V22H2mStOwqYWw=
X-Google-Smtp-Source: AKy350ZrPyR1hRVTBuZnQUpMEn54ihWHCa7XbNjYLmiSy4XxnRAJ80dimqjvvbOmN9ocOuC+cire+hzLe0DMBMrzkWw=
X-Received: by 2002:a17:90a:fb57:b0:23d:30c2:c5b7 with SMTP id
 iq23-20020a17090afb5700b0023d30c2c5b7mr2603971pjb.3.1680215397861; Thu, 30
 Mar 2023 15:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <beea645603eccbb045ad9bb777e05a085b91808a.1680108414.git.johannes.thumshirn@wdc.com>
 <3a0f0c92-63cb-3624-c2fe-049a76d1a64a@opensource.wdc.com> <CAHbLzkoRdTTbnfz3RyLQAeNJBOEVNGL2WLgRSE2eQ4nR8sRe2g@mail.gmail.com>
 <b19696d3-54bb-d997-5e56-aa5fd58b469f@opensource.wdc.com>
In-Reply-To: <b19696d3-54bb-d997-5e56-aa5fd58b469f@opensource.wdc.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 30 Mar 2023 15:29:46 -0700
Message-ID: <CAHbLzkrEXVDf4TYLw_MPrFNybWQHWXKX=zP5GhxHQFdpVPWhEg@mail.gmail.com>
Subject: Re: [PATCH 18/19] dm-crypt: check if adding pages to clone bio fails
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 5:24=E2=80=AFPM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/30/23 09:17, Yang Shi wrote:
> > On Wed, Mar 29, 2023 at 4:49=E2=80=AFPM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 3/30/23 02:06, Johannes Thumshirn wrote:
> >>> Check if adding pages to clone bio fails and if bail out.
> >>
> >> Nope. The code retries with direct reclaim until it succeeds. Which is=
 very
> >> suspicious...
> >
> > It is not related to bio_add_page() failure. It is used to avoid a
> > race condition when two processes are depleting the mempool
> > simultaneously.
> >
> > IIUC I don't think page merge may happen for dm-crypt, so is
> > __bio_add_page() good enough? I'm working on this code too, using
> > __bio_add_page() would make my patch easier.
>
> If the BIO was allocated with enough bvecs, we could use that function. B=
ut page
> merging reduces overhead, so if it can happen, let's use it.

It does allocate BIO with enough bvecs. IIUC it will merge the
adjacent pages? If so page merging may happen. Since dm-crypt does
allocate BIO with enough bvces, so it can't fail if I read the code
correctly. I'm wondering whether we could have a never fail variant.

>
> >
> >>
> >>>
> >>> This way we can mark bio_add_pages as __must_check.
> >>>
> >>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> With the commit message fixed,
> >>
> >> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >>
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
> >>
> >>
>
> --
> Damien Le Moal
> Western Digital Research
>
