Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080E66CF725
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC2XbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjC2XbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:31:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD983C20
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132677; x=1711668677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UNlm9Cgnb69c4/O/u7KM3nCJu6vgziKIZ4YaTqHtuUE=;
  b=e42V3W2EvrF5jaN6uC91VQS7VkotzOy5ARTUvEyB/cnPDZ5kHQ2lPWIT
   4Q6Ocn0CG3tqJzS80frVanF/eyR/g5clmBux1IioiDgxG9jI/XCBVUyxy
   +c/yBJk1IU4jwRkdEhdBOXaBZL6mx9sloLZbGavXv00uVj9QQZoCM1NMM
   0D53pLWK+Jd6WxLivQfgTOpK4u2A24Fh0TVAIE+l8uYf56baCjV1ur92i
   ub0aryLPFW1/DD4woU1RjNEH3JNw0XKcK1PFDJkD3GAFe+/JaYX7OfYLA
   933ue9ZppZeaSJDObCUUHZj8QgfinZ+Y95roxBxLRNfo5kMkS5RT2OQmq
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828444"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:31:16 +0800
IronPort-SDR: GTwctiOlZ+K4IO/Vw/T5xwHYRdgfyFHrB2kNbFwYyD0qb9ulNcjP2nQCdkB9KEpXo3274Jot0i
 w1ZRiKyM46KglLFv3wgPR5RE62yaN+BWV3ItcWPaYm2cr7CzMqTIpr9B155FclkP2q1HSZndCw
 DjZpfZJQ/hdaz3xKs0OX1DAfAq3LhInQhA5/xgxk9DxYE8S3cWwbT2WPjLM+sKxGTiqcrYU7r6
 U5vXU0YfF/ZrJLsnSsQvpGbSYufutdOj7s53bhNDTUKftHq6W/1cxnkZojRTgXsSv/wTuytebw
 Q24=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:41:45 -0700
IronPort-SDR: hmoV6aQWlz5bnG70x8tCgIUcpcXiD3cv5AmL0cRYpj41B4/Pk4dNDZga2lScdEZGvfbb+El5Lt
 cAoivWLUlGvzfW6ubl42BsDwj5xfS3NezVJjWfYyG6AfVgHRFc7X0EWEjs9BJknFyKkwx6mw75
 +bdBvY1UAudnPYUQVxScwQKU/1WznYPNO0ZPT4biiIYCmPB61mciLugoBr9QrT+eTAJ3UPjgVl
 iFQYlqcLymeowVkQGqwfPy5lA1t8k9mDz2OCCkmVZl5eX0Tpie+7aOS7bmfC022QOuq4AJcWiP
 /xw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:31:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2qm0n4Pz1RtW3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:31:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132675; x=1682724676; bh=UNlm9Cgnb69c4/O/u7KM3nCJu6vgziKIZ4Y
        aTqHtuUE=; b=Ca2fO6rcxglppHNXYxRAHziKkRlfWQdPRtKcotDpyHFiP/dqL1l
        +eRINX7r2eICbC4KQtNpc23E7B6cTVrRj9Ksclu4Jqd/OhE7FGf0WFts4RSkNvRZ
        vyDh64QjNua4rA3LG9nobAs9hY5rxbY67Vr2/TNnOHh89mZ8LeAkwGHM4RGHVU7Q
        G2zLU+l3brOhyc7kjdil5v6zpK4QdjwQTJ4zW86BPD9Cb/sL1GpTuVvrOGcehbqI
        6BtW6hfXgSgZ2432WxO3xb5C7AONp6W2nDb+sKaqwGk9QuSWfywQR32EdxP4QOPx
        RFADdkCfux4rv8H/ZisxP0MjM4uYkF1VzgA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id psyolYfWLJ1s for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:31:15 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2qh3MbGz1RtVm;
        Wed, 29 Mar 2023 16:31:12 -0700 (PDT)
Message-ID: <3ba0a4e1-7b75-9d0c-d6d3-dfc3d4bbbef0@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:31:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/19] fs: buffer: use __bio_add_page to add single page
 to bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
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
 <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <56321f8ef1e70e9e541074593575b74d3e25ade2.1680108414.git.johannes.thumshirn@wdc.com>
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
> The buffer_head submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
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

