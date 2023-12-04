Return-Path: <linux-fsdevel+bounces-4779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECF803A76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C892A1C20B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0728DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeVAMIlA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CEB0xlkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A247B3;
	Mon,  4 Dec 2023 06:49:55 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4DkUSw021724;
	Mon, 4 Dec 2023 14:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=w1Q9znamzmg/Q2nKQP2FuCwV/Vp8tU5+Ny21HJ0HMZY=;
 b=jeVAMIlAWZJ1yz13M2HYPHFPBr5ZRx9zagv754+lh7RtU9I6UIikoWzUmjY+CvUP2TCd
 DFObJrfLhvAQHaiQSxXYCMfZfEQAggE6M4QFSCazaoKO7zmdf68IrV0YTnJRaVnlydCU
 leZsv2N589zq0Uo92VVWU5JiKdYyzs+CPEG/brU+3tVK0ECif0Bh4FWhHZfrmLkXx+XO
 l/y/JoWYg0ACu0jlTS2Ums8Tv8i9LKTujf/oJdE5O6/pO9IWZd1lw1Ftu8N1lDx+TY1O
 19eKTxrqJ51TMrVZKHayoB0YB2SBiOwiqgkOACA/1CAHLPVdw045n6HnqZ65wIw66Eai eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usfxp06qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 14:49:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4E58kV014483;
	Mon, 4 Dec 2023 14:44:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15umpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 14:44:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn8IEZFQPT7rFOYehBggtoBgm5ClFYaJLOMp2SrWpOLEMVWciVbEz147BI4WN9+I9unviTIwVtA6kaaDUC7zA9jj59xk70SXcPlHqShZWvVyUCl4n5pakpdX3x67ZHjFGqFhbdDsfqpoqOilppWsNZ0+NXFN+2ZJxUVN2EqwHFVriKdF3ePlOtOcqjZ7E4+7dVXxkQMOSsxZIIF8Kl3bDaOXf3zfEnjFkUQT7z60mQJcjC16aucHbk9g/EYBOt67O7PcynFWghxcohC+W3J14z1yLc8NwMCJ4y4XaHyTwWcETXPb1IF2+XSN/VOLkuUmkoSE7P5zj7g/xjOhJm4nSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1Q9znamzmg/Q2nKQP2FuCwV/Vp8tU5+Ny21HJ0HMZY=;
 b=kl2Kmbt2LBpdU8yPq05BuYPOxjcdPj4zmztNth5A5dGZXRc27geDD1f1pfaWOE09v0pllCeFOtB9e4/himu4vsdS+G7AH5n3OcemqeF15+E9K6I1lALG+FsyUHTNBVd8d373iJ7lnXBgt+oQHnm16/32yaV9mrAkmhkaigisKouKq585nMaBZAeNVy8WeU/R7+9T98iexK3cbrosfN/jWE/jCYeHbS3qUefQX743ZkvD7f5/UM0oqT4UEr3MFwY6SH/6nvXNq6S3Svk4xhoZLt+A0+rNZ1L+ntR+/z61CRXmTqzg6beXYQX1M+P2QQcGpwzLInmnLG/zTsOf4K6g3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1Q9znamzmg/Q2nKQP2FuCwV/Vp8tU5+Ny21HJ0HMZY=;
 b=CEB0xlkzqxM/a0D4JaY/55cMNXUT4oTX91D1YOnLu5E+lqwVJqKdlBW3prFCxs/11HDg33Oue56iOny+lgSOm4ZUlhW9qwvKVCpT5sVXp3jZ+lAC4jrTIsUi2galrhZZNQQ+nx8l9b5r8PRXIu3i5ZMy1sdS81QiuofBa8I3NBY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4415.namprd10.prod.outlook.com (2603:10b6:a03:2dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:44:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 14:44:39 +0000
Message-ID: <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
Date: Mon, 4 Dec 2023 14:44:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Content-Language: en-US
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 40da94b7-be21-4c2e-c46a-08dbf4d78b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a3Z5xjNOFGB0WXbZfZQl/BRaNgsjy8cGtf+Sjj6X5pmAc7CrjHGGl9CS9h9GpM6S8VQoRYOj6tRpT8Q+r4PgRap+2C9aabbXcMyjN6dsyGl2XuQ2+Brcg+KPwQ9EYi1+uRsaJ26joWBNIy/JbSTAnYbcm0dlL80WdtJSzULV2On0NUGJ4Uo7yMEqF5sA2M8sQBlNnIzRdEBXwXyOTek4SrBcQu0gXOnBoRB8tC2O/RMwVtESFZMc429kMYpEfAc9gpyy/l0UU0+jwrY+yoDoMGPZMAm95Q/89O9fnqnzHGlbtj6Su96C0dSmrRRMD/zog2Z8RXVwGHNqPzDYXA1ousltpEMMqk5sxdVscbd67xCeOyrjCk556p+8sq2upW44BRYISFbhCXDar9gBu45yk3AUHs3PU7z6mtoWSHXEQPFRZBEPYngq6Jyfwaf6fRWJO/BBKLSChTLCZ3K1KO7YihHTnXfWaTvePi6UIJvNfop6KMG4jx6HKbw5JzhChyndUMEaOUFr1503/lmOeYUQ/JX2JbB0Jk+6lzz2bcjjcpsgSS7jPQa7QVGgixN1or0J27jhWLTwOSRb0+A4lm988sJ3Cot8kHoDNrmEN31XRd5g2DVBwM2a8j9eZyRS+55hY98Nx546NNVFeT7Qj8ON8Whh77hqeiXTrW6b/aeuNHkeDd3gjY2zTyoAiEAnmqN+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(53546011)(36916002)(6512007)(26005)(54906003)(8936002)(8676002)(66946007)(66476007)(66556008)(316002)(6916009)(4326008)(38100700002)(31686004)(6506007)(2616005)(478600001)(6486002)(966005)(6666004)(83380400001)(31696002)(86362001)(5660300002)(2906002)(7416002)(66899024)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFlCVThKdU9tanVHM25ZWlpBWHN0ZDlSUXZqTWtVNnlLNHNnSGhvM0dicC9Z?=
 =?utf-8?B?cVBFWlAxVUszellhVU5nc3lQbUhNK2ZxZ1JMY2VvQitPNHpmNExsSVBsOGtN?=
 =?utf-8?B?NkRDeS9hSCsrVmVSc0VMVk9sVGFtY3ZIa04rMmkxcjVZczdQRWN2WkhyZlR2?=
 =?utf-8?B?RWNudlljWmVNbzlTZDh3L2RYV3Zlbm92OUVVT1FNMEw2SmUyVzB3T3Q2eC9w?=
 =?utf-8?B?dEFvU0FBakJtQ3FSRVlCY3lhcTdHZ0Q0MUh4b01YYjFjU3NVNk5BMXM1Yy83?=
 =?utf-8?B?cmxjRjNQdjBSOTR2UWJVaURLV0pxRnZJR0ZwSlpFRlVoQ1hJYnRnRi9LSDRy?=
 =?utf-8?B?dm1EcVB3dTlEUG5qbDE2Rk5wL0pBeWpLNnVUTjV3aXh2SFVhTXFxT1J2Y216?=
 =?utf-8?B?K2QwNDJiSUFqYzJuN1FLNFhSY0JoZDRtRU5STHMrSGlCN29uSDZjUHFGTzlH?=
 =?utf-8?B?Z1VjT3ViZVFKMFB3TDNMcUhHYUEvck9CdDlwVTMvR2FHczB1MU9rRWNxQmRy?=
 =?utf-8?B?MituUS9DK0hKMk9DM2RBbU9aRzE3YlhLNU9oRzNNZFhhYWhndWM3UmlhRmI4?=
 =?utf-8?B?cEx4akhWNm53NGpVMytuMjNhaEVYKzZnNlFnMzlwM1BXeEM1a3RtcHRYZDA2?=
 =?utf-8?B?RGd5K3Q0aWpweEJ2allOYm8zWlVkMWs1WDUvT2RpbWtJbTJrQ3d3K0Z3Tnla?=
 =?utf-8?B?cm5VUTVCaWdaUnB5YXE1Y0psK1NldllUSlRRZTE2azFlNWF3ZUMyQVI2b2cx?=
 =?utf-8?B?Zk12UTY3USs2alVQaG95OWxMTm02ZzZPQ1orTDRoc3ZqdENPcWdRaEJrZVFR?=
 =?utf-8?B?di9SWjhPdnRPNS9lQkliOTNoUmNrZHF5TUw0d1I1UUFRUVhSSFZRcy94VnNW?=
 =?utf-8?B?WWxlb09yTWQyYVUzSDNXVmJadnhCSkR3QWEvdGhibmc5dXgvUnZqemVGK2cz?=
 =?utf-8?B?MkZKbGJSQk4zaW9GREt3RWJsRndmRUlqam80Vnl4UDZaYm9lRjdseTAvN1Rk?=
 =?utf-8?B?RGtmc0JpSjdVMFY2TXg5MDJEdXMxTnZNRVBDNmlTUjR5ZTUySzlnQXljdkZZ?=
 =?utf-8?B?QmEycE9UVUVtdGpsSHFGWmk2N0YwRHFKRDF4ZjFXSkQ1RGNybWFmQUY4bXpK?=
 =?utf-8?B?UlM2bjdRUnkwUy9wNnhHSjNDdmQvZjc2VFhWcTRheUFDTGJIc1FDTWVpVVd2?=
 =?utf-8?B?OWpIdWtUa1F6elEvRGRybXR2djNNR3J0VStlMVlEaFBsdGg1dHBUeVpKQ0FW?=
 =?utf-8?B?MWExemhQMklhQXhZcDU4Y2I0MnQzOGhUV0U0cFVIQktYM2ZuanVqQVhNM3Ju?=
 =?utf-8?B?SVJzdnVPZm1hVDduUUhFbDdsaVJSSTlmTTdIczdLRko2cXJOUWVwMng3cXZ1?=
 =?utf-8?B?QnV1cG40OEtGSGc1RS8zek13aGR2ZjcrWFF6RW1RNHhCdFA0MkVBcWJ2dnRL?=
 =?utf-8?B?NjhUdEkzTU9xT2JlUUJLcWdVdEFGZGJnSDdZRTVrYXhXWWsxNlJwS2RKOElE?=
 =?utf-8?B?RXBZT2pWbkFuS1NBNVhOTEdMRHMwZGVrOExmQU5LM3VmMTcxUTlDR21lSkhE?=
 =?utf-8?B?ckFmVkZZM2cwVUNwVlhMMWJNRnVScU5hQXQ1aHczenIxTnZpTHAxVkw2WnUr?=
 =?utf-8?B?ZDJhZ2ROQnFROVFkNGM5c0M1VTZsQURyZERmY2lQcjJuRWhxd0lKVG4zOEVG?=
 =?utf-8?B?bmh2U3hRWUhuZXRBdlJESkQ2WnpHS3ppL3BzcUViRGtRYjZpUWlQQjVQekJE?=
 =?utf-8?B?NG45VlloTXpwR1MybWVVMDk5WmlrTzlWb0sramtHV3JWdTM4SVRNQXRGaTVx?=
 =?utf-8?B?SmRGa2NPQWxaM1BPM2ttUXZFbUNrSUJTUlBSUDJ2b1JKTUxKK0pmV3NYY3FH?=
 =?utf-8?B?MU5WeW9DZm5Fb3ROd1NWclY2RjhpRk1oWnY1TG42YXcvT2tGalVVTmsyMHor?=
 =?utf-8?B?cmU2bk4yUStrWlZ3aGZtYjd2TXFYaXY4a2k2MjcwbGRXVU54Q0JhTzAyWEFW?=
 =?utf-8?B?ZXdxc3RBa3VSV2hoZWdQbm5KTUZjcWJNbVEzd1p0QTB6REFwa0lzZnVuZ095?=
 =?utf-8?B?SHZVWm16ZlBoNEsyRDE5QmdRYVNVUTIvR1haSGNQUEFlTmdVcjBjOTE2VnBw?=
 =?utf-8?Q?Y/yeHDtrBkEvWx7zPl/2z9xU1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rXWe8PVN/UoMkMjk/WzUg8MKA1Mps12NU33cuZ6nXWVNvTEg0pP8CoPOqkhaJTDHAgAVGBjnwamG178PfcTneF5gLSC2/kTseU+JkksydOaVjg4azv7EQ3Gb+vxpULsyDKsqYzIRsZZ/FO+HARoiggzA8KVeDlg6RX0GIvR5RjpywQetQuJGPulHNpsV9V5Xja9nCVnp2b2FJ54Qblg0aslS+cq3pcYKZfDdsrFQv44BNQHKp4gUpjEC7gdW+JrsxlNXBw+82roq43p2dQVfhpeBR8hexpiz9Bi9DaoPSW92Z+3HTnR5n4MJ5f5g+/rSGRlo1YZq/u7/7TAv9vTFZhYTr96AP/ktM4P1BsgmmIpRmNYl8eFZMjRNl3EqQfszEkHoiX0VGQDtDxM6xa7mdeFnpiIw52k8r6HbnYor9VqYFnctfar+iGblaFor2yJe6cxrgbpiJZttUQoP1IPjjdKdpXUFHTXLfVJa5GpXPArECk+areyZNGNFBwoH2gtrAOSCORG9iEKpJA1lZcxgMY1On3rpHD3aNdEOs8bzMsVftj0jZi06slfdGPpsxjfkoQK9Q/yNBsoLJEqqsExOzx5fVvOTu3SgaM6E7NO5bT5a33FP6/SdZQBK3dDjBHXVovY1qrIIQEkvdhii8cp6pYhdkeZRHhCef2zeBd8HItzOMEyfJg9ix1eTnH7Ra7e2AEeC6E8fy4Lb5GE4Cmsg7NedSlDNwzrng2lQGhYSykth492FNGN/zOTL3N5RQHTgCAQRESv5laHgIA4uWtYqvYlx0qum+5vi8J1IAluKGEwCz58sW/4+kN9KMeS9V+yzT8oziDaNBjDXepb1rL1OlBawKjtFZF3Ep6moBtanm00RKm7RQA8hvvCSRe7nS5PPITx1mcccuxnO7aRYx/6LEQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40da94b7-be21-4c2e-c46a-08dbf4d78b56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:44:39.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH1oSe/8O1xlg1miv73XcoSUe5AkhjgD0/c5yGdtg/GJXix1WOvfITH59pgsf2mvMZdtn/6aa4juEyBW0y/mkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040110
X-Proofpoint-GUID: UjMGxG2dPRmbaFrrv27w3ORSlpCZVFoH
X-Proofpoint-ORIG-GUID: UjMGxG2dPRmbaFrrv27w3ORSlpCZVFoH

On 04/12/2023 13:38, Ojaswin Mujoo wrote:
>> So are we supposed to be doing atomic writes on unwritten ranges only in the
>> file to get the aligned allocations?
> If we do an atomic write on a hole, ext4 will give us an aligned extent
> provided the hole is big enough to accomodate it.
> 
> However, if we do an atomic write on a existing extent (written or
> unwritten) ext4 would check if it satisfies the alignment and length
> requirement and returns an error if it doesn't.

This seems a rather big drawback.

> Since we don't have cow
> like functionality afaik the only way we could let this kind of write go
> through is by punching the pre-existing extent which is not something we
> can directly do in the same write operation, hence we return error.

Well, as you prob saw, for XFS we were relying on forcing extent 
alignment, and not CoW (yet).

> 
>> I actually tried that, and I got a WARN triggered:
>>
>> # mkfs.ext4 /dev/sda
>> mke2fs 1.46.5 (30-Dec-2021)
>> Creating filesystem with 358400 1k blocks and 89760 inodes
>> Filesystem UUID: 7543a44b-2957-4ddc-9d4a-db3a5fd019c9
>> Superblock backups stored on blocks:
>>          8193, 24577, 40961, 57345, 73729, 204801, 221185
>>
>> Allocating group tables: done
>> Writing inode tables: done
>> Creating journal (8192 blocks): done
>> Writing superblocks and filesystem accounting information: done
>>
>> [   12.745889] mkfs.ext4 (150) used greatest stack depth: 13304 bytes left
>> # mount /dev/sda mnt
>> [   12.798804] EXT4-fs (sda): mounted filesystem
>> 7543a44b-2957-4ddc-9d4a-db3a5fd019c9 r/w with ordered data mode. Quota
>> mode: none.
>> # touch mnt/file
>> #
>> # /test-statx -a /root/mnt/file
>> statx(/root/mnt/file) = 0
>> dump_statx results=5fff
>>    Size: 0               Blocks: 0          IO Block: 1024    regular file
>> Device: 08:00           Inode: 12          Links: 1
>> Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
>> Access: 2023-12-04 10:27:40.002848720+0000
>> Modify: 2023-12-04 10:27:40.002848720+0000
>> Change: 2023-12-04 10:27:40.002848720+0000
>>   Birth: 2023-12-04 10:27:40.002848720+0000
>> stx_attributes_mask=0x703874
>>          STATX_ATTR_WRITE_ATOMIC set
>>          unit min: 1024
>>          uunit max: 524288
>> Attributes: 0000000000400000 (........ ........ ........ ........
>> ........ .?--.... ..---... .---.-..)
>> #
>>
>>
>>
>> looks ok so far, then write 4KB at offset 0:
>>
>> # /test-pwritev2 -a -d -p 0 -l 4096  /root/mnt/file
>> file=/root/mnt/file write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24

...

>> Please note that I tested on my own dev branch, which contains changes over
>> [1], but I expect it would not make a difference for this test.
> Hmm this should not ideally happen, can you please share your test
> script with me if possible?

It's doing nothing special, just RWF_ATOMIC flag is set for DIO write:

https://github.com/johnpgarry/linux/blob/236870d48ecb19c1cf89dc439e188182a0524cd4/samples/vfs/test-pwritev2.c

>>>
>>> Script to test using pwritev2() can be found here:
>>> https://urldefense.com/v3/__https://gist.github.com/OjaswinM/e67accee3cbb7832bd3f1a9543c01da9__;!!ACWV5N9M2RV99hQ!Lr0j4iDHrfXisXOGZ82HNPefBtVDDGe9zbLhey7rRDfPE7A_tsrrQ9Dw_4Ng_qS7xTGCZaEWBKtd6pqA_LIBfA$  
>> Please note that the posix_memalign() call in the program should PAGE align.
> Why do you say that? direct IO seems to be working when the userspace
> buffer is 512 byte aligned, am I missing something?

ah, sorry, if you just use 1x IOV vector then no special alignment are 
required, so ignore this. Indeed, I need to improve kernel checks for 
alignment anyway.

Thanks,
John


