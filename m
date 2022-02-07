Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16D34AB878
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 11:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiBGKMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 05:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352073AbiBGJ50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:57:26 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655CAC043181;
        Mon,  7 Feb 2022 01:57:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z7so18739025ljj.4;
        Mon, 07 Feb 2022 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T8GS9Lx/Nzfe8shyS/bZ6AFUZk8Wg4JdFQgCVTpa/ow=;
        b=Ed+tt6LNx+FM2iQmQE+1H418+wYp0WiOdsm/3ibcYdtcajjtWUSvy6Zr1lCqSMfdTu
         MCGxgkD2cpro20lYahzc6+gySNFKYSzKSO0CJ/3bp/V2aQaTtLKDq7WbhGHaKlH3Dc8T
         sIP68l8ipATIFf7HK9DX9itcJovKwyqQU9ycTeS7sy5cE4a0muJYSKyoYiR3fB31LidS
         rDL1N1w027ij27ZYE+t0mReXf/jbaNn+T1MWmwy2hHKf+vg1zbOyS09aer9Z5OSQ/Wat
         /ryVkhvEED6SRdZ4UgDojneyxvtFIWT49X2lXj9lpIjvsz3bly3o+oaxnOI5223H9aQW
         l/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T8GS9Lx/Nzfe8shyS/bZ6AFUZk8Wg4JdFQgCVTpa/ow=;
        b=LXiyAbCRKEXVo0rpdXsq4Pg0mQjLCgiZ27gcSiouSuszP/tUT7tMW0kyfcsF3MYD94
         yW+8G7Is3hh0AUNffW7tqdhb9kmo93m25Wpo9kB0A1WIboATdEz8u8/OACOcCALILH4E
         3AnCVAR/mBWeGXIrxelfLSsP26/kZUq4FVKWrovcqx4Qr8Y2SW3aIRkUzl9wjeA6BVwv
         4DKv54dtwcFup6y4VOhjfEoIFXUOKxvv8CMu93+viTN5O0tUCRsl6akB37OTs9792wWq
         7bhqEuRj/0+gyEDCzdd2+7uQT0Bxkdiz5nzTfFjCfcGW9fxSh5ZfBhzN2RHeL03iwOEy
         wkPA==
X-Gm-Message-State: AOAM5322qg7ie2dimaYLiHFmOBIeqnJ/6ifN4EzcqZaU2mhcrHHQwkfF
        LNOLEkJtSS3U7MT0CrGpsyi5bZoXk7l9IAfspNO/0tFrt4nbLQ==
X-Google-Smtp-Source: ABdhPJxV5weaU4Xoj+nXg6b8L1jKYRkPcK3VXq+/Al3uXfmdamOSUyvoF17yjujMX3jIRgFIA5NTrgrLqSjbGfGwu24=
X-Received: by 2002:a05:651c:108:: with SMTP id a8mr8630674ljb.479.1644227843616;
 Mon, 07 Feb 2022 01:57:23 -0800 (PST)
MIME-Version: 1.0
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
In-Reply-To: <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Mon, 7 Feb 2022 15:27:12 +0530
Message-ID: <CAOSviJ0+97ouVbQpQD1RykdyyM2Z_wVRrQjciizzMPS+pLOEsQ@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
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

Chaitanya,

I would like to join the conversation.

Thanks,
Nitesh

On Sun, Feb 6, 2022 at 7:29 PM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> On 27.01.2022 07:14, Chaitanya Kulkarni wrote:
> >Hi,
> >
> >* Background :-
> >-----------------------------------------------------------------------
> >
> >Copy offload is a feature that allows file-systems or storage devices
> >to be instructed to copy files/logical blocks without requiring
> >involvement of the local CPU.
> >
> >With reference to the RISC-V summit keynote [1] single threaded
> >performance is limiting due to Denard scaling and multi-threaded
> >performance is slowing down due Moore's law limitations. With the rise
> >of SNIA Computation Technical Storage Working Group (TWG) [2],
> >offloading computations to the device or over the fabrics is becoming
> >popular as there are several solutions available [2]. One of the common
> >operation which is popular in the kernel and is not merged yet is Copy
> >offload over the fabrics or on to the device.
> >
> >* Problem :-
> >-----------------------------------------------------------------------
> >
> >The original work which is done by Martin is present here [3]. The
> >latest work which is posted by Mikulas [4] is not merged yet. These two
> >approaches are totally different from each other. Several storage
> >vendors discourage mixing copy offload requests with regular READ/WRITE
> >I/O. Also, the fact that the operation fails if a copy request ever
> >needs to be split as it traverses the stack it has the unfortunate
> >side-effect of preventing copy offload from working in pretty much
> >every common deployment configuration out there.
> >
> >* Current state of the work :-
> >-----------------------------------------------------------------------
> >
> >With [3] being hard to handle arbitrary DM/MD stacking without
> >splitting the command in two, one for copying IN and one for copying
> >OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> >candidate. Also, with [4] there is an unresolved problem with the
> >two-command approach about how to handle changes to the DM layout
> >between an IN and OUT operations.
> >
> >We have conducted a call with interested people late last year since
> >lack of LSFMMM and we would like to share the details with broader
> >community members.
>
> Chaitanya,
>
> I would also like to join the F2F conversation as a follow up of the
> virtual one last year. We will have a first version of the patches
> posted in the next few weeks. This will hopefully serve as a good first
> step.
>
> Adding Kanchan to thread too.
>
> Javier
