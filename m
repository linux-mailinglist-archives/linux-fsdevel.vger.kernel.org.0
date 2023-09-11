Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF679BBE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjIKU4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbjIKNhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:37:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286FCC3;
        Mon, 11 Sep 2023 06:37:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BChWKT028465;
        Mon, 11 Sep 2023 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=zQRHZxc2cNe0/aT1OLeF48+IaXyaKO++elVWjVe08Wc=;
 b=kOZj5UojGCOtsjQc7lzwS4rdobNvWvekoXasRo7qi5EKk9mevRK5ExuTOrhcnzPZiVkU
 NPpaEqOt+p+A+d9Q+9BjjJpb8Jjn2iJVp/EdiIYh39phJ+i+XBksTMBbbvnBLH4s5Dui
 LIh4ByOKcAUz8a3s4FVQQvu8Bqri0uf+B0MwEvzy81f1itycJqMUV67GRbPLnRs68Pq9
 +uVCo3Z0T3oHFwoxWQxJR5RXos1f91Oma80yvE0o9+AMfPaPl0cg0FwpKjIGmtt6TQV9
 pAecBU4i1iiTLrl/gYzAw1WmXymERvrNgJVm6Sqqx5wsczXUC7dP9ITs+sYAugid3uZ0 Ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp79fne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 13:36:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BBqNcF014716;
        Mon, 11 Sep 2023 13:36:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5afea3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 13:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5HhwYRafUlKXEOzL0VJZhFlhN8FDwLRAK7V9Tsm3HI3N8SYa1tAUTdFaaq+Lda9caHno5057s/N1gNB1hOwikwvqljT2qo0n3u4DOu6MzgWNlU/2umC0gpcOOyz2PGnFcdF/EtVAUu/O/s8IgRvTDFHJNP760deHjsiySMzbh/2SHiKEmFCUwsXgqSMcUuqimdSpW5P9/MUpHrg3wN2WWmSVIvJ8T1zusE8rifgmkL1fxDgxPGHaQg8rblo/sN9goxB3UCFfWas4jEHF9INQpISNvxC6r4vdSGLZmBrbOAd2swdkrgiXUGaCbU5DenJkhpSdK1UtWiMT2ofezmZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQRHZxc2cNe0/aT1OLeF48+IaXyaKO++elVWjVe08Wc=;
 b=MxE7fRJ3BgyJap03PqYh6O3aMh+4nYRQo5XRebDZlmNIDImdZ+G+nWgqffXBsA+fFwhtF+ODfAXTxQSkGsj7nt8mGttfq1Ab0LZfP64VeppSLWlOAk/mzjSMC+ZWvx9+NRK7CQ3aItqb4Dyf1PWtxdxI1gtnBiRM/yRvIxpYyk27vBAcWkoVgHOGrTlaRk0oE4ttABWCYWaK+5bTXJVXkp6tRygG8QId82SI4p2BqRzdauLIZBuQPxgJUjfzSR+z0HQaSK9OJjkIq8Ev5TohS1Vwb3YMJy3mg8vc3VvTpY6D2Kmi352uh0hPPDHcALLJZoVtU9Is3OsBxQ9VVnbAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQRHZxc2cNe0/aT1OLeF48+IaXyaKO++elVWjVe08Wc=;
 b=u/DjBJ5chTFJHKkzJDnIUPLX6qj69QvISAdSFU5cjB8BzmmTRiBnbmxSlWER68VW4Y7qwviw68Mj/hjQ893ZBcIFNX6dHH/DhUJ2jCnJRpzuuhFRYz8VfGRiR3E03t+EooVRgzu/ddisCDEmhfh3//0pB0imjOGqY2IA1Cv3ETo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.35; Mon, 11 Sep
 2023 13:36:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:36:54 +0000
Date:   Mon, 11 Sep 2023 09:36:50 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <20230911133650.6673xqdeunheebbl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-3-zhangpeng.00@bytedance.com>
 <20230907201333.nyydilmlbbf2wzf7@revolver>
 <d388a9e5-560a-72c2-4db5-1f39827740c9@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d388a9e5-560a-72c2-4db5-1f39827740c9@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee867ae-5607-41ec-4306-08dbb2cc2925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58gdbqQXIzovnNcSvTSqE6xrV8cfq6FNVLqLBzPxX9Nx0FuAIJd1aYIOalHDJDbSApNL4RDGbj5HvUWiVweL0byvg1hXjZHA3kximsUO97m7z0fU0hUddAK3wNRd2uaewty79FEtO6tAqKor6cFVN1eTN/IjLnTzJ+BT9iUT1SAgq+Mgzo7RzpsqfLzP73ANEfVSnozlLpM+QB7g6LGMd832WYEemlZMOBb9Dhpg3R/I1tyDIBbtt/jjX0CU49PwWU2ddQ74woy9W7bGis1ugaFCdFXO2gT6Y9LM1f63TLdKeQTwMNDwnPDPz7ldEukoUke0NkZVxZgiwRRw3RPin1uk3iQYcIJScApbwm/n8NjmuAHH4DmG1t0JOSu65lb9VC6Hz/Bf8AK6lnAnkaIcGhs6DwNLdgVx2zcVzDryCdk8MmIChz5FrCjOV8w8GnzdHCpriCjJDpcGAd9jn2bgFfV1k9s2iyeEaVuWLO3HDVQ8VHCxY7Wa1bjXw+Qa31N8RP97kR1oIUGYXekOg5CY9c1Qa8HvZu9EehXau1ZdmirVuBzUnepL7p+qiqKfW/Q7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199024)(1800799009)(186009)(6916009)(41300700001)(316002)(66476007)(6666004)(1076003)(86362001)(66946007)(7416002)(2906002)(4326008)(8676002)(30864003)(5660300002)(8936002)(478600001)(38100700002)(66556008)(6506007)(9686003)(6512007)(6486002)(33716001)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JnazM0UE9PSk5tcnJvUHZhVUw2VCtoNHdzMVkzZFUxd3hZUnp5VTZMaC9s?=
 =?utf-8?B?ekJkcFhzMWV2SHRhZTVYSEdmUVRsSm5lMklzbWNSYlEvWm1vNUIyVWE0cHRm?=
 =?utf-8?B?N21PNWk5a2toenZQZ2lCcFJlS1NxWHM2WnYzWGd2ZnRKK3FnYnQwc1JKdUow?=
 =?utf-8?B?eFBrWVBISUZ1ZWhpOGk0N0QwNDJxb3VSdm1CUjZiWUU2am1aOTBIRE1SSzl4?=
 =?utf-8?B?eEZIU0pndXlFRXB4YVVOa3p5K2p5eW53WnU0eXBtMlNYb200WmdFZ3dkNzU0?=
 =?utf-8?B?bXFWT1p6VDM0U1dFSjliaU13d29MakxoNmlRVWJqbHFNWFMzeGtIK0tScS9O?=
 =?utf-8?B?eGJOdzZVOGdjTERvclZncnBGY3ZnNXJhU0c4YTR3QU81U05WS2RGQWZsalRJ?=
 =?utf-8?B?WGkvbThSM2NjYjlMTXJwSG8wYmRmZURjSnBabW02NC9tT1FuTzFKQmhqV284?=
 =?utf-8?B?dlFaOVl5bUdTbHFLV3Bsam5MWnJweURUTW9tQVpsTWt0eUFWMW1RVU9SUG0w?=
 =?utf-8?B?ZHE2S0JNUnRnQzVoNXJCVjM1cE9kaEZRTVpuSGFUMTVzdGpITWthM0U2aVE4?=
 =?utf-8?B?MEpUQ2FxZTJkNGxpZVM3UWFsTGlKRThadG91SGR5aDhoUnRwQ2NRaXRnQitm?=
 =?utf-8?B?Wnhpa0Roa2F3cy8rM0h4c3h2QTdRNDF3SkNhRDk3QmpPUGVjRkVIS0FGTEFt?=
 =?utf-8?B?bDZxbzN3WW5LM1d4NTF5VDFSVFg2ZmFpaSswVGp3MmROYUdtdUJpWHo4dzhF?=
 =?utf-8?B?TmVYajZtZXRTaUh6dFhHdDhMalBvbTBCajZEQk4xbTZnT0JtWk9hejlMbUkv?=
 =?utf-8?B?SU1XeG5iSDVrR3RvQzJVSkQ5b2Y5TFFHNk1QQk42L0FTd0xMSHIxajJETGlW?=
 =?utf-8?B?aUhIaEY5cmFuMmpzeVFlQkZ5QzRMbzdpZ29aeE5oS3h6dHpvbjdxUTJ4RVRt?=
 =?utf-8?B?QTM5S3hoenAxMDJGYW9EZFlHYWZVamNHZkFCT3V3dVIzOUdtRVNLc25pMFVj?=
 =?utf-8?B?cmRIVmx1L2ozd09GQ3FMNEM5dHBYQlpGajEyY1pCR05zOWRsL29kYk9zVzhU?=
 =?utf-8?B?aG9QSk1SaSsyV2VoT3J4WFJaM2ZxbTFobFpTeXYwNkNtL0U3RG05RG5GWTJW?=
 =?utf-8?B?aEJtRnhSRnk5MVFzUFRDSkhxcE9zelUrUk9hbDFKWDlYMDk1bTNIcjN5dG5K?=
 =?utf-8?B?ZktGMFk2aFpZU2Y3azZUS0NhZlpHRktiME9lNUtSaldzL0hDbHRBQXZWVzd4?=
 =?utf-8?B?eHJmdzVlcXBON1ZYZVZ1ZVllWGg5TFlhNnhHMFpzR0VRWW4wbTVwdDlranFM?=
 =?utf-8?B?ZWlmNSs2MHEvUDQrbStnaVg5QWl5eGNtdlFYZDJRcEhHQ0lra052c284cXZD?=
 =?utf-8?B?MHFJbStEREprb3d6RDFheHRXN2M4MytRZFRFeFNNTFpGaWNSWUZXZDdDQnVp?=
 =?utf-8?B?MXNGbjVMR1pMRkE1MFdzVmJjMzh5Tlh1eVEyU3JiaVlTaHI0bFBVeCtUL3ZU?=
 =?utf-8?B?Qndsa2NIOXNhNXZUNHc0MUd5Sm5vZEgvbnVIN3hXS2IreVJkZExyc3BCNStU?=
 =?utf-8?B?QVZPNkFGUlpYUk5KanllbzIvYU9xZ0FOallaRUFSb2hDdDR2cmVKMnBqci9r?=
 =?utf-8?B?OFNMSkw3cklxTmVHZ3JvQUJaMUgvZ283MkRCekJ1NjFiR3hlb3hReDRoeDdm?=
 =?utf-8?B?STBzL0tja1JiRzQyRlVZL2hXV0dYR2Z3cFVwdXpYNW4zc21QbGR2SnpON1NP?=
 =?utf-8?B?ZGdncFJlTllYNUpTaEJYYWhKQ2tKM1VlVUNjT0hGTnZkeWhhZzRtNFp5Qzc2?=
 =?utf-8?B?V0ovY0tBQ0dSVkhHSHVZNjN5NVAxTGhDa245TTRPd0h0VG9PU2xOVVVpeTBx?=
 =?utf-8?B?UDlqN2lSQnRwT0Z0a2NSRVJwdmx1VUt5ZzdwRmZmWFBzakVvSDBUQTZ4SVdE?=
 =?utf-8?B?NklBTDBzRmZzcVZuWVB1WElPa0V1d2Y3Z2ZqU2FIT2t6Z3ZOSWREeTlzUmVW?=
 =?utf-8?B?Tm04ZDF5aEhzN2VXT0tLY1YwSEh0OGRWdXltdU5YaDZxT3FYUWE1NHZsVk9s?=
 =?utf-8?B?aUJhVkxCN2F1NWZtNFpkVnlvZWFYY2NnZGZCMmI1N295VVowaUtsL1l6U1pJ?=
 =?utf-8?Q?+X2nxTKg8M/BXj2JLCLjmGDsX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zm1RRDJ6NjV0NXZrMVZmdTFLYXk4cEZPV1RwbXRrVzRDYzdSa3FDSG95ZUVB?=
 =?utf-8?B?UFYxSXE2RzcrR2VzSnNvQVlmUHZSWGFzYWJIT0hYcDV2dzZLdnh5RW15V1Jx?=
 =?utf-8?B?cVNIM1F1NDB5MlBMeHhVdzhXQ2o3NG9jTXFGUVJJQ2lDMElMSmU0Rll1NGpk?=
 =?utf-8?B?SUd2cDlmQVJFZDdlS3Y4OGE2VXRSRDIvM1N1RlFVQzBhVDUvNksrQlpTUnhS?=
 =?utf-8?B?ZkNZdzJkUVUzdGRIU3R3bGtQaThYL2tVa28wakVsb0VocXhiSEg4QkdJVnl4?=
 =?utf-8?B?RUMwbVZSVWxFSXljblg5TVhGQ0kwcVBzSHhMOXNYT3ZhOEMxczVSMkZwU2FU?=
 =?utf-8?B?WG4vcVBtV2RKTXREckR3V1FSdGVLN0YrU3F2WWRuWUZmazVNbFcreXVLRkRJ?=
 =?utf-8?B?SW5pOEFMUW8wa1BzaG1LcHFhNGdySHp0YVNGRzg3K01oL0J1d2RqWTVXSFBT?=
 =?utf-8?B?bHB1TlVLZGRudjhoaUExa1ZHaVJuTkgzeHB5TUl3bGl5R2oyOVFEYllCKzcx?=
 =?utf-8?B?Tk9Va0IyY1FkMmsxbUJ2WU9qazllUnNDZ2VEaXJDRENVbUdhVkJ4d1U3eUps?=
 =?utf-8?B?ZW5oOFVkMjByUDhGOHZIMjk4bTZVMWZDZmlVTiszeEtjWVB3NW9YN09XYnJ1?=
 =?utf-8?B?ZzdTeGY0d2djSWlzVlM1azh2dUVhZ3BrcGN4WVRCalhNTHo2WGhrYW5UbTUz?=
 =?utf-8?B?a3ZQMHJlZENRUmZVOXVMcGQza2NpSnhpa2RlNVlZRkM4RXhXSmtBS0F6QWhi?=
 =?utf-8?B?clluUzN2a0NGUGpJUEx0RFVIRHVQS1Q1R2VKV2wxOTAzc0tPVGJLZ01Vbm5a?=
 =?utf-8?B?c0pLQi9ScUwvUi8wVnpmNUxrdk5zZUFkVkJzV2FwV0J5clpXSFRBNStEQlJa?=
 =?utf-8?B?RFVLWmcycEgwNkZUSlNwZFE2K0k4VEhiSlJZcnY3TVBKeXBvc3d6LzcvVmI1?=
 =?utf-8?B?UFdiOVYwajdmNmxUQXlSZnNQQmI4UUJJWC9jaFMvYTc2ZlFGRm85Z0ZtWkNi?=
 =?utf-8?B?VDJ1NXp2amxrdjBIZ2wrQkVaWEp0NTVRd1ZOUVV4N2dLRTJ6UFNlSGdqMEt3?=
 =?utf-8?B?d3NkYnk5cCt6RGRhenJwSThvWnFDWmpZUnpMTXVjRXVEM05DYmNXSWF5WTg2?=
 =?utf-8?B?OXFvU2NNcjVUcUh5c0U2Q0pKZFMvMklteTFVZ0ZNNXUwQUVwNjRNaDZrRzBa?=
 =?utf-8?B?MnB1a0pnQ0MxcEFmakk5OGZsb0ZrSzBjV0VxWkpoSzZpWFVwOGFQZW9JNHhq?=
 =?utf-8?B?aXIzMkhzdkNLWHp5ejN2Mm94bVNrSGdEbEI2ZHA4Y0dNMHF2ZTdrVUtxVmx4?=
 =?utf-8?B?RkZxY0ZvOExBR1V2Mjg3eEp1RW5Pd3k5UmRJRHh2ZWVwc3J0M1ZmUzZuampV?=
 =?utf-8?B?Unk0WVc4ck5QL1MyT2JuMEFGSmI1dG1KME8wTitVeXlGL2NzWEFPUUZPQlBv?=
 =?utf-8?Q?OvN/QVie?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee867ae-5607-41ec-4306-08dbb2cc2925
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:36:54.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAAKztwj1O98uFZpjYhqjd/qMGaIeoUZDwAc9F80n3xdUn52TML4LIUbjlZuVI58YhOP3bIO6nqvvNTq5Ha0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110124
X-Proofpoint-GUID: tUQVcLOIMoNWrwA2TGJuS1jdeQSW2oAU
X-Proofpoint-ORIG-GUID: tUQVcLOIMoNWrwA2TGJuS1jdeQSW2oAU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230911 08:59]:
>=20
>=20
> =E5=9C=A8 2023/9/8 04:13, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:57]:
> > > Introduce interfaces __mt_dup() and mtree_dup(), which are used to
> > > duplicate a maple tree. Compared with traversing the source tree and
> > > reinserting entry by entry in the new tree, it has better performance=
.
> > > The difference between __mt_dup() and mtree_dup() is that mtree_dup()
> > > handles locks internally.
> >=20
> > __mt_dup() should be called mas_dup() to indicate the advanced interfac=
e
> > which requires users to handle their own locks.
> Changing to the mas_dup() interface may look like this:
> mas_dup(mas_old, mas_new)
>=20
> This still encounters the problem we discussed before. You expect both
> mas_old and mas_new to point to the first element after the function
> returns, but for_each_vma(vmi, mpnt) in dup_mmap() does not support
> this, and will skip the first element.
>=20
> Unless we have an iterator similar to "do {} while()", we have to reset
> mas_new. There is still additional overhead in making both mas_old and
> mas_new point to the first element, because mas will point to the last
> node after dfs order traversal.

I was only looking for the name change.  Although, I think we could have
written in a way to avoid skipping the first element.

>=20
> In fact, I think mtree_dup() and __mt_dup() are enough. They seem to
> match mtree_destroy() and __mt_destroy() very well. Underlines indicate
> that users need to handle the lock themselves.

I think you are correct, __mt_dup() doesn't take a maple state.  Thanks
for pointing that out.  Please leave it the way you have it.

> >=20
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   include/linux/maple_tree.h |   3 +
> > >   lib/maple_tree.c           | 265 ++++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 268 insertions(+)
> > >=20
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index e41c70ac7744..44fe8a57ecbd 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned l=
ong index,
> > >   		void *entry, gfp_t gfp);
> > >   void *mtree_erase(struct maple_tree *mt, unsigned long index);
> > > +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t g=
fp);
> > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gf=
p);
> > > +
> > >   void mtree_destroy(struct maple_tree *mt);
> > >   void __mt_destroy(struct maple_tree *mt);
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index ef234cf02e3e..8f841682269c 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -6370,6 +6370,271 @@ void *mtree_erase(struct maple_tree *mt, unsi=
gned long index)
> > >   }
> > >   EXPORT_SYMBOL(mtree_erase);
> > > +/*
> > > + * mas_dup_free() - Free a half-constructed tree.
> >=20
> > Maybe "Free an incomplete duplication of a tree" ?
> >=20
> > > + * @mas: Points to the last node of the half-constructed tree.
> >=20
> > Your use of "Points to" seems to indicate someone knows you are talking
> > about a "maple state that has a node pointing to".  Can this be made
> > more clear?
> > @mas: The maple state of a incomplete tree.
> >=20
> > Then add a note that @mas->node points to the last successfully
> > allocated node?
> >=20
> > Or something along those lines.
> >=20
> > > + *
> > > + * This function frees all nodes starting from @mas->node in the rev=
erse order
> > > + * of mas_dup_build(). There is no need to hold the source tree lock=
 at this
> > > + * time.
> > > + */
> > > +static void mas_dup_free(struct ma_state *mas)
> > > +{
> > > +	struct maple_node *node;
> > > +	enum maple_type type;
> > > +	void __rcu **slots;
> > > +	unsigned char count, i;
> > > +
> > > +	/* Maybe the first node allocation failed. */
> > > +	if (!mas->node)
> > > +		return;
> > > +
> > > +	while (!mte_is_root(mas->node)) {
> > > +		mas_ascend(mas);
> > > +
> > > +		if (mas->offset) {
> > > +			mas->offset--;
> > > +			do {
> > > +				mas_descend(mas);
> > > +				mas->offset =3D mas_data_end(mas);
> > > +			} while (!mte_is_leaf(mas->node));
> >=20
> > Can you blindly descend and check !mte_is_leaf()?  What happens when th=
e
> > tree duplication fails at random internal nodes?  Maybe I missed how
> > this cannot happen?
> >=20
> > > +
> > > +			mas_ascend(mas);
> > > +		}
> > > +
> > > +		node =3D mte_to_node(mas->node);
> > > +		type =3D mte_node_type(mas->node);
> > > +		slots =3D (void **)ma_slots(node, type);
> > > +		count =3D mas_data_end(mas) + 1;
> > > +		for (i =3D 0; i < count; i++)
> > > +			((unsigned long *)slots)[i] &=3D ~MAPLE_NODE_MASK;
> > > +
> > > +		mt_free_bulk(count, slots);
> > > +	}
> >=20
> >=20
> > > +
> > > +	node =3D mte_to_node(mas->node);
> > > +	mt_free_one(node);
> > > +}
> > > +
> > > +/*
> > > + * mas_copy_node() - Copy a maple node and allocate child nodes.
> >=20
> > if required. "..and allocate child nodes if required."
> >=20
> > > + * @mas: Points to the source node.
> > > + * @new_mas: Points to the new node.
> > > + * @parent: The parent node of the new node.
> > > + * @gfp: The GFP_FLAGS to use for allocations.
> > > + *
> > > + * Copy @mas->node to @new_mas->node, set @parent to be the parent o=
f
> > > + * @new_mas->node and allocate new child nodes for @new_mas->node.
> > > + * If memory allocation fails, @mas is set to -ENOMEM.
> > > + */
> > > +static inline void mas_copy_node(struct ma_state *mas, struct ma_sta=
te *new_mas,
> > > +		struct maple_node *parent, gfp_t gfp)
> > > +{
> > > +	struct maple_node *node =3D mte_to_node(mas->node);
> > > +	struct maple_node *new_node =3D mte_to_node(new_mas->node);
> > > +	enum maple_type type;
> > > +	unsigned long val;
> > > +	unsigned char request, count, i;
> > > +	void __rcu **slots;
> > > +	void __rcu **new_slots;
> > > +
> > > +	/* Copy the node completely. */
> > > +	memcpy(new_node, node, sizeof(struct maple_node));
> > > +
> > > +	/* Update the parent node pointer. */
> > > +	if (unlikely(ma_is_root(node)))
> > > +		val =3D MA_ROOT_PARENT;
> > > +	else
> > > +		val =3D (unsigned long)node->parent & MAPLE_NODE_MASK;
> >=20
> > If you treat the root as special and outside the loop, then you can
> > avoid the check for root for every non-root node.  For root, you just
> > need to copy and do this special parent thing before the main loop in
> > mas_dup_build().  This will avoid an extra branch for each VMA over 14,
> > so that would add up to a lot of instructions.
> >=20
> > > +
> > > +	new_node->parent =3D ma_parent_ptr(val | (unsigned long)parent);
> > > +
> > > +	if (mte_is_leaf(mas->node))
> > > +		return;
> >=20
> > You are checking here and in mas_dup_build() for the leaf, splitting th=
e
> > function into parent assignment and allocate would allow you to check
> > once. Copy could be moved to the main loop or with the parent setting,
> > depending on how you handle the root suggestion above.
> >=20
> > > +
> > > +	/* Allocate memory for child nodes. */
> > > +	type =3D mte_node_type(mas->node);
> > > +	new_slots =3D ma_slots(new_node, type);
> > > +	request =3D mas_data_end(mas) + 1;
> > > +	count =3D mt_alloc_bulk(gfp, request, new_slots);
> > > +	if (unlikely(count < request)) {
> > > +		if (count)
> > > +			mt_free_bulk(count, new_slots);
> >=20
> > The new_slots will still contain the addresses of the freed nodes.
> > Don't you need to clear it here to avoid a double free?  Is there a
> > test case for this in your testing?  Again, I may have missed how this
> > is not possible..
> >=20
> > > +		mas_set_err(mas, -ENOMEM);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Restore node type information in slots. */
> > > +	slots =3D ma_slots(node, type);
> > > +	for (i =3D 0; i < count; i++)
> > > +		((unsigned long *)new_slots)[i] |=3D
> > > +			((unsigned long)mt_slot_locked(mas->tree, slots, i) &
> > > +			MAPLE_NODE_MASK);
> >=20
> > Can you expand this to multiple lines to make it more clear what is
> > going on?
> >=20
> > > +}
> > > +
> > > +/*
> > > + * mas_dup_build() - Build a new maple tree from a source tree
> > > + * @mas: The maple state of source tree.
> > > + * @new_mas: The maple state of new tree.
> > > + * @gfp: The GFP_FLAGS to use for allocations.
> > > + *
> > > + * This function builds a new tree in DFS preorder. If the memory al=
location
> > > + * fails, the error code -ENOMEM will be set in @mas, and @new_mas p=
oints to the
> > > + * last node. mas_dup_free() will free the half-constructed tree.
> > > + *
> > > + * Note that the attributes of the two trees must be exactly the sam=
e, and the
> > > + * new tree must be empty, otherwise -EINVAL will be returned.
> > > + */
> > > +static inline void mas_dup_build(struct ma_state *mas, struct ma_sta=
te *new_mas,
> > > +		gfp_t gfp)
> > > +{
> > > +	struct maple_node *node, *parent;
> >=20
> > Could parent be struct maple_pnode?
> >=20
> > > +	struct maple_enode *root;
> > > +	enum maple_type type;
> > > +
> > > +	if (unlikely(mt_attr(mas->tree) !=3D mt_attr(new_mas->tree)) ||
> > > +	    unlikely(!mtree_empty(new_mas->tree))) {
> > > +		mas_set_err(mas, -EINVAL);
> > > +		return;
> > > +	}
> > > +
> > > +	mas_start(mas);
> > > +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
> > > +		/*
> > > +		 * The attributes of the two trees must be the same before this.
> > > +		 * The following assignment makes them the same height.
> > > +		 */
> > > +		new_mas->tree->ma_flags =3D mas->tree->ma_flags;
> > > +		rcu_assign_pointer(new_mas->tree->ma_root, mas->tree->ma_root);
> > > +		return;
> > > +	}
> > > +
> > > +	node =3D mt_alloc_one(gfp);
> > > +	if (!node) {
> > > +		new_mas->node =3D NULL;
> >=20
> > We don't have checks around for node =3D=3D NULL, MAS_NONE would be a s=
afer
> > choice.  It is unlikely that someone would dup the tree and fail then
> > call something else, but I avoid setting node to NULL.
> >=20
> > > +		mas_set_err(mas, -ENOMEM);
> > > +		return;
> > > +	}
> > > +
> > > +	type =3D mte_node_type(mas->node);
> > > +	root =3D mt_mk_node(node, type);
> > > +	new_mas->node =3D root;
> > > +	new_mas->min =3D 0;
> > > +	new_mas->max =3D ULONG_MAX;
> > > +	parent =3D ma_mnode_ptr(new_mas->tree);
> > > +
> > > +	while (1) {
> > > +		mas_copy_node(mas, new_mas, parent, gfp);
> > > +
> > > +		if (unlikely(mas_is_err(mas)))
> > > +			return;
> > > +
> > > +		/* Once we reach a leaf, we need to ascend, or end the loop. */
> > > +		if (mte_is_leaf(mas->node)) {
> > > +			if (mas->max =3D=3D ULONG_MAX) {
> > > +				new_mas->tree->ma_flags =3D mas->tree->ma_flags;
> > > +				rcu_assign_pointer(new_mas->tree->ma_root,
> > > +						   mte_mk_root(root));
> > > +				break;
> >=20
> > If you move this to the end of the function, you can replace the same
> > block above with a goto.  That will avoid breaking the line up.
> >=20
> > > +			}
> > > +
> > > +			do {
> > > +				/*
> > > +				 * Must not at the root node, because we've
> > > +				 * already end the loop when we reach the last
> > > +				 * leaf.
> > > +				 */
> >=20
> > I'm not sure what the comment above is trying to say.  Do you mean "Thi=
s
> > won't reach the root node because the loop will break when the last lea=
f
> > is hit"?  I don't think that is accurate.. it will hit the root node bu=
t
> > not the end of the root node, right?  Anyways, the comment isn't clear
> > so please have a look.
> >=20
> > > +				mas_ascend(mas);
> > > +				mas_ascend(new_mas);
> > > +			} while (mas->offset =3D=3D mas_data_end(mas));
> > > +
> > > +			mas->offset++;
> > > +			new_mas->offset++;
> > > +		}
> > > +
> > > +		mas_descend(mas);
> > > +		parent =3D mte_to_node(new_mas->node);
> > > +		mas_descend(new_mas);
> > > +		mas->offset =3D 0;
> > > +		new_mas->offset =3D 0;
> > > +	}
> > > +}
> > > +
> > > +/**
> > > + * __mt_dup(): Duplicate a maple tree
> > > + * @mt: The source maple tree
> > > + * @new: The new maple tree
> > > + * @gfp: The GFP_FLAGS to use for allocations
> > > + *
> > > + * This function duplicates a maple tree using a faster method than =
traversing
> > > + * the source tree and inserting entries into the new tree one by on=
e.
> >=20
> > Can you make this comment more about what your code does instead of the
> > "one by one" description?
> >=20
> > > + * The user needs to ensure that the attributes of the source tree a=
nd the new
> > > + * tree are the same, and the new tree needs to be an empty tree, ot=
herwise
> > > + * -EINVAL will be returned.
> > > + * Note that the user needs to manually lock the source tree and the=
 new tree.
> > > + *
> > > + * Return: 0 on success, -ENOMEM if memory could not be allocated, -=
EINVAL If
> > > + * the attributes of the two trees are different or the new tree is =
not an empty
> > > + * tree.
> > > + */
> > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gf=
p)
> > > +{
> > > +	int ret =3D 0;
> > > +	MA_STATE(mas, mt, 0, 0);
> > > +	MA_STATE(new_mas, new, 0, 0);
> > > +
> > > +	mas_dup_build(&mas, &new_mas, gfp);
> > > +
> > > +	if (unlikely(mas_is_err(&mas))) {
> > > +		ret =3D xa_err(mas.node);
> > > +		if (ret =3D=3D -ENOMEM)
> > > +			mas_dup_free(&new_mas);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(__mt_dup);
> > > +
> > > +/**
> > > + * mtree_dup(): Duplicate a maple tree
> > > + * @mt: The source maple tree
> > > + * @new: The new maple tree
> > > + * @gfp: The GFP_FLAGS to use for allocations
> > > + *
> > > + * This function duplicates a maple tree using a faster method than =
traversing
> > > + * the source tree and inserting entries into the new tree one by on=
e.
> >=20
> > Again, it's more interesting to state it uses the DFS preorder copy.
> >=20
> > It is also worth mentioning the superior allocation behaviour since tha=
t
> > is a desirable trait for many.  In fact, you should add the allocation
> > behaviour in your cover letter.
> >=20
> > > + * The user needs to ensure that the attributes of the source tree a=
nd the new
> > > + * tree are the same, and the new tree needs to be an empty tree, ot=
herwise
> > > + * -EINVAL will be returned.
> > > + *
> > > + * Return: 0 on success, -ENOMEM if memory could not be allocated, -=
EINVAL If
> > > + * the attributes of the two trees are different or the new tree is =
not an empty
> > > + * tree.
> > > + */
> > > +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t g=
fp)
> > > +{
> > > +	int ret =3D 0;
> > > +	MA_STATE(mas, mt, 0, 0);
> > > +	MA_STATE(new_mas, new, 0, 0);
> > > +
> > > +	mas_lock(&new_mas);
> > > +	mas_lock(&mas);
> > > +
> > > +	mas_dup_build(&mas, &new_mas, gfp);
> > > +	mas_unlock(&mas);
> > > +
> > > +	if (unlikely(mas_is_err(&mas))) {
> > > +		ret =3D xa_err(mas.node);
> > > +		if (ret =3D=3D -ENOMEM)
> > > +			mas_dup_free(&new_mas);
> > > +	}
> > > +
> > > +	mas_unlock(&new_mas);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(mtree_dup);
> > > +
> > >   /**
> > >    * __mt_destroy() - Walk and free all nodes of a locked maple tree.
> > >    * @mt: The maple tree
> > > --=20
> > > 2.20.1
> > >=20
