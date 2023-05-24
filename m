Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACC70FF35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjEXU2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXU2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 16:28:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C319D;
        Wed, 24 May 2023 13:28:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OKGVDf006666;
        Wed, 24 May 2023 20:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f+99qlySoZ/CuEbvxF2MDoPLWH7C7zb4ilV0VojLjq8=;
 b=QBQ1M7mPdaWJW3FnNh5MBebQhp+oPOUjLOTmlSyXnjAfX5CHyKE8reEYwFz/fefR5Rm0
 TSXZXtlvxA9Nw++AQmYjTsVh/Quy/Eo0Wrkg2C4IiLUELy67ZSCe3krNq+r5UAk3YSxL
 s/qx3yFcjEw1ei8+OauH3TWDsITL17viv/N1ySzPV5yUQ9qz5zzhzBnUOXAxrMzUhIpz
 2VGQbNV1dYPuFzlDULSi8JTTQew4v/Lw38YM+N3/S88xZm1yTM64CUIL6kloIosEpBCc
 kBPEaoJpnPKUG2tHFpYd3JgCRmMJMhJvmEWZbx1PJ/t3ftLOl2ftaFHmgMVWrg2ZF5b5 ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qssfh00ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 20:27:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OIj8IN023588;
        Wed, 24 May 2023 20:27:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8w917a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 20:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4jBkh9lEMGqbxixGFvXT+FqW6j1uZhWR7Rd4XxcQsqrJh3C2gWAGA6wVQL3vWdm09u59oTOTvK2l9frG/iLr4m879MDbAl4UHCKcObaq0lqVTBDxwGH8HxUAd6WyH6V/L3oqcqP+k8UV7mF7g99fABjTQlGglJtgsnlQ3ybmfzzz9XUYawimCiT5oF5CfPzLpESeFXEXGooRXMFofGs1yX41LpyELf49udcHhn41DsIGrTWf55+7r6wnGAmdwvzu/1T5LayWPCGqYPc8fvQ8R53gk7DorY45nuIaJI6VNXCIGfrUvQ5hlEdRl0B9NOkcBoeYBi62cL5zOvRI9WhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+99qlySoZ/CuEbvxF2MDoPLWH7C7zb4ilV0VojLjq8=;
 b=KtnUeAB29YEGuw/V++S5N/uld5I2dy8sZFjLTt/S3EH1WRdy1UiLM1f0oYagptcFqyHTuFkh9rWO1DOT8zntYIRa10DXo/NMENmW2PpdT37q9N2WXTvfoarUuV4o6kNl5SDl3XQINHrlalZcFZ2VCxNuXM3Siz/fWgrqJx6J6dwnl3zS2QlbaUa5QPw5a9PiQH3BYoeWUhPRHFky30vywvzEbhgPlGT0Q/GXvO+2AAaIUnsXPVFpS8NvP0PoRb8gUcJN8fFMT7MxUVPb4jpcJi8gAhMC9pdla6MdkiTjQcIv7VZHfV2xD1gSVxUWe236zUo2Q7QV7ThLYszMYKOzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+99qlySoZ/CuEbvxF2MDoPLWH7C7zb4ilV0VojLjq8=;
 b=nnYtfjdzldDcM+4HQWms82myicw6GAP6ScakW3q/y1C4ge0UH6+b411ZJMNQ2db64zp+wzaCaFPwnwU9YYvlDbkUhgL/YKhw+gwAyd6t8t7JLFiM+GIR3xZhV0FwhcPUk8sR54mDPzva9ILV9THnF9UD90ObuQKG2H8hvLuMqrI=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 20:27:50 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 20:27:50 +0000
Message-ID: <9ac39863-e4be-8783-cd00-21d79d9baa56@oracle.com>
Date:   Wed, 24 May 2023 13:27:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
 <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
 <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
 <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
 <CDB5013B-A8D2-4035-9210-B0854B1EE729@oracle.com>
 <b4c4d608-80aa-7f3d-7a83-2e7b24918b02@oracle.com>
 <dc0c053d734dc5b45475cde015d1cebb78922336.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <dc0c053d734dc5b45475cde015d1cebb78922336.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:806:120::24) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CH3PR10MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 79463db3-02eb-4d76-3c4c-08db5c9557f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VphpUW3gBz1no3o64awGgG+O5WPPb4AsZBxxx3GUzz1W1hD4+PrPKdm0/K3H8a9+l+j9BVUc9bsjXAnVVIuKgCIBCFHSQNsS2kwED8DXGScGNpFi0Bm/Bq0JFKMFkMEeybDTuvxKFpDq/ivCN/QwIOoK0V3ZcvPznfTyuDn6rMhTXWeHpwMP352/zbGnFaMHxTRSKPQr9Mm8h+RVFm92oATJ2j92g7VGFrXHlnoOqXTOdJU9LiRSyyb9ku5NOeV/WUDXV+u9nJ/iFgPmGgxplxXsywFY3GcqyPLGmbKFbFNuAVAu8cgjsixSj1MsFxN7BHQwDc4aF65K/vyYDO274BpPiBba9SETkmdBjZeDNckplNDgZR9Ipgqw0q1X30gblGIljTZAK2ofV0X6mNV7OrTjMt1sqIqmLcjKYepBOKCglGhB3cG77OPFZoa1poAF/02/tt5E2kUSk9Bo97SkQWToO/wr7E98uWfaOLuH4PVjR7H/JpBSqEBzaJaSOsPfq3xh7DU1LWe3PbgpWeryB6gfBtkweCXxkk0JXXhD/daMAREtAyn9osuGjzH8IDBsa42iMaRYRWDHFLfS4wXdUsKrqDlyXQSRD3ODbVnO2mA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(110136005)(31686004)(38100700002)(54906003)(66946007)(66556008)(66476007)(478600001)(86362001)(31696002)(4326008)(41300700001)(316002)(6666004)(83380400001)(6486002)(2616005)(36756003)(186003)(2906002)(966005)(9686003)(53546011)(6512007)(26005)(6506007)(5660300002)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGgySitXbXdKVUJzenNjb2JVSTh2M2VIQm5Rcko4SUJGTWFoWk9KRXB2VkZ6?=
 =?utf-8?B?Q1M0elhpWmJoMmQ0UElTNVgvS0JLRmxLSFNuZ0IzYzhwMVQ1K1JMOXdaeFZ6?=
 =?utf-8?B?Vkwvd0xYNW5hTUZOSkovcWpRRklmc0M3cWJkVDJiZVMzQVUyYVdFNHhrcFJx?=
 =?utf-8?B?b2pveTFCYmFLZ21LcGtTTDFwMkt4cFNrdmNkWmR3Wjl2UUM0aWRwZ2JlaHFL?=
 =?utf-8?B?MDN0WXZXeXZkWjNZWVk5WFZtRkc3UWZoeVFZaWJkZUFXRm8rMDVXQWt3VmE0?=
 =?utf-8?B?Y1dNZDZzdUdRSnMxK2thWkpOTitsVUp1QmQ5SlBpaDA2MEJjRmQ1ZUQ0MllK?=
 =?utf-8?B?Tno2MjhvWGMxL3dVTWtOTWZwTlNZaU52di9hSUV3VUptZERtT2RGdFYzVmhv?=
 =?utf-8?B?TXhyM2l5RDdrdERIZzc5UnpzQXBZQmhBR0VFRkU4MnRMNzFPdVhzR2I0WnUz?=
 =?utf-8?B?MW1oa2R2VlplQ2NGMDJrcXEyRWU2emVLb2IzUjFXUkpMaTY4ZVNNV2hPVG5m?=
 =?utf-8?B?SFFDdUFQOFhxL2tOc2tCZHFBdVdTNlplaFJQU1JONlZPWVcyb2d5U3VSYmJP?=
 =?utf-8?B?eUpvVEF3elR6ZWdETFBFcWdFNllFckxHQXpYU0dHbllGUmhCdWd6UlorRzEy?=
 =?utf-8?B?cjNMMTAzbHpBL00xSkhpMklBZ09vdU5OeEJaUnBUaTJhbCtJNkVmcWt3N0dM?=
 =?utf-8?B?M3liWUlBbncwMGdUOVB6SFJxWk1ZNDNkeWM4M3ZCWGZlRURvVU9OK1JoeGFM?=
 =?utf-8?B?SVVPeEFlMGNjVDNFV3hUcWVtelVHcGdtZHJrV1hMRnVIak41REUrTy9tVEdk?=
 =?utf-8?B?NXRPUi9uczRPd29tSjh0K2NIOVQveDArdTBtRzY4enJ6azNlYkZxcW4zbDNt?=
 =?utf-8?B?UmRqMUxpQ3BRc2NQWnFmNFVGcW1DZnEySVVreDlNcThzdHFiT1FQY0FhSFNv?=
 =?utf-8?B?K2hOVzZZQzlxTUdhejhnM1l0MjhpTjByNUJ1b3hFQkEyM0c2aHVKTlVHcGhy?=
 =?utf-8?B?OVc5YTZYbzN3WHc5d0tkazZPbi9zYUJpN2c2ay9FQmFpZ0VwV0djWWJPaDhk?=
 =?utf-8?B?YVhjZWtTWnI3VWdGeUg2elBNK1BQbHdSNHRTME1RSXhvY2NUMEprdlVWb29R?=
 =?utf-8?B?YVJMMUJtTTlzdTNGRENpc0toNWJhaURXblpVbHVSeFZLeW1idXRUYllUTG9V?=
 =?utf-8?B?MWYrc2VXcFE2WkU5MU0wZlNyRnRzZ1F0Z2lwbVFUajRxUmZkZTdMUWNZNTNm?=
 =?utf-8?B?K21YQVdkODBkMUl5YU8wSXpTZldMZ2ZRR09GYzllbm9hMkNjYkFRakU4NFBQ?=
 =?utf-8?B?bmlUS0lwWlBNa21raWpEd3VXZ0xFNVhWa3h0OEE3V1VFNmxqU0dUU0YzZDRz?=
 =?utf-8?B?bExyTUZ5RjhEU0wrdkh1TzYxckxja3VWZEl3OG51MUh1ajdEVnhOL2VrcGJi?=
 =?utf-8?B?cFNLUGRac1BhZkJGRGhPWHpvVTRkbklaODhrWWt1SXJxL0o1NVVGRjl0QUFq?=
 =?utf-8?B?WUZPYTNsNE5ZV2tMNXZlNHlweW1lSHZVb05EWllHeDl0UUR5azduN09rb2FV?=
 =?utf-8?B?Q3F1dFhPR055aWJhQUpnY3hNZHdHd0xOU1dteDUvM1puM1drbjhIM0FyMTdq?=
 =?utf-8?B?dzJoOWNrTnoxamZSdWpHNDRMZlVldm9Yc0I1VytZVlJtZFVaejcwMTQwalJV?=
 =?utf-8?B?bk1kRzBJNlpUQmNGOFRIY1I4WDBvMThWN0N3a25rM09VV0tCZE1kL2pRUHNa?=
 =?utf-8?B?cXZia24zcGZpeCtIK3N6Y1FlN0tlUkh6SVp0ellXZkJtaFY3RmhNYXpBZm1C?=
 =?utf-8?B?dVZwcEw4ZUVqSmxudFF4Y3hYZldhT3hNcFVzaEJLR29YckR5ZXhNL1NJL29n?=
 =?utf-8?B?ZmdiS25pa0xFeEh3cFVqWmQxaGRvOGt5b0RuV1kwYlNaQ1hCTFB2U2ZKRnJ1?=
 =?utf-8?B?MGZnK0p5MmxjZU11WUVLQkRlZ1dpTDdFVTRrMVZMY3dQNUpSMmdIQ3FTNGlS?=
 =?utf-8?B?YkhHVmZQeHhMcWFCZ0doYW5wRk5ZRW9oaHFIVHdTQXU3QmQ3NXVuQkNSdmFo?=
 =?utf-8?B?ZzlEeDlxWHl6WnEyTkVoZDk5QThGZkJnMjZtc29xUCttWEM4aGlwSFgzNU9u?=
 =?utf-8?Q?KCkYyhgYd1glGHe9df76snC/S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P71kYd52EW1Nhv4zDJfBbKit8nvKecZ2Sa0f5PvhxBYI/cs6Evkaa/uYaW4Bbvl9V7dW53fIObwS7ZGTkM+svpdIV5tF3d9O9BM4Ydur/MV6jOMdsO0a3RxzJE8i09QV9kEA7xOs7fKozHRy6fShkkqIOELk4sGbDJv9Xn0eCuXvdBqyyk5vjP2Oo4Jk6mAticLoffYbpTPiOzyHTLaBq5teu90Rk1Hni1G0Bw7zldX1RXKEz48FIRL6mxAzcPdsmuEyDLD03i8wf1g631iuBvYVIyxCX6eJIcAiDmOcY18vD3kUpjR+Xfkq8fozi3J1RMRDMB8CfHRyB4VqS3bOgWN1LTqB+jFhy8capIWQmLkKM6w/H+05l/oZ/XoyKxCJcyCWVFatukwhVg7W2xOjykGPy+WGsoxRdgol0iHsuO49UeiDTVFm/P15RPbewsD3tX/Lgic9IAy7woSFIbtuxKcpVL0W6m08mtTn75NsfThtlUwIlQYoJM9KTnF+YP+ieMBcolYxXlfVLNMmCnivEGtvUCdcljjoAn9Z10yCjrk2VNFhw4XVP9XSFdoKyJHZS8XNFYQ3kajW1aZYcsk8XOu67dDKWa0JABZBtQONNMRzFLvm5UPsawshxvNVEW2Jq3dNQ3qRGpj9k2b1GX8sdo6Au6Ow1tZ6EhmKhB1ALnOXdYRcnVrI3oIH/GkYTTQjj9X+NlZmy3voPBFoei2gPM1QEIHpm2TrXU/LN0X+m5dM+LqcYFV8zLtOIfxonYiFrYCp8Mk9CkRzbckLUaHRPtTsYJU9vJMNy+rk78CGZLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79463db3-02eb-4d76-3c4c-08db5c9557f4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 20:27:50.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y77w7P6r5eTXacnOwX/K1l3pwg5eqqITFt3jkNtN5RythvyHiqk3j5YWyfrpPkULbiQ8HRnYVZHyddXhjrx3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240170
X-Proofpoint-ORIG-GUID: TUsyNnfsPrK-cDIyk5ZANPCqybTSYtXS
X-Proofpoint-GUID: TUsyNnfsPrK-cDIyk5ZANPCqybTSYtXS
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 12:03 PM, Jeff Layton wrote:
> On Wed, 2023-05-24 at 11:05 -0700, dai.ngo@oracle.com wrote:
>> On 5/24/23 10:41 AM, Chuck Lever III wrote:
>>>> On May 24, 2023, at 12:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Wed, 2023-05-24 at 15:09 +0000, Chuck Lever III wrote:
>>>>>> On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>>>>>>> Remove the check for F_WRLCK in generic_add_lease to allow file_lock
>>>>>>> to be used for write delegation.
>>>>>>>
>>>>>>> First consumer is NFSD.
>>>>>>>
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>> fs/locks.c | 7 -------
>>>>>>> 1 file changed, 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>>>>> index df8b26a42524..08fb0b4fd4f8 100644
>>>>>>> --- a/fs/locks.c
>>>>>>> +++ b/fs/locks.c
>>>>>>> @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
>>>>>>> if (is_deleg && !inode_trylock(inode))
>>>>>>> return -EAGAIN;
>>>>>>>
>>>>>>> - if (is_deleg && arg == F_WRLCK) {
>>>>>>> - /* Write delegations are not currently supported: */
>>>>>>> - inode_unlock(inode);
>>>>>>> - WARN_ON_ONCE(1);
>>>>>>> - return -EINVAL;
>>>>>>> - }
>>>>>>> -
>>>>>>> percpu_down_read(&file_rwsem);
>>>>>>> spin_lock(&ctx->flc_lock);
>>>>>>> time_out_leases(inode, &dispose);
>>>>>> I'd probably move this back to the first patch in the series.
>>>>>>
>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>> I asked him to move it to the end. Is it safe to take out this
>>>>> check before write delegation is actually implemented?
>>>>>
>>>> I think so, but it don't think it doesn't make much difference either
>>>> way. The only real downside of putting it at the end is that you might
>>>> have to contend with a WARN_ON_ONCE if you're bisecting.
>>> My main concern is in fact preventing problems during bisection.
>>> I can apply 3/3 and then 1/3, if you're good with that.
>> I'm good with that. You can apply 3/3 then 1/3 and drop 2/3 so I
>> don't have to send out v6.
>>
> I'm fine with that too, particularly if other vendors don't recall on a
> getattr currently.
>
> I wonder though, if we need some clarification in the spec on
> CB_GETATTR?
>
>      https://www.rfc-editor.org/rfc/rfc8881.html#section-10.4.3
>
> In that section, there is a big distinction about the client being able
> to tell that the data was modified from the point where the delegation
> was handed out.
>
> There is always a point in time where a client has buffered writes that
> haven't been flushed to the server yet, but that's true when it doesn't
> have a delegation too. Mostly the client tries to start some writeback
> fairly quickly so any lag how the in the change attr/size update is
> usually short lived.
>
> I don't think the Linux client materially changes its writeback behavior
> based on a write delegation, so I guess (as Olga pointed out) the main
> benefit from a write delegation is being able to do delegated opens for
> write. A getattr's results won't be changed by extra opens or closes, so
> yeah...I guess the utility of CB_GETATTR is really limited.
>
> I guess it _might_ be useful in the case where the server has handed out
> a write delegation, but hasn't gotten any writes. That would at least
> tell the client that something has changed, even if the deleg holder
> hasn't gotten around to writing anything back yet. The problem is that
> it's common for applications to open O_RDWR and only do reads.
>
> Maybe we ought to take this discussion to the IETF list? It seems like
> the spec mandates that you must recall the delegation if you don't
> implement CB_GETATTR, but I don't see much in way of harm in ignoring
> that.

Yes, I think we should, for clarification.
Jeff, would you mind to drive this discussion on IETF since you can
present the issue much clearer than I would.

Thanks,
-Dai

