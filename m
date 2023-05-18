Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299D708769
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjERSBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjERSBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 14:01:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED4E46;
        Thu, 18 May 2023 11:01:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IFGswY026300;
        Thu, 18 May 2023 18:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lZEW0WZSJ5Gwt8lcIlG/Y8Gbzq3TBhBvP9IEAd7w9hA=;
 b=2phZMGnDvhrd/QjFOsYIrp4NgitbrKcMz9HC1XZ+joKcdbbA+PFnJG6eiTVDTJ9aq+Jt
 82Fji+f5ViMEawypTnIROX88/28ybXUWnmIoqvPQcJb/ML5orQtXLrhkR75LsVHPjVMz
 UD4PWQQdp/T2432mgssw98/YFq/UznLMUTO/9zFVlZ6l8iIY4GsIubhRDAKRiSXhDWrH
 JSy+Px0oiaousakjzIBZ0t7uGHB7IJxmEwb28tcwsbPPTxiUkg83LxtGMSuM8oRBcYHO
 gqcSJH+BXJmJ/p8XnE+q90+827SdrbgbNafLcbsv1sO8hs5t8nvatKZTJ8Mt16iU57ae TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc3916-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 18:01:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IHjUao036702;
        Thu, 18 May 2023 18:01:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm044443-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 18:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtYPC63w4GB8mlvozo8lNTQ2OVsEVdBGR0Usm8CprKswKc56hv7H691zbdMp0TRqzDX1yVOEgR3YAbaEFly9mQS9Gf5kn/P7XkBMrFKBjjtZjpekkfmtWY5SeBogbz0M80AUVQKyGQr2anQelKToD40oXvQyKzyOYMTGjpsDYoABSdu3ja/SO6/kjZof/LganIq13FY6rH4ZZtXI3XYMn4mWNRzYsXUNYff24n58nOOJK4KxUoDhp3AYVRqNubf52AU19b/IMfrhxfhfR1IP5TjLu1RA1C9NuHEH46KCugbViDmRaumWupfClbBw6qwSQOGDTVRsPw8hhnAG5oW7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZEW0WZSJ5Gwt8lcIlG/Y8Gbzq3TBhBvP9IEAd7w9hA=;
 b=P9ObJIYOWULPHn9v4NmyKrfqgZYCRttUPzG/FwpNJYOXleOGjwXa77W6Y9rMSALf5RFs1p+FX4QE946FWNNBRDevTU3wqQYVAc7+7j3Q+DZQihTJJ96kjUgwieTlzrUvtx4sSDzXBDXFSoIzHpTWKGEx342+dGdBZ+CQvKYfga+KpKDYjXMqr6tYkWJh3yunKZeaxDi75WiEzemvGHeob2Lw8AxpMeW3veHxpP+wg+MAT+vRqcTl9DDTRH2K1xjATObOSrg51es+pKRbWGD505/U8sfjsrqt++yLd9uKEHBVh84oAp4ghQjj9N0+riSFpp/HiQezCVurLjNuXaaFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZEW0WZSJ5Gwt8lcIlG/Y8Gbzq3TBhBvP9IEAd7w9hA=;
 b=NKIRCipLFTOIlUjC6l0rNSQFlAnMwOLRynCeXcd2hfADPTuzrFdQ8xqWdKXRhe1+w+1LjKVHDjcnHedes30yCehz1JiT73ryrjsvYOX1q0XQby9alrQiROaNNSJAB6jQEaXcvLntOH0W1zjtM28yXCAMGdV74gq+eAqy/CK/ero=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 18:01:29 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 18:01:29 +0000
Message-ID: <5fab1724-090b-9c22-5555-bf3df7ea165c@oracle.com>
Date:   Thu, 18 May 2023 11:01:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] NFSD: enable support for write delegation
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
 <1684366690-28029-3-git-send-email-dai.ngo@oracle.com>
 <1B8D8A68-6C66-4139-B250-B3B18043E950@oracle.com>
 <21ad5e62-b3d1-2f74-d3fb-819f4e6a2325@oracle.com>
 <C3B5A73F-2504-407A-9B62-A130CAA5E2C9@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <C3B5A73F-2504-407A-9B62-A130CAA5E2C9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b0aaad-385c-458e-d8a1-08db57c9e7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNgNnVNw+3V5rTSvhKNvnTWeolfaKCx/pnLaPiag9PDsDjhwLp+kR7DX8S2ltfx9hfOyS06Y7HzCcPgwb3GeiXC9XDYqHxRZvo1P2EVx84asszjutxX8iwg6yYFdtHlwjWjU0S5iBnpHhaFvdI4Za1+L9JLj4nutXKKdwCTEdE0/UvDsbkgl/YAeuZBXGRMlu5DImwbQKvhrAwHNz/w7/l3aGtZV1HNyNOKOdQISmpPSlRP5CGpYmTS6fUugifHq6rNdmlwwRIkc9Ua9jGzVxcjTPmB9Qbp6NfCcS4uhl4DA+ql6RyB0ZC8LsZzt9wEvl2Yld0iIbCZO0YjNBO19fxaRNXXtkMD8DXTboTcq+uswtErrg1MQ6BmX/wGf76k7ud8YHtdT3LDeo+zcu7a3Bb3gOFtzQ+vJkGE/S9uKBmrG1Lvx6V18qN73A6nvEBfKZlt1HsNxv7IGcq7EnC8gjaktatitRhKrI1XVQRhUo7VvxQ7wfkCMWdi4fTQwDtjn+gmvL5AtJhhUIDIFcmjoSj0ed6+hD1hkVJv4M00cg953IcGTEJJIfTUy3Cq1aAm1YQk6YXnfSiNLeklVpfEJrMN6xLNgUgeYCmjEwE2xMnP5M/R8gAoNjQubdKuAZgHs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(86362001)(31686004)(66899021)(83380400001)(41300700001)(38100700002)(5660300002)(36756003)(8676002)(6862004)(31696002)(316002)(66476007)(66556008)(66946007)(2906002)(4326008)(186003)(6506007)(6486002)(6512007)(26005)(53546011)(8936002)(9686003)(37006003)(478600001)(6666004)(54906003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1lemZFT1l1NnU1SGl4aUt0elFFTFlqajhYNGt5cHBtVlZPeDYrSm9xc2VQ?=
 =?utf-8?B?NkhwUEtwMHFIanUxdG9xOFVKR0hmeHBRN2VIUDFYL1VKNS9lWXc4SmtCY21v?=
 =?utf-8?B?bm02RG5DM1FMajZaaVJFeHA0dC9mTkhISThaQmMvWUFNakZnWTVIaGFiNDlj?=
 =?utf-8?B?Ry9CcGJLZ3Z0MFFUaW1NYUE4cXBsWEt1enpXSFVkRVNlY25HSjJRRjNCUmRW?=
 =?utf-8?B?bUJJNWoxRHU3Ujl5WmNDK3F0Y21zbEFiMEsrN3ZEVHBUU2MzWnNaR3NDOE04?=
 =?utf-8?B?KzBJWUZtL0R2Q2Y2TVBCYzJPWkV6am1ITG95aFgxNHJaeCtORS94WWM4YStw?=
 =?utf-8?B?aVAvZ3pZL0pZVjdMT3FtVVE2Z0g4dFY5MFN2UENBQ1BOTWk1bzNvVURUdTNn?=
 =?utf-8?B?WXNVcXBZU0NKUjZsN010akVqZ05GMU00cDdOejFLd1pySTFPSGJMaEMrcmxU?=
 =?utf-8?B?NkpwcURidjdvRVVYZnM1ZE45T1ZXZ25DemlnaTQ4U0kybk1YSnZpQnBOSVVG?=
 =?utf-8?B?R1oxU1ErMUhWTXc0UDBRYTdZRElTM09GWk5Ub1FEemE1azhvdE4rT01kbDgx?=
 =?utf-8?B?OTAzL2VnbG1DN3duRnQvTUNEWEwrMFFJbXFZWDdOZmY5bG5Udm1XdkU1V0ZK?=
 =?utf-8?B?RCtPZmFQQTcwRGxldjZmd1VTR0IyVDcySjdlR1dHaFBpMkRyUzVISVZOdjli?=
 =?utf-8?B?SkZVZmhuT245VzZ3TWxFRGlVUkd3VlgrKzRybU9seGpQZThpSDlGbkZWVlMx?=
 =?utf-8?B?Q1FveGRFSENQbnFHZEI5a1kzL2FuSHdFbWpqcWQzQjg3bk9QYmRaeExMVnZP?=
 =?utf-8?B?cy95MUZoN0pDNmMxMUhKeXBuNWJZeHYyMHRXd2hCSGlTOXkzU0dRNDRRLzFL?=
 =?utf-8?B?TVYvRXk5U3NwT3BQNStBOHhac3Z5ZzlGak5QMzNrMUlRakVlbUtSK0M4ZlJk?=
 =?utf-8?B?Z0VSczgwNHIwQ0NESTBsWk5Tc1V0TXFJNG91ZGllSHhHanUyMStBQmdnSWpp?=
 =?utf-8?B?QmN2KzdzZnZ2OXZ4YzVMRnJjUDhFbVd2QmY3cU1kU0kzZjQ2NGNaWEdsZHdk?=
 =?utf-8?B?RERCM3pFdlJ0dzJ1WTVtaGUzdzRwbCtiOG1YSytRMnFTaTFzMVovVVd0ZHox?=
 =?utf-8?B?aFNUSnpiZ2JjTWpnajNvU3hEdFZWVnl6NHU2K2RTZGh2b0w2b3g2UTBoYWh2?=
 =?utf-8?B?U0pFZ1E0MTdmTzhHYmRobHJ2SWhRZEVoQklZMHhWRzl4T1JmWUxaNzFwZ0Vr?=
 =?utf-8?B?V0k2REN6c245RHNuY1I1aHJyRk94NURjYWdWVnd5VGYrSzFsN2ZTMEhoZXVT?=
 =?utf-8?B?V1NrSHFhRUZwdmJzN2U5WmNwTTdsNGFSanhTcWViRUtTVjk2WERkQTRqeGhB?=
 =?utf-8?B?TkY4OWZBZW55cjNOOTFXZ2lhKzJOSTJOSmxRUllTYWZGcjFHWVVZNVdUOG1q?=
 =?utf-8?B?cUNRdTFtQldYVC9ZSmhGM1RIR1NBZmFVUkJBb3Q0UjJzeWZiRnZheTlmZCt4?=
 =?utf-8?B?UlBpWjgwTUo4YVI3eHlIMS9ZejhFNDlEUWZzRzJPdXlhT3FjcHZIQ0I2bUp0?=
 =?utf-8?B?QStVQWE5bEdGOGowODY1dzAvNmJ4YWUwOHlFSnArLzJwREl2Ri80UHFwU3Jm?=
 =?utf-8?B?UWZYdEdQbXFEVjR5NlJQUFpGT0hQYjdXMWMwdEh2UlUrSlJUR3dBeko1dStZ?=
 =?utf-8?B?ZzQvSEgyMmxYOFlXWmh3Q0dSWEw2ZzVCS1ZPR2wxTEpjazRqKzdOOUZ3bCtZ?=
 =?utf-8?B?S0FaZ0ZPUW9RR1FzUFZ5R1VKV2F3MjUwK2F3NTU0MXV3YjNDeExEVWFpR1dU?=
 =?utf-8?B?SXRYYW9UTVdvemwxTjk2VUE5RWlVMnhwWWgxNDI5VTMrN2xRcWpGbHkxNjBB?=
 =?utf-8?B?Nkx0aDUwWUorVWFuWDltOXk1L3oyVm0zMFArMi8yYW9pUjExUzVaSDY5bEFs?=
 =?utf-8?B?ejRCN2NJd0V6WGQzb2Vidklpd1B4RTJFczlZUjRrL3M4clpRSFRoc2J0alAx?=
 =?utf-8?B?c2JEblZ5bmV6NVFTdTVMVHRReEx0NEhoQjdnRkQwS0poQWVTeDBFZWtSK3I0?=
 =?utf-8?B?NktVUWlMcGhyMEE3MWRXZVA1bnUweGZkVFozWmJabkJSakNSekhpYmdhMUhk?=
 =?utf-8?Q?eq4IVMQKk3TN2lSp/f7J3fCTS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NFUjhHT27j6GZ6N90arAB7M1I7eDW93/aAZcmmQhk95Iamh3mfFu77Daz/XTJ3JHyPdJswcA+EE+V+6dzMYbTLUElcd4tXNPiM9nTcgkWDdBNDDAtHv50D17r1/FuPzWk3vFYqfIyUxbv0reBJa1pay3KFUl7onmkushkL266cN9pu7gCS1Pg0PmDuSjmW40j5YXOOEUgXjOUVI6dB37IW+ZSpEA90SQOEhVRhTlWKlPdmB1fWnhVEfweFXnsSzbsyI46G+K0hHGoDM6PBWdXCqYCQfvP9Fa7TGyItLiMk3RNgNgUQgMAHHOco4tk0iYQxzN5ZJ7BbLFL53GBsuqa6qyB7kyWI4lYmtXxXFFIF9xLOstEgRp9CmFu2OhSCMTG+jYZxk47A7UG79ikN5mzLH8H8702G+R4slYdX64S86yG4UoDoh+k7qQcT027hcMtsjFniqEkWXB07xvsF+rDmfkdKvZyKZOZsOPZ3ycBToKEiOPZHhiY0blzzMfD2NnK3dsf7vyHoiGRoEM3XPIBTUA56D4wxJTZkZoSHtl7iCM2uCgDFtXdQ8bV79VLnUWtAtyB5JmBtIgvmCUS//AZ0V2t8ptyqbqirfXI/p+09mP/rL7jhp9J2ojM8vKHBD3FaQabUWFlZPS32QRjbEVzAmjIRxVQV+1txcBQZOHHJwMLLeq2htROZ/Wvd8GrKJm9bbszwRZYLBZrV0g6W3Jg2sIV7ZxIt82seWX9qXKxRTi7NLJ5ENgR2rbiv8W1w54aNCf8CxsEUuDaiWRugpfILrJByxzVOLixBx2Lw38Yeo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b0aaad-385c-458e-d8a1-08db57c9e7ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:01:29.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzVRJv6Mjfk2pWdvCJrISH+NCeFgZ5RQUTadi0gnXEoEeKw6EQb0jLt0hZbdiBucvBFyyRqgrE6quL1qY6LiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180146
X-Proofpoint-GUID: -SFkZkmNNRc0dm6GaFOTGdPgsUCCkFt6
X-Proofpoint-ORIG-GUID: -SFkZkmNNRc0dm6GaFOTGdPgsUCCkFt6
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/18/23 10:16 AM, Chuck Lever III wrote:
>
>> On May 18, 2023, at 1:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>>
>> On 5/18/23 6:23 AM, Chuck Lever III wrote:
>>>> On May 17, 2023, at 7:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>>>> if there is no conflict with other OPENs.
>>>>
>>>> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
>>>> are handled the same as read delegation using notify_change,
>>>> try_break_deleg.
>>> Very clean. A couple of suggestions, one is down below, and here is
>>> the other:
>>>
>>> I was thinking we should add one or two counters in fs/nfsd/stats.c
>>> to track how often read and write delegations are offered, and
>>> perhaps one to count the number of DELEGRETURN operations. What do
>>> you think makes sense?
>> I'm not sure what these counters will tell us, currently we already
>> has a counter for number of delegations handed out.
> I haven't found that, where is it? Certainly, if NFSD already
> has one, then no need to add more.

num_delegations in nfs4state.c

>
> It would be nice one day, perhaps, to have a metric of how many
> delegations a client holds. That's not for this series.

okay.

>
>
>> I think a counter
>> on how often nfsd has to recall the write delegation due to GETATTR can
>> be useful to know whether we should implement CB_GETATTR.
> I hesitated to mention that because I wonder if that's something
> that would be interesting only for defending a design choice,
> not for site-to-site tuning. In other words, after we plumb it
> into NFSD, it will never actually be used after CB_GETATTR
> support is added.
>
> Do you believe it's something that administrators can use to
> help balance or tune their workloads?

You're right. That is just for ourselves to determine if CB_GETATTR
is needed.

-Dai

>
>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
>>>> 1 file changed, 16 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 6e61fa3acaf1..09a9e16407f9 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>>>>
>>>> static struct nfs4_delegation *
>>>> alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>>> - struct nfs4_clnt_odstate *odstate)
>>>> + struct nfs4_clnt_odstate *odstate, u32 dl_type)
>>>> {
>>>> struct nfs4_delegation *dp;
>>>> long n;
>>>> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>>> INIT_LIST_HEAD(&dp->dl_recall_lru);
>>>> dp->dl_clnt_odstate = odstate;
>>>> get_clnt_odstate(odstate);
>>>> - dp->dl_type = NFS4_OPEN_DELEGATE_READ;
>>>> + dp->dl_type = dl_type;
>>>> dp->dl_retries = 1;
>>>> dp->dl_recalled = false;
>>>> nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>>> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> struct nfs4_delegation *dp;
>>>> struct nfsd_file *nf;
>>>> struct file_lock *fl;
>>>> + u32 deleg;
>>>>
>>>> /*
>>>> * The fi_had_conflict and nfs_get_existing_delegation checks
>>>> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> if (fp->fi_had_conflict)
>>>> return ERR_PTR(-EAGAIN);
>>>>
>>>> - nf = find_readable_file(fp);
>>>> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> + nf = find_writeable_file(fp);
>>>> + deleg = NFS4_OPEN_DELEGATE_WRITE;
>>>> + } else {
>>>> + nf = find_readable_file(fp);
>>>> + deleg = NFS4_OPEN_DELEGATE_READ;
>>>> + }
>>>> if (!nf) {
>>>> /*
>>>> * We probably could attempt another open and get a read
>>>> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> return ERR_PTR(status);
>>>>
>>>> status = -ENOMEM;
>>>> - dp = alloc_init_deleg(clp, fp, odstate);
>>>> + dp = alloc_init_deleg(clp, fp, odstate, deleg);
>>>> if (!dp)
>>>> goto out_delegees;
>>>>
>>>> - fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
>>>> + fl = nfs4_alloc_init_lease(dp, deleg);
>>>> if (!fl)
>>>> goto out_clnt_odstate;
>>>>
>>>> @@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> struct svc_fh *parent = NULL;
>>>> int cb_up;
>>>> int status = 0;
>>>> + u32 wdeleg = false;
>>>>
>>>> cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>>> open->op_recall = 0;
>>>> @@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> case NFS4_OPEN_CLAIM_PREVIOUS:
>>>> if (!cb_up)
>>>> open->op_recall = 1;
>>>> - if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
>>>> - goto out_no_deleg;
>>>> break;
>>>> case NFS4_OPEN_CLAIM_NULL:
>>>> parent = currentfh;
>>>> @@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>>>
>>>> trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
>>> I'd like you to add a trace_nfsd_deleg_write(), and invoke
>>> it here instead of trace_nfsd_deleg_read when NFSD hands out
>>> a write delegation.
>> Fix in v4.
>>
>> -Dai
>>
>>>
>>>> - open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>>>> + wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>>>> + open->op_delegate_type = wdeleg ?
>>>> + NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>>>> nfs4_put_stid(&dp->dl_stid);
>>>> return;
>>>> out_no_deleg:
>>>> -- 
>>>> 2.9.5
>>>>
>>> --
>>> Chuck Lever
>
> --
> Chuck Lever
>
>
