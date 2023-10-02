Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914ED7B5908
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjJBRRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237954AbjJBRRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:17:01 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58CAC;
        Mon,  2 Oct 2023 10:16:58 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-79fb70402a7so483300239f.0;
        Mon, 02 Oct 2023 10:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267018; x=1696871818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iu8NvrKBKHhHgS8Slq7i78aOuiYNJGoV9uRZn/WDwyI=;
        b=kAvyaH5o7bymNhUmnAMi+6ygzGSwxilnMV3bC/qPdxt1E2VMtzGtAZLd6plg/EEX3P
         tHkVHtjQq8Xnt50gITpiYDFaBh4E9d0LZusTOv0J6cWMARgJI4Mu+bF7mxAGAUjbhrDf
         HAp1nHe6ulCfopjRJjXn3lm+ISn1YV1cpHZXNSrKNWSVLwEjaFYEhuqz65Qr5+z+n3Ux
         vSEjrOnnRdFP25rL79cwG3wE1K3c29DSptrdQ8CmC8TKQRP2M0qKzb0YEKyyuuWAdcOQ
         IPbTiKN8Ae79/uzdVjZqTOWjq7MhAnjX98Rv8Qdn+FOhe0OI/nj2fDh2gwVi/Jc0kknJ
         egWQ==
X-Gm-Message-State: AOJu0YzJlKxaZqsyuvEBe0K4VKPJHTmyTKDYmLfq/chci2fCJZGZrNBz
        PlC2oFim19A+/g2rYMs+tcS3UDygc24=
X-Google-Smtp-Source: AGHT+IEoDn+q5FsKihSEBKIgKVa7seARDombXiwCpyy/t4h10aaiYc1xz7Sk19cjqDv6V5fpAtuXmA==
X-Received: by 2002:a05:6e02:1d83:b0:34f:f6f0:d4eb with SMTP id h3-20020a056e021d8300b0034ff6f0d4ebmr14327979ila.21.1696267017844;
        Mon, 02 Oct 2023 10:16:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b0055c178a8df1sm19517981pgd.94.2023.10.02.10.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:16:55 -0700 (PDT)
Message-ID: <d9f8ef9d-18b1-4cfa-a163-0985af942aa9@acm.org>
Date:   Mon, 2 Oct 2023 10:16:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] scsi_proto: Add struct io_group_descriptor
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-7-bvanassche@acm.org>
 <DM6PR04MB6575C0B9DD2DA055A67EE72CFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575C0B9DD2DA055A67EE72CFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 04:41, Avri Altman wrote:
>> +/* SBC-5 IO advice hints group descriptor */
>> +struct scsi_io_group_descriptor {
>> +#if defined(__BIG_ENDIAN)
>> +       u8 io_advice_hints_mode: 2;
>> +       u8 reserved1: 3;
>> +       u8 st_enble: 1;
>> +       u8 cs_enble: 1;
>> +       u8 ic_enable: 1;
>> +#elif defined(__LITTLE_ENDIAN)
>> +       u8 ic_enable: 1;
>> +       u8 cs_enble: 1;
>> +       u8 st_enble: 1;
>> +       u8 reserved1: 3;
>> +       u8 io_advice_hints_mode: 2;
>> +#else
>> +#error
>> +#endif
 >
> Anything pass byte offset 0 is irrelevant for constrained streams.
> Why do we need that further drill down of the descriptor structure?

The data structures in header file include/scsi/scsi_proto.h follow the
SCSI standards closely. These data structures should not be tailored to
the current use case of these data structures.

Thanks,

Bart.
