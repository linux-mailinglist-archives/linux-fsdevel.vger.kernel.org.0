Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA05666C5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjALI0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 03:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjALI0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:26:12 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046D266B
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673511971; x=1705047971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sr3ArDEmfNCuygQFLPShrGCz8hvfzXLxVli7BXUMZZQ=;
  b=JDWCggk1lCI1a+Jnvacf88ILZXtCzqb6ke4iMLkVmm9++8VjC29ughvC
   VDVluWl7+YFNqdQLfRwaXImUW01OrLsmiiF1WTLdz54RB95O87Op3/mIl
   lRnPPwbXH5oUGISnY4R6IHHDylTuU77YqxaxbVhGJYMxI7wW8nvtbHIQ4
   jtCEsmePM0525pLSPTmiNG9cEdZazIaa8Ay0fuic2j36NGd4TmQxm2Ol3
   fCvDvZXZdZf1Y1MpEX0fclsgwbiigOAXAodPzLtB2y0yrONJXtj+hNYjo
   QuDpt1uPK3qRmbdo5Ha3xfLHuWtTD+6YgzISIqmCjiA/1x7x92IsXkQll
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665417600"; 
   d="scan'208";a="220482479"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 16:26:07 +0800
IronPort-SDR: 0P00cE5yiSdq//zhu1V3cI0H9Jvb3N4UIiNNyoJn8twk9LNuOKzuaJVt9tADY2zVQk79Flnw1v
 hJDCDSrlG9lyLAMnIaoPODMH/mE97YfKzF8omBIEKYSigj6Xiw3jEVae+8hkVYMQ/258A6qYeU
 74wiqdCaGoQvtqBdrGasXdlmpuWN8hMUNprld6Tq2mQT2rIU9+zBREbOCLkjMAdhwspwYjOKX1
 F7GiCDMsNwxZgt/g80/i4JNXRQRdVPJ7vc1kp6YnscwT9QGtI7wEWQkRKwsBDqlSgMiEtk6PU5
 dPk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 23:38:11 -0800
IronPort-SDR: 54MiYOo1MZSewz3AP4no53dW6fu9jc8J10Vf/7iObYousc+hIytFsUNSayJAGtHBNGWuVErwSb
 wjln7dec2izVm8xkDODJobQ69Ua6RTmRNON2PXCkBnnkW++WdWKPkmuSR20j7niOuVJpp8viyx
 c5T1BjyqRmBsDd2FIKtv83oguCa+W+hJujZjCHiIlK5V3ieXjaHJYnZ5r2Hxd6Oc+xn6soyK/b
 i1VzwEdOkxmbrFajOe9Y3adMKt0LlIO2cnleMsGw4a87LelVtTEFKfHCKHQeYqNXcJEWLJYSpT
 LbE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jan 2023 00:26:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NsyLR1mhwz1RwqL
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 00:26:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673511962; x=1676103963; bh=sr3ArDEmfNCuygQFLPShrGCz8hvfzXLxVli
        7BXUMZZQ=; b=Dua4e2TSpaf0daARq0z46kus7hxlgzLg5akghue0dOO+1E5SC0p
        +LFeHn4jkMJUs3SK3KeCVVxCnzVWCeFH5RVMdZhGEurkRUvUekgZT8k4XstNlrYF
        9ASb6ckMrL1JKlsdTXh8zjy1GIHQVz4MhP8AEyWbCgzTrW4MpgW6Lh1xcXJpiaiu
        ADqGEr1JihxM2qssm3sjlVCjPwSCpt7NbcKOrDtRxvRxaa5Dndq87A3HnCKJHfSY
        maJtzhqgyBXWd8ZLExJfbBTL2is6cnwxps/hNh5a66v1Rst67IvwcHoTJsClyg1J
        NiAQ5jaA0DpxpWwnLpRdDRHORY0fBFuHoLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Gk3VGuXDUpX for <linux-fsdevel@vger.kernel.org>;
        Thu, 12 Jan 2023 00:26:02 -0800 (PST)
Received: from [10.225.163.21] (unknown [10.225.163.21])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NsyLL2PkDz1RvLy;
        Thu, 12 Jan 2023 00:26:02 -0800 (PST)
Message-ID: <8cf5ed66-2b96-d9da-a619-1cf29ffeba6a@opensource.wdc.com>
Date:   Thu, 12 Jan 2023 17:26:00 +0900
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
 <3cd10400-05e1-3190-db0d-78026acf50c5@opensource.wdc.com>
 <bac325d5-34c2-ce4e-781b-d19f24126002@opensource.wdc.com>
 <78d06124-8dc6-d77a-b519-ee5d4847b479@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <78d06124-8dc6-d77a-b519-ee5d4847b479@wdc.com>
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

On 1/12/23 16:33, Johannes Thumshirn wrote:
> On 12.01.23 06:18, Damien Le Moal wrote:
>> On 1/12/23 07:08, Damien Le Moal wrote:
>>> On 1/11/23 21:23, Johannes Thumshirn wrote:
>>>> On 10.01.23 14:08, Damien Le Moal wrote:
>>>>> Using REQ_OP_ZONE_APPEND operations for synchronous writes to sequential
>>>>> files succeeds regardless of the zone write pointer position, as long as
>>>>> the target zone is not full. This means that if an external (buggy)
>>>>> application writes to the zone of a sequential file underneath the file
>>>>> system, subsequent file write() operation will succeed but the file size
>>>>> will not be correct and the file will contain invalid data written by
>>>>> another application.
>>>>>
>>>>> Modify zonefs_file_dio_append() to check the written sector of an append
>>>>> write (returned in bio->bi_iter.bi_sector) and return -EIO if there is a
>>>>> mismatch with the file zone wp offset field. This change triggers a call
>>>>> to zonefs_io_error() and a zone check. Modify zonefs_io_error_cb() to
>>>>> not expose the unexpected data after the current inode size when the
>>>>> errors=remount-ro mode is used. Other error modes are correctly handled
>>>>> already.
>>>>
>>>> This only happens on ZNS and null_blk, doesn't it? On SCSI the Zone Append
>>>> emulation should catch this error before.
>>>
>>> Yes. The zone append will fail with scsi sd emulation so this change is
>>> not useful in that case. But null_blk and ZNS drives will not fail the
>>> zone append, resulting in a bad file size without this check.
>>
>> Let me retract that... For scsi sd, the zone append emulation will do its
>> job if an application writes to a zone under the file system. Then zonefs
>> issuing a zone append will also succeed and we end up with the bad inode size.
>>
>> We would get a zone append failure in zonefs with scsi sd if the
>> corruption to the zone was done with a passthrough command as these will
>> not result in sd_zbc zone write pointer tracking doing its job.
>>
> 
> But then the error recovery procedures in sd_zbc should come into place.

Yes, for the passthrough case, because it ends up generating a failed
write, which zonefs catches and handles. All good in that case. It remains
that the patch is also necessary for scsi if the corruption happens with
something like dd, which will be seem by sd_zbc. So subsequent zone append
from zonefs will succeed, even though zonefs is not aware that the wp
changed...

> 
> Anyways for ZNS and null_blk this is an improvement:
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

-- 
Damien Le Moal
Western Digital Research

