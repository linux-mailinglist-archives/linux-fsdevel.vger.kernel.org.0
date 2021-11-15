Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4AE44FFAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 09:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhKOIGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 03:06:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4092 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbhKOIFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:05:55 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ht1mV4FtGz67mLl;
        Mon, 15 Nov 2021 15:59:06 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 09:02:47 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.020;
 Mon, 15 Nov 2021 09:02:47 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>, "corbet@lwn.net" <corbet@lwn.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 4/5] shmem: Avoid segfault in
 shmem_read_mapping_page_gfp()
Thread-Topic: [RFC][PATCH 4/5] shmem: Avoid segfault in
 shmem_read_mapping_page_gfp()
Thread-Index: AQHX18MROltj/rJe+kKE1cDtluXUoawALbMAgAQP9RA=
Date:   Mon, 15 Nov 2021 08:02:46 +0000
Message-ID: <987ab9f6dc844f8584a0224924e13bea@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-5-roberto.sassu@huawei.com>
 <YY642nxarVElvKUS@gmail.com>
In-Reply-To: <YY642nxarVElvKUS@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Eric Biggers [mailto:ebiggers@kernel.org]
> Sent: Friday, November 12, 2021 7:56 PM
> On Fri, Nov 12, 2021 at 01:44:10PM +0100, Roberto Sassu wrote:
> > Check the hwpoison page flag only if the page is valid in
> > shmem_read_mapping_page_gfp(). The PageHWPoison() macro tries to
> access
> > the page flags and cannot work on an error pointer.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> This looks like a recent regression from the commit:
> 
> 	commit b9d02f1bdd98f38e6e5ecacc9786a8f58f3f8b2c
> 	Author: Yang Shi <shy828301@gmail.com>
> 	Date:   Fri Nov 5 13:41:10 2021 -0700
> 
> 	    mm: shmem: don't truncate page if memory failure happens
> 
> Can you please send this fix out as a standalone patch, to the right people and
> including the appropriate "Fixes" tag?

Hi Eric

it looks there is another patch. Given that it was proposed before,
I will drop mine. Thanks anyway.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua
