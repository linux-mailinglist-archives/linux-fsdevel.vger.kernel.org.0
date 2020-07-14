Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51C121E758
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 07:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgGNFLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 01:11:33 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35508 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNFLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 01:11:33 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2F3138066C;
        Tue, 14 Jul 2020 17:11:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1594703488;
        bh=O8M/VJRhRxeOoGoN7HkoA71jSzqeM9f2QwrI5HndS4E=;
        h=From:To:CC:Subject:Date;
        b=MiUpwprXODEVpSt2aL/+bNETJFa3lfHSjS24FtIEy4bQZnrLvGVhRZakl05UX43kC
         eN71cpzicQM4kcuUTQttYKk2cIgns2ZYlPeF6nK+kA8YsnRn4dis23cX4ge2+hoBV+
         BOS86zsODOG4nJyWG+8jVOFZMef7O3ubJJyPBTqPhgMn2cznnXqND+NWSE0+7rb5Q1
         P2ByZ4Nb89WkGP0ArLVolVRfX7XxeP2Fxr8lVbQgi5jIqfbFivkRyta3f/bknImt0n
         WnvQPzCxnGqLJ9QK/A/ThQTct+y9K1Cz9Ke72OiycDpRLNinTCUJnRlRLsMirfBz5E
         K0e24Kg7cHRGw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f0d3e7f0000>; Tue, 14 Jul 2020 17:11:27 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jul 2020 17:11:24 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 14 Jul 2020 17:11:24 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: procfs VmFlags table missing from online docs
Thread-Topic: procfs VmFlags table missing from online docs
Thread-Index: AQHWWZ04Axuc9KTu2km08OQff6fL1w==
Date:   Tue, 14 Jul 2020 05:11:24 +0000
Message-ID: <8abafee9-e34b-45f6-19a7-3f043ceb5537@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C41B5694AB920741B5F1DA9FAC79A379@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNCkkgd2FzIGp1c3QgYnJvd3NpbmcgDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL2xhdGVzdC9maWxlc3lzdGVtcy9wcm9jLmh0bWwNCg0KVGhlICJWbUZsYWdzIiBkZXNjcmlw
dGlvbiBzZWVtcyB0byBiZSBtaXNzaW5nIGEgdGFibGUuIEl0J3MgdGhlcmUgaW4gDQpEb2N1bWVu
dGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0IHNvIEkgYXNzdW1lIGl0J3Mgc29tZSBzcGhpbngv
cnN0IA0KcHJvYmxlbS4gUG9zc2libHkgdGhlIHRhYmxlIGlzIG92ZXIgaW5kZW50ZWQ/DQoNCkFu
eXdheSBJIHRob3VnaHQgSSdkIGxldCBzb21lb25lIGtub3cuDQoNClJlZ2FyZHMsDQpDaHJpcw0K
