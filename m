Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C7C37EBE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbhELTjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 15:39:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358827AbhELSug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 14:50:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIk7Ys012846;
        Wed, 12 May 2021 18:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=MkmPNWWPBNjceUPGxZnN6+6oSKmxDnlQGP66vgze8pY=;
 b=Nknv6RJuxF046zlb8IWLaOGv91wQPJLNxTsbaZeAntGYFq1PGpwShxylVqARvdySSVL4
 VauNt22znGCcwUZfUeg69MBM3IXR0igPohnEJT55WUOzoGpkHo3HoJvC6mAQxLkSzR/F
 gwB8yRdgDEJUJRaryOExdl2lI4pHWQ3k4fJna4q+1C+pVRkkCHjDn8iXmmiWHGD2bW9V
 BRvELt5s67X/9BqrrClY3oHYzuo7iBHREH4dXegw3ftCs3QSQoIRL8AJWbvLKFv5+xPR
 TRxtwleE4uwVijB0ewOdYezr7NRQBRKKVgxy82yDM1GuUvUlQ9d3eTFWAtzLA2GYlz4V zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38djkmjyxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIik8D186150;
        Wed, 12 May 2021 18:48:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 38djfckhf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScCSeMF7cCH822AabMZZZKHeL56FUHyKxN8+G4H/ye5iv2qZFdT2Aa1w+gRAwyXpGaW1x1Xa6vPEcfY67+ZZwFYMQXn1jR0N7zZFC8Kpi87kSvPBVlSQ4ZlgOU7X5hB70tATVUQgsZjpchUdI0bdxcWNPswSxFwimuuqLEY/zWpAZ0Tep96dwrFhUpfduWt1IbRJ8tfWdmEIINOu9uBJtnDnHGRGTbNKM4RHiYubw/04PHsDxe/JrU2X6MAxWcSaJue2cKbcCUvDGtUFFup8195P3bFSbuGt+GLGOL6hm/D3QeJtItrC5y65MQJl9OB+vUXRKfyNrWk1MwO3UqA26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkmPNWWPBNjceUPGxZnN6+6oSKmxDnlQGP66vgze8pY=;
 b=TN1Rx8qZX3MkRhmGit+HfhysXdnw67VIimbBfgF7UCg4ngtV7W/to0F4hrBmtpfHxfgBmnbgG/PdyL6GRsD/cNij4N1xxqOUF6lLGXamKTLTwDEsp+n3Fww7uC/DjL/YWGFOmQtkqSmnxeqqVJll8K90V5NHi47MRUiSN+ELJ8BBHP4zDN5i+HS2Sj6IQGqCZ0zaKVJXqOJNXnWQIEa9cc6JwRCU0IxsE44KSwqCRaKMbMvGslIZmbfMV4b+7N6HvuXwN45rQR8BkhDW3uru/nJrTucn7FQmFnH0ZptSD2phl230sPNrrqt8V07lXO2XYRTeKKOspoutrHEMkJDFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkmPNWWPBNjceUPGxZnN6+6oSKmxDnlQGP66vgze8pY=;
 b=EZhAd2ZnuzhifnsmkH7fVrgrk0ROvgosL2mV5L+/efDwcGH+EPZuEMPeKvoMXIf1yJy4uOYSgyWXuq/G2kTKdfLP0va05AomgWiwmormMjQbvcMBjjNfEN3Jw+DmHauAnFFFm37vB8t6BWDvHHRi0tS4FD2Pg/hdG6SOYRLJpEY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 18:48:52 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 18:48:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 1/4] radix tree test suite: Add support for fallthrough
 attribute
Thread-Topic: [PATCH 1/4] radix tree test suite: Add support for fallthrough
 attribute
Thread-Index: AQHXR19zptPJuWt0S0yNBUHtYnlPaA==
Date:   Wed, 12 May 2021 18:48:52 +0000
Message-ID: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c69998-6adf-4bb5-6cc7-08d915769670
x-ms-traffictypediagnostic: CO1PR10MB4785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47853818B57987E4459BED08FD529@CO1PR10MB4785.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LF9gaMEDTvMYFGCGeiYqWVp2gXCTZI77HGfxqhnB7jTBGNWsSGQOLIETVUq2X7PVDhC2CfdJXv4diVbYRkgLY9DSCi/kL1hNoTvsEiAMD1lHOY/2cnZYaoXnor0d0cbbug05TQzJ+klPC3lljAGbBNnqR8BK6llJrorFaJppqJpcFy6SjebbN9QWTXJ5Uo4Yeq0KwajMXS83hovTQeoO7kCJa/8dTKLZPmSpIdS9wU72IZXfgjcT9nLpndPBdQbKxCoAip46MEEgR7Zw/yB0hmmNp/bIpjGWC6iAdIbd68iiNk47AtBEkFDTFC5t5HB3RbXdPVL2TQtia5GR1KaFOg4FpDZGK4bGUV2WPb9rhBprZfbjYXenSHjEdANdZFNBEo/SAN9ewEYCcSX4/+9yfGwcUX5jSAPhJpOC+W6DbR/CbMCTdGArlMYMizhBGQTIkCdZAdqsQbSPDoBDKAJ48lYmp8qSWQyhOLKIxS2yuL0zOZ4m6dQWkqflvRiCqPNpEomWR6vLeTxvOS4//DVfNFygWchjF89LnsJNajqpEaubtjii1qhJMS4fzBkCL1FXP0DS9CHxlNBkDu0PV9pTn1kjp0bRfIgFtYsnG+fFyiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(36756003)(107886003)(122000001)(4326008)(38100700002)(186003)(86362001)(71200400001)(8676002)(5660300002)(44832011)(4744005)(110136005)(2616005)(1076003)(8936002)(6486002)(2906002)(6512007)(66476007)(76116006)(66946007)(66556008)(91956017)(64756008)(26005)(478600001)(316002)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yT5MSJX/26pj+ZB95zt+gurnoQwMdZRbUIjSnKgANaoYIiMNnJHCAItpDF?=
 =?iso-8859-1?Q?b6FMVcxUuGXTc0yUZiVN0enpFQB0Y2MJE9Esv2ZOgxwDZ81bMvf9+5NPPT?=
 =?iso-8859-1?Q?Ns3AIzHe1uRhqzCCQe/1Vov25KYf6eSsBZRzwvH1nYIESmW7daz99GfCWH?=
 =?iso-8859-1?Q?RjaplrMkxxP+dR2m1xsbGv4wCzVnXPgEuqvCFVqXQ6y+TXFxWZK544NKDQ?=
 =?iso-8859-1?Q?UeCotYK89NXKA2elC7s1Jh1SzjJhItD5T5nnsoqCWisE9i1JBNaKois+UP?=
 =?iso-8859-1?Q?G944BmrFjJYOpconbxJba6pteJvwgEfvMHsHwkPRCghewtameix8uHDkdr?=
 =?iso-8859-1?Q?Zt9Y9hIW8S4l7S7P7eG2HDqZAPyJ87pIEwHERBcaUZMhp08lO8Onvo9+KC?=
 =?iso-8859-1?Q?JSHnisE6OHRvEvp9LER5tsBYp/FQWiRX1/OUuR+CTn7fKfqPhdFJfi+3Uy?=
 =?iso-8859-1?Q?q/J+REiGzKle9qRJ2piF6FJc2a+dqtVo/8AydgsYRhUwG7+Kvcuwr/IIfR?=
 =?iso-8859-1?Q?cEH/N36n2Zh5aU42gXqfPZa0dUzoNb5iP7VNVDpQGNbQRnBMpJZueum4iX?=
 =?iso-8859-1?Q?l/9jlQT2lgEOfZqVbbqBAORNtKfjmaM0QyQOGAWU+si+9TM8vY9KL8Gh0i?=
 =?iso-8859-1?Q?s5kxAQwrjg41+l712D36W6bBkw8u6v4oTxQBGiyueehjWK+JUiOSegzvOg?=
 =?iso-8859-1?Q?qtscSjoL2eFoSam66gWy6Hf+3ZpD5ikeelrhOFS59jBb6E0Llx/aj7kRv3?=
 =?iso-8859-1?Q?VrJu43y47MrrFLX3WMlLg6DbXbu7JsFdShvZ4bNcz1KCSs8VmZlhHR8y4X?=
 =?iso-8859-1?Q?qUj9BV4rvXcpxoLqkvkNw4ecL9i1ZFn4XSjvfgvA8DbQ/nFkjPhkeguXI7?=
 =?iso-8859-1?Q?4uAeYUqU80YQQNt+9IuLULVUVCO6EE6cchUDDjcqlepZhokXTlhmQ5Nzgp?=
 =?iso-8859-1?Q?KGlKIwNs36Koaq8xgi6wKwraulLk0y/pxL2or1VmKByOpYx+rxgMdF4Oga?=
 =?iso-8859-1?Q?fColJXJO9iNw74YldWNzT6jE/yDtmGzwOygbIuKIFnJF7QFiFWwf3piibj?=
 =?iso-8859-1?Q?QU/UkOEVf7J48LKIVBpwpwN7cBwhOmDAmiKr6t8edpFcK6qrqw3LJA7W9l?=
 =?iso-8859-1?Q?B6C1/LSYk5nSUePrDq/eQzPmxqLqQzCXZ6WsnuNplWka2gs7WlTvIHEet2?=
 =?iso-8859-1?Q?l9FjS5I3BkFhaauALmAC/HO7gH5iE1nZrLe9cUBYIoGg7lQS/1tNcqGgC6?=
 =?iso-8859-1?Q?a57lvXcGMuA7v9/o9mP55eRVHR6g9UzHsm2ZQXlFik8EmsPADJnc2aZzwL?=
 =?iso-8859-1?Q?LbL30FVm6pkfFdRE10+C660Utn92+gPcs9Nt/mIpn02/q5v0uZ1Ywr89uu?=
 =?iso-8859-1?Q?DwetinnGAe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c69998-6adf-4bb5-6cc7-08d915769670
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 18:48:52.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKau6vLLoJ+gX0IBEplIQDl8WQgczwTLakOKa/wy3Sa0+dFiqh4Q0aPKJ8XXf/jEV7El6WoXjZg0bbzuNetS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
X-Proofpoint-GUID: wxp1YBpP5suD_hrtEqY9vtaIROMihjoZ
X-Proofpoint-ORIG-GUID: wxp1YBpP5suD_hrtEqY9vtaIROMihjoZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for fallthrough on case statements.  Note this does *NOT*
check for missing fallthrough, but does allow compiling of code with
fallthrough in case statements.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c400a27e544a 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -23,4 +23,11 @@
 #define __must_hold(x)
=20
 #define EXPORT_PER_CPU_SYMBOL_GPL(x)
+
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
+#endif /* __has_attribute */
+
 #endif /* _KERNEL_H */
--=20
2.30.2
