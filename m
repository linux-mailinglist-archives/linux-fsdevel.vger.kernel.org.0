Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED0F39AA6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFCStw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 14:49:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45248 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFCStu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:49:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153Ideso017750;
        Thu, 3 Jun 2021 18:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=uTvHh3QePqT3lON9ZCLobivunOtWUqzjnj6GD2sqD7M=;
 b=KCCROJ28OekiCwAU0BUBDq6RaKIVySFRFonwhF6/ICY/hocbSQADBsCgt++WAwqlMPnn
 czLfG2eD0txVDAzpXbtJzrBjOk5SIlKAtDn0Y/kG+g5lv0nqYORNOQJwMDOgSmKXlyV8
 fuoHN2WE8Vxy7wzmVCLID2LctFsfvYpgv3ym5diHs1ddYFoSa6wtJlTncsY0yUnA6L0Z
 VF59mswJu3HmrFIXGdx9LQHFETuXIMsgyjrpfgQOPKjPQdriM917ccfqhyR/uBDCLKNS
 d/8yH+GhzNMgnt/vcFGGJ2vcQsmBoK98Jk6jtRPBNO/AaDxvYDfP5rbwVHv2PoeT2Srn AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38ub4cv7y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153IemGc195728;
        Thu, 3 Jun 2021 18:47:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 38x1be5g01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 18:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Deqz66XsVXV7mXJc8PSfgXWV9isVMo4lrYjEuqMuD+EUUPi+MHCIYNT+j9X+V9sZorflmh7Nq4E3wcMgl/O8HCWFDYGOMLBpDukEY0Kh2u5TIKq/9JQz4LFAk1yfro/usyo8lu1DE5fdzqAbv9SedkrA41RrrtgOjzr6SaYKQFdHmu/aT0qqDpsJ099qQ3myLtmG2A1jLQMZ8/yM2+YaFEgn9j3yU6SIk5j6r8JEv6KtUCs4g9e2sevHah0aCN51irzi2mM/9Jb5/ipsQA4i459wETCezYN67jeYrqnQMgXcY0iaGC4dIB5cXX1Sek6uYdWPmDoUnBFGfqiigLruVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTvHh3QePqT3lON9ZCLobivunOtWUqzjnj6GD2sqD7M=;
 b=RDxvHIBNmddJGhx1KGjNvp51vGT8x30cHI1bSKXLX2ROu4/gZHHxWvGOqW3RKdyM8Bwg+OMPwVdztt+H/7LP98xRqm/FKeT4AlDhwHbSGIQLlDXhIz3J3QLH9vi1FvNLkaf/vKj5dyUoG31P048v7fu/jP3+ciYd4RCdCttzHl15fzUQrWSTvmlRu+7fTGTGCUNCXUonwKgxN7ZnNIPrToXdebTY8bGsg4RMM1iFuGAzEG/2dYdKMHcJaFltaC3qjd35LBdN7iKl+bjkls6Sh3XAaZ5oZf+ows/mNEZjJj5hDqt4HwCAcutwnOGt6uscDTrqK+8OXSdgvum+h49TcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTvHh3QePqT3lON9ZCLobivunOtWUqzjnj6GD2sqD7M=;
 b=wR0P0Qn4DWFtWwVco7VZlVmUmqLOKL0OdQ189WOTJgz/GDWbjENC75rY0AE8fXNQCRA3bdYORvRKKzpQJKFiCM00cYowG+wK5c9mPwNuxqjMMhQSyQrBngo3dB6DS1119uwq6F9UO7jMkbRf0Ywy3izpjmstRZ0S3Me/px6RxG4=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3340.namprd10.prod.outlook.com (2603:10b6:5:1aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
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
Subject: [PATCH v2 1/4] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v2 1/4] radix tree test suite: Add pr_err define
Thread-Index: AQHXWKjxibRAqzb/zU64Ev7/GARb9g==
Date:   Thu, 3 Jun 2021 18:47:45 +0000
Message-ID: <20210603184729.3893455-2-Liam.Howlett@Oracle.com>
References: <20210603184729.3893455-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210603184729.3893455-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83681bc-d62d-41cf-3d39-08d926c0139b
x-ms-traffictypediagnostic: DM6PR10MB3340:
x-microsoft-antispam-prvs: <DM6PR10MB3340FA71F61BF6052A2052CEFD3C9@DM6PR10MB3340.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 68wxkuPK/0Tu6E/tV4bR7TOTllQTwFTPRVcuGkirBL3P0PWZK2bW/XC8xXWfrkiVsxygPyDm007dursBxbtAx01vY7mevLy+vEOs+FWKxTNlQ5FoQemdNlF/lyeWQkTtNkBjuN1xroZ4jS2l0oS0yglR2TTSN3miL07bA4gD6bW5kFgT41OPBg7E8lITBNYrFuruHKJJ1wZbT2KWgThNLfk+at496zbMJCYpDcsXYxkIULZzUaSfqyi2b0gta3MehjtqZxn9HaO6GuIr3L4BRPJMy2dEu046+ysS9SeLJmWybyIHvfseFm4ffOpOG26106KmQ9EsTakskdy3qTjC7D2JsWjgYueCeaUnKOEHStWwuegiVxwWQk++zauGKPgyhWeGQmBs62MWTyXFGqsbVWBoXKdBeuE93zHbN9xxLX6Rd48xwI+NwuakS/gMrb3uxGyQx2uuNKwR6l/PDc26krSqIQwanvYzAXXHPeGEqYYrtM+8Vsbzqezlyv+vVRCk9gpNoySNqqNzkLCFwlwy+ztNVdNneraME+M7rVtUoP8T5nEYJMQWx4QCZzeZ7+xHbg9f7FqUZJaaOA7Dx8BPJakOQZf+XS+XwoPBsk8Cbwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(478600001)(71200400001)(66476007)(122000001)(66446008)(64756008)(66556008)(91956017)(66946007)(76116006)(38100700002)(44832011)(4326008)(1076003)(2616005)(8936002)(4744005)(26005)(6512007)(6486002)(8676002)(5660300002)(186003)(6506007)(110136005)(316002)(36756003)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bQrRy3Oq2/83QOJJzDrPlgola7nvAnYvISMllKKcoh1bWFUHIVdigz/42r?=
 =?iso-8859-1?Q?LGT4qElRR7vfnekYBR46itdSBHaNXxaYdMR29z3Nmys6/bX2s54IHISF2/?=
 =?iso-8859-1?Q?Ct6w4aLmyhY/BByvNPsTc1VQGM13wBm3hrnQ6JI0SDyUUFziPc2HCVSq5u?=
 =?iso-8859-1?Q?7J6DUdTxTJxiaNBWm65f1f1wBROafuF/hF8XB1qcdUpvWeFUNcsbZSBEZc?=
 =?iso-8859-1?Q?BsZlJ4N5mmTMsucXxj2Pc06WfB2A/6IgZio59jK/5DYzeh+NyVscZwHkrO?=
 =?iso-8859-1?Q?avBmpCxdRWFtE1Uf51mYkM/nVkkyacLKwrQFPgpdCKnj3eocP9WcCYsT41?=
 =?iso-8859-1?Q?9ElW4p3TrfR+MocnIXV4yqUYLFLcx+49teYuhn3WvxPfYwKV8xNCf1nKGy?=
 =?iso-8859-1?Q?j4z1nDgUzn0gxQH/CYPRpAt2EbJRLAZZT6dXUwqE+1Xp48znGLkM3V1B7V?=
 =?iso-8859-1?Q?L/nft0IRj+hGd04TJSvCJgJXDzgWmJRrH68C+7Q7fgqN0CK3L4dskKehyR?=
 =?iso-8859-1?Q?ntwRtzRNxkwM7X6FGMjZuYRQdZwpp1vSo8Q2tWrVrwxG3KH1c9rHWONmUb?=
 =?iso-8859-1?Q?BCaBBVi4PzWB8lTjZc8dk8DFtktWj/UcYq5lw09DdMSJaknn+zJwzqS2ZC?=
 =?iso-8859-1?Q?sc/5HwM40VHrDvmbsJnZ3WH/JGQkJmzTe8zNwiearvXUnZSD9n/c0C+Nag?=
 =?iso-8859-1?Q?M/ickCyxNpWFdgdxYAxCGoGnezKlcgVrXvzfyTsqbnhD1lvRJE3DjEwn+u?=
 =?iso-8859-1?Q?Kypw3EixuIigJhqui/5EB3ilxeL98dn2rtjSfj9V3J32AXAx9wUHW+fy1X?=
 =?iso-8859-1?Q?Fkooi0hbDdSL5aSTXi7/FR7gCRAUq+zdmXSn8M9qSLNhfPk8YEOYJF4A83?=
 =?iso-8859-1?Q?bU0YwClUDTyKij6kOJ2stOBjbVh+jAS1nD4zMPPGKUTjheppjU5jriDNw3?=
 =?iso-8859-1?Q?kpkZ/wsDh7ejAO7v3mr3cACL0hckT0zGk18R1ZbCJVaP0+Z4fyEgeqWQTW?=
 =?iso-8859-1?Q?5VZqQOd3syw/CIk/X5+w8ITJ0HNvpUYee6SEviJG0IBjDqZ2noaPhRzIUk?=
 =?iso-8859-1?Q?mwlM8U8MnPCavY6W5PdEWGbUFY7h2TiZRmKh9iPesk8jXgvwcIOm68r0ym?=
 =?iso-8859-1?Q?e0q5zsPNp5NEk7p3PdMIFTZZS3DcCqbtMV3+vpszwDT67QJvgYvBfzYeZ7?=
 =?iso-8859-1?Q?fcvCbJZD3MFkFK+Z7aWndo8I8X5AJS7OVT6h4LKyGSsNySOq9URUO6cnnP?=
 =?iso-8859-1?Q?28DrmxIQzi1DquzzG2G689BisaLjGpZRpcKC0bh+yEty806mUx8zdvj3j5?=
 =?iso-8859-1?Q?wmqQC7ncPf4Z7QbhmhT09q0zqRNlE145QkAqR6aL0SKxas1mP8N5dygB3d?=
 =?iso-8859-1?Q?KuzFPHlzrP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83681bc-d62d-41cf-3d39-08d926c0139b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 18:47:45.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcRfFGh1trR94yTDZfRfH7EVDp8GXD1NspvPEGcN1f0AZ7EvRrvPFevFuDTiL9cie4IQ5+OrL7sKFF2FssuP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3340
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030126
X-Proofpoint-GUID: LP-TvGyB3rv1QKQF_tpcqjOY8cR1NY1J
X-Proofpoint-ORIG-GUID: LP-TvGyB3rv1QKQF_tpcqjOY8cR1NY1J
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.30.2
