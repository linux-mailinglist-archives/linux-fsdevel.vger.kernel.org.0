Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C3115524C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 07:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgBGGLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 01:11:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31937 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBGGLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581055884; x=1612591884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XK5Dr3azdLybQMxGVTr6vOXvQ4grvTnFSL3+eeJXcGE=;
  b=NhrOhb+Ld+eAiFzKveTgoeyYHsfU9xVIry1NW7PzmnMG7uSxUjsj5HCu
   aEoRFaeNvPrt0ZwH+dxZOfXBJ9jK5QDBT4OkXuEQINIoriI93sResxzv3
   TH3J6Vszzp1R/g6n/0VbRYyZg6la5uT5bOYK2/oSyhpZFLrqOMiv1H92w
   8VbuaIgGxSTxN1NllX/YbGpXXOuzVVQLSMswg1KHDRbS1XS1lcJ3804bI
   nMnxI/O5w3U2j6x/cMkChnpqGN5URc47TtT8piEi4QCeFpWx9B4Q18now
   XysgDrKOib8eIdv1t5ofQZCSytfrSrDH+WxBN1w0wxW3ZAFegNX7q+Sl5
   w==;
IronPort-SDR: N4TXK5f28EAbWnSnlDZ2PMwmIbplAVKSYfYF+J+j9GNAhDSTdQAEJCKYoyjzP4x3cDaKG+zjEa
 Lap3ZN+ejQE4ZBrkNr1ZcM9TMrCdvOyhDgd5+KLSyXnd7+rCtbPkwKz98yW/gIKJS1VSUywYgc
 +0T5ul/MBKpYs/cLrd+jVxV3haovhTllo2sS3RdQ3pHjviqyzTONwexT/E3KoXN12+oh3o1Mzk
 6JvVdhPNpzL9mIvtXPVyA1YyfkW9HfISwWvyPwVQWGOqOcD3ByMmo2MkZ7sf/tkoxrAVlhDw0K
 IT8=
X-IronPort-AV: E=Sophos;i="5.70,411,1574092800"; 
   d="scan'208";a="133680910"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 14:11:23 +0800
IronPort-SDR: R7wazCqumdQV2IFS7Vx1k32OkZwc7/D+2HtoM3VK3TJpqrRiBy50f5eb3uH/1JSwm8FY2sxb81
 0fxzCHmo4231QSQ5HUfBI+3EuwwodQENPCuRXGEiIuMSHYomH8VgTVFyA0niVcKlLMMsRcw2R+
 l5urw0pwMsAoq9Wxfdc6d4JvN4kgNogB/tec0XfPK0MZPISNTi7WkLPPCXoBOUPa4qn9BryPH2
 2fCBngtybyMQO/vt0q1cAwVXCwHNiPhtMm4n3ICIhx2o4LV5TonZA4n1s8B0019Gb4ZDepRU4V
 MddCfhjHOmR97ZIg0N5YTlJs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 22:04:19 -0800
IronPort-SDR: SywZMEInlaJnihKWKXi2nlJZ/rYf5hR7wC1d6p667wPgR2F7E0u6MzaJrYt0ZL1m/uOqPPMVwb
 PPQv2WoFtz1cO1kTjqzqIZBlybupr1OXMMZvDTEH6226NOh2Xn97FQImVix8hvvfdTKG5Ab4nV
 d0txHIT8aUZqP5VO7BATV4xJzE5GsTIhZTqqT54N9m16nTqlOtfpQaglvkyOhW1oRhpSLCe9XZ
 5Fx6i3c+oN+fDyJwtx8wB78R/d0vYDAirwro5nklGHqQT26NsLhnm5dO4qo3RY8ohBRzEIoRuq
 490=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 06 Feb 2020 22:11:19 -0800
Received: (nullmailer pid 756200 invoked by uid 1000);
        Fri, 07 Feb 2020 06:11:19 -0000
Date:   Fri, 7 Feb 2020 15:11:19 +0900
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/20] btrfs: introduce chunk allocation policy
Message-ID: <20200207061119.bmvqcq7sv4yrktle@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-3-naohiro.aota@wdc.com>
 <SN4PR0401MB3598D9897CF42A343A03D4739B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598D9897CF42A343A03D4739B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:30:06AM +0000, Johannes Thumshirn wrote:
>On 06/02/2020 11:44, Naohiro Aota wrote:
>> This commit introduces chuk allocation policy for btrfs.
>
>Maybe "Introduce a per-device chink allocation policy for btrfs."

What do you mean with "per-device"? Might be misunderstanding? One
chunk allocation policy is set to one btrfs file system. There is no
per-device policy for now.

# yep, I found my typo and fixed it: "chuk" -> "chunk"

>Code wise,
>Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
