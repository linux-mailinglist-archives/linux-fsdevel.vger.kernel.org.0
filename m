Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C075635E68D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347958AbhDMSiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 14:38:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28180 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhDMSiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618339071; x=1649875071;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=;
  b=NgakPtGok0KyVKu1GNHBkdaHLSCcjZ4VOsNbSufnXAkbaf7UNQeSc+fZ
   9WxYIY8KDclWAOjwZu/5Lxfyd2QP4eXUtQDbHuLiX4OTVqUBe58q4RQr/
   DgrpVaywZSLmtMzkgNY0IxRMJ2ZEGN0dVYS4dwR1OVApC1xKdmnT0hJar
   d2lLvG7oVtVzld+kfwrIMccx0MGG0++cPAlJBLI+Uyg5JNaidQqCNfx0l
   oAaFh0bKeR5BtF3JoO1KwvJIa8K5fqPj6rvWfjyE3aMngcFmZqfyZ9xy4
   6UgR/9BTaFK8d6o2sKuP9hzD1W382JTtAn2du17L4UtSNAkrJSkI46WJS
   w==;
IronPort-SDR: wIA1KIacVeS4Hvqog9ySjbZa/cZctLWFdoYxhoaX6Tij8PqMsjrMU4IjFZJPVVMeeE4B8yw74m
 wxRH/ZWn7lhgLqRidhBwSAJ1HXg05q7/g5dFWQZ4QXSOSOauLDflQAXepKQ/6SbeZb1NEJu/oq
 yIx8arVS31WhCF6ItXZzzDDHKwdm0V2PXneRJF8jpSjWEJ3Sy1bj4vybuyFzLVwEF79CSxQ3FZ
 /nW+he5zOkd1A9M/qDefJT4zl7WTddQS/wK9lC3Y/7HliWdz0UyqzDbXE9DW7dnxH7IWtpCvKT
 UzE=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="164633132"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 02:36:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxxmViz9ruRzDi9hWybooghcdapN2GSZxm+2ldjeTa5MFXh8VCwlcr+0r6zWSkJSqU8CnDd4JgbLSv4oMRDh2Pa7j8GeZcIiM0gFWhMd3iEu8rHE4qU/3GSeKejW8m+2JTDM8rKZD5JhyDOH8+O/TvMqqoV7VDL9R/FKL7nuIUzaWHNsYyUJK/ze0BqzeLsjgkB5efaNDRxX1YVyNLp3j0V3v1tqeJQ4wTNcnqxUmPw0vwXCWgdzTKQlCjcnOkJN5GIrMnglIIZ9aVrerQLALXKssi9UjMeV+Xk8Ndyac++13YwPyQZH/n6nAbcIJADAH7Z3DriimjUnGkY32Qq1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=;
 b=m7bBK3cVolLIufaR7M1n/Ydv2OzUqLrD4/Gl6oU2lFoHpIvR96jnQciep2Lx8OzjK5G0WUNWu6F0rAos64uNT+J++Spl8G5uMDVskzDYPNlvOgA10oKHaIrXG5Mj+1DWVhV8I4RkHXoQG8mSf9eOjdhy75i48c43seMwxT46Uzvdebb8OBzIl3WD6jS9gWVvUAjcrk/sJTEVmZsPUOqgTD8lcxLiLTkETkQESqvKFuJ/7KYnm0+DZOZnGxYOj+D2wXBb/LuRzDXx4uCzfIdDTLJtcbGxDKCoBDqf1LCdyLRq0dGqIDrqdUskTl48ds8jR87kvlAB2ulagLoV7oxdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmeKu/60K+kL43WU/5W+5FF7/1zpEg6N31AcmeZldf8=;
 b=X6jSrGMhslysk2v8S6dQWJHjttaZPvkj2bedSankuu1IBEKiMYb0X6+M4GSTB/4I8sd5c1KbHbQeFG8sdEpFYY2QSWQRTLyniiYNPnkBxGSw+GDEw6bGzWdtsthBY32rihZkCHXiU2HtNQhFR8OJskuHZN82Q3vsg9jO0cIgy54=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5831.namprd04.prod.outlook.com (2603:10b6:a03:10d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 18:36:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:36:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Thread-Topic: [RFC PATCH v5 0/4] add simple copy support
Thread-Index: AQHXByxPYjd3lKFugEyHev6iOAHEsg==
Date:   Tue, 13 Apr 2021 18:36:21 +0000
Message-ID: <BYAPR04MB4965A79071C8DC9DA9D49FC8864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
 <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
 <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
 <20210413182558.v2lynge6aleazgbv@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07d44658-af8d-42c8-1008-08d8feab094c
x-ms-traffictypediagnostic: BYAPR04MB5831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB583150F9937AF4B9E369E0CB864F9@BYAPR04MB5831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBr7pG6TnGVl6YdKYyIZ4BhOioPkmcuNaUz7klkiqHAYb54p8fwqXp0C2DKZA/vfdfvjcED4RDCzOwkbws+aMlhcWzcZWz4tIJxrJ6bux0J0QoPhughkFKwqB29ObDMaYMlVlx1Hz1aTSnYVMnjdxkA3Z91rA4a2AVgfPhfD8FnFFnJNGtcTxmbqfeI9wV2MvXeRYKBJTVCBbwQbIxSF4XquAsi/G7TMhG3h81r/MJrliUrqmrOgZrcnvE6zmWDWCY1nP0u4gndHsJtP+5Uh5KLCqFU5zEo27NIS1jIqYfaElNJtkT+6XzyU2Z986VY498TZgZculD59Pro+33EJIZ0KhBeFWIXEio5ONCaboOLfOCjEhE8nPuQ0/dzYfmCvtmcWHe6rqm0mPrfN1CKAU8FFaoRSPBkwKDLFLL3uo7x8zLO8ExiASy3NPNjZG9NbYqTSuJbvh49tTP6FzdrRbKUP/5upo5d38VySNtfOJtQfXyKoUPoERe6bY9UYh9m3Z4NVUrSkRM35naE6o+YusMErFIMkRel1S7F+KSTD2Yy218MxXpyH8jUC1+2bHHTFWQqG9VcnnDWLRfXuAoFvXPBN8Y9vSctXyrBL3WN2HPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(6506007)(7696005)(55016002)(53546011)(8676002)(8936002)(110136005)(33656002)(316002)(2906002)(478600001)(54906003)(71200400001)(26005)(66446008)(86362001)(52536014)(66946007)(76116006)(122000001)(9686003)(66476007)(5660300002)(4744005)(66556008)(186003)(64756008)(7416002)(4326008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?M5TpDuBSP8cM9nhAeCTpefAVq13+lWPJeQs8R5A+RbOAs5J0Tz0mr9AQ4L?=
 =?iso-8859-1?Q?F81EoaDFoMJdNNkr7ssJTSRljTk9SD6tWfO8ms+E/WdWbJQy3WzM6faSPc?=
 =?iso-8859-1?Q?M2y2e1b9W+6plqeaIXJQem9/DbBL9TswHAqGtox5ldaYLjIyOIF/O8KXgF?=
 =?iso-8859-1?Q?R540QX2pWui4cDA47CfnfbFNKnnooEnBg2yy8CuZUYaUFiUdwKo/BdLbFE?=
 =?iso-8859-1?Q?XKAfCT0cFXFDEaZXWNHuV/SVThjvzjxArFy72b4AadATx0lsgpnejAJ64e?=
 =?iso-8859-1?Q?h0AsUp3+UE5FUXZBMFAawHkuybQJAjSA69dvKhMlowJnDUcCuasEAFT0Ps?=
 =?iso-8859-1?Q?wK2eDhP5Jv+gzqVwgrc+IXxqG7hiU9l2FmXL2dnYbGzZd7hWGXPTdCRxNz?=
 =?iso-8859-1?Q?uDvvnjH5PgRrAARQUWefEZDvsKyLTsi928F/KUlH93Gliy2djrYLZJx8o1?=
 =?iso-8859-1?Q?kYmQRY4UDXj4zcye2r02r3up3DabvwQcD+rz8SIo9ePgysoIEnDk5p7Zi8?=
 =?iso-8859-1?Q?Pt3G4vGI4S7pkQ1HMWllSlMCf0aKvxNN7RBeoLvQVJKmImXb2VWBzLxMGm?=
 =?iso-8859-1?Q?RCnbBDJVu3YMkLvd+Hd28Zxrqti4Z7PC8/iBWU4FLzjwoHJaHsD5MVC65d?=
 =?iso-8859-1?Q?LP04d8MBTAk5Zhmie9KrErEAmz6vAhNQ+EhXlme77VK4Zhg0XCMZQYWOvJ?=
 =?iso-8859-1?Q?tO9cJXgvNbs/sndAum7e4h/WFvyWr5kr3vKBO7bbi6hkZKUZxSa/Jml9Kl?=
 =?iso-8859-1?Q?RDyWvl0IV74VlYi7bp+77X/Xi2ywtYVLTgJiVoMafoMNZa+DVMvkhzf2XK?=
 =?iso-8859-1?Q?D2/QW8B1KBFexCLMkJ1UOml/kwrcQaJ0mfUbBYIGz1Zlp67ieLxEKkNlTn?=
 =?iso-8859-1?Q?XCDw/iytrrGmOVS+pexg5U45EE92g4875iydhZiNY9XV0Da0RiyEdcBKJK?=
 =?iso-8859-1?Q?/rnymwfJ05VRU/n7AjlbNQG2BAmRRi5D7W8K8FHaCy6O1oeQ7iEGe/Eiq1?=
 =?iso-8859-1?Q?P/itxnsIuK+AiiAGaZRWwJtBDwp9pZJMl6jAfOexbhdDPsYvZOCJfhTj9f?=
 =?iso-8859-1?Q?ncI0WhXERQG2VgTC3XGfFzja+XQX2heEgSSIFgi0cG58XGUthi/61uNTMj?=
 =?iso-8859-1?Q?zfJP3i5xqUxAvzKdSrMbvzSXEVAhd/bcOdLTW6Nu9Z7uyqfodCpitW6TJO?=
 =?iso-8859-1?Q?leJq0Z53OUHjGFi1Sya501gAYWiC/eVj5uat+372iN7UTD/vvLw4mzl+05?=
 =?iso-8859-1?Q?oM4kRSg0NaIx2EkDarpl5heJou0cu4NvQ0mFr8ZPA5suqTWnR39pu0IweP?=
 =?iso-8859-1?Q?rpsAoi8yzEno7WbF8yrpSKp/Gg2W7fDhum/pfrNT7oRabJYx0HQJT6UXkl?=
 =?iso-8859-1?Q?A+6rdS8nq5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d44658-af8d-42c8-1008-08d8feab094c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 18:36:21.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQk3lW+pLtNEJaw5UIPu+n5AFE/A8oQRNwDjAjm6oHMAyu0LP9WmDOsb68NccbHEFTRPO9hMVwBDlSjMkOBsdMPgv/Qe81f99GpO9FE2oXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5831
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/13/21 11:26, Javier Gonz=E1lez wrote:=0A=
>>> I believe there is space for extensions to simple copy. But given the=
=0A=
>>> experience with XCOPY, I can imagine that changes will be incremental,=
=0A=
>>> based on very specific use cases.=0A=
>>>=0A=
>>> I think getting support upstream and bringing deployed cases is a very=
=0A=
>>> good start.=0A=
>> Copying data (files) within the controller/subsystem from ns_A to ns_B =
=0A=
>> using NVMf will reduce network BW and memory BW in the host server.=0A=
>>=0A=
>> This feature is well known and the use case is well known.=0A=
> Definitely.=0A=
>=0A=
=0A=
I've a working code for nvmet for simple copy, I'm waiting to resolve=0A=
the host interface for REQ_OP_COPY so I can post it with this series.=0A=
=0A=
Let me know if someone wants to collaborate offline on that.=0A=
=0A=
IMHO we first need to sort out the host side interface which is=0A=
a challenge for years and it is not that easy to get it right=0A=
based on the history.=0A=
=0A=
=0A=
