Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383D64B79F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 22:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiBOVva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 16:51:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiBOVv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:51:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA92E1B45
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 13:51:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y9so475149pjf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UF22wzNFpm2IeXFXPkRt/7QTNpA2ZS3NNacg1G/BHTA=;
        b=aLkLiUl2q3+S6eeMXpypsrxoD5fjO9umu93awZL2f4DtK7iBq9t1st5HRP4P9rgAKQ
         vbbbxGJdWSs0YTXYqaQOXspsbJuV/Ut61sGZKXIhgZ+Ao1l2oLI2a3lopePAqvNg0AM/
         kDMZ1kpGbiLtcFI4B2ZqtAbaAHRBWRiCwoQbOyqM63uY3euR9sdAmumj5oYMSCVi95Ns
         1sW4wxDTlXLSh9B6p0n0D3UkJbjeDvFRKeSYt2Q+/kQzExnf7VeE2lpE7rMUEQZ5fScV
         u6euyIJCEvIB0kJrnAAehROqriwI5p8Dq4L2NbjbKWOUOEKsNVQpkAWi+LR6NKEvikDK
         GEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UF22wzNFpm2IeXFXPkRt/7QTNpA2ZS3NNacg1G/BHTA=;
        b=oCieEtSm+lFm6cvaRfaJsE61WXAdXjRI9Zbvv9lmJtF2SS93M46o2BBp9YjPXt756A
         d8MJjjIz+7eoxnRCVc8u+lxh6Mqdfxklytjf5lMqrP19FDd6s9YqHLxGVrmErhrwGkAx
         mnjZes4dqI1qs9zalACPtvZFZVzOmI/tKMU+nyNiWk2ze/aicWXg97XVPtf6vFaaclD0
         Om/AUBb640Klef6eEEmK16xjo4CvtXKQ++R4Ufv55vkgnH1vxelxPrWroHcmBpoYESRf
         QYyRcoS0CBkfdxcuVd+yW/ByHHeBAaTc1OBqQnqxVii04shM50d9Sel9cdWJ+2nPoqqS
         qOfA==
X-Gm-Message-State: AOAM530UZ6BTmLukS93Wmq+AcLfZjjqDsHK5VMkES1hzlL7lNR3dE4ID
        cg7qhgNOnj9miNRTlRlRuLhBpk7nruOgV/+m1y0Ekg==
X-Google-Smtp-Source: ABdhPJwiWSTwvDiLHvEHx5jVlkEcfKkWS636fiMP5bezJwAkxTbJWDUQr5zyAmugPr7yn16pxbnRwJ5XVgTvcXGjjUQ=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr753705plr.132.1644961876547;
 Tue, 15 Feb 2022 13:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20220105181230.GC398655@magnolia> <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
 <20220105185626.GE398655@magnolia> <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
 <20220105224727.GG398655@magnolia> <CAPcyv4iZ88FPeZC1rt_bNdWHDZ5oh7ua31NuET2-oZ1UcMrH2Q@mail.gmail.com>
 <20220105235407.GN656707@magnolia> <CAPcyv4gUmpDnGkhd+WdhcJVMP07u+CT8NXRjzcOTp5KF-5Yo5g@mail.gmail.com>
 <YekhXENAEYJJNy7e@infradead.org> <76f5ed28-2df9-890e-0674-3ef2f18e2c2f@fujitsu.com>
 <20220121022200.GG13563@magnolia>
In-Reply-To: <20220121022200.GG13563@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 13:51:10 -0800
Message-ID: <CAPcyv4gXp66bc6dkN+F8pUdxwCj=wmkOebjmPdALyKKZSOczoQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>, Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 6:22 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Jan 21, 2022 at 09:26:52AM +0800, Shiyang Ruan wrote:
> >
> >
> > =E5=9C=A8 2022/1/20 16:46, Christoph Hellwig =E5=86=99=E9=81=93:
> > > On Wed, Jan 05, 2022 at 04:12:04PM -0800, Dan Williams wrote:
> > > > We ended up with explicit callbacks after hch balked at a notifier
> > > > call-chain, but I think we're back to that now. The partition mista=
ke
> > > > might be unfixable, but at least bdev_dax_pgoff() is dead. Notifier
> > > > call chains have their own locking so, Ruan, this still does not ne=
ed
> > > > to touch dax_read_lock().
> > >
> > > I think we have a few options here:
> > >
> > >   (1) don't allow error notifications on partitions.  And error retur=
n from
> > >       the holder registration with proper error handling in the file
> > >       system would give us that
>
> Hm, so that means XFS can only support dax+pmem when there aren't
> partitions in use?  Ew.
>
> > >   (2) extent the holder mechanism to cover a rangeo
>
> I don't think I was around for the part where "hch balked at a notifier
> call chain" -- what were the objections there, specifically?  I would
> hope that pmem problems would be infrequent enough that the locking
> contention (or rcu expiration) wouldn't be an issue...?
>
> > >   (3) bite the bullet and create a new stacked dax_device for each
> > >       partition
> > >
> > > I think (1) is the best option for now.  If people really do need
> > > partitions we'll have to go for (3)
> >
> > Yes, I agree.  I'm doing it the first way right now.
> >
> > I think that since we can use namespace to divide a big NVDIMM into mul=
tiple
> > pmems, partition on a pmem seems not so meaningful.
>
> I'll try to find out what will happen if pmem suddenly stops supporting
> partitions...

Finally catching up with this thread...

Given that XFS already has the policy of disabling DAX rather than
failing the mount in some cases, I think it is workable for XFS to
fail a DAX mount if reflink is enabled on a partition. This should not
regress anyone's current setup since the FS will not even mount with
dax+reflink today. As to the specific concern about registering
failure handlers for other purposes I expect that can be done by
registering failure notification handlers on block devices, not dax
devices.

So it's not that pmem will suddenly stop supporting partitions, dax
will simply never gain support for reflink in the presence of
partitions.
