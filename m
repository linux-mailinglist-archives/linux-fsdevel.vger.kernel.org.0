Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782853010A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 00:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbhAVXIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 18:08:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbhAVTjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:39:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJMPT5110485;
        Fri, 22 Jan 2021 19:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=r/zkEKpEVAdw1zseykKrA86cN4VGm5bpXUuE+ajbES0=;
 b=qTa3AL0K50NiYGwi2CoRTaB6unLCpOu8Mjje4hkDY8mzbdW0gbHJ3149eR6WDGn19WAh
 HoVq6+T/sj38Ke2eBdmmt2jViJDBObgp2GsdwRn/YhSfDdaHddDqfGhhIZZWFsSRoVPf
 mbpBwcyaNsxO9bSzS5o7kDoWyZYSSCBN2iUHnL7wb+3NLPrgtPc8v2UZJY5/geMm21BB
 iC/uNKucGCKV6QMXLBQp3sxSD8mfzijleSVQIY7zJ6zNaN1BkvJQ/b1Ui86E0YDMllFd
 mNPXt9x0SYsniFHmlWHh3f8o3HHMJBRWXrdbsFnPJce8z9HMoHo58lWw3DcMSfqhYzAT eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3668qantdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:38:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJB01N189068;
        Fri, 22 Jan 2021 19:38:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3668r1gs2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO3cmGt6XeIaKV3tFHBHCxSx4NagRi4J7FFBZkYVPKq3c1Rg41k+Q2+K60kVINx1/zO87Xhp8UQQLMgizka8pbwSeuY3+cQ721CbRMH3T16x8efqApy8yyfH+BI1Cdbrr5EIuwN2gXNX3C63lH8Hv7Afqt5dR+63LOz+icQs+Kq7eL94OhyIMRHh9rL7QE0xQ4+siEvo+MGYNIhV/yXmjiBSLWNiJqgA+xTq4e7dqrz5NqpbM5wqnIHSkm5MPzP3lGheakvNv1Jip86Qh8z1HtgSCw7oNfQWwARkPgGxAOImm+itftwtiWIuxk3xGhF5pkeSF72FZZrThoPDczNb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/zkEKpEVAdw1zseykKrA86cN4VGm5bpXUuE+ajbES0=;
 b=UxTdm4XuqV+sjD6L6Jx9oPXipTtE4FxPT6TPhpli8rSJcFhzv/e9eZWmpqumBiAjNxTTvkdx8uQsD0iWpDZAdLsD9PjTkqDpjuO3zCRyFhpP/7LHioQROKnQwsAAiFVnAi2sXSNLHOKPAH4hgIH4RyDDzXPz63DI8NR4/u2u9/gzXze88ROcKydw+Ilg9li67ZiHiMvwsVQL323XYMn2BH0yjpBy4XzwuN0aHuwpPaySlcKQp5cjh3KxFfnC8qzEx7i9nye+abon5RAUxd0d2EwFrn4V8H7auLKev4T3TAH7139zWN5Ir8HiErQ4W4o6rrHu96b9erUBA1qYPw4CBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/zkEKpEVAdw1zseykKrA86cN4VGm5bpXUuE+ajbES0=;
 b=Ww8k8hWe79zmCwfnd3VH6WqD+jJzNRq8C1bTkxh437aiDBzpl7pChEFIPivhkZ7oBya6zg3GLUfya9fzbDOVoEQ23wDL5bMCfAjr+WbLzgb1b1z1NwF6ao+id9E+31jjF+9OzKlp6iVrXexuTNZodfLTOs5dYCYbKzSoB4Z4jy8=
Received: from BYAPR10MB3656.namprd10.prod.outlook.com (2603:10b6:a03:11e::29)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 22 Jan
 2021 19:38:24 +0000
Received: from BYAPR10MB3656.namprd10.prod.outlook.com
 ([fe80::d008:cc46:8ff7:6e57]) by BYAPR10MB3656.namprd10.prod.outlook.com
 ([fe80::d008:cc46:8ff7:6e57%6]) with mapi id 15.20.3742.014; Fri, 22 Jan 2021
 19:38:24 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2 0/4] Remove nrexceptional tracking
Thread-Topic: [PATCH v2 0/4] Remove nrexceptional tracking
Thread-Index: AQHW8PYlA/sKguPJXEiRJQwiLTy6/Q==
Date:   Fri, 22 Jan 2021 19:38:24 +0000
Message-ID: <A6FDF15C-F975-49D0-9A4F-5470ECA9BD87@oracle.com>
References: <20201026151849.24232-1-willy@infradead.org>
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [2601:285:8200:4089:bd98:f3cd:3555:a591]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d2de3b0-848a-4a84-5bd6-08d8bf0d488a
x-ms-traffictypediagnostic: BYAPR10MB3702:
x-microsoft-antispam-prvs: <BYAPR10MB3702C4C0108831606CBD88F381A00@BYAPR10MB3702.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elTekp+HgGH0hQScudLH1qixy3QA8Xh7Em2Ez62ElJSUGPulIbsJklwnhXcBOn7kz8vlMm1RiJlvK8/CEpY2pM5keBDiqvk28lsjJXNRuubGEDnn0mPWwFTPFuwzqLC5MbnA6lzw93OHKkvP4n0VlqhPpj2SpgeBUQDGRl+zfNhXFkcTBxag1PcEOGbyzumyRzZPtNxtJs6TTYlzbe5nZbH3j+BKuwQmfZoLIo90Coc7Lbh/J8wd8QFyUUPSpdznAleeDUfxTM/jlTiAj7/F0XMoAsKRs0AzfypJJHRJ0rSQSwF1PEd0rCPlV11BgTo0Hd4akK0MUCgeEyl8kfCPRgKci1R5Hsf8/F3g+TtZn3dZmRIWsgX4kscKuUOtmRjxgZecPlciEPHCrLIUNGboHqtVgkWDSh44vzpjpUFCSzpxELn2VPQlvhZ0kQ5DnVIA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3656.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(396003)(366004)(66556008)(66946007)(66446008)(76116006)(6486002)(8936002)(478600001)(5660300002)(316002)(66476007)(83380400001)(91956017)(4326008)(36756003)(186003)(2906002)(33656002)(54906003)(71200400001)(6916009)(6512007)(6506007)(44832011)(86362001)(8676002)(2616005)(53546011)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tK4Fykhlut30U8sth2b1Zw02OTL0Lj0yLkxpJnrYOQyfFg6SKbJkh4tZRawM?=
 =?us-ascii?Q?gQVwxdzTcvdkGv4jB3hTOGfeHzRCxZeX3f2X25UGBwWV2YVh5JSR7G8ZDFEH?=
 =?us-ascii?Q?dM7+98ERSEjT8t8N0N4dcs6pfakupa5yMDpsTKXNXIluWlwrabF6kKHAGcr3?=
 =?us-ascii?Q?omd7aPVHi1M/EueGJwPpVC15kSLvBcNLwDxoUInIg7pVXc28IKxd0lnF6f0s?=
 =?us-ascii?Q?RjRRhPJXaxWEqCgvGkf45PhBTLXz+TmxeIB7F0YJ2Lvc8yWBn7rOH+nnBkuk?=
 =?us-ascii?Q?BcsQZbqCiOoCqWoWfozsGnFI0roni0+F7TJRf7YxNMxjt4/g9Uls98PQcFfQ?=
 =?us-ascii?Q?12yLmZskeUFBJRZsz4VaMn7/yVLZvd5w4zdFpEh0WhgmLbMFhhSPiruUU9di?=
 =?us-ascii?Q?iCqQ5j62AgzExhIAIGbRFYXB5zpG2d5JcRNepAgSQswSUUcXghaAxxaeTtan?=
 =?us-ascii?Q?+XsVVrX53PP4EsGAjckYrF8ZJKk1zQrnIJpddKLKCdDeGcolXD+SfcSHzlKc?=
 =?us-ascii?Q?Ss+qCW8vbU3F/zCTdetzC9ymzOCjhuoS+EacH/jnqKKP4T0nT1a4IGTTRgF0?=
 =?us-ascii?Q?x50iCN7UlkA799r93GAsYgRxiIkihraLl/WSleOZPv1GtMy9iRGAvQV5bh/t?=
 =?us-ascii?Q?zs3aZ75NvF66SWS//QUX1isLH/rJJKdAZXn0eZE+FYbq2sS8Ujz5HYrek2Iu?=
 =?us-ascii?Q?KAx99ccUra6zPIKj0Pkwd2MQKT1Yx3WunqCmzdJYagC5Zp1Vb0NdihLxpgYy?=
 =?us-ascii?Q?jkyFphqWVGe0P4chGiDYVcU38C7eflAxPcpVVagzcb8f/sg6+wg/puN4ucyI?=
 =?us-ascii?Q?jbOXvux/M7UmMMqNO7n5v7SJqqOS8gLoNaC3YYBIZnDqw4v/GNeZMarQ8lSA?=
 =?us-ascii?Q?raC1jGUBXbG5aPdAk3JwjKoDGvV1QBHTq2weEFdYbkDNLxzYGYrWHG9yp81x?=
 =?us-ascii?Q?BW9KCJ2FRkbEHJE8KrnaRMMsvwf0wNKoWW1wgkrVwPkDfhrEXA9DeNf0HcLE?=
 =?us-ascii?Q?AN3k4smREfSoFP0yl6VaRFJ1LPCURuEpZw9VX5JR44rxQ7fknZj/LzNEc6bl?=
 =?us-ascii?Q?icEWp9cdob1Yr7vpv8riHEFsqF/oGaCNjVNj/qjGsD1TBerC5iyFy67rqD4q?=
 =?us-ascii?Q?Sh4jYMEKcwSHBQa8NEqyq/O+rMaF4TwGnA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A30E6942BE94743A22C6CD173DECBC4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3656.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2de3b0-848a-4a84-5bd6-08d8bf0d488a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 19:38:24.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH4swulYzLAbsDRoIPDREfiyJS+6APXkhbWcI2YwTFLMmZerVJeoueno+QyYvdImE/RGrEMGzGjKsVzhEJIUAXMzdNDyR3U7rStyHr2pjks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220099
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 26, 2020, at 9:18 AM, Matthew Wilcox (Oracle) <willy@infradead.org=
> wrote:
>=20
> We actually use nrexceptional for very little these days.  It's a minor
> pain to keep in sync with nrpages, but the pain becomes much bigger
> with the THP patches because we don't know how many indices a shadow
> entry occupies.  It's easier to just remove it than keep it accurate.
>=20
> Also, we save 8 bytes per inode which is nothing to sneeze at; on my
> laptop, it would improve shmem_inode_cache from 22 to 23 objects per
> 16kB, and inode_cache from 26 to 27 objects.  Combined, that saves
> a megabyte of memory from a combined usage of 25MB for both caches.
> Unfortunately, ext4 doesn't cross a magic boundary, so it doesn't save
> any memory for ext4.
>=20
> Matthew Wilcox (Oracle) (4):
>  mm: Introduce and use mapping_empty
>  mm: Stop accounting shadow entries
>  dax: Account DAX entries as nrpages
>  mm: Remove nrexceptional from inode
>=20
> fs/block_dev.c          |  2 +-
> fs/dax.c                |  8 ++++----
> fs/gfs2/glock.c         |  3 +--
> fs/inode.c              |  2 +-
> include/linux/fs.h      |  2 --
> include/linux/pagemap.h |  5 +++++
> mm/filemap.c            | 16 ----------------
> mm/swap_state.c         |  4 ----
> mm/truncate.c           | 19 +++----------------
> mm/workingset.c         |  1 -
> 10 files changed, 15 insertions(+), 47 deletions(-)
>=20
> --=20
> 2.28.0

Looks good to me.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

