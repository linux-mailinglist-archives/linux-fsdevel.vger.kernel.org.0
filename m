Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B896D797B1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbjIGSEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbjIGSEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:04:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97626E45;
        Thu,  7 Sep 2023 11:04:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Hsw2U018405;
        Thu, 7 Sep 2023 18:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ksT3sTRfJ1IHx/fy0uCbrx9KLifYdd6MntQFyI9HMNI=;
 b=cHOJYPdHEnCfvDzRZDk/gwc3gZROGPck8khFDYgRadKDU1hNI89tj+TYG02oxQa9ujUd
 jPVLRlYr+NRyfIvpRx6tjs7hf5aQYOl8SANjCHJpV61oD6dUUdw4V64A2bxmpDKXocI3
 j924p1yqaBtNZSdCy7X8oIg3jIBs/Q1LVp9DVhz52ObMhdRL2MUWbGKcJ1lIP+zf4bzb
 ZVRcbZuhQrlDdZqpKO2O5JGyZH8Z0B+wFGBGt1C4nM1bxwX0WmDVcxjyEkaPtm08knCE
 YXjeusY6UIpyA5+egdRlKT4GkyB8dAXdYf8GlY8S0J8JjaxbAY3wnYknmRW8FZ8AlI/e 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sykb3r0e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:03:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387HF4fi037830;
        Thu, 7 Sep 2023 18:03:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugeas84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXrGa7reJhnPIhepNHuwuvIo0QxbTwnRDBf0KR1r7Pkqc9o5JUM4E7VF64kLLJV12w7LadQqtFdcf/FuUHAhNqL4mcG7KsSdxsDoLaBtidl3Myew+Is8LSAIb0rRON545APKJ02xKNQg6lZxo+I88IJa5feokNDonIfJBSSUWDR+tnOv6GFt67IRv6sgRcGH1DUwkphz3glJ4OcGHAVwUMOt/toYSIC5DpRCgXMeu0lJdX9XVRju0tBuMQCfqhWd/Tav/9cX4JXDOAudOFCMsJP/MBJvX58+ZBBW6nVpvAnqHRs/Sarym3PAAmbqkJIucXxE0VcmNRwQDuCUGRHxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksT3sTRfJ1IHx/fy0uCbrx9KLifYdd6MntQFyI9HMNI=;
 b=mNTFCiprMvGLwsou+b7rVVWArElB8DG1COAOR3ONfz782z33ML+YIV6Gw7ga2/2Qg45WntMX4m4sWpSNiEtux9Um34I4pyEqBVQsqwJ1rBwwQydDPHvzhqw8SPkckSyTC4pv2zFqGjwkrvmtdKOVBDnAZMrL7bTTwqtyS2S76877kJEjuTmweP/tDtya2qwZXoys+er6FYDbvjHbMI4WdKL9e2W4/PLvzAeRCB5fQAMQmDkVqtVRpiqCJiL883qi/vrPznXCYuwvJvh9OM3rH3cKotEntbskNaL4Dpm3Qj8KR9wzJqGb4SGBhnwOSWTJJCPfb7Nu1k9AqOu7bE9LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksT3sTRfJ1IHx/fy0uCbrx9KLifYdd6MntQFyI9HMNI=;
 b=XD9oE9Zj02wlJw0ek2N/26W+sgQjJLf7Rwt1c5ynXjFCRzVTOQ/shfKKIJmGsEEg7AN1uO7z/Anda8Iw5TB/jyQigpanWYq6357KeQkaeQObnXFLoEL+rBbNutFgOryRst7RWXMmQjEAnC79BmMgDqV97dMd9emJrYjTkLiAJII=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6457.namprd10.prod.outlook.com (2603:10b6:510:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 7 Sep
 2023 18:03:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 18:03:04 +0000
Date:   Thu, 7 Sep 2023 14:03:01 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] maple_tree: Update check_forking() and
 bench_forking()
Message-ID: <20230907180301.lms4ihtwfuwj7bkb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <202308312115.cad34fed-oliver.sang@intel.com>
 <0e9a87d9-410f-a906-e95c-976a141f24f0@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0e9a87d9-410f-a906-e95c-976a141f24f0@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0504.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e672daa-bbc8-4466-7169-08dbafccaed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SUpuDSp31Ku/Re4krg/4b8tWvBN2irk3LBM//3c9ZZCmG04TXW532NYLchOSQkfp2LK3gqwtf6SI6f5zjsFNQytg9hgYItLJwus+a8voyTKOMkaJijQDHxXJ2cIaI7ZePlhDrISQdlNji5Kn5ZXGK/oWqJccFIAN8+ePyqACEO6F5TMVH13+zLEHxTDh3YRsWJ6ZG8Sz6u0/9FuTrXav1Xf367wCPBwp1ahx6V3Wz60XULBn0WbnJxJCWSWaqVxQlQpji48l5A+DMNMmufVYhiboFyhDY0RzVDhKbNH25eCgRU/QzsDJ+m+kgVP5HpMm27XeuOzuS45umM4IRyA9ozTzkfGIP5mWPTeTs91vyyEDY5hLuNsMRPK9cWuUSuxZcQuKnel0tVMweVzO1vk+S9okp+tBoXAazWvntCxHN1lWpdFCKcVp836YNbJS7jRbYeajZRavFEYk7ypa1AacAFQLSM1BQAb3fyAVTyA00DuR2AWQh5KVOfXQDBJF82ea40y9vrss/50DtcZC/L2hDk77FtdEPgGTb00il1scBEJAnWLaLsxbmGRspvpgypMiojdz1/c3bYp9CVTCWlaqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(6666004)(6506007)(9686003)(6486002)(26005)(6512007)(86362001)(1076003)(38100700002)(5660300002)(7416002)(8936002)(15650500001)(6916009)(316002)(4326008)(66476007)(41300700001)(2906002)(8676002)(66946007)(66556008)(33716001)(478600001)(83380400001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2kxMC9BWE5PWmVGRnMxN3d0bFZDQWhUN1U1K1R3cUFwSDBGRi9NdGRjSDRK?=
 =?utf-8?B?Mkk4NFg3NHNGbzR5Z3VabjgwaENiajNLOFpzaXYxV1pvT1laUWdxNUFTQkg0?=
 =?utf-8?B?TjN4ZFB4WGN6Zm9PdXNmYVk5cHluNkxlL294TkZ0SXpKaHZ3cU9WTTVjcDBi?=
 =?utf-8?B?YmlVYTBUU0dtU296d2VMckVrT2sxT1d5RWNtdU1VeGNHZnpwZkJCZzZVdGMz?=
 =?utf-8?B?VUoxNGprcWFEY0RKSXdqSzh5S1ExWkN0WDBIODNFZGpldUtveUtadnZKVm4y?=
 =?utf-8?B?dUdyUU9GdXBUczBuNCs2ZGxKUVZ3NlRKbEJjL3ZNU0hxMFpGT08vby9ybDVq?=
 =?utf-8?B?TEpFUlhJSTJ0WHh4ZGRJcDlOT2dyRlVTMjl6d0Q1dm1pZWsyenlRWitvWkZM?=
 =?utf-8?B?RVRJa2QxOGU4UlMyK1NKYlpQQmZKclBOcE1QRE5PS2Y0MlNxZVBTOHljWXN4?=
 =?utf-8?B?bEZMd1I0Wnpxcm8wWkFYUGpTMWpWUU1rYldPbHVRemNLR0FXRVRLQUFrMFlZ?=
 =?utf-8?B?Z1NCdFZkZVpybWZHak9KVnZhcndoeVpBemVIVzhVVHpLM2NWS1lVVkpqSW9E?=
 =?utf-8?B?dmVJY2ZrTDJQZkVyM281M0s0cC9INktsOCtwcXZKTmk2VHdiZ1NUQXFkUFZC?=
 =?utf-8?B?dmNaTFVCTldOOTFWRW9sT3dsWjFocTZvcHNYYXJrNWRyTkFML25oRTByVW9w?=
 =?utf-8?B?amdaR1NVSmZ1QXVlU1BoZUpIdXdraVJCSXk0QzJTT3pjdWY5SGRQMnQ1Uy9U?=
 =?utf-8?B?MkxvTDJSWTNjcmk3RC9NakRqVFF2WnRrbE43YlZRZ0tMaHprSTllanU1UE1y?=
 =?utf-8?B?OWs1akVPbmFTMEFqaGxIVEFiUDFOaHZEZWlzcThjcGlFWWhXUHZBdUgzdlRu?=
 =?utf-8?B?ejNURkhhZzhZdGgzUWFST2d2dkVZUWFzTjlvR2IzVlUxYklXdktpZzVXTGYw?=
 =?utf-8?B?OEwrMkNFRlpwVG5nQUljUmswODFVQVNyWGtLTlRGN21vQXR5ak9wdC8rMGRs?=
 =?utf-8?B?STVmdzZ1RWlLZklSNG0yWmI3bjlsVml3OHk4NGpNQWZuWEJXbndJS2tWbml2?=
 =?utf-8?B?WWZmcGs5eUVxVzNqSHd4VHpwd2JKK0U4NUNyYisrV2RHRmlmMzFXTDdNYnpV?=
 =?utf-8?B?TUVFdjhwckhoU1R0Ull6ZkhnaGM3RW4zc05DTjBHM2FCVEptOW9BdVhDdW5q?=
 =?utf-8?B?dUlBcVVwSWJJc0xVMGRUMnU2SWxCbWx6UEg2NC8rUmd2UndiR1NMKzNWN0dP?=
 =?utf-8?B?MUFXTEpnMWNSNWVJcFVGcHFtTDkxUTFuYk9qZTIrMVZrQjdDRXJZM0NNVU5H?=
 =?utf-8?B?dGJ5NDhETlFxNUZpaE1Ca0VMcGxxaHozTTRjWWFWMno3Q01LZ2xtUFVnT2NY?=
 =?utf-8?B?ZXo4UmJuYXZQdllFQWVnQlh3VUZyYXp6WEVvcDdwRzRhU25wN3M3Zzd6aTJj?=
 =?utf-8?B?amVSYzZWOUVqbkNxcFRKOXduUCtpOEpZWWVFTTU3MXBmRmplMVQ3V1gvZ1Rs?=
 =?utf-8?B?TUpWSmVOUklhU2tOelpkaWVhb2pqUTFoMHR2OWxNMUFLUDByTmYyZ0dZRm1s?=
 =?utf-8?B?QVZFQllSN3dzS01XbC95aUVTZmZ0WTRlVER4ajBRMWNNZUpwTUtBSDdwR3Zt?=
 =?utf-8?B?bTN2SFFGY2ZjOVJseDgzdXovb3I4UG0rMCtmNGwvUzBud1o3aWtYVUZ6WTlW?=
 =?utf-8?B?U1F0WDI2Y1JjUzl2V0hmazBMV1JzdFlvR2FIbXd1cVRDM3laM3JOSTIvR0hJ?=
 =?utf-8?B?bWtHdWc4b3lNbkVJMTRzTWhXNkxTMnJ6VXpJSFhPQ1Mydm5FcmhLMEdDc04x?=
 =?utf-8?B?eTBudnBoRkJBTEQ4ZHNJWXZOL0JqVDJJMGJQVm92ekt2a2RZeFFrZWY2UkhK?=
 =?utf-8?B?cE5CdVBJKzMyQm9VZEdtdWNNL1MvWGNmTWNteGVQZm8wSGZ0MElZTnd3Y0FG?=
 =?utf-8?B?SEIrc1dYK1M0anVlZmFwZXdVU1lpTWlTMEpsUTFmVVU3bUo2ZHh6Y2RHK3FT?=
 =?utf-8?B?WE8xVUY4Qm92dktGVm54KzNGMzRiSzI2QWhoOWZYb1psWDNPNmZIaHpOdmox?=
 =?utf-8?B?cmFXMVV0djh0SHM5dVM0bld5WjZDTzQxY00zbVVTUjEyMUJxdU9nSFlFTGtI?=
 =?utf-8?B?YzJsbmVEdVIvNElRSEhWdEdkckdYdysxdXVXdGxFRmMwSU1ibmRpMDdhakJL?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VXQzV1JocHp2K0hUL3NBbEdYZS91b09YK3A1K1NPbE14eHRZRGFlYjFXNVhB?=
 =?utf-8?B?NzZLenFlSnRQanVYcTFlOThQMlFmQnZUTm5EejZReWczYnZSSEVDenI2TGw3?=
 =?utf-8?B?RTloaFpWVW5iNjF4ZWFlQUJZdjQ1N2xLNko5MzZraWh2Z2NRRnpZZ0JPb2U1?=
 =?utf-8?B?Z1BZeVJsSncrM2VoOWsvOUc5dVNZdXVuSjV6WndHeUdNSEQyYjI0YTJUSDRl?=
 =?utf-8?B?UkJZK09sNnpPMFk3eWRvMXh0d3NkaXRrdzQycnBXNEtpSVJGM1YwTWFObVVB?=
 =?utf-8?B?T0RmWWFxWi8yaFNsUHVvV1orRS91dmZUWEV1OGhTaEpSTGxuUUV6T1BGU1gy?=
 =?utf-8?B?MUpKRzdaT0pJRExJekFvbDc2dmRicGJrK0tDRnl0NUhIQnBaVlVZd2RsQmFj?=
 =?utf-8?B?Y0lkQzE3YWJCUE9vZndqYitjRGtORXpXWVQwV3pMcHBVLyt0VFdjTWNReTRy?=
 =?utf-8?B?OVlIVWQzUTBnc0RsVlhVOTkvR3dsa0hnTzNvSXRYOS9BTWdNem5Uc1lIdTVt?=
 =?utf-8?B?NVdtWjJ3MTNDVVlqa1JldTFsNmJ2SjlTMU43LzVVT1dBQ3VvTXhVNXFNbkNn?=
 =?utf-8?B?eUYzOVdYbm5KZk5FZUUxVG9JVGtyUWo4cUR4ZnZFZy83VU8xL09qemtTWG5D?=
 =?utf-8?B?QzczbWFGMlFUNFRZL1dyenlZNFg0UUN0YVY2SUtlZ1p1NkhnSDI3enIzNlBW?=
 =?utf-8?B?cDNGbDhJdzBubER4NE1ZT3lHeWhMRlNtTERDb1JKaUhPTXY1ekQ0aEFudi9z?=
 =?utf-8?B?K0h2a3pYUGJiN3EyT29XYnl5eTQ4YnA1MTZQT3hRTXVzME5RM0g1emhNT2Rm?=
 =?utf-8?B?RUsvUXd6eS9FbVl2ZzFpdUtwdmJteTB6L0xaSVlpd2pMRVB4a3ZYOVM1RmJy?=
 =?utf-8?B?VGQwckQ5TzZXdGtKTWpOMjZ5Q2xlb0tIWTU4Ui9lR2JoZkgyS011NzVIWDY2?=
 =?utf-8?B?cGRETzhNbUsrWTJOTTIvRVl1ZG9FQjYzQ2UraFJoUmExYnlYcERVMkQ0SGtB?=
 =?utf-8?B?VlUxL1VHOUtxQnp5aTRZbnVsZDNCSk1HUURQOXlpUFJ2WEdWM0d1NndNdFZl?=
 =?utf-8?B?bVY0SDhOMWZ6N3Q0Q0psMkxHdzkyZXdBUW5yRlJjOGN3M2Q3a0xoemorQWpl?=
 =?utf-8?B?OGJqL1ZEN1dzRUI5SGhMY1NpZTdUTENnbVI3UzZQMnZvSk1hbzQ1cENoMmFD?=
 =?utf-8?B?YjZXa0JpVWhJVHdZUnNEc1Zoc0FpQU55RndzMXBCdGhnV3pyeFN1eEdkUitX?=
 =?utf-8?B?WXNlNWYzY1VaVFYvaDltTkJtYlRFeGYxejE5WkRISFNsMFNvZm5ROWVMdzJl?=
 =?utf-8?B?WVB5cTMzaHEzSnZkZytGbTJFd05ObHA1UmtjNDVLQ3IrbG45MkNpenlwRC93?=
 =?utf-8?B?aWlyOGJ3YzZQMUFnZTlzT3d5SFB6T1kwNXJCU2YvdE13QzVoSVN0Q2JYMHFX?=
 =?utf-8?B?RkkxRGdLT1RLNFZpV1Erak9IV0Y4cU53TGlnWUhnWnh6ZndGdlRIQ0RzeVlW?=
 =?utf-8?B?RkMyWlFhaFAxZGtXY1F1R1FRRDVGZmNUTHVFakt4TXNjSHNqVmpZTHJoaFdt?=
 =?utf-8?Q?aLsrT40S35qDQZ+ieKy2TXB9g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e672daa-bbc8-4466-7169-08dbafccaed1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:03:04.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AiK1JeFADAevzkLg4WcU1kNnXeLI5ay2ipJuaAIiMs4igPegtk9XwxDJv/TKPgu/5AhrtfH++0DeHGAamJmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070160
X-Proofpoint-GUID: yulakLPfrjPaBI31U84TpEVRhGHV0uCF
X-Proofpoint-ORIG-GUID: yulakLPfrjPaBI31U84TpEVRhGHV0uCF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230901 06:58]:
>=20
>=20
> =E5=9C=A8 2023/8/31 21:40, kernel test robot =E5=86=99=E9=81=93:
> >=20
> >=20
> > Hello,
> >=20
> > kernel test robot noticed "WARNING:possible_recursive_locking_detected"=
 on:
> >=20
> > commit: 2730245bd6b13a94a67e84c10832a9f52fad0aa5 ("[PATCH v2 5/6] maple=
_tree: Update check_forking() and bench_forking()")
> > url: https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/maple_tr=
ee-Add-two-helpers/20230830-205847
> > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-every=
thing
> > patch link: https://lore.kernel.org/all/20230830125654.21257-6-zhangpen=
g.00@bytedance.com/
> > patch subject: [PATCH v2 5/6] maple_tree: Update check_forking() and be=
nch_forking()
> >=20
> > in testcase: boot
> >=20
> > compiler: clang-16
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >=20
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >=20
> >=20
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202308312115.cad34fed-oliver.s=
ang@intel.com
> >=20
> >=20
> > [   25.146957][    T1] WARNING: possible recursive locking detected
> > [   25.147110][    T1] 6.5.0-rc4-00632-g2730245bd6b1 #1 Tainted: G     =
           TN
> > [   25.147110][    T1] --------------------------------------------
> > [   25.147110][    T1] swapper/1 is trying to acquire lock:
> > [ 25.147110][ T1] ffffffff86485058 (&mt->ma_lock){+.+.}-{2:2}, at: chec=
k_forking (include/linux/spinlock.h:? lib/test_maple_tree.c:1854)
> > [   25.147110][    T1]
> > [   25.147110][    T1] but task is already holding lock:
> > [ 25.147110][ T1] ffff888110847a30 (&mt->ma_lock){+.+.}-{2:2}, at: chec=
k_forking (include/linux/spinlock.h:351 lib/test_maple_tree.c:1854)
> Thanks for the test. I checked that these are two different locks, why
> is this warning reported? Did I miss something?

I don't think you can nest spinlocks like this.  In my previous test I
avoided nesting, but in your case we cannot avoid having both locks at
the same time.

You can get around this by using an rwsemaphore, set the two trees as
external and use down_write_nested(&lock2, SINGLE_DEPTH_NESTING) like
the real fork.  Basically, switch the locking to exactly what fork does.

> > [   25.147110][    T1]
> > [   25.147110][    T1] other info that might help us debug this:
> > [   25.147110][    T1]  Possible unsafe locking scenario:
> > [   25.147110][    T1]
> > [   25.147110][    T1]        CPU0
> > [   25.147110][    T1]        ----
> > [   25.147110][    T1]   lock(&mt->ma_lock);
> > [   25.147110][    T1]
> > [   25.147110][    T1]  *** DEADLOCK ***
> > [   25.147110][    T1]
> > [   25.147110][    T1]  May be due to missing lock nesting notation
> > [   25.147110][    T1]
> > [   25.147110][    T1] 1 lock held by swapper/1:
> > [ 25.147110][ T1] #0: ffff888110847a30 (&mt->ma_lock){+.+.}-{2:2}, at: =
check_forking (include/linux/spinlock.h:351 lib/test_maple_tree.c:1854)
> > [   25.147110][    T1]
> > [   25.147110][    T1] stack backtrace:
> > [   25.147110][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G          =
      TN 6.5.0-rc4-00632-g2730245bd6b1 #1
> > [   25.147110][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [   25.147110][    T1] Call Trace:
> > [   25.147110][    T1]  <TASK>
> > [ 25.147110][ T1] dump_stack_lvl (lib/dump_stack.c:? lib/dump_stack.c:1=
06)
> > [ 25.147110][ T1] validate_chain (kernel/locking/lockdep.c:?)
> > [ 25.147110][ T1] ? look_up_lock_class (kernel/locking/lockdep.c:926)
> > [ 25.147110][ T1] ? mark_lock (arch/x86/include/asm/bitops.h:228 arch/x=
86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-ato=
mic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:4655)
> > [ 25.147110][ T1] __lock_acquire (kernel/locking/lockdep.c:?)
> > [ 25.147110][ T1] lock_acquire (kernel/locking/lockdep.c:5753)
> > [ 25.147110][ T1] ? check_forking (include/linux/spinlock.h:? lib/test_=
maple_tree.c:1854)
> > [ 25.147110][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:133 =
kernel/locking/spinlock.c:154)
> > [ 25.147110][ T1] ? check_forking (include/linux/spinlock.h:? lib/test_=
maple_tree.c:1854)
> > [ 25.147110][ T1] check_forking (include/linux/spinlock.h:? lib/test_ma=
ple_tree.c:1854)
> > [ 25.147110][ T1] maple_tree_seed (lib/test_maple_tree.c:3583)
> > [ 25.147110][ T1] do_one_initcall (init/main.c:1232)
> > [ 25.147110][ T1] ? __cfi_maple_tree_seed (lib/test_maple_tree.c:3508)
> > [ 25.147110][ T1] do_initcall_level (init/main.c:1293)
> > [ 25.147110][ T1] do_initcalls (init/main.c:1307)
> > [ 25.147110][ T1] kernel_init_freeable (init/main.c:1550)
> > [ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429)
> > [ 25.147110][ T1] kernel_init (init/main.c:1439)
> > [ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429)
> > [ 25.147110][ T1] ret_from_fork (arch/x86/kernel/process.c:151)
> > [ 25.147110][ T1] ? __cfi_kernel_init (init/main.c:1429)
> > [ 25.147110][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> > [   25.147110][    T1]  </TASK>
> > [   28.697241][   T32] clocksource_wdtest: --- Verify jiffies-like unce=
rtainty margin.
> > [   28.698316][   T32] clocksource: wdtest-jiffies: mask: 0xffffffff ma=
x_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> > [   29.714980][   T32] clocksource_wdtest: --- Verify tsc-like uncertai=
nty margin.
> > [   29.716387][   T32] clocksource: wdtest-ktime: mask: 0xfffffffffffff=
fff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> > [   29.721896][   T32] clocksource_wdtest: --- tsc-like times: 16934781=
38832947444 - 1693478138832945950 =3D 1494.
> > [   29.723570][   T32] clocksource_wdtest: --- Watchdog with 0x error i=
njection, 2 retries.
> > [   31.898906][   T32] clocksource_wdtest: --- Watchdog with 1x error i=
njection, 2 retries.
> > [   34.043415][   T32] clocksource_wdtest: --- Watchdog with 2x error i=
njection, 2 retries, expect message.
> > [   34.512462][    C0] clocksource: timekeeping watchdog on CPU0: kvm-c=
lock retried 2 times before success
> > [   36.169157][   T32] clocksource_wdtest: --- Watchdog with 3x error i=
njection, 2 retries, expect clock skew.
> > [   36.513464][    C0] clocksource: timekeeping watchdog on CPU0: wd-wd=
test-ktime-wd excessive read-back delay of 1000880ns vs. limit of 125000ns,=
 wd-wd read-back delay only 46ns, attempt 3, marking wdtest-ktime unstable
> > [   36.516829][    C0] clocksource_wdtest: --- Marking wdtest-ktime uns=
table due to clocksource watchdog.
> > [   38.412889][   T32] clocksource: wdtest-ktime: mask: 0xfffffffffffff=
fff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> > [   38.421249][   T32] clocksource_wdtest: --- Watchdog clock-value-fuz=
z error injection, expect clock skew and per-CPU mismatches.
> > [   38.990462][    C0] clocksource: timekeeping watchdog on CPU0: Marki=
ng clocksource 'wdtest-ktime' as unstable because the skew is too large:
> > [   38.992698][    C0] clocksource:                       'kvm-clock' w=
d_nsec: 479996388 wd_now: 9454aecf2 wd_last: 928aec30e mask: ffffffffffffff=
ff
> > [   38.994924][    C0] clocksource:                       'wdtest-ktime=
' cs_nsec: 679996638 cs_now: 17807167426ff864 cs_last: 1780716719e80b86 mas=
k: ffffffffffffffff
> > [   38.997374][    C0] clocksource:                       Clocksource '=
wdtest-ktime' skewed 200000250 ns (200 ms) over watchdog 'kvm-clock' interv=
al of 479996388 ns (479 ms)
> > [   38.999919][    C0] clocksource:                       'kvm-clock' (=
not 'wdtest-ktime') is current clocksource.
> > [   39.001696][    C0] clocksource_wdtest: --- Marking wdtest-ktime uns=
table due to clocksource watchdog.
> > [   40.441815][   T32] clocksource: Not enough CPUs to check clocksourc=
e 'wdtest-ktime'.
> > [   40.443303][   T32] clocksource_wdtest: --- Done with test.
> > [  293.673815][    T1] swapper invoked oom-killer: gfp_mask=3D0xcc0(GFP=
_KERNEL), order=3D0, oom_score_adj=3D0
> > [  293.675628][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G          =
      TN 6.5.0-rc4-00632-g2730245bd6b1 #1
> > [  293.677082][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  293.677082][    T1] Call Trace:
> > [  293.677082][    T1]  <TASK>
> > [ 293.677082][ T1] dump_stack_lvl (lib/dump_stack.c:107)
> > [ 293.677082][ T1] dump_header (mm/oom_kill.c:?)
> > [ 293.677082][ T1] out_of_memory (mm/oom_kill.c:1159)
> > [ 293.677082][ T1] __alloc_pages_slowpath (mm/page_alloc.c:3372 mm/page=
_alloc.c:4132)
> > [ 293.677082][ T1] __alloc_pages (mm/page_alloc.c:4469)
> > [ 293.677082][ T1] alloc_slab_page (mm/slub.c:1866)
> > [ 293.677082][ T1] new_slab (mm/slub.c:2017 mm/slub.c:2062)
> > [ 293.677082][ T1] ? mas_alloc_nodes (lib/maple_tree.c:1282)
> > [ 293.677082][ T1] ___slab_alloc (arch/x86/include/asm/preempt.h:80 mm/=
slub.c:3216)
> > [ 293.677082][ T1] ? mas_alloc_nodes (lib/maple_tree.c:1282)
> > [ 293.677082][ T1] kmem_cache_alloc_bulk (mm/slub.c:? mm/slub.c:4041)
> > [ 293.677082][ T1] mas_alloc_nodes (lib/maple_tree.c:1282)
> > [ 293.677082][ T1] mas_nomem (lib/maple_tree.c:?)
> > [ 293.677082][ T1] mtree_store_range (lib/maple_tree.c:6191)
> > [ 293.677082][ T1] check_dup_gaps (lib/test_maple_tree.c:2623)
> > [ 293.677082][ T1] check_dup (lib/test_maple_tree.c:2707)
> > [ 293.677082][ T1] maple_tree_seed (lib/test_maple_tree.c:3766)
> > [ 293.677082][ T1] do_one_initcall (init/main.c:1232)
> > [ 293.677082][ T1] ? __cfi_maple_tree_seed (lib/test_maple_tree.c:3508)
> > [ 293.677082][ T1] do_initcall_level (init/main.c:1293)
> > [ 293.677082][ T1] do_initcalls (init/main.c:1307)
> > [ 293.677082][ T1] kernel_init_freeable (init/main.c:1550)
> > [ 293.677082][ T1] ? __cfi_kernel_init (init/main.c:1429)
> >=20
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20230831/202308312115.cad34fed-=
oliver.sang@intel.com
> >=20
> >=20
> >=20
>=20
