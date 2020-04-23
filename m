Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550471B52AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 04:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDWCor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 22:44:47 -0400
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:30664 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDWCor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:44:47 -0400
X-Greylist: delayed 671 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 22:44:44 EDT
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.231.130]) by mgwkm03.jp.fujitsu.com with smtp
         id 0abc_3579_5544f71c_4878_43bc_a3de_fa2088113603;
        Thu, 23 Apr 2020 11:33:27 +0900
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id BF869AC00FD;
        Thu, 23 Apr 2020 11:33:26 +0900 (JST)
Received: from [10.133.121.138] (VPC-Y08P0560080.g01.fujitsu.local [10.133.121.138])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id A3A30403;
        Thu, 23 Apr 2020 11:33:26 +0900 (JST)
Subject: Re: [PATCH V10 04/11] Documentation/dax: Update Usage section
To:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-5-ira.weiny@intel.com>
From:   Yasunori Goto <y-goto@fujitsu.com>
Message-ID: <2282176d-60c5-0e4b-3cf9-7a7682de380d@fujitsu.com>
Date:   Thu, 23 Apr 2020 11:33:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422212102.3757660-5-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'm trying use your patch now, and I have a small comment in this document.

On 2020/04/23 6:20, ira.weiny@intel.com wrote:

> +To clarify inheritance here are 3 examples:
> +
> +Example A:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' a

Probably, "-c" is necessary here.

xfs_io -c 'chattr +x' a


> +mkdir a/b/c/d
> +mkdir a/e
> +
> +	dax: a,e
> +	no dax: b,c,d
> +
> +Example B:
> +
> +mkdir a
> +xfs_io 'chattr +x' a
ditto
> +mkdir -p a/b/c/d
> +
> +	dax: a,b,c,d
> +	no dax:
> +
> +Example C:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' c
ditto
> +mkdir a/b/c/d
> +
> +	dax: c,d
> +	no dax: a,b
> +
> +

---

Yasunori Goto

