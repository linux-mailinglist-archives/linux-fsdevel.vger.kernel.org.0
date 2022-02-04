Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EC34A9402
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 07:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbiBDG2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 01:28:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8271 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBDG2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643956120; x=1675492120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XY7HM1Ns7hm2Ldhsemh6j5ncCcWBc54JkxLeU7W/o3w=;
  b=Zujenl/ZA+JkZoUJtRX9sgEaVbcXUyI0EAEDHbDp74VMnAgow9RJPQv5
   CLKRyGY13m8XfMnvx4GPxuKL2/HdGyGNjj3RCA4Si51iE6d75zn6Tl7AE
   gmSM6AB4tb8y2E/2X5wCLoK3DCCtf3YeFfr0D9Ui+RNmtaipKa/jGJTaC
   qk2oIvnQK4oJttMU9KirQNHBMyUahX3gMUHdJEYrtUYypIZAQWyhQetln
   /fV5cvTqoOgS2jd7Rl9RqLSe4DBj2fkzmmTPILTbbh/rlzkALGoXTGlkp
   l92EL9cH3MzZh4ZWkKsAvu7rIbXfWVkTDlSfDT47ykHhSV5z1PMHfphof
   g==;
X-IronPort-AV: E=Sophos;i="5.88,341,1635177600"; 
   d="scan'208";a="196957608"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 14:28:40 +0800
IronPort-SDR: RA0bc6XXOJbIZaPWU8sFg52I2KjWVCmJG1Z2xJD6jADtF9yskrI6tefYLju3niT4cpALtyh4vR
 QqwYGa6L1bJqIk2t/ymndANZy8R8e08PEV7O5NW8ZLjRXw5vN/8YDzQoOgG9+mg7/kkkxl8oc9
 sFk5oC/ajwRSsJNiriK2+UHGLmnSqLLW/DFlMKcdu7I2MVD697L73Kozakg9flLTKOHqTtrP92
 LBfXF1eRMk7lipScAd8MWk3nKwEMcxAow1S7Bg6rHG5u4lyKraiooj6Kf02PmzA4kZF5REX/LT
 mL2LCjq0H4wMhkdztFv/pPxM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 22:01:47 -0800
IronPort-SDR: jh3hfilCH1CE4XLapr8wKEXCq5g9ShUGa5TcJo5PFnIDT7qWesSSBhpVZNPUuQdckU1iTtTgo4
 v5YUIkvHpA5KW/SLSdVyLk1pNL7o2Jti/NJTG60cBMOOMtC/Y/2ZXz57hypkjuAhii9NUmD0/1
 dpy4VHdvFrkGJ8Ul7rJAQBG083/wZ3pbvuQ933t+2Jnna1XtHoVMEcdcOqtdfT2iSMGa+Cpzrj
 ymEPQqcDkM4qPrZ5LNN1aKR97pHqSfRuG9HuSVIYWmywiPZuR7luLQ8l6tlpEtzmfMvV0vjm1i
 sbI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 22:28:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jqlwm64LNz1VSkW
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 22:28:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643956119; x=1646548120; bh=XY7HM1Ns7hm2Ldhsemh6j5ncCcWBc54JkxL
        eU7W/o3w=; b=Vy1JQI4M/p1RM6pYjkGTdHayEVDerzZzeQKwGTfze/XnWDZgKtC
        452KAtRCJmmt2/PoJYUSFE5uhvagAB3Aq1Fktw/41WmPj8t5pXf1u0eCtiVdkYqj
        101uSyKbmZmftoezDdZsx8NMUv2/vmFsInUBB/0WSQbmeVoYYQ5A4gIGMf0IckqC
        4kAcyV9l8+HvrKY/u5XCSrb2iOQhmd++vpkqueu5mnX/ad80yJuRsm3HZ3dA9vXV
        aH3mjv/PXZ2R3eiDFD/wY6bfvhEKTK1baWpKRVPShwdOOm725/z3JLVgHG4+2+Qw
        VDs6oFM1RR6Yb3d/5JyVazRxgVSzUUtx8QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T04Akcq0SIpA for <linux-fsdevel@vger.kernel.org>;
        Thu,  3 Feb 2022 22:28:39 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jqlwf4v8pz1Rwrw;
        Thu,  3 Feb 2022 22:28:34 -0800 (PST)
Message-ID: <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
Date:   Fri, 4 Feb 2022 15:28:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/22 12:12, Chaitanya Kulkarni wrote:
> 
>>>> One can instantiate scsi devices with qemu by using fake scsi devices,
>>>> but one can also just use scsi_debug to do the same. I see both efforts
>>>> as desirable, so long as someone mantains this.
>>>>
> 
> Why do you think both efforts are desirable ?

When testing code using the functionality, it is far easier to get said
functionality doing a simple "modprobe" rather than having to setup a
VM. C.f. running blktests or fstests.

So personally, I also think it would be great to have a kernel-based
emulation of copy offload. And that should be very easy to implement
with the fabric code. Then loopback onto a nullblk device and you get a
quick and easy to setup copy-offload device that can even be of the ZNS
variant if you want since nullblk supports zones.

> 
> NVMe ZNS QEMU implementation proved to be perfect and works just
> fine for testing, copy offload is not an exception.
> 
>>>> For instance, blktests uses scsi_debug for simplicity.
>>>>
>>>> In the end you decide what you want to use.
>>>
>>> Can we use the nvme-loop target instead?
>>
>> I am advocating for this approach as well. It presentas a virtual nvme
>> controller already.
>>
> 
> It does that assuming underlying block device such as null_blk or
> QEMU implementation supports required features not to bloat the the
> NVMeOF target.
> 
> -ck
> 
> 


-- 
Damien Le Moal
Western Digital Research
