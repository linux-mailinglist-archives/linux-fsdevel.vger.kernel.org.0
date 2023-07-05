Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDA7487B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjGEPT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjGEPT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:19:26 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED451735;
        Wed,  5 Jul 2023 08:19:24 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-345db6c12b4so25136435ab.0;
        Wed, 05 Jul 2023 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570364; x=1691162364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhOVd+fM39By6Neo4SNlvIwXWgDBhgramNmEhS79nFc=;
        b=DESWvkdXfKRFM7YbT070ZmknAy3m3u3OBm8n2LEXxQK6fuEG5UkpUrgMQue9xGiagw
         dwoleP2J5Qw6bPF7EzsJ0i0QFB+EbVcpSzjvgR7pGn/vXQWXCEbmy31T+HjFF5qXdYR1
         z+3q7Pg8tj3Qe+E6RXqzuubza3bnSf4csuiZLXOat/vCU4R8im7e73uAOEIGMs6ICtX/
         rsXwpPAokvej42pZH9/taX2sbR5sXl9V+vVdisjJV9U3MFGSHTMEQ5sGqEeX46WzyMlV
         UClv8XYFy0yLUXAyQYseavn58dOSNX9/2O29h38956C8kGkaN+qKW3fnBS9yJCyf0iCd
         XNWA==
X-Gm-Message-State: AC+VfDzsJDUwAEjjmxd2e0EBu6YLsL2TilrOZR+pmtA3er4k02CRZNJB
        RmIjIUDf1wBVSCyRJf0loyE=
X-Google-Smtp-Source: ACHHUZ70uoI88DRVhGiNe4v8NMOn4CckRug5A25bO6UrnrhXn4O+oQb9CB+u9z1UucgpvIObIHjohw==
X-Received: by 2002:a05:6602:2113:b0:784:314f:8d68 with SMTP id x19-20020a056602211300b00784314f8d68mr18093430iox.1.1688570364015;
        Wed, 05 Jul 2023 08:19:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c1f1:7d21:6172:cbd2? ([2620:15c:211:201:c1f1:7d21:6172:cbd2])
        by smtp.gmail.com with ESMTPSA id l6-20020a656806000000b005579c73d209sm15456631pgt.1.2023.07.05.08.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:19:23 -0700 (PDT)
Message-ID: <1ea08f84-f900-92f2-e32b-2db242a74559@acm.org>
Date:   Wed, 5 Jul 2023 08:19:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
 <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
 <ZKRFSZQglwCba9/i@casper.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZKRFSZQglwCba9/i@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/23 09:14, Matthew Wilcox wrote:
> On Tue, Jul 04, 2023 at 07:06:26AM -0700, Bart Van Assche wrote:
>> On 7/4/23 05:21, Jan Kara wrote:
>>> +struct bdev_handle {
>>> +	struct block_device *bdev;
>>> +	void *holder;
>>> +};
>>
>> Please explain in the patch description why a holder pointer is introduced
>> in struct bdev_handle and how it relates to the bd_holder pointer in struct
>> block_device. Is one of the purposes of this patch series perhaps to add
>> support for multiple holders per block device?
> 
> That is all in patch 0/32.  Why repeat it?

This cover letter: https://lore.kernel.org/linux-block/20230629165206.383-1-jack@suse.cz/T/#t?

The word "holder" doesn't even occur in that cover letter so how could the
answer to my question be present in the cover letter?

Bart.

