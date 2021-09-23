Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2C4165FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhIWTjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 15:39:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3458 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242796AbhIWTjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:39:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NIwKWI012795;
        Thu, 23 Sep 2021 19:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HrMfOFnQRDN0kHwHBd+nS46Ey5ZzzsqC2hg9VexqUzg=;
 b=vc9AD1ydqwXUJNYgN3vGxV5POtPbbm2A1l2m4fXcEBFgiW0jM8ouDbEwprhay7U2mIkY
 IZJaXLS4oSeQRmpSItMIfo5Lw3llQI3y16s9zJ7X6/nNdegOJNuxo11UPlFq+qmnyjid
 igOMuZkqnd+/LxXGEAbVjnpbEj0lkmswuFOfCA+AVXWSNj8ekBdXYY0e1RFM2qBFsKv9
 6vBFkblmG6iXmVXK4FiRxgpKWFdol5b+OzIL0TR5pswnZxq03H7o6GU94P5uhsdAsD2h
 X6ZTwXcfa/GeippYdTm5mhe+AxnyCYw0YddAeyQYCkjURC01CBZCsqmSUD3GdIOqpe6a tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b8qkrbnjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 19:37:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18NJUtbX036424;
        Thu, 23 Sep 2021 19:37:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3b7q5crgpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 19:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCfT9yxVhOmBcbI94cNw67lx3OICyW85xrALe6aFvX7znm8E3TX56cK7zVAoRh1rGRWNfEM0KEJbSl3EcwkzJe+LCrHYhvHu48LFpiAjKaafuHMigl53j89rM2uI5wXXYESrIDDOnwS1uTRLFpiwy3PEapLOtVMC2bvfXehV3hhzK2sKkWWEh7RENjSE4YbgCAaKm9SwBz+AhQaWhRZYLVLzKvx/Ck8q/TrsURrJr7+SienoCkX0lJoOsYAoh3c1zK6pj62nQOfVuE6o0DzxL1wfHRAi1hwGlpL83h/0khxCGA2WQyU5n3CheUdJZXz48o1ELpXkH7bKu2B/Lu2E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HrMfOFnQRDN0kHwHBd+nS46Ey5ZzzsqC2hg9VexqUzg=;
 b=U+HrwV3142eZ6rVljXa11DEwUDYNthjQGeNq4sJyX8dWEsvuNohdMXO/UQpm2W7Pc/bZ/AZCRgqNHrGdrVbf3xfU6LxPPtwnPRDMt5Mb7vWrU4/REeqZ8IaeeLIY5q3rwM3uyD6mIsmG2CtRo3OFn1bpt9FnPKMleg2Nbdi9WKU2pshmUWs2CCu1wPXf1B62CeLIg3HA2C82SgzwFOsbtgY/AwTCoVL3gBH1fVfBB3bD0OCLptt2MJVcAe9+WJViT5bLnWyvW9FmTOZUOaIKgJIjV9ySh9EKtDHsOLcKA6miEOj27j/g8LiBouaQgY5KStO/PTvs2+VDkF6PgY8Y7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrMfOFnQRDN0kHwHBd+nS46Ey5ZzzsqC2hg9VexqUzg=;
 b=pUcl9WlmfK1qIx2u+Oc178rrdRJrWdemZgiNmvvdTQ5XBi8edP7+v/+wh81TB2hJxX+Fhn/4jhA7Cg9FL5qhU6UnSrZ/szOM45aZMg5k+4BvJfxXEpAR3p+GvbYmV7AJHAOwdHOTiU6/oNlTodh/ibi5oQkUQS/kQdhBBbpzwfM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB3608.namprd10.prod.outlook.com (2603:10b6:a03:120::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 19:37:39 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 19:37:39 +0000
Subject: Re: [PATCH RFC v3 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
From:   dai.ngo@oracle.com
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210923014733.GF22937@fieldses.org>
 <96ea034b-ca95-3934-4c31-14c292007ca7@oracle.com>
Message-ID: <028375b3-fa08-1dac-7d81-5eaede3c77b5@oracle.com>
Date:   Thu, 23 Sep 2021 12:37:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <96ea034b-ca95-3934-4c31-14c292007ca7@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:20::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-135-151.vpn.oracle.com (138.3.200.23) by SA9PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Thu, 23 Sep 2021 19:37:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f1d0ac7-9e32-4d84-a5c1-08d97ec99a45
X-MS-TrafficTypeDiagnostic: BYAPR10MB3608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB36085C67A554A0542CF0795387A39@BYAPR10MB3608.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymxbNYvgcpKN20yAiUQdlttum5SH9DEdH3vF2gokEHNtYerXAMkDC902NP4czdE5k7cXTUWdAVluRcdAYkyIlwgZDElVADJyO3QcOSVNKFfNbdP8AmyvA4rnQhrzF5KQwjpKKtzaHb5xjmNDGoL67DVpyAI9J674TuhiaQgewHOe0R54bMoBukhew7H3rwMAQWzwfA6hRnzHyE63rN0L6WvKAUvR5BxwwED17X3ZkPfKOs+uEFQQG6MbFMV0sR21EKGGs2Q2yUT4Vx3X8W8IlYbBzJJZIObGiV/7CgxZtjMCoOkgJk2v4moHs8BjXODG9wYb6dx4XQ7S0pZbDH4zA+7mRlnUvozFxQYUmvSZMA1xZ27dqSTtvbiGcKUeamxMvJAdlybk8Axogbr02Ow+uDq5qTXMjvhx1NSiyVGvkazXjACw9kDmDyojfZBnhQFNIt1TYv2BQB7kT71xCv7Zdd5Y63Ymco4n3npD/5dpAGisTfw4Q6vdEyYvwj9slMstHPk75thxzQXkgNHyYlsX4jewSAM4z1t4Ry1GgsnA6z3DBq3h87X9IHkygRRRaNf6n6myiRI57VwQQNc7mf+6z9pu1x3nXNacXisVICuPVXMKUO6qgPvb+ZRJK6+0DaX2004r8gf3k/s9+UdQW513GzUg1hz0UMp49Ck4suBp9h06iqxsR9xFRGo0MubXKOWFa5ZU38OnZ92Df15rryPVfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(83380400001)(956004)(31696002)(9686003)(2906002)(26005)(4326008)(8936002)(38100700002)(86362001)(66476007)(186003)(53546011)(7696005)(508600001)(316002)(8676002)(31686004)(6916009)(66946007)(6486002)(5660300002)(66556008)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdHZEs4M3BDSTdkQlVLRHFpOFdxVzBRZXFBWkU1cHdSc0txZUdtUVlFYlFm?=
 =?utf-8?B?UXpDTjNkeURrb0lnYUswWWlyQUc3eUlHNXhoOG85YmppajdNejQ4d3VsbHB6?=
 =?utf-8?B?dlFYRmRDd1dDU2pKQnZldUlOdG1BOEdHSUZHblJYeU1SMllLR2tuc291THRl?=
 =?utf-8?B?M0VhQ002dFVvYUI2YWF1bEJjL09qcVRPKzFvU2E2NHN0KzVJVUNXMEcxc2xj?=
 =?utf-8?B?VndqL2NjN1MwMkh6bFJma2VGbjFoYiswKzQrVEViRXpYY1JrNDdvWkVkVWQ4?=
 =?utf-8?B?a0g5VENQaDZHbFA3eFRIdzZQYXBZZGxoZ3JLczYrTjM5ZkpreThITXlBbFBL?=
 =?utf-8?B?ckFDTytJeFFrZlpZN3ExK2tubHpRNklyMm9ZMFU3ejMxNUFqMXNTYmZKY0sx?=
 =?utf-8?B?NWx4OWllQjJ3blpzdml6WW1QOElXVTRteGl6YXRGYW5KOHBLVWhmbHNJS0lK?=
 =?utf-8?B?T0JrUDlkOHkrTGY0Q2VxYWlnVGh0RVdlcFo0UlBBU1h4UFZsdHIwcjhyVkJp?=
 =?utf-8?B?cnpPM1dOM1VpMWdvcHdaVXA4cnNXL3QxQ2hNUHhMcmY4T3ppUUkxQkVXcWs0?=
 =?utf-8?B?SkM5MDBHcXV2QnZsK2F1ZDY4OWtEdmxIeEwyckpaQlZQNzJXUHlFTmxUZXBk?=
 =?utf-8?B?RTRFWVEyNFVqQ3dWWGZyWWpxeG5Cc1l6RVpYK256Rjgxb2ZZVU9aYkNxcW9N?=
 =?utf-8?B?RVFndndzVGdBZVgxbFR1cUpHREtHU2lnRnA0bVJlQ1ExRlVkaGR3eS9Lak9E?=
 =?utf-8?B?TVBBaGFCOU10SlViWHhKZWxnZG5QRGJxUFZrcGozb0xRdlZydlBNbmJQb2pu?=
 =?utf-8?B?aXhzR2FJS0xGdTdoYXhMeURWU2c3OVBpRmd5SEJKWDFaZTZuS0Y0ZFVES2JD?=
 =?utf-8?B?V3dVaHdDUGhBdHE1dGlEUHNFWmVrR21sYng4WlpMNGlXeXVpSFc2enVwcnox?=
 =?utf-8?B?VXNCdnpwRTFnWk5DM2t1alBQajhvb0NiS0J6TjMzSmR3dmdQamxocGw2UHNr?=
 =?utf-8?B?U24ybDJUZjdycS9YcUMwT1BHRlpwa29BREFGdXN3Si9RWno0UHBOYzR0RVdn?=
 =?utf-8?B?Y2NuRWlEanJOakgxaFhNL3VaTXVvM3JHT3g0ekVmdkNSWTdEMHZ0QUFpVjBs?=
 =?utf-8?B?U0ZMU1A0L2h5bFZNbnloV0MzZ2ZNYllwR25reDc4NHVNY1Iram1lRVhBN2c5?=
 =?utf-8?B?L2x5NlFuazdaM3duTjI0TTZNNEpJV1k1TzAyYzNPTlhqYUpOQXMrY2Zkc2cz?=
 =?utf-8?B?a0VBcVZSenRsRkc5TjNweXkvNmNBeU8vUDRFMWhWSTkwWURjVGVGTmxINnJx?=
 =?utf-8?B?dkdZNmJaa1dENDBqTWZRQytxNWtWWTlPY1lKdHlUSHJhYVp4c0ZiSTU5M05p?=
 =?utf-8?B?QUNEclhXb0tWczFCUWpDWEJZUjlLalJrTWxHbXRVUEdzcU9ENGRtU2RtY0Qy?=
 =?utf-8?B?bXRvOElncUhvQ3V6OFloY3MrV0F3YUJyK3hYbDRuL0pwd1A2eWk1aHNFMlZi?=
 =?utf-8?B?RlBaanY1NzNqcGpkY1dFbE5tck1TaWN5RHYwNHFaNjA3WWxFM2I0NjVBQ1JI?=
 =?utf-8?B?S2prYkVXVmdGRXE0RG1naGNpZitJaW5VeFJNTjMwaGdrZ1J3VFU4L29mSkpE?=
 =?utf-8?B?bm1wSDQrZi9jOEdlQUVxN2tVMTRqVTNoY2RkMU1jUHpHZjdxekxmV1JvRmxl?=
 =?utf-8?B?aFlGYVpHdVJYK21RZTBVdnNvUS9Cd1dkTlFvbFhVd3dVNDF2dUlSYk9BTHla?=
 =?utf-8?Q?l1TXlUsGo0WqtT6Gc5Dgu4zDpFHkaKVRERQ5/3O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1d0ac7-9e32-4d84-a5c1-08d97ec99a45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 19:37:39.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +x05HrTA7+x41SlpAHS0tcwVqeJgMlMbWl2cSu6kH37i3nwLy3+ImNTWQ+xiy15o5xug71JIbUHPVgWdgirr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3608
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230115
X-Proofpoint-ORIG-GUID: zFWqJftQH1NED4SCqSFqfT3hAMX-lppe
X-Proofpoint-GUID: zFWqJftQH1NED4SCqSFqfT3hAMX-lppe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/23/21 10:15 AM, dai.ngo@oracle.com wrote:
>
> On 9/22/21 6:47 PM, J. Bruce Fields wrote:
>> I haven't tried to figure out why, but I notice after these patches that
>> pynfs tests RENEW3
>
> The failure is related to share reservation, will be fixed when we
> have code that handles share reservation with courtesy client. However,
> with courtesy client support, the test will need to be modified since
> the expected result will be NFS4_OK instead of NFS4ERR_EXPIRE.

correction, with the patch for handling share reservation conflict,
this test now passes with NFS4ERR_EXPIRE as expected since the courtesy
client was destroyed.

-Dai

>
>> , LKU10, CLOSE9, and CLOSE8 are failing with
>> unexpected share denied errors.
>
> I suspected these tests are also related to share reservation. However,
> I had problems running these tests, they are skipped. For example:
>
> [root@nfsvmf25 nfs4.0]# ./testserver.py $server  -v CLOSE9
> **************************************************
> **************************************************
> Command line asked for 1 of 673 tests
> Of those: 1 Skipped, 0 Failed, 0 Warned, 0 Passed
> [root@nfsvmf25 nfs4.0]#
>
> Do I need to do any special setup to run these tests?

still trying to figure out why these tests are skipped on my setup.

-Dai

>
> Thanks,
> -Dai
>
>>
>> --b.
