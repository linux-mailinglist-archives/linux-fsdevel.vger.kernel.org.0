Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BD704255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 02:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbjEPAgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 20:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEPAgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 20:36:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F883E2;
        Mon, 15 May 2023 17:36:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJrxtw019178;
        Tue, 16 May 2023 00:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kVxKNmD+5kjX3SpWVsOhFbmNx/PcGomibI6nVucx7D8=;
 b=BiPYzuFp+g5x9HTm3saad1tDGZks2NcnMJ4f0Bvan/grdoZYPjVCkqHhKSOL2dmLXUP8
 od/jZZoNElPD2bWShiTJNI7XwDesoRjrLxY+3iGX8NxLRtf79+iwsLnUYWPzXFHtBFU7
 knm4rhnCqoKnWiDGHH9ms1VKfBPovPELBm50Vt1XPacHO0moLIfT9NhUS/4kMrprGElL
 Ws+8bwitag9T+fkPtZvc6Wa90EO0BZzx0ChnYastF0bOUhOsxiHOMOc7aY11S1AroTUJ
 yiIJg3R7qVvVRAjnTFyOt/Y9JL0wmrLcMZpM52LfbdSdqCMvds53p0gF8uAdS3acM7X7 Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25u1cxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 00:36:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMmfde022086;
        Tue, 16 May 2023 00:36:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109mf64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 00:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXgmTwX4v0UYVo+GrVibn+M2+hXXexFpYqAmUBopdqSK717Fayq7FxkNTHqco7MwYOT2JTj7pIvFlxm1WbGW7Tgk94E+d8Z+jXHtQ9ctwcCoa/7hJZ5Zx4QhniqaofmfsL0KQ4S6sLe2Ff8LuFGHij+iS116UZGAM72MgfWmbYUK84mm6sDd6PHRqP63ytz7wveLYJ9+2aNpcuV4a+Z0cBfF3H2sQ1lcPY2tazarsE53sHC2zWxLDVIg5qVlc/bpNrVmMmByP20pCHuEsqKVh1aoLKfczFRMBzdVD/MeEdySGkkZyKW68pBjLATsIohXhj4mVgOnK1EKe+JpIA6kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVxKNmD+5kjX3SpWVsOhFbmNx/PcGomibI6nVucx7D8=;
 b=j3T2UKi6hMsHdXvqgm2JyKLRCVXG8gWm3A1kuWpxY4nPbGKQUWFVwF4hOyur/dkC2gOsyk7efKQjoPTmTENZey2TiunRUVUfxw/mIBFraQlpcWINJPx0OgXHm3+3Mc7AVbg2rtxQWHCrjGyyyhvPgA88BWO+TeheRJmRVRgV0dshjhdCTikuC1cbbRHrB44GiRPfMvxlhM4qtHnrl32llC19Nge8DgcK7C7QGNJBK9kexAYG/kosvdTmGX2UYPm2a+IH44sLbR1CnbFMst01nLeNNbyIXaQmrb9yUqh1xX7GrfKzgAtjouB2Z44qe5w8rsio6XNzm2iSxKtbw6b5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVxKNmD+5kjX3SpWVsOhFbmNx/PcGomibI6nVucx7D8=;
 b=Z/khygXHWa2de0uzaIkU8iybGdzIxQ0quKaiugmsiAAlYHkUIRhxZjoOX99IqzBkkT64k8rcEpEn5gRLW9Ssgb78+YXgM9j22+OoOd6b4UmFEMMPa0dK2+7YYjCiIl1b23FgUuAK1cEXkvpLlwpXK0ZJs7K/FyyHInmY8VeZjD8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 00:36:00 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 00:35:59 +0000
Message-ID: <90b314d1-2d89-641b-5145-fa9b76814f93@oracle.com>
Date:   Mon, 15 May 2023 17:35:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
 <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
 <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
 <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
 <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
 <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
 <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com>
 <927e6aaab9e4c30add761ac6754ba91457c048c7.camel@kernel.org>
 <D970A651-1D60-4019-8E91-A1791D3AAF6F@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <D970A651-1D60-4019-8E91-A1791D3AAF6F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN2PR10MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: b5742b42-6d0b-48cd-3bec-08db55a5850d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InzZRRWS5DnKnMi3uacjISME5f3fdUfRfObJsmzzEBc7FwXeOmwbQB+gP1+bU/O5kEcKXrzwJANQIwJl2m6BjddTP3kSbOVU3vlLqjjOKP1x4B5QTGsEO1rzdaKJe6meKRq6+CtqtSpYVzOG5EGZ56fvsgAQsxzSA056SofSux6m0uLK0f6lo83MpJeAxEp4zhnzQBOKtzA/a5Jct3er5HktIqVD3FVRqumM9lp6YPDE2TXZ4U8l69fEbCl11Ra2iVoCVdgzLQjYbgYvy2Wjnbudrqvr+g07rnJqudmED7gsbheoRcdLUi32CckNR4+L8AG9pazsMMoeuUtDdNe899A07kZAi2MPjB/W7mHYMJlPZPC6VR2fakYzMJ99ltEAQHErxkVVVFns2igLzP4uAZpc04N/hdCa9s0gEJkdkdZHh6KJQnHuq+f1hT8Ghg4fSN9v+KYF05YGMw++hmybstCUhhjIxO7CDlstWCcAyPC54enW/YVc+pLiai2E91SRb453GMnRQHE3I2q3FQoTB2Y7tO+ImZHpJkGtYExvpiUj1U8R97vlxPGgPtjmO6zr63qs6eUtLFVP5FY+KCUjs+hHKObDoGZi2Ai8SdoOooHMUbVlmwAeVDBY0OSTxQ1G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(36756003)(316002)(66556008)(4326008)(66946007)(66476007)(31686004)(41300700001)(186003)(26005)(8676002)(8936002)(31696002)(6512007)(86362001)(6506007)(2616005)(5660300002)(6666004)(6486002)(2906002)(83380400001)(9686003)(53546011)(38100700002)(110136005)(54906003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1ZZ0RjZ2hwSG04empBQTI4b2hpMzhGeDVhZVJWU2M2dklIcUN3STBTckp4?=
 =?utf-8?B?YjlFWC9KdzBDcld6QXh4WnRGUGhpcjVOMXU2ZkRuRFh2MnRiMGM1UmVsSFpF?=
 =?utf-8?B?a0Z5YVlqSFpKRjZWNGJBUmFkUFJXTy8vQTlQTWc0VW5TaEh5bi96c24xbmlX?=
 =?utf-8?B?VFNIRGZ6VkE4R2lQSlpKNmx1ejVRb05FV0dxbVBBVnRpa3NaeGJaYkRkb3pW?=
 =?utf-8?B?enRhY2J1VkZxM3hLaHNTeWtMOC9jTWxlQXZNcERETUMyM2lrcHloZmtZck1J?=
 =?utf-8?B?VEt6ZTZvMFZrZ1Y5QW13QjBwcDNpMWpHT25DYm1VcGY3U0k1U3grNUk2bFV0?=
 =?utf-8?B?SXIwL3JKcHRhTXhKR2Q4S0QwR1NMKysydVJHMkpiZXc2VDd1TDlVTlIxWWIw?=
 =?utf-8?B?alM5RmVlb3J4YjdYZ0wwR0VjTm8zUUc5a3RhWk0ySGNRWmFScnk4VklyVkFm?=
 =?utf-8?B?Wjgrejd6N25zTTgxREpmbkJDN1NNd1lDTWlJdE1JOHZnblladVI3RE5lZHQ5?=
 =?utf-8?B?enJNNE9lS1U5eGxtLzlRY2FjV2dKQm1VY0Y5N2FvRHdTa2VGUlRpNllYYnFo?=
 =?utf-8?B?TWh3dnVYUHI3VXJLR2J3bjNQRk9Tdjgxa2g2L0pOZzY4cHZFcjZIQm9GRVFM?=
 =?utf-8?B?cXJLdTBEZ2tOWnMzS0tMRm1sUGRBemI1NzQrUjlkRFlzZWYyK05WVTJ3QzNz?=
 =?utf-8?B?cUxKWU8yYkttaEVTTkZqRlRLWVlpTVNEVEc4a2x4MUlGTk85RGVUaCswSFoy?=
 =?utf-8?B?bS9sZTVYamdJUnk0SG9EOTN6NmJ5NlZXZ2hzay9ZcUJtRVZ1Zk1LbXdHUlBw?=
 =?utf-8?B?V0wwaURMNUNqbkxLdVVXVnhwVHJKWmNMcEU0bXRaT0syMmgvS080UmMvTnFG?=
 =?utf-8?B?MXBOM2VpejJ0Q1BvMlp2TE9QcDBFVUg5ZytiR2s3Mnhza21mZzFUSHBQSEVo?=
 =?utf-8?B?ZVlrNmFybzV1Z0g5TFB2R2NkakN5ZFpvTXh0YTE3RXhsRTBZc2tyNTJvQ0pR?=
 =?utf-8?B?QmNoejdhV0hpd1ZYS1lXWnpEMGFKejlhMWYvVjlhejkyTHlWQUtleWh6bThw?=
 =?utf-8?B?RmRiaTY1YlZLZHZEOU5UdFkrMXRUZWoyYWNEa1lsZTViZFNIdGdacU4reDVo?=
 =?utf-8?B?cHA1aGlISGxiQmYzbGEra2pPam9RV2xvWjd1OGd4bkp5MktDdmdzSzVJOTgx?=
 =?utf-8?B?ZWpUU0NJRVpZNGF2ZGl4VnY1TjVyYTRRL3B6QTNPK0RBdkpuMDB4aEI4d0My?=
 =?utf-8?B?OExFYUFMTFRKbTcrOFphL3MrTktyUS8waTRtb0hJR0VtZ21JUXQyS241RjN1?=
 =?utf-8?B?U2dzMjdySjdCZGVSY2xwTGMxdWJsa3Mva2dlZzd5dWlwMWlnQ0QrZENuV2t1?=
 =?utf-8?B?a1ozUmt0Nm1zc081UDFLZ3pjM1dhNWlET1gyUjFWU2hxRUM5OGNLWGxKNTFo?=
 =?utf-8?B?WGlpcVQyWmp0WjVuK0xQeDI5WmpOVGk4b2NSOFArMlBpSEJnNjh1TW5CeDBB?=
 =?utf-8?B?ZDlDdSttSTdLWENETmVwdE5yN1k5M1pvMURRQzJIMWJ2bG9zNTRyQnFQUHpO?=
 =?utf-8?B?WWtOSFZjQ1VqYk5KaHQ0ZTV0SElUT1I4by9mTmZXeUl0K3F1MWdBd0J1WHps?=
 =?utf-8?B?U0Z6S0Fjb0FZcXp0eW0xcVUzR1RRN1NROGpPKzZjNDNOSnM0QVUzUUk0TTJa?=
 =?utf-8?B?MEdTN1Q2U0pnMGVXakxSUldqVWhoY21wYTJhT2V1dmY5a2ljZGFDNjNRVmp0?=
 =?utf-8?B?RHh3bGhYNXZvblpsb1Y1UlhGd0tFRzYrRjZtQkxJRy9lNHNjMzJZNzFhUWxk?=
 =?utf-8?B?V1VnWGtBbHZEKzZYN1BEYkVTNzNlYlY0TkZVamVFaVhSOXNwVWI4cnJ3VFc4?=
 =?utf-8?B?SzJoN2tyeW1ydDYwWkJyMVdvWDdqSENKL29Nb2RVY1YxeE0rbEJjNmVTY1U5?=
 =?utf-8?B?cUgyUlpudG9panZIUGNVc0o1QWhLaG5zUlE3T1VNKzR0MHdkKytxY0ZxM3RL?=
 =?utf-8?B?UE9UL3lxWSt3aWdCLzY0UlpJdWJVMjN2ZFRBSzB5OCt0WXBOdVNMZGZxeGRo?=
 =?utf-8?B?YlJ5K1NmQkRBTmpoS015bHJ2cDU2eXVvNmx1MkJvcFZ1eGQ2Ri9wZmxWYXkv?=
 =?utf-8?Q?B1VGIWZCXoaaFbGFyVCxE7NY4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 01Cad/ufvEchzIDml4JR8cqVeCUGJXArf9gMaULRkvc8DL89ZzVRpKRC38hb5ijOM4isZiMGsXUnQvueCkPmzf7z5wbSr0MuQTXP2DKeTkmmHYkyCu5pfiyxN5FiBkxwDJpYL5VqeQ2pHGZb7FinYRO2h9TRaNKtjA+CDCfqOPgjD0n7zdIEQqgFRraxauWNOg7tujZtqkRb6BQw4uSebC8fKTzvOy7iSfd4cA0YJ7q56KOCe/XAfaJGH+UdiVZuxTKD/hDBRJKe5V4Y0inUDGcgskuLWiXGvuXKqosT3DXoB2L5r4VEInNobxWPMz+B4u0vHWpx8FJMqJMMpC/x+vF9XCQDRKpd7fX01asUP6JDqLCqxl3JwklMDACzDk0StlhGbUV64B3COyG1lgWWdEzi0kbEjiKC9C3cWiR8zgI7VNsZ1vus07ItpN6gMjdT2iBjUe/pqCH4/q71WGFDTga59UkfknJIX0H/DJ9irpkgRdEIw2ya8oOsZ0azCDytE0zkGYrkr0yw/s/RlZ5VyEB/zmpSZuKK13GGS6EEZ622eQq5g8t0stYXVuel4Q6Sj/XuOwo5E0lcrXA7Rz5RB66knFL50DreiMgxjiL9M31TQOEXAkNhIfNUfTGeJX6MXLQLGtjZz3oEweojEvXTxwwMYfdRXO6VGFw9q5mzrtUC9+oX6ka09MrP9eXu9JI7viZvzbOpQOtTCgBWWAGShjgP2bMpMZAutFicXUNEdJ93nwbjB81z2YW8rVhJqymnMfNLD9CSCM2/aqaVIlRclerU4pnvm8ei9V5W1el4/JtgJxq94gdI9RUv7/p9+sJY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5742b42-6d0b-48cd-3bec-08db55a5850d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 00:35:59.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQR2LLcre6mnGhdJ+QrxyemukL8i2opgT/DgGdNEzMZj9q4r+NqomlmkuTRGFy6fmdGm8t/fDgi4dEJLrvu0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160002
X-Proofpoint-ORIG-GUID: WGqmIpx3O94kCSRVWkkwwf71dhp86NbU
X-Proofpoint-GUID: WGqmIpx3O94kCSRVWkkwwf71dhp86NbU
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/15/23 5:06 PM, Chuck Lever III wrote:
>
>> On May 15, 2023, at 6:53 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> On Mon, 2023-05-15 at 21:37 +0000, Chuck Lever III wrote:
>>>> On May 15, 2023, at 4:21 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> On Mon, 2023-05-15 at 16:10 -0400, Olga Kornievskaia wrote:
>>>>> On Mon, May 15, 2023 at 2:58 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>> On Mon, 2023-05-15 at 11:26 -0700, dai.ngo@oracle.com wrote:
>>>>>>> On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
>>>>>>>> On Sun, May 14, 2023 at 8:56 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>>>> If the GETATTR request on a file that has write delegation in effect
>>>>>>>>> and the request attributes include the change info and size attribute
>>>>>>>>> then the request is handled as below:
>>>>>>>>>
>>>>>>>>> Server sends CB_GETATTR to client to get the latest change info and file
>>>>>>>>> size. If these values are the same as the server's cached values then
>>>>>>>>> the GETATTR proceeds as normal.
>>>>>>>>>
>>>>>>>>> If either the change info or file size is different from the server's
>>>>>>>>> cached values, or the file was already marked as modified, then:
>>>>>>>>>
>>>>>>>>>    . update time_modify and time_metadata into file's metadata
>>>>>>>>>      with current time
>>>>>>>>>
>>>>>>>>>    . encode GETATTR as normal except the file size is encoded with
>>>>>>>>>      the value returned from CB_GETATTR
>>>>>>>>>
>>>>>>>>>    . mark the file as modified
>>>>>>>>>
>>>>>>>>> If the CB_GETATTR fails for any reasons, the delegation is recalled
>>>>>>>>> and NFS4ERR_DELAY is returned for the GETATTR.
>>>>>>>> Hi Dai,
>>>>>>>>
>>>>>>>> I'm curious what does the server gain by implementing handling of
>>>>>>>> GETATTR with delegations? As far as I can tell it is not strictly
>>>>>>>> required by the RFC(s). When the file is being written any attempt at
>>>>>>>> querying its attribute is immediately stale.
>>>>>>> Yes, you're right that handling of GETATTR with delegations is not
>>>>>>> required by the spec. The only benefit I see is that the server
>>>>>>> provides a more accurate state of the file as whether the file has
>>>>>>> been changed/updated since the client's last GETATTR. This allows
>>>>>>> the app on the client to take appropriate action (whatever that
>>>>>>> might be) when sharing files among multiple clients.
>>>>>>>
>>>>>>
>>>>>>
>>>>>>  From RFC 8881 10.4.3:
>>>>>>
>>>>>> "It should be noted that the server is under no obligation to use
>>>>>> CB_GETATTR, and therefore the server MAY simply recall the delegation to
>>>>>> avoid its use."
>>>>> This is a "MAY" which means the server can choose to not to and just
>>>>> return the info it currently has without recalling a delegation.
>>>>>
>>>>>
>>>> That's not at all how I read that. To me, it sounds like it's saying
>>>> that the only alternative to implementing CB_GETATTR is to recall the
>>>> delegation. If that's not the case, then we should clarify that in the
>>>> spec.
>>> The meaning of MAY is spelled out in RFC 2119. MAY does not mean
>>> "the only alternative". I read this statement as alerting client
>>> implementers that a compliant server is permitted to skip
>>> CB_GETATTR, simply by recalling the delegation. Technically
>>> speaking this compliance statement does not otherwise restrict
>>> server behavior, though the author might have had something else
>>> in mind.
>>>
>>> I'm leery of the complexity that CB_GETATTR adds to NFSD and
>>> the protocol. In addition, section 10.4 is riddled with errors,
>>> albeit minor ones; that suggests this part of the protocol is
>>> not well-reviewed.
>>>
>>> It's not apparent how much gain is provided by CB_GETATTR.
>>> IIRC NFSD can recall a delegation on the same nfsd thread as an
>>> incoming request, so the turnaround for a recall from a local
>>> client is going to be quick.
>>>
>>> It would be good to know how many other server implementations
>>> support CB_GETATTR.
>>> I'm rather leaning towards postponing 3/4 and 4/4 and instead
>>> taking a more incremental approach. Let's get the basic Write
>>> delegation support in, and possibly add a counter or two to
>>> find out how often a GETATTR on a write-delegated file results
>>> in a delegation recall.
>>>
>>> We can then take some time to disambiguate the spec language and
>>> look at other implementations to see if this extra protocol is
>>> really of value.
>>>
>>> I think it would be good to understand whether Write delegation
>>> without CB_GETATTR can result in a performance regression (say,
>>> because the server is recalling delegations more often for a
>>> given workload).
>> Ganesha has had write delegation and CB_GETATTR support for years.
> Does OnTAP support write delegation? I heard a rumor NetApp
> disabled it because of the volume of customer calls involving
> delegation with the Linux client, but that could be old news.

So far I have not run into any problem of NFS client using write
delegation. My testing so far, besides manual tests, were the delegation
tests in pynfs for 4.0 and 4.1 and nfstest_delegation test.

The nfstest_delegation result is:
1785 tests (1783 passed, 2 failed)

The 2 failed test is regarding whether the NFSv4 server should allow
the client to use write delegation state to do READ.

>
> How about Solaris? My close contact with the Solaris NFS team
> as the Linux NFS client implementation matured has colored my
> experience with write delegation. It is complex and subtle.

Solaris has write delegation support for years.

>
>
>> Isn't CB_GETATTR the main benefit of a write delegation in the first
>> place? A write deleg doesn't really give any benefit otherwise, as you
>> can buffer writes anyway without one.
>>
>> AIUI, the point of a write delegation is to allow other clients (and
>> potentially the server) to get up to date information on file sizes and
>> change attr when there is a single, active writer.
> The benefits of write delegation depend on the client implementation
> and the workload. A client may use a write delegation to indicate
> that it can handle locking requests for a file locally, for example.

This is what the Linux NFS client does, handling locking requests for a
file locally if the file has write delegation.

>
>
>> Without CB_GETATTR, your first stat() against the file will give you
>> fairly up to date info (since you'll have to recall the delegation), but
>> then you'll be back to the server just reporting the size and change
>> attr that it has at the time.
> Which is the current behavior, yes? As long as behavior is not
> regressing, I don't foresee a problem with doing CB_GETATTR in 6.6
> or later.

I think defer the handling of GETATTR with CB_GETATTR until 6.6 is okay
so we can get some runtime with write delegation to have some confident
with its stability.

For now we just return the (potentially stale) file attribute available
at the server. It should not cause significant problem since there won't
be any real application depends on this feature yet, at least on the Linux
NFS server.

-Dai

>
>
> --
> Chuck Lever
>
>
