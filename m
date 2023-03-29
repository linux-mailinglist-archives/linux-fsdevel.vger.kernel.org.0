Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0B6CD6DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 11:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjC2JtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjC2JtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:49:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6126E4226
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680083356; x=1711619356;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=aSSAlcRJSfAX0O6Zugl95StopLm32g0V9E3LFX80d8M=;
  b=L5TUaA5F3I0vy5gohqhEvJ++AZFBNUT1UNChuWuvQH2C+QEeUUYKGUhD
   3kVlxZDymyR0TL7z/NlMZuCffOr0SnpUlYzniLdQJqHMIXERcXZTN3gfA
   /Sa39hN8x8T23BdAWudZ1oF9p9tWeCmKgUGc87AaUejL9JehjCjLX0oto
   1MBALE1v9IT4fs/EmBDAiufy2oaW18Doc8ZtwRqyi4dOO8mR8cTSomMat
   r9W/LlQRMVJqETGwfzYG7dJittaV/H0gxuKboW5gd92u7qCMsEyXi5Vcr
   U8EZmLX9x/VLzmT9B2f2Vt0Hj7PKvSl1z+OORL5kfECKp3NW5QMR5LPv1
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="331218612"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 17:49:15 +0800
IronPort-SDR: SJdjytCzJYAM+m16xQCBgQEoyJj76Cw9cCexfTml2fyLiJ8RVzRbeDoh4RGPKgsCEVM97DZAyZ
 e3DeZiptIpPYJT5YejfdB2qpjJWgZLciFs3M6ZcxpTkD3h4nbxpnL+Vk59Dh6VPFej4pYOWz7Y
 oYNr+0ZqXByHrJ9kWPRvwZm4yudei5B7FlRCsLTPdG/vGo7j5FDbDwdvgI/LibUV3vLWoUpYCL
 3Lr6iARSnRjGUUuORPh0zdiCMhDNv+17tEmHhgxz8FNy+ARQbKKLyHuvMz7TXxlq1aJCk71yM6
 zJ0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:59:44 -0700
IronPort-SDR: hK8GGvM0GTcsYlegpfttHloFwebiBYDh4sKlHcP8KGvJpTR6j+rBY6k8sjDpRP39j5sijQs6GH
 TtJ1f4Ssl+AiXDh4VmosEZXhcs5EfNa7QVFfHryEoMYaYEeFBUjCLi/OGmWYryZjBn/ys97MEB
 6Dg3+VCcU19uY38q1hmCp9ExcZsJJdY7L8DhiidDTcAAjw/yPu7h8w8sybrxiH/iGLj1kYLMgE
 iqxELi5wgwBXtYNCjUplf9XIck+rp6CBwp5pK9S3jT1Fr8vtxSj3de1tiHvHfGrL4kqOgnNXXe
 KEA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 02:49:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmhbH3LB7z1RtVt
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 02:49:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680083355; x=1682675356; bh=aSSAlcRJSfAX0O6Zugl95StopLm32g0V9E3
        LFX80d8M=; b=o3i8OqVNFkf6qzxOdepmrg6DWIK4C9zd0GXUElLcsj2K1E+CEcu
        57TTW6VJrMZvojY/e0gsaFtLF70c6IA9ss+CtSHbSOto3W5A/0Q3tmzOevr4M3Sj
        bWRvkgioGztODyJD4WXkYj0n+FTUFhlvcOGAXb1H6G0umW++FZ7/sUmlH3t+VlHr
        i+Jjtx/aSyDrWCDDRpodhDzoLMiJs+qrU86MnzDIso5xreAb6Sm6KIgG1Hzr4BRJ
        rCIk/VxRXuNQQtiDykG2TeisN93unFxkX4NGClC4foU8hdH2RZs7k/1COTck8Cug
        evQbhxAfYgwXJZduoTTC3GZ9Wf37TTHZa3Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m8oRLYFN_CyL for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 02:49:15 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmhbG2Jc2z1RtVm;
        Wed, 29 Mar 2023 02:49:14 -0700 (PDT)
Message-ID: <f33888fa-24ec-4432-3193-f2d644289f06@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 18:49:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] zonefs: Always invalidate last cache page on append write
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>
References: <20230329055823.1677193-1-damien.lemoal@opensource.wdc.com>
 <ZCPzbFzjFyiOVDdl@infradead.org>
 <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <46acc134-3f38-2a2d-c2aa-11d2fbee2abc@opensource.wdc.com>
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

On 3/29/23 17:27, Damien Le Moal wrote:
> On 3/29/23 17:14, Christoph Hellwig wrote:
>> On Wed, Mar 29, 2023 at 02:58:23PM +0900, Damien Le Moal wrote:
>>> +	/*
>>> +	 * If the inode block size (sector size) is smaller than the
>>> +	 * page size, we may be appending data belonging to an already
>>> +	 * cached last page of the inode. So make sure to invalidate that
>>> +	 * last cached page. This will always be a no-op for the case where
>>> +	 * the block size is equal to the page size.
>>> +	 */
>>> +	ret = invalidate_inode_pages2_range(inode->i_mapping,
>>> +					    iocb->ki_pos >> PAGE_SHIFT, -1);
>>> +	if (ret)
>>> +		return ret;
>>
>> The missing truncate here obviously is a bug and needs fixing.
>>
>> But why does this not follow the logic in __iomap_dio_rw to to return
>> -ENOTBLK for any error so that the write falls back to buffered I/O.
> 
> This is a write to sequential zones so we cannot use buffered writes. We have to
> do a direct write to ensure ordering between writes.
> 
> Note that this is the special blocking write case where we issue a zone append.
> For async regular writes, we use iomap so this bug does not exist. But then I
> now realize that __iomap_dio_rw() falling back to buffered IOs could also create
> an issue with write ordering.

Checking this, there are no issues as it is the FS caller of iomap_dio_rw() who
has to fallback to buffered IO if it wants to. But zonefs does not do that.

> 
>> Also as far as I can tell from reading the code, -1 is not a valid
>> end special case for invalidate_inode_pages2_range, so you'll actually
>> have to pass a valid end here.
> 
> I wondered about that but then saw:
> 
> int invalidate_inode_pages2(struct address_space *mapping)
> {
> 	return invalidate_inode_pages2_range(mapping, 0, -1);
> }
> EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
> 
> which tend to indicate that "-1" is fine. The end is passed to
> find_get_entries() -> find_get_entry() where it becomes a "max" pgoff_t, so
> using -1 seems fine.
> 
> 

-- 
Damien Le Moal
Western Digital Research

