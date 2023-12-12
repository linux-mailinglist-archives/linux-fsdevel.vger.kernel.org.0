Return-Path: <linux-fsdevel+bounces-5665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B880E9CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709031C20B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED25E0D7;
	Tue, 12 Dec 2023 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CTxUYleb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UACCB3dz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE1AB7;
	Tue, 12 Dec 2023 03:09:47 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7i0Ym019194;
	Tue, 12 Dec 2023 11:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=G9uPYGSR98Rb88RfONFKc4B5xQ0ce0WEpJWuGlPoTCU=;
 b=CTxUYlebMRRKF2HWSBlcFw5uaP99tSppZfS4tuOz/XiSRyjfeMEzD/b6VbJIAGg7KKZ3
 Ik4rGSOaEcNAq1ASM6qZb/gvCKwBxN70XM9VcvhbCMMBmH4Y8WHKoqhKtRX7qpH2orZ8
 Wt32QAHaMxq5KwxzbptPYXH5SYZJ6gaAR3kxn5nJQ7p9V0Vs2l8R2Dy14qiErL1KIJoa
 VnVNXYm9yRmRujesHSES2g+JY1jJfoxsVutEfGGG8WUgV5XZBuIDxgtoHB4X1SnoWAn2
 cHO68vFDDHgKoXppMmGAs5w6B+cHu1GkwBeBwdvdoyopxI+tZHBZQebBLovtmOXA69VY Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu258rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwIas018681;
	Tue, 12 Dec 2023 11:09:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d55k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6dfzwvgTQAZpkQXZpWJGrvvSKjTnYHTqW3PSo22r6rrOhNY1eFZiCOUwxAAqchL/LPV6H2uBE4S6jeLOkbA1MCPwE8mKPc/MHlfcQ281+K7NJnO9KVANlzUQ9efeRoN1NHPpBxRoiZDY+McU+9+NmhsA6XrodqzDo0FDyx8EdpqiPj5hpja1owOkMwwonwH02/Qbd7gtQ6VnRFZuNQWMb4MBSlKFba7w7dgSHZCKd2rd0dMrxN2pbaXMCKLXQFQwWPogKhLtfFEJ5VLzYGAryuIa5H7qGegCYS3UtpdC/AQwLoCfRV8SS1bNGYYEUtqmVZRooebH7uNf291rGH5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9uPYGSR98Rb88RfONFKc4B5xQ0ce0WEpJWuGlPoTCU=;
 b=LQCWI95oIStMdKp2VKqEETYGTRwhG/VokQ0kYr69qjLgqmkrgn4XU598+5K4G15QB53PDCAs7pmNLWp1dXDph31ZtmLEQ0qN5NM76c/MJSP8GPdgXZsIPxpI4JR7sDjqc6qFRNXbV7R8uJvwMj6QSb/Qsqxdj2B6iGltdrTtaF4rpP35ltnG3YY5nvYIGIkROCfoa8++LvUA3eLCwtHTUNNpju/IjxJKFjTkc3Yn2qHj2AgGAJ4L2h/ppg6V2f9fQICSo8dlLuFsn4iUneJISGlQUh5/3ob+gS2PeeGWr86r5opBH+TiPaBs8sgj+7AVPMeTVzgcNJYpYrfyJpvqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9uPYGSR98Rb88RfONFKc4B5xQ0ce0WEpJWuGlPoTCU=;
 b=UACCB3dz624SdpZQDrgf5J97z1Y8cPsA7xJr7JiENB3Xlg/9NenMCfYbEuCOExOEQdTyT7jbV+ESQwnPT6wriVsOV7MNYmL0nlOL0JZt+dWr3MS5+Z7rUFP8eyhnMwspPBgfknqXPQEf09hhKjSD3eiL57yXtrgS/xQjSu/yAg0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 05/16] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support
Date: Tue, 12 Dec 2023 11:08:33 +0000
Message-Id: <20231212110844.19698-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 551c8a71-72ba-4e49-ac47-08dbfb02c9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fl4oPW/09BJjkptrAGvunxT/uPA7RIHpOkBhDDsSjO1B/bRaFloUqY8kk6BkQv6TjnS8qJjhRZdFwxDjIfMjd0FUrk84wgjfpCgmt5e6OGpSL4oYJzlyJlURZNvkQkQkcel/69ccNBQvz2uUB1vdCtJltGX//5JicwUjC3SE1B8ZHz/eo7d8VDtP4PST06arwmZTKbMZX/n75wVCegDJ1vnwz9q7CWP8bLBXL489voJ/WmO5r2CqXzBHRkZ7nqPDRzf5p+tGBpG0lUjU71gvbcDICQc7Cl+CF/80BQzV8sYf6OTrR1jGjUf5AxYImHRv0tp2aSwNgIvCHH/WdIG4Ekb65uhZUtNFlOg4chi21pbofrUmG9dNAEdkM0nAvHO4Hc4SEyrabxzUCzzuCYSqaKxmBvdV2auNXy9jMki1Ao687m6RrKapMoVJnnAm9Cs2ZZjUoFYkgVnLkBNPRciNhul/G1HEDJXcl5Z/kmKSsnsB179JuCZzMYfSp3nkH+PeJCu/8+Ho4/IrG3m9ZEzwK5ALUeCi5KgEUMMGchkc067gWcrf0/Zx1ejaxAj0tpkeDQZNOj+WVGlYONJrbTBNizvPv+BGBKXPk+a2Dv86igs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(54906003)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wHl69egH9xBqAN9hIGoaQZiG9wgkLRPFnHBN0Kfoi96tEvTWQxcXLpGDWxIU?=
 =?us-ascii?Q?89uxlkoK4xz/g1DVlj3ZLtZWAxqJlXp67+dl4iNvv6l5KfFHR3w3LJQpGJoo?=
 =?us-ascii?Q?eHcJkDKnjMxeqJ3/gsxDUJS39m+9VGYH3wJPO4WFKoQwaisoU1h5Up0oMG/E?=
 =?us-ascii?Q?8VAsfiliwllZzFtnohgY6fy4VP8pEIcuy84Ic/4oZTW+a5cskruTxZLE8up1?=
 =?us-ascii?Q?cmWXgGt3CvAoB6qCXyJwDmO6ajpd5Y10cyxIAT9TaSn+8uJyXcXkJ999alKN?=
 =?us-ascii?Q?FIn2GxM/CPqDgVNyEPfjOxHX/ZJoI8AboH+FKEpO3vA8LS5rM37gpA1SRZkz?=
 =?us-ascii?Q?HstD1npWppKP4bvynSZN9GkMVYxG/YTLhcU2hbtWdV/mLda0EWlu3gupnSQc?=
 =?us-ascii?Q?DoDfMPkKY5DKM6xqL+QLxPTThbQ6JfeKSA+WrHShJfV0PUj+t1zRwTby8AJF?=
 =?us-ascii?Q?q+QCKNeOdYeN0Od/9vPjWCvbppmam0/MZriX0ADq73PIXL5nO+sz9Hnc4mog?=
 =?us-ascii?Q?RUyi3Q5C/byOkG8j4Fp/1kjJvqi9j34QexQLIkMzkom85UbX3sbrWKhDI9bS?=
 =?us-ascii?Q?PQiWlpl/FWJKROSCrROxJbt6MzRnTOLJt1kIiCDYkZ4rbra+04pYj6YtIJRc?=
 =?us-ascii?Q?nWH+GX5wnLuZOzVIAPVUpytzNAyIqSGNS0pY1oDuZnCKkSbftcSny8i5S9Fc?=
 =?us-ascii?Q?Jm2lLHZ7N3Da9SPZJDyaTbUTLMFbQri0tIqROi/Mg5meIRliEQc5jKTyHRc0?=
 =?us-ascii?Q?fvvPlpdnJvjrDzoKTO/q3rDxHw3f5V8sHqC3iMwxUlTSrfVIVjbnyg6FmuvQ?=
 =?us-ascii?Q?EVSkwKcw6to4rt81/tWj/38moASpMnlGR2kX+ZD76U6YFA1Tz4PLUG2RVLq+?=
 =?us-ascii?Q?07tYwCtddg5CPHWclmCHPoiEYEepVgjWVT9DFwhq6IPL0vOwI+bOplyYAoF2?=
 =?us-ascii?Q?yDMWoig+Cnl3jwAIG0TvCjft6O9LaOXbue3YJUP4CVWvaGce6cgMQD4i64mo?=
 =?us-ascii?Q?sK2MtyKQzLsPGrmdqYazPSL16L0cjWk+RaFtdGVIhLM7ZeHqSdz9iSfup05l?=
 =?us-ascii?Q?5ovP5OKZeZiQ0kdUU6uyUBfJDZ777AEPBcIC73cbKJDZJobtpWsxpRCttOvF?=
 =?us-ascii?Q?fPV2APCQ5vHxx49FpMQikS/grYhKuINmjNnqRqnQ9trvoAKzDtjReEtj8zuM?=
 =?us-ascii?Q?T9kbyo2S3BcQg0lAPQ5/uXrvxu06ZasJgDKQGRszvhCjxuhCdw0mx57GyTL5?=
 =?us-ascii?Q?N3LYueNMyg89W/1VWGWBXnBwjTbkeeRs4Z/otPNy19IH5/TL2w7blNyVFTxm?=
 =?us-ascii?Q?mwP5/cWRsUIwu7ORO4zMt3avP3UsJ86YKNTl+AvpgdqnHUMcwlhsigneFJiM?=
 =?us-ascii?Q?ZLZxa8X7mdHzGJKUzToLOrCeM0CIRWWDE9sMJE7FySpc/lN+eKBf1b0tIUIm?=
 =?us-ascii?Q?Qu4Hp5iMA55tO9t8XVJ6nnPk0ueC+/FvSDLReebozKOBSfybSpfBWneJcVoa?=
 =?us-ascii?Q?jWFXWX/4kxo9h44jgDqDjoPWTZGJO5okCSBEO8F4Ay6nWEgciJw5T71e1tCI?=
 =?us-ascii?Q?XlahsMIFHzISRrTpFKKgOUPkvNDfN1lV6LuhKHpVP1CnQtZDIU5iPJRSaCPH?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V9XoFZgPyAs9kGeVU/UHm1JayXTBHzkVN/ZWCbQx6Ph1DlVBV56E5FacPCSWsxgB4CrLLQMS2uxCR2G0SBoFiDtOlLSytE6lg2Cp9mpE2QduzOpAIYpUYrJYOvhWlIheEbc63pf37CFy9MRjUCKgY6f/B3ZliGSLx6s0nBZMkt+6lX6NrZh9xQh4FhcO3aKyEkXeT1fx1GK9MLPHw06+2hqBL8ggDX4lyX1ZwNpoCCeKXsbts9TLRm5C6BHIAoBRzNr8WfM11oOzVkgTMFnFN7oFm6qaXKIzAzS9P98eM0bfjtL4RD8KmT9jRPGMt8hTaPs84cnCUV8HWtiYquHfxLKjncvnJo6L1tIuPHJHQgoXl0TnlyfRcCt86tOujQTCcOZJBlYeHjN/kPjX4qw2AO4Icr55jJQEPBmXF+d0YlL+gQRmHB0d+pstzQ01zApomUhGdxvRz7dprXN4GLVa26dvh9Fmrx1mfg3zLxFlPopx9OmM7T5zSUO9nJUITMX2pT76UVwlLHS0cJeFcjZSUbqIKDtbNz1JN557JGKlwrN+sMO1ULuQaMRVkxoXR8mpn8pInFmNFAaI6R6q1DaL5hG0jz9ERGzrepkBftSEXHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551c8a71-72ba-4e49-ac47-08dbfb02c9c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:19.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29Lc2AFRS23sOfpHEB9W9E3mDcSqPMa03AJq3hpQ3jwIhdKwU2GwBLkoS+p78eAP7B6aDY2XsgqHchUzLD7pMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: _hof55kIx_G12pWsjH5qXTiXeXjdeOe-
X-Proofpoint-GUID: _hof55kIx_G12pWsjH5qXTiXeXjdeOe-

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
write is to be issued with torn write prevention, according to special
alignment and length rules.

Torn write prevention means that for a power or any other HW failure, all
or none of the data will be committed to storage, but never a mix of old
and new.

For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
iocb->ki_flags field to indicate the same.

A call to statx will give the relevant atomic write info:
- atomic_write_unit_min
- atomic_write_unit_max

Both values are a power-of-2.

Applications can avail of atomic write feature by ensuring that the total
length of a write is a power-of-2 in size and also sized between
atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
must ensure that the write is at a naturally-aligned offset in the file
wrt the total write length.

Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
flag set will have RWF_ATOMIC rejected and not just ignored.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/fs.h      | 8 ++++++++
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 70329c81be31..d725c194243c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -185,6 +185,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async nowait buffered writes */
 #define FMODE_BUF_WASYNC	((__force fmode_t)0x80000000)
 
+/* File supports atomic writes */
+#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x100000000)
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -328,6 +331,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_ATOMIC		(__force int) RWF_ATOMIC
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -3265,6 +3269,10 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 			return -EOPNOTSUPP;
 		kiocb_flags |= IOCB_NOIO;
 	}
+	if (flags & RWF_ATOMIC) {
+		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index da43810b7485..1a5c68d31ef5 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -301,9 +301,12 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* Atomic Write */
+#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ATOMIC)
 
 /* Pagemap ioctl */
 #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
-- 
2.35.3


