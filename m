Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272B132C4F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359131AbhCDASo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52082 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354814AbhCCGAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614751205; x=1646287205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHbP2PVz75/uxoCFw4ilooJsgZgJmV6Qp8xrir4zMRw=;
  b=CKXHfKD8b7sUpHJDUMIwTT32RVvpzEVzwL3hkuXLr7Eai0KmqZmb1UoY
   p9BumUcjs6332Y+q8D6txEiSBWiowmPaBkYKXxvIHclrtQfny6ffOovdy
   FvKvRpYl/m9e56SpXB8ZenlXfigJ/Y+26FzDh6/s0ydcg4Z6U+EAuRqon
   NHsj4gFdtRazIBR3HiWPjZ8gD39Nl1IhSW1kJ0nT/HPRblBDS27Jwk2nW
   JcfCVbmMbMJgvSp/RV2WHA9q5JyoyUbFoA2zbhijrVmdhCs0yGjBbllwX
   gZibgod2F8KBuj9f5qrCO9BSSh6iLNX0uPPCzl6liTYUvybvVWZr4c2fu
   A==;
IronPort-SDR: jnYlJZLq0F3qYRM0VAYadPDJMypIpYoS7P4zPGaDd1/b0qcZXwWoW36p56YFDs26panBhB/Tlo
 EizeTgO/0NfE114djySG6cCXA3dONWEemNtAZlpxN3JDnMEG7F2g57MV76XTJeEifOebjg30od
 qZGOVBHRUyJ3Jc5h3ymBazTshc8NbvVN9pSIjaOu6i0juvkK/Zs0YHwBTGZ+ZNSif3SCNxOWEp
 LGDH6Q4KUCjWIuiK4cKcJhZOTuywNFmhuIlXy2qZFHhUrReSTitZFzxbNd+wGP9YPg+UVlXpR+
 bEA=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="162392622"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 13:59:00 +0800
IronPort-SDR: deuwS+MDVCOM9IRdZZhUBIePbpFzWn4RHNYQouWafsa2B919XCF+jtEvlH/EuLGzEedNlHip0C
 EdxOvA752fm6K5IU4tIvw8gB2a3RXsUPx5FL7NnCCjkI37ms/MKU/HKmOfvII0XNq/yMhQVpoG
 npmp/KBMg7BRM3k9L7p7Jar9mdbnAY2fjuiwo5jGCfbCzTCZbJZChiePr1exEhObHzBR4V9EAZ
 wOtSIbLrnJBJaHjIMyywXvwh/c6CpzXHrduAC+6N7UwOC9tHPWTP+6tza4nZOQbTWPOlZwdn7v
 /hqGih6EjUa7MysVYXWL6scr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:42:04 -0800
IronPort-SDR: lLoAeHooPjrTPxXjr9uqr9EbU9hNYUnAu6LDJlOctTQ6l0brzYNMDUDmqTcO3tsY8j3EB/3hdy
 7/Tm6gOJEiuWvbP5FI4xPL5Z7yjrGU3qI4ZbQmoTngxYjeEXwfLAqNWue1vzMdMPsWoI9CwohG
 d2+LfSohzRTpPDAdrFnOpXJ+IxXDke7HZ0DD43CO+sDU9sa0mvcClQk6T3OmA07O7DyVuby1tJ
 2pg4EtEzjQPlYuy0ETPtKIDiT7u1LYDUfvjclPVVmayHQ5JQ6eSY96Kzkf7Dk6aOlb8UObZu+Z
 xtg=
WDCIronportException: Internal
Received: from bksm5s2.ad.shared (HELO naota-xeon) ([10.225.49.22])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:58:59 -0800
Date:   Wed, 3 Mar 2021 14:58:57 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fstests: two preperation patches for zoned device
 support
Message-ID: <20210303055857.yfevx2uyyhltn2jk@naota-xeon>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Is this series intended to also Cc'ed to fstests@vger.kernel.org?

On Tue, Mar 02, 2021 at 06:13:03PM +0900, Johannes Thumshirn wrote:
> As btrfs zoned device support was merged with 5.12 here are the 1st two
> preparational patches for zoned device support in fstests.
> 
> The 1st patch adds missing checks for fallocate support to tests that are
> lacking it and the second patch checks for discard support availability.
> 
> Johannes Thumshirn (1):
>   btrfs: require discard functionality from scratch device
> 
> Naohiro Aota (1):
>   fstests: add missing checks of fallocate feature
> 
>  common/rc         | 8 ++++++++
>  tests/btrfs/013   | 1 +
>  tests/btrfs/016   | 1 +
>  tests/btrfs/025   | 1 +
>  tests/btrfs/034   | 1 +
>  tests/btrfs/037   | 1 +
>  tests/btrfs/046   | 1 +
>  tests/btrfs/107   | 1 +
>  tests/btrfs/116   | 1 +
>  tests/btrfs/156   | 1 +
>  tests/ext4/001    | 1 +
>  tests/f2fs/001    | 1 +
>  tests/generic/456 | 1 +
>  tests/xfs/042     | 1 +
>  tests/xfs/114     | 1 +
>  tests/xfs/118     | 1 +
>  tests/xfs/331     | 1 +
>  tests/xfs/341     | 1 +
>  tests/xfs/342     | 1 +
>  tests/xfs/423     | 1 +
>  20 files changed, 27 insertions(+)
> 
> -- 
> 2.30.0
> 
