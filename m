Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03156114C17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 06:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfLFFha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 00:37:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19839 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfLFFha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575610650; x=1607146650;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=KODw/vdvau1ReXajVxhWlbRTNic9Grog72dkEQg1AZc=;
  b=fB4NmSfHrswlrZSxgFeSpgKWfo+bLwf9jOIWbWbSU2np1+6fzvmzjyMj
   hVkG53VbLdl8zeBAcNpIGkNbkwTtsHxmUhoIbz/FxMXrYVYWSztSMhd0J
   bamJEhs/J5E+X9nvwjTnMD215/CDjpJo3b9vdt0ffbVLhVNa/VhC4i003
   7JtVzg8ug+BHw06xIvG6CbXKTcP4/4kIkGm8qlILuYrn2BWlPic3dXzx3
   Hh1MT551CvjfTs/2o189vjjtNBsvrAMtFwMW3qyRuFODkPP31b6RarU7d
   QHHq0kMZUb7r3U0vKxeFBfBrENsxSFl8p9iyzEFPrliu49CJintSXejEn
   Q==;
IronPort-SDR: 5WDrJ9LfEaUY4TKWyzUULz1VlT/IeM859hwam0z2Vpd7OSigAE0tvLVgIrvd90xaN/mZ/iQtre
 GlWt8b6XtgXG7acnOTZgAdQXHVGjP9TpSSf56Wo9UaGWSsuqzLMHyD3/9JDARv+i6c1ltxBZ9n
 YyCR9gZnitnQ5Tk85oEUq7FSX236LgbAidIrOzACdCuMOel5tj6KHInNMiQPl5NAyZlghNpcsz
 n9RoXExYoFU3qHdLYqKntT/eOwrpnUeQO/90QSXBPwY0stWdHJpjKXiFoFbjrLJL7FGAbjGBf3
 apc=
X-IronPort-AV: E=Sophos;i="5.69,283,1571673600"; 
   d="scan'208";a="125522053"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2019 13:37:29 +0800
IronPort-SDR: cDUQhwd+2Pf7QHy8tUP76m8O/EXQANujWtlgtLQoTTu5fvlbOvsQ9gz/sJCSJ5t4fqigudOBzu
 pz+AOMMpqtPNtyW0NSOgwaWZnrpcX81k2X/58fFBxQS8O2+NQEuQ9iz0qoSmrfuA5alUsJc8BV
 ps15G7NVKs42Fh2DLcvYRaKXsn9z1uR6jD6tFoZ1XE0iAQ+71dMciANxK07pnMdUYIXuyKidC7
 nd9bgLmtemanZkYGUQTV5J8CHbnqzmNEmOKnaJdjMFX+Tes+X6TTn7gwaL9Drh/j/B6FPb7ojc
 23DjZtNXgtECx/FpgmrzHkw9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 21:32:13 -0800
IronPort-SDR: 1nhZLn/qE+kzr1vfWdqviNheQ9k9rZuol1tmXP2TdVfNSdBJw1GMxhuw/+cxxRw2qfo+/jalD8
 GzZ3ekUh/S8bDZ1m7iw0AaHBtzobyQ3R8MS4zj6/OrveAYN4zVGx+p4Dvmpw+6ar3La4qCwPal
 7fsqQO+wai4Eb90FtJoueBL2Oq7tgY4fDuu7XB7LBGbbVR3knO6aEjoTdvuw4D8KEFwdy5xlZ5
 wtAX7md/vbqyDfcfLPsggrtjfXZsgNxDTxFE8G6s1Z/IDJXmZGEL6X5NYdpeCrXHyxRUm2Aibc
 kqU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 05 Dec 2019 21:37:27 -0800
Received: (nullmailer pid 3658036 invoked by uid 1000);
        Fri, 06 Dec 2019 05:37:26 -0000
Date:   Fri, 6 Dec 2019 14:37:26 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/28] btrfs: disallow NODATACOW in HMZONED mode
Message-ID: <20191206053726.2q5mwjekqoflraql@naota.dhcp.fujisawa.hgst.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
 <20191204081735.852438-7-naohiro.aota@wdc.com>
 <20191205153142.GU2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191205153142.GU2734@twin.jikos.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 04:31:42PM +0100, David Sterba wrote:
>On Wed, Dec 04, 2019 at 05:17:13PM +0900, Naohiro Aota wrote:
>> NODATACOW implies overwriting the file data on a device, which is
>> impossible in sequential required zones. Disable NODATACOW globally with
>> mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.
>>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  fs/btrfs/hmzoned.c | 6 ++++++
>>  fs/btrfs/ioctl.c   | 3 +++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
>> index 1c015ed050fc..e890d2ab8cd9 100644
>> --- a/fs/btrfs/hmzoned.c
>> +++ b/fs/btrfs/hmzoned.c
>> @@ -269,5 +269,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
>>  		return -EINVAL;
>>  	}
>>
>> +	if (btrfs_test_opt(info, NODATACOW)) {
>> +		btrfs_err(info,
>> +		  "cannot enable nodatacow with HMZONED mode");
>> +		return -EINVAL;
>
>That's maybe -EOPNOTSUPP, the error message explains what's wrong and we
>can leave EINVAL for the really invalid arguments. I'll need to look if
>this is consistent with the rest of error code returned from mount
>though.

I'm OK with using -EOPNOTSUPP here in btrfs.

Just for a reference, F2FS returns -EINVAL when it has "nodiscard" or
"mode=adaptive" mount options on zoned block device.
