Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4F39AA68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFCStu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:49:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45594 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCStt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:49:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153IedF1080272;
        Thu, 3 Jun 2021 18:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=dhQ0lIlr3dofy1TAQaeyPGt9yFwPYd7dVQWibe9PQg0=;
 b=c479Ko87shHNE6ZWyR32+sS7+2fscBRNf2tiEO3fB4RcssnsLHMIvCS/Pek0/5tQnQqA
 +Qdx42RqLXu7+TnFraZOKPhKIS6y2LqDmGi5v8BA0UGFNCupXxTmfnSogr9Rh2Hyg9Rt
 ypXPhbOXXC3X3GR3sx5wCNJ3vqXdZ8FzxDPZaMmb9/QOUVOUBWMfL6tXEWPnHFyvWa46
 5GNy+ui5S/YLGDSnvqq48If8uVO7Z4caLJ+fOePQYivz/dMDAIWKLQoL6Lb2Hvy9A9hR
 3FokwcGH3GxNs9QxyxcyRZ3h/ZvvzD3zcjInut6FU/C0WhmcKEwMNyoik+Cz/k8jX+Au yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ue8pm5dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153Ie4k7082587;
        Thu, 3 Jun 2021 18:47:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 38uaqyhwqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyMK7KWLsKoEyxj8zk8ixSaibnP1hYeiwvRq6cynkwUScCqNYnWd3Juyx+NQHBOi4akk0vWiuAzS6ZiSFhNU5YLvPdL2TLh1P0j0zmEgoezwrB83yC9soPlwbIT2OxMi7SxAAB9nPnptD5SIRb3Gnj+eOiEZ9uT0hQBhtIFcgpZHJW8KaF+J9zXHsZLLOJod2wUXGdWlvTo1GE1ByCJmKZ1gB1Lgez6F1L1A8plHCgyrbovdcug2j7BaNUwMjS3cqi7gmAfDaqMqqZtDlXBwx7SBHi9nLtWRSlmOxyf+fG0Osgp5FRDQh5GbZe+c+Wj0fIBbEg6XJL8d0S3mBCfhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhQ0lIlr3dofy1TAQaeyPGt9yFwPYd7dVQWibe9PQg0=;
 b=ib/BqQZib84xZs0kY3NkN4BXlGOH/XWuIrHFCYPOyvW5WlLKv2/w92wTKUhyd2kLAkZQgN10LFsxhPPNOhS+j9GlX6KULv/bQ8G064ZCymIhfSDBicmoj45qjFYZTaCpBgfXPC23fYO1EdsNfOntOeibsXQ/tPmoZz44yPU2/fLAEvAJepm9jiWwUXVJTSjAeMgyF8ZRi+RPyX3judBLUVvBmyLnD+IKWLNJYh9LU69HQHXCdYQuCqCn/baApINDYijBcZcH4jwoHwQwbx5u9InWn0FcFzBoEKdRLRYrO/Fzqq9Wqm3C7WYiJ/yo+V1cFGU/jGDfHHSQaOB9L/JFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhQ0lIlr3dofy1TAQaeyPGt9yFwPYd7dVQWibe9PQg0=;
 b=cRWmL9E+MpA58xZ920SiUymVHKuo5Itl6u7DJsW+0KmkKYW8avC/rQvHYSNpOFg3n7dGgKTuLIzGXjqykldZH6WkX2KzlzndIwUX96PZtu52WnCql/ifY2EQmrxF/yHjUyNCwzz9UtmK4qek+wY6QKuMAyCg7jfVYNYAR44T7kA=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR1001MB2092.namprd10.prod.outlook.com (2603:10b6:4:36::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 18:47:45 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::b8b4:5900:668b:c9c2]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::b8b4:5900:668b:c9c2%5]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 18:47:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 0/4] radix tree test framework additions
Thread-Topic: [PATCH v2 0/4] radix tree test framework additions
Thread-Index: AQHXWKjwsRmV9s2P8Eyzd9mpuwBWhQ==
Date:   Thu, 3 Jun 2021 18:47:44 +0000
Message-ID: <20210603184729.3893455-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5dd387-f0a7-4fa5-40bf-08d926c0135d
x-ms-traffictypediagnostic: DM5PR1001MB2092:
x-microsoft-antispam-prvs: <DM5PR1001MB209271F8245A6DDD70F8B14DFD3C9@DM5PR1001MB2092.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3N1rd9VmfgBi3QQXttbtpav9JLLZxOUoilBG0uOtaMbES8riSnmeX7n67c2Rq4Gh8g0TGiRTyZnlHxMgTvWBtMqnM7xQ4zFG4yKa35RCOEFoQn/x0aTbuAghcDucPy8YoTw+LqZmes5awRkShaCNhRHLQwG9+NVxQVEsKVHHSirPrmWFY4MBQT2ZCeqDy5pmneu2kQehpZajO6VOfYFFxF/9BLpLG8BCqapyUWSLHWKAIWh+8JIx1TuwoXlAB8cNChmtNLKq2Z9sSFdIRDWNseWmhf3U1rWsLpvRLUDJDetZSr1f1irqkWNNGp7p2Bux27HRHxy8PRmELUwaf1jsXpb961xPdybCT5F59IZQpMyR7ITD5aeF2Cj931kXxl+RnjMrBqKelJ55KV12s9Ne8Y/LVl8eKC14pKyLDG1xXi9tIr66Qw495Q4+GhtWtRl/GY3r4OfGG+w7VCf/nwNr3MAm5NQb8wvyRCO2m1tZEIY+CywYY5+Di3QUmO5+dFURiRbtGTisempHatd+VjPai+fcDBwCOQcJavgrDmjbVBG+rf7eOgvh1eKIA4JSmMeb4UKWLv9q3MXDfahad092373CEMxXXTm8WO4RoVSDycQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(64756008)(66446008)(478600001)(91956017)(76116006)(8676002)(66476007)(66556008)(66946007)(86362001)(5660300002)(44832011)(6506007)(110136005)(8936002)(2906002)(6486002)(6512007)(2616005)(316002)(1076003)(36756003)(71200400001)(122000001)(38100700002)(26005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?D+W0clvpDJYrQ8MdoyYM4zse8DwTf7foVWckyH/dA+cFoSGZ5+EAf5ywvt?=
 =?iso-8859-1?Q?Ch40pmDppKW0qPgWEfLh+/hWVPyo5t3a+t5K2comPyopuwhEWqNUMJntvj?=
 =?iso-8859-1?Q?d/ttZPGO+1KcSkRmB5sWlBAeOKi9z4tYqWFwl7/PShPMy8Uko3sbVNyVBY?=
 =?iso-8859-1?Q?eBFuqPcJCFNkxURGY1dF4uwFernFQxgyzV5++/SeZSaLEF9g8HhWeO102b?=
 =?iso-8859-1?Q?T92jI0U/6fdEVXneSXCvQ/CrkTuhriQs8Cs07xi59yez9JQ02dYuxv0GdY?=
 =?iso-8859-1?Q?DIghgIKdYNTa88keS/rT8R3YDVZMUaTKlN8YljH4smWdoJ+5hWk6lOFc9F?=
 =?iso-8859-1?Q?k2jDZb6ze0YKnleCm/7jLmnGCNDTpVPFZXzj9IZQc1yZYelvbFGnpIWoTY?=
 =?iso-8859-1?Q?cRlsBbFkFQGGKKwYW9XowkCcoliFjzUL/TmIAn4/hsu97hclkSAqPHddMX?=
 =?iso-8859-1?Q?DbbpCPcFUYaXbVx6HTSDrNgoScD3DEISfCpxF6SM9gOynlxTh029piqVdv?=
 =?iso-8859-1?Q?NADJA8POwZG2GRppfL+BJnenHs0QesU8XyxZ2qq6wdhG0adYmBhGkHJruS?=
 =?iso-8859-1?Q?eIrsT6+1xUcHj/qUK+6LYVcbI588StLtr2G3Gc2mETpaRJzsUA9LQiMklB?=
 =?iso-8859-1?Q?pZELPv3fQF6nNimlEej7NlCGn9xHMuIbBOveObIEfstmOu/KEB7wgvdZ7z?=
 =?iso-8859-1?Q?KY5Fbs0Hd9PN5mu38emcz/3XbL2mr1nFyiX98kX28Vg6EWCTU8ode1n8s3?=
 =?iso-8859-1?Q?7EXS90z2W1fwwro/gcZITfKMRDEohzg85Q2/fse/PNR5U4vK5/jmvkKeFz?=
 =?iso-8859-1?Q?gaE92quWdJ/QngLEPKiiT5z8FyvM+FwqdlUAh+r+iT5jN20hRdg5LosFoB?=
 =?iso-8859-1?Q?46AInmaOMxc3Ij8tK/aZUGcWICRjOusny52sWiBZu9lfZKktzRhjEjbHjC?=
 =?iso-8859-1?Q?jpch+5PcDy58U58iWNuSA0pCDXTZ+u5/pOR0sKiFhZwlJEtMkxrxMAm7ew?=
 =?iso-8859-1?Q?rDY4I6OSEqYHLaeq5f8bssiXkqZkLJ5rIe2Wqe93LkCOO97HyenfQtN9Pm?=
 =?iso-8859-1?Q?+bYVzgeZRJExoIHkaokRllHc1zIDcI+yOUHz1pB0e9jrBrgEFkOWIi7nvn?=
 =?iso-8859-1?Q?rupI/kDG1nVLtj+2y4w3kA6PfaKBqZOd4/AK7VaEVFqvJ/tg7mMjHGciDN?=
 =?iso-8859-1?Q?dFu/qi25pDG5JiC83jPkLQ3p210OP/JgmRODF/iY9p4XMfDUK07OR928Es?=
 =?iso-8859-1?Q?xN/t1re1/LuWzL1IksbOyIQEBPRMNsCjC1gI9m+RVeYeEDSeNyOl0YApdU?=
 =?iso-8859-1?Q?HMCdLrHIRXMH9GvKIl9goa6h845c+pSYyLZmuHdsS0u/ySl2azZSjE2t1X?=
 =?iso-8859-1?Q?+AQ40eg7fV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5dd387-f0a7-4fa5-40bf-08d926c0135d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 18:47:44.9677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oly2o4H+2pSsZYS6mE5SDEGx32gVVVCy7+bUSrXn/K5NgUB2Yzn1uYq0uNwcAHN/nzQC3ASQTKowjn5ok4xqlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030126
X-Proofpoint-GUID: Fb_odJO8i3veYJEGNVepVe4vu1RvcxD6
X-Proofpoint-ORIG-GUID: Fb_odJO8i3veYJEGNVepVe4vu1RvcxD6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increase the functionality to the radix tree test framework for use by
the lib/test_maple_tree.c

These patches were first presented as part of the maple tree patch set.
Changes since the maple tree patch set:
 - Both bulk APIs are now in the same patch
 - Relocated nr_tallocated from maple tree patch

Changes from v1:
 - Dropped two unnecessary patches - Thanks Matthew Wilcox
 - Separate pr_err and kmem_cache_set_non_kernel() into their own
   patches as suggested by Suren Baghdasaryan
 - Change allocation counts to be per struct kmem_cache - Thanks Suren
   Baghdasaryan
 - Fix slab bulk API issue when not aligned - Thanks Suren Baghdasaryan
 - Added a test for the bulk API

Liam R. Howlett (4):
  radix tree test suite: Add pr_err define
  radix tree test suite: Add kmem_cache_set_non_kernel()
  radix tree test suite: Add allocation counts and size to kmem_cache
  radix tree test suite: Add support for slab bulk APIs

 tools/testing/radix-tree/linux.c        | 160 +++++++++++++++++++++++-
 tools/testing/radix-tree/linux/kernel.h |   1 +
 tools/testing/radix-tree/linux/slab.h   |   4 +
 3 files changed, 161 insertions(+), 4 deletions(-)

--=20
2.30.2
