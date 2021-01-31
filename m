Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43D309DCF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 17:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhAaQLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 11:11:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhAaQLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 11:11:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VCFDQ8192764;
        Sun, 31 Jan 2021 12:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RXelkZefKUeyIb8bAuHIb8zg4NxN269MzGy4b54TG5I=;
 b=uuZgRc41Yr/XBfp7eDbxHqnMHm6RYv9sEtsU6fRcjzD+h9vXn7fTIu9Suucjv4SFitr5
 TSuE1RGlbXnWgvYfHwY1HHlQ6l/i28Z00wqf+mRdbsOJFEbZUdkaz2ZQeMvbeougFYZD
 Vcq/Z77aX/s230eB7yi5rgBPq47tuQsrcPMtyrguIpm/DpIrUv0znZLF/sJDi9Y7X0bn
 g8SpbhB99hJUldIixcdN+jqEGVMNzeNPCjv3q5k6cdy3PYfS07nZdKdeFbUySFfj6q1A
 1o8RRkixvzaN0PyKYS5XRFCEQrRQUDQwojNxH+PeiZrycencHtVssmAuJXUxpZKS1rZr EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydkj821-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 12:21:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VCK25j196413;
        Sun, 31 Jan 2021 12:21:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 36dh7nmyfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 12:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvkKtaeKZlM+AHRH5fXLySc/+pHDc4paKoF3jVIejGI6/JWy8mSQSqjQkkmsSGrLUZyt0QM1jXBiosMohR7H7ZT1PkyzABIgIuon85iYcNaqiZag9I0POFrAHhFqphNQDe34CX+SkHjLPPZ3/EvLnOYfArBWnzYLfdIyozQQZdMT3oUyCaSyOP5HKI12pE3MX1/YLJlWBdCnzb8FDu6neWwwMIs00DeuP5+QkXHEms8NK5aTiAGCM499x030UnjQOO+CRmmLQzc2oIH+AxagRtQNdfl6eTF9WAfox94ORIVaLVbsky9zxKjuiUkWq2fu4jQnfC+TQexuTnN8L+NAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXelkZefKUeyIb8bAuHIb8zg4NxN269MzGy4b54TG5I=;
 b=cj2aEGBJBH4iBVEBva5RCFp64diH2HXwQUWrQJri+UaB5oZrK3ztW3OVPESM+aCa5z1Tuo2H81gyuS+TVxQpOJvcQWJcE+1fR69li50OlLBhpd67PZ0wPuGizoRyuxAtHRVKVfP4TrVI6IjZMoEHNGDQkNY2CU59bGXuSBThSjr3LHxQPSPL2yL4O/X8HGTNHXf35K28t2IzulsY4AXQKY3FHZrbh4QRHdR4XPXI01A23vYolYVcZoen1I1sEWOEPE45o+4fvOaSEWFr5DmG7E1VEWjBbHw2XXu55FfcBVlizmwPUNvP5fnrfA8oqTrNnjCCiIGzC3NdJjbQQ/AsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXelkZefKUeyIb8bAuHIb8zg4NxN269MzGy4b54TG5I=;
 b=xacLqozssTQg0uQlzHwROkUm5IGw38fjroq/5Nxy7ZY7JcntxN8dOpwHTrF5r3DUQCLYqoSq6e3mZWaVY8qC9S+R2UdkX4Iv5+0UYsbSITktLK69NOMq5mdJLoqgOWfDrKB+d5mH1YKS5Y2NACw7bOzaamSzIAtpJwznmTy7Mfg=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3700.namprd10.prod.outlook.com (2603:10b6:408:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sun, 31 Jan
 2021 12:21:37 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 12:21:37 +0000
Subject: Re: [PATCH v14 17/42] btrfs: enable to mount ZONED incompat flag
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <51183faaa8afba3858bb48be627ef5072d268fc1.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <86fa2506-ffa6-8d5e-f0f5-fac0e8b3ebfc@oracle.com>
Date:   Sun, 31 Jan 2021 20:21:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <51183faaa8afba3858bb48be627ef5072d268fc1.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c074:cdb6:65f3:80b1]
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c074:cdb6:65f3:80b1] (2406:3003:2006:2288:c074:cdb6:65f3:80b1) by SG2PR06CA0219.apcprd06.prod.outlook.com (2603:1096:4:68::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sun, 31 Jan 2021 12:21:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cdfd48-13c4-4be0-48e7-08d8c5e2c107
X-MS-TrafficTypeDiagnostic: BN8PR10MB3700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB3700C03786B1849AD7C47D12E5B79@BN8PR10MB3700.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI4wqbpAfYclO9W9n7UZYorRyyS9TIS49JLSe9mcBAg79OysKFl+geYyTE3flLbFBKlW3K3FVH/tQZADlGrcIs56I+8fVSr3gEDqt/RoIWQqg0v7CbdJazqKUHwpcL0auM/6tav/Pbm8Nxjpd3l9yE7WwrV+bSYQYLCUaAHZC+IdxQGkG1UlRdQ7lN0InsxgDeBbip1P7yCDr9zVcQH1w12fgNZZ/cPaosYsx3XBm4c50GAIPWSHCW8It++TU4Mm6xic/ckfArsnCRjlsv5DbIR189HeDB5f+jkfwSqVlp8pAIagxc1lH5J63kMbiCCmu5Bq1KfgbSEWZVVywjj48EncTTHoQxoKBiKhA+Cul63LL8qRnDklGs++H4pl4thoqXVlFbC82j7YldhSKh9gmY+5BaUusCUXzPEFBbnaOOw8QpnjFIvqFh7v8vAOr/YJ7Ox0m6AWqqOKcuFc5qJVTBm3MTDbyksXNYyrKp3/BCH6+F6+a5zjdU6HSby8vX9pOgzx9kEHmUUrar2kkCvFtuYBu37jkrSN9E864jz1O3PQ3vGltJw5MSU10sESbmU1kNR58Z0pmkGv8BnC/369A+GaD9BiWMPi1Mr5ylPZ+MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(478600001)(4326008)(66476007)(36756003)(316002)(31686004)(66556008)(86362001)(16526019)(6666004)(2906002)(8676002)(83380400001)(31696002)(2616005)(66946007)(186003)(44832011)(6486002)(5660300002)(4744005)(8936002)(54906003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TC8zNE9Rb1U1RlBlZldxUkFOUlZ4Yit5dkQ4WmJQNXVyZkl0c2pKdlFtbWRj?=
 =?utf-8?B?NmJHMHdLRm1BS2JGNGhBZHh4QityQXlVS3hRVzFYT2hzSlVEWDd3aU1Ua0hZ?=
 =?utf-8?B?djJKTW8rcWJBN1lXYnZ2SHc5dWNxTDV5TmdQTjVuUi9ydlZUYlEvdG5mL0V3?=
 =?utf-8?B?cHYvaGpRenhSaS9ubTE0UWdVSDZvVFRJSjIvZFl4ZzQ5SmMzQ2xJZ25FYml4?=
 =?utf-8?B?R0owcjk0STV1K2pUZ0VLcmd3OUFVMldITXZUTSs4U05FUGtjc3B3Uy9aczhT?=
 =?utf-8?B?b0dsYW1laXVlaUJhRGhFZkVOWmlSQWtod2kva2grMi9TYXJLRUR0aERnOXEv?=
 =?utf-8?B?ZkJYWlRhczhlbWxzaXBQTVhuRllHbmxEb1lzRGJKVDEybWNkS0xrZzFNanh4?=
 =?utf-8?B?ck90SzVNSVZycG90YUNHQXdlS1RzamNtMitmcVM5eWhRMkJidyt4S0ttejhw?=
 =?utf-8?B?d0xNYnJqekJWZFRpdnpTQzIzcFpjeTBDOS9hbEljaW9YWXdYbk9HMkllYUlB?=
 =?utf-8?B?N0YvZGVSMW5vOUhRZis0OUlIcHhVS2RDVlRSY3dMNE9xeGY1eGVHc21oRGV1?=
 =?utf-8?B?WFRBSmVDOUR1TGczQzVpVDlNN2NkU2czZ1NzUWlOa2ZFRU5DcEIrTFo3cWhE?=
 =?utf-8?B?TCtsSC9kYWEvaExWWXNOSEkxSzl0Uis3eXlIZGVaMlZ6S29lbEpLT1pXRkcx?=
 =?utf-8?B?RHJMdStSZVZWV2VvM21ia1I4aFF6R2pnYmUvWTZUN0JYSEhmMUdpb2lyMjhj?=
 =?utf-8?B?SXlGTmlkZ0RlbnpvbTlyZFFxSjhvRG9sNFM5RjhsaEZUaEtnYnRkaVBwc1o2?=
 =?utf-8?B?c1JXM3Z1WmN5enRpWjlOK3JFOVBIMWNTelgwSWh5NGlHc1pQODkxdkJjNDZp?=
 =?utf-8?B?c2JyVnovYk9LOHIxQU9iU3k5dk1mVWpMUnZVMEluYklHVk10Unh5eFdzZm41?=
 =?utf-8?B?NHU2N0ZqREcvYVgwd0xiYmpmN2NzWkJ3bk5TUVpDaVRoeUZ1dVE5ZTNTTkdH?=
 =?utf-8?B?aXRMdGl0YjBiSWs1VnVxMVVxR2w2QVZ3ZVBBU3RieUFiVVNvUjJwc3Njdk83?=
 =?utf-8?B?TU15ZCtreTE4TW9OY3kwSWZ4V294VkpMb3BpaHZjYVRMc1pVb202UlVhenJi?=
 =?utf-8?B?OUV4SW1zMWRqYXNycE02T2pEZHptaWJkc2lsanR5RVRoOXFVb1lIR04wNjdt?=
 =?utf-8?B?Kzh4cXRBT1h4MGwrZ1M2N3JYWmUzZ3ZVNU5IODZadzBPTE13VUNPRXhTRWZq?=
 =?utf-8?B?aVd2VnFDcldQTGZzeEdEUFp0aVc3STZJWlZZTEkzcExFdVN3NGk1Q0VUUUxB?=
 =?utf-8?B?R3I5b0VHUU1yeFZqTVF0K0lKVU5Uc0RZV0tCQ3lmWXQxWFR6SlY0Y0RyUmxD?=
 =?utf-8?B?ZU5mMjVERlBjS1dmWUxQZW9tTG0xbG93MWN3MWIwdlJhbHJRcDdFRXBpUDFB?=
 =?utf-8?B?K3Uvd3VOV3grR2I2YktOVm1uRnlFYWxnMnVBOVlRQURjbDNtbFhGN0tvYUtj?=
 =?utf-8?Q?PB1XzYcciNN43vlVDeFSI1mMuy8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cdfd48-13c4-4be0-48e7-08d8c5e2c107
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2021 12:21:37.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUWz3h8X7SYL90blm9r6Ya2oz/NNpaNMcykGPO1tRZSfT5bUqdDVW1ZBFYvDpiMU2ioRTDKmt7sd2wx4GcRDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3700
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310067
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310066
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> This final patch adds the ZONED incompat flag to
> BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
> system.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/ctree.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ed6bb46a2572..29976d37f4f9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -298,7 +298,8 @@ struct btrfs_super_block {
>   	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
>   	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
>   	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
> -	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
> +	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
> +	 BTRFS_FEATURE_INCOMPAT_ZONED)
>   
>   #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
>   	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
> 

