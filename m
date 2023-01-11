Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA4666605
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 23:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjAKWI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 17:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjAKWIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:08:37 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8537FC3F
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 14:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673474911; x=1705010911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v5dxX/2Gxt2li5E9l1qkLOhZPtj69umZvAC6Ddd0t6Q=;
  b=qL3uOmRVgIGux3gKIp2/cNCQ+95bFcDW8JZHjm42IWPYavqxyLJZAeMT
   zXS7EIKV3PVtm1DEi+SBI1m7WO1fOxcf1Qf1uaF+HrMzEwMzTerRs3b+q
   gyy7Jz5yZCUQo37bEm0+rfzVg8iwaeCU4NhXKzxk2+jAbchMtG8At91/r
   uinFse2IS4hab2SZSkcjwNIKTqkC59Kb07DAalrp+WDfx0MwXQ6KSN+1K
   kJ4+68Rev6Nk0ZfHGyUo+fjgjr/S/9PjCb2phYdFGORCs/2ls806s+UYy
   jet3DUBRw4rlXaRv1AQmNsOkUG4mN9KkEegFjtrvhNHEUpcv1Sn358blU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,318,1665417600"; 
   d="scan'208";a="220675723"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 06:08:30 +0800
IronPort-SDR: RQH/B9ohRgPZAEuruGDo5Y9bZpUQ715rID9izwlYVCZqqzPKxS7raHhimIdIGWD5pAQOrBw1C/
 OUkf+mRTH2sdwHhwt+hVxw1uA4VXsDUmMTsShx0cZCe+gO9CGmu+JzVk3y3JmWU+DJ5f8WKtje
 GqXLDJJ/zhEUhskD+eIf8ayncuJtxW4WT9J9O6DQ8pp2NR2zdJ4lK4TKrBEbWnkNggcyQ4ywe0
 Q6m9AvtQ18aisjZgiAnAer3o80pkV9mmn07G/6lkJrOVSirQk1JoOCn8xv6iz+hgcbm5CcMioV
 SYk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 13:26:19 -0800
IronPort-SDR: z9T79x83maAUKThXNcJBjsRM8M6pcLmLI+C66qDJUNqUSmrk8ABQfqG9naFHUqEUT38mk38j6H
 PC9DuoX2YBKcLx7LhpMD2n8KH6wsGehE8XihHte40xFyu5vVfz+kWOS7mY3FyP92UnASButxgr
 VC1eyocAR5aB7xiIfNDcVWi6Cgh2FXSVOXIFDOeoTHFmer4Rk1KE+2sMrDyZO/FxsSE24Yok0/
 th9pjA87t3qsyYqASB6Yn4lbxBnB7LCJiWer2GBxorgt6jd2ks7P3F0u9T7KKZk3FMsY3pduLZ
 Jfc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 14:08:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nshdp3msvz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 14:08:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673474910; x=1676066911; bh=v5dxX/2Gxt2li5E9l1qkLOhZPtj69umZvAC
        6Ddd0t6Q=; b=BdNOdxPbloX6A9W1KD+Jjncrm+g8Q+5OFKu0LbCjbPF4IYxqEjw
        yMxszMptzROWFRArKn6yiVt/yP7QnhuyL075s5SC5fMXtOY0Arxj+96aeZBJ9BNu
        LtTx3wKrmuZ4z7pDBmZjkmDrc9gbyfxRp7oRHK7i0mUbUn7aPhbNTXjvmK8KBMhQ
        CPb7mY+3zT4OdOGwOKPWymlsd9BBCq1KfoHFktsIQGw93pdNp0UV9I8jyFtecFXH
        LHa0J1STskKJKCX98d2k6XNTkkRRCEQY5LJnxH0VCAQRU+g4NhIcY2j41yP5aJUJ
        1RgBU/FW4LBv6v17uDYig3CSVb9U6ZtJ+ZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D51LBwaX-G2d for <linux-fsdevel@vger.kernel.org>;
        Wed, 11 Jan 2023 14:08:30 -0800 (PST)
Received: from [10.225.163.21] (unknown [10.225.163.21])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nshdn4L3Qz1RvLy;
        Wed, 11 Jan 2023 14:08:29 -0800 (PST)
Message-ID: <3cd10400-05e1-3190-db0d-78026acf50c5@opensource.wdc.com>
Date:   Thu, 12 Jan 2023 07:08:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] zonefs: Detect append writes at invalid locations
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?J=c3=b8rgen_Hansen?= <Jorgen.Hansen@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-2-damien.lemoal@opensource.wdc.com>
 <cca3c2b2-38fd-ff76-8b58-ad70a2eaf589@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <cca3c2b2-38fd-ff76-8b58-ad70a2eaf589@wdc.com>
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

On 1/11/23 21:23, Johannes Thumshirn wrote:
> On 10.01.23 14:08, Damien Le Moal wrote:
>> Using REQ_OP_ZONE_APPEND operations for synchronous writes to sequential
>> files succeeds regardless of the zone write pointer position, as long as
>> the target zone is not full. This means that if an external (buggy)
>> application writes to the zone of a sequential file underneath the file
>> system, subsequent file write() operation will succeed but the file size
>> will not be correct and the file will contain invalid data written by
>> another application.
>>
>> Modify zonefs_file_dio_append() to check the written sector of an append
>> write (returned in bio->bi_iter.bi_sector) and return -EIO if there is a
>> mismatch with the file zone wp offset field. This change triggers a call
>> to zonefs_io_error() and a zone check. Modify zonefs_io_error_cb() to
>> not expose the unexpected data after the current inode size when the
>> errors=remount-ro mode is used. Other error modes are correctly handled
>> already.
> 
> This only happens on ZNS and null_blk, doesn't it? On SCSI the Zone Append
> emulation should catch this error before.

Yes. The zone append will fail with scsi sd emulation so this change is
not useful in that case. But null_blk and ZNS drives will not fail the
zone append, resulting in a bad file size without this check.


-- 
Damien Le Moal
Western Digital Research

