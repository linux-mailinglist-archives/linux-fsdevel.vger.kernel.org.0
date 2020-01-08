Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2113449D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 15:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgAHOJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 09:09:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgAHOJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:09:44 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008E3JFT029828;
        Wed, 8 Jan 2020 06:09:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hP8SA3oZBom72jdiBimMfphYUPD0R7ylGX4dbij5sD8=;
 b=V0lhkCoaWvrxGaEy797GeEvkSw0YWjmFbefdmvSXuq+bGS3KELfJcmNz5cwCA9lnF/Si
 W1Bs+36QNx2UFRCp+vu8+JVGKVqLiDzb2SnnoqsJNMGspHaAyvznrs08sDpqWkfLUEdC
 Rm8ewsZd5H1rWW2jyPXf0Au1YG5rJfX0RsI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xd2ac3umg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 06:09:28 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 8 Jan 2020 06:09:28 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 06:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrDDeTa2QMkKOZuASdJ9XBNRT1AedD/qxLUCzG4zrpRJbNsly9O5fLBexZhjOk+srm5kjQtWsIu6JfNuAa3BZg8ifRnQlYeCLjhuc4YYN0MTGmXowvV0Q2/IVDr4Ksrv/D9NHF9w8j64RiR95R0cbqmK4aP7/37uu9DPn1EKg+IzWIN6EiOuLG1lpiMUhuU1J4b2nJdhe08i45nOjRAgcTwG+BGKw2+Bf6ESBOuy0qDybEGqGEAdaRbAqHwI5N0vlxcgU7D4e6QXKJz+c7S15ina50ou4CReb29EY9SxggTO33e2/M5I2dTxPOILEDBkTO3jXbQ75x2HZPKxrPik8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP8SA3oZBom72jdiBimMfphYUPD0R7ylGX4dbij5sD8=;
 b=JgoCSG7OsALOcd8c3hbhPEpdVk2rrJB1gK19mLJGAJDgurEjfQey245RoO7Cp/MuGFM22mRF7oFbvZioPjQb2Yvz/CgLsh8v60v3gisqE5JqZ8h0K258+9DBeep3ho9t/0f+f/g/wpfCd7qEGo0FMtNQ+tOxtotmqIcNw2VGuw3HOOedcoYf+T6r40yZ6fgwKP4pk7RLwJVTkcbhl+HMjjcbRsCOo7G5iPFRngd5k2pyyPB4b5VkINBuU7r1Y4/hF1ljcSUsexJmltoRNY7XVJdcvEDyKm9tmCWb1Cj33453i0MKb7GdQZYg4GcIO8CWVHThw1cj/TrnLt0wWbit7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP8SA3oZBom72jdiBimMfphYUPD0R7ylGX4dbij5sD8=;
 b=IRFi9BCxvwcSIaPJyKmJaOV2EoUlRU2ZX+U5gvT9Uek0pm1QuLxklSo54lcyHrhW/ZjqpKMtQ0iQMDceB5FE5hiPbYS2v2r1WeetIdXQ5H8WLcED5jNcUh4/n5ALeMhX36OBhH8mKMEPRu1TfaFscnaEiOQALVkSHZgsC9p8Hwk=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2208.namprd15.prod.outlook.com (52.132.125.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 14:09:13 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 14:09:13 +0000
Received: from [172.30.74.107] (2620:10d:c091:480::89ea) by MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 14:09:11 +0000
From:   Chris Mason <clm@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Thread-Topic: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Thread-Index: AQHVsDfZCAhJpFV97UaB5wo39Jtv8ae1MtkAgAAFQoCAABuEAIAACAuAgAABbACAAALSAIAAOMgAgAAYaQCAAWKTAP//4lWAgCitGACAAVbbgA==
Date:   Wed, 8 Jan 2020 14:09:12 +0000
Message-ID: <E1435F53-D5B9-49D0-B207-20F0D21AAFCE@fb.com>
References: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <20191212221818.GG19213@dread.disaster.area>
 <C08B7F86-C3D6-47C6-AB17-6F234EA33687@fb.com>
 <20200107174202.GA8938@infradead.org>
In-Reply-To: <20200107174202.GA8938@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.13.1r5671)
x-clientproxiedby: MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32)
 To SN6PR15MB2446.namprd15.prod.outlook.com (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::89ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a502c35-2322-47fb-1632-08d79444568c
x-ms-traffictypediagnostic: SN6PR15MB2208:
x-microsoft-antispam-prvs: <SN6PR15MB2208CC887130539BB5F19A1ED33E0@SN6PR15MB2208.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(81166006)(316002)(86362001)(5660300002)(6486002)(54906003)(8936002)(2906002)(36756003)(81156014)(66446008)(64756008)(66476007)(66556008)(66946007)(16526019)(2616005)(186003)(53546011)(4326008)(52116002)(478600001)(71200400001)(33656002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2208;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKIU5/hZoNi3pCFObZe5JN9XcpFWMkAy18Y5cXY+Wx3BWeVvBStybOBArF4/yxwpygrFHBRZtLIlMhrC7fZlB548MKIGfzelp0JUle6Trj8upBgq9Bk7iKVbyXo5adPvgxdmtFX0vz8c9Km+1Q//WiKgygrup7RMcOtCYnL7SvCpUHvn0zb6609VeZA0UfwEK2+C4wQfoNim9P4RrLa/xyfWTQd4Thizhyf5QBC1rhKVCOKNbtiRMBGgqyKR1XFkNsVnW++vdA6qojPSM3lfBV63ddWYPWmA2B7fR6XyJ4KyjM/AlL4DsC1fgNHaMSnTwCf8UzydoERnNa0rBr/LnohuFt0lE6zOm2mXE2jE9smssjPAZwentrNjTTN3a7+DX16Wa8AJav77+dw3b2g/RhS7SZFD4rOF907zsAoGmV9a2dtntwY+RjKa8JiA+hW7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a502c35-2322-47fb-1632-08d79444568c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 14:09:12.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riY28i0sigkdJaIpPSqARe5OCYmRF0eG0TzTNtyQGx4rXyqqX18qcUQD9EyZtS5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=671
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001080120
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7 Jan 2020, at 12:42, Christoph Hellwig wrote:

> On Fri, Dec 13, 2019 at 01:32:10AM +0000, Chris Mason wrote:
>> They just have different tradeoffs.  O_DIRECT actively blows away=20
>> caches
>> and can also force writes during reads, making RWF_UNCACHED a more
>> natural fit for some applications.  There are fewer surprises, and=20
>> some
>> services are willing to pay for flexibility with a memcpy.  In=20
>> general,
>> they still want to do some cache management because it reduces p90+
>> latencies across the board, and gives them more control over which=20
>> pages
>> stay in cache.
>
> We can always have a variant of O_DIRECT that doesn't do that and
> instead check if data was in the cache and then also copy / from to
> it in that case.  I need some time to actually look through this=20
> series,
> so it might be pretty similar to the implementation, but if defined
> the right way it could be concurrent for at least the fast path of no
> cached pages.

Yeah, I really do think we can end up with a fairly unified solution=20
through iomap:

* Allowing concurrent writes (xfs DIO does this now)
* Optionally doing zero copy if alignment is good (btrfs DIO does this=20
now)
* Optionally tossing pages at the end (requires a separate syscall now)
* Supporting aio via io_uring

We could just call this O_DIRECT, but I like RWF_UNCACHED as a way to=20
avoid surprises for people that know and love the existing O_DIRECT=20
semantics.

-chris
