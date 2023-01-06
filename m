Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0E65FDE6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAFJ02 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 6 Jan 2023 04:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjAFJZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:25:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4D75D00
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 01:22:01 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-FaFPO-QRMv2f2SfbtlhxTQ-1; Fri, 06 Jan 2023 09:21:49 +0000
X-MC-Unique: FaFPO-QRMv2f2SfbtlhxTQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 6 Jan
 2023 09:21:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 6 Jan 2023 09:21:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ameer Hamza' <ahamza@ixsystems.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "slark_xiao@163.com" <slark_xiao@163.com>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "awalker@ixsystems.com" <awalker@ixsystems.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>
Subject: RE: [PATCH v2] Add new open(2) flag - O_EMPTY_PATH
Thread-Topic: [PATCH v2] Add new open(2) flag - O_EMPTY_PATH
Thread-Index: AQHZHXO7YJxmMel9jU25EiVio9tPeK6LKkFQgAAJzgCABe+GwA==
Date:   Fri, 6 Jan 2023 09:21:46 +0000
Message-ID: <ea8739b122674695ba9bf991b589817c@AcuMS.aculab.com>
References: <202212310842.ysbymPHY-lkp@intel.com>
 <20221231235618.117201-1-ahamza@ixsystems.com>
 <4b39cf528148470c934fb5823b35e9d5@AcuMS.aculab.com>
 <20230102143538.GA8886@hamza-HP-ZBook-15-G3>
In-Reply-To: <20230102143538.GA8886@hamza-HP-ZBook-15-G3>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ameer Hamza
> Sent: 02 January 2023 14:36
> 
> On Mon, Jan 02, 2023 at 02:01:38PM +0000, David Laight wrote:
> > From: Ameer Hamza
> > > Sent: 31 December 2022 23:56
> > >
> > > This patch adds a new flag O_EMPTY_PATH that allows openat and open
> > > system calls to open a file referenced by fd if the path is empty,
> > > and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
> > > beneficial in some cases since it would avoid having to grant /proc
> > > access to things like samba containers for reopening files to change
> > > flags in a race-free way.
> > >
> >
> > But what does it do?
> > (Apart from add code to a common kernel code path.)
> >
> > 	David
>
> It can convert an O_PATH descriptor to one suitable for r/w work.
> If we already have a file descriptor: {opath_fd = open(&lt;path&gt;, O_PATH);}, we can call
> {openat(opath_fd, "", O_EMPTY_PATH | O_RDWR)} instead of going through procfs
> {open(/proc/self/fd/&lt;opath_fd&gt;, O_RDWR)}.

Aren't both of those security problems?

Testing the file's inode permission allow write access isn't enough
to verify that the program could actually open the file for writing.
The program also needs 'directory search' access on all the directories
back as far as an open directory fd.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

