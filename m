Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674C513DBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 23:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiD1Vkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 17:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbiD1Vkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:40:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EDBC1C9F
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651181856; x=1682717856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ks/UYFZ4BEuJfvHdflvtNX42llFGKlgREEMC26vTdf8=;
  b=eLxiq3ZXnYFl3qZnitlhJNSbnVE7dhkzKfppUNpaVLBEddm6Bo+4jNFF
   pzhzhDXRhKTJwz5NEoPQJ9l5aIoCnrQlTQQfnnGKXxFIf+MzTT46ybQlt
   lldyEBLCLnlBqOA/3tZvxHtS+uS1PFLPmwlmaXdizMH9t3uOueWENj9im
   m316ZieI1hpPTTmbBZJ2g8/P1MS/ExzQSyhS6lJt1u8zTNoq7BX9QR3R1
   WjGgRbTfbAG1GJy/sR8I6egnXlmcuL7yY3Qa1wSyWkHOoJTlrpBWFEU+A
   gCbx4VXVJKCYqFakSaLlVglu3JO5AZUgAYUdBdzCNh+zXQzNAusJUTiIm
   A==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="311070684"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:37:23 +0800
IronPort-SDR: yiitZxBxYHR3LbOceAxu0gjUphx5kUx7qPknR0MMSseCgeKTCJnCBhwysM0VHqgf8ggqfXUXou
 t5ZzaUIS0eQqPrV5GaVs5+Iy2BEqY0lW3gg8KeMRxYW7rcFI4aTNwNpEOsGWZSCoQRrFmTs4Jh
 KDhr5fJ4T7lTS2TcEV1tyf+z/9+gNPVi/x9aLDflsnAW8hYZnutdcAXVJziSyw4Uw5+wbPLBKW
 XQIPE9LPHRiiEqhiH+0lbIrQ+XlssgAuNjE98wB9FgBj1OEHPRD880cfsMgw3iL+Xv5bKQpNcB
 lJWFVzMsTIQFKWoUimQqxGmw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:07:31 -0700
IronPort-SDR: M6LwR4x6hjJ57thQcfBwaaDctZyXIhui6jMp4wkC4FJMa/n5JSuZCopnq44KMRonGPrJ4LTUzH
 0cUPp7x4QPXN7o4gADjMOQPIhHVyapBdicaq6tQtHaw1/67mTpiM2LdkIv+GfOsxinwvPb0DpM
 ilCxTXIqDPTsavH+rNRCciPPh7pbXe3/dclDP0XxH4Y27KrtPQEopSj1wQRcliLxSavBJqrpKd
 YpVWHI84Yt7pI8sBFhkUUOGZMP1CcUi1x9NPXFSr6rbT8pxhwzyMSiZYZ/TxvfGXggVzKqt44u
 6YM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:37:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq88x5chsz1SVny
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 14:37:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651181841; x=1653773842; bh=ks/UYFZ4BEuJfvHdflvtNX42llFGKlgREEM
        C26vTdf8=; b=Pia8U2+MTp2QRDkEB4f2LrGB1ac2qZfAErgsCBWCFKjMxrXVn/Y
        bwkaAOoOvDD9yplFQBQeoOJVsSLVROSZs/aY7852UH4Hkft/gJ8l5Vevs96ehApm
        H01Pi7zw03XrBAhpZA+8aNjI4XPTSKE/B53mqI7jTUhf+kO3QzvvSihGG5g4JCrn
        J7FkLjqy1G9aN6QLiRcqwX03ov+vXozvTOfikx/Qr8m+XOlL3cwYuWTPPQFKLuuT
        dLexhqGOTQGF+oDQFcdirmTE+zKbH/a93K/4NbxqEWezpvNJTnGI1pJhScoN+3RX
        JtdhbfwQOwWUwz6SrnP4PdT/zkoQdrOf4pw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ROCCKI_VL5Yv for <linux-fsdevel@vger.kernel.org>;
        Thu, 28 Apr 2022 14:37:21 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq88w02gHz1Rvlc;
        Thu, 28 Apr 2022 14:37:19 -0700 (PDT)
Message-ID: <a6d1c61a-14f2-36dc-5952-4d6897720c7a@opensource.wdc.com>
Date:   Fri, 29 Apr 2022 06:37:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
 <20220428074926.GG9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220428074926.GG9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/22 16:49, Nitesh Shetty wrote:
> On Thu, Apr 28, 2022 at 07:05:32AM +0900, Damien Le Moal wrote:
>> On 4/27/22 21:49, Nitesh Shetty wrote:
>>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>>> The patch series covers the points discussed in November 2021 virtu=
al call
>>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>>> We have covered the Initial agreed requirements in this patchset.
>>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>>> implementation.
>>>>>
>>>>> Overall series supports =E2=80=93
>>>>>
>>>>> 1. Driver
>>>>> - NVMe Copy command (single NS), including support in nvme-target (=
for
>>>>>     block and file backend)
>>>>
>>>> It would also be nice to have copy offload emulation in null_blk for=
 testing.
>>>>
>>>
>>> We can plan this in next phase of copy support, once this series sett=
les down.
>>
>> So how can people test your series ? Not a lot of drives out there wit=
h
>> copy support.
>>
>=20
> Yeah not many drives at present, Qemu can be used to test NVMe copy.

Upstream QEMU ? What is the command line options ? An example would be
nice. But I still think null_blk support would be easiest.


--=20
Damien Le Moal
Western Digital Research
