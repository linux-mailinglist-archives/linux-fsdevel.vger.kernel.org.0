Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE474D54B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 19:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfFTRdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 13:33:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfFTRdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:33:35 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KHKJdF001684;
        Thu, 20 Jun 2019 10:33:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9JrVJbdBfSF0MhohJVF60W/ryo3IXTB4Ol2A9ONoUaQ=;
 b=eWN2uOwtmbGhWQuYPGeSGgfyZjqRc4PagrJuvUHPrKdOG/G5PtH5uwIov4CWN93N8DPc
 Inilz5WJOL8MUD+ru3aK2b4P8Na0z1cX4CfehW07AvCB9OjeGhOAgkC8qCF0UVHGC4UO
 e1ZVh888AfLMcLB1mG0HOrLkzRm7vSmAUWU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t7ur9kpdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 10:33:29 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 10:33:28 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 20 Jun 2019 10:33:28 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Jun 2019 10:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JrVJbdBfSF0MhohJVF60W/ryo3IXTB4Ol2A9ONoUaQ=;
 b=onYFGFx/7QVExFlIXIoPqqq21GDz6DZzvMi8jkQ4JoZzS9Gap9kg3hL8gh+GRpscuR9MtbXFZqoNjPZGxY2Uevx73X+e5KcY58K0/V+usQPWVgDqS+A9kY9qEGkWJTCRCGXI8o4pTDaU36v7DGtRbe8AHlAjJM0eiea0Q8pSOrY=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.60.19) by
 BYAPR15MB2407.namprd15.prod.outlook.com (52.135.198.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Thu, 20 Jun 2019 17:33:26 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2569:19ec:512f:fda9]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2569:19ec:512f:fda9%5]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 17:33:26 +0000
From:   Rik van Riel <riel@fb.com>
To:     Song Liu <songliubraving@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v4 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVJ43LQE1pNmPhcUCBRrcpB6GfjqakzWUA
Date:   Thu, 20 Jun 2019 17:33:25 +0000
Message-ID: <b9db545fdb5058831e48504ea4e4e0bcaaf36ff3.camel@fb.com>
References: <20190620172752.3300742-1-songliubraving@fb.com>
         <20190620172752.3300742-6-songliubraving@fb.com>
In-Reply-To: <20190620172752.3300742-6-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:301:14::14) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:112::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:f51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8eefe25-41ed-4e81-5540-08d6f5a5666f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2407;
x-ms-traffictypediagnostic: BYAPR15MB2407:
x-microsoft-antispam-prvs: <BYAPR15MB2407D484950AD78D3C1F7C80A3E40@BYAPR15MB2407.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(366004)(376002)(189003)(199004)(229853002)(118296001)(5660300002)(4326008)(68736007)(102836004)(4744005)(2906002)(71190400001)(11346002)(486006)(46003)(110136005)(73956011)(36756003)(2201001)(478600001)(66446008)(71200400001)(99286004)(186003)(6486002)(8676002)(66556008)(54906003)(66946007)(2501003)(66476007)(6512007)(316002)(81166006)(6436002)(64756008)(6506007)(86362001)(446003)(81156014)(76176011)(25786009)(52116002)(476003)(256004)(6116002)(2616005)(6246003)(8936002)(14454004)(7736002)(53936002)(305945005)(386003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2407;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /+JabLX0YE+oHbwXeCcgcSqMrYosKOPj8L6QXcH0cnqIEmpbObaq1097E7kQ6xze+LkRUnq76e7UQHO1nG1AoNgyhXG/trhnf57C4AwfRU/cGYNzk/5on2KAOHh5XLAolasq556g7f/yQCOB01eNKGgUeQJI9O1+cUAtVTDeg6IyKC+FIEFCq5ulJSZp0vef3+t6n+1HzKojebkfU6HSCLuxGziLO6smyy8ysIXQERCcLF6t0ZHI0gzXelnMFZRXSRldPpe7d/t/BUuovbScvx6HUACzVIf3boLtx9sEC0H7eEGaUym0xzSH//ZvVTMGDPphVa/Fhltzxh0qcNItgGmy4JSahxwuhLofEeWrBd3xbFOPK7SoJKXy0bXNTdt9WpEMhgOHusKQmvv4jlg20d8bl92iK2G95ni25GmGgck=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F260CBB187980D40AF5582D9C124341D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eefe25-41ed-4e81-5540-08d6f5a5666f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 17:33:26.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riel@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200124
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDE5LTA2LTIwIGF0IDEwOjI3IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gVGhp
cyBwYXRjaCBpcyAoaG9wZWZ1bGx5KSB0aGUgZmlyc3Qgc3RlcCB0byBlbmFibGUgVEhQIGZvciBu
b24tc2htZW0NCj4gZmlsZXN5c3RlbXMuDQo+IA0KPiBUaGlzIHBhdGNoIGVuYWJsZXMgYW4gYXBw
bGljYXRpb24gdG8gcHV0IHBhcnQgb2YgaXRzIHRleHQgc2VjdGlvbnMgdG8NCj4gVEhQDQo+IHZp
YSBtYWR2aXNlLCBmb3IgZXhhbXBsZToNCj4gDQo+ICAgICBtYWR2aXNlKCh2b2lkICopMHg2MDAw
MDAsIDB4MjAwMDAwLCBNQURWX0hVR0VQQUdFKTsNCj4gDQo+IFdlIHRyaWVkIHRvIHJldXNlIHRo
ZSBsb2dpYyBmb3IgVEhQIG9uIHRtcGZzLg0KPiANCj4gQ3VycmVudGx5LCB3cml0ZSBpcyBub3Qg
c3VwcG9ydGVkIGZvciBub24tc2htZW0gVEhQLiBraHVnZXBhZ2VkIHdpbGwNCj4gb25seQ0KPiBw
cm9jZXNzIHZtYSB3aXRoIFZNX0RFTllXUklURS4gVGhlIG5leHQgcGF0Y2ggd2lsbCBoYW5kbGUg
d3JpdGVzLA0KPiB3aGljaA0KPiB3b3VsZCBvbmx5IGhhcHBlbiB3aGVuIHRoZSB2bWEgd2l0aCBW
TV9ERU5ZV1JJVEUgaXMgdW5tYXBwZWQuDQo+IA0KPiBBbiBFWFBFUklNRU5UQUwgY29uZmlnLCBS
RUFEX09OTFlfVEhQX0ZPUl9GUywgaXMgYWRkZWQgdG8gZ2F0ZSB0aGlzDQo+IGZlYXR1cmUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPg0KDQpB
Y2tlZC1ieTogUmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KDQooSSBzdXBwb3NlIEkg
c2hvdWxkIGhhdmUgc2VudCB0aGlzIG91dCBsYXN0IG5pZ2h0LA0Kd2hpbGUgSSB3YXMgcG9zdGlu
ZyBxdWVzdGlvbnMgYWJvdXQgcGF0Y2ggNikNCg0K
