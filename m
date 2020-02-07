Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAFB155267
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 07:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgBGGWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 01:22:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15440 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGGWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581056565; x=1612592565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J0GPMbDdHVJhTCcVTtgSsLWjRWSYRFjDt3+8Ib0Xk0c=;
  b=ZcRIXlW6DfvC2NCKXp4V7rrtJ3vp3iUoDuoMA+04DwmJKQNdYyyz8x5h
   MPSFLqWdN1pbOs8tjVNQL1gVZPWGVqgtqVX/gWwY0/ofSUO+ClXaVtzn+
   Vi5+vLq7Ev4gmILLVa1aRzXRvrjCoGMTbO1YLqi0hwcsxWjJkaI+61zOH
   tSgGDZVowLEIMfFbPjeXcok3DKgAmJN6bcCGvvBIV6DPOupPW/c6hjtsb
   OjVYsVGompZKsMcbRLcmPhZjPwsLbsYCSC2yixan0pA6lkLWBurfSMtnr
   PJPaAG3uVGIO7mlX3lekynHb1fewDzRd4xnqZJFUds3cCgZpLyytLqTgH
   g==;
IronPort-SDR: XpCMt/qvZFuz0zHKyKg6josU87ZswGjeBcUXY6Ei4iJRvK9ZwlCTeXhfacCnVf9zL/M3bC86c9
 laPIJNtrCvzTB1NbiCWCF6NpTmnP4JDtJpkTJW9RcKxwShDC7A3Lyyx5CfJKc8carwK2GSWiuH
 qkWYXeSEkoA4WuwP/btwFoSCGYYiIWZthAFcPwPtaACMbNy1yUgmzz+i0tIlPyJ6Ls3uU7JKFD
 eAD+YJnE41rQGsiCFNrfBMtbju+7KRV7bUeW2uOBKkjAPZEjCp7tOVirurniCybJraW9taZxx/
 h74=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="130788455"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 14:22:44 +0800
IronPort-SDR: qDviYGOQjOK7RJlCpbfcUyYFEybcFeSwY0il0B6tZ6b2qcx9y9HZQjG18nYptPmAKG9NiAal7E
 WP2Z5JFcArS+hh1RrYc4lFaZCOZJu7sdQBm+KTYVWvLUIppStCAzQPvCNZ72wXZtRhAGE4clUY
 7M2bw4tFt4Cy6cpAAGXTGuGdc8rCKUE5fUMw1XJUNEuiwWJnerdWB4bsVBPN747AHywO7DeRSE
 AituyQVSfvcvlC3lR1niw49XKveuGAEoaAJEFI25ZMj2xe8a2OVSIPmCGWRcq2VwqZVhQdffdJ
 o/90gJvwaxtkS0RpXAiSLp6v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 22:15:41 -0800
IronPort-SDR: TM8rlh9Eg0VU12xHnt0W6jaUJS3HYYp3oZlW/1mZBxi+9O++rHeZqtjeWXNs/VcLwzXId+r6GD
 6cN+GGNg+35V9mbsfBK0jCD9IOqT38+F9loPFCPG1sLbQzo+XQBIosT+x8W2ZhJE0jjacUWU5r
 jfHEhhBiTEz0VzXHxicoytjzfHV7L53Rrqv4qyjP4UXqkICe7RYv4gS5SPQUZVDsFjWhghxOcm
 BwOojZp+qUBHOoeoDdGbSfdfqAI9LJD5xRd6w9vgWdeCPGmT82rqr1G58PrVqT9bvIEc7KsCVH
 i9Q=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 06 Feb 2020 22:22:41 -0800
Received: (nullmailer pid 773781 invoked by uid 1000);
        Fri, 07 Feb 2020 06:22:41 -0000
Date:   Fri, 7 Feb 2020 15:22:41 +0900
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
Subject: Re: [PATCH 03/20] btrfs: refactor find_free_dev_extent_start()
Message-ID: <20200207062241.fnmptspzmf5cv6e2@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-4-naohiro.aota@wdc.com>
 <SN4PR0401MB3598B575B00C5519FD9937419B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598B575B00C5519FD9937419B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:02:12PM +0000, Johannes Thumshirn wrote:
>On 06/02/2020 11:44, Naohiro Aota wrote:
>> +/*
>
>Nit: /**

Fixed.

>> + * dev_extent_hole_check - check if specified hole is suitable for allocation
>> + * @device:	the device which we have the hole
>> + * @hole_start: starting position of the hole
>> + * @hole_size:	the size of the hole
>> + * @num_bytes:	the size of the free space that we need
>> + *
>> + * This function may modify @hole_start and @hole_end to reflect the
>> + * suitable position for allocation. Returns 1 if hole position is
>> + * updated, 0 otherwise.
>> + */
>> +static int dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>> +				 u64 *hole_size, u64 num_bytes)
>> +{
>> +	int ret = 0;
>> +	u64 hole_end = *hole_start + *hole_size;
>> +
>
>Couldn't this be bool?

Good point. I changed it to bool and also renamed "ret" to "changed"
to make it clear.

Thanks,

>Thanks,
>	Johannes
>
