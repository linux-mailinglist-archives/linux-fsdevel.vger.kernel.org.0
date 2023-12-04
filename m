Return-Path: <linux-fsdevel+bounces-4796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83C803D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FF71F2123C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DC2F861
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKUTAwtO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gJwB3UAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684CAF;
	Mon,  4 Dec 2023 10:32:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4IVCPM009339;
	Mon, 4 Dec 2023 18:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Dq1cwoGrdsF8rX2j/190b9/CpmyAijmH2otOIHadQwI=;
 b=gKUTAwtO1804stz0bnMRkRIUsFUx/9mozb4g7epOMLZxaUW8P0ax6xGxvXsiSHAa9AMJ
 wUjjA6TRYVvoHwouanqOEwrZQYJd2gnOBwyowUQdoODCEpraAxV5I2Q4k7+/0gqhgqJZ
 XOQKJogQpzfF+jzBfA9hJNl6Sh0dETj5EyuZ9XVHfSvu71peMLr6wel7/CY79kIgfm9m
 6g+qZK7Y77ztWUhsEpKnt0zGm0+CZMA8XqgKoXUKk2tJLoGUS1cfPXprR1HHtRP4PiLX
 2rPHZr8q2QJ2tsVp8fbJb5GQJ/6tXNroD/V0yHQbgDDDnpGklZQgG0VcsTWg7trrFZOl bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usm488054-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 18:32:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4HldBw014421;
	Mon, 4 Dec 2023 18:32:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu166gup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 18:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaoxzNsLQbEW8q4rYQ0hVTi7p5PJBPSyU/bWYZhNg+kQP29IlmH9H0MpgqwaAR3y4D5X+XzVYfC2iHI8ovrhiMCqMbbumFAScFu2bU/e6atQdMh3hE2g0cRrM4CHCis2fxDTx5utEU29OmGN/rljURMrNKzyqtEaTRvh4XC0vmZBtrm9JzjoOOlskh/8oLJFEsksf/SuPENHHLZW0ucBMXpOlVF22L8Lg2etJssmO672vhM6LQ9ckX0S6TfSVjxcFoP4Qz3/Ovk6XQK7A9e0LusqGiFWc3bnM3WsEr+6ihxN2UyeDhoLRVbmG4MEpei6DYUiKqPM9WOdMOUccJsthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq1cwoGrdsF8rX2j/190b9/CpmyAijmH2otOIHadQwI=;
 b=BBenIr02/WT6uKVt51d/TVdyNfSrvMlxGQU4+JmyG77RUqPyC9XRM/wPfppq9IXkxad0k1iPjsFluf/DMuDQyIgqsRJybsr4Nqc8VDUdQe9tzz4SYjjgIyOBBV68KVVrfOLFb9HW4XAvZbWDQKt9X7sOHkdnybWo000YVo7MfuLih3MWEQwmSlHv7DudMbumgOYX8RNZQhdJ+9IF5LhH/+abHJXdrmaqAnSR7Ndq5Wy5rsKUdlMBrF9YsmztPjOGQSImAPOoHHmdE88pboI53H8cu7ISu0CZhlA6bWTzCB4D3OFIvHgY/j4AscVBYo1z5+05AOWvHDDDBEhUfbteCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq1cwoGrdsF8rX2j/190b9/CpmyAijmH2otOIHadQwI=;
 b=gJwB3UACPAQcWwOLfUUsszbN8tRdXRN1iIlPood3LxmEtlPkOCP2EB/4EygsDaTpxCoZvUAf5YKJHNzYYTzISR6wRBpawgyKpPUozUC8wNqpTAgSBtlrOzwAEWFPDXuYVps1sNDirEq3BYAidesJFajQqKg2xmkEPcqhfdXDhM0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 18:32:39 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 18:32:39 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] mm/hugetlb: have CONFIG_HUGETLB_PAGE select CONFIG_XARRAY_MULTI
Date: Mon,  4 Dec 2023 10:32:34 -0800
Message-ID: <20231204183234.348697-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8739e990-057d-4112-58d2-08dbf4f764d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	64/juXkTiISEzjSaLFWt97dZC611Da1ROs+IG31Q0qyjw42vSOSVTHK2aNgKTkjnby+EWBC/pBCQmqtNU0N8//BOPpIcF/TRXEZ15d4SrXbdAAKPhRSf7oCVKjsi3VC9Z2LvMEBRbOfyQfdEACuFMR/+At9JZOjIarKkTzJ+sPmWvuo7v1m1wx3x0OI9iI1XblDr7X7lWhlB/8xBPGEDAlO/kA/Oig4n8k7b5fFE33EyHB4DBDUvos2uJ7KufnmRspNonpIEZtgi5DhKX2PtUZ8ZWiBqxR3RUWn8A5N2gUJVd7fD6+i9huw7biJjcoJUuB/R4Uleu6lWRQ1/qrNmVVGphwOEBxbg46/h5mRFZUdqUCjY93MzG7q/vIMdt3FobSwGWtXB08fEnMcn58cO5CHQGMj0iC4WZMN+C58el/rwu69ErNHUU3LkIAkAQj7XZZlUmmBeAacOKSMbzWtpirFR39pGkachgImK8qsCMvy8ynUgDC3/xCc1RivJ5v7boJyexiF2L8U5OgJPITgjDFB0NhughhWfJOO7m1HaUFjLVMerXp2f+5eiqJ9sH0zo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(316002)(54906003)(66476007)(66556008)(6666004)(6486002)(478600001)(5660300002)(41300700001)(36756003)(2906002)(4744005)(4326008)(8676002)(8936002)(44832011)(86362001)(2616005)(1076003)(38100700002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jS3iwdc0A8RUgpXYA9DB6ifm1t7LqKbyGsk7ramnXKPgQtu98ifkNV/clAsa?=
 =?us-ascii?Q?Qm81wVAOmblPCFyEkPgAyODo6wVXgVF7N80z2l8wRlO/EaKriRpn9Y/2UGwk?=
 =?us-ascii?Q?SjuWiAC8VrR+mDt12OU7N4CFoot5em2+YoM5KvDPxWpvpAXi6BMukVuTtnEl?=
 =?us-ascii?Q?b2Mdo21L1Ab4NnhCexNbSZnO6cOfuqgodW0aRtg6aXfC35Opm8ImGMS1DXEb?=
 =?us-ascii?Q?7lI3Ud0sROmVdJ7KW66G2XDz43EGDKVqTqWvnp0xcdsi8WFyMeU6h7HSrUDD?=
 =?us-ascii?Q?e+44kRzcQaBKDptXlcnwwDn7To0M5SUWBRKu4EUz/WlHqHopJLrGUf2li4L5?=
 =?us-ascii?Q?F03u+iCFhypqnNPMnIg4j/bProuubVnVzPo69BegwXffruJl2CcvlNj+S+L0?=
 =?us-ascii?Q?aJBXymH3RM0sPb+h3kvGd1Cz8Q8FmwIC77E74unbfkgmD7MaFL5h0Z+aEI9h?=
 =?us-ascii?Q?pPv5sZ69qsy+STmsH6bvZfcP1quqW8oCzgU/eFQU1XskS76JccEixdbktUAn?=
 =?us-ascii?Q?2Otq1NJ24WUqzM6TKt5PJw++ztNzrFBSgO+aAEIuPia5ALAhksusmbVFQOLq?=
 =?us-ascii?Q?3sxBKYeeO0Z957wWDF/4fTkumoE6+EgMjJBvL1tFjHFkT8Y3cWoAZUx6qd5M?=
 =?us-ascii?Q?GYcLsUjtIuAGYsunmFT3bEmd2CWd7jmc99Pe+n4vmj2kT3FnmZA4xElFPgX4?=
 =?us-ascii?Q?gGb9DJ0W/1XxglLBe6tCh887XIUGiod+w4Q6JqCkoml49U7Zo3AKD5OIe2qE?=
 =?us-ascii?Q?PMxP+ZMBelDBy0kVccrDN24asC3y2W0ApBPZfx5Jter5eJf/21LU3DpvMlqz?=
 =?us-ascii?Q?a3Cn7N0K4djBjGCEe9O/8CK1tFAqFrSCnRsS+qR3mhE5egZ0H/1tJtvCsAHO?=
 =?us-ascii?Q?9pJaKvamEkAwrK3AUmm6Kpemd3uFGqnjjiWpyZvjve5V0KFlQ/7TrzyJYg9U?=
 =?us-ascii?Q?uW39qd3eZLMTC+43Nb8768fChno8E1kadSHVuP/2lRZ/U12mLwtXy10ISo9D?=
 =?us-ascii?Q?H55NzV05q/BmBIzeg8VgcydF0Qz8MxWpBjo5+/bXoVj3Avu57joqMSl76u+c?=
 =?us-ascii?Q?IfllBc8yAocm3sDCPEt0pC+5L55kspN/NwBup7DRwJcxlqNI57dfPE7ZbQWg?=
 =?us-ascii?Q?fQEGYV7A7m+PeCSH4jMxBRETReHNWiY4ijyHAzFNrxsAOJR9SAJyt/fO1SU8?=
 =?us-ascii?Q?B/jM0PhaLd7AAS1Frrga1raI+qSHoqtHxooFbdKRIaS6k2kLnpZCIxXxyykA?=
 =?us-ascii?Q?nV5dpoBBY+VAZgVXdO4O15O/FIkiTKp24akPyQHrvgeC91gFXIhEj9MwyxLn?=
 =?us-ascii?Q?gyA7uUT5vKUwFdEhrywQfncHzjPwMF8xdYD1wn/z1OOOFH4nfoOgR4Ay8Ts6?=
 =?us-ascii?Q?KEmB1WCoWjpgqXVmD53c8k5FxsK5vjpSJqxkZ3+xbp7XS4dVWf0xRh7Z60Oa?=
 =?us-ascii?Q?UDvIEFKgHGmemNOXtWVPuCgs3KXQn2EvZAipjTa37SqHF6czlj+FhZGzbd0E?=
 =?us-ascii?Q?5mBSJ8zhKMyQOnjWP+oyKtQHXprmis9jCo+m673SwM4tID1Uub240+d4Tc5Q?=
 =?us-ascii?Q?V1987bebPoGGVCwgK/UL4vFAX1Bl6pxkssHHIWxkacszFwzeTENn6hObq1lh?=
 =?us-ascii?Q?64KONnE6w33KzzVeaJVz3zo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RJyEy5t7VjXfOj9eJUAmixiBJpsgJvrQQANgUBslgTC3EPvSTuijX458mYIh1UmylqvH4/yDBLqxm98iXjwMC5LmhgnhM5hjtt9pjaeZmnCFlcO0MNUXlUZWEdFKqC/OzCsHKjRys/7ybXg9S2Xsr2suU3QDXu8jceMOi+nJAQJ1fBXDwkG1l+Tythq16HkBhBjpnF6bY9yLd86dWUlcFMxJC1NbxVkQeJ7SNojjophfjTkkmEKWeWVB4JGeeiK3mTXD/y8DVsbuzazyyqq19XinNN1CqlxugFZfqo/ZH52LHUZGY6HPYAJNFnktyxXRz4uOfhn9q+828hFyPHS3Zg3J2JAWkpVWFSWCvBOmDmS36SKRce+0m3xrJN9CvMI5uEEWfAt8fGsKnP+xDCS8kOhfjSZQOupdhwhJQRAelh7rg8DEhsdWo29ChR7YJmnAyI/2sZbU45ScuqF+TaM6KDOEv8Ev9QKGts1Zr8uAy87V9iIN4hKnzGiWcD4Y7f6Hcy6jXLxqAScH4Juf1lNKq/AWsjI+P0VK0aukx16LHaW14X0h5HqSCLtSo+Q8Nz+a/rDxaAmQ7hEjwOekW7RnNlAHuiJpNifbXMtqTROyfKq08lKE3wVccV6+IMNSIeXnmhVdtcLlEDJVKRwFoso1LaeufACeBuYwufe2+e/SUUfLafHOsqIH//xtptLelPbvVa2p1psQjVBVfyeVDbsG+gkuIhT2kTehu9JD/GOCym8EgxoMHFLJo4D13734kjPkIYinmUxPcmPSpqU4/P17AvhxCUtojlTcptnqMxwOKZKYZLE79z6qOx/xAB+VWcKuRCCvnPfpFn5V/E+A0crnpcndOfR5W/IqFUGa6nEWsz+17w9aIOdps/ZFVj9VxQDkLmodrCEDPRzFGZv6TyC+ae27MVBv/gKOHetImxxAhxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8739e990-057d-4112-58d2-08dbf4f764d1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 18:32:38.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJmhG1Swimcpu598QprU0m/oANm+Ok1sHdE4t3bP4XBWyGnxWMuoIB3BNa2bW016jWrAYsOZROJnPZovNziYUhpUjWVxVEkTFwAc+X116q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040143
X-Proofpoint-ORIG-GUID: 9ME4yC1tXOYa7Ik8CNFF8QUxh74iqCGk
X-Proofpoint-GUID: 9ME4yC1tXOYa7Ik8CNFF8QUxh74iqCGk

After commit a08c7193e4f1 "mm/filemap: remove hugetlb special casing in
filemap.c", hugetlb pages are stored in the page cache in base page sized
indexes. This leads to mutli index stores in the xarray which is only
supporting through CONFIG_XARRAY_MULTI. The other page cache user of
multi index stores ,THP, selects XARRAY_MULTI. Have CONFIG_HUGETLB_PAGE
follow this behavior as well to avoid the BUG() with a CONFIG_HUGETLB_PAGE
&& !CONFIG_XARRAY_MULTI config.

Fixes:a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 0b404e61c80b..cf62d86b514f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -279,6 +279,7 @@ endif # HUGETLBFS
 
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
+	select XARRAY_MULTI
 
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
-- 
2.42.0


