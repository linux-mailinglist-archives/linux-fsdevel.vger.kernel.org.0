Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEA6CF781
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjC2XhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjC2XhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:37:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D885260
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133023; x=1711669023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D+aEMixN3+lt/Ao/5W/66ZnjrxKALm8DtG5/s/spqgo=;
  b=BzGDv4wDMMy25RxAK1X7aozfjxuF5ugpCtmS9L6fndLUM+XfgrB2oBwE
   6TjZFDquUzf1lzzZLflhvWvnCymbu9jQ0Gdk1kO9dVJAy+gjdYaNDONm3
   tWUSLy8RwlSFC/2KmIqlGky4IKUVovHVga9YU6fonEniPcIsBJoIP6OfZ
   7fp9JhLxzSNJE8+ZdrfUJ9XT8P7zVtkOd0dQlXLWPr+4U6LXc3U2KEgDo
   9iWGSqe/XlIGl0JkPDJ+jMFewIMMk1+4PZj2/YFjYOmm3yVgL9QZ8HoBQ
   8FWcy/qXTdrdrYXDLwYnZNvNGyXcCl0wpoL8i7esDPjVM8uz2g+zmDOR3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113840"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:37:01 +0800
IronPort-SDR: sqSj9M6XOW9/bNfTAJFPwjaMhoZZ1WdUUID5VZXUyyYoGIKAB+zR73Go2gZJVuXA1XfDmOobK0
 BBLijLNfRRIJ4Sht8oByPxj0hYXPoLmWovexGi9dhqMXnyA+XEtb9NYYh9/CZ+zSAHQdlko5Yc
 U4nrcnkv2xhEH++YazddWFIFQSnvv7vUeUTLS3SAxAJY/3hCj14kNge3hSUAzF8sDarRi+Tbfq
 Rd7JlO7unQ/VFwo6b76AIoJvuF+DXuUMQq6tpqFJYj2trHacCcV1CcvHwPiAVL9YKFC8P5I9Jj
 5ag=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:47:29 -0700
IronPort-SDR: yLUgKV9G8IRBRH25lP1kiSV6ULs+tPLc/kNJ9VCkuQJp34XdA9oTsfNhUeP7xty2dxyl+GIYgy
 tqA6ZGcIwFxN6luNRxJoCRiQMPUd113OOPQtG3NmJJ+pCqhU8160AT3df9cEjOp85WAm5sbrON
 dSE9Hlq3taLjQpmGxxjezIRf9HVQ38hNVVuNSdwMKBffz+HUknT4VD/OCpSuaJlWslar5zLcdb
 9IJ38HFx/ifiZOWuzVFQS/bk381z1qbzVkT/Z41LVzPWf6KLwSGA/AqNA7HhN4cVPjedyDte7B
 UhM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:37:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2yP4vclz1RtVp
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:37:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133020; x=1682725021; bh=D+aEMixN3+lt/Ao/5W/66ZnjrxKALm8DtG5
        /s/spqgo=; b=BEfOkYGGZfGNwIpK9BEJ0FcFAcVLpJnvJCRHtqvX1ZSykJX+oaz
        TiKbQqo/rlFcgsGqwufvYk8MIKGTrAb9+RSsrJd3SZRo35htZKTw14P+p/eD7q/J
        ceqYnoioxpQ1yuPl8XxWYNWTguv/974yBA9klFhcKgFSo99Ul+ebGjc2RjgypZF9
        Edw+QnL+wy8s1G7+GYq/bnFol1i1bpAhLPRysri8L0LJfnjE4aU2+znrrOFBtHLe
        kPJoBqaYr+hUOYgCZHb6OjFE3dVfncY3OnznL/HrXrJLgp+49NV58WitEWdLbK+H
        SGYLaXAVc//3j4H7s6ktsYfZi2PJTJuLWOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tuVj0-oNzN-z for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:37:00 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2yK4J91z1RtVm;
        Wed, 29 Mar 2023 16:36:57 -0700 (PDT)
Message-ID: <1027d62b-d09f-e9fb-b8fb-9876fda97f82@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:36:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 14/19] floppy: use __bio_add_page for adding single page
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
 <aeff063d2f56092df8cae0a6e9c1a8e771994407.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <aeff063d2f56092df8cae0a6e9c1a8e771994407.1680108414.git.johannes.thumshirn@wdc.com>
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

On 3/30/23 02:06, Johannes Thumshirn wrote:
> The floppy code uses bio_add_page() to add a page to a newly created bio.
> bio_add_page() can fail, but the return value is never checked.
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

