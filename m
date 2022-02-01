Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0164A59E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiBAKV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 05:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiBAKVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:21:25 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88007C06173D
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 02:21:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so52600503eje.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 02:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eIOyvFawBB1yczxqwT9GD1wEUXr2GprPDkj97BLOhM8=;
        b=pJgqMkadljh7RQEG1OifyORi8FTJ4yvtTfhp3Fv0W8KUnRAFhPQ4ydhJvfbXum++fP
         3t7f7doYblsNgo7oMDTiOlmZxcYOiY37CgCvg8/RYn8T+Po8tgv7lvxp9CBGdStWf3sq
         WwtEU3TOLf/MOIjXnUbZGNWUc0SaOZUQaiLRhguRevht8Ac2tVvAoukw0t2U0+1QzAhu
         BEo/9KKub7Q2qd+N8AHo5ghjz9HneRcptN27Xs5gNExbv0R+eQ++gXKpGeAVamTqzYf9
         GzqAZGpYgMj5ryA1ScCFdqG68fiEHF0J+CN6knWH805XRJi4UYxN58axR+bPXe0b2yhC
         lyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eIOyvFawBB1yczxqwT9GD1wEUXr2GprPDkj97BLOhM8=;
        b=O+Zhs0FccOroZ2tMUiS3Q7XzrxcoeLOBanZEBV0tBnmVlZ0qV2ft/kc28iLiY/Dlp3
         KY2EEgBTZ4sp21Rcy3CXhLZ4QSojAE9iWpyjy9Y0ncDMxTs4xQKQd8xaunmC/07hQ7ga
         eZN6/CU0+bJswAZHWb+qDUPrLZzdoytrQfNo/6bQsb/DCGa/PBkXpLpdGQ7aUHZGQtrR
         EUbS8Naij0a09gobHxm9Ilz5VT+QgFqSNvCqnNaOXcvlrjmU0SB9Ke75AjOUJLlC1A+w
         VV0to5USpS3b3YnOxTCXmvdGg/pzTeSCVbLaxWV6e+/aMct33ocuovaPzyNvaC/pI5VN
         TH/Q==
X-Gm-Message-State: AOAM530rkfoct4Ot0DZIs+V/Jsp/+CDyP7yKe4kYNFo758c90DwZdnQ1
        Aq/O4WCvyqIeorz3F71+N6ikSg==
X-Google-Smtp-Source: ABdhPJx58nqEvb1Npa2CsMHZtPsUoqQzJ41tgdoNFsHrDBZEqyc2NUJcMe6tBJmOhT19Yval8hSzoA==
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr14491120ejc.20.1643710883991;
        Tue, 01 Feb 2022 02:21:23 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id w24sm11634557edu.97.2022.02.01.02.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:21:23 -0800 (PST)
Date:   Tue, 1 Feb 2022 11:21:22 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.01.2022 07:14, Chaitanya Kulkarni wrote:
>Hi,
>
>* Background :-
>-----------------------------------------------------------------------
>
>Copy offload is a feature that allows file-systems or storage devices
>to be instructed to copy files/logical blocks without requiring
>involvement of the local CPU.
>
>With reference to the RISC-V summit keynote [1] single threaded
>performance is limiting due to Denard scaling and multi-threaded
>performance is slowing down due Moore's law limitations. With the rise
>of SNIA Computation Technical Storage Working Group (TWG) [2],
>offloading computations to the device or over the fabrics is becoming
>popular as there are several solutions available [2]. One of the common
>operation which is popular in the kernel and is not merged yet is Copy
>offload over the fabrics or on to the device.
>
>* Problem :-
>-----------------------------------------------------------------------
>
>The original work which is done by Martin is present here [3]. The
>latest work which is posted by Mikulas [4] is not merged yet. These two
>approaches are totally different from each other. Several storage
>vendors discourage mixing copy offload requests with regular READ/WRITE
>I/O. Also, the fact that the operation fails if a copy request ever
>needs to be split as it traverses the stack it has the unfortunate
>side-effect of preventing copy offload from working in pretty much
>every common deployment configuration out there.
>
>* Current state of the work :-
>-----------------------------------------------------------------------
>
>With [3] being hard to handle arbitrary DM/MD stacking without
>splitting the command in two, one for copying IN and one for copying
>OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
>candidate. Also, with [4] there is an unresolved problem with the
>two-command approach about how to handle changes to the DM layout
>between an IN and OUT operations.
>
>We have conducted a call with interested people late last year since
>lack of LSFMMM and we would like to share the details with broader
>community members.

Chaitanya,

I would also like to join the F2F conversation as a follow up of the
virtual one last year. We will have a first version of the patches
posted in the next few weeks. This will hopefully serve as a good first
step.

Adding Kanchan to thread too.

Javier
