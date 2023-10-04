Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B327B823B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjJDO0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 10:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjJDO0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:26:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17825C1;
        Wed,  4 Oct 2023 07:26:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948ivsS011615;
        Wed, 4 Oct 2023 14:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=VfKeGpyFzfSga2ghcqRip29s3Wjk3OC2sf2sLShqFxM=;
 b=XDukHtcQ9h6bzLfCAuEfjUpxjET+9+lYwyk6iLLTR4dkFBjGVS3vdysA6imlNU0CyU6d
 9Isk1+Dw6ynpasvOrDEruuqvzZNeqYtysJDj4DZj+ggX28z6cmSDetShXyvDRvOt5D3Y
 7G6Ur47EcasYcLJDmbPpvfasbrUAEw+BgUcUJMeDvNj5/KOc8fCLNS71ExVgS/e1brjx
 rS+Eh6dEFASwqFmnGVYNqq4J92eCVrYzCzhbc8emQL+lfpP/A/HyMZ4Zg6mc0RmC3TV1
 22i/ZIVQjKEnFxAN/V5I1ZWeuyPRVxHjYyBmdyuyy5ds8jVoo5JegTCsvY1A3L8X+Sz/ UQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vf4wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:25:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394DAZEV005796;
        Wed, 4 Oct 2023 14:25:07 GMT
Received: from outbound.mail.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47pbw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:25:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6KZex3BQwGz76yiNMtrMYUh/l6m4EeQTmhxiDD20sTMv4nstRA2zdtxI+07ikyPK1aeRzp7bsxUZc2aRHdnAAOGKynAtPJfadftS1/nkW6v5MNm7idSjih5oZNuZZeyP8hvO6TJepzGakyeWDBZnWr3eWXtncPbU1CP3GApMvv2ll0ATU4RcbTi1s8JAsoiqV5QQs1ZmCUYqTJ+y/fnO1CB5n+ooiYu//6mIOkbxXsKCIMUkc43WZT6HQxuOrc8Z+Gvbe3f6hGlZVvNFrICI/Uqi3WWPmgJlKRJFapkgdTXFpLt4L/HgS6N6eoo1nNkv0c5QLYIqx3SG8u14xNYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfKeGpyFzfSga2ghcqRip29s3Wjk3OC2sf2sLShqFxM=;
 b=OnGkNeapAmm6W/awS13k25xlHGw48joOS02OYIcGtxnmddXX6gTUon95cs96GmFd83gdGSdibU+GVcboCVtx14q2T0kPc3tEl7ad6E+a0NCejjLqN2okeM9DJr4Elsp69ibVj03ciJmRnJNkvfD0PHfhmrbz49JMMuDIphltutEYl9XhLHMuAU2dLyPbRaZ7IxmvCyk/y7dgCzVA5XOxuoBAr9fI78CEtN3Utw9dJLONrKWWq5wAlFdFVDQ1pUa/8LUvlYAiOHWmsyj2pS/NET6SvykfJ7FdKxMENZ8XX67cLYOkMxe/q092V8+YadpPsab32fJNjXnh4OrOBb1VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfKeGpyFzfSga2ghcqRip29s3Wjk3OC2sf2sLShqFxM=;
 b=hFM8JJPOR8KSdropmAn9oe7TO+nJD4BaPEzJvWY4oOVrRwnC8rm8sjkl6FvbRiaFTrBJL7ywiDXJaJ17meXpbK4D6TNJ4mn87fg7evUb5DIDyB9xMXdd7nMzKBcVVLc+6+TU/TJPqsQDHMQualKluVTZGiQvsSpAJGukSKYpXH4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 14:25:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 14:25:04 +0000
Date:   Wed, 4 Oct 2023 10:25:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <20231004142500.gz2552r74aiphl4z@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-4-zhangpeng.00@bytedance.com>
 <20231003184542.svldlilhgjc4nct4@revolver>
 <7be3abc1-1db0-35a0-0a42-2415674effb1@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7be3abc1-1db0-35a0-0a42-2415674effb1@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a1e996-90bb-4f44-a205-08dbc4e5b349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZrm+DTkSwXhSCJ6X3Gsw/X2DaQLShizbuXibCLZFO8edEPtMhBHpcJvrkv9D4GIxLsXdHtBzwgRfJdklQMvhhPIo1tEDhgf182AI5bvOCupj+jO+iFhAczeoGHE14Zjxyrbv/F2dxV08G51eXxSsMwdZjE8B7kZ/tAVBWReGQaxwJpwsDWa4zw0yJWUC4qcxEhysbm8XuhmyyDI/+HIJJeUeG74uldaKBIDchFiwHlLDRzXiSoZASmkqxEcUofLT1mFGrm4H/Lpl0Si6jrPDGW25373xQ8FKvHeTAY4HGqtrnDMMp7FySOAdjrBukHKrdlcz3B/kY8Xv4wljN+OLdG7L76NcyNDCb9pJYU7+61Y4FF8PErfCCP2DS/YVtcvit0KEsRUMM6J1UqiIhiOApwsXOhBPDKWf00eiHwaiqfRutuAnzLVkDXzaBf/hyJypQZSeakTkmyac5856J5MRgOkpSopNGKecI9AB4RwXztq17M/HpfUL0ceLhyRPmd9Unpp2BTPON/UdXcFau6+Ry9Xri0kyAo2xumkExdAfok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6666004)(38100700002)(9686003)(6512007)(1076003)(26005)(6506007)(6916009)(41300700001)(316002)(66476007)(66556008)(66946007)(30864003)(2906002)(86362001)(8936002)(7416002)(5660300002)(8676002)(4326008)(478600001)(83380400001)(6486002)(966005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhraEZtQXlLQlJRZlBySXY4T3RBSEpQazhlY2hWRmg5SHBNTm1YbzhEdGh2?=
 =?utf-8?B?ejR4ZThZdmxrbWpmbHBwejhROFlLN3QrbkQ1REVLTDcxdEJZc1ptZHFvbUR2?=
 =?utf-8?B?VWd3RURlVVNDK0syWFFmWStGV0tJTFg3eGNHeUdQclM0aE5NUTV4Z2w0bXlV?=
 =?utf-8?B?MVMwdUpWMy95eEYwSktqemwvbzdkdTk3cXgvMGN0b24rZ1ZJMG5NYloyc3Vx?=
 =?utf-8?B?UGpCVW1xbVZrYnBhZEJxNnJxUkc2NCtKRVhrRTdHbitFSzk3ZVdPcmE3d3lP?=
 =?utf-8?B?SjcyeUJLYmM3b3phNlpJbmVQUktaWjR3L3M2dTNqdHJ6MTA0NEpTWVB0MXVt?=
 =?utf-8?B?bFAyYjBCV1MrKzJBT2pRc3ZQREZvay80RmFXK2RTZkJUaXloaGYweUtmSVlC?=
 =?utf-8?B?b2pNcEN4WFZvQTlxN3ozb280aXd4NmhLYkZkSThJTUdTeTArSENpVUhnT3BG?=
 =?utf-8?B?cmRVdlBsWWVtNGFPSmxUK3FWM3c5SW5JbVhYVmpjNmsrZGwzSnJveWNnMkFE?=
 =?utf-8?B?NzBXVDFELzh3T3NXUXVSdWhtcmhVN2htb0grYk5HSXZZOWhBTVFSRGRpeTU2?=
 =?utf-8?B?RWxObnY2Z1pZNVdJbHZFNDJnd3BRSlRmQXRtWU1RcjNiNlY1NDlpczg0UjBk?=
 =?utf-8?B?cnlPZkxOU1BrZlQyZ2t6aTFCZ2Nja3lXNlprbEF4Y3UvaDdPZDdWNi9QbExa?=
 =?utf-8?B?YjdyNW1QVnNidm1BOS9aeWZJSWdrazlrZ2hWcHA0ME5jUXQ4Q291bUw1MDg4?=
 =?utf-8?B?ZnNTK0FVNWk0eElNZUhUQjBqcUhHaUJNaGdmbTVQSUg5RmFoeTlnNzZwcU9Q?=
 =?utf-8?B?K1NwMG9odlFIOEZlVndPY2xydm53WDZkdUtkR0lBK3prazE2aU1rVlhqL3ZE?=
 =?utf-8?B?ck9mVXpWY3RpS1ZsdFVZcFVCbUNjaHNuVGtIN0V1VzZocCtqN3BMRzlpWTNq?=
 =?utf-8?B?NWNpMEUrQThXcGMrd2hXek5DT1J5aEVUbXVSVmRoZ1FEZXFWNzFJTkx5RVM2?=
 =?utf-8?B?MWVtRmJNUUUxMWVNTkZTQ045VWNNdDFtZDRoNC82bTY4dE1adWtiS3c5WEdB?=
 =?utf-8?B?L2cwanU2RU4zRG1Fbjd4WUo2OHc3N3hFaFN3M0NhQnZGVFcxRjl4SW5KekxG?=
 =?utf-8?B?dGZzS29xVDVUMWp3dzR5L2owVjJDK3F6QU8xaGlJRkpjVU9TS2FMc1NZMngw?=
 =?utf-8?B?bERmNDZURHhtemJQS1NhcHZTbVIrcCsrcWRpVDZRMElEVFZKd3dERk9SREVD?=
 =?utf-8?B?OWk0NTVKcDA4dHI3RCtlQ0xWZW40ay8ydU9VTnJMMlhzcVJLaktKMFBhMWpM?=
 =?utf-8?B?WVFsZi9TUmgyQU05K1lNRlJrbTA4ZXIyVjR2TzFMVllySlNsc2RrUnNHc3Z4?=
 =?utf-8?B?UkVWRnBrVmd5YUtzelRTTklYeWFMaDlxYXlNaTdwRStoczN0ZmV4V2VVN21J?=
 =?utf-8?B?YkFTSVJhU1VwWFJySXpWajRnVTBlbXU1Y0o3SmJFNk9UcXpDSXpPNXdhNm5k?=
 =?utf-8?B?MzUzOU5pelR1eVVQNi9EWkhZVmlOUm1HdjRKelExbmNZSnhSMGgzbGl6c0Jy?=
 =?utf-8?B?OS83VDZCejFwWG5yNE8rd0YwdzRERXVWMnlMNmp3dFJ2dXFwZ1Nwemh0RG9u?=
 =?utf-8?B?NHNjYnhPR3B3SEk3cmZzQTVWN1NmUlJqV3pjRGNYMll2UWtnMjZjMmEySCtj?=
 =?utf-8?B?U1g5MmkyWmdkOFZWTWYvRjliR1FSYnF2RVJ1L3BoL1dXaVlPRHdGTzdqcGhL?=
 =?utf-8?B?b3JWYldqSTh4YmdLdzhLVHh4Vy9jaHVyZ25QczFwMi9QN0NtVUtPTjM4aVBD?=
 =?utf-8?B?bXJNd2xOd0hBWlFwRmNkOEpFQnN1bmN4UUd6Nmo2UDBMYmpRY21GcDhRWmh0?=
 =?utf-8?B?SEtpSzQrdFB3WGlVOHkyaGtPWEJ2S250TVBiNnJwLyt2OCtSNitTcWFEWkl2?=
 =?utf-8?B?L2RWTlBKUkxObXRWdXRQNUdCWjZvSVFkc3VWcUlEWTVyM2I4Uk02SUFPRkZD?=
 =?utf-8?B?SkZISDBNUXJxamgvb3VmSG5zdi9ndEJzdFRCaHZxRk1iUEs0aUQvSnhwcWhK?=
 =?utf-8?B?cU5VWXZPcFU2anpyN202QzA2cmEyMXMxMDQ4b2tjRzM2WjB1cUZiYlY1aloy?=
 =?utf-8?Q?0tAy7wripx5RHgZMQevlNkaEK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V25nQWpUV1FRWVI4TENWTlB6Smc4dUt0TVg3MHlRYWMvMDdRbS9yeUdvYXdN?=
 =?utf-8?B?c3ZuSWw3bjBuTWFNMDBvd0M1Q1JTUlBOKzBZOEtNTHUvNUtWaDJwOFVjaFgy?=
 =?utf-8?B?QVBrcy9PSmI5eElDYmY4YUNKSytQeGFCclVldU5YclRTVmV2VFRGUWJkM3Bv?=
 =?utf-8?B?MGpQTDRGNXhpZHRPOEhrMGZIOThsWjJVWCtMTnBNRU9IUVQybWplZzVyYStt?=
 =?utf-8?B?SEdYZ0Q1NUxJVG5VS2M4Z1oxNE5zMjF5M2tvMDhTSStWV0lQUE5lV1d4SXdS?=
 =?utf-8?B?Mlg2bTc0dUk5OGxqWG4zNEdjdE0vZlk3dUZCUXRZQ0ZMQVE2c3ZPTUlrUHdy?=
 =?utf-8?B?OUZWenpGOTMwZmNJamtuRWhSbFI5MytaL3d1UUd5QTZLd1oxL25lem5BTi9L?=
 =?utf-8?B?SVRoQytibys4Q1lUajBwZlJpb3lkYXFQOERxRllZRStNcE9FR0NsRTkyVjhh?=
 =?utf-8?B?TURydXhnQ09yQ1JJR1Q5Y2N1RDFNTkppdXdESFNHV1d6N0ticlpycFk0V2M5?=
 =?utf-8?B?TVRqc3JBVEhpQkpQQ3Q2WWFGWE5pTzg2SDB4c0FzMlFlbExEcU03a1R4Uy9F?=
 =?utf-8?B?WGIwOVFaVTdsby9RcGtoZUxFN2htSWJFNlhEYVJFeXBZUjlTZy9EdHBzU1Br?=
 =?utf-8?B?QTRoNlZmWEdVaDlreHFCUFJldkpDQzFLN0VHdFRtNHhuOUtwMWRyWDdwRlJw?=
 =?utf-8?B?VUMxRUo1VDhpcFpGakUzaFl4Nmx5OVUvdDJUK243bXEzUzdQQVFUYWYzQ3ls?=
 =?utf-8?B?THAwd1M1dkZuZHhlZjN4TWdkQzdRd1RvWWw2ZGQ5T21IdlJHTXhHaHJDRnNj?=
 =?utf-8?B?SVB5RllqVGJmbzk2Y25PdUpRV3VQRE5DV0thYy91TzRnZE1mZmV1ODV0MHAz?=
 =?utf-8?B?NWtucGJxZUg0bjdwV3BFUmdrMGZFNDBQRkJhMFo4RW54WWdtVUplUmpYU3hy?=
 =?utf-8?B?VTNnUjFYZjcxdFErblpRcW1PQUZZYTJQVktYOC9LSDQzK2pnZVpFQ280VHY0?=
 =?utf-8?B?NDRjOXEyUGZra0t5OXdUTkRoQUZqOHB1VkcreE84Y2JadUhXK0dlT09sSHp0?=
 =?utf-8?B?ZHBWRWpMZTd4bE1RUEYvblIrbkp0MFErYUIzSXNuUDVFV1pnVGNvVkpidTRJ?=
 =?utf-8?B?dzY4eEg0L1FaVmx3MDgyc1c1anIxSEU4dERhT2xpek1yZkUrQ3dJL01uZnoz?=
 =?utf-8?B?dVVzZjEwYlBXbERtK1B2bURJaG9qL2xzUEdGMGw4Tkt3WWZvTlEyaTBrU3o4?=
 =?utf-8?B?U013bi9pbU1DN0crVmlMemdEQXhhYktHU1B0cTdtOE5BdnFDT2UrNElPTFl4?=
 =?utf-8?B?ZlhtcUhMMVpmSlo5T25KNldjUWsxWmxldTdVOG93U0ptMlVCZ2RxUVE1eEpE?=
 =?utf-8?B?ZCsvVWNpenlCOEFRMXNUbkhuRUVRcndidTBhUm92V0t6aE9wYTZ3aHBxZHJ4?=
 =?utf-8?B?UFNXUklBdkxRSllKNm9YZG9FWVd2VXFRZkRoZzcveGkyWTE5bW5JY252M0h3?=
 =?utf-8?Q?pAC6i3LLtFOmvaUX6eAQM/x3pGQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a1e996-90bb-4f44-a205-08dbc4e5b349
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:25:04.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6UsjOXBUf8ZzIK2FpozEWk5nUS0kPzn5YyE8per8lW7nxXFJLCoqVIdLv0VOegvW1DenhbZV/rrMXfEtJODsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040104
X-Proofpoint-ORIG-GUID: tJBRm6a1pyNFALX8ebXdTNUCNu7kf2J7
X-Proofpoint-GUID: tJBRm6a1pyNFALX8ebXdTNUCNu7kf2J7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231004 05:09]:
>=20
>=20
> =E5=9C=A8 2023/10/4 02:45, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> > > Introduce interfaces __mt_dup() and mtree_dup(), which are used to
> > > duplicate a maple tree. They duplicate a maple tree in Depth-First
> > > Search (DFS) pre-order traversal. It uses memcopy() to copy nodes in =
the
> > > source tree and allocate new child nodes in non-leaf nodes. The new n=
ode
> > > is exactly the same as the source node except for all the addresses
> > > stored in it. It will be faster than traversing all elements in the
> > > source tree and inserting them one by one into the new tree. The time
> > > complexity of these two functions is O(n).
> > >=20
> > > The difference between __mt_dup() and mtree_dup() is that mtree_dup()
> > > handles locks internally.
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   include/linux/maple_tree.h |   3 +
> > >   lib/maple_tree.c           | 286 ++++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 289 insertions(+)
> > >=20
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index 666a3764ed89..de5a4056503a 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsigned l=
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
> > > index 3fe5652a8c6c..ed8847b4f1ff 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -6370,6 +6370,292 @@ void *mtree_erase(struct maple_tree *mt, unsi=
gned long index)
> > >   }
> > >   EXPORT_SYMBOL(mtree_erase);
> > > +/*
> > > + * mas_dup_free() - Free an incomplete duplication of a tree.
> > > + * @mas: The maple state of a incomplete tree.
> > > + *
> > > + * The parameter @mas->node passed in indicates that the allocation =
failed on
> > > + * this node. This function frees all nodes starting from @mas->node=
 in the
> > > + * reverse order of mas_dup_build(). There is no need to hold the so=
urce tree
> > > + * lock at this time.
> > > + */
> > > +static void mas_dup_free(struct ma_state *mas)
> > > +{
> > > +	struct maple_node *node;
> > > +	enum maple_type type;
> > > +	void __rcu **slots;
> > > +	unsigned char count, i;
> > > +
> > > +	/* Maybe the first node allocation failed. */
> > > +	if (mas_is_none(mas))
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
> > > +
> > > +			mas_ascend(mas);
> > > +		}
> > > +
> > > +		node =3D mte_to_node(mas->node);
> > > +		type =3D mte_node_type(mas->node);
> > > +		slots =3D ma_slots(node, type);
> > > +		count =3D mas_data_end(mas) + 1;
> > > +		for (i =3D 0; i < count; i++)
> > > +			((unsigned long *)slots)[i] &=3D ~MAPLE_NODE_MASK;
> > > +
> > > +		mt_free_bulk(count, slots);
> > > +	}
> > > +
> > > +	node =3D mte_to_node(mas->node);
> > > +	mt_free_one(node);
> > > +}
> > > +
> > > +/*
> > > + * mas_copy_node() - Copy a maple node and replace the parent.
> > > + * @mas: The maple state of source tree.
> > > + * @new_mas: The maple state of new tree.
> > > + * @parent: The parent of the new node.
> > > + *
> > > + * Copy @mas->node to @new_mas->node, set @parent to be the parent o=
f
> > > + * @new_mas->node. If memory allocation fails, @mas is set to -ENOME=
M.
> > > + */
> > > +static inline void mas_copy_node(struct ma_state *mas, struct ma_sta=
te *new_mas,
> > > +		struct maple_pnode *parent)
> > > +{
> > > +	struct maple_node *node =3D mte_to_node(mas->node);
> > > +	struct maple_node *new_node =3D mte_to_node(new_mas->node);
> > > +	unsigned long val;
> > > +
> > > +	/* Copy the node completely. */
> > > +	memcpy(new_node, node, sizeof(struct maple_node));
> > > +
> > > +	/* Update the parent node pointer. */
> > > +	val =3D (unsigned long)node->parent & MAPLE_NODE_MASK;
> > > +	new_node->parent =3D ma_parent_ptr(val | (unsigned long)parent);
> > > +}
> > > +
> > > +/*
> > > + * mas_dup_alloc() - Allocate child nodes for a maple node.
> > > + * @mas: The maple state of source tree.
> > > + * @new_mas: The maple state of new tree.
> > > + * @gfp: The GFP_FLAGS to use for allocations.
> > > + *
> > > + * This function allocates child nodes for @new_mas->node during the=
 duplication
> > > + * process. If memory allocation fails, @mas is set to -ENOMEM.
> > > + */
> > > +static inline void mas_dup_alloc(struct ma_state *mas, struct ma_sta=
te *new_mas,
> > > +		gfp_t gfp)
> > > +{
> > > +	struct maple_node *node =3D mte_to_node(mas->node);
> > > +	struct maple_node *new_node =3D mte_to_node(new_mas->node);
> > > +	enum maple_type type;
> > > +	unsigned char request, count, i;
> > > +	void __rcu **slots;
> > > +	void __rcu **new_slots;
> > > +	unsigned long val;
> > > +
> > > +	/* Allocate memory for child nodes. */
> > > +	type =3D mte_node_type(mas->node);
> > > +	new_slots =3D ma_slots(new_node, type);
> > > +	request =3D mas_data_end(mas) + 1;
> > > +	count =3D mt_alloc_bulk(gfp, request, (void **)new_slots);
> > > +	if (unlikely(count < request)) {
> > > +		if (count) {
> > > +			mt_free_bulk(count, new_slots);
> >=20
> > If you look at mm/slab.c: kmem_cache_alloc(), you will see that the
> > error path already bulk frees for you - but does not zero the array.
> > This bulk free will lead to double free, but you do need the below
> > memset().  Also, it will return !count or request. So, I think this cod=
e
> > is never executed as it is written.
> If kmem_cache_alloc() is called to allocate memory in mt_alloc_bulk(),
> then this code will not be executed because it only returns 0 or
> request. However, I am concerned that changes to mt_alloc_bulk() like
> [1] may be merged, which could potentially lead to memory leaks. To
> improve robustness, I wrote it this way.
>=20
> How do you think it should be handled? Is it okay to do this like the
> code below?
>=20
> if (unlikely(count < request)) {
> 	memset(new_slots, 0, request * sizeof(unsigned long));
> 	mas_set_err(mas, -ENOMEM);
> 	return;
> }
>=20
> [1] https://lore.kernel.org/lkml/20230810163627.6206-13-vbabka@suse.cz/

Ah, I see.

We should keep the same functionality as before.  The code you are
referencing is an RFC and won't be merged as-is.  We should be sure to
keep an eye on this happening.

I think the code you have there is correct.

> >=20
> > I don't think this will show up in your testcases because the test code
> > doesn't leave dangling pointers and simply returns 0 if there isn't
> > enough nodes.
> Yes, no testing here.

Yeah :/  I think we should update the test code at some point to behave
the same as the real code.  Don't worry about it here though.

> >=20
> > > +			memset(new_slots, 0, count * sizeof(unsigned long));
> > > +		}
> > > +		mas_set_err(mas, -ENOMEM);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Restore node type information in slots. */
> > > +	slots =3D ma_slots(node, type);
> > > +	for (i =3D 0; i < count; i++) {
> > > +		val =3D (unsigned long)mt_slot_locked(mas->tree, slots, i);
> > > +		val &=3D MAPLE_NODE_MASK;
> > > +		((unsigned long *)new_slots)[i] |=3D val;
> > > +	}
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
> > > + * last node. mas_dup_free() will free the incomplete duplication of=
 a tree.
> > > + *
> > > + * Note that the attributes of the two trees need to be exactly the =
same, and the
> > > + * new tree needs to be empty, otherwise -EINVAL will be set in @mas=
.
> > > + */
> > > +static inline void mas_dup_build(struct ma_state *mas, struct ma_sta=
te *new_mas,
> > > +		gfp_t gfp)
> > > +{
> > > +	struct maple_node *node;
> > > +	struct maple_pnode *parent =3D NULL;
> > > +	struct maple_enode *root;
> > > +	enum maple_type type;
> > > +
> > > +	if (unlikely(mt_attr(mas->tree) !=3D mt_attr(new_mas->tree)) ||
> > > +	    unlikely(!mtree_empty(new_mas->tree))) {
> >=20
> > Would it be worth checking mas_is_start() for both mas and new_mas here=
?
> > Otherwise mas_start() will not do what you want below.  I think it is
> > implied that both are at MAS_START but never checked?
> This function is an internal function and is currently only called by
> {mtree,__mt}_dup(). It is ensured that both 'mas' and 'new_mas' are
> MAS_START when called. Do you think we really need to check it? Maybe we
> just need to explain it in the comments?

Yes, just document that it is expected to be MAS_START.

> >=20
> > > +		mas_set_err(mas, -EINVAL);
> > > +		return;
> > > +	}
> > > +
> > > +	mas_start(mas);
> > > +	if (mas_is_ptr(mas) || mas_is_none(mas)) {
> > > +		root =3D mt_root_locked(mas->tree);
> > > +		goto set_new_tree;
> > > +	}
> > > +
> > > +	node =3D mt_alloc_one(gfp);
> > > +	if (!node) {
> > > +		new_mas->node =3D MAS_NONE;
> > > +		mas_set_err(mas, -ENOMEM);
> > > +		return;
> > > +	}
> > > +
> > > +	type =3D mte_node_type(mas->node);
> > > +	root =3D mt_mk_node(node, type);
> > > +	new_mas->node =3D root;
> > > +	new_mas->min =3D 0;
> > > +	new_mas->max =3D ULONG_MAX;
> > > +	root =3D mte_mk_root(root);
> > > +
> > > +	while (1) {
> > > +		mas_copy_node(mas, new_mas, parent);
> > > +
> > > +		if (!mte_is_leaf(mas->node)) {
> > > +			/* Only allocate child nodes for non-leaf nodes. */
> > > +			mas_dup_alloc(mas, new_mas, gfp);
> > > +			if (unlikely(mas_is_err(mas)))
> > > +				return;
> > > +		} else {
> > > +			/*
> > > +			 * This is the last leaf node and duplication is
> > > +			 * completed.
> > > +			 */
> > > +			if (mas->max =3D=3D ULONG_MAX)
> > > +				goto done;
> > > +
> > > +			/* This is not the last leaf node and needs to go up. */
> > > +			do {
> > > +				mas_ascend(mas);
> > > +				mas_ascend(new_mas);
> > > +			} while (mas->offset =3D=3D mas_data_end(mas));
> > > +
> > > +			/* Move to the next subtree. */
> > > +			mas->offset++;
> > > +			new_mas->offset++;
> > > +		}
> > > +
> > > +		mas_descend(mas);
> > > +		parent =3D ma_parent_ptr(mte_to_node(new_mas->node));
> > > +		mas_descend(new_mas);
> > > +		mas->offset =3D 0;
> > > +		new_mas->offset =3D 0;
> > > +	}
> > > +done:
> > > +	/* Specially handle the parent of the root node. */
> > > +	mte_to_node(root)->parent =3D ma_parent_ptr(mas_tree_parent(new_mas=
));
> > > +set_new_tree:
> > > +	/* Make them the same height */
> > > +	new_mas->tree->ma_flags =3D mas->tree->ma_flags;
> > > +	rcu_assign_pointer(new_mas->tree->ma_root, root);
> > > +}
> > > +
> > > +/**
> > > + * __mt_dup(): Duplicate a maple tree
> > > + * @mt: The source maple tree
> > > + * @new: The new maple tree
> > > + * @gfp: The GFP_FLAGS to use for allocations
> > > + *
> > > + * This function duplicates a maple tree in Depth-First Search (DFS)=
 pre-order
> > > + * traversal. It uses memcopy() to copy nodes in the source tree and=
 allocate
> > > + * new child nodes in non-leaf nodes. The new node is exactly the sa=
me as the
> > > + * source node except for all the addresses stored in it. It will be=
 faster than
> > > + * traversing all elements in the source tree and inserting them one=
 by one into
> > > + * the new tree.
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
> > > + * This function duplicates a maple tree in Depth-First Search (DFS)=
 pre-order
> > > + * traversal. It uses memcopy() to copy nodes in the source tree and=
 allocate
> > > + * new child nodes in non-leaf nodes. The new node is exactly the sa=
me as the
> > > + * source node except for all the addresses stored in it. It will be=
 faster than
> > > + * traversing all elements in the source tree and inserting them one=
 by one into
> > > + * the new tree.
> > > + * The user needs to ensure that the attributes of the source tree a=
nd the new
> > > + * tree are the same, and the new tree needs to be an empty tree, ot=
herwise
> > > + * -EINVAL will be returned.
> >=20
> > The requirement to duplicate the entire tree should be mentioned and
> > maybe the mas_is_start() requirement (as I asked about above?)
> Okay, I will add a comment saying 'This duplicates the entire tree'. But
> 'mas_is_start()' is not a requirement for calling this function because
> the function's parameter is 'maple_tree', not 'ma_state'. I think
> 'mas_is_start()' should be added to the comment for 'mas_dup_build()'.

Oh right, thanks.

> >=20
> > I can see someone thinking they are going to make a super fast sub-tree
> > of existing data using this - which won't (always?) work.
> >=20
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
> > > +	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
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
> >=20
