Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0D15545D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBGJRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:17:30 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19613 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGJR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581067049; x=1612603049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jhxdo3uW7mtB3vCW3/73UxGcpoerT0l0GpF+YPoY+uQ=;
  b=NsmFPvp+kTR/THC8g7cN5RpWJh90BXTXwujrAnN1nFnRBB6CUzbV8RAU
   J5oOi4OafoZu/cnckt01qZ7E0wJ5kbuin5wwPOsIZjdS+BNzAmC92GMUa
   zcL1FM5lwQe9e69DoaagvRjGAEd5GEXj6//cqA9AeDnFO6HSeBjCly62r
   L1nBi9HZ9CzxKI3xF3Sbq5iHwmSXx0QwPAfYDtORS9Sab2iKg/3o4u1Np
   Oeex3USuAhRl8zlohjy9WRXAqTmlz4dJl856ugNEr59XHxhrkX3Djkho7
   hFV2BVXtQiOd58aKyEPWH43i5Pl5GFUxp2xKeXVGUNoX1YFAqPT6heMIU
   w==;
IronPort-SDR: MXn5cDORbInqPEqE+K2mQN9KdDaJJuLxWWabPOQri5pKFFEaVdy/EU/v6K8RPkDQA0U77d3WA+
 LM1JdnO1isZVkMcoPBGH0vQnIENuNigiV5iKg5/23zeHrmusGfno+p0vElbZjUBBFROEKK4RBP
 ybBuV25bf22IlW46Sy19lNHW/hDhw4hJys0U3V79Ttb++kv4G5MR4SEBoCl+WlPuY08cFTuRO3
 vDN/OT+FuFju00tmSK+ClKfhbo2B1bMJJXCZy7ayhZjB/p5z/agVvjxSuWH8Aose/IYhPREnqD
 Dqw=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="237323647"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 17:17:29 +0800
IronPort-SDR: moP8dQN2xN9z87RwDxG5hQfH+GHh8fpqDrzZdhLxBeiqUXh5+ocBYGvgpmr0q7VVYXGUb1sxPA
 0EzhKI5F3HdZ4mXH7Fncvt8FwVQhSuxYkMTQZeY7GoqGRJY2ddYUIWIJ5ShAScIiH/mxvq5dVt
 YogL1L5gfQVXhBrvO1xUQfvv3AJtMHZTRah1ust922NtJ619XyEIqMnnL82YWVrFchZPbUyHri
 pTb5wds8pSyUZA9EiUB4GTCxD0eggZi3BcSHQYorWmK1Fyy9Hd4InZdtqgR7fz0D3sGh3gWT/y
 j29V8OOqo60Olnk5jVPMc1T0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 01:10:26 -0800
IronPort-SDR: XVys83ZxIdAj0SEkfy30bFQ09f0youVQ4E4g8xFMmFyBTPXYbiNlpSqeFa/up9ZGJy7SBLkE2k
 K4PNwbLK2VqsWJ9/aZ5gxP4x1sUX/HB2IAHvOuhiWpwESz8DdVY62H7feNpYKMvDSTHYXleAj2
 icccgC12TE1G4YoJfZwn5yUT+2wzJtQ+ag79tnXls6lp3I4hUQhRJv4tYZGUXU88LCvIAKyql5
 DcfFpOw5BzJbo8Nzh7E9v9Eave4gO+lMTuiJW9dr+rNuvcXgJHAXiFjISJIrcDJlzVqDVxxrhE
 9H8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 07 Feb 2020 01:17:27 -0800
Received: (nullmailer pid 943054 invoked by uid 1000);
        Fri, 07 Feb 2020 09:17:27 -0000
Date:   Fri, 7 Feb 2020 18:17:27 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/20] btrfs: factor out create_chunk()
Message-ID: <20200207091727.btop25g55wlls5z3@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-9-naohiro.aota@wdc.com>
 <ce201812-22c2-9799-f453-780a5b16e49b@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ce201812-22c2-9799-f453-780a5b16e49b@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:49:58AM -0500, Josef Bacik wrote:
>On 2/6/20 5:42 AM, Naohiro Aota wrote:
>>Factor out create_chunk() from __btrfs_alloc_chunk(). This function finally
>>creates a chunk. There is no functional changes.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
><snip>
>>+
>>+	ctl.start = start;
>>+	ctl.type = type;
>>+	set_parameters(fs_devices, &ctl);
>>+
>>+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
>>+			       GFP_NOFS);
>>+	if (!devices_info)
>>+		return -ENOMEM;
>>+
>>+	ret = gather_device_info(fs_devices, &ctl, devices_info);
>>+	if (ret < 0)
>>+		goto error;
>>+
>>+	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
>>+	if (ret < 0)
>>+		goto error;
>>+
>>+	ret = create_chunk(trans, &ctl, devices_info);
>>+	if (ret < 0)
>>+		goto error;
>>+
>
>This can just be
>
>out:
>	kfree(devcies_info);
>	return ret;
>
>and all the above people can just do goto out on error and we can drop 
>the error: part below.  Thanks,
>
>Josef

Great. I followed that style.
