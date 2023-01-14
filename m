Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7266A857
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 02:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjANBdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 20:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjANBdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:33:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13D6A0E0;
        Fri, 13 Jan 2023 17:33:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30E0BVK1006395;
        Sat, 14 Jan 2023 01:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=tvW8TJHM8Bx+aHVdsfSKu5X+TgJW6yEqWv93PEQf88A=;
 b=dLTEq5cXnRM65TvNijD3y/JUb/A4LhY/vhw21TUEiltYj9kMaliisJb7tbnIIcIOwTAI
 CuCidd1bw16mfVIViYelfo0QthJNSq83Wtkc7B4qnL1WeVvd8idokae8CFaBihl/Eesc
 vca7KLVeZvSiH0ru2Yt+duydM20viS1G8jtT01SCqYzDoo6cDR8hau6/nyyFKtJ28+lb
 DDjvV5foikfqAnjI+7BYAQ/EH84pPnii5SF52VCZBXXK6/vyl3h8+TlHaqjlbBs8/S3G
 m6Xnyf4zWXrX++YxBwa/G4G5bpV4afG42V3ZMrlJ66kMnOaBtFfjKhmwMzlHt9eP5moC yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btx2sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 01:33:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30E1X54C003286;
        Sat, 14 Jan 2023 01:33:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3ju201m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 01:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYrB76rko1Ra6spTOKPjTzlcmpnqvQCExsZm9Ui4yT3n3HwWXzgLs3AoOI1R0N5tEwkYjXIw6I4UOPisSMu7z0EfQouHjqiJxh519J/gDM6n2FdNJxcp1jPJlCNefZZK86ic/6jILJF28xJ9ineDv2AeNHzmT3XwSGsHvF00YhPR/uMGaj3T45PfJ3TX65OoWIl4C/rchnIKIGbxw1vVd05t4LUB7Bu8hvj4N5erzzR18t6slHlfiEPxJ0JkRUWVkHG45SO+XGKrT2LukpYF3OEA809ZhdOBjeuFEQAtRnJvUkOdlrbbKZE4Spwgwqy0VdDdSxmbT/hEXZNXZBZ40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvW8TJHM8Bx+aHVdsfSKu5X+TgJW6yEqWv93PEQf88A=;
 b=Vp/TIJn+MaVc+D/rd6pEPlIIVtAV77s9UwLPaF/e1y/+hIZrq9Mx2BR7qzbWLCD/ARNvSFmCrp1/MwKPjPNiYVXNl1iCTtzeC9XyNtU/67VL/ZqONZGcE31ZMD8E/RACytv4IhHxkiGpsWKt2Lyyx//Yfa11HONSSL7xmbd8AY4C2Mp7vTv1ui9oWk/XodMXnMRORxdiOGTBHw+Hq5HFYXrG2iYqSn8kX/EC7//lMBI5TZYJVv5cMVLeUvp7QNtYCJTuIShxUGRk9/PwmO7wXnXk3jE8bc6U+T3gyLlBtKMDlgjMJMvCnzLypC/4S6qVO8LDqGgHpLhqXNDmNfkQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvW8TJHM8Bx+aHVdsfSKu5X+TgJW6yEqWv93PEQf88A=;
 b=GbiCt7dUbqXpIqliK3DhypZRpGKWAYukdZHRC2oF2sboQeprwnSQakAG2hAGoRMdeRhgQ/YzR9XMViPYQMQfEG+ouw/gQ54IbhkCHc6Ks512ZaV1XYNZ5k1/2lUExqad4EJ325/DHBA/BFTfmAVdusHfGQ/eoCt/jXvXGeHF8H4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5831.namprd10.prod.outlook.com (2603:10b6:510:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Sat, 14 Jan
 2023 01:33:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 01:33:16 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bart Van Assche <bart.vanassche@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7r1ucin.fsf@ca-mkp.ca.oracle.com>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
        <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
        <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
        <15330.1673519461@warthog.procyon.org.uk>
        <Y8AUTlRibL+pGDJN@infradead.org> <Y8BFVgdGYNQqK3sB@ZenIV>
        <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com>
        <Y8Ds9JbWNGlWnoj9@infradead.org>
Date:   Fri, 13 Jan 2023 20:33:13 -0500
In-Reply-To: <Y8Ds9JbWNGlWnoj9@infradead.org> (Christoph Hellwig's message of
        "Thu, 12 Jan 2023 21:32:36 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:5:74::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 6105591e-08b8-4882-1909-08daf5cf4ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzeB8G1BJQkgPq9fvVs5Zel4Fbs1H2u+r6mBdYo9LGI/jA6nGWkU0eZj5YOY0U+nTUsDCFDr2+u8RI50nIfEj4kdMGUacTmYUtCl2ogPiUoIuYv0ZFfeyTFeyFADNzxG+ukdtGB6+h7z5xDsdqZAzUPe1E8AueSdUwsQxF2bIzqYCRTfTxA6n1cVJC+YWkjs8yr+xBw5KaacExiBz+dUtHkHcGNsjsuyB2hntb0t2jb7/VZ9qnodf1Rug1XhWhj0tvTV96AsnYVJdqa7FAIVbZ0BHEV21FowRY7VH6OWSI3NqV9ILl0QaI8iNYzPhrz3VaL+ynQ4hr13b4G2agzrPGZImy6KgWBkd+9XNcs4IezZ5hQBrRwFLVoAiy8qNHPMDseTVmwSEiEZCm7n/9Q4xbpuPVbDIAtr8sKosZREZJkAcBGEnT8W1o4IwG5l9nEJYoDWkNYRgF8ApzklZT115xhAwFBvn4So1/hq4RGPGZwUThjONCG3BVlG+AHljyJX6F/8aRw72iKADWwvE3yGkV/g6NGyP//JYLjr6b435/TJahuUohdhyw/8w+GHg8rrXsPLOijzojGVUcJKImypQ2RcDjR+vGeQlTZFBMXMxKIOGXlin/KgneKNiMMdEUGFhf0L6E+hL+uJu7zVgLhKww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(8936002)(5660300002)(7416002)(41300700001)(54906003)(4326008)(316002)(6916009)(66946007)(66556008)(8676002)(66476007)(2906002)(6486002)(478600001)(36916002)(38100700002)(26005)(6512007)(6506007)(6666004)(186003)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXwYW/MYD/nOAnJL5E8wgDzj2SAPe/P5XL++RENeJmUBZ7LqJDYQc/hdbHXa?=
 =?us-ascii?Q?BBHufQ/qvjn1BohC4L9THFrNS+XMTdQ5vTahTGpFNt7PGxYnVuCsj5XkOhCt?=
 =?us-ascii?Q?DfQu6MYWhXIJK5jXvmPzCtcLg/iZ4uwuoV7+OAxj4NaxJdpXEVOX97o7CSDG?=
 =?us-ascii?Q?cA9yRqZE7oN1+C5r0HzahJcADNYtZT3pcMeAkraE8tz+u5V4KS7BbNJd1mei?=
 =?us-ascii?Q?24NO/oW1ax6Htz9XknGDdpApJy9RWDJilZAuqwm+DH8uiXIUXLgZjY7y8Kny?=
 =?us-ascii?Q?9JYIdgeC6yQU6UjDgqW9pfNJAaPW1f2L4SmRnJSSvUus1qenjFB/RfECsDTr?=
 =?us-ascii?Q?2GjK/suIvA+yAftHE2YwmvFQ4GQLpJwMV5NAyBpBI8SslMJdxXLPfRkn92Zq?=
 =?us-ascii?Q?7fJa432sBessDbK8qC3dCriUWqgXvwUeDBG3vjY0hoAxdMbuuROETnQxSFQL?=
 =?us-ascii?Q?oNVigtVL7kisoMUo/1VvgZvF7x2s4PCZ5nDoN1AIm9jupOQejv4qWX73jn03?=
 =?us-ascii?Q?S4dR1i05mpF0kmiYTvpAfScL0FdYvDryV0d8BTdH+kt3qY2R6i6aivRw9BP5?=
 =?us-ascii?Q?a8iPVKonHL2u9UuNhr/Lnn6+fmZRs+32McOacT3hUAHzH407qMquHXNPploS?=
 =?us-ascii?Q?BOQA4/wnrkTAFtlAAWjXZwNivFafnaSEKlWUhX31mwOE5LI/nNNGPX+SoL+B?=
 =?us-ascii?Q?b7gVxyn6cgiwJAxgRJ5QcfXnW8gAx5YE97mL77gkXXjpsJBGqHQvDBARGIte?=
 =?us-ascii?Q?A2OelTLHtRHcZWuqdVrfccsyRhqoZtZQf8psATTVrlukYxf44UgfNgEnhSuH?=
 =?us-ascii?Q?RQ11oOYITsSjFQfqlk5/uxqxGAcjjKWzr5ZW9kkwzOeKQrszHZsTmfXZBy0w?=
 =?us-ascii?Q?dS7qjxHepyW4OoiGl9TagAPk8Fy+iUXZW4vsBH1gsx6t0TzxOoPAEG3SUW7r?=
 =?us-ascii?Q?L5jrZHxcWarPmGBF9j4jqeZUoThUvXv7FRClneXykXga+FfML3J1H+PWGGT8?=
 =?us-ascii?Q?C+eVLN2RFN2pjv3bDT20MgOuor81eJGgLocv6IEgqvENW/IckWe01H6aWHSQ?=
 =?us-ascii?Q?wi8osd8rxv7hxCfFghram3JZnZnwMg93uyk9UKZrNyD9mTJLwr4tQ3ZKTB8D?=
 =?us-ascii?Q?9eWsUXDHJI+jzInEBClKZ6FnhzvpYWoLcy36StH4ntX2dlpctY+kOTeWYVya?=
 =?us-ascii?Q?mBHSuzkB4YCn56gY5w5JssehcLQn7GoqN8SUikxXbOXK5b2c1qfliMmJhHep?=
 =?us-ascii?Q?qOPc+PB4aDjAH3uW5fjf+KjIeKgqzMBWRWD0UIK3Sd2BRrJ8Eps+OhB5apPX?=
 =?us-ascii?Q?qwg7TFSu6PjUuQ8sisGgrNBME1shOaNutnySuGdrlb89CUd74tXpCIhn/mBy?=
 =?us-ascii?Q?DXIJzGDBNfh7oo6/pld083ZhNohoCweUOh486dVl38jrpQRhcD8JPraw6FCf?=
 =?us-ascii?Q?UjcDoFcM/B8cKwTv71avZ9khYZzfEU2IyrwqojuBzxa8nqMVqCmxQV/2xbvy?=
 =?us-ascii?Q?zcTlCWskbc7AR8Fc/QjubWKQ0Otk1tqTQnttghFgU+T0nRbIcSWF1L2vSGXt?=
 =?us-ascii?Q?SzRuHI+BL/8chVcFGFyHL+MVQH0A6U50mCxFbOAKpZrfHWBQEexaDizyMwnT?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1SqDU1fDkjXNlaALfXJBFu5eKJSa3zFKLCyFxq0LjX2xGHLP0f9eFgcOC+h6?=
 =?us-ascii?Q?LR5PjEcFUFLYohaqxT1/iMIaFAGkXM0Y6EM1p+P03F6YWdPyt0orBCWnGY58?=
 =?us-ascii?Q?bHJeNUpSlOr2tJQIL1UDN4yG45iPhLx3dVe2uf/bXoXB644vSgRH7eRSy3NX?=
 =?us-ascii?Q?XkLPvAokW52M+cZKsfow8svmYgTpdIFWhBrV14ubBNFTUkWKZLjeTfPY+QDD?=
 =?us-ascii?Q?Gz5Lp9hW0Kw63qSfHr/Cm3/P4V07LmIRj/77hDY7CjCps0e/q1X8SkbgVEuz?=
 =?us-ascii?Q?Q6aTLAleGSsOpiaSFmiobI894+jp1i5v+MDkyL2n8uGP+MhSysYf2sVRWhqQ?=
 =?us-ascii?Q?zC+pyvQh07jdcrWCeCP4r4+eTbmkG51VK+rZIiRuls4o0Rfa3bELBMMI9/tM?=
 =?us-ascii?Q?fyudyw/U+Z74iOv0tVPWLH5E+7gJuZWUCGlEcbHr63YuqvVQfDVEx4xFHVCG?=
 =?us-ascii?Q?WfK3IiqMVPVz056Sg+gCtk4mrUlBSHi6sjpfkay1Zhv/zIyZXn0qLyYAMacU?=
 =?us-ascii?Q?rm1gZSWuqPH6cuKsJGuc/N2+uInA9qL9qXUFCX5hTpIRYVdVSpgYcFiS7VUw?=
 =?us-ascii?Q?yjw0WNNwA0O2ZvlawQlr5irsq5BCd3g+w2oW7vmHA60rBsYAbYBlnR5OQ0CQ?=
 =?us-ascii?Q?8d5cKOvNpNjfF+eSb7cvyNPGy5BEWmGX07OF8MST7DyhZ7DTneFg5+MZPwTK?=
 =?us-ascii?Q?Xb0Mbjh+hyJsQtzcUPbbzIaoWtoVvZozifPNRH7jfa3FE2Nh8TEKr4QXMrfu?=
 =?us-ascii?Q?4EgBKMpU/lNYdUpskPZOtKLJpQLATdCVBe0HeIy+x0IQ3yk9K3wFnOV3wIgk?=
 =?us-ascii?Q?VxsQH1zDPdX+tSHX/X0MbSqkfHJrMNI6+pppnwn7jsIHo4dNaksSMhS3IRqx?=
 =?us-ascii?Q?q8X41LQD0U4QdgUIb11hZh+32NDI34EZLp/Aa7rEU/7d1HCZZtTUHBmI7npA?=
 =?us-ascii?Q?FyzlT7kYr3Fj2mPHSX7T8NIZqDqttnDjUsg502jqBpKd4lVCbkEDv+qdpzSA?=
 =?us-ascii?Q?blAeKIHCCbFQBvLnGCNlM9peqr7rcfi8iURrw8zQGdBfu6Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6105591e-08b8-4882-1909-08daf5cf4ef8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 01:33:16.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC8kystx7sYAeBth4XXtT/PslhlFd8QfEpb+XDECaFzFVsIX6I3BjbnnN1QgDSQB7MgO19v4J4Ji/i35oJbMJ8QSkmb5QudgjQ3Fr1W9SYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=711 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301140008
X-Proofpoint-GUID: tirb5IlmfUBOkkGkVV5x8qw6chL2E-0U
X-Proofpoint-ORIG-GUID: tirb5IlmfUBOkkGkVV5x8qw6chL2E-0U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Yeah.  And that weird (ab)use of blk_rq_map_user_iov into preallocated
> pages in sg has been a constant source of pain.  I'd be very happy to
> make it match the generic SG_IO implementation and either do
> get_user_pages or the normal bounce buffering implemented in the
> common code.

Yes, it would be nice to get that cleaned up.

-- 
Martin K. Petersen	Oracle Linux Engineering
