Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C854D322C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiCIPvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 10:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiCIPvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:51:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86213701E
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 07:50:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw13so5699139ejc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xrbpP/Yfwao8lnj7LaSM/uRQpgaSVRznTS0TTH/HjZY=;
        b=s3xFNi6w/peDGqcEmc0BfMkPZn7cwxFxTcYpMhZo8mLd849lJJCJPAfTNkd3VaRKMn
         8D/pjSsda3jU/kUBKgqXjBLnK+pfqfXsEJb+MLwdZg9xmpkHQylcEcckW1X1Ej7wxleM
         Ocg1MWV+93+ARFiP/QbJy1epHrG9KrAALd91YORM/vgENm4v3zou2T2CrXDJY1TL81SQ
         LAlXStVVmvhEUfG4kfQ4LJnb3TkAtXzEhDl4vxr5+owgko1gg5gks3ZdBIr/A+yDY/gM
         RO33ihV+A5M7uWuDaf1/mtjmApBj24Up9s8gK/ksaVxOtT85uLj8B9Ov6cycxj929zDc
         Fr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xrbpP/Yfwao8lnj7LaSM/uRQpgaSVRznTS0TTH/HjZY=;
        b=DQRrJHo0W62CkQzf0xmcOtFqP5RQ+M6W7Z8O/RQ0br1wsHk4ebQqsBny5bUBMormBL
         z/PM/wuky4Hs38LYF9hEPYbyjoUGO8ywPhJh9sSSPp4OzTBmbzQNLjAWBLtyu7tiV4UP
         0TExTxu9oOruu7ZSBs21ZAceFHzlpZK3I5Ki1cw15NSi+GZXJM39R+5KV5Y0CzHtlqBD
         idu7IfZ6wD+rbcn0DsCMPqp2uNhkxKEAtXWw8h++nra+KqYp5xCICvDbne6kMq8zuctA
         BZd9kXh5iuxXf2+tCMiFgef8OQwgr6BrpX6Xq1GayryPV6gaDaClX0/uyKlJDDNFp7/5
         UYDA==
X-Gm-Message-State: AOAM530JAfNDjxQjAviOBHVtUP0A18tmoNOtX1fIINtInzxEi7Da1+F5
        isX+DBhXbV3vS/Mcn8GrUA0NCQ==
X-Google-Smtp-Source: ABdhPJxZ5pBljQ9c4cS3Z9+taf/t5M3OBOhL/UO8YvG/idZkX4Ez6hrxTSX+wbR+RbFNFZdxzRpO9g==
X-Received: by 2002:a17:907:7f2a:b0:6d6:df12:7f57 with SMTP id qf42-20020a1709077f2a00b006d6df127f57mr390349ejc.122.1646840996396;
        Wed, 09 Mar 2022 07:49:56 -0800 (PST)
Received: from [172.16.10.50] (213.16.174.189.dsl.dyn.forthnet.gr. [213.16.174.189])
        by smtp.gmail.com with ESMTPSA id h8-20020a50ed88000000b004160630c980sm960188edr.62.2022.03.09.07.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 07:49:55 -0800 (PST)
Message-ID: <2015a35a-915c-351f-81cf-bd7dfe4502a1@arrikto.com>
Date:   Wed, 9 Mar 2022 17:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
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
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
 <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
 <23895da7-bcec-d092-373a-c3d961ab5c48@arrikto.com>
 <alpine.LRH.2.02.2203090347500.17712@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
In-Reply-To: <alpine.LRH.2.02.2203090347500.17712@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/9/22 10:51, Mikulas Patocka wrote:
> 
> Hi
> 
> Note that you must submit kcopyd callbacks from a single thread, otherwise
> there's a race condition in snapshot.
> 

Hi,

Thanks for the feedback. Yes, I'm aware of that.

> The snapshot code doesn't take locks in the copy_callback and it expects
> that the callbacks are serialized.
> 
> Maybe, adding the locks to copy_callback would solve it.
> 

That's what I did. I used a lock to ensure that kcopyd callbacks are
serialized for persistent snapshots.

For transient snapshots we can lift this limitation, and complete
pending exceptions out-of-oder and in "parallel", i.e., without
explicitly serializing kcopyd callbacks. The locks in pending_complete()
are enough in this case.

Nikos
