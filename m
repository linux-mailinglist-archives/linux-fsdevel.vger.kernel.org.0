Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B01295888
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 08:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438863AbgJVGsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 02:48:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48468 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407804AbgJVGsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603349415; x=1634885415;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=FlMHwlKQHkGtz11u/T63nBONh3Bzvj/xoVk3RFmnD/Q=;
  b=kXOKTGMfdci52Ka1r1ELMErrqFfAVDAvbh2X1L2qyzh7MyL6mpPinXC6
   CWNPeQXixXXnf9mW1A6gr/GMinGo5vT8JRiGux3yEAQc2j9Kq2K9dxu0+
   Tt8bYzMC5FzoTVTiCZEBoFSrPh2gEpJoqafc7scChJyVhCRDsARbtK6Qc
   3XZNGScyo3XRwteaXJYLK7NxvbYmWMdXNKHg10+QnwWhPiJjgdSHYzBV4
   5/890ueX9KXFtp5jsi86ArQy7jgH7v8cBvBt8bBzlsThUDPKpBsSVSWn6
   h+a7MrOnZPCMpMyvDJUUZKrq+iHBNGoGEH0RGKi0i3NQBpC9nzdQeCC0P
   Q==;
IronPort-SDR: /ZSUK+K/3wz51reZn5eqcNMm/2of4Rmn9Yyi57Y0V/3K6mr/urGYyLGW5dc9FCjagxQmfmA/dh
 KvgtABfi/xzSzQfHZW+w1B6fhX2tKL5QyGjftmY5Zwufy7XAkPpttwmIFKBPmhXRkJ6EBTBi0M
 jpRZAQE77rejWCNZw9zh7cv8vwg2EG4Cp3+zCQXS4NPpSpw7jT9MUpf4qvHgrsuwHdd6ypfnX7
 ALJbPnj9OqPGKP2jHDY+V1k/dpl7lF+zvjZ0uLYOqTw5UMAjHn5XiluI3GcxP4PiChCkIJ0ZFg
 VKU=
X-IronPort-AV: E=Sophos;i="5.77,403,1596470400"; 
   d="scan'208";a="254094978"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 14:50:14 +0800
IronPort-SDR: 2CpP3PZWJ+LPJ9WKPo9SeUJkKJ2ry68YyZaxFnOOro8D+kdpTJI39w8SYUifEvcU2AEfe09u3f
 vT6E4Szdonp5xg5anlWEGQe+iJX6kNn6BcU/JhFlF5+gg9tCBJ8TSw3BYwO8CkiCTmBzdyfM7i
 LBng+ePLmNPE/gK1J8G7a3/43MioZG4nTQVVQc7NYlwEGJwTLjb25gV4l6hAyQNqbPRzO4SL1r
 gIpGfeE/cFAMWKAdQgzE31Rp2MONwQ/vlRSt7mguG8rpaYDhXscV9Ha8+PTwqvO0yCw7V07VTk
 qll6mgv/s4bnHdhgf4Xm2Fi0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 23:34:33 -0700
IronPort-SDR: RFwsVhv+sbyh+pyn9f7IG+keDM0jIZBb58TCLI2b3WDs9k2bVDnhQmctfcrOozlk1uzQ/eIp0S
 3t9GBBmgJ2ydfw4Zzlx8ENVDUjqXZuml46PFSF34Jq51Q72+Btcv5qJLBDRsoSZfWFwaBP39Wv
 OsrE5sC22zGojhL3egPYXs5Xc1YBuwAEKoskDgvZ995YwH/wNJgfWBgQ9Z2SXOMH2Fc21xoMgo
 Y24bPJCivNvWYur4cdcSvVR9xPBUJu9/7+ovL64Mm1v0HGHaQCgaesoRu82urZ9kCiFRYZbzPe
 BuA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 21 Oct 2020 23:48:08 -0700
Received: (nullmailer pid 791091 invoked by uid 1000);
        Thu, 22 Oct 2020 06:48:07 -0000
Date:   Thu, 22 Oct 2020 15:48:07 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v8 10/41] btrfs: disallow inode_cache in ZONED mode
Message-ID: <20201022064807.am3amanzc7tzec5f@naota.dhcp.fujisawa.hgst.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <4aad45e8c087490facbd24fc037b6ab374295cbe.1601574234.git.naohiro.aota@wdc.com>
 <20201013154117.GD6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201013154117.GD6756@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 05:41:17PM +0200, David Sterba wrote:
>On Fri, Oct 02, 2020 at 03:36:17AM +0900, Naohiro Aota wrote:
>> inode_cache use pre-allocation to write its cache data. However,
>> pre-allocation is completely disabled in ZONED mode.
>>
>> We can technically enable inode_cache in the same way as relocation.
>> However, inode_cache is rarely used and the man page discourage using it.
>> So, let's just disable it for now.
>
>Don't worry about the inode_cache mount option, it's been deprecated
>as of commit b547a88ea5776a8092f7 and will be removed in 5.11.

Thanks. I'll drop this one in the next version.
