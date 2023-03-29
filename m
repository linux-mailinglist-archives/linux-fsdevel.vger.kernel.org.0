Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7933C6CF76F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjC2Xfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjC2Xfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:35:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E764C13
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132940; x=1711668940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DWbdU79pQfFU8gOZbr/b3mO5eH7xSF4O2WK0oT2d+QM=;
  b=e4tM3OB6qnFZwVEAoNE/wDAps8KIxbd/qD4mXGq0DbK4kTTcdvXQVL4x
   63ZrciB5rGU83XfGNxNAYrxCbry7s/hZIkVhCdoxrJAmqdDwSNjIIDZRB
   9nTry9v+b5yEBuwRWneLdjd94waWBdnN5MeblhCPzA+4SrBGnpP48NF97
   rpYcHE37waXOmIAqCD5NCTZsgxa7jTzb7E9+5rj47NUROLsFNM3p7Nx2B
   cwUtkjSlibyTXUMgi1sm0W7m90BVrbIgH8E84VIh3ZsGIdtJ/kjRI7yWl
   NVHtUyJHG9npjOEvlhMhOjYXZjmLFNsjllOJaXkYcedBQkhq2ivtFPslE
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="231808797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:35:39 +0800
IronPort-SDR: ZTYRqFrQRx3P++Ct00ghfrFC0a6iyEwODxbi5u7PUsp6dJWRuFln/Q+m329wrrCe2qx/2Ux1Oz
 oQ34WqhGzF7tJBtmn2gtKhLgSzofZWBV/Gi2XrKNlVAeP2YBZ/K+D9pdzCHovYrqvghkx3u3VU
 g9U8nlNTvOarEHjp6emObLIrja1vhTRBD2Y8nSBYpREr5xm4FO2vznKMQq5RGB/440RXVJarQV
 E6qcfwwUg5NVq3a4yjmWQFVVwYZFSnLcjK3D1Itwzf5UcrDd1KtpU2aV/EKDQCW+TPug5clwQE
 VuY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:51:47 -0700
IronPort-SDR: iOeRlSLZ1MdIkHYmTu+voYzOsjlLeOG7EufbNNpW5gnGgMoBS/H1iuGJbjetoEXN7PHxxGwm05
 itKIcCur/23c+U7u3StkRYmZnuE1B2a40pzaoCVQklV3XWtrW4hzcH5hY+GitMzlGiL4Nx5oET
 75ZHW4/Pna966XWybebnpUH/GfI7JapB/BjWqMJ4O61MXEQ+psz9MkMbhrJ1QTepb+MATk+cW/
 lkhW9LO8nCaKT67hZ4XKx2MKVMqAW70W6/zX/x4HDSrVKR3B/vU7+/iApy1DQLucCGKlXpBByo
 7xY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:35:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2wp424Xz1RtVp
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:35:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132937; x=1682724938; bh=DWbdU79pQfFU8gOZbr/b3mO5eH7xSF4O2WK
        0oT2d+QM=; b=pGtiZj8FTU2zGz7vQdRVApevxKgf2Ka8vvY3tec47efsQI9KN3F
        6TNrUUZy3srMM5hOLLaNJ9cj/RFbng7Lw8c+GhcUj+WX8KJI8fIL7Yjnd4bTPSsy
        stRUmGBxBOV4gys+ZZFaJ27DeqO7fJhqYFoNYW7LF3jJeGSCgJuHLKFdrC46mgR5
        469/TVxEK1vciOHd8I6Ja/b0kn7Me63VLOI+P7tjou+N5OBIOT0FMExqkO8OsOGA
        8OP7Fy+8XEeqfKciX1F/w0JzBSWbRunSIFL7UwQ/deJBQDb0gvxDp5EIV13Eq79s
        Squ+hzD5gSNXTu1SYU5Wiz5w5imKszOHOFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v6EdNCpFLz6g for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:35:37 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2wk4Fdnz1RtVm;
        Wed, 29 Mar 2023 16:35:34 -0700 (PDT)
Message-ID: <ce3889b4-8689-ac73-0761-fc35a78b8dbd@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:35:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/19] zonefs: use __bio_add_page for adding single page
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
 <ef742ee32fd0623008114e929d9a3e688fd721f7.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ef742ee32fd0623008114e929d9a3e688fd721f7.1680108414.git.johannes.thumshirn@wdc.com>
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
> The zonefs superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is
> never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

