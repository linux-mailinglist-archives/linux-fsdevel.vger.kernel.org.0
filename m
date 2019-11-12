Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F47F86C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKLCMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:12:12 -0500
Received: from mail-eopbgr790041.outbound.protection.outlook.com ([40.107.79.41]:43328
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbfKLCMM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:12:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvkY98FPJ3RS1UeDMm4OwUW/IcZjXdb0HJpYIeyp1LieRasKbIMe+9SVm9sDteF3ddPDMXHRw5C1P5trwr+4HulcasDnFsHrlUpwMIKcxzvlw6apHrCGHAa574Hg6oNkB2UtDwQgVg9uAfXKf1riVn3lUf80PiBxCyP2AaNe/4mwM/OhUbxH6j0Mh4GX9wxGOZxdbZgxVpiSTvVkQrP1hC3YMoDBq7riZik1qOuiPJRatNx2t5ru2ZisN8pxCQBoc0ZmiPJOVrKtoZh/tB7TnLCc1Q9C2zQiz6B7S2LV/Y6eFyhaiazhMLnnJ5ZMvIeXt42uTS1E6yKCky8iBvB/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KNkVgQrkngTS4qXw8mmTUn0x/JdWoj/Hl7eDuV06kE=;
 b=ndsWIm+FfXZO4wzjBDQOjgOYRmPN9beq0n7ZKNL99lKbZY4/6svvV+pR/GuIlU86YRSvlaRRLRW+T0BSj9GghPfEf9mn8Y0G+oS1duVMmnrC+BCfDRqvKvng0vd4DMoyYokSFDQarY3bxHiq9HSGlIzcgmjQowanygvDFSYCP4eL9jbWRiXthEHHxcAkLgH+n7qT/NcYRfHWyY6lRX9zpgHZaamhi6KRXluQpBkzIu1N140wakI9V9sVrkPFUbpKdUjdC7hNZhTAFxSTN6Jqd97rBwmXeACUDgp9Bu6yWphQMattiPsuK9tz9T+7YylhNKRBHuchDGCKJ3Ti+ToRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KNkVgQrkngTS4qXw8mmTUn0x/JdWoj/Hl7eDuV06kE=;
 b=NYsK0P6vHWRkoQstYQBStZ6E1lnEevTIyTLlng9rdbP5tkNAA10lUAQk+QHNVt3lhgjAALhoSedr81+wVNBzL1nhIrrtrZeSqhQ2E+5MXP5tezTo32sIUufiA77zovZNLJSY6uKHLTKHa1aFEq35PC7rySBcm/61cCEfTnOxnL0=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB6270.namprd02.prod.outlook.com (10.255.7.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 02:12:09 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::58bc:3b1e:12cf:675e]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::58bc:3b1e:12cf:675e%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 02:12:09 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>
Subject: DAX filesystem support on ARMv8
Thread-Topic: DAX filesystem support on ARMv8
Thread-Index: AdWY/Oy6C0M7BvSlQD+OiC0acLTSOw==
Date:   Tue, 12 Nov 2019 02:12:09 +0000
Message-ID: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [115.98.198.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6dec05d-dfdd-4a1a-6274-08d76715b90c
x-ms-traffictypediagnostic: MN2PR02MB6270:
x-microsoft-antispam-prvs: <MN2PR02MB6270C0E0BAFE9475E2D039E0A5770@MN2PR02MB6270.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(53754006)(14454004)(81156014)(5660300002)(33656002)(186003)(74316002)(8936002)(81166006)(2906002)(25786009)(7736002)(558084003)(7696005)(305945005)(26005)(486006)(66066001)(54906003)(8676002)(6506007)(110136005)(102836004)(2501003)(99286004)(316002)(66946007)(6116002)(71200400001)(71190400001)(64756008)(66556008)(6436002)(2201001)(66476007)(66446008)(3846002)(478600001)(52536014)(4326008)(86362001)(76116006)(9686003)(256004)(55016002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6270;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToKBUI16fbR5on/MKL+S7BiDXU/pb6sV8gMKgKPMrRMDEmWiIlaL4n3944XwRYF/FPb65FHPiZkKNOmDbsOWKjYx/EKFk5yzhcNS13/O4dhF1DVJgARHvPDZvxA95Vht4ZggThwLUcNKXLu5o4nzEFQ6SIDsghK4vXWAd+YA3KOss0zSnFpwAB72QAzEH694k7f+LjgKi/2YDhzn98WA9KqpxtLeqGT3S0ZDJc90HfZxRNld7Hx5wqgLv6PZDFwPbDXmYEv7Mzn3TMhI2RWYgzL7lYV4XD/X7m3js2fKDSYPbuwOxHQraTEPv6GjeCsRbpFiLO1oOKSSGl2QcBD1surEVzqwlnwTXRKG9uN31XcLrSpmq6dT1qE7QEftLGxU9yIOnSjSbL0+PvQq+XObuwnY8haV/wJDsxhZFJg4ekrXHgTLyRIfClPevEwFaxdl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dec05d-dfdd-4a1a-6274-08d76715b90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 02:12:09.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzzrg5awa7zXO5N7LVmUXMfUqXHkVeYRleq+463TJDWcG+Btro/62PUrMDw+2m98cGvp9vGJVHFr86hmJZObJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6270
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

As per Documentation/filesystems/dax.txt

The DAX code does not work correctly on architectures which have virtually
mapped caches such as ARM, MIPS and SPARC.

Can anyone please shed light on dax filesystem issue w.r.t ARM architecture=
 ?=20

Regards,
Bharat

