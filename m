Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38059155241
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 07:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgBGGGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 01:06:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11919 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBGGGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581055563; x=1612591563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TceCMjfxoqrfp0V2DcMDHKp+VTOkKTloikfR28lTyO4=;
  b=MMy406sPYegEA0w6Yn+GuUQ8MatVO47wul9gxUKaPJuXeDmWZTsjevQv
   ncfoyJq1W/kRNHGQHzWS0FurxzP00VAQ11BN61mnRENTee7JwCLtsEvk+
   dSEApjfUCdPsFKGCU9mEgm/4LJtm/SGxwfNm68wzxhAk48C9TKgeLMIA1
   h9GMjkRag2nlZiX2Dw6yYmg54cSodQZaMRPYTLXYcpY/roMVG6IhHI4vK
   rlrDDo2nLVCdtgX9mdxN9lUs8QmYa0KfnmKoXrXWH2WSCsJWheOB7GZxE
   58pqaYLJnSk5UoSl6IGwYjiZfDgP/uWAzBIS5v8oE7TTIAQglodSFpNvF
   Q==;
IronPort-SDR: A8TKOwmw2b6fffePaaopfFMUuL2vDgMF1kG82sSMQxyVv2m9DHwO1cpHgK4qXtfBT21JUfIONs
 teyb/BL60rQyO/uk6SQqObi9cnrn7Rt0WFWy+POM9MGVSrV6VkSTLKZ4t8gXvcsqvpHh16ijts
 KUt8dpcd4b7uzayjYNuBQRdE155mXSwBbJ2kmB3lxShF57pk43Yet5jjosol1fjL8f0ROm3KPH
 xik+AHr+bA6AsKQpFg1GMZtEVQmPr6c7CdwKzj8aXPsbgsA6+/dzTL7dyMAadkPQmTjOhBShjG
 LhA=
X-IronPort-AV: E=Sophos;i="5.70,411,1574092800"; 
   d="scan'208";a="237308902"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 14:06:02 +0800
IronPort-SDR: efOejSZd4x1jyTH8/chwX3NF5GTzIdZvD2N9Jfyji3eR6RtLJcfIxEgbmWQzvS1wKSTvalKBB4
 mAlFElF6Kg+fS+oxEHDlD2OyabGgN36DzWk815SP7kTLbOm0ZoggS5dLI9R41ICyCzvGreI8hy
 RkbMo/cwCwM0uD1Oz8P6PtETEK4EgQd/2vFCI87fwmiuF4a3F3p0DXLJmkbCwswKBg8mOhLHon
 R2baHmJgQWxsRw3EoA1Wh4pMO0jjM6M3tRa7JJVTO+uuQPGlhAXuJQaKblUSbQkPcHWnxcFRFM
 D5SXcRhCYSgjcyt3yST6agd+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 21:59:00 -0800
IronPort-SDR: G/E8AIAeiSUOgMlQ4WMcbMffqmR8FD1uHPdGX3dif4XNE5jUnF4d1j62v3sw5/Li1uZdMSdQBh
 qec8jsyvF683G6N5mfBinnumHSPd6Y9SQg/55rzBmx7kV0WhBtAjStq81L6+1cABzP32uFgApz
 dVK5FrUA9KdCaHkWJsTrdaGT5JmH95UMeRKfZWglj0a7olMSY+akGHqY9hNTjD7VHSR9+4Pc04
 dJjmIrytrNtN8owz6p/75Sa3Tt8uO9eqKgDTfmCz8PI7BUaqgsTeu+Wsshp6X68eIbH+T4re7e
 Qx0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 06 Feb 2020 22:06:01 -0800
Received: (nullmailer pid 752349 invoked by uid 1000);
        Fri, 07 Feb 2020 06:06:00 -0000
Date:   Fri, 7 Feb 2020 15:06:00 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/20] btrfs: refactor and generalize
 chunk/dev_extent/extent allocation
Message-ID: <20200207060600.bxcot22i3tpemrn5@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <5861600.kR87CiLkK2@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5861600.kR87CiLkK2@merkaba>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:43:30PM +0100, Martin Steigerwald wrote:
>Hi Naohiro.
>
>Naohiro Aota - 06.02.20, 11:41:54 CET:
>> This series refactors chunk allocation, device_extent allocation and
>> extent allocation functions and make them generalized to be able to
>> implement other allocation policy easily.
>>
>> On top of this series, we can simplify some part of the "btrfs: zoned
>> block device support" series as adding a new type of chunk allocator
>> and extent allocator for zoned block devices. Furthermore, we will be
>> able to implement and test some other allocator in the idea page of
>> the wiki e.g. SSD caching, dedicated metadata drive, chunk allocation
>> groups, and so on.
>
>Regarding SSD caching, are you aware that there has been previous work
>with even involved handling part of it in the Virtual Filesystem Switch
>(VFS)?
>
>VFS hot-data tracking, LWN article:
>
>https://lwn.net/Articles/525651/
>
>Patchset, not sure whether it is the most recent one:
>
>[PATCH v2 00/12] VFS hot tracking
>
>https://lore.kernel.org/linux-btrfs/1368493184-5939-1-git-send-email-zwu.kernel@gmail.com/

Yes, I once saw the patchset. Not sure about the detail, though.

>So for SSD caching you may be able to re-use or pick up some of this
>work, unless it would be unsuitable to be used with this new approach.

Currently, I have no plan to implement the SSD caching feature by
myself. I think some patches of the series like this [1] can be
reworked on my series as adding an "SSD caching chunk allocator." So,
it's welcome to hear suggestions about the hook interface.

[1] https://lore.kernel.org/linux-btrfs/1371817260-8615-3-git-send-email-zwu.kernel@gmail.com/

>Thanks,
>-- 
>Martin
>
>
