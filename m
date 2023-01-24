Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01D679D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 16:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjAXP2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 10:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjAXP2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:28:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BAB65A8;
        Tue, 24 Jan 2023 07:28:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEmokN005297;
        Tue, 24 Jan 2023 15:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xrE2UsEKV+YmXF9iaobmlBH43ID7fPa9Dor3oJ5bFuA=;
 b=IZSp6AEEt3NABPLhwv0YzLI62sgw1D+U9ZhmOYpzVSeqRXFUUJ8nMv1jrQ+Gln8eu9+6
 loiidYtGXjifpbSGFldh6GLP7VwbLFtEf1SGA38R685qLovSI4lB0EsaE86vyXhG4XB0
 6kDMQB1KKJJnsdmulhTNWmBjzlr/JBGTDnwIT9iRtBWhLqhe1f2Z47SeBwJ3VPO/3kXg
 LeZj41/lY31q1M6OeW5bM56aycD+gNgsPU/TubejTyz2zppmD3CetyNLPJTcAKuiijGq
 YEChaEyODiBKVGfr1nhaAEj8YX2tBpoB5kTbuR8seb7DFJPiaqtV5G2S1c2zmWjZTr7P gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcdpu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:28:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OE9bLQ005851;
        Tue, 24 Jan 2023 15:28:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g5228f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5z0anKyQf1EIowu4zf0BGo5qhk/92t/smx1uzXODTp3Ej+Vn+6Rc6YnjoB7/WJ7SPwaapQnyzAqa9HOoAy2ZpeBeBxg81yLQs4vPi6UXJ+aCLEuXpgXGeOhNPq19BtJtRinXFazJUf14Q1NokiQdhM3Nu7sR1pTws/pQLaa705CGkhknxuqRG0+GiNmEA27JA3sfCnSq6lauMAkAUkDO130OzUtjpFqI3fVllheKEHxXrdd8NLBeyMNZlIPurUfmeK5pVfjVaL78TQMMMS3QIpMlOpVOj8mp/BnL8Ll2m0IxqSZSIufUqf8AvJDEvnc6QTV4F93GqOzD2JFnuuDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrE2UsEKV+YmXF9iaobmlBH43ID7fPa9Dor3oJ5bFuA=;
 b=YYCGjxPz2D0GPGDUnNsiCPtRubNo0i0Xz4gVeJi4jOOXo+9kaW/irv5HfS3ipfkVndCv8VJzLDNGJOVybegPSlTVvrqSdCkA2gX8n9W1xusa2eULn7PQ8OZIrVDu7X4hirANdIEcGUoVFQAc8JdiJnGlmXY8+k7zL9ELxGRS68GkUuRkCXlsSadVbhQo2PjilETd/9SY+BR0XwHHDyxL8Ycw+6IYQF1uXupPCLWmLOU5qdFfvr/R4xXpOtJ92eIz/EPQk2M/D7C5voLxbxqJII5eq93Fy4iqkLgIdk02eCjq9CDot2NZdznSZsHKE4WOD2qq4Q52Ninm6B9sm1Mw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrE2UsEKV+YmXF9iaobmlBH43ID7fPa9Dor3oJ5bFuA=;
 b=TrOMSmhOnIl8lOp8z1g15e6P+WFuDSIHjgCXxb7PK8WkhIlTd8+R0j6f6caUw0EDaQN9Bm8M6fIE1T865QO/dcx6fjuSfpTTV4mf+o6bFGA1JVkKAr7b4Z2LTCgj3c9WH9AZvuSwCvkV4fOfQePautIGsxhyrb8ma+PtDASBIpI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6169.namprd10.prod.outlook.com (2603:10b6:208:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.12; Tue, 24 Jan
 2023 15:28:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Tue, 24 Jan 2023
 15:28:09 +0000
Message-ID: <7530de3d-eeff-df08-187c-44ae5874db2a@oracle.com>
Date:   Tue, 24 Jan 2023 23:27:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 06/34] btrfs: slightly refactor btrfs_submit_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-7-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230121065031.1139353-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: ac49081d-3575-4844-3f28-08dafe1f98aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUfr97CuSjk6YknofbAyg7wkO5ysOwQjI4ryDXzjQjzfiRbujPul+sme+pw6wLmGudYomGr4bAmaRAOXiHYdIqVcY5soz+H2r57R34U33C8V4F2tzXxcZRG/I4PlqYZEItZKfyFCKxA3Xj4i1KwGUE08zsvgatn531fv/t17ko4wF/C0vY+Rb0JkIkrNiBbHzrLJGWWN+sqkov4AvShIpe62whs30deHPKCjsKRBvO+ZKZu95mT0LNZohTF/YmcqNtKcShzlAjf/C9r0i3Miku3E1GbnQFmgRVC32XrvZNC1cD/Ijui0yg0u6zJovhcxIBMgwHeWFxPtEOdsYq2Q/YMBtVfqqA5jS7Dmt5fQ5I+/VVe2UMGWtnA0Tm259fO7yt/oWm+WQ4SgeguEq3KG3M9/859ATVPW/Tv7PXqz8x+KUwgGW/Gbw/BML+a2b7kVCgKnj4Oqre5uRJU9I2Vbwus81BeI9biYuwBTmsCKZX5AfBnEL+i6YNQYJ7anJREjDBOimHgOEsuOx5WYSjb7w3FW8briOYHblwOlmeZefgYy28tceW+B5d75Bawxbw6cPL87SOZWnbJA4yAMrmZru70leMiQd1yUusAu00+eVprYfctmUNCOW7wjdqTYIOET7SFryA8ZyQFBy1KhaVZ5FIm9DfCl/hk47XJwk3tDQ5v2aGPYGk8CSQAWcM+5sHwrQ/3MEzgxFS8lOTNX8cVhMtrO2IkKY2idtssnTiXP8nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(31686004)(36756003)(2906002)(86362001)(8936002)(44832011)(38100700002)(31696002)(7416002)(19618925003)(5660300002)(41300700001)(558084003)(110136005)(6486002)(6666004)(186003)(6506007)(316002)(66946007)(54906003)(8676002)(66476007)(478600001)(66556008)(6512007)(4326008)(2616005)(26005)(4270600006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk4raFRkZStBYVFXUEVrbzhaODJVQklGdEpXUXkyZU9ML1lvZlJSNDRrUmM1?=
 =?utf-8?B?cTRTRmpZemZqZG4xQkxJVG5PckdjYWQwQ3BMZHc1enAxbzQrc2RLQ1NlOVBP?=
 =?utf-8?B?a0lSdTFzdHhYdHEwY3FoTGpwTW5JN0k4dEM3VTdud1pubWVlVjdmTWZ5aHhv?=
 =?utf-8?B?bjVSbGxTWklaL3YzTU0wM3JCMjNyYmJieGZ5YzVtOVk3SStkWWIrdXpaRkFa?=
 =?utf-8?B?L3RKUmR0MmUrdlJVVDVZQTc2OTAwTEZXZmxMS0JzWVVLM0lWNllGZUltRUQx?=
 =?utf-8?B?MXF6WDNoWTJaREs4aUFnZW5tcHFjRHVwMks1TFQyb25laTFDc1A1UVdSUVdD?=
 =?utf-8?B?aXlya0h6TEFkZ1BDZlM5TWlzNzJiNnNLVSsyT203YmR4T0R1ZzFGT2tkM3dS?=
 =?utf-8?B?aGFvSklsSHJ2TzJaaElBK085dS9ub3dBbFRnNm4yOG9VdnVEWm44aHRiaVhK?=
 =?utf-8?B?dUlDRGp3SGlGSTZ3YUpHSTZHL0tZeXhOMEtjUFhJa2JNVnpJT2JTdFluZFJU?=
 =?utf-8?B?UzluNkNoQU1JZHZsa0JTcXRBRUtDdWE1c0hqOUFRZ2RPaXg3Mmx2dS91VVpR?=
 =?utf-8?B?d1RJNDk4ZHFMTUtJYkd3Wkg4eUVOSDNJZW04YndKTGJDYlJKekpQS3NGQTQv?=
 =?utf-8?B?amI0M3ZLSkZLSGV2S0F5L3p2MVdCSE1UUjJnUWs1MXhQNGN4a1NZQ3NiR1ZY?=
 =?utf-8?B?ZVYrbGtZc1VhZitVcUZJU1I4dk5zR0lvdytDaXNPUzdhTnhBZkpraEl4QTR3?=
 =?utf-8?B?NmtZVEdaVHlpcXRmS3d6emVGN1ZmZENMcnBtYVVXb0R2RDI0YVNZZENKZVN6?=
 =?utf-8?B?MVJZZjNNWHRtRW5QQ0ErK1hpeXE5Mm10Y3ZlK0VuYUZnNnVwdGp3c2FXTHZB?=
 =?utf-8?B?K1pZdy9RRUhuVC9EOVBzYWkwb3RSL2VDeGZSaXNoTlJpVlJDQmF2ZkhtZGp0?=
 =?utf-8?B?L3VWWEpoUmFFbXhFUVZ1NzJ5NHNlallVVm9GYjBWc0s1dHJrSXdtN280QTVW?=
 =?utf-8?B?TEQvSUEyMGFCcDlQcnJYcTVhdEpMTU1rUlpJelI0NFlGaFJoQ2ZHM3lRdGZM?=
 =?utf-8?B?YjhKdk50RmZPamplOGJ2SE1Ca3pkR2tMZXRHd1ZkMGhTNE56WUt2Q2RmNGhX?=
 =?utf-8?B?Ti94bEQyaTEwM1lJSnE2bWdSZGRmQzY1YWRHUjhlbnBnZ09TOGZ1bXlQaWdS?=
 =?utf-8?B?dTNUbm5SSFdaVGV1VW9MZ3h0U21ua2VFNWZ4U29VY1ZEbnhqcmtlZVhYanJt?=
 =?utf-8?B?ZmFxYVFoeDFpMCtiODhEZitsSjYwRzVvb2hRa2cwU0hSTCs5eTdGQU1PS0FD?=
 =?utf-8?B?aDU1eVkzenlVd0d4a1FBY3dSUjROVXhBcm8vdU9RcFZpZ291clBLMnRld1pM?=
 =?utf-8?B?RjhyeWo5WFA5NnhPR1pPZTJ0K0NFWUZKUnoxckJqS29KOFZPSmNBWlBWdXlR?=
 =?utf-8?B?bUhnRlZzYS9tamY2dXRFQ3ZQUVUrVFJDdjBhL3lZTnc2M0xzY2pBY2kyaFJp?=
 =?utf-8?B?SWFsb04xZ3NNMFJCdldrc1p4RkhQUE42eHg4N0FrL2Y1VXYwZGJQYnB3V0hI?=
 =?utf-8?B?dUhxTERIWEFCRy9qRUFmUUZOb1cvbVRDL2dRYmR4M3BGVU5pcFZ0U2w3TURN?=
 =?utf-8?B?UUU5TUFlcWR3aXcxQWp2cVBDRll5ZisvVjVVaDh2REtEbXo0Zmlhb1BwMWlj?=
 =?utf-8?B?bkc1V0lZUEl4alQxdjRvRVhRSWdvRTU3TW1lcHFieThJNGdHMjVXZ3lwU3VR?=
 =?utf-8?B?ay96Z2FvaFZvUmtYMTFKakhUSUFRMWc2SXU4NjZQUlRNL25QV3Fad1VkWE11?=
 =?utf-8?B?QkhRQ2JYa3BHL0VkVjRRSi9uYzhmVXFvVW4wb0JHN2F1eWdVaUZaM2dWUld6?=
 =?utf-8?B?SXNGOUpUWlUrTTZPZlViNFVoNWpwSDdid1dGTGthTXpsZkVHLzE0VktnYkNM?=
 =?utf-8?B?M1BpNGpWMzZNUkN2TVJvakcxbHJMV1lrSUlzWjJxdStXdFR2anlVU0ppaTl1?=
 =?utf-8?B?TG84bUQ5QXRVU2k1cnE3WVYrTGg3Q3lXT0g0YUUrRnJVKzVtUE9ESGlWM3l0?=
 =?utf-8?B?bE1RSitDbGNITG9reE5hS2pKMjQvTmRlRWpZTThISkptN2MxTlpYQVBCTi92?=
 =?utf-8?B?RUFpNmVJWkVWQXpDUWRPcDJYL0tQZ1FBQkRtdUkvLy8zbzI2WlBCWVRiNXg4?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YWljQ1RjQWk5MkpVTzZFTnYvbDM3cjFIbmpLUnJGWmlRM09nZEFCcklhT0VE?=
 =?utf-8?B?czR4VnZlY2lLVlRzWUhidGhWS25oNmYyb0YzNkZxOG4zbDZjYkhaQm13Nk96?=
 =?utf-8?B?MG9TME9qR0xydUpTeTdwRDh0QktWdEJ2UzA2cDdnZ3dSeU8rV0tCdGFyZEsv?=
 =?utf-8?B?R1lFT1pnYWcrUnVwUCt3U1NKWU5sei94OGdnc0F2UHhRdS9oMStKNVh3cVhz?=
 =?utf-8?B?Q29WdHhtemdyYTZuOVMyYTZkSVM5NmtrOXlyMWlHOVE3UURlMXZBaTJzVit5?=
 =?utf-8?B?b3d1cFFVTy80RXVvQlQ1K2xuUnhyb21tdFdyeUw0Q01SWldXbW5nSVNSU3hx?=
 =?utf-8?B?QkxVUmV6Q2F4U3hNU1FkUFFVMWRDbkVQSHFtRXJ6M0xkRWcrRmt5c3BMajA0?=
 =?utf-8?B?dG9CUkFwbG56VFZHYXRHbDRkOXRhOTByZW1wSnNEMGkwbFFJc2lnWFM5MHdx?=
 =?utf-8?B?Rk54YVZGUTRPQ0lKeUVHci95RFh5czVPcEI1S1JRTkNSTHo4NzZ6aW5sR0Jq?=
 =?utf-8?B?dERJZWdPalpFclYrZkRYVG9ucVdyUVVKK0duc0RONlE1SHFpa2lCT2VzNTFl?=
 =?utf-8?B?dm9NdnhRdjdXYTByRWhQSm9TcDBMWGdibGlxUDNobU9qSlhRZ1VtMlpTYWU4?=
 =?utf-8?B?TnFRWUE2OUR6eEpDSk80TjR4YTlKalVjaXVycjJobXZlcFAxRTZqblRsMnhl?=
 =?utf-8?B?QWJTZEl0UVQyZlRLck1hSktDZGtyQzJtdmxFOXhQVWR1UGlSM3htMWxOMEE0?=
 =?utf-8?B?QUt4Slo0elU4KzNFL2w1N2cvNmRSc1lCUTlsWTBYUGEzaE15dTFSYnpFdzY3?=
 =?utf-8?B?VXcxdHR6WW1sdTdjYUJQUHdsSTdVU3pGUFFhcHorRHdQQlkxUno4WXkyVGl4?=
 =?utf-8?B?dGMxRXk1Yk9MOU96RWVEOTFYR2pvOUVkcVBkalZmMzlDN0s2WGRMT2RRWXlV?=
 =?utf-8?B?UGdhMXgzUFV2YTFNRlNtZTBmVGpCTFZ2WDJ6VGpJWUlCdFdqUGgzeElldWht?=
 =?utf-8?B?cVo0T3JkZ0o4T1g0RHNveHlxSGx3eU5tMlhKbnAzSUpVSU9oUkVGbmJ4RFY3?=
 =?utf-8?B?NGtlak5EdkpYaXZUWUIrZXM3enhiWXhFT0U2K1JwR204dUdiUnM5MkRnOU9O?=
 =?utf-8?B?Qm9odkVWNFpuWWlKZC9EbjlNZ0wzTGF2L0ozeldkbm1pWFBudjg1MlpwT2Jt?=
 =?utf-8?B?dTIyNkJubnI1VmlJellnTjdPYlBySkNlOGFrRWkvc08zWjV6MVRRQUVjdW9t?=
 =?utf-8?Q?1PlIhMFf9tLNex2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac49081d-3575-4844-3f28-08dafe1f98aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:28:08.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4Kk8R6GaVvkkJKCpg7hD8iwX22qkAmBuIqxokZXxD9xWVEjZc3DDy96nQCfFsjjX/oxTfmU9qkHNGZCusNKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240140
X-Proofpoint-GUID: _WJqZdaVh14lx4is_09gJ3ICuJOLlfa_
X-Proofpoint-ORIG-GUID: _WJqZdaVh14lx4is_09gJ3ICuJOLlfa_
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
