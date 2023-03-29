Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87006CF779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjC2Xg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjC2Xg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:36:28 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB112D
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132987; x=1711668987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OTfJOB5+rMhAgZTM4ONfC4vlfxhMaFKo471fkAaO7qM=;
  b=St8PzksH1ZEMAMvMW1CvbZLbPTeJ+Sim9cGfHlRTUzL4Sit9XRhx9KDd
   lC6n3AFi1t0uTWOYMAjZ7C6kmS/Ce1il8eSV1n653bvQbSzvN4LQJwMUD
   UVZSeBormSGRSL9UhZcpxoIq8OBt/o3Fc8RIK848h54gRZuImoZ7FvDrH
   OfJet5UpcWdTHlz5IEOndDVWginMZgFvBOrEKwgIGgDQMOqOyqze7kOhO
   H1RY+LBEwKgHTPxxeDf9JfYYrMdSuSltY5TkhEXnSBlw5rvBynYQ9HFi1
   MclBULdUgwVah693xdeE1tGqguh32Y/FDeZOVMahm62bod7ErB8wT+o62
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828698"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:36:25 +0800
IronPort-SDR: i5OIH4swsIwtwPEvYQhTTwEWaC7Qdj8RruEo10jB3G/v5fd2zRHESIb60ZCwMPXD3wHOQ7K2Qk
 /KP8ERLwPFJYprFfXpRAaDbLnJsAtuLeBpUuvBc2ZC0UqqdWM4W8GpJQHE4+r2ry599qK9T9JY
 L4/MH7jCr4IXSgqesuLtBCfdhTZbJr+ZAwngCdhh5dG/I2osls6iIrQAFkBFneWtHs/lUpv49h
 8dTkfwPvD3J/HxctBLnznTgcPqJ68qIBrTsa5CLs7YesZCgJe3vg/CN7ycayR/1wF7CkMWcC1Z
 Y50=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:46:53 -0700
IronPort-SDR: LOgfFiB6M+90sWTtHJ9hhH5YDOB1S8GRpebbiAgCGMMP4cNDWX0x6xQQRtBZ4s0ER0Xy8wmjtm
 m++UPC0L+GNBkdjB6ve96rw95cS8Xg4U/qUIaks3gNxAwzuKb1iY9dgaN74zIAqNWNHBfGY5QE
 FNMwyWtyfbG/okQFQPrr6sJsOlwZPkzXhDHB93rIg92y/vJMGtkq0Cl2KjO+cNKHfkbIGWHMzH
 YY+Qc5ePKrswpISchCTY7p7GtvXRFTtPDFk6ljHuCAV6ZGft+Yt4MzxVguA7yvaWIPj99b677e
 TbE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:36:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2xj5Lk6z1RtW1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:36:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132984; x=1682724985; bh=OTfJOB5+rMhAgZTM4ONfC4vlfxhMaFKo471
        fkAaO7qM=; b=iA9ESw9qffKNSFDF3ok630RxnvZTTZvVjdgrC2mRPtNl91Z08Bz
        yihPfnkjRCVwpEa0rK+4D2u0qY2ZZWg97ju7UgczJYkMP/zXgwrfenICqIC32DuN
        2Hd749Yv3hAEPotkgbr4/VjJEvWNMpSPZPwBnUUQR6kPTixNsWpB34Uws1Y9pYv2
        BfpUFjvU1jp89f0qVou4HeTsGlk6+qUWG0JnkHbEMPegxcMpkqmAElk36HNq8vKC
        3vtHABssq94tgixRpIzjnFDkx9+ZPQ7qPcOq+YMmOo5kQtPsrUishTIa5S7BDEKT
        Z9i1qF9rzU21n3jHrd3Ow6BexmdN0fTC9TQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3L4gKCclO32f for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:36:24 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2xd5qYJz1RtVm;
        Wed, 29 Mar 2023 16:36:21 -0700 (PDT)
Message-ID: <329c915b-b49d-491f-80ef-f4c9cdf80600@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:36:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/19] zram: use __bio_add_page for adding single page to
 bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <339841b3b7ce6b2faf56bcaf9d92e298d878ef64.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <339841b3b7ce6b2faf56bcaf9d92e298d878ef64.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 02:05, Johannes Thumshirn wrote:
> The zram writeback code uses bio_add_page() to add a page to a newly
> created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

