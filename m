Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E32113BB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 07:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfLEG3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 01:29:23 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15064 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfLEG3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575527362; x=1607063362;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=r1ER+U8UNzaMS1CTWDUMQTjuAriAcAs1m9uD1dfeQy0=;
  b=huNyjBbRkkpRlBBVFdpF0ivLEWGVvuW+CCW6Z2z4vtSqaTA4tk8qG6VN
   khCL9ie7lPuBccIEgiuktkM9rM9srrmeUF43Q6X+sCu+JbAplI2ek/0Cw
   hKMYRVWLoA4vSG0/qUwBBd4vx/o0hAGOOWjIlArLGZzMi8iPD1B+zak/Y
   5XM5YAGFmXNyvcvaCUtL6wbgdC9kPSg1jVe8cNnx05CSXW93dg3CXyCWo
   rJRRt5a6sjKDIZnJISKZLw/3IwtHXlK6r1Gx7zce0NW4xGIAbCkCeEiJP
   6P1q7YVnRCKAmeWSJqqazETeUd1sdmEh8UDt3gj7bqdPeqqVS5efqFfxo
   Q==;
IronPort-SDR: 6um3IgEJONOb5GGsOV5fPEKRx86H4Tn4aj2XrStftjEgsSsdSgZft3hn5EvN+JzTRGaQhJTJ8U
 vE+ZqWbdY5lfFSQR/zWtqHNfTiFv1i128pqyygjNWIoW160eKaVY16OSJPo3tLoZecavTlp04H
 zCIB2o761AY/H5ac740Oty+u6Z69KKqocsWpduGlmuLdMNII4PRKD5pWqMvOnmiD0fgA43II45
 P/5U6wdjhOIXUwtxPLs0K42Wk+Zs4Lk+NeK3CWjJ8kJC1mrN/CDqCVdrCTInq6/n28UIk4qAk7
 WnQ=
X-IronPort-AV: E=Sophos;i="5.69,280,1571673600"; 
   d="scan'208";a="124653449"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2019 14:29:22 +0800
IronPort-SDR: eI/pPxJEbJAMyf2iDds8l05HKQ2DEgTG0m0dVBwE6+wySk0aIXDOOxN8w9mUamMoiZRmlvN5H0
 TO0hG+5jomEJ9oas4IMzC4sVUdRXDAzF8RQnoRXNpPYUo4tKkGsvwYt5B1LVnBcgQRY94rMSZG
 qgkCbbJdOG4M0iiU+9EokkP4dYlgpzB1xliWJcYVvwrFVOfjgeYqBbpSyzWJLnhFiPZXOUwp20
 ArD6SZMuZqhM88518IzgQGca+UxPscS6nkdCjr22pMZMzXu/Ka2prvWXNEVJC0KVcbNAyxXaEI
 81QxK9+zyxfZ/2PRoMVx+hCM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 22:24:08 -0800
IronPort-SDR: pYmcLFfuaWKWMAFUDkfzRfpDMtgqGUMqCZDJI1w+JLY7sxmCh1I9CufvZrIXaP6vg/9vsHEcCd
 i76i2s3FE05F4mOym65jgcq8Kqu5cOcfJdkupQrLgovCbUr23pNFWu4Ie3h55CQZC6hWUcWXgZ
 i9L3xRg2c7btCDkLzefmhnuG6HlpwSSKFk5HcAxHt1n+QZZSTt2B2UqwCqa+/mhiVKXwtlpu8F
 hJA9Upcv6p8T+9vSR7GMWmbWb2VH6HAG0y6HYWXxlcpV4sC5QmHYdE39x/RPhRPkqyhW4lnpas
 /6Y=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 04 Dec 2019 22:29:21 -0800
Received: (nullmailer pid 2335473 invoked by uid 1000);
        Thu, 05 Dec 2019 06:29:19 -0000
Date:   Thu, 5 Dec 2019 15:29:19 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/28] btrfs: Get zone information of zoned block
 devices
Message-ID: <20191205062919.mgpqe6gnbpahwaic@naota.dhcp.fujisawa.hgst.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-3-naohiro.aota@wdc.com>
 <20191204153732.GA2083@Johanness-MacBook-Pro.local>
 <20191204172234.GI2734@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191204172234.GI2734@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:22:34PM +0100, David Sterba wrote:
>On Wed, Dec 04, 2019 at 04:37:32PM +0100, Johannes Thumshirn wrote:
>> On Wed, Dec 04, 2019 at 05:17:09PM +0900, Naohiro Aota wrote:
>> [..]
>>
>> > +#define LEN (sizeof(device->fs_info->sb->s_id) + sizeof("(device )") - 1)
>> > +	char devstr[LEN];
>> > +	const int len = LEN;
>> > +#undef LEN
>>
>> Why not:
>> 	const int len = sizeof(device->fs_info->sb->s_id)
>> 					+ sizeof("(device )") - 1;
>> 	char devstr[len];
>
>len is used only once for snprintf to devstr, so there it can be
>replaced by sizeof(devstr) and the sizeof()+sizeof() can be used for
>devstr declaration.
>

That's better. I'll fix in that way.

>The size of devstr seems to be one byte shorter than needed:
>
>> > +		snprintf(devstr, len, " (device %s)",
>> > +			 device->fs_info->sb->s_id);
>
>There's a leading " " at the begining that I don't see accounted for.

Oops, I'll fix. Thanks.
