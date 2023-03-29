Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C56CF745
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjC2XdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjC2XdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:33:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77055A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132785; x=1711668785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=APb6MZhJtx+BKA0st8ClsB22pp0y9Pqig7XgT6sLxmI=;
  b=TXH5CSvPmBbjDrlzz9EkNq6t23/fUwhiC8TJLsAiBlZQW0DxbJXifFeI
   Z1D5ip3eo4TUhFyVvLjFekDJ+csiIXdpyfpTFzkQVLPlfqIdCm6SjvIzv
   rXBob6qgOsTF/7GiHuGwjNQv6km+xVQsYJOOxNhEyc6SgjeLacHTL+WIY
   a3g7LpTn0K/o5pUI6bti2HSpBu+ldg7EFKMyF965YJs1QXMn+/ZUZjF33
   jInfbpL7JsY1oUOR6sxryRYrCkPurtAlnXM529JOMVZ2Uj1cXPhIiCohC
   alHXBscZZ6EewG2bqPkxqDenQxgRmyvkLWfNONew+jj8VOB4In+OMxFG/
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="331273897"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:33:00 +0800
IronPort-SDR: WSnm0ZusY6EgV7srZv7bj6jNJ4HynamqaezuoN/tB4iZWVeZj/641Qyj1SXZVt+zjn25s+vZ/h
 aa4jJ+rxuSfzwCCbydIIm+6nOVtgHw9JPWQxe58+fARv5yD6THBLkwXzRnEH4TqKVQy8za6LA3
 0txIYMdyroC+zMi1Sg8IutuPkAFIIJ6dHTUGKFKceCrJbyNVfHH43f48Kh0fD97kSZKws5hNsL
 +E57YcAfVGsHmPKVZNvTge99kbZPL0OBruo9XOVedSimeE1AIV9mU4fJn9ZETD7K767JvcWzvo
 OgQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:43:28 -0700
IronPort-SDR: KEBa0TwcahkFP3XccfHH4Igj47D8Ac9GjL0D7ohPo54BIJik8e8WAHRml08TuJP0dLx8b8AyIk
 RBNqdLgi7KdpbTh4rEdb/L0dTGYyQ+ylBNCkxZ85PZlAihhOWy9jLgVTmf0GXJYgyHOuNYLB+K
 WMm8eFA7vMO4OEVXjNjyFulElHayL+44VkFWib2PMEdRIzs1SsK1tJJ8U6QJGeYI56bVlexVcX
 0ojpihwS4BpjJCpPTkSrHdoLmHCAZZGKs0o5wzNPleY9flco6QI12JmNbTi37y+Bq38gzAjMsD
 Rew=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:33:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2sl6cRpz1RtW2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:32:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132779; x=1682724780; bh=APb6MZhJtx+BKA0st8ClsB22pp0y9Pqig7X
        gT6sLxmI=; b=EYPDnYeYBXvIPZU4yIKMtwumuioUV+FfuJ8fPXn7WoGbUKa7gK8
        7zyK1PX1ztxSUnflTcanHerZGll9o1DObBU+bLHw03SR356wtqMJKa09n0qcvgMS
        vZWj5aB/mrLRcKD+ZLaMWZavI1BMEp4d64WqsbKtIuhCcLZQRoyst2pdWD8Q3ya+
        ByQ8/RWystsxIVYmNeYNkH7soMStSvU7GBy5Z6O0BckSLdQn+7R88KD6YesLFa8q
        MYecYOCLxyWkIdz2hhL6x1SyTg5ktN5Fm733y5g6M9KOTaT0AtP36cbIMuLZhZ81
        iYFb15wzt+oKQjUeF0cNSTKYAFDWutLqRVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jozsW8IXX6bG for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:32:59 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2sh28h9z1RtVm;
        Wed, 29 Mar 2023 16:32:56 -0700 (PDT)
Message-ID: <93331778-cc12-5d26-34a5-7cd8834a0309@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:32:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/19] md: raid5: use __bio_add_page to add single page to
 new bio
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
 <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7ba6247aa9f7a7d6f73361386cc7df5395436c33.1680108414.git.johannes.thumshirn@wdc.com>
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
> The raid5-ppl submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked. For adding consecutive pages, the return is actually checked and
> a new bio is allocated if adding the page fails.
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

