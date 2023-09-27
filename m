Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421AD7B0EDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjI0WYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:24:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E30AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:24:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL7Tne005172;
        Wed, 27 Sep 2023 22:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gcjlaA+t+Mauf2/u6Y7jeQWF05acvLWnLbSz4pqM4fY=;
 b=DKvjb4ykcizvJ7y05k81SBDRtLkIboAMkKAmUPQCl+ouFLw+VBShxt/bMKj+1xJSZEEQ
 o0GV2cX9SNNT/BmJ9AduBhyWoDTj12XUBuZZUh/7zoreXHpHAc3WZE0IHnXhuoZciVST
 jCf5WoBFuuyAaTB82Q4292jbYgdpSdvAaVOdJyd+WRKeSX+6bUGpNnht7/gyf7ReuAmY
 XDE7UtLVFQxeKf16c1oAmDEczr63zmuhqEjFYR+2IVxSMky8iYDliZtULnIP34tiIXpi
 d7R/oatDBOPzjzbgwvowZqzDlePFdyTxCpyDNrITr8xV3RnfifpxGZ5CynxyFq1oOQco sQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2avh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 22:23:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RKSSPF035041;
        Wed, 27 Sep 2023 22:23:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9015t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 22:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsHY4DlPC55am+jafG31XGO+gESW2TAzjHtXRsHKlRQo2WSJxddindio7cbJeiktMYyL67FsTLDHgs6VBBcFaXMd3sJOX68D/0/9sqiuKSuHPrFQSrbw1BwKutkcA+QjGO4cYsUSsAnCqBZ5hJOW8yTTrDEaH004UxjE55MHxNgVha6vFPV6Dv6wZmtAj0MJqEiVOWe3HPeUQ4CznbyunMVueaLvej/5UfaFc3ilYromN3MCMnWG6q7TjH6oiXkowkHwOkG5Xu6LmzfvB7ywRomT8FS4dvYfFT+hyY/SR7xGXM6EVvO15mLPKpl8ZDYXxefGhAk0+LdMcqQ3O2+3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcjlaA+t+Mauf2/u6Y7jeQWF05acvLWnLbSz4pqM4fY=;
 b=CV2jLysDn+ZSLeVvraLah3PQ8rYc5+sVQuTfOpw+zoCQ6/0o+mwhy8s3uU+SoZIVZoSUDswZUTs5i90xOQuD4U7SAbziNdIHSosRGhCpFdzem7PGq2GnSmhtKIRRrKxU+u9bFDbXAlSIK4DklO3Lpees9eKndEjN2mXRfvpJLSKlY/E870T8dTTqQxk7ChZBc9Vcxs+jajCfl+UTCoazFECcYQ5mTaSVAmUAbXF6TBim+/vvdBOEy7rJd9VBj6Lr1ezGOq1yXBRNj9KZKJSxTIbYHUj9E8N98YnvJbFNDg0NPQ5nzbxcmVuoWAtTZCvXlvRh2ySDGM0ldcUYcTbiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcjlaA+t+Mauf2/u6Y7jeQWF05acvLWnLbSz4pqM4fY=;
 b=medlNhPB9o7VdxQQxxANobwnXATyOZHwr1cRUUwh/KTU8epPmLGk8Ivt+pw5y31mWDoo+taHIpb29YWf9cZ7wnIPx0c9Fl6jDC39zZtNnSNDr/jHp2xu7rKtGsMOZSeU3jeRYJJrgvKeESiXxDLxTK1kNsxCwYHqFojo3yzvkL8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 22:23:20 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Wed, 27 Sep 2023
 22:23:19 +0000
Message-ID: <e32610af-732d-4f36-ace7-83112b94da1b@oracle.com>
Date:   Wed, 27 Sep 2023 17:23:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area>
 <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <20230917185742.GA19642@mit.edu>
 <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
 <20230918111402.7mx3wiecqt5axvs5@quack3>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230918111402.7mx3wiecqt5axvs5@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:610:b2::19) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a21f70-8ac4-49e3-659c-08dbbfa85a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZxPI+xjb6uhulZq9VdAzDqToajVVnD4giEc3sj9OorX+26/7912cWiuWo+XBaXVEmXuK3fpoiQxBrLCminCL9sFh+KD5v0y/TT6kxJXkX6RTtUsTQjM6CU5nk9suxhq3qdeAOntgnRyxYUYzIBHeYysZRH0Ku7sxdCkxxG4WOD5GNXdIdXuIqu48vxJ89PPGPpsOukCaBqyUQAxvy7Na/J0bMJQUW3GQFi9kTaAkWOrrprc/g4crKZJnZOfKQN5c5DPMVz8az2fEWptWw6gViI65nNddv0hefSF6SsCEFMVO5V2Pr94j50I9D/apPSSbDM1+T1M7O3QeNDJ1LN4B7mxif4rpn7R9MsHh/HDfK9buqSHPl1vtledzLvM+lymGvu/a5Dz5SC4I8dlVdCWNpjbChAN8nXPtL9RhLg1lOFhV170NsOL8UOvU55rSNJwsRh1Hz7SnxZbqGKgihPHBHGFg0R5/kyo+jEFBRa5fcGBeWQ6wpXBQHFlKQ3Xjk8eQh51E+VwKPaImo1CCmH5TYzG7QITMWySgu9ghRO5tWl8GhD/QdqsWWXijjQmF5l9cHxvX9jMixjSYsmaAP0lriifl6aWP37VfKkwbem6boUCdUPhGy41FxIwBneeAS3E/gJMKT1kNR9ytnquxqIWVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(2616005)(36756003)(6486002)(6506007)(6666004)(6512007)(478600001)(316002)(66556008)(110136005)(31686004)(66946007)(54906003)(38100700002)(41300700001)(66476007)(5660300002)(44832011)(7416002)(4744005)(86362001)(8936002)(8676002)(4326008)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2szQ0p2bjlId0h2dlQwQnhkV200Y3ViTXNVdXQ0bmFldEdKT0daTlNhWWtv?=
 =?utf-8?B?aU9NRmNFUGkxOEFTd0Rpcm1qOXhjNEtMSU5nb3RjUW9jOHFEQms0YXBMcDd5?=
 =?utf-8?B?SW5DSUdlZmlGSnFYbmFZUmc1V1FQSTZTTVVvdDBzWXV0VkxFSU81L2dqMHZw?=
 =?utf-8?B?aVh1TW9mWlh3cWV0SWY2bVJaWTBHd0hmS210U0o5cnMvV2JZdzY4WFpOUzZZ?=
 =?utf-8?B?OVlGdEt2YW5NUCt0aUp1MVBhc3VSUU1wd2dsU2N2bC9jMWVYNFRpaXpaMGQ4?=
 =?utf-8?B?dEdsMndLUUUwaWpPbTVWSFRWcERHeVRPcHdMbklVQThGZ24yNmpSRjZ1aUZF?=
 =?utf-8?B?dVhTdmdhRGFvS0ZWZk4vR015ZXpxTDZoZDBPMWtPcXdRL25rdklTMHI4ZDdS?=
 =?utf-8?B?dlBIVFNoZGgwdDE4VkoveUV5VWd4QzJHcmYrOGlkeXRWcXNQRFdkUEM3V085?=
 =?utf-8?B?R3VmN09ITWoycnJjVUloRVVpRSs4eVlDaHF2cGxtVkJzS3FXdXNXcmM1T0o1?=
 =?utf-8?B?WTFHdjRleUdMU1J4VTlPb1d5bEF4VzNtTnh6NDkvYlA0L1lLT0hVSktjYVo0?=
 =?utf-8?B?V3l2TE9rUWg2d29ka2F3UXFncGdlcWR2bFllN0UrY08wL212RUZ0RHcrS3Bv?=
 =?utf-8?B?UU05RUxSTnAxNXYzaVlWTWtBWnY4R3ZXUHNzL1BYcG9DN09VVVoyQUY4Y2pM?=
 =?utf-8?B?MSt1UmVHeWcxNzNlTHZmc0pOVjFyai8rdnhmMUQwTlRqVTJ1c1p5ZjBoRTEy?=
 =?utf-8?B?QkliVWlTZzRzaTN2Z01YdSsrUkhjaDBzeGtJN3U5bE54SGdlTkZSTlVKK1N0?=
 =?utf-8?B?b1NGMnVwM3pMdTRoTTcrRU5nOEkrdHFxK3N1NWh2cDVwT2tSalN4MytibFdp?=
 =?utf-8?B?T3lVeDhDTGNjTFdjbjZTRGpkOExXSTc0Wms3dmYrSDVFa2VWMkIvVC9HNUIw?=
 =?utf-8?B?ekp2Nmd3clNqMEl0L3Z4YUhCT3JkWXl3dXJhQWlVT0NwdVFBckQ5eGd3Z3ZK?=
 =?utf-8?B?djVORUR3V1plWmdYaUNaalZ5NDlVMUU2emtWOXl2M0orT01JYUFaMkNKUmdV?=
 =?utf-8?B?NUtWVXpnbm50TFgxaG5xVlJGc3BMRFJOOUtpNjRtL2JOaXVYVnE2ODdLODZ0?=
 =?utf-8?B?TDZVWU9HNGh5bVM4UlNCbkVnem4yVjRnYlIram9VMGdLOW1YTFlrMnkrOW1C?=
 =?utf-8?B?Nld4WUVRVDB1R0hLMFhBbnI4UGd4Nmp4OG91cTdQUnA0bTc4NE9zVjRxUElK?=
 =?utf-8?B?UFZvWTAzUlJ3WkJJS280dmhBV0hBQW5QSC93cWRyVlphZm4xeExieW92bVY4?=
 =?utf-8?B?dGhVcEJLSTBSa1gyMk1lVmJkbDdrN0NZRHlXMWo3cUJHZ0EvQWg1cnNVYnhx?=
 =?utf-8?B?blNUdTBtWXIrMUtZL1d5K2QwTnF3THIvaGY3QVkxV3RXcGMrSHppMzRaN2ZK?=
 =?utf-8?B?UHlTZkMvcXVoNTRlWXBraGR3Tmo3cUlKTERNakpiZVd0bVFpcHd1eFJLYVNF?=
 =?utf-8?B?eGtrVFVxNlZTMU1COWptNjdxSzdIb29PczBNSEdTYlZKdjM2ZVRFS1JIdXVs?=
 =?utf-8?B?S0U2U1JwVms5L2p1bVBsZW1LRkhtYUc2Q3U2U3o0K2tOb0NiZHdvd0Zuc3ho?=
 =?utf-8?B?U0xISmNzcVpsaXROTmw2NDgzWnEraDNReDBtVzg3T2hhYWN6dUprSnNob1Ew?=
 =?utf-8?B?TU1mR3FTSk1yV25ZWFJUUGFjYUF3akNhMjZSaVIxQ2hnUENzQ3JRdzBMa1ZW?=
 =?utf-8?B?RjR5N1ZqUlRMd3RHWnQreXhFRG1DdW9EcFNIMTZjN2hGRjZUc1RCbm14OFF3?=
 =?utf-8?B?cDl1ckJBU25LVUdSSm5ma3F3MytlY0hxWmNHL1ZXKzRyQnRJNXJ0M1FvRnoz?=
 =?utf-8?B?bjE3VDJBaXZOcnB3OHB4U3ZzY2M3NnI1NEJNVllmYnk0enEyNkhEcVl0b0Zo?=
 =?utf-8?B?KzdhbDNReWNTa3A2bkhEbnNXZXhnckFNMG9SUU9TMkFRTmZGck5wclMrd01S?=
 =?utf-8?B?UVg5R2R0WW11cHRUN1E1djYzQ0FsUHpFd0poMjFzWmNhclg2R0dpUXVuN0J6?=
 =?utf-8?B?cWs0RmMrNWs1d01UeG9YYTgyVUx0ak9HQlB0UFA0YXN5ZCt6QlJvOEFoUUtK?=
 =?utf-8?B?YTBjS0RXS3l3TWg5bjcvcWFZaTNMRS9waW9NNk1ZSytZNjhTM1ZLUU15RXJn?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXhpTFhaaWN6WGFzZ082WThmejlUWlJuLzNIUERwN3FNUlg4TWRCdEFTSUx5?=
 =?utf-8?B?c1pCMlZtb1JMNmFYb0I0SjhpN21VM2NUUS96U0V0RnVaZjdDQThZU2Z1MitF?=
 =?utf-8?B?YktqUnBHYXBvd05GVXFMdTBJYmVNV2ZRZnlOZHM4TFdieDJGcWpSU3UwRUtB?=
 =?utf-8?B?ODkxU3NGNzhhQXZ4OHZvekRrNmxTNVRvTWlpTnhPS3lmK2FzeEcxbWVWK3BE?=
 =?utf-8?B?TkRGOVlLOWlPeWY0LzVlQ2o5ajFWWHNGVXBOcHIwSWJENEE5eDN0dFJ6djhW?=
 =?utf-8?B?NHJaRitLSU9lOEdPZWJvWXRzNFVkNE9KWjFOZU1PZ1dkQ3lOYU1Ja1hOU1BL?=
 =?utf-8?B?NFQ2eXBMdE1GZmlsODhOTDR5LzFNa01NSmlCTXFheEl6dHl5MG1QUlJVTXdV?=
 =?utf-8?B?K1RTUisvTnJ5TklxWGp5UjVWeXE2S2pkQkxINXVnWVdzT3RIZ0lLOTlGalVX?=
 =?utf-8?B?bEh6RVFLbGdIeU5wWjFpY21xdGt1MFVhZDFJTW1TY0U2aXpNc3lmUHRpZWNn?=
 =?utf-8?B?R0JGcWpWYWloRUN0WkJZVVNFdHpONTBuanBaUjVGaWZ4cXJvLzdBZ0RuazFZ?=
 =?utf-8?B?WHBLWWU4NXcxa0ZESjl3NnZnMFZnSE53V0ZQUjlJSHVyOW8wTlY4OU95a1BV?=
 =?utf-8?B?d0g5TFdmNWRjMCtFOGU2c0VNV1lkTzJpYllIam50SzNJa3FOK3NrUHNoNWEz?=
 =?utf-8?B?UXpEWTgyOStXU25BaklvbHpRbTBUSlJqVHoycE5QNWtlV1JqNzFWd1EzRW84?=
 =?utf-8?B?UWxQMGJiWk5leUd5SkVPV2xFdzByTEZsMzE4a0VUSno4SGhXSW9IZXZLdmR2?=
 =?utf-8?B?RXZzM3ZYOWZzS2o1QmNVU3B1VUJRVkV2WmhmOHB2RWdwdVlXdGU5Q2FXQzNw?=
 =?utf-8?B?K0lhTWxwSVJtM0RyQzRRQzFFeFBvS0JFTHJSSGpIcEJhT1gwUWFMV1pyVnV1?=
 =?utf-8?B?cGduOE9PTFFZOU9FL2hjV1FCaDNzWVZWakprcHVVdVEvd0hoOFVQaGJtSWEz?=
 =?utf-8?B?VDZOd2hOc09iaVdMOWRQdHY0VEJUamN3NG5zNnVVb3pHcjZoNkdjdjNVYjNm?=
 =?utf-8?B?azlNblBiY0Y5SFg5L212TTZ3K0lYclZpMFRyTlkreTFwZk8xYWRJVzRzbi9I?=
 =?utf-8?B?aHRtcGd4Q0xqOUgrUnhWT2VzSlpmazc1c1lyT0IvQXFDSHVJaXpCcEp0SXhH?=
 =?utf-8?B?dEtUNkNHZWR6VVFNek5ZZUE2SjJGbzgwOEt6eTM3cmxhRC9PeWZTYUo2VXlC?=
 =?utf-8?B?S3hjWGpqNTdzZUlOY2JqUytiTG1mY0VuOXUyN2RSYnpwN2k5aHhQMXg2cXZ0?=
 =?utf-8?B?cCtPQUNlNmxaOXFUZm1aZ3BQdTJJSjRkN0ZkSTN3SUdoK3lhbnJYNWR2YWlX?=
 =?utf-8?B?MmFrRE9LUFBQTWNGbFZURVlGQTRYdXhvNzhzbHRWRjRPc280UWpOZDZKV3pI?=
 =?utf-8?B?MlNrT2oyY21ndk5RZlJyRjE5OEIxY3pqTEgrbzlFMEJhWlBkcWVzUmxTbG5W?=
 =?utf-8?B?L21aa0tjZnJubzNxM1htZGVrYUtDbWNWM2lsZElNdjNZV2RUZW45ejVlTmdY?=
 =?utf-8?B?bHZSZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a21f70-8ac4-49e3-659c-08dbbfa85a67
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:23:19.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPMJ/uis7FJt1SnwZqkEGmN7nisHptBG/pdLkH+jhTIpq4mjQ/zthG7+Qq8QGUDSp7gVas7hLgAvyz6cwtvZa4rm50eWDbrpVNpy4Htfdig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270193
X-Proofpoint-ORIG-GUID: pXaT2taM6EsXHw8oUcV2AvbedN2JUyJB
X-Proofpoint-GUID: pXaT2taM6EsXHw8oUcV2AvbedN2JUyJB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 6:14AM, Jan Kara wrote:

> I agree. On the other hand each filesystem we carry imposes some
> maintenance burden (due to tree wide changes that are happening) and the
> question I have for some of them is: Do these filesystems actually bring
> any value? I.e., are there still any users left? Sadly that's quite
> difficult to answer so people do bother only if the pain is significant
> enough like in the case of reiserfs. But I suspect we could get rid of a
> few more without a real user complaining (e.g. Shaggy said he'd be happy to
> deprecate JFS and he's not aware of any users).

Sorry for the late response, but just catching up on this discussion.

When I did make that statement, I did get a response that there actually 
are some users out there that want JFS to stay.

Every few weeks I do try to catch up JFS things. I can try to do so 
weekly. (We'll see how that goes.) I'm not promising and major revisions 
though.

Shaggy

