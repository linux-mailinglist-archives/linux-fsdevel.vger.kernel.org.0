Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A9A1240FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 09:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfLRIDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 03:03:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49770 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfLRIDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576656226; x=1608192226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjRUzMyK9kbVWLxqBNpbaMEchEMdkitMEToTToKOkT4=;
  b=qebgd5/lDWlqawHHkZBi33ctM4cLIgufdbHum9nDKkyK7aXNJtD5sciY
   afi9gQyTgfwPW81GLcQ0xLN29d2RXuR1qqmOfkFzJNHLySKiQfdEFe39o
   wvitgrVzvOFMUgDB4x3K83TvupfsNFVbPbkdneG4xUWC/UMNisMoslPNE
   7zBmrkRS6rj4VIEFpgE9qE0vfkFwFjjU/8cMSHnI5lLPj2ztHsYgWFR7B
   Dzm1SFE2RyFaUoiEgEwqTvUhLLcEtCKNvIvZR/wJphUqFNWDtNBA76C5s
   uvsE7RU/ukCRgl/8+otD30ZaYRH1maYzJjn7i9W1+dBnRMpjxZRn3HiC2
   g==;
IronPort-SDR: 9Ya1e4rkVJhA3d27G27V/6clStJzNoM3Deai92Lb/sFRwDteDXfQa/Rx8Z3HVk41+9r8bA7AqH
 7GKWG+KLYZuhQdW00TRKae20gUiTiMenM8yYk307gSTA7sg7DxOuzHxR+kZRVQp009/Wk/aHY3
 J5AjiZmIqXOxk4WbhgZu9d47/tfmFPRG8ykj2rtfTEPsfDHHM8/wmuQ49kXEgItDao1G1T5GW6
 qc4ktwikaYqgZCTxOMeWMSIeJKlyD5avm3S8ErWG1u5AzCHfXjfWWc7uLwUAh7N3SKmMDynIEN
 lEM=
X-IronPort-AV: E=Sophos;i="5.69,328,1571673600"; 
   d="scan'208";a="126390773"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 16:03:40 +0800
IronPort-SDR: vn5BswXQ0wiL8Fz2hFjEGex7mH36KTl4ITtOtYaO4gMd8B8qOQew2S3rAIMZpSLGHLWPyA2aPw
 Qzu1V81DJ+zlUNF79HoxmXpit9L1AKk1eYKRdbTcpGPZRwXoiGw9HQ+XT/j9oUyQRXXeEBtuYL
 6AMgqkoRPOl4ILyryb1aPV+7Zu4Fgn2FLDENXxbfSUY9UevU+Pf0hucTA8ZbQON4LrcJT0jq5F
 BEE3VUxLmPMWxt3NaURMsrvw+PtLJjy1a3HqUTrV08XtZLK6wi84bebWedCjJ3a+hkqOaDUAyZ
 AJ0uNZqJe7deonk1aaBvy1lO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 23:58:03 -0800
IronPort-SDR: tI1ADJt1UaBspg6bmCWyaUvNAivUnLwtdUVDfnTDy2RCb0XsobMwrNYSr3Nm9pDijp2QH/MEf+
 UTmP48r/9mX4IUEVrk/sSmDHrrhIsYSdHhtiAD+hgG77guRyTvqubXiQXMlFTlq8mCqnrLA7TO
 y/+usjDsxoeYyp4QGhUdCyAEs0eF5iTQTnlICSYoha+bDPcsKuI6d2T2s+8I9NOXvjLIq7qz0e
 1fBZk/4lJu6Ze6dUgPSIuxsqKMiYfDQBQpVFGXIQJVzKNMBCVvrro/+AAv2cBJ2NKzM62Mr20v
 6rk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 18 Dec 2019 00:03:39 -0800
Received: (nullmailer pid 991182 invoked by uid 1000);
        Wed, 18 Dec 2019 08:03:38 -0000
Date:   Wed, 18 Dec 2019 17:03:38 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 21/28] btrfs: disallow mixed-bg in HMZONED mode
Message-ID: <20191218080338.br4pk32qjpmd36io@naota.dhcp.fujisawa.hgst.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-22-naohiro.aota@wdc.com>
 <d287a92b-796e-0f44-c177-5143f7589cb6@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d287a92b-796e-0f44-c177-5143f7589cb6@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 02:56:20PM -0500, Josef Bacik wrote:
>On 12/12/19 11:09 PM, Naohiro Aota wrote:
>>Placing both data and metadata in a block group is impossible in HMZONED
>>mode. For data, we can allocate a space for it and write it immediately
>>after the allocation. For metadata, however, we cannot do so, because the
>>logical addresses are recorded in other metadata buffers to build up the
>>trees. As a result, a data buffer can be placed after a metadata buffer,
>>which is not written yet. Writing out the data buffer will break the
>>sequential write rule.
>>
>>This commit check and disallow MIXED_BG with HMZONED mode.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>I would prefer it if you did all of the weird disallows early on so 
>it's clear as I go through that I don't have to think about certain 
>cases.  I remembered from a previous look through that mixed_bg's were 
>disallowed, but I had to go look for some other cases.
>
>Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
>Thanks,
>
>Josef

Sure, I will sort these patches after the other disallow patches.

Thanks,
