Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B744AA046
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 20:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiBDTmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 14:42:06 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:35804 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiBDTmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:42:05 -0500
Received: by mail-lf1-f43.google.com with SMTP id i34so14688673lfv.2;
        Fri, 04 Feb 2022 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ow88Lu4aUs6K7UkGLeI5Z43Nbv5HpcgNARMLv9ghlkU=;
        b=TpFi/w8V+E7pbO9sIvLpXZCpdWezLN3gUSIfpae0rAfXunnHQoI1jO+McdOkoyyvry
         rpUeXbR2S4FMUcIK2ROcUGKWUUt29F/xn7gfPQugn7xPgfsgy2RjXGSLTqvEFqxQizUs
         UemRWsnEtkd4NE/9MnMJJY+2kzZrILdV0UEahM7z9pM9c2PBRwlaavtJq04TKtp2RKMi
         SfNZHW788cW54l6at6TZuezDjBfN360XlNenjVWgmSNXGdnmUCR4lwh/F+hZxzOJfoTa
         zTYtOv5OsrlN8LnEyXtPgrSrhoEO0tFX8dw7kzuvq0hNgelyDruS6BhYPwSZgM8gE7FG
         /67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ow88Lu4aUs6K7UkGLeI5Z43Nbv5HpcgNARMLv9ghlkU=;
        b=PklOu0iEVkLTWJvT2BKPgl42XNmg1i6rzSwU4dwKuon9cmM/2i+/NxrEJDRjsDjAOY
         rBbHssziydgFD1CnjQ3D8OWirS60tAOEHDA/cbJrIoBBJMQ+txS+1QR9Boq+1o/sXMeB
         aWKQWx5KSIEz7M7NMKIL4zXRpxZNEHkbHKgaz0y/13bCf6JGV+vy3hved4o/L63Qpe7Y
         dzbKtJtfXoHpqT3+bQYjDXxy6laVebBaRkH8JYWwfWBch+rD1mwP0bH7e8WUskVi75oE
         QV6w9DxixIo1nhjdEzbjZZatS2RxAwHLczAPKrfLPXkxBLUeEbZ5jc1J1SuGJGHPaRSj
         25iQ==
X-Gm-Message-State: AOAM530ojHWL0nvKdUebubKSDVT3otEdHG1JD3wpc4rfjGzZ9Vmo+gFY
        jrve144V538Ar+zpxnCv/UIW/tPuvfA287vbrQI=
X-Google-Smtp-Source: ABdhPJyHIm2s/AwXxjYIOHGmKgAxztwbsh5UaTIz/wUfKedoZaCqO6GHsMXWPEigismScFC9Hc7Iu0UaLWeROhbCTFw=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr346407lfy.563.1644003723415;
 Fri, 04 Feb 2022 11:42:03 -0800 (PST)
MIME-Version: 1.0
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2> <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Sat, 5 Feb 2022 01:11:51 +0530
Message-ID: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] NVMe copy offload patches
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
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
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
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
        Kanchan Joshi <joshi.k@samsung.com>, arnav.dawn@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 2, 2022 at 12:23 PM Mikulas Patocka <mpatocka@redhat.com> wrote=
:
>
> Hi
>
> Here I'm submitting the first version of NVMe copy offload patches as a
> request for comment. They use the token-based approach as we discussed on
> the phone call.
>
> The first patch adds generic copy offload support to the block layer - it
> adds two new bio types (REQ_OP_COPY_READ_TOKEN and
> REQ_OP_COPY_WRITE_TOKEN) and a new ioctl BLKCOPY and a kernel function
> blkdev_issue_copy.
>
> The second patch adds copy offload support to the NVMe subsystem.
>
> The third patch implements a "nvme-debug" driver - it is similar to
> "scsi-debug", it simulates a nvme host controller, it keeps data in memor=
y
> and it supports copy offload according to NVMe Command Set Specification
> 1.0a. (there are no hardware or software implementations supporting copy
> offload so far, so I implemented it in nvme-debug)
>
> TODO:
> * implement copy offload in device mapper linear target
> * implement copy offload in software NVMe target driver

We had a series that adds these two elements
https://github.com/nitesh-shetty/linux_copy_offload/tree/main/v1

Overall series supports =E2=80=93
1.    Multi-source/destination interface(yes, it does add complexity
but GC use-case needs it)
2.    Copy-emulation at block-layer
3.    Dm-linear and dm-kcopyd support (for cases not requiring split)
4.    Nvmet support (for block and file backend)

These patches definitely need more feedback. If links are hard to read,
we can send another RFC instead. But before that it would be great to have =
your
inputs on the path forward.
But before that it would be great to have your inputs on the path forward.

PS: The payload-scheme in your series is particularly interesting and
simplifying plumbing, so you might notice that above patches borrow that

> * make it possible to complete REQ_OP_COPY_WRITE_TOKEN bios asynchronousl=
y
Patch[0] support asynchronous copy write,if multi dst/src payload is sent.

[0] https://github.com/nitesh-shetty/linux_copy_offload/blob/main/v1/0003-b=
lock-Add-copy-offload-support-infrastructure.patch

-- Nitesh
