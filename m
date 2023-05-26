Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF9712E86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 22:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbjEZUyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEZUyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 16:54:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C801BC;
        Fri, 26 May 2023 13:54:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QKoLED006373;
        Fri, 26 May 2023 20:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VjiXKuJWdCMBKkwxoZ03tszL/C/xXc0co/LIg1hiSAI=;
 b=Ek9946sO61qlyJWwVwd9tpHY3piVD5CcX4RpmnoXaYQPeT+fbYoQgjl73pHgp240PX9+
 QiBleTnByJlJqlmB/FvbHDx/5Z6AW1l5AfHPznFL6wM9J1ZBPT2XU0wnIOse7X20FMxZ
 ZA3H3S6KC0M9JIHCr5wM2K9N10iZo3MYF/muNoCmPMg7ATEilmGDPFeBhhX9NFLZuaIX
 TMjPzDnWxFN2wdF6ZXq8gPtt7HQJMOJvfN02UhdmlElYJv2252pr98I0GdfO7SpBafty
 6ieQmK6LzRK+v8jX1h9dtiMD2ATy4oktyMdYb4C6Ud/PQeqoT4cY3lLcbD5PXTT/s9Zz CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qu4550047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 20:54:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QIgOXe023798;
        Fri, 26 May 2023 20:54:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8yxvwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 20:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlf+SNpAjl5WOVRTAQK5ySB5KvZqjscmNaxst9cxPQKPdck0nwzxb51KdFja/zNgiZDhJ94iby4zYdHKTquGOU7x80sXPZq9lwvLsXGIaQNv+/5W6eTQDvqhdjsWrRgKpSTlpsVALKOq0q7M5ExL1+I7Lz5hrIECAqMvHJ6wrs/kKXPitZrHzgIA72B8M7F2W2YEDZwV1I+vHzaNocCqLVWSfxYXT0PEKBqjAchGzpun/xLWkOPIH9dQknocVQDrv8ntObNew5uG96baeuCfH5nNtvSGttpAGKiDjooH3uf6DLSdV5Hee7vZtHS2CXqd5786N9m6VnymbVp72+WHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjiXKuJWdCMBKkwxoZ03tszL/C/xXc0co/LIg1hiSAI=;
 b=N/tKAq2h7ZCX5VSuQG9cStAUrfEo+OgU/c6o/jkLq/GNNTz+U5nQAo4dsu9eYrWNQL9X/Bw7g8mODx26yyRDImjGBiO2shzr6aeAUOQ+ul4Y8n8oJXxaNruZDfBulwSIH4Q3swdoKRkLxZw7kyJ06i36ok3za1LQHwVocbfh8G4BCmbtcMkw8SzzIdpRKnb+7L0uvJuI/fgzQqNmK4oFBkzKDSBjPsF+WQaNIxFi79GSNT6h0CI/rVHhB4dDJrcWqttxb4E8jzTOW/ChFz/Yi1a8ER7lPsh4nC4MpeqjK4BC25zIPyBZ4ccYXTVB1ptKVq9HKwlpp3N/N2PjxbktjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjiXKuJWdCMBKkwxoZ03tszL/C/xXc0co/LIg1hiSAI=;
 b=LxApsGkiY6k/ifzvtIpgXJu/vrmpTjsAd9pbFQrkb5UTCkN1bQU7+lgSEV1uKztxIZrbGfqYyhYwsFuwUuWnSdWq5xIwhtfqYGImsXchhaB0pIZ09Vt3piYg6ir8kyX/bVFl+iCypRbNiKv93S29PgRfC2+nvcjpCyfB1/rxzuU=
Received: from CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24)
 by MW5PR10MB5667.namprd10.prod.outlook.com (2603:10b6:303:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 20:54:16 +0000
Received: from CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::8027:bbf6:31e5:2a80]) by CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::8027:bbf6:31e5:2a80%6]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 20:54:16 +0000
Message-ID: <3719ffe2-c232-6779-9379-8cdbf94c0ef8@oracle.com>
Date:   Fri, 26 May 2023 13:54:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] NFSD: handle GETATTR conflict with write delegation
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1685122722-18287-1-git-send-email-dai.ngo@oracle.com>
 <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
 <ZHD8lDQADV6wUO4V@manet.1015granger.net>
 <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
 <ZHELONbYnZe0wOzh@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZHELONbYnZe0wOzh@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:806:127::20) To CH2PR10MB4264.namprd10.prod.outlook.com
 (2603:10b6:610:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4264:EE_|MW5PR10MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: f41c79fc-2b3f-404b-f3c0-08db5e2b5e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CKEC2STjGVfAcL1tu/F4/Oip7b3TZoVyrx5dEowut4tXnQVwPOQfiLMSy0q1klJjhxGOM8MT1LBduFGg8997Dd4rjZz/mlfOi5XiVBleVmmYsRXQSEPRAzSqVzhaIBA7JBd7kJIpP5ndGgUWBP1lp0xIiF7kzuO/hsiv3MZBlkgJj/S0XMk+ANi7Ybl8XnmNDNP51ocf/ptppJDaTRH87veQdTCAtRQQakjTBtY9vWKMwGil3WiJ+Dy0LA+TFxfZrrWcBGRxY2w4neK7Hwg+olxYhO6/Wyua05D4ES8xPWTblhjIQmtTk56tm+mJ/K3X+ah2dfTUMxQ7LuRyjdGVbToCxBteNmJCZ+xcHcM32Ol130Jj70K18jfSC+hKbuRhGfHbfyaxGTCZNk5ODCt0b5UMxjbHRU4dVFUGsIuzg9oFpbit2Yp6jCpDqcdUoppixgvXzXqpkktC/v4xMZYXQY4G2IQc6v46H1g615//gpaXSv/wsD3+LcPn4phq31nbZuTvpEq8EGcW3GsOilwtdItWgCSvRDvlgx8oIK05vnAqc/pd5lfOF8jayYXK3939S6eiWDC/7MQq5QPF8KdoKfphVgmNdg9cgN+OUPck2OhSVqW+Yhy30R0njklPUG1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4264.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(6666004)(4326008)(66946007)(26005)(6512007)(9686003)(6506007)(66476007)(66556008)(6916009)(316002)(41300700001)(478600001)(31686004)(6486002)(8676002)(5660300002)(8936002)(2616005)(86362001)(83380400001)(36756003)(2906002)(38100700002)(31696002)(186003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRxb3YvUk9LdDZPaXRlMUVGR2ZpNitvYXhEQTNNOXF6WkwvL0s0M2hqbHpl?=
 =?utf-8?B?TEJiM1h1ajd2L01RZXVqbGR0eUNBNnRCWDlVK1UyNGZkeGNGMlgxejB1TElw?=
 =?utf-8?B?K202NW9WNVo4UUFwbXpSdmlFaWxqSVZDVVYyWmNaVTErd2tTS0pVQkxuMUt4?=
 =?utf-8?B?SENuZDk0OVYxdXh0dmd3dGNmVWt0UGU4UTQvblh0YWVVWUg5UXNkVHlVRVJL?=
 =?utf-8?B?U05sWEFJSjU1ZW1MMXhDeFAyVVhuN0U3bFhTRTVzdW1BK0QyYnlENDRGY3Zk?=
 =?utf-8?B?MExUMlBGRU5zOURwNDVFN3hTRExLZ3RjaFBnSk1oblhqM2wrMEdPSHliSWhi?=
 =?utf-8?B?UGxFaFNMdnZoTWpqdDZQeTl0RkM4WFZ3eFpFUU9TakgxTHhpYjhCdTR4Mmkv?=
 =?utf-8?B?ck5EL29wZzVrai94MjFUVlhWOXkwak1Cc21pcDZ4c0pSQllMcnhMR2FVdmZn?=
 =?utf-8?B?c0lnaC9qbnhXUkk0OTFzM2pmUUYxbmZpaTFoa2JSQ05DMXJOZUlHV0ZQTXRD?=
 =?utf-8?B?NEhobjJoK3g3MTV3MHIxNlZ6VU55ODhaSnRFZXA3cGxtNmRjZHh4a3kvdlpm?=
 =?utf-8?B?djF6UVdPRE5VOGhIS2Y2aDRBeCsvdlRrbzl2WXhSeUhGa2NEaXRZVVZZYk9R?=
 =?utf-8?B?Y291ZzUvTy8xSGU5MFQ4KzA4WUNBS1h0ZGQrZlRKamd4YkZBZlNxTFBEeWJN?=
 =?utf-8?B?RUpyOThxSWVVYkZVSnJ5K2RyZk1tbzVXeTJ6NTY3TEpPK3FQVTJzWFlweDFO?=
 =?utf-8?B?SlNJMzA5UVZxUW9UZWVrZUF5U2NaSSt6U09nM1Y1Mlo1YkoxdUQzTm1WUklO?=
 =?utf-8?B?a1c4VWhuUEFNTUpyVExKSVhtS2U3TnJGU2xUU1FReTNzb2lvcUlJU1JSYTZF?=
 =?utf-8?B?aWVsdnlqQzgvV1c4L0ZPZ3pJRTFEZm16OWxxOG9LYkVrQWtXMUxmS0doenhE?=
 =?utf-8?B?VVluNTVGWnFLcUlENGRXNjJLaDJXZjMzZURoTTNwNXRIcnBPaHgxY3NsMElE?=
 =?utf-8?B?MlBUNlQxU0R2c1hDS2ZxeUgydTBMZFQxZHM3c2RYMjRHUGRjdWJQQWcvczBn?=
 =?utf-8?B?ZGt2djRVemdCU0VrZzB2b1EvbFI2V09LZ2kzTVlnNHcyZndTbU8xcW1hUEFY?=
 =?utf-8?B?STNrTExpZDF0blYxZFJ4R2s5OE8wMWlVdVdaaFhvN2NvSU1RUWlCaVIxTGts?=
 =?utf-8?B?SXZrNFVxeFozRWR2Ly9LcmVFSXRrQ1A3RXpXY2owWGcyL2NlVTZBd2VUMnJP?=
 =?utf-8?B?R2R2Uk5Qc3ZTdGlOd01pT2xVbVdvNUp5ME5tSVBYdXl1dVF5RzNqVXp6ME5z?=
 =?utf-8?B?UTlORkt6amRhVFN0YW5XNzdsVk1XWUt4RnV2L3RDRW5sY1RDK2pSR1U3M0hS?=
 =?utf-8?B?WU1zYzBxKzFLaWFRdktPTmdtbytkYkVveUpjWWlxaVowcHp4R1lyOUFQa1Jm?=
 =?utf-8?B?SHhQUUVSNVJNcVJrTVdxUUNOclZnTXVpMmVNdkN5dEJYcjUrTjRNQllnTVFu?=
 =?utf-8?B?ekttams3RE5LWVYySUhnZ21ZbEU2NysyNFVHYTFaRTBMcHRlS29OUGp1RDdr?=
 =?utf-8?B?MmFHVkorQ2pwbmFYMVorMWtXYzBGM294T21jcmdCZWVwUW9rR25mSmhVa0ho?=
 =?utf-8?B?ZVZZKzNSbDBhRUwwSHlUSWtPSzNBSkhyV0U2R0pnVHJkRzZkR0NVZW1HamZW?=
 =?utf-8?B?U3QzUFBmZTNWTi81WEJKRm0ydzJvaEFOT3dUdzV4R0dKaWNVT0NvTm1veEVl?=
 =?utf-8?B?WktYUkNWdHo0WFVJUzNCZDNhcm1oaDQxM3pMMkZrb1FEaGpBQ3JxaStxZFZO?=
 =?utf-8?B?LzgrUlBjSFNINUlPY0NkdGpRaDRZRkNNaXV1ZzR4d001RGxWaUNUU1haMFFG?=
 =?utf-8?B?R0g0TDllZTMwcmxBRlhMKzREYkdMRVJ6MlNDRmhaUklVbi9pTjJMU2hsbnpB?=
 =?utf-8?B?c0duZjF6WHEwTW9SMFlVRklwbGYvSnZBMFFDbkFaeDIzNVVoYWtFa1BZam9C?=
 =?utf-8?B?blg3Z2h4OFNzTWFVZC9wMWY5cnFqakdFVzFoV0hsRFVveXQyV1ZxOWV1WDNw?=
 =?utf-8?B?ci8vemdyY01Wc2F1NkhBbVkrenFaUU82UUp3WUh5WExYNG4xakswVGVidjVO?=
 =?utf-8?Q?paXF/WCOEXzEBu5Ju/c9CxlfJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ragydAzq8Xx3DXKACAQDyvynnHCE++iLgckfr0F3HpPWT2Q34jFlCZGUsDFTFmwBSsl5P9RvDjBmzx29UXJApzMa9z/TrcfIyXQavyaIXqu3ICsA3+H+1cNNMsmOPK91MlJixlmOn5WNVhn2/LFnPsrrbtFDfHXu51R0jWj8XzfZHweEn/hOg0MDl7x20vAnnMSgCBD4AVqLZzcEE8qYaiJfv3Gkm5XWJRLaAqi0S3C9OX8Qf8fT4vWGWgoOGMcM1jH4aNAXHO1mCppCvtZwXX6Tzo7UVWVQvokp6jIHIQcpWJ/Gf0zRioqB9LI5c03OjLNyAF8CgQbZcAsifJxoHTbTrHULR46AI4FVFO4UEZw4sgu6G5wJUs3nH13mCeXqu7OqV9buIFkPUiSgMunpIP5g8S2T6NFHRVG/1j66ADEdyQM9OOO6Lm2uxssKIXy3PIUjiq6al746xxSse/FxEfBWoaIVkEfFjsPLs56w3LgPugS3peDkQZh0xnNiXyiC85lKN3KKDi9RHpUlZr1zdxPitX9vw3cKTQndPKx4vZGqeQ5/i2n7ecPYV81S9gcc4dguAR9gIRZWASx4owIE4kO5UKXM5HIFsqE9LrxUyjZjCrSA7n3EoyCmvu8GL4lsQ5q7wKCtMmhrZsxKHK2fSw8mGXaZM0QPWwcZ0aDJ1mdp+4rXoHToJ+Ag9EBVK3tIZb4oeSE6HmBtoi1WQUbxYRXWSKQ3JYPK++/h6wFbBoKdZ1Fkv71ZXSEpjrJhH4UX3MBsLtLQIG34PgGzcLo8+ykUdIv0RsHFgiF7PuEyRo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c79fc-2b3f-404b-f3c0-08db5e2b5e43
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4264.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 20:54:16.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFgvrsakRws89zxxcAs/zAW+/FhCpt8LMvRqTRYYDiG/55kKfc1aOcyGTsiwMdAQiEefJSAE4joj0v6SjwQcgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_10,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260179
X-Proofpoint-ORIG-GUID: WromHly2mtZoRlYQKcI5QsmqFE5VsTy5
X-Proofpoint-GUID: WromHly2mtZoRlYQKcI5QsmqFE5VsTy5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/26/23 12:40 PM, Chuck Lever wrote:
> On Fri, May 26, 2023 at 12:34:16PM -0700, dai.ngo@oracle.com wrote:
>> On 5/26/23 11:38 AM, Chuck Lever wrote:
>>> On Fri, May 26, 2023 at 10:38:41AM -0700, Dai Ngo wrote:
>>>> If the GETATTR request on a file that has write delegation in effect
>>>> and the request attributes include the change info and size attribute
>>>> then the write delegation is recalled. The server waits a maximum of
>>>> 90ms for the delegation to be returned before replying NFS4ERR_DELAY
>>>> for the GETATTR.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    fs/nfsd/nfs4xdr.c   |  5 +++++
>>>>    fs/nfsd/state.h     |  3 +++
>>>>    3 files changed, 56 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index b90b74a5e66e..9f551dbf50d6 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -8353,3 +8353,51 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>>>    {
>>>>    	get_stateid(cstate, &u->write.wr_stateid);
>>>>    }
>>>> +
>>>> +/**
>>>> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
>>>> + * @rqstp: RPC transaction context
>>>> + * @inode: file to be checked for a conflict
>>>> + *
>>> Let's have this comment explain why this is necessary. At the least,
>>> it needs to cite RFC 8881 Section 18.7.4, which REQUIREs a conflicting
>>> write delegation to be gone before the server can respond to a
>>> change/size GETATTR request.
>> ok, will add the comment.
>>
>>>
>>>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>>>> + * code is returned.
>>>> + */
>>>> +__be32
>>>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>>>> +{
>>>> +	__be32 status;
>>>> +	int cnt;
>>>> +	struct file_lock_context *ctx;
>>>> +	struct file_lock *fl;
>>>> +	struct nfs4_delegation *dp;
>>>> +
>>>> +	ctx = locks_inode_context(inode);
>>>> +	if (!ctx)
>>>> +		return 0;
>>>> +	spin_lock(&ctx->flc_lock);
>>>> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>>>> +		if (fl->fl_flags == FL_LAYOUT ||
>>>> +				fl->fl_lmops != &nfsd_lease_mng_ops)
>>>> +			continue;
>>>> +		if (fl->fl_type == F_WRLCK) {
>>>> +			dp = fl->fl_owner;
>>>> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
>>>> +				spin_unlock(&ctx->flc_lock);
>>>> +				return 0;
>>>> +			}
>>>> +			spin_unlock(&ctx->flc_lock);
>>>> +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>>> +			if (status != nfserr_jukebox)
>>>> +				return status;
>>>> +			for (cnt = 3; cnt > 0; --cnt) {
>>>> +				if (!nfsd_wait_for_delegreturn(rqstp, inode))
>>>> +					continue;
>>>> +				return 0;
>>>> +			}
>>> I'd rather not retry here. Can you can say why a 30ms wait is not
>>> sufficient for this case?
>> on my VMs, it takes about 80ms for the the delegation return to complete.
> I'd rather not tune for tiny VM guests. How long does it take for a
> native client to handle CB_RECALL and return the delegation? It
> shouldn't take longer to do so than it would for the other cases the
> server already handles in under 30ms.
>
> Even 30ms is a long time to hold up an nfsd thread, IMO.

If the client takes less than 30ms to return the delegation then the
server will reply to the GETATTR right away, it does not wait for the
whole 90ms.

The 90ms is for the worst case scenario where the client/network is slow
or under load. Even if the server waits for the whole 90ms it's still
faster to reply to the GETATTR than sending CB_RECALL and wait for
DELEGRETURN before the server can reply to the GETATTR.

-Dai

>
>
>>>> +			return status;
>>>> +		}
>>>> +		break;
>>>> +	}
>>>> +	spin_unlock(&ctx->flc_lock);
>>>> +	return 0;
>>>> +}
>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>> index b83954fc57e3..4590b893dbc8 100644
>>>> --- a/fs/nfsd/nfs4xdr.c
>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>> @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>>>    		if (status)
>>>>    			goto out;
>>>>    	}
>>>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>>>> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
>>>> +		if (status)
>>>> +			goto out;
>>>> +	}
>>>>    	err = vfs_getattr(&path, &stat,
>>>>    			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index d49d3060ed4f..cbddcf484dba 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>>>    	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>>>    	return clp->cl_state == NFSD4_EXPIRABLE;
>>>>    }
>>>> +
>>>> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>>>> +				struct inode *inode);
>>>>    #endif   /* NFSD4_STATE_H */
>>>> -- 
>>>> 2.9.5
>>>>
