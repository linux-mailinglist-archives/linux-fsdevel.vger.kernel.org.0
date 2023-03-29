Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11556CF768
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC2XfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2XfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:35:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205612D
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680132900; x=1711668900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eeHaifFAhmRPPQjhcQgNdDiqHkPhvUoOQEh9qZdcZBI=;
  b=Q40vDSNTGIi54F12judAEoCbV5Cpu8JPgsOBSmHmhC2pijeDxgjtZ1NA
   Jk5X5N2iUO5XXoVdV7BGTyS7DU43uQrh6FRivE4z6MZCYG0RWdV4PUGqK
   wNXJz6tpaLFdH1uswxOf6YrzJdnY3n9J/rTRHmNcGvw29VXVNmstqFtDU
   81LBvCGxbgTdYKX4OddF2n/fwhUgd51NuKsL1i7VxoiW/jS+lENVTMZQQ
   Ljfo9vEdzQV5sRIjto7vD0ZtVwRzTZpJ7pREJuQcvEOrdCPywctt+WV3l
   FFenvCRmjW7ufzqpKAJDzZfzIZju+zL5b2lQl1rS1Z36Ojrn73/gIXDPB
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225113719"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:34:58 +0800
IronPort-SDR: NWJv8OfizmIh3B5I1wXn/G+cAicAlNEMxYsweqdLkk6kCGXv60/AWEK02APu+o1s/TA6uoxWNk
 4mhqJj780f+nieDio5p/BKaeYpzaJJAxApahRcdWWdCKeKKzgyT0G7sYDRy79CUB2YWqqJ+mgN
 I3+a9kpvmcV9n3qES9GzMTEC0ltvfWJaZA41fCrTd1SzFoRrByFMdV+7f0ioiQvD6Mh7t1xSnb
 M2JPSnHhPfzx6jHdySyWtrpVyFpIaIGDiz2BWJlD4jvUroAyAAGMIWa0uXxK7MZHCem6nAHPSV
 KW8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:51:07 -0700
IronPort-SDR: R+vc9d58S7MCaGF1tbvvlxJd0TRCu0CuOZz88bJMaIKk+17KsGVyYxH1wHdd6/thDT7EbAOrp7
 sxp3yaSQi3Favm6fhjFxHnHLxGpLefg8V+KhllrqRf9dg0Fig+h/SIxZ4v3zkA/BR+EH69lQgV
 TVTZIeRnVRbb3lDMlJbWhvt9Uwy7jWOZaE8cVShQGOj7kbOYtl1u57GbCdQOeb60RLIVMKCVnP
 rBIij379WumBv1moIzfr3DgIGsEr7IOhVNXB4AfvvuqUNyHrTd+cZ/O0gog3xNbctNi3pzGwAo
 00c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:34:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn2w23JV3z1RtW3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:34:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680132897; x=1682724898; bh=eeHaifFAhmRPPQjhcQgNdDiqHkPhvUoOQEh
        9qZdcZBI=; b=BXNDcLcmPPrVqL0uFQjErIzucxTlO2TIjyuUMny2mRGUWmQis2+
        Kp33jWSJF1g147Opo3rTneP3H7gwmNnEY+Up30cZQPxCibvRicdthlRAp7HwfA3s
        yZ2CR0pSt1DWieL+O+5noiTVyC18th0YJN7NxnEc9WA69UT3Aek5Gf1Ykc8KUD/E
        fCMhYTIDSrIhJoUmE5A9NvofEQI3CB/096YNkJxWerVVLA5+j1USgnk3t3REY1DB
        4txAUQ8raXYpQ2EQFHL2FPvKU/3Tn62ZAbsAG7vjHNq3VUhum4TuE7DV08/TeyBl
        eQW/1XF2djdTME7GQEAjbOj7c59rU1TGj7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d8zLBcDVhL0W for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:34:57 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn2vy4wThz1RtVm;
        Wed, 29 Mar 2023 16:34:54 -0700 (PDT)
Message-ID: <14a2f204-32a4-5108-560b-98c3dac2abfb@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:34:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/19] gfs: use __bio_add_page for adding single page to
 bio
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
 <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <51e47d746d16221473851e06f86b5d90a904f41d.1680108414.git.johannes.thumshirn@wdc.com>
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
> The GFS superblock reading code uses bio_add_page() to add a page to a
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

