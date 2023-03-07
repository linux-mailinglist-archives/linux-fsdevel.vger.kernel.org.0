Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073816AD92D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCGIWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCGIWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFE2D153
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 00:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678177301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBji0LNsTbKnr3CZbmzWKYlrRFmfjW4GaBRuCv1xIV8=;
        b=Yul2Ws7LFNPbhgDx63WZu0otXavuul4pHjH/s+GBfVvyEklGmceNtPGFaBwNHhFJ0wkcyq
        R31t7hKuhMYKhaNMQxY0V0e60s0M2k+GsPXuDFGi6enVWiySkDSIGmbSez6C06vzUrBuwi
        c59umd1a8cYeVHF/xTjR+rOncuvzEHA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-RSCiYz3JMY6n1gUG1KHf-A-1; Tue, 07 Mar 2023 03:21:39 -0500
X-MC-Unique: RSCiYz3JMY6n1gUG1KHf-A-1
Received: by mail-io1-f70.google.com with SMTP id n42-20020a056602342a00b0074cde755b99so6829976ioz.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 00:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBji0LNsTbKnr3CZbmzWKYlrRFmfjW4GaBRuCv1xIV8=;
        b=WKMeNBSJkfzF1fq9taJBmNEfzJ6gPgPUxdtbaOwIuw3XPfyC2n+Zv6HpkzRjReBzEa
         MNdVWBPOvn361vR5loWLsfmRp9kd7utT/0oYQsjBPrrfrGhoNWPRnaWSn/WoepUeov6b
         U0ArWntcguAGClxXc1y6elhSJDpSL5ty7wRrEZAvg65ziXdUKl2zSGHWFLJHN1RXSNPD
         L+CGAs/aRIVC2Ox9PaXXlQzxj8gJKOPCWYYdnAcwVc7T3l+vJBp6t+Q9xSAfarxZ0DNi
         U3zzW1+XlfuP/eTgvjza9aNvuLV9rSZsl4JVdz1uCASLt3tzVlO5A5Bz2yad+QyDsS/+
         dekA==
X-Gm-Message-State: AO0yUKWQgFmVuHj+z9tlQW5c5wjgTHqX/QixdJQBUIokMIldZAlmVDja
        qjcbylUH8dGPlbN5Yy7cZnSQclkCERf2Ykwx6gQhLEAbtFv8S50XOCIWjl97Xttr+y+rTvyA7m0
        Jwr9v9Ji0FChk3g4xJUhEE6c8wJxxpUuztM2LONziGg==
X-Received: by 2002:a02:a98f:0:b0:3c5:1490:5775 with SMTP id q15-20020a02a98f000000b003c514905775mr7054359jam.1.1678177298953;
        Tue, 07 Mar 2023 00:21:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+pi74784V3aUFUKUApsQ/WCFXo8yfDBfLzkgDCyFQ4UQgKGFgVOGTUcgURNG5/Amga6IuppxYJwXxso7K5O3o=
X-Received: by 2002:a02:a98f:0:b0:3c5:1490:5775 with SMTP id
 q15-20020a02a98f000000b003c514905775mr7054355jam.1.1678177298680; Tue, 07 Mar
 2023 00:21:38 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com> <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com>
In-Reply-To: <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 7 Mar 2023 09:21:27 +0100
Message-ID: <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 6, 2023 at 5:17=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:

> >> I tested the performance of "ls -lR" on the whole tree of
> >> cs9-developer-rootfs.  It seems that the performance of erofs (generat=
ed
> >> from mkfs.erofs) is slightly better than that of composefs.  While the
> >> performance of erofs generated from mkfs.composefs is slightly worse
> >> that that of composefs.
> >
> > I suspect that the reason for the lower performance of mkfs.composefs
> > is the added overlay.fs-verity xattr to all the files. It makes the
> > image larger, and that means more i/o.
>
> Actually you could move overlay.fs-verity to EROFS shared xattr area (or
> even overlay.redirect but it depends) if needed, which could save some
> I/Os for your workloads.
>
> shared xattrs can be used in this way as well if you care such minor
> difference, actually I think inlined xattrs for your workload are just
> meaningful for selinux labels and capabilities.

Really? Could you expand on this, because I would think it will be
sort of the opposite. In my usecase, the erofs fs will be read by
overlayfs, which will probably access overlay.* pretty often.  At the
very least it will load overlay.metacopy and overlay.redirect for
every lookup.

I guess it depends on how the verity support in overlayfs would work.
If it delays access to overlay.verity until open time, then it would
make sense to move it to the shared area.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

