Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAC5286B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiEPOPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 10:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiEPOPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 10:15:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BDF55AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652710545; x=1684246545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZIVl0tMHMU=;
  b=JhV2yhW/SuYHFJrrdfve0QdbrgffQDpBugSwmCPtq5q19cC4HXKEyWWt
   CGwKMbLmzgtLsLXsR/uAw1yr85TRJGh7jwomJ8KRE23MZvF9BExgZf/lk
   2LKY5xE+jE0HCi9okDf7ze9GVLE5ZyXO/m06jj23G0au4VyQEj6mZRN6E
   V9kh1baHUhmhvmExdBNykCxZ7vh4jBS/FzqHkwkkk1YCUNafSYBAEzOXm
   nsPYD4n9HEZqd1YsJ5wvySqcpsv/L4lqkN4+9zAqu9f19BmBpVBqRCKjp
   E7xZpQGNbJqDHN9wV9p3PhuhueJePyGYZe6HTfrFL00ooLm16y5edHfTX
   A==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="200443517"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:15:44 +0800
IronPort-SDR: u3GR7ITCS3Kq5LPj4dUmkmY1iGbSRb+m9daq5lBax5PL1eY7Tehgzu8O7I79f7H99T8KZ7Ff5D
 pfAlG6rW9r5DbsfPQrJfvoLJ8hC77T1GFwVAzSgoUS5gu7wMFh3X+krupt3IaQfzO+BBddyMlO
 o/G9eCsNk+3QY/iFZzbo0QI5nCRVD1qkgOh2JGiK1uqFyATq7+Mh9hp5T/z0ZNRjGPrK0UgulP
 NNn4d/VUvwWAteut5R0/dVHbJhVAoGMkEmpqdJC9iZVvyUADC9J7FmlCTcvd6vG00oaSguJz48
 1Mc1RcC6RZYSmiBeJjihzzrz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:39:38 -0700
IronPort-SDR: 4WVR1LX1FoQG04ar2w9Hl4I94oiFepkDL4Zzvx6JJs5mx4IRl4xQesgpT/xFNdY+kxzpFwwRxw
 vPzMtpQMY+6soPypxwvkaKzCj3MsQd9zlZ1LoruKe23KpGf3FUWr8ZfWA1bbMMgArVkgvBhsUi
 m9vDA7YospH2Wkg4PMbL3DidIM3w42Y5Kg60dy79+CZ56VIKrtlAJfMQpe9wH0m8auQBlwMsG4
 KOVPD2hxsVAsZjltr0XhjISe93PRSbWVvGAHgbqCdQWrDEEeIFkShOUt8wEw9KFjS2YdYZ9GA3
 oNQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:15:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21W339fXz1SVp2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 07:15:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652710542; x=1655302543; bh=zOv+Wev7E5lt7EeSM9kcmJh0rO5V+6OnlZI
        Vl0tMHMU=; b=i4y52IglqHa1njsCmAT+LslWANsFjmGWNuC+BQusYwJboYbqlpx
        1K5trb7R/DS0LQM7zIGMW36j5tKV1MkXjwyqWyIuVDc9mYbpFnl/PFabswil526a
        8PiySSAYXnoSsIriKA/fIQIfIzGNus805nNa9Qt91pNUX3WFWNouE47CHlBB9rel
        maqyn8618u1OIr5FZQpjtBkmCq16SVwivVnZFernknGS9rgAJn+4/1wc9xKfDMsc
        KdcjDRBgvTZk1H8sIVIYRnv8T+1SqXKjglgem7sY9T2qTTW/b7gkVCrv7G4sfF23
        zShZbGhGxHLSBwjGLH9SpFHHDxkqgHQgncw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kybnqqTu5rVS for <linux-fsdevel@vger.kernel.org>;
        Mon, 16 May 2022 07:15:42 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Vw31VPz1Rvlc;
        Mon, 16 May 2022 07:15:36 -0700 (PDT)
Message-ID: <31e03f27-6610-c4e4-58b9-6b9db000a753@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
        Chris Mason <clm@fb.com>, matias.bjorling@wdc.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <CGME20220516133922eucas1p1c891cd1d82539b4e792acb5d1aa74444@eucas1p1.samsung.com>
 <20220516133921.126925-1-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
[...]
> - Patchset description:
> This patchset aims at adding support to non power of 2 zoned devices in
> the block layer, nvme layer, null blk and adds support to btrfs and
> zonefs.
> 
> This round of patches **will not** support DM layer for non
> power of 2 zoned devices. More about this in the future work section.
> 
> Patches 1-2 deals with removing the po2 constraint from the
> block layer.
> 
> Patches 3-4 deals with removing the constraint from nvme zns.
> 
> Patches 5-9 adds support to btrfs for non po2 zoned devices.
> 
> Patch 10 removes the po2 constraint in ZoneFS
> 
> Patch 11-12 removes the po2 contraint in null blk
> 
> Patches 13 adds conditions to not allow non power of 2 devices in
> DM.


Not sure what is going on but I only got the first 4 patches and I do not see
the remaining patches on the lists anywhere.


-- 
Damien Le Moal
Western Digital Research
