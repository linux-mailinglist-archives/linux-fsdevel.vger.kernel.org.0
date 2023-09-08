Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726A8798A76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbjIHQIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbjIHQIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:08:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982EC1BF5;
        Fri,  8 Sep 2023 09:08:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388G4kcn021597;
        Fri, 8 Sep 2023 16:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=HVMN5ImzZHgNeJlK2NP+rQZq6JJsk0Cbg+2zwc/Tihg=;
 b=cwX7RsXcNq0O2GtTv/dXLP9D5uKXZEh+BSJRwU+AmwNeaoCD7TmTnlDr4z8vfBODplxH
 7eL5U77eEXGyMDXYZFAAC1/PHU5ei9es9aI2P1hyyCKy9cyXF2W80eLMcshEnE4x0rBL
 TxxRWndP/Vvypnh9Ma/gYasZejnWpKUMEjplBbf07FFHEiolnBdTp/JB12e1ughn5OrH
 I5IaX7ajkLFnb+YDpTb/y2wNlYy8CD85X9v+Q87I6nLtjfLgddGVHsAUd/+UWleMDzKR
 USKremu4FLruG/QXNHug311pjIdTYSFsvYpUylbVavQy5nfZ+nOBYXL8lwmAba7C3GLl uA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t063e04vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:07:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388EbRqN016697;
        Fri, 8 Sep 2023 16:07:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugfkvk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOhZ5YtLu6QXJaiZjr/1tRM7TjgLWyecGdPIPAXJ8Hf7vXWKoaBQWqY0u3SZ5lt/RdrrrU1Z3+YBUNWdQ6TSjXGMGdtmv/Lwg2cTgGd7kdKXUfQIZBhK2vy4Z4UElQVB4M+ODRK8ERJEJUhMK4dErFMD6BtnE1KAGr6jeRhv0hcn7D/wuAyb/ZJ5Ozro+NkAR1XX4FL1vzqJjaW2LKxTfteHYmNRRsWWydWQ+mqlKHtFOSwHEh7CXLvXIpx4Xf5vMtRnek72bre1/hTGhtl0mNhd095y70ThAh4pYDTZBYOAe87ASMYOHpA6Zqwt4wBV84mt564MtFDnp4ZNmFiS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVMN5ImzZHgNeJlK2NP+rQZq6JJsk0Cbg+2zwc/Tihg=;
 b=X1q3xPh+bHIs2VAZBQjGyrgHvet1qjK+MjyeMDmIJiAI+EG7SALgEO/2NrvPdBUTkUlGjppKKbnexqb2+1uA3qEkVcHyaSS3fs7WKITMZvVx173m3EBI71HF80MwTEX9i0BBP6N82b6bcXyg2+BMegcZLCYsjuo9RcDTbWDNrJ3J57BVihWHsN+Jq16M6OdHgWeobyPKk1c7ANvSryiYQOnWpwrqJml7PUPVwS+OMbIjs+Z/CFe/x+DJhGEyqssaqk6aV8eP34GwVCX+7WNxKpmmn2Hdk8icfvhNNJqVyf0tJWZr625s0T47BmDqfHYJrlOaeC7zwm5eLGSSDKJN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVMN5ImzZHgNeJlK2NP+rQZq6JJsk0Cbg+2zwc/Tihg=;
 b=hWYHMeHS23ftTbMus5Sk2BJJWJ09WVI/ymXun7pFKfLd0jukhR8xA8f6GPtVwBZ5ZKW5ZkcDjB5wTpIsP9AUBnTKvqnMpEaZC4TbGDHpfy5d96lTrwYxQ+8bEstqK35hq+0Si+x342miVj9AKrhXue/LGIj4Yhiz/nJhiKYPD1M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:07:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 16:07:24 +0000
Date:   Fri, 8 Sep 2023 12:07:20 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20230908160720.ayas5ptunklcmd6e@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-7-zhangpeng.00@bytedance.com>
 <20230907201414.dagnqxfnu7f7qzxd@revolver>
 <ab29ca4d-a7dc-9115-930d-86c6425e2b9c@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab29ca4d-a7dc-9115-930d-86c6425e2b9c@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4234e3-0a83-4178-cadd-08dbb085b05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajBDOPW3trTtkKb3I2KT0tuBLaJcFHRik/Qd7fC3ytWQggc70YYjm28CIqI5qtLDZnpZ8K21xXEomArftRL9DWH8AVZRmP98nK2c9llmWoWEGP3Aj5vxbCDvXpB+rc5R4mm1thXvPdF/FsiipGjqSyfW4hfp2D0R5YtQsf2PuR5l4Tju5tEBtoVpIqPr9Qpdug7bqHaOZ22dNSg0fhcded5sny3h4A4nl3t6YQTlYYiYz5q4KhAFrxjfGnNaRNFtOfIFDrv/S0izrZ6T9+ZZvutGW8/Xz99x9TydQRANDftyLdiuApQ+Dnwco6aw5LKsdNExwvJTL0cfQFzA7yvdjt8Z+do08KgD4pLEKFEqJ21x4zYRGCKfpAWsviltLej88DYPWbdMUqrJV6CreZHuZgJuyrKwWVVDIGvxDWw+/aMinYAgNuPB8uMfkJaOA6hcoAo/ZTT0fSlJcJlz2FdI3nsk0f2wdGDe1G1qP4GECIG0GxV899WlkAVP28p8w+fiZp5jDlJYOlhXf5cLFdzZhgr16/p5VBNAXxyF/tKnSpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(396003)(39860400002)(366004)(186009)(1800799009)(451199024)(9686003)(6486002)(6666004)(6506007)(6512007)(966005)(83380400001)(478600001)(26005)(1076003)(41300700001)(2906002)(4326008)(7416002)(33716001)(6916009)(66556008)(66476007)(316002)(66946007)(5660300002)(8676002)(8936002)(86362001)(40140700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmgyQ1pGdjNKMVowa3JOaW1IYjNFZ0NWZkQwY29EaVJwTlI1S2I5MktlbW1h?=
 =?utf-8?B?NU1idURCTFp4OWVvVG8yY0djNU5FZ2FqazlUT2Z1NXl3aHZNemt5cVYwZGRH?=
 =?utf-8?B?U1BESWtZNllaZFdpNVhkKytHVlc5cEhabC85SEFkSXNGYXVlMlV6cDNvQmxi?=
 =?utf-8?B?QmNtMnN1Y3FXSmhPbUd3NTEwZXN3UnM3bDZtYVFYN3hZRnUyMWZkNjVxdjI4?=
 =?utf-8?B?YUlvcUgrVzA3ZS9HYnVnb215bzhZR1ZKb0pLRW1NNHUxdEhXZHl1M2NjcmVP?=
 =?utf-8?B?bldkNWE3c0l1U3g5VDBTMXhOazR0ZjJlZU9pV1kzMXNsOEp2bFlOVkhqdTR6?=
 =?utf-8?B?TGszWmttaUNxZXdGMmxrUHFSdWlZTnhGd1d0Y0haTVp1aHhSc0gwZVVCVm9F?=
 =?utf-8?B?cVhsZDIrTk9ZNGZDNXR4dWZIdisvOGl1S0Zoa1cycTlYSjlPb3lOaUVPQk9p?=
 =?utf-8?B?dWVMS1NFTjJXQnhrTStLKy9RdERBdkptb29hYi9iVlFwWVdYc0lUaXJGSHpk?=
 =?utf-8?B?c3NJVEE0TmFaOFFhWW11TFVlQTgrK2libkQ2VWhCdjRaRCtXeENKWURVbVQ5?=
 =?utf-8?B?MVVkaVRXSEtZOEN6cDNiUzRLUDQzMDVJWFFZaktxaHBMM2ROWWdPemdnL25o?=
 =?utf-8?B?cGZqMDNZNnFsY1BEcmthRC9Fc2ZIdGY4RmVuUGZUakVhSnJYUVdudlYzb3pm?=
 =?utf-8?B?azVpNVR4YnY1UTZRa2xFdFcwSk9lMHBHSVhzMmhiN3FGdThBaU1vR0NZbEJt?=
 =?utf-8?B?alRJbFlndW5VOENPSXkzZ3Rvb2RRN1FVeWRvMlNwK045aFhmcW50T3h1NXBO?=
 =?utf-8?B?NnVmWGNOd1R3akF1WmZHVUtvMldScWRMa2NiMTk3NjdDQjYzNGdqWGVWQzd5?=
 =?utf-8?B?VWhCNjFXbjFQYVhaR2oxMjBMc21IZ1g3OE0vT1crT3U1akdIOXl4cHg3eDFH?=
 =?utf-8?B?bUFjUDhLdTRsc3hkeGZJM2ZTY0g5MG1pK0kzQXM2WEJ6RXFSS0NZU0MvQlVw?=
 =?utf-8?B?dEJXbk1EVmlhMEJ5YXdzRGl4M3AzRXlLVWhPbUdoZmRaNlpoNXFXWld2YmVv?=
 =?utf-8?B?bDR3NnNWSHVoNlBrNzgwSzJLUkF6dEVCR1VOd2loaE9SdWxobGdESyttVzdC?=
 =?utf-8?B?UGNsQk9ZcG93ajg3bjRTMThneWtwTFB4NWpLV1h1VStyZzVBRzAwejhsbGo0?=
 =?utf-8?B?T1F3NHFrZDRWc2Z1anMrWkRNSFpqQjNhNGw4TDNDcXNEVE1qOTJrNGxDRlU2?=
 =?utf-8?B?aHM3UjA0Qi9abHpFUDBISFd6Wk5CM2gvbTBMSThCKzF3Yk1rNlFqblZwdk5I?=
 =?utf-8?B?SWRhYnlHRWE1QlAzeGZwNUE5QmtJelU2VG15Z3JRQXZjYnpkZllqUzVXVEto?=
 =?utf-8?B?VFgvcEVWL2pmMkxpdEgwMncxYXdtU2s5Z0xjU0M5V3R5cWlIdWpnSjNpNEdO?=
 =?utf-8?B?VUc1b2tvTWNXSDhjRlZBVDIyb25FbWIyUitaSW5rY1J5NzRoa0d0ckd1bjIz?=
 =?utf-8?B?SlRvb004d3dOSHNKbkhqVFB1NVpVN3M0QzdBVTN6RTl1b0NhVTJjZzFwZFFS?=
 =?utf-8?B?YVROd2tWZFF0aGd6VEVpZjBqbEdCVWJFeC9zbGV6Z3dDdlcxVklCc1hoK2JH?=
 =?utf-8?B?ejNFTWZYVFpYUXBpMTJ4TU5hWnpWOHR5R2x0T1U4bytnTTd0OVhtbzM3ZjVj?=
 =?utf-8?B?S0h2R3hFSmRtSVBWQTNtOVV4MEFvOXd4K1RQanlMY3lMYzl0ZERBdmlzNkQ2?=
 =?utf-8?B?QUdXNUtpSndOTWpkdVpLUS9nRzlYUEJTanVLTjZ0MG0vU1k1UFcyOHBFTTcr?=
 =?utf-8?B?TzJBVXZDQ25MaEp1TFpRWldXU1pBNk5IYlhwWm5CT3lLZXpSejYyem50NW45?=
 =?utf-8?B?ZHdYUWphc2pkaXV3RU9sRDdGMVhya3hhOFF3L21MUmtkYm5rMHlQa0UyQ1kw?=
 =?utf-8?B?Vm81MWJja1p5THdObzlQZGVCZzZzcjRoUzllWnRadXZUWnFxSGFCaTRJS2U2?=
 =?utf-8?B?c29nbXBkNFJqY0ZvTURESHRNcE1lRzA2ZFlJK0VwOG5NRjVjaTlnZHpKNnEz?=
 =?utf-8?B?a2haUnFqK3I3VlY3Z3I5WlNsaCs4UHY4ckdYelZQNnVJZzVtaVpFM1NxWFlr?=
 =?utf-8?B?RVd5YTh1SHZxL1FVdkR0SjJPb2JyTXZSYlpZY1BJczg0VFNrSHlNbHZkdld6?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bmVzeVZtRlo2djlrYW00enRTT0FCSkRQY3cxTE91K0JWUGRQdU00THpnRk5Y?=
 =?utf-8?B?dDdBNnBQOVZLRjJtdXFNeFVQZGNrR2orQVZqdnd4d3FTaDRoY0haSisrY0R0?=
 =?utf-8?B?L0NseW53aGV5aG40N1lJY0h3UkVsOHVzNTdBWlpEY2JpR2g2Z0NMTXJIT1Fi?=
 =?utf-8?B?ai9lS2ZpR3Nxb0tHa1RMb0RQZVJhSmYvSTljZk5QM0ZLL0pQMHVKN0VESW9p?=
 =?utf-8?B?Z2o4VmJrV0gzMm1sczZrTU9NMVlrVmllLzhtcVdqU1pZV1R1TE9ERGswOWRU?=
 =?utf-8?B?MjRYT3dTbU9QY1FhV01MTE9nTWNmOWNqUmFDaUl0eGx0NVFhbEVNL1gzZEJw?=
 =?utf-8?B?SGczWCs4SjFPUTBFendyUC9OMUlxV09NNDBDdUtYT3MzRFM3MXVhbkJoTTF3?=
 =?utf-8?B?MmxhZUhVZTdxSEpOUlFPZks5STEvRXBiNitxWHZPU3RZWUhiTElQQ3VIMXFC?=
 =?utf-8?B?cjdoSFJ4ZTdKSHJHZjE5WXVTVjBOaTZVRVNJRmZPV2dXTkNqWGRHNHhHQkgz?=
 =?utf-8?B?Y0xRcWROb1ZMdGxqWDFDcEZMa1ZkYkdSSXFUaUgyY2I0NzZGVkYxNDM3OGJB?=
 =?utf-8?B?SnlyZ1dlUVRwMnM4bGJwTGhjU2MyeHFEOEVSSUZsc1dqdXFQNDhxNVVZSzUv?=
 =?utf-8?B?aldGc3NES0YxbE5CUWdyaExldERha2loeVRsR0tCV0w3WFVrNnJpU0s4S2Zk?=
 =?utf-8?B?TmIraGZVRVE3YkZpZVdBVE9tdEVxWkgvNFpuWXNBU1AyazZMTU0xZkx0VTZy?=
 =?utf-8?B?L0RiZDlzVlluSWwvTVIvUjF4M3hXYkNGSkY2dDJlQTIwb2IwSFo5U3FEckFZ?=
 =?utf-8?B?c3d2Qzg0SXcxclRkWmJaNzAwQmJUL1lmTDEyaVBmaXRTeGRKNzJlTjdyb1Nn?=
 =?utf-8?B?dGJnTmxxQldHSEw3aVlnSmpqNkZ2NDFFd0RBNW9NQjBMTDJmWEpCd3dYQkFH?=
 =?utf-8?B?Zk41ZXNsdERRY0krL2pXMlExV2xjU1A2LzA3cTJkRzN1ek8wbG4xOHJkeWRJ?=
 =?utf-8?B?WnBnaGpqOStOY0xqeWtYbklLSlhYM3Axa3hMOTZXRkJZd3U2VStTdUxRdzRr?=
 =?utf-8?B?Zll1eDd4eHI0WDVBS2ZzdytHY3VHcmFxekhLTFhsQThpYmp5dnIwazkzd3hW?=
 =?utf-8?B?ZVNxdm5xL3FVd0hMWStLRklKUWpzY0dpWE5idFpjZmc5cnA0dVY4Mk5FQ2lI?=
 =?utf-8?B?cW5nbFUyTmNYN2U3SEFnZkR4UGkzTXhxKzNweHk3dngzNlk3ZkpKU0t2R0lZ?=
 =?utf-8?B?dUtta0hXWjVhQktxYmY5QXA3Tk8vN2RlQW9ETDFpYjB4YWc3SGVlZS9DbW14?=
 =?utf-8?B?cm14ZE8xU2plK09LbGZlSTg4NnIrNUg0ai83UU1OYllPemZrelpzaVVBcEtj?=
 =?utf-8?B?RUVqR3lYNjdPaUxmVkwwamdZU1dZbE9RMmdwZlY2T0VCeHRydlRsU0hmM0M3?=
 =?utf-8?Q?0jb8aZxK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4234e3-0a83-4178-cadd-08dbb085b05a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:07:23.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANbUCMQd/Kva2TfU8wmaYOushfHv7Fhq7ulm7fsQoDg+mIMv/VbDB8BdijbGsjsoXUAYeSiGiRecT8D1En4jVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080148
X-Proofpoint-GUID: X8Y9-hwiOk5ejcTQrQQM1Ftiivy5FOvy
X-Proofpoint-ORIG-GUID: X8Y9-hwiOk5ejcTQrQQM1Ftiivy5FOvy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230908 05:59]:
>=20
>=20
> =E5=9C=A8 2023/9/8 04:14, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:58]:
> > > Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and the=
n
> > > directly modify the entries of VMAs in the new maple tree, which can
> > > get better performance. The optimization effect is proportional to th=
e
> > > number of VMAs.
> > >=20
> > > There is a "spawn" in byte-unixbench[1], which can be used to test th=
e
> > > performance of fork(). I modified it slightly to make it work with
> > > different number of VMAs.
> > >=20
> > > Below are the test numbers. There are 21 VMAs by default. The first r=
ow
> > > indicates the number of added VMAs. The following two lines are the
> > > number of fork() calls every 10 seconds. These numbers are different
> > > from the test results in v1 because this time the benchmark is bound =
to
> > > a CPU. This way the numbers are more stable.
> > >=20
> > >    Increment of VMAs: 0      100     200     400     800     1600    =
3200    6400
> > > 6.5.0-next-20230829: 111878 75531   53683   35282   20741   11317   6=
110    3158
> > > Apply this patchset: 114531 85420   64541   44592   28660   16371   9=
038    4831
> > >                       +2.37% +13.09% +20.23% +26.39% +38.18% +44.66% =
+47.92% +52.98%
> >=20
> > Thanks!
> >=20
> > Can you include 21 in this table since it's the default?
> Maybe I didn't express clearly, "Increment of VMAs" means the number of
> VMAs added on the basis of 21 VMAs.

Ah, I see.  Thanks.

> >=20
> > >=20
> > > [1] https://github.com/kdlucas/byte-unixbench/tree/master
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   kernel/fork.c | 34 ++++++++++++++++++++++++++--------
> > >   mm/mmap.c     | 14 ++++++++++++--
> > >   2 files changed, 38 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 3b6d20dfb9a8..e6299adefbd8 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> > >   	int retval;
> > >   	unsigned long charge =3D 0;
> > >   	LIST_HEAD(uf);
> > > -	VMA_ITERATOR(old_vmi, oldmm, 0);
> > >   	VMA_ITERATOR(vmi, mm, 0);
> > >   	uprobe_start_dup_mmap();
> > > @@ -678,17 +677,39 @@ static __latent_entropy int dup_mmap(struct mm_=
struct *mm,
> > >   		goto out;
> > >   	khugepaged_fork(mm, oldmm);
> > > -	retval =3D vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> > > -	if (retval)
> > > +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> > > +	retval =3D __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_NOWAIT | __GFP_N=
OWARN);
> >=20
> > Apparently the flags should be GFP_KERNEL here so that compaction can
> > run.
> OK, I'll change it to GFP_KERNEL.
> >=20
> > > +	if (unlikely(retval))
> > >   		goto out;
> > >   	mt_clear_in_rcu(vmi.mas.tree);
> > > -	for_each_vma(old_vmi, mpnt) {
> > > +	for_each_vma(vmi, mpnt) {
> > >   		struct file *file;
> > >   		vma_start_write(mpnt);
> > >   		if (mpnt->vm_flags & VM_DONTCOPY) {
> > >   			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> > > +
> > > +			/*
> > > +			 * Since the new tree is exactly the same as the old one,
> > > +			 * we need to remove the unneeded VMAs.
> > > +			 */
> > > +			mas_store(&vmi.mas, NULL);
> > > +
> > > +			/*
> > > +			 * Even removing an entry may require memory allocation,
> > > +			 * and if removal fails, we use XA_ZERO_ENTRY to mark
> > > +			 * from which VMA it failed. The case of encountering
> > > +			 * XA_ZERO_ENTRY will be handled in exit_mmap().
> > > +			 */
> > > +			if (unlikely(mas_is_err(&vmi.mas))) {
> > > +				retval =3D xa_err(vmi.mas.node);
> > > +				mas_reset(&vmi.mas);
> > > +				if (mas_find(&vmi.mas, ULONG_MAX))
> > > +					mas_store(&vmi.mas, XA_ZERO_ENTRY);
> > > +				goto loop_out;
> > > +			}
> > > +
> >=20
> > Storing NULL may need extra space as you noted, so we need to be carefu=
l
> > what happens if we don't have that space.  We should have a testcase to
> > test this scenario.
> >=20
> > mas_store_gfp() should be used with GFP_KERNEL.  The VMAs use GFP_KERNE=
L
> > in this function, see vm_area_dup().
> >=20
> > Don't use the exit_mmap() path to undo a failed fork.  You've added
> > checks and complications to the exit path for all tasks in the very
> > unlikely event that we run out of memory when we hit a very unlikely
> > VM_DONTCOPY flag.
> >=20
> > I see the issue with having a portion of the tree with new VMAs that ar=
e
> > accounted and a portion of the tree that has old VMAs that should not b=
e
> > looked at.  It was clever to use the XA_ZERO_ENTRY as a stop point, but
> > we cannot add that complication to the exit path and then there is the
> > OOM race to worry about (maybe, I am not sure since this MM isn't
> > active yet).
> >=20
> > Using what is done in exit_mmap() and do_vmi_align_munmap() as a
> > prototype, we can do something like the *untested* code below:
> >=20
> > if (unlikely(mas_is_err(&vmi.mas))) {
> > 	unsigned long max =3D vmi.index;
> >=20
> > 	retval =3D xa_err(vmi.mas.node);
> > 	mas_set(&vmi.mas, 0);
> > 	tmp =3D mas_find(&vmi.mas, ULONG_MAX);
> > 	if (tmp) { /* Not the first VMA failed */
> > 		unsigned long nr_accounted =3D 0;
> >=20
> > 		unmap_region(mm, &vmi.mas, vma, NULL, mpnt, 0, max, max,
> > 				true);
> > 		do {
> > 			if (vma->vm_flags & VM_ACCOUNT)
> > 				nr_accounted +=3D vma_pages(vma);
> > 			remove_vma(vma, true);
> > 			cond_resched();
> > 			vma =3D mas_find(&vmi.mas, max - 1);
> > 		} while (vma !=3D NULL);
> >=20
> > 		vm_unacct_memory(nr_accounted);
> > 	}
> > 	__mt_destroy(&mm->mm_mt);
> > 	goto loop_out;
> > }
> >=20
> > Once exit_mmap() is called, the check for OOM (no vma) will catch that
> > nothing is left to do.
> >=20
> > It might be worth making an inline function to do this to keep the fork
> > code clean.  We should test this by detecting a specific task name and
> > returning a failure at a given interval:
> >=20
> > if (!strcmp(current->comm, "fork_test") {
> > ...
> > }
>=20
> Thank you for your suggestion, I will do this in the next version.
> >=20
> >=20
> > >   			continue;
> > >   		}
> > >   		charge =3D 0;
> > > @@ -750,8 +771,7 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> > >   			hugetlb_dup_vma_private(tmp);
> > >   		/* Link the vma into the MT */
> > > -		if (vma_iter_bulk_store(&vmi, tmp))
> > > -			goto fail_nomem_vmi_store;
> > > +		mas_store(&vmi.mas, tmp);
> > >   		mm->map_count++;
> > >   		if (!(tmp->vm_flags & VM_WIPEONFORK))
> > > @@ -778,8 +798,6 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> > >   	uprobe_end_dup_mmap();
> > >   	return retval;
> > > -fail_nomem_vmi_store:
> > > -	unlink_anon_vmas(tmp);
> > >   fail_nomem_anon_vma_fork:
> > >   	mpol_put(vma_policy(tmp));
> > >   fail_nomem_policy:
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index b56a7f0c9f85..dfc6881be81c 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3196,7 +3196,11 @@ void exit_mmap(struct mm_struct *mm)
> > >   	arch_exit_mmap(mm);
> > >   	vma =3D mas_find(&mas, ULONG_MAX);
> > > -	if (!vma) {
> > > +	/*
> > > +	 * If dup_mmap() fails to remove a VMA marked VM_DONTCOPY,
> > > +	 * xa_is_zero(vma) may be true.
> > > +	 */
> > > +	if (!vma || xa_is_zero(vma)) {
> > >   		/* Can happen if dup_mmap() received an OOM */
> > >   		mmap_read_unlock(mm);
> > >   		return;
> > > @@ -3234,7 +3238,13 @@ void exit_mmap(struct mm_struct *mm)
> > >   		remove_vma(vma, true);
> > >   		count++;
> > >   		cond_resched();
> > > -	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
> > > +		vma =3D mas_find(&mas, ULONG_MAX);
> > > +		/*
> > > +		 * If xa_is_zero(vma) is true, it means that subsequent VMAs
> > > +		 * donot need to be removed. Can happen if dup_mmap() fails to
> > > +		 * remove a VMA marked VM_DONTCOPY.
> > > +		 */
> > > +	} while (vma !=3D NULL && !xa_is_zero(vma));
> > >   	BUG_ON(count !=3D mm->map_count);
> > > --=20
> > > 2.20.1
> > >=20
> >=20
