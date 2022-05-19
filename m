Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75F52CC21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 08:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiESGqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiESGqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 02:46:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79D13CC8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 23:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652942762; x=1684478762;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cqPMPg/YffdZHcCrnM3XKivoHpwnlB3DQsGm/ZDGisI=;
  b=qaOKyyvGIi1+cgaub3kKR+eGyeviyNHQHpxaCE2Lzdc5tN0Nh09Oe/nH
   guh/1cU8Zu8h5DtXbppg7Yct2mN1A5nnGTubg3esy2zykJHmgDRMLPGoS
   mbOKpkXOEPVGh+e8oCj4rWR1+MlWOFEM6ia3W57dm5PnecqwIQiYljwX+
   TWEfxPghiIVlo3pQGdWEVn+BEA1CGDg38NjxfEwG+H/GH7c1Dw7ZcZkyr
   s8X+GkEdutM2l8WN9qrDw+QmeV7zeNTWJ3Gg8X+yKAzKuOZmvK30Sf7gt
   lETd7BAQfMOruTCToxOinvkJVeY/DowZ2FwIrZceOQM5UOO5z/k2EdR35
   g==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="304981961"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 14:45:59 +0800
IronPort-SDR: 9yDUwaW3IHRrA/Fbbe8tmUmyi2safabmxSEqzEK60lCvYlZ/Ek6KSXEuI2Wfs4WDj+kIj9anBe
 aeJAHkp+f7i7sVlCHjFaw8K7ozOnWnvfQp6xg0QARfOY4vbBwpM0PYWr6r1NbgxDpmX+hmB/0K
 dOVQVTDn6La3/YVkHypdzA9NVOy5CPCYLIx75dWYnaVjsXizCkKZ3zPb0IG+SN46WsEnbdk10j
 TAKf+glNK3ZcnKV8Q6bCoN0aKLTAHqgSqvbRUmQX7y4NbAhqVB4P/BrvCGYvPHlYLEIEOpGQO7
 MhddFxvkGgD8xpYA0u+OYiwo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 23:11:24 -0700
IronPort-SDR: wBsXFLy7TnZw171FBLIKxoO+isuvCRDej2kj6kv9Cyu4WFb59sTd/fqOmVcydcpw9L/1hZ9Zyk
 QUn8BZcZof9myFf0gvJo/9Hr7xpqkCzKDoLITh2STxb7HLZNt+ldgTqNEszmiB/8/O9Q2cTLUE
 PHMEHMNXpo1Qc9kNB3DSIbMKcvC1GgqOLOd/p27tfKqrKDwFeZxuWiWrDjgtCPy+9G+KfLqNmP
 wdY9uKNvprgV91L1cVUolIcw6fJmC19+Wqw1SEqUXhjrugY+2lQc4g5J0qei6hyu4zejWXbO/e
 Ujo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2022 23:46:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L3gNl2DXzz1SVp2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 23:45:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652942758; x=1655534759; bh=cqPMPg/YffdZHcCrnM3XKivoHpwnlB3DQsG
        m/ZDGisI=; b=H2A8vDR1hn+U2YAW61OKPa7ido07LtclbMZI468okOV/RbXWPTh
        o032LhvSNFNCTH02sTgX4vtrIT5VvHrQzZL9fDScL7339i8nOr6U5h7qNfyW+VBo
        9Kv8K30k78V1m87g637oYh39Ue1VxQYsx0NsOVj5cavAae3enXHEUKMUMPNpQNep
        70U53xETn9VC+edj4T4qCpYzeF9tgiv5vPimcOcbCvnVM1pxINQhNRcrVeN/pkch
        fJJ2KS1dkAveymSqASofPwtzNoI6MR12/eS5WMUGW+cVlNsQrvaWO129DflliQcc
        HteqKEyBIzqlDKmzO8vIhni91VSFRZqDOhg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xsDNySC5k6y8 for <linux-fsdevel@vger.kernel.org>;
        Wed, 18 May 2022 23:45:58 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L3gNj0Hhzz1Rvlc;
        Wed, 18 May 2022 23:45:56 -0700 (PDT)
Message-ID: <283d37e8-868a-990b-e953-4b7bb940135c@opensource.wdc.com>
Date:   Thu, 19 May 2022 08:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-4-kbusch@fb.com> <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/19 6:56, Keith Busch wrote:
> On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
>>
>> So the bio ends up with a total length that is a multiple of the logical block
>> size, but the lengths of the individual bvecs in the bio are *not* necessarily
>> multiples of the logical block size.  That's the problem.
> 
> I'm surely missing something here. I know the bvecs are not necessarily lbs
> aligned, but why does that matter? Is there some driver that can only take
> exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
> queue limit into account, but I am not sure that we need to.

For direct IO, the first bvec will always be aligned to a logical block size.
See __blkdev_direct_IO() and __blkdev_direct_IO_simple():

        if ((pos | iov_iter_alignment(iter)) &
            (bdev_logical_block_size(bdev) - 1))
                return -EINVAL;

And given that, all bvecs should also be LBA aligned since the LBA size is
always a divisor of the page size. Since splitting is always done on an LBA
boundary, I do not see how we can ever get bvecs that are not LBA aligned.
Or I am missing something too...

>  
>> Note, there's also lots of code that assumes that bio_vec::bv_len is a multiple
>> of 512.  
> 
> Could you point me to some examples?
> 
>> That was implied by it being a multiple of the logical block size.  But
>> the DMA alignment can be much lower, like 8 bytes (see nvme_set_queue_limits()).
> 
> That's the driver this was tested on, though I just changed it to 4 bytes for
> 5.19.


-- 
Damien Le Moal
Western Digital Research
