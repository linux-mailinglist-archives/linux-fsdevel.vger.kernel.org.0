Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509CE52E330
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbiETDmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbiETDmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:42:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54931674EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653018121; x=1684554121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsP9rR0bmsdYi/b/kU26DDrdo3eIaFFijAIs7ZCN7N4=;
  b=UBHfK36KLn7oVanXIIt4lLXgTczVDGA2KL48f3edrs+MxPtrcLnMnKjp
   idKaG3Ezx1J9H8Hraw9KaAbUxZrepG46ECCrTkNgNnd505Wt0/xDliIgd
   Tnwev5qXexKIlo3LnvNLHNmQVEjVw+rjTC0U470vNYkPgZeHY8yJrj8+6
   X0VU/s9hck1ZiDqwUe1oc9FlSxoAlM78+0theeTgWMRPzPqIDmNzDPIJY
   d0IiLnSVrWm1aEUMJ2UOklj5UmiByG5DFlraMI4XxpCL5PH4qp6H3Ai90
   URlgfxLFz5z+ncbO4pMdplwi6BbFjl6YQLrw9f3hNnkGm915NSVSXmsce
   w==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="312850100"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 11:42:00 +0800
IronPort-SDR: +qXE1bTiu3ppNh/IHURTyTR2R+dDnqwmm9zlnHZ5P2htsNvr8NEsyvCV17lUjXK0Yp4NmYWQPI
 0jbUSgQ5uo22vNvq6JR28t7Hv1F8pgtqVXUYWhtteL+MRGmlv2jOo50onrHrXjItMeyJWygdqJ
 Dgyb6fgqvMCMb2zDuIeTQ9K9TTYWXgBPh3Mo2JMP4GHSgSEzr8uS8fK+c871EhPwtqQzUWPJk/
 HgKG/EvTko3ma2FaoYplDTmpE4bQy/SWUrqPzS5c58sLm2W3pc8+uNnt8jGToNHrtOILkp1oMC
 kuFF/d//cJhdEl1IPPJcxuPi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:04:51 -0700
IronPort-SDR: wnnn2Ro0bJI8kSFxoPlss1lNOUKVEBNZ7wTUZHv+o5TD8QGkThQtlgtjlcMs/p9FtgWml6+ETr
 7Mn7TLjmUQXHwM+50S5tgVEkdLYfzARrivOVyHIiIUQlZSoBWnq9mSkuN12ieX/9r/4pxOWZKl
 zZthJXpJPWHVfJyx+SVYboRao8weZ+pTj9YBQkwL7rqVCp396FQPVMUbSfONdYqFAs26MH5syH
 9yqPOGv/s+huxkz7nfvba15IAz4uqrCMDc9qYR+AnCKe8wtIN+5XdVoUs1qJToG7jEUG9AvPI8
 uzg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:41:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4CFs4F6Tz1SVp1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:41:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653018112; x=1655610113; bh=vsP9rR0bmsdYi/b/kU26DDrdo3eIaFFijAI
        s7ZCN7N4=; b=TOOPyIZkc/aHTy2wEvoXXElTfusvRXNu1QsteanVuHg5bqU7wWO
        mwbjBiXuQbiTRw7xOyeeg1G9XUUTu1p7ojInIix0A20JmYpba9eWGV64Io5bxJAX
        YM2UKPXaoFkpFvWRoEEF3xbTnSWhxN0Ur4ew39qYPlfCIPZoRhPdEn1d6JvvFvnC
        vaxvAvp50cS5sqgaHhkvG+W+GB7GOB7JDE7zHiORzahyLnZEifUqJ8UnvoCDbblp
        QQPrHhnakW49nTbPvFpfzOrvstlSaJp7ilas6c1UXq+ywivUEYDpx3eIHWuHMhuE
        a2qqGH20HOi7zag1S+AceVtOJ8x2SsAWXPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HnKP51BcboDN for <linux-fsdevel@vger.kernel.org>;
        Thu, 19 May 2022 20:41:52 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4CFp71jmz1Rvlc;
        Thu, 19 May 2022 20:41:50 -0700 (PDT)
Message-ID: <e4b57864-a685-d7a4-b8dd-1078547f7b0b@opensource.wdc.com>
Date:   Fri, 20 May 2022 12:41:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org
References: <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
 <283d37e8-868a-990b-e953-4b7bb940135c@opensource.wdc.com>
 <YoZ8OKDXZBiNd9XB@sol.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoZ8OKDXZBiNd9XB@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/20/22 02:19, Eric Biggers wrote:
> On Thu, May 19, 2022 at 08:45:55AM +0200, Damien Le Moal wrote:
>> On 2022/05/19 6:56, Keith Busch wrote:
>>> On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
>>>>
>>>> So the bio ends up with a total length that is a multiple of the logical block
>>>> size, but the lengths of the individual bvecs in the bio are *not* necessarily
>>>> multiples of the logical block size.  That's the problem.
>>>
>>> I'm surely missing something here. I know the bvecs are not necessarily lbs
>>> aligned, but why does that matter? Is there some driver that can only take
>>> exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
>>> queue limit into account, but I am not sure that we need to.
>>
>> For direct IO, the first bvec will always be aligned to a logical block size.
>> See __blkdev_direct_IO() and __blkdev_direct_IO_simple():
>>
>>         if ((pos | iov_iter_alignment(iter)) &
>>             (bdev_logical_block_size(bdev) - 1))
>>                 return -EINVAL;
>>
>> And given that, all bvecs should also be LBA aligned since the LBA size is
>> always a divisor of the page size. Since splitting is always done on an LBA
>> boundary, I do not see how we can ever get bvecs that are not LBA aligned.
>> Or I am missing something too...
>>
> 
> You're looking at the current upstream code.  This patch changes that to:
> 
> 	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> 		return -EINVAL;
> 	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
> 		return -EINVAL;
> 
> So, if this patch is accepted, then the file position and total I/O length will
> need to be logical block aligned (as before), but the memory address and length
> of each individual iovec will no longer need to be logical block aligned.  How
> the iovecs get turned into bios (and thus bvecs) is a little complicated, but
> the result is that logical blocks will be able to span bvecs.

Indeed. I missed that change in patch 3. Got it.

> 
> - Eric


-- 
Damien Le Moal
Western Digital Research
