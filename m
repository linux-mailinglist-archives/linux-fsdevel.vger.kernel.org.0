Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22344A4F22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357719AbiAaTEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 14:04:01 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:41980 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiAaTEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:04:00 -0500
Received: by mail-pf1-f169.google.com with SMTP id i30so13663403pfk.8;
        Mon, 31 Jan 2022 11:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ba+ZTTm9dUGfaeSvRk+qlfqj/OlYP9s6XSq9bd25RTY=;
        b=c1lrRwffkBFldJRuhrFNbGSVdR1YvhArvr+056enyutyu+ZW7d0HdBWeNnsroz3FpC
         UUR8s3H1O93cqu4MJBWE5b0Skdnm1ylVSeoRk9n+cdbb8TwUepRN4AR0XgnQoPqY/COn
         OL/n6MtC5Q138Ef350ayqbRSls0McGA0OcKSaB6FRwvKloz/6QHt+osS1Fevi5qU/jn0
         ruxzvnWkrfPAucXOKfTdDhfAQEEVo4Nf9XejPp9qirqmCdbdNLi3rRmRALKLjT+P14oI
         b2nwsVEQMCxwYIY0ZQbgXEOmXwI7XNcl75nkwkM+5DrCTmxUA5Fd/5WzHX4dxdFk/usZ
         Gw8Q==
X-Gm-Message-State: AOAM531BBInl47D25koYugw/AfWo84B7VP0FZ4+qZCY7gKQDTqpmVwHT
        vmruOHexHnwVY7vYSRg9+IQ=
X-Google-Smtp-Source: ABdhPJzQA22tXEk8X4OPms7oAF0wKkcs2v8eBD4LAyDqrpj0MnwPbwFxejGQ4ckny7zBvb+xVPqt/g==
X-Received: by 2002:a63:343:: with SMTP id 64mr17733875pgd.463.1643655839828;
        Mon, 31 Jan 2022 11:03:59 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id e30sm5686912pge.34.2022.01.31.11.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 11:03:58 -0800 (PST)
Message-ID: <59a907b6-596b-402c-b619-b0f5b6013dff@acm.org>
Date:   Mon, 31 Jan 2022 11:03:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/22 23:14, Chaitanya Kulkarni wrote:
> [1]https://content.riscv.org/wp-content/uploads/2018/12/A-New-Golden-Age-for-Computer-Architecture-History-Challenges-and-Opportunities-David-Patterson-.pdf
> [2] https://www.snia.org/computational
> https://www.napatech.com/support/resources/solution-descriptions/napatech-smartnic-solution-for-hardware-offload/
>         https://www.eideticom.com/products.html
> https://www.xilinx.com/applications/data-center/computational-storage.html
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
> [4] https://www.spinics.net/lists/linux-block/msg00599.html
> [5] https://lwn.net/Articles/793585/
> [6] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> namespaces-zns-as-go-to-industry-technology/
> [7] https://github.com/sbates130272/linux-p2pmem
> [8] https://kernel.dk/io_uring.pdf

Please consider adding the following link to the above list:
https://github.com/bvanassche/linux-kernel-copy-offload

Thanks,

Bart.
