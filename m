Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E815D4A87CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351926AbiBCPit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 10:38:49 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:37476 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351905AbiBCPis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:38:48 -0500
Received: by mail-pf1-f179.google.com with SMTP id y5so1603301pfe.4;
        Thu, 03 Feb 2022 07:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJc80QrxeNpdYK/bKJzdbQZVP7dPgDgH6+/SL6BaJLA=;
        b=doU45sIK+CSec063wF0MiToitTNSaakQmJ9w4k/ShF5SmY6NH+n3Q/9rT59IZLyXK2
         5lf1kZqpIVnQgIRFH5twfJTXc9IgB4rHHCq8ilKrW3kb8HOAnSoZ3025pcLHO3f2EsrN
         /1uNBpV4FHgqnsgbTs6v/TZcDq7Ixtbc1or142TmMy+9d/RExvWvsMvZQbLvMfQNAUXf
         R6bCdJ9Q4MckZJAJ8z0DKE9ad0wlwQg0rDbDtLeGOf3y7w4IFK2SSedS7o+VaksAIMnT
         6e6RfVtt3FfRERL8pKeO+vjPuLqZzpfESeRgnMzW1S7bfJuaxOuzOfYNl9ZdG6H+wjvK
         ysdA==
X-Gm-Message-State: AOAM530AglalReux9/ieAPVUL++rJI1U7w6m78ZSWiTy7sGV5RegGGJV
        CqaMWRHTQQHu8FoHCqXx+0A=
X-Google-Smtp-Source: ABdhPJyK53iWqvFX2Vqq2e4bGH4TKRnnEI6Nef430vI4MXHRwAQ64yyEJcJ63nBPtWhhnkJ6Y3aDlw==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr15183399pgc.603.1643902727819;
        Thu, 03 Feb 2022 07:38:47 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id b12sm12465462pfm.154.2022.02.03.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:38:46 -0800 (PST)
Date:   Thu, 3 Feb 2022 07:38:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
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
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220203153843.szbd4n65ru4fx5hx@garbanzo>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> Mikulas,
> 
> On 2/1/22 10:33 AM, Mikulas Patocka wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > This patch adds a new driver "nvme-debug". It uses memory as a backing
> > store and it is used to test the copy offload functionality.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> 
> 
> NVMe Controller specific memory backed features needs to go into
> QEMU which are targeted for testing and debugging, just like what
> we have done for NVMe ZNS QEMU support and not in kernel.
> 
> I don't see any special reason to make copy offload an exception.

One can instantiate scsi devices with qemu by using fake scsi devices,
but one can also just use scsi_debug to do the same. I see both efforts
as desirable, so long as someone mantains this.

For instance, blktests uses scsi_debug for simplicity.

In the end you decide what you want to use.

  Luis
