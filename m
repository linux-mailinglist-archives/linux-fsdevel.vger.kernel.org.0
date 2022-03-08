Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571774D22D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiCHUtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiCHUtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:49:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32331350
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 12:48:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so453495ejb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZwTZJ+cU/YiESkdxq7NY4b6RLcbHEOvUMvJI9bbFH7M=;
        b=Gwnt7g1XSPp1zY58EeFWUMm5Q6xwrt/izpp+FhPjy+7iS1GbvRRNqzDyqXMF4t7xO1
         ZklX9hQxNs+ZdvPab9Q28wcBu4BGYbDhrdk5ddjP9gSzihnpoHUbou9SBEnPmhPfScRp
         bGaCVQ1Utj2EZdYlP3YhQGLUPCyyRCB8tyHaXytM2w8JLJElKi6kAz3iULOo7EQIPIf+
         itVbQlj6VZ7ClmD0lS/swlcnAsK0r/d6eN2usBdu7H1rjAUyYWNNJ6Y+e7VHPKKjbN8E
         n3Mm5UxU9+4kS7CGY0vNMa/v55sSzNUVC8l5n32k+rx5W2a9rF1BAAr9xwCNrnSnsmcr
         Q5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZwTZJ+cU/YiESkdxq7NY4b6RLcbHEOvUMvJI9bbFH7M=;
        b=T4jJcKdM5ue4FupeWEQjFbbQ10CseZuoJCKxzZnnN5aZ9wEuXx7rI6+GnrH4xB2zDb
         XJ4ftDBom2jNPirBlrBQv+u9Jc3hC6Y2Adk+VXCAMXmwChjWxRxkDLCaGr1bV5mu32Cj
         xDxsNBr6GRDzleCj44tiT0R/sFdtzRXkn/VOEJIDFBpioZmoXouu2JMfI+qkdxmG6IJj
         3B8zMzGR5y6aMJMadhzt5SxpFWnGlYIUXScxjyqlc6cb34Z4cyQs/K7wnPNHIPvJc8tX
         qGEH9W9zV/nRMGEwLqYbFt5th+Ryb+SJKlvcZ06K85Gqfz2oLcJ/pXvYtMXFz9VULzdg
         ozIg==
X-Gm-Message-State: AOAM530G8AV68Gr9eF2RDdC3GKEHRWwVNu3t58JYcMkqNbRdF1Nb/1mh
        bhC1KXW+7KXU1J6t3xETuL0Sfw==
X-Google-Smtp-Source: ABdhPJxoU+8TvtIedOHXaAEiIlveanpsqTd3At14GihTobnyXos5yBO4WToMuK5Nec5SIeR3YDUPEQ==
X-Received: by 2002:a17:907:168a:b0:6da:9167:47dc with SMTP id hc10-20020a170907168a00b006da916747dcmr14943856ejc.126.1646772501317;
        Tue, 08 Mar 2022 12:48:21 -0800 (PST)
Received: from [172.16.10.50] (213.16.240.129.dsl.dyn.forthnet.gr. [213.16.240.129])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00415a1431488sm8172430eds.4.2022.03.08.12.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:48:20 -0800 (PST)
Message-ID: <23895da7-bcec-d092-373a-c3d961ab5c48@arrikto.com>
Date:   Tue, 8 Mar 2022 22:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
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
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com>
 <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
In-Reply-To: <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/1/22 23:32, Chaitanya Kulkarni wrote:
> Nikos,
> 
>>> [8] https://kernel.dk/io_uring.pdf
>>
>> I would like to participate in the discussion too.
>>
>> The dm-clone target would also benefit from copy offload, as it heavily
>> employs dm-kcopyd. I have been exploring redesigning kcopyd in order to
>> achieve increased IOPS in dm-clone and dm-snapshot for small copies over
>> NVMe devices, but copy offload sounds even more promising, especially
>> for larger copies happening in the background (as is the case with
>> dm-clone's background hydration).
>>
>> Thanks,
>> Nikos
> 
> If you can document your findings here it will be great for me to
> add it to the agenda.
> 

My work focuses mainly on improving the IOPs and latency of the
dm-snapshot target, in order to bring the performance of short-lived
snapshots as close as possible to bare-metal performance.

My initial performance evaluation of dm-snapshot had revealed a big
performance drop, while the snapshot is active; a drop which is not
justified by COW alone.

Using fio with blktrace I had noticed that the per-CPU I/O distribution
was uneven. Although many threads were doing I/O, only a couple of the
CPUs ended up submitting I/O requests to the underlying device.

The same issue also affects dm-clone, when doing I/O with sizes smaller
than the target's region size, where kcopyd is used for COW.

The bottleneck here is kcopyd serializing all I/O. Users of kcopyd, such
as dm-snapshot and dm-clone, cannot take advantage of the increased I/O
parallelism that comes with using blk-mq in modern multi-core systems,
because I/Os are issued only by a single CPU at a time, the one on which
kcopyd’s thread happens to be running.

So, I experimented redesigning kcopyd to prevent I/O serialization by
respecting thread locality for I/Os and their completions. This made the
distribution of I/O processing uniform across CPUs.

My measurements had shown that scaling kcopyd, in combination with
scaling dm-snapshot itself [1] [2], can lead to an eventual performance
improvement of ~300% increase in sustained throughput and ~80% decrease
in I/O latency for transient snapshots, over the null_blk device.

The work for scaling dm-snapshot has been merged [1], but,
unfortunately, I haven't been able to send upstream my work on kcopyd
yet, because I have been really busy with other things the last couple
of years.

I haven't looked into the details of copy offload yet, but it would be
really interesting to see how it affects the performance of random and
sequential workloads, and to check how, and if, scaling kcopyd affects
the performance, in combination with copy offload.

Nikos

[1] https://lore.kernel.org/dm-devel/20190317122258.21760-1-ntsironis@arrikto.com/
[2] https://lore.kernel.org/dm-devel/425d7efe-ab3f-67be-264e-9c3b6db229bc@arrikto.com/
