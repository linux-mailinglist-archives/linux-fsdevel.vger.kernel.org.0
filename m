Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72E6CF735
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjC2XcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC2XcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:32:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B9D1FFF
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132738; x=1711668738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2oOVyR5FAdaST7S/q6ZiTs6JWIlaWidrp4+z9soxNLY=;
  b=lxQDF5IPXdv3N0Of4APic76sZ7mpSM93oinOV2I0jbh5V5WQibbkgs4j
   4Limy1ZfHyKeWFia/n2yl/4c8Kcw34ROvHqIA2An+lrZcRABPlibhts0G
   Hm2zL81mBwkrCg+Uzf1rHvr8YaZW4Zds1JLRXUuWN+IrXYU3WhtHwolD8
   NFyTa/Xc/JCWUI/VnpLSG/9nIqjWwj/njX1eMIYfrEruVV25yMpfy3KV2
   04lNXIIq9ASYyD7p0+JWzNyAGBgHSHqTTxCReqjKL3Gve9jNwYrvXyage
   OeKRyfrUGNjue6FTu3QeJhWVCyUUw1SYw8Oqm07SPvVJ9Sq2NGavfnbdy
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113559"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:32:18 +0800
IronPort-SDR: oWrfxQ42QVjfvzcWiSLi7aAGpwFvk//LAFTIoqleZWk6xRPFyZ+5tNEBJgGNbbGm2FhFxHY5sS
 QCsMNv0RkJF4ilH5ELXLQLn1Eh9iSpklDKjBJx5TTsE4bgbGae27EVuODCNrkWHWDI4VRSIyIX
 5CyndfAzeAjeMwyeKVBhpY+NEIdYo0ZFHIIWnlp9Bmqgo9ZPLSL5gBqwNXk+A1s6dxNeBsCB6D
 YBE4XwVIXN3p8buyoTFp5tTvvTK0HOtshKdG5Igf6X5hpTrHB5V/HxKRvifvd7skxaZ6sl4Ge4
 Zvs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:42:45 -0700
IronPort-SDR: 9MpQfG/9juzl2czc7YJSL4DO9mPppbKs4nGxm1o/V09aSI2QkIcycJmk4Ucbucu4/H++fa3ncM
 Xw/EQctUVHVvvhm18V6SKjCXEEOY4J4Hzz8VfPugdam+GfOFw2QX2HlNnH5/HD788Cb05UnF5m
 HjdtYyHaXShAoJyQljn//0JmIxp+w0OFJeK03QWmAPtUwIDTw6jGZaaDPWbzKOyitj5yGL5mBA
 WQdNqrAxx7NrRemZQUl6pSefbKAwf2cnNCTpvMj7cGbvV4Wcd9smxHxMJLyZvFhf44ud9ItXe7
 6W4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:32:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2rx73vzz1RtVx
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:32:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132737; x=1682724738; bh=2oOVyR5FAdaST7S/q6ZiTs6JWIlaWidrp4+
        z9soxNLY=; b=CzTI5dmKz+cz+ra1W91v/vvm1q+lz4VpZaKNJ+ur2JgwvsLgkyz
        Ag9i1RXpGZQVCWt/gCi8lYEB9yivIbPnlXG6Hkz4MlXf5GZofs5pel3W7YhmzADn
        y+IYY/j6Lu2Sr8JsZyfjakqTUdNpz293fh+kzLI/QY1JbVuKx8S2nxmI8RNRgCP9
        5hP2QzGdEOFg9faNtfShxavTwxvhGcZzFc0K7rJLpJN7Iw5Q9BWad4Y+EX6dqTJt
        4igFqUNZin9rq2K2OW32dMdvOFsCycds3Ts6xqe6P+GtL3mkBpHqjGNtHRe59whO
        D7Vet14/ORgEglG520efiA8j4/Y3c2z2ESg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LVK81kg0drwb for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:32:17 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2rt2gL4z1RtVm;
        Wed, 29 Mar 2023 16:32:14 -0700 (PDT)
Message-ID: <a18998ed-49e2-739c-1f1a-c3d2375f4438@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:32:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/19] md: raid5-log: use __bio_add_page to add single
 page
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
 <492cbaf4225065838d25e04f8488528e50a52e3e.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <492cbaf4225065838d25e04f8488528e50a52e3e.1680108414.git.johannes.thumshirn@wdc.com>
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
> The raid5 log metadata submission code uses bio_add_page() to add a page
> to a newly created bio. bio_add_page() can fail, but the return value is
> never checked.
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

