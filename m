Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542F2666AB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjALFS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 00:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjALFS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 00:18:27 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513674859B
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 21:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673500706; x=1705036706;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7XmOqbnGdh3OQ0csUHCquXpbRJQFXO0b/WVvzFvFqN4=;
  b=rcvCknBstJdBe/rG53P5twTxTYh77m2OG/kEduAKOX5VM+fgSv19YSGz
   2BrUOdvHMJdKMvT44kCoaXoeINaj0XfD1wTOTQocqH/89rxGdCPgYT4uq
   MEiWAsDNgidE1MjQooJ1j4sCheGwLBlaRJSta4njQN74vN4K2lA8OSZfv
   aW0lTjdNMdLsE8rwMGAQAMOlmDeej204d86UFJZXXsHmLdoe0lhpyjX2s
   Ndz2ryVWTZcj+/uEJ1uXh86yTPUwdG1KgDYQtqgNRjZSlsAj1XGVVXsNB
   t+l8pKFl/GEVRN5Nqo7IslcoKwPQX/qiG5Zi2koeqTbeHmr8slF1ko1kT
   g==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665417600"; 
   d="scan'208";a="225641810"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 13:18:25 +0800
IronPort-SDR: U5anvrfLze83hbS+shDqpBa65z6aPKCnA+Auuigrv2Lg5VHOXgerL8CoGkCqTdRCzVQASWeeZe
 antDIDLWt9dNWxGbRPjttBqIJXzxPpndBuGQg2Hj5O4ctLNtME1/XuAgX31o154FtBZ5SGof20
 x/Wigvcs3MAi/0LJZ/xdvzecVRjzZ6cetuqTFYEtFzHif4ydg65G2gNXdX2ob0+fl7qjHQImVz
 tbgvF9TAD8hXiFj5b2WkFNAYdrHDw5YQEFUNsxAQvPIrh1eTn80Gw8CFuMYT18fv8tQqzEdlSg
 RJA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 20:30:29 -0800
IronPort-SDR: MoUWKALDl/3yCl+loSULmE+DugH9dAWLMbluqhXq0yDJc9WL7Ydy/S0b5lOlBjbSqbal4LmEBt
 UkCTgnmy+No9vP4hu3qIzqQJI14ebqvdq8JzW0jnUtB2H7MiKUwH987gb/mLL12LGwBuio+R7g
 30QdL7nxac+0OQV2K7S4Mai7ladCaTeMe0zZzfZBCE+Kmsj2iGslr9Y7sInxuLRwMTngj6jgd/
 kFv35diiOWIuxeoQZqQJiPdXg3+qBtVz2YjkNXcL65Qqr6I77wbpDq/YurTqvoklWEKpV3kfxF
 6Gg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 21:18:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nst9s3fwCz1RwqL
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 21:18:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673500705; x=1676092706; bh=7XmOqbnGdh3OQ0csUHCquXpbRJQFXO0b/WV
        vzFvFqN4=; b=KGBXaRvh5v948lvqhBCzrH/MBsq0ETA0QUZ1rsZFFeOUqpTKZtn
        U7KZ73TPAJeZjTzbhYk+zAluBCVdD+yTy9kC5ui+Bn/8BH7NYuIAGAWJmg9gJ8C3
        AQpB/Sw7qqoo9NOZ6mrr/rdL8Xr/RzeGiesl4cYS8JBkFZpyXnylqyh+aIAIFdLy
        O1NhwHI+gmy8vCCqy+fubwmand8qpQjHQy5MgJ6QFxwI5Siqu/MGCGicnszmb5k5
        iHpvTLNwEGMfSZLE+LWB1JcVyQejSClOuw6cCRztE6tdiVYbzW3/ntxqPVmY3xrH
        BdMFfm0naqNAilfj22k2dX/7MS+8POmZNuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YFqpY2-tBo5H for <linux-fsdevel@vger.kernel.org>;
        Wed, 11 Jan 2023 21:18:25 -0800 (PST)
Received: from [10.225.163.21] (unknown [10.225.163.21])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nst9r3kt9z1RvLy;
        Wed, 11 Jan 2023 21:18:24 -0800 (PST)
Message-ID: <bac325d5-34c2-ce4e-781b-d19f24126002@opensource.wdc.com>
Date:   Thu, 12 Jan 2023 14:18:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?J=c3=b8rgen_Hansen?= <Jorgen.Hansen@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-2-damien.lemoal@opensource.wdc.com>
 <cca3c2b2-38fd-ff76-8b58-ad70a2eaf589@wdc.com>
 <3cd10400-05e1-3190-db0d-78026acf50c5@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3cd10400-05e1-3190-db0d-78026acf50c5@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/12/23 07:08, Damien Le Moal wrote:
> On 1/11/23 21:23, Johannes Thumshirn wrote:
>> On 10.01.23 14:08, Damien Le Moal wrote:
>>> Using REQ_OP_ZONE_APPEND operations for synchronous writes to sequential
>>> files succeeds regardless of the zone write pointer position, as long as
>>> the target zone is not full. This means that if an external (buggy)
>>> application writes to the zone of a sequential file underneath the file
>>> system, subsequent file write() operation will succeed but the file size
>>> will not be correct and the file will contain invalid data written by
>>> another application.
>>>
>>> Modify zonefs_file_dio_append() to check the written sector of an append
>>> write (returned in bio->bi_iter.bi_sector) and return -EIO if there is a
>>> mismatch with the file zone wp offset field. This change triggers a call
>>> to zonefs_io_error() and a zone check. Modify zonefs_io_error_cb() to
>>> not expose the unexpected data after the current inode size when the
>>> errors=remount-ro mode is used. Other error modes are correctly handled
>>> already.
>>
>> This only happens on ZNS and null_blk, doesn't it? On SCSI the Zone Append
>> emulation should catch this error before.
> 
> Yes. The zone append will fail with scsi sd emulation so this change is
> not useful in that case. But null_blk and ZNS drives will not fail the
> zone append, resulting in a bad file size without this check.

Let me retract that... For scsi sd, the zone append emulation will do its
job if an application writes to a zone under the file system. Then zonefs
issuing a zone append will also succeed and we end up with the bad inode size.

We would get a zone append failure in zonefs with scsi sd if the
corruption to the zone was done with a passthrough command as these will
not result in sd_zbc zone write pointer tracking doing its job.

-- 
Damien Le Moal
Western Digital Research

