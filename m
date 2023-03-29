Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988F26CF713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjC2X3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjC2X3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:29:23 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C174E35AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132562; x=1711668562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a+NVpLO2XQBp6iZs+ex8RERrDcsLfBZuQOxHVIXweuE=;
  b=rfMii3AkZFug5eMwEbD9IIqjmoyt2+3MWOSja5U4iawTj499qH3unRo1
   x80cwtQWY3AocVd2KRjNcpznqSQOo1dzMJupWFKAO447J77H3tofZtKRQ
   l7c+OGgNiMK1vDgG1rlQmf0UlgaUhQNnwp5Mdnk5TwF9VdmkaZw5U2H8X
   pTdvRUGfTMtONeWblRUHWA4PSpoODL6Ti57Dlv6+LBr/hESYV1IQo49bC
   357/TGGn1SDjPh+uS5N0mq9wxswJsgY1eDKW9NguSo7aQbqnLN+JEDwav
   juAqmcNZzdLgAh9+YOJqr+x+1wfKaU/kmOX+TwOAkbpQbGGEG0+kGSwbW
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226647948"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:29:21 +0800
IronPort-SDR: kl/VUq7q4BpMyJYKBM4/34E0nowyUuyiktlukKAJd8Ead/9+r5J0zAksZCTJ1yzF7v6ZD9Bnxh
 C2o8m+vUXq7lJzj2VkHb3hjLr0cPuR25h6CnQkRD0XsglLF2E0lPHL1i9PMH/ZRErUMAoxKPVz
 ZHgzgzFiBSoWV5AgMVWjilc7RV/AwXdi8C0KOsjzRVcIUkUWxgZv1XxTlIywQBhIcWOyPKHzHU
 DiEy32wcP2KVYyqgKFAsBIzgshRxG1+vaKTeI2jkaAB3t71RlpAbGPFU7CXnBWKFLMgO0biG6I
 wmg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:39:49 -0700
IronPort-SDR: MDNYBYB86f9om74+MyYa60BHIIOA0cNtcl98k4HW/H8EvnKY22kYjUUJjeZPVSTDpRygR+5jgv
 a/F3nJ32+0ynfdbQjszG0GojNqziNYP6mLh/yfn2kVC39dOw2kwUoPBH9xypRRkPATbq6Q7nqI
 NGvpgUKeDrsPm/eO8gk7Hk+WYSA3UsZIhQHCciwWbhanmZzjJyORD5Nb15JnTURl05VLvj01o9
 WYYmU0sjTw8hshGvpP5JjUD0ysH8FJHtXq3FpdJw/qmBnYU0VXOAJxEFsOxGOuYb5stVgVD6Vv
 Ztg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:29:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2nX2Tfxz1RtW2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:29:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132559; x=1682724560; bh=a+NVpLO2XQBp6iZs+ex8RERrDcsLfBZuQOx
        HVIXweuE=; b=ey2f3kk11MiZ8fW2lBsVE6iqLCNprO9dciEEFxTXxN+atK95JFm
        GeL4fdna7sGh5OA3GyhTl6dDgM1awPXCw/oh0ur/h+S4H1cvx8Kq82Mw1Vc30qtY
        Nl4miDGl6PutBI7w7Ra2ULynQ0KRR2jk5wsVgu1BGOTa2pU2ZCzd8135B1HLnAHe
        bwtsBUtPmdPVK5BZusnYQ0LO/k1J1+NHVVOZRXZOFswL4vtTAlv9VzJwO/o1EGqz
        GHmTvBtmOh6QS/VJ7nCVRUApfB8c0Gn/ArE3TTpQ9cCBP794K0T3HJ8VeF0pNwdv
        NXyennxT++lsXIsW0TYKGI/+C0BsoiTHPVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9nYIYOELpQ1u for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:29:19 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2nR75BJz1RtVm;
        Wed, 29 Mar 2023 16:29:15 -0700 (PDT)
Message-ID: <a3e8f1cb-4d76-dcb0-41a7-43b015d25dd4@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:29:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/19] swap: use __bio_add_page to add page to bio
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
 <7849b142e073b20f033e5124a39080f59e5f19d2.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7849b142e073b20f033e5124a39080f59e5f19d2.1680108414.git.johannes.thumshirn@wdc.com>
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
> The swap code only adds a single page to a newly created bio. So use
> __bio_add_page() to add the page which is guaranteed to succeed in this
> case.
> 
> This brings us closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

