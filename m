Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869E02869CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgJGVDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 17:03:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15322 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGVDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:03:35 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7e2cba0001>; Wed, 07 Oct 2020 14:01:46 -0700
Received: from [10.2.85.86] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 21:03:35 +0000
Subject: Re: mmotm 2020-10-06-15-50 uploaded
To:     <akpm@linux-foundation.org>, <broonie@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-next@vger.kernel.org>,
        <mhocko@suse.cz>, <mm-commits@vger.kernel.org>,
        <sfr@canb.auug.org.au>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gary Gunthorpe <jgg@nvidia.com>
References: <20201006225133.Y21m5SGLJ%akpm@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6a97eeaf-781b-f06b-050b-a56c9f8f1632@nvidia.com>
Date:   Wed, 7 Oct 2020 14:03:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006225133.Y21m5SGLJ%akpm@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602104506; bh=JZfEZdS82MK5uL1Zki+SPS+QszJMiRQrlHgFw1PPP20=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=kIpxYqeZ1MCqIMXKYxFL/yzbz2v8z4MZXZxABnVPpduChvb6wcuqYrUzQb1fPLuIW
         uDpb9BihN63L7B049pu8l+IFEMQ2s+UKQoZe2nxqnX9tth8Xmjh62Z4ydvJi0ur8cR
         +gO16mqVLHXDruzxsoZrzaQXAmwNk3S1h/UObIkBbtOM6cZW/qIAFedV9Yu3srsGkT
         DYOBuT1MeLvrCCVbY6T0Ipxqc0My0e3gUoQi6gLuW41tA6Pad5Zgin0SveWDYn96up
         pOgTU3LjyeWYeRhywdoqQqW5YPuf3QOZC6/wIWgp0gZcwbj8w5KEWBWH/rFnn8lnfy
         SrVj3f+TJWY6w==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/20 3:51 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-10-06-15-50 has been uploaded to
...

> * mm-frame-vec-drop-gup_flags-from-get_vaddr_frames.patch
> * mm-frame-vec-use-foll_longterm.patch

That last one needs to be dropped--see my note about why in [1].
And syzbot is also complaining [2], correctly, that you can't pass
FOLL_LONGTERM to pin_user_pages_locked().

And the patch right before it, while correct as it stands, should end
up being unnecessary, because Daniel is taking a different approach.

So probably best to drop both of those from mmotm and -next.


[1] https://lore.kernel.org/dri-devel/f5130c7f-eebe-7b21-62b8-68f08212b106@nvidia.com

[2] https://lore.kernel.org/r/000000000000f3c7f005b11111c9@google.com

thanks,
-- 
John Hubbard
NVIDIA
