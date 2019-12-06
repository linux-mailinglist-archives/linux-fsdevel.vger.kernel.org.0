Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA612114C81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 08:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfLFHGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 02:06:18 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30773 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLFHGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575615978; x=1607151978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FtPqEvBtr6eqL+4+3P1rLy6WssbTHg/1y00fYZ+q90s=;
  b=Ps22SSgN/7Qn5wNYmTYXRw9GPq5tY8VOHscbcfrLvPf66Qh10XtouhBh
   siWSV2zwHjC4xEC1zqfW1qpIgOkCR0BEPlwyjLQtgmez4S5zZHA7D8Luc
   g1vTm83zp5iImq034/DTggye9OVbEkNTFhsF7HRtnlMZLO9POsn+Vj1U3
   A6ssatXxXJWVc0nRPt74KbEHE9LlMtCiy6bDMP4bzoYFCUSp3vpC6oXEu
   puye+m9zrXw4pSVJP1td0QfdPzZlFWCkbcdtvt8Q5Meq6Y6g9ofhmBEyM
   lPznPAwnz9xqqkGgLESavQbrrXiOeOcoqi5BQ6AIU5AqT1W6QWS1Ukirk
   A==;
IronPort-SDR: guHPoiFpywQ/jU7aqlCqv9cYdKTvc23Ll34vuGHUBeRUUdsID0ChYgHVVOHSbFZ1LwwCVtPONh
 Y7bVyIuYROcon8MqEXWMOvXBBdUUrbsy9ZywdhKOr9bNrEYYHW44R3zNrtKkuP/JM6Kv3v9RXu
 Nn9T3jyYweO6h+bjpU6GUfuV/6SYoQf8W/R8NNmhay43oqVB/Zs6CM7v07tIDklCvpZ5Z4WXgX
 qoUdluYaMdYmKgqTxrmL4QT5c5UbcUI/ZqPnTmMsNVPhzUxP1Wx15eiJrLRjJINxW8Vp4ahpu2
 J5E=
X-IronPort-AV: E=Sophos;i="5.69,283,1571673600"; 
   d="scan'208";a="126367187"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2019 15:06:17 +0800
IronPort-SDR: VQUxSTNuKJpVqed1qgvAiH2NTlxUPniWJJwuTutTdh6+XxpGmUHmFlhNfQriKeopes976LMxGc
 rgsWsJR/ME3IZSE/XvO068niokiGTkxTZ5+igapCyazsb8oBdFpLejoOS3CDOD3XRKSjJFFD+k
 Ep0yZ6V/GeGJ3FhUOggUiTe+NnF8PBCMcjKVX2G9su0sRDBnNOFxOSBduvdJSrA1GJrgbUlGx3
 iZ/qDFvdOJxvRw/qHcXjrUi9ljgkq+lO1w5ZJZEEnY+GKl4b4Rr/LTW1xTZixsf5ioaHkb6hGg
 02eJS1CA1SHS8Ub54fa6M8FD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 23:01:01 -0800
IronPort-SDR: UY8hBGkPreVCFJns+uIMeEQwc4/2Pkdbld9Y1y2FIEj7h/dXq728HuB6bWr6MJugV/C4caBSYn
 3vdHo5DMI3p2hGR+bSd1L4O5woHHVCZCoCcJ6i5NiM2u5sKRs6p75F93bSc3Fe/aelixTLK84g
 pZQQJMLLggk7ACPNMfdiOPYuv33i1DU+Z+q/B3EBREDVgMvTWYo48XNOLZqnkNcst0rt0C/Yfy
 R1H5C8TJ9bXIXLiVzOyuvI9ulMiGi0JxGBOHJ7Px3OYWdp7aeHRNFACW8urduwEUk8kQyhA+Xh
 Rdo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 05 Dec 2019 23:06:16 -0800
Received: (nullmailer pid 3793491 invoked by uid 1000);
        Fri, 06 Dec 2019 07:06:14 -0000
Date:   Fri, 6 Dec 2019 16:06:14 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] libblkid: implement zone-aware probing for HMZONED btrfs
Message-ID: <20191206070614.aajb77v5oano2bzo@naota.dhcp.fujisawa.hgst.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
 <20191204083023.861495-1-naohiro.aota@wdc.com>
 <20191205145102.omyoq6nn5qnximxr@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191205145102.omyoq6nn5qnximxr@10.255.255.10>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 03:51:02PM +0100, Karel Zak wrote:
>On Wed, Dec 04, 2019 at 05:30:23PM +0900, Naohiro Aota wrote:
>>  	while(mag && mag->magic) {
>>  		unsigned char *buf;
>> -
>> -		off = (mag->kboff + (mag->sboff >> 10)) << 10;
>> +		uint64_t kboff;
>> +
>> +		if (!mag->is_zone)
>> +			kboff = mag->kboff;
>> +		else {
>> +			uint32_t zone_size_sector;
>> +			int ret;
>> +
>> +			ret = ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector);
>
>I guess this ioctl returns always the same number, right?
>
>If yes, than you don't want to call it always when libmount compares
>any magic string. It would be better call it only once from
>blkid_probe_set_device() and save zone_size_sector to struct
>blkid_probe.

Exactly. That should save much time! I'll update the code in that
way. Thanks.

>    Karel
>
>-- 
> Karel Zak  <kzak@redhat.com>
> http://karelzak.blogspot.com
>
