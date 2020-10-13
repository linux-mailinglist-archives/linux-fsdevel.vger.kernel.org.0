Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3A28D12B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbgJMPWz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 11:22:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:32229 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731172AbgJMPWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:22:55 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-21-09KH6FfAO8KY9eLeQUqqNw-1; Tue, 13 Oct 2020 16:22:50 +0100
X-MC-Unique: 09KH6FfAO8KY9eLeQUqqNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 13 Oct 2020 16:22:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 13 Oct 2020 16:22:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Giuseppe Scrivano' <gscrivan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Subject: RE: [PATCH 2/2] selftests: add tests for CLOSE_RANGE_CLOEXEC
Thread-Topic: [PATCH 2/2] selftests: add tests for CLOSE_RANGE_CLOEXEC
Thread-Index: AQHWoWoRAVlnv2MNgkqr2VY1z2O7MqmVpaJQ
Date:   Tue, 13 Oct 2020 15:22:50 +0000
Message-ID: <725dd537afca44489dad48e8ef20e894@AcuMS.aculab.com>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-3-gscrivan@redhat.com>
In-Reply-To: <20201013140609.2269319-3-gscrivan@redhat.com>
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Subject: [PATCH 2/2] selftests: add tests for CLOSE_RANGE_CLOEXEC

You really ought to check that it skips closed files.
For instance using dup2() to move some open files to 'big numbers'.

Although you know how it works, a 'black box' test would also
reduce RLIMIT_NOFILES below one of the open files and check
files above the RLIMIT_NOFILES value are affected.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

