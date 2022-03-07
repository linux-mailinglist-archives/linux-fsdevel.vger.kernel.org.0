Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5094D0AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 23:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbiCGWMW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 7 Mar 2022 17:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbiCGWMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:12:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D49F8BF19
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 14:11:26 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-213-iFbUxoq8N32Ti0xfCSXC3A-1; Mon, 07 Mar 2022 22:11:23 +0000
X-MC-Unique: iFbUxoq8N32Ti0xfCSXC3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Mon, 7 Mar 2022 22:11:19 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Mon, 7 Mar 2022 22:11:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Nathaniel McCallum" <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>, "G@iki.fi" <G@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Alexander Mikhalitsyn" <alexander.mikhalitsyn@virtuozzo.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFC 0/3] MAP_POPULATE for device memory
Thread-Topic: [PATCH RFC 0/3] MAP_POPULATE for device memory
Thread-Index: AQHYMjv2CAL18nxa1UOLUz+3aRpSlay0etRA
Date:   Mon, 7 Mar 2022 22:11:19 +0000
Message-ID: <5729d03d6a174da6b66d1534ebdb1127@AcuMS.aculab.com>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <YiSb7tsUEBRGS+HA@casper.infradead.org> <YiW4yurDXSifTYUt@infradead.org>
 <YiYIv9guOgClLKT8@iki.fi> <YiYrRWMp1akXY8Vb@infradead.org>
In-Reply-To: <YiYrRWMp1akXY8Vb@infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig
> Sent: 07 March 2022 15:57
> 
> On Mon, Mar 07, 2022 at 03:29:35PM +0200, Jarkko Sakkinen wrote:
> > So what would you suggest to sort out the issue? I'm happy to go with
> > ioctl if nothing else is acceptable.
> 
> PLenty of drivers treat all mmaps as if MAP_POPULATE was specified,
> typically by using (io_)remap_pfn_range.  If there any reason to only
> optionally have the pre-fault semantics for sgx?  If not this should
> be really simple.  And if we have a real need for it to be optional
> we'll just need to find a sane way to pass that information to ->mmap.

Is there any space in vma->vm_flags ?

That would be better than an extra argument or function.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

