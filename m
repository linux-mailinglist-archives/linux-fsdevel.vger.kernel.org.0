Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21A2A2400
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 06:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKBFPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 00:15:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13708 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBFPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 00:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604294111; x=1635830111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MDVEoEQcSym59szMBPLR8cqI2gyv0RcHJHQXl7c/2P0=;
  b=EawkG0b+5w9hm0kmsCiqc+43an2EMFculdd1OfsMliLZAtq4dGkSpedW
   D3v3pWaJqrjKhXdiE/VNQtdrvqN7A1DnsbY7x6W5aMuk0Or2oARBHJNst
   9x3hXvn2Ct3BQnSwsaI9dKcI20ccFnD3cMqOgBJRfex0HsUMY+f7vqYZO
   SYIx0V1H/ZhQenmstVTDvzMXpDVAPDnU1BEoQ/EjmCDz50hkX7g/yoRWF
   pQNYMyUqhiSSn+8TTu57cLWCKpySjnTpOKBchTsRzfdcm5xqMwt6aaL8i
   tQPsloJMQNCcoWveGU4/S9qVkIwB+Eip1LLyHdtiR8A7D9qcIyH3ncwH6
   w==;
IronPort-SDR: QJyZiyIU6t0BiUG7Ab4eIl9USQkm/hhwijcvdKfR1KoaCE3RH5fV18PC1Ffm2OSRfmPMfYRHsz
 Ab2h79mqlFhQroahjIUUMEsT5P92tnmWcQSJAk6mxIKJQF+qiUsx3bIA+DXtjkuYnSI+Dk5kBG
 jJZhdG+zzACKtv+J9G1Yly6UWU2FFYGqfivnyrhv8lwI/tqIlEI3Xjmp7c0VN0ePdhzCZWSNBX
 BAmd91dG55QtUGkgv8iUR8Jz2cCXjFTQq/A5jysgdijzzdlO0WACNeWbHoy/6fpgtD+1mtaRj5
 Voc=
X-IronPort-AV: E=Sophos;i="5.77,444,1596470400"; 
   d="scan'208";a="151424675"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 13:15:10 +0800
IronPort-SDR: 3SUhKU3nuPA/eb4gGdyGq/9czcVFz11AP70SLD5t8MLHezp293IC3C5K2ALdFlJTYvpS05Iwbl
 XBftgAfi02IIpkgVAzVPk1UkVIciEkmeyd7mesB3NDvG0UOYqKZ5jYq6i5UZjGCxMYBXKzZ7q9
 n9AOG0Y24mggjPhdMqq4CG8R9eW3vn0/gVb16q6CUlnMSPefjRR1btQeRF48eCo55JgtJQq+/7
 EUDn34KYw0Kjx04apVeL7GsGkGtoFITZSsaBesNKBf1sCfm6VSVI4m45F2lFYnOVE9h7FqUA1o
 cjAA6WlAFoJIn1T8s4XogPRv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 21:01:21 -0800
IronPort-SDR: dA5wzmMNhUZ8dxBZvccqX+Xatd+UW5uMtZe6KOSQl6m5Ccogfxdu64lM9gYf6veZ29AdKDzNvv
 3Ld3rPSnnOgeYUjtY4D9M+QTl8JV/5k0HqvDWQvESCN1gFm+9U571pw8l0QqVwIMbcaAxoaRYf
 vOB8gXvrJ+lPlTjC+O2WSjZd4vh7EQqu5lwvwkTyYYTEP5CGmiJm3rlrKHHnOZ08CV6TGFkuiU
 Dij0rI9a7ICg5uCFiKAbJwDoOE48Yj5RTUwuxRAPfSr2t9CorUgm3YFQUtFaD1yenyfrn5zPDU
 2Kw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 01 Nov 2020 21:15:10 -0800
Received: (nullmailer pid 3275271 invoked by uid 1000);
        Mon, 02 Nov 2020 05:15:09 -0000
Date:   Mon, 2 Nov 2020 14:15:09 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v9 01/41] block: add bio_add_zone_append_page
Message-ID: <20201102051509.qmcgbyvxzeqcp6jq@naota.dhcp.fujisawa.hgst.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <a7ff7661-0a1d-a528-9b92-7b58b7c11e6b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a7ff7661-0a1d-a528-9b92-7b58b7c11e6b@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 09:40:08PM -0600, Jens Axboe wrote:
>On 10/30/20 7:51 AM, Naohiro Aota wrote:
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
>> is intended to be used by file systems that directly add pages to a bio
>> instead of using bio_iov_iter_get_pages().
>
>Not sure what this is for, since I'm only on one patch in the series...

I'm sorry for the missing context. This patch is for this series.

https://lore.kernel.org/linux-btrfs/cover.1604065156.git.naohiro.aota@wdc.com/T/

This patch uses bio_add_zone_append_page in place of bio_add_page for zoned
device.

https://lore.kernel.org/linux-btrfs/cover.1604065156.git.naohiro.aota@wdc.com/T/#m88184d5dd11ac30c0878582898cd9d6f7cbc21fc

>
>> +/**
>> + * bio_add_zone_append_page - attempt to add page to zone-append bio
>> + * @bio: destination bio
>> + * @page: page to add
>> + * @len: vec entry length
>> + * @offset: vec entry offset
>> + *
>> + * Attempt to add a page to the bio_vec maplist of a bio that will be submitted
>> + * for a zone-append request. This can fail for a number of reasons, such as the
>> + * bio being full or the target block device is not a zoned block device or
>> + * other limitations of the target block device. The target block device must
>> + * allow bio's up to PAGE_SIZE, so it is always possible to add a single page
>> + * to an empty bio.
>> + */
>
>This should include a
>
>Return value:
>
>section, explaining how it returns number of bytes added (and why 0 is thus
>a failure case).
>
>> +int bio_add_zone_append_page(struct bio *bio, struct page *page,
>> +			     unsigned int len, unsigned int offset)
>
>Should this return unsigned int? If not, how would it work if someone
>asked for INT_MAX + 4k.
>
>-- 
>Jens Axboe
>
