Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCC83D27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 00:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHFWFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 18:05:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8410 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfHFWFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:05:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d49f9b40003>; Tue, 06 Aug 2019 15:05:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 06 Aug 2019 15:05:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 06 Aug 2019 15:05:39 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Aug
 2019 22:05:38 +0000
Subject: Re: [PATCH 0/3] mm/: 3 more put_user_page() conversions
To:     Andrew Morton <akpm@linux-foundation.org>, <john.hubbard@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190806145938.3c136b6c4eb4f758c1b1a0ae@linux-foundation.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d606c822-df9e-965e-38b6-458f6c3dfe14@nvidia.com>
Date:   Tue, 6 Aug 2019 15:05:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806145938.3c136b6c4eb4f758c1b1a0ae@linux-foundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565129140; bh=rN4rO17/aT7+L127LeaBuWusoBpU6GuMzRTNeTvQtyA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RyUHGmb+ONciHZR8TDcra6EGCiFc19hpKqbxJhOr5CXgF0u+AJ08BIc8YQ9TMG9TO
         A9s2SNx+MQOxeMTHn3uY/yVZ5GdJ//1j13FexJcRa0b9agZTk3/VsNKAH6byhf+8uY
         5C2+0NZac11xcQJNzTAlaXEQrJF+y+w2GMYO4mfiet5sOmrqRPueGIQPRDaGbCCyUm
         T+fKwawV4VNNTsWpspkvC/lbu2zcbyLpZf2kqrj2Ity9iXJjT6Gv7fZLHNEGEUHcJR
         HBk/OIw+SgIgy6VNZXjdZlETfaPAxScsnN9sFdRA5kaIWJpurj4C2Oq0zVysHK5aGX
         iXaXX6n53Ozzg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/19 2:59 PM, Andrew Morton wrote:
> On Mon,  5 Aug 2019 15:20:16 -0700 john.hubbard@gmail.com wrote:
> 
>> Here are a few more mm/ files that I wasn't ready to send with the
>> larger 34-patch set.
> 
> Seems that a v3 of "put_user_pages(): miscellaneous call sites" is in
> the works, so can we make that a 37 patch series?
> 

Sure, I'll add them to that.

thanks,
-- 
John Hubbard
NVIDIA
