Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4910C397C72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 00:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhFAWcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 18:32:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54718 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhFAWcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:32:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151MPt8t024829;
        Tue, 1 Jun 2021 22:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2020-01-29;
 bh=NymrcAKG6iAl+MYRgokq6NRR8JzK17uZduRryGdWJuk=;
 b=MKtXZHIL9yAMi3W2It+ZxW3TQUwpvGz2viRTqOVopjC9vAFQMQD3bGeuT05cdiDK19Yz
 nzVN9TKg9SvHs+Ca6ULwHospj5hBfcfHG1msiow4CzQaSNVcnHdWQoyQfwy/ZTgrKhY9
 QK/EskgHSagnXL0L5pWdp4hVw3tkafksMclICt9ldClLJZaFHFazQ8f8hSOFM3ttyb8e
 YpwDRKf1kT3TWH8sm40ReHOj7uwzAdHD+ismGQwGrSS8MAokMS3yc4E43dJ9pkDQBUm2
 i0WDGfvdBjuAxe9xwiN9AICZ2XV0ba7KN9ucHZrU/qpHNXmHPwnZLX4e8Bg2eml8FJWX Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38ub4cpxhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 22:30:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151MOeng179524;
        Tue, 1 Jun 2021 22:30:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 38ubndj3tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 22:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQopm6ABwT+emNcbdxhBzVSUg0k3pIgMuZnugKY7pYrQ8hvEFYgyc90o8H/vipQXYooDB1CLFIg4o+tzRF5ab4jVJhT2yMgET476ZM6b35HPwaAbq/OiXhk3NBz1Cp+ZthImumK0vZH1sVoHd3/iTc5MHZGlTevqivf9POZO1OVwDCzWoelAi+NQvH/vd8Bs8SQwYHm+ZloEwQWJtt8gp5m97q+YTzf1Gjz2rvBpCm3HXW3HRP6ngH66/Zrvry/y5Nf45ZXhzmZJEVy3bhrzHAndqhYu01GNRft98jjEfpUUj4St9fD0/5kytf/tymtbwMlEAqDS0jp0U5FlScjW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NymrcAKG6iAl+MYRgokq6NRR8JzK17uZduRryGdWJuk=;
 b=AetH8voBCgShcVhUcrF3DKFu2c9GvvfvDv8FIuijNy7Om6jzdotZHibgoE+FVAS+Pc6l8N+f8Yu5g+qvywS1ik6q2oxGOUMVBA/Lm9F9b8U6jSvzQ830YJHZxOFP9i8/DG5zJovVOj9N/WHwjqNezkfSpP/3eY1856NhX6+Zf0vYBAT2TCo+Ugzpu37KR1A3CVuZk6JVliYGjaSBrbqJEqT0nfvifqBiSAmWURWOcBscgOBSWmxRb79/gkUYoFPd4p6xbv3wXwl6k3enRxNogZuOWgZ+CwVUqFv1ZK8rgdm+xKZrUYxCD0cgoJ43mJ/rqJXtk/uBy7oJDOLByPhX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NymrcAKG6iAl+MYRgokq6NRR8JzK17uZduRryGdWJuk=;
 b=mEjJsyBVXmSfuIrx0SMsllKyv0aOwqugu22Alag5N0wqna82tGOcy8/SH5aSg1K73rfBONKW42viX0hWY2eZwznSk7+uGWTbFKy9yWbVt+fOXJc+/mINIMY/h5ePCtndSbBpaKJeg5GFj3+rXCyhfmBW4NeQhr5Ggn9VHXcszss=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1646.namprd10.prod.outlook.com (2603:10b6:301:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 22:30:18 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 22:30:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] The Maple Tree
Thread-Topic: [LSF/MM/BPF TOPIC] The Maple Tree
Thread-Index: AQHXVzWzgsZ52rnPcU6fkaFpcp7ZKg==
Date:   Tue, 1 Jun 2021 22:30:18 +0000
Message-ID: <20210601223007.pvrns2kqqzuomdlm@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 366c170d-a0fd-43cb-cab4-08d9254cd5ff
x-ms-traffictypediagnostic: MWHPR10MB1646:
x-microsoft-antispam-prvs: <MWHPR10MB1646D4C1319A751355E99EC2FD3E9@MWHPR10MB1646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: puQqDZ33pJja5eOglHHwzgLRByw9UO/xcvBvjgtJQqwMlUwqehWF3Xz1VsosURHpGYrJKsJG/P1Ov1C8v4Xs9IZ9TEdfuKVNOqOKkUXFJSpwQJx0yfigRxET3JfSvl5ajp/7xiK9L4dd7SpTGwc9Wa4EbrsIBveuTUvk2448NbSaIoTKxnAJz1ntJPX/RHdU1Vw+i2ig3wl14Y6vbTH+XB8SGl7PjmQcNf2jSU5ZT4jAO5GXUDOzyequU3kHIPUrSA0cRuXuu/oKR25AHAYntv3nexw9xbij57goM1javjjGbJMRqL+yTXEwN45tjwuCM9G4DagZOuFTOfxTNu9xA9XrRPmPVi/O7tc2MaOj0mcjtFl6Em/EGfyxmMQmNJ3zV11JbDAN/2XfEcek72C58pYQRVpLi+/zqYZPiiZay/Oe9Vatsxt9AjXB9DLqwAfiiW0H07vAMh+n7L0qvk+aCov533dqqdsoojfWs89wmkKrTZjEx6HWQQseL0JpVYRM+nzP8iPztV1hg9zTyGUGaCN2zfE+aSAseWx4j2Cief0A8He7svZtRQ3wct8BpDjiXYWFjmWJyxZsxcw6eVmr5EnbJFZT65bP/Z78eFQhaUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(6486002)(91956017)(8676002)(2906002)(76116006)(122000001)(38100700002)(66946007)(83380400001)(5660300002)(66476007)(64756008)(66556008)(71200400001)(8936002)(66446008)(478600001)(1076003)(9686003)(44832011)(186003)(6506007)(86362001)(110136005)(33716001)(26005)(316002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e6+HhHdtfQc87dAam1CzS+wHHru+leElThOPqrPsDBjbBjjOXfffCG5soT0d?=
 =?us-ascii?Q?5tgp4uDNzhc+3XgHfG4pcTNlrJ1U9FIeSgAD5u/zXOX5u+LelAEEW25IiqqN?=
 =?us-ascii?Q?qtSBFXYYnYhuZmTaT2Y/qYpmTAZUTMnp0+oAmmB4Zvb4la3P5qh89JEYwrk4?=
 =?us-ascii?Q?ZXAUZuRuFxOHO1fA3P8NFv4LE/Jn+soH+qbv/lXHnc8Rv7vyCUq3PT92Juv2?=
 =?us-ascii?Q?g3EqudYyAEslJnDfK+gyYmT+ac9TvkQJnCuAsm45UtIZlrXiTvoSNh/Ltv93?=
 =?us-ascii?Q?iaQxIyzQbE1wXWmVrST0XFYivV6FhHy2fF19qoDd8MzLGjwpqn9VAUaLmAHX?=
 =?us-ascii?Q?b+anqFTSFY0xNujarHJz/uPZhexu8sxbiO0RURUkYL58DUKv0R2PwfFwCmdm?=
 =?us-ascii?Q?SZjBxLu80wgjIrdMR3bVEd/AljF6I/enYvWDY+GeECMPlI0WgvmLPNEc/ent?=
 =?us-ascii?Q?BaSC+ZsyyCCH45A9zBSa8bAPqGGVsaYjLgfep4PKfoEVKSU3UA7jK4lNcTfb?=
 =?us-ascii?Q?4AU83NV9eSxoUWbAEMC9C2R9nUNfY3d49wMxw0eC4d+MR545U+jkcaQxv7P8?=
 =?us-ascii?Q?PM/EfXjU8manQ9N/Xf+vzFnNsPCmjfKxywGmp16sLB9GjyhYlE1iALPbmto8?=
 =?us-ascii?Q?I+YVdC8FlIUs8RrzRAk7e0s2rE6+xqYs0p6Ifsznz+KN2v56mfQdgBxTcKoX?=
 =?us-ascii?Q?qEpFgroH+C/mzZAxlfOqCo6bnnqOipkEEbvNloDNiTDrOdP+coNf9CQzPhpE?=
 =?us-ascii?Q?uxQPiagP/O69OM6ItAQek4JCTEIKO4O6tT+gjgGbRVB2l3CrsvbQ84T0Q1xt?=
 =?us-ascii?Q?KBSqjKA4aWeSKuarSJLN+6CXUkupwb8X79rJNCJKCe0Ro+H4olfe8SlykgJ9?=
 =?us-ascii?Q?mLm2mjF0Ca6csa9Q/4Cpv4vIArLft4ihbwR2SEk5rzSS1+MGN/7N/eiVH2Df?=
 =?us-ascii?Q?zE/TLL33BwqY0nK3NFoImSOZymD1sU+Gk/x2yoysjjXCbV8rnaA1I6v7+oH3?=
 =?us-ascii?Q?a4VtvlQiTx7EPv4KFLJRQaZP8mT6t6VOoGpDRlSpmwKFgAKtyiDWYkdm1ELk?=
 =?us-ascii?Q?lPuVPUE9rdwagTMJ/SzxUfeo8RFUzdcKHaYJI69jnn9Rxr9mtZoTernFP1x9?=
 =?us-ascii?Q?FLoiT2BDGceCaw2YP4mHIdex46x2aLsT/I1aVeHyh4LIlcxsBQA5ps96oNGY?=
 =?us-ascii?Q?mS1YglXg/u3pY15i7R9Wi9qPdItEShygs4SvSUHNQv6BfOdfjJgpS5G1RsRJ?=
 =?us-ascii?Q?URLI5WWwGyLgUeOCpd3AJaKWOxgUlHox5Pm1cURZEA0psfbPs5auhwNDeqM9?=
 =?us-ascii?Q?NO0z9aYx3ALyMai1b4t6kwvw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4A0840C6493F54C9DB16D0F51372A00@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366c170d-a0fd-43cb-cab4-08d9254cd5ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 22:30:18.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuHDxQA9oy6jjue25fpDOD+PZCXLPWTkdD2wfvXGJjkNT79UmlSlyGCdqjwbNoV5IvJJ40yH9Q9xs1i+6rpWlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1646
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=443 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010149
X-Proofpoint-GUID: L21lAyHEs8oShjf5M-86OFa9mJYPbsCR
X-Proofpoint-ORIG-GUID: L21lAyHEs8oShjf5M-86OFa9mJYPbsCR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=747 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Over the years, the tracking of VMAs has slowly gathered more refinement
with added complexity.  Currently each MM has a linked list, a tree, and
a cache to track a list of ranges. The current patch set adding the
maple tree replaces all three of these data structures and is just as
fast or faster - even without modifying the locking.  As more of the MM
code is optimized to use the tree, the locking can be extracted and the
RCU benefits will begin to show.

The maple tree is a RCU safe range based B-tree.  Many of the rules of a
B-tree are kept such as each leaf being at the same height and being
self-balancing.  There are also fundamental differences such as how to
handle an insert operation that may cause one entry to become three or
several entries to disappear all together.

I'd like to discuss how to use the maple tree efficiently in complicated
scenarios such as those arising in the vma_adjust() scenarios. Also on
the table is the possibility of a range-based b-tree for the file
systems as it would seem to work well for file based scenarios.  If
people are interested, I can also dive into how the internals of the
tree operate.


Thank you,
Liam=
