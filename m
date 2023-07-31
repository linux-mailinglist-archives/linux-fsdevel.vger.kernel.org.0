Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90245769C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGaQ3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjGaQ3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:29:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549DB2682;
        Mon, 31 Jul 2023 09:28:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTogs004888;
        Mon, 31 Jul 2023 16:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=OOGFmbMerxNMZ33VDa79w3YKACG3t90wq6s42BE1W70=;
 b=wdrjAkwTWgZTw0p/HDTGBBWYrSaCBnS5X6+11Kxj92asOs4WjTYdlcNCdiA/f4PTxT71
 6BPWmSkbw1fQK1YInaPx26nNH/RHKVPeET5qmfTrv/JMBiNh0ghgUaUzmqf62QPAV6MX
 v7nf+7cVIqAMlbLn7Oxl108r7dTeqzYwP41Xb9JnVaMkKM9wKwaFwBZvfqbuY08pLf3W
 RW9AkzaTysvyavkKNUA0r5h8xw0v44j4HmGktdM1NHLlqVkJLW3ST3PNaDRel+jiAJk7
 h9O2zcTjf3YRs4xVopldki/iCypqBC/BfBrj914HcCoa4EpqSwqqa3giW89YFxCgLx/F RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauty8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:27:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VG6PCM000693;
        Mon, 31 Jul 2023 16:27:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74v5ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 16:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9xlfY0rzO4RxvinhRdcJRzmaSoMm/oLKRyyt1PSLJw2HGu20js6YKf5brAtumIuacKPbzH1HDXToRAcOFdzkn3E7VO+bQZvtq8HWanNy7J+PJhpAz7tm+y1Q/ode74LlLbs1vGNC2lYHNbIal5OAJXRR7qicO8uDFp8BXJJNqzEoiFEc1XlHnrl5CZok92bJ2JwEG6GkLlzao89wfnMyQrRIVmFkSA6UCNF9F+cMXtBkDzoR8YqA7yriet5cdaVPaknxAlUdZ9s322x7Ttmlg4V9aojpyLmRFPnVDIsdjWhnSle66WKzoQYsydzFwb028i0FBJvNDTkhxQwoeZrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOGFmbMerxNMZ33VDa79w3YKACG3t90wq6s42BE1W70=;
 b=Av8mHSfdHRw/V3/mFLRBnrQcd0NGtC/HkKNwwfhzU8r+s7cAmM2vrtZEiwrggyo3Zx98VxHKUF5+gOHtX68eZZbevAt8Cdb20a3lwhIL2ZRpK2VOGcFoWAIDf8GJzjylYCBzVcfCvnY26dL86XvbGtARsEi7jOF5jrdH4PVNTSdNJ0uP4eX2EA0bnWlAMoQ69hhQpgA3C68WSJ19/j68TGInTvM81WbJWGmWvlpmBg/l6GunIwQQxpHf4jVYAwcAhwBSGePlXf2ptdRWVqnFdlckSc2EDoePrU/YLj/YOudW2RDT9M0xKLFyEvRyjNPQCCfFiPP+92/5KmesZMmwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOGFmbMerxNMZ33VDa79w3YKACG3t90wq6s42BE1W70=;
 b=VyshbXlad+CxICs2omdnssCweRf2eXWCChZ2Nx+oN6RfjpyeUwPr6GgEu8rVqjKVekiCnmBofFTMdEvN3Fa2N+bXADc/vSu/EbAzPKc0bnQxEXfgiABXLQMNNGk5i8/A1ObNWvSDTHXbpGmWfHcyh+bLljrhuurc+O6+tPZ1BUk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7854.namprd10.prod.outlook.com (2603:10b6:806:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 16:27:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 16:27:17 +0000
Date:   Mon, 31 Jul 2023 12:27:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     willy@infradead.org, michael.christie@oracle.com,
        surenb@google.com, npiggin@gmail.com, corbet@lwn.net,
        mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and
 mt_dup()
Message-ID: <20230731162714.4x3lzymuyvu2mter@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, willy@infradead.org,
        michael.christie@oracle.com, surenb@google.com, npiggin@gmail.com,
        corbet@lwn.net, mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-5-zhangpeng.00@bytedance.com>
 <20230726160354.konsgq6hidj7gr5u@revolver>
 <beaab8b4-180c-017d-bd8d-8766196f302a@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <beaab8b4-180c-017d-bd8d-8766196f302a@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c23637c-fefe-4576-2e70-08db91e30145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+BwXwsZZp9xt6s2sV7J5ZhigamB/lPmnp1EPIjRhtIMBN7j0GOulBZjTdJZSFCegynek8pmqpAoyNvKuNbbKPJ48PKVSyt6Z74i5sS/pqBLIPCvd5uUVzeKHlCCxvM4KHKnpK/LJSKqY9yVujsTf5mSYCTKx7upHMveC8Er4zMNn9baOZPTKKMx/eLw5gH1mWj9ntSxVAMIuO7ulp2RwHg8NSr97PNFIVMMjdGad2FG0k4ej2Z+VoyUKlQgt7OnwaeLai+hduMluO+sj8p+YXdNknkUZ6P0kIJtigy2Ry0qW0oFJ0+qFrfvtPk2Hh4q1tDz9HjIXtz2v5xfViQ+krM758xjozI7v0gvGak8vJr7RPRgqXd9osS9jZtS5ianqdiEHxA7o/3xHsJi7W0mP7bsYejr5xg5o/+jr5hgAYD/HU+zBYo2soHUqIe+/L2VQGD0HYwT5msXSyAoZLYtUD3gf071bP5scELDX5R1npkOdN3jBHj5JGvNd2HZHWZfxohNA9Ew/9CSTBBWe+3Kyfl3JRu0+7xQOsknFtNrHvVx4xseaPnu0meCPWC+/vc+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(5660300002)(2906002)(66946007)(66556008)(6916009)(66476007)(4326008)(7416002)(30864003)(41300700001)(316002)(6486002)(6666004)(8936002)(6506007)(1076003)(26005)(8676002)(186003)(83380400001)(33716001)(478600001)(38100700002)(9686003)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdwSzlZRVU0VXhqNml4eWhWNStUR005SnZCTEZMRDhnTlVkYkJQU0IxajJt?=
 =?utf-8?B?VW93RDVLYUF1c04wb0MwcHUzeVdIRTNGNUkzajZ5NEREenpIUTVFMXF6VWlB?=
 =?utf-8?B?K2NSZ2ZQYm1GRWVZQzFaeHFLRGZlVUVHaVJsM0VIYmNwV2pkVzJOZ1FMSEtO?=
 =?utf-8?B?MlpqQ3VRUEJDVmR4Z0UzN0pnY3dlZmozc05SeUg2QmF3cHJCYTdtNjhhZnFa?=
 =?utf-8?B?MTdhWHRqMTU4VUN2b2pmQlVsNHFJeStxWGxjcklmSTZDa1JRRnVMOUZOVU5l?=
 =?utf-8?B?R29sRXVTdHBUY0h2TmZHMVRpTHpQQTJTK2h6OHU1S2dURXZVWHkzU3BaeUZD?=
 =?utf-8?B?aGJwMW9GeEJHQTNlMDBtdVJuSFNJMHF1YW1KYXZqc0xrRWJ1SFRGNk9ONG1M?=
 =?utf-8?B?cWhFVTFHSENMUlZ5WkF5anNnZlo3eUhHdlNScUxNbk1GOTFxOU9kV1hNZjZQ?=
 =?utf-8?B?RXF3a1ZGVEREZUdNWitLa2JDVjRRbUVNdTVZRmxkTE16c3FkUGQ2OVhsV0hL?=
 =?utf-8?B?cGg3YVpseVJ3SzBIcmJISmE4d3IxZnQvU1RWWjZkUzMxRTRVNW94cjNpN2N0?=
 =?utf-8?B?RHcwQ1VSS2t0Rmgrakx3RWVISlBuV2VMSE9nRk1SaG91bHZGeHh0cGFobUt6?=
 =?utf-8?B?RzJxQXFlcTU5a1M3M1BnRGVyY0dmMEt3SEVFTi85OEdVRDFJQzlwMWZuVHho?=
 =?utf-8?B?YlhldWNSTVhRQmZ2b3ltQktrZTVnMExMb1NGYmYydzk1YVB3RzVYMFZJeTBu?=
 =?utf-8?B?VThvNXFoQnNVVlllWWpuNTkwbDd0elprbjgwSGNtblVTWlRRb1krYWhiWks3?=
 =?utf-8?B?SDdtdXo5NEtKOVBOYU9qdWI0eTVYbS9uSnpadXBOUk5pbkRyNnEwUGYzejdk?=
 =?utf-8?B?c25vODdUeWt4SHFtT0dmUWVnYmhzeXM2TWZ5ekUrMmtLcmd1SXY3V0Rud3F3?=
 =?utf-8?B?akRRbFFNVmc2dEEzamJ2dnkrYzBvaXhzNFgyQkZ2U0FkL2wzWU5nbFVSOFNv?=
 =?utf-8?B?ZDA4UEJGR1NHVTA4eEZwbUVhMVdkT01udTBvSjFuWVVMRC9hcEt6VS82emlL?=
 =?utf-8?B?RHkvTHNmWmhMYXc1UGJURFdld3hIR2Q3UEVrUTZyRmJQRVRxdVkvWkRaOE5T?=
 =?utf-8?B?WGM4ZGh6Z09IS1djL3lUOU01cTBPcjUveE1SS09Fc1ZWdHp2RDZUbDhjNDRF?=
 =?utf-8?B?UWp2b1k1NU42L1ZqVGNkLzYzRWpsT0xNMEVoSGxmcUdXbUZDaVliOVEwbmMr?=
 =?utf-8?B?N3lIZXdyYmVSekJlMzl5aXI3T3Bzc205U0FnVzEvZWk3RlVFQitWZWNScldz?=
 =?utf-8?B?RW1KbWFqMjV6ZDNvaGsvT2JEemdSV2N3UlpTZTR0NnZRa2U2SHJOQ2NPeURM?=
 =?utf-8?B?SW5maThvTkVLelBnSkJ1RW1IcTNIMW9YRlg3ejBWS25QL0V3eFc3enVXckpZ?=
 =?utf-8?B?bm9Pc0VmbmcxZHFia3BlSWs1WGVPaXJ5ZUh1OXhqdmRjWVNJWkJrTVQ0Z3l0?=
 =?utf-8?B?MkU5MGthNGl3Szk1czBkMDU4SE5iU3loM2lBaDZrbkY3NHg0Y0dQTWNsZkMw?=
 =?utf-8?B?MHRkMkRleEtSWjlBbG9lRjZMQ0l1ZmVvNmRtZFVDUExYK25LYjNDWGpmRXpL?=
 =?utf-8?B?V082Nkxzb3NQcGtTcWpqS2JYbGFrK2Zwbnk5V3FpT2pvS1FCSk8rbS9wbXFQ?=
 =?utf-8?B?bmhFWVRDRlloNENlcmdZMlUraDVobDF6cnVNV2NEcHZ0akMwcHNWVEQ4ajFL?=
 =?utf-8?B?Y2dQZ1JZTytzbkwyVk5nelNERWhHb2pySlo3VWJzaUQwdU0yRittWFhndS8v?=
 =?utf-8?B?YjlmSnA4Z1ZoTmE2TG9ZT0ExVWxpbEo2UEdKU3dzKzVIUm5GcGkvTDVORlBI?=
 =?utf-8?B?WEdEMDdBcS8xT2cyMmR2SjV5dUZSQkNLZkVtSlljZjByV3Q0WktYWUs3YUpz?=
 =?utf-8?B?TXdYR1JBSm9tRlJOR0c5Z2JrS0NkczVuU1AyMWxoWFRHTUt1cE1wcU1YZXh2?=
 =?utf-8?B?Wm9wM01QKzZWTjBmWkhEU1hobmhiOENjcnBKOFNra0RoWldoU1c3SCtSOXVP?=
 =?utf-8?B?LzZxNFp6QnRvbEJBVXJJM1Fwb1BmZ0dTaWFvNjQvcUVhRkJxUERSbGtZMTZ0?=
 =?utf-8?B?MFM1UytHaE1VL0JFMlhuMzJUMGJrUkZxRnlIeDVnL200YTBJajZLQWwxVGRx?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a00xaitXL1BNeXI4a2l2M296NWp3OERXdE9KZEtrQXgvRDZUa0RaQURWNjJn?=
 =?utf-8?B?a0ttZlpTOStmU0ZWZUtVV1Q2RXdoUnRTa3F5OGZmS0FyOTZUN0xRL21KR2ZK?=
 =?utf-8?B?RkJMeDFZVjRCWTVIbXdlSFNrZVYyK3E4dkhXV2I0ZWdzQ1VHbmxXWUJGSHI3?=
 =?utf-8?B?TXlac1hYS1V5K0JORFBLMCsrYWxqOWZRSDFVYTRLVzlFT0hZeTZSakNrb3VE?=
 =?utf-8?B?eUFHOXh4alpIRDF6dGh4QjdrcEpHYy9FWHdlTGJpTGF2WW9tbFpaSGRhU29p?=
 =?utf-8?B?SEdMMENGaDRqa285WVFsYUJIbTlaYU9iT0hCUm9TUnhQQlNXZ2xFVk9oQlRB?=
 =?utf-8?B?bGhldHlHelV6SmZVYnhTdzluVjEwWFcyS0NJamd5TzkzUmRPUEtzT0tBa3Rh?=
 =?utf-8?B?K3lsbk1TNXFFUER3VEloaWNoZHA4dU5iOVk3eEllankvWGEyM01VWnJuUjVs?=
 =?utf-8?B?aFREWm0yckVMdGxhci9hYVp5U3IvRWNKWG5LWVRaRUVUamNRUGdZZEFIUEc0?=
 =?utf-8?B?KzNGTi9MNXc2cmZaMjU5SDZUTTFLa3hyajRWVFA4QlNxVkk4NU9raGx0Ujlw?=
 =?utf-8?B?eFE1TmsvSUQ4Y1Vtdkk2R05QSTIyd0NkM1R2VWk3NFptL2NhYVc5MXBkT2VW?=
 =?utf-8?B?RUd3UXUwUzFUUWtISUFtQkJDckczVE56OGczeWN3TU9janBEeURzOWFYdTBO?=
 =?utf-8?B?bjRJcWVqdTYyM211ZGhValoveElHZ1JvOTd6QjJ3YnNLQllrTWZ3TlBncjBG?=
 =?utf-8?B?M09udTNneURPY25aZk9tWDV5NlFzdDRFNERnSzg0d1NEdjA0ZXNITEVldDhM?=
 =?utf-8?B?SFB1dmEzSjRhSDNYcmFkaWNyVTFMM3k1WDkvdG55ZVVMb0drYVg5MDcxQVB5?=
 =?utf-8?B?Y3ZyejdGa28rR29PMDhiaHVzQlNHejl0VFgvUHpqdW9UWXBZaWdxdHlOTlBk?=
 =?utf-8?B?b0RWaG8wMWd1eERzMXcvOU9xQVh6R1VLaDZobDB2Q1hPQndoQ1pFU0JjSHZT?=
 =?utf-8?B?TWo5ZDgzV0ZQWjhsMW92bmdna0Q1UzVtclJMZWxYSTNITlNwMGRranAwRlFq?=
 =?utf-8?B?MTFUQzNVWkVJVGpqR3FOVjByVWcwSFNKTW41TTBrS1A3NG52ZVUyVHBUTVVn?=
 =?utf-8?B?Skw0TTVDVGIwSXAvQitmUGd5OTB0cXJaSEUxaS9JcGF0L2NTYTB1eVBwS0lE?=
 =?utf-8?B?TFJKczBUb3RZc3dQMjBzc0xrY0Fkd2ZVanYwbVN2TlA2aXQ4TXk0OU1NcUhH?=
 =?utf-8?B?ejQycE1mUXliUFZvWUtZbmFDbVV2TFB4cE5OT3cwM3o2cjhnRnNQaHNmYm5T?=
 =?utf-8?B?TTFNNVF6eEtHcEJ1djNOYnk1bWRPcVVOL0J0T3VRaHkyeTN0c2J4ankralN1?=
 =?utf-8?B?bEgwaGxON0VQN1F5YzVvWTcyNzQ1MkN2dHVyNlVZMDgrNXYvbVVKUS9OcmRZ?=
 =?utf-8?Q?OvzudVrV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c23637c-fefe-4576-2e70-08db91e30145
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:27:17.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3JzdHlpFwIEhjB45ADUbGG6nlyGIzvC5WPjT+e7JHgLFqCamKGXGp82uwA6YX9gZ1etGKQNWbfe/Uwp2OPBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310148
X-Proofpoint-ORIG-GUID: OTV1VuueN33UDyIFFWe9qNmkkhjh9SBI
X-Proofpoint-GUID: OTV1VuueN33UDyIFFWe9qNmkkhjh9SBI
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230731 08:24]:
>=20
>=20
> =E5=9C=A8 2023/7/27 00:03, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > Introduce interfaces __mt_dup() and mt_dup(), which are used to
> > > duplicate a maple tree. Compared with traversing the source tree and
> > > reinserting entry by entry in the new tree, it has better performance=
.
> > > The difference between __mt_dup() and mt_dup() is that mt_dup() holds
> > > an internal lock.
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   include/linux/maple_tree.h |   3 +
> > >   lib/maple_tree.c           | 211 ++++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 214 insertions(+)
> > >=20
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index c962af188681..229fe78e4c89 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned l=
ong index,
> > >   		void *entry, gfp_t gfp);
> > >   void *mtree_erase(struct maple_tree *mt, unsigned long index);
> > > +int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)=
;
> > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gf=
p);
> > > +
> > >   void mtree_destroy(struct maple_tree *mt);
> > >   void __mt_destroy(struct maple_tree *mt);
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index da3a2fb405c0..efac6761ae37 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -6595,6 +6595,217 @@ void *mtree_erase(struct maple_tree *mt, unsi=
gned long index)
> > >   }
> > >   EXPORT_SYMBOL(mtree_erase);
> > > +/*
> > > + * mt_dup_free() - Free the nodes of a incomplete maple tree.
> > > + * @mt: The incomplete maple tree
> > > + * @node: Free nodes from @node
> > > + *
> > > + * This function frees all nodes starting from @node in the reverse =
order of
> > > + * mt_dup_build(). At this point we don't need to hold the source tr=
ee lock.
> > > + */
> > > +static void mt_dup_free(struct maple_tree *mt, struct maple_node *no=
de)
> > > +{
> > > +	void **slots;
> > > +	unsigned char offset;
> > > +	struct maple_enode *enode;
> > > +	enum maple_type type;
> > > +	unsigned char count =3D 0, i;
> > > +
> >=20
> > Can we make these labels inline functions and try to make this a loop?
> I did this just to make things easier. Refer to the implementation of
> walk_tg_tree_from() in sched/core.c. Using some loops and inline
> functions probably doesn't simplify things. I'll try to do that and give
> up if it complicates things.

Thanks, I'd like to try and simplify the code instead of adding goto
label loops. The code you are referencing is from 2008 and goto loops
are not common.

> >=20
> > > +try_ascend:
> > > +	if (ma_is_root(node)) {
> > > +		mt_free_one(node);
> > > +		return;
> > > +	}
> > > +
> > > +	offset =3D ma_parent_slot(node);
> > > +	type =3D ma_parent_type(mt, node);
> > > +	node =3D ma_parent(node);
> > > +	if (!offset)
> > > +		goto free;
> > > +
> > > +	offset--;
> > > +
> > > +descend:
> > > +	slots =3D (void **)ma_slots(node, type);
> > > +	enode =3D slots[offset];
> > > +	if (mte_is_leaf(enode))
> > > +		goto free;
> > > +
> > > +	type =3D mte_node_type(enode);
> > > +	node =3D mte_to_node(enode);
> > > +	offset =3D ma_nonleaf_data_end_nocheck(node, type);
> > > +	goto descend;
> > > +
> > > +free:
> > > +	slots =3D (void **)ma_slots(node, type);
> > > +	count =3D ma_nonleaf_data_end_nocheck(node, type) + 1;
> > > +	for (i =3D 0; i < count; i++)
> > > +		((unsigned long *)slots)[i] &=3D ~MAPLE_NODE_MASK;
> > > +
> > > +	/* Cast to __rcu to avoid sparse checker complaining. */
> > > +	mt_free_bulk(count, (void __rcu **)slots);
> > > +	goto try_ascend;
> > > +}
> > > +
> > > +/*
> > > + * mt_dup_build() - Build a new maple tree from a source tree
> > > + * @mt: The source maple tree to copy from
> > > + * @new: The new maple tree
> > > + * @gfp: The GFP_FLAGS to use for allocations
> > > + * @to_free: Free nodes starting from @to_free if the build fails
> > > + *
> > > + * This function builds a new tree in DFS preorder. If it fails due =
to memory
> > > + * allocation, @to_free will store the last failed node to free the =
incomplete
> > > + * tree. Use mt_dup_free() to free nodes.
> > > + *
> > > + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> > > + */
> > > +static inline int mt_dup_build(struct maple_tree *mt, struct maple_t=
ree *new,
> > > +			       gfp_t gfp, struct maple_node **to_free)
> >=20
> > I am trying to change the functions to be two tabs of indent for
> > arguments from now on.  It allows for more to fit on a single line and
> > still maintains a clear separation between code and argument lists.
> I'm not too concerned about code formatting. . . At least in this
> patchset.

I have a mess of it in the tree and wanted to communicate my desire to
shift to using two tabs for extra arguments in the future.

> >=20
> > > +{
> > > +	struct maple_enode *enode;
> > > +	struct maple_node *new_node, *new_parent =3D NULL, *node;
> > > +	enum maple_type type;
> > > +	void __rcu **slots;
> > > +	void **new_slots;
> > > +	unsigned char count, request, i, offset;
> > > +	unsigned long *set_parent;
> > > +	unsigned long new_root;
> > > +
> > > +	mt_init_flags(new, mt->ma_flags);
> > > +	enode =3D mt_root_locked(mt);
> > > +	if (unlikely(!xa_is_node(enode))) {
> > > +		rcu_assign_pointer(new->ma_root, enode);
> > > +		return 0;
> > > +	}
> > > +
> > > +	new_node =3D mt_alloc_one(gfp);
> > > +	if (!new_node)
> > > +		return -ENOMEM;
> > > +
> > > +	new_root =3D (unsigned long)new_node;
> > > +	new_root |=3D (unsigned long)enode & MAPLE_NODE_MASK;
> > > +
> > > +copy_node:
> >=20
> > Can you make copy_node, descend, ascend inline functions instead of the
> > goto jumping please?  It's better to have loops over jumping around a
> > lot.  Gotos are good for undoing things and retry, but constructing
> > loops with them makes it difficult to follow.
> Same as above.
> >=20
> > > +	node =3D mte_to_node(enode);
> > > +	type =3D mte_node_type(enode);
> > > +	memcpy(new_node, node, sizeof(struct maple_node));
> > > +
> > > +	set_parent =3D (unsigned long *)&(new_node->parent);
> > > +	*set_parent &=3D MAPLE_NODE_MASK;
> > > +	*set_parent |=3D (unsigned long)new_parent;
> >=20
> > Maybe make a small inline to set the parent instead of this?
> >=20
> > There are some defined helpers for setting the types like
> > ma_parent_ptr() and ma_enode_ptr() to make casting more type-safe.
> Ok, I'll try to do that.
> >=20
> > > +	if (ma_is_leaf(type))
> > > +		goto ascend;
> > > +
> > > +	new_slots =3D (void **)ma_slots(new_node, type);
> > > +	slots =3D ma_slots(node, type);
> > > +	request =3D ma_nonleaf_data_end(mt, node, type) + 1;
> > > +	count =3D mt_alloc_bulk(gfp, request, new_slots);
> > > +	if (!count) {
> > > +		*to_free =3D new_node;
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	for (i =3D 0; i < count; i++)
> > > +		((unsigned long *)new_slots)[i] |=3D
> > > +				((unsigned long)mt_slot_locked(mt, slots, i) &
> > > +				 MAPLE_NODE_MASK);
> > > +	offset =3D 0;
> > > +
> > > +descend:
> > > +	new_parent =3D new_node;
> > > +	enode =3D mt_slot_locked(mt, slots, offset);
> > > +	new_node =3D mte_to_node(new_slots[offset]);
> > > +	goto copy_node;
> > > +
> > > +ascend:
> > > +	if (ma_is_root(node)) {
> > > +		new_node =3D mte_to_node((void *)new_root);
> > > +		new_node->parent =3D ma_parent_ptr((unsigned long)new |
> > > +						 MA_ROOT_PARENT);
> > > +		rcu_assign_pointer(new->ma_root, (void *)new_root);
> > > +		return 0;
> > > +	}
> > > +
> > > +	offset =3D ma_parent_slot(node);
> > > +	type =3D ma_parent_type(mt, node);
> > > +	node =3D ma_parent(node);
> > > +	new_node =3D ma_parent(new_node);
> > > +	if (offset < ma_nonleaf_data_end(mt, node, type)) {
> > > +		offset++;
> > > +		new_slots =3D (void **)ma_slots(new_node, type);
> > > +		slots =3D ma_slots(node, type);
> > > +		goto descend;
> > > +	}
> > > +
> > > +	goto ascend;
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
e. The user
> > > + * needs to lock the source tree manually. Before calling this funct=
ion, @new
> > > + * must be an empty tree or an uninitialized tree. If @mt uses an ex=
ternal lock,
> > > + * we may also need to manually set @new's external lock using
> > > + * mt_set_external_lock().
> > > + *
> > > + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> > > + */
> > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gf=
p)
> >=20
> > We use mas_ for things that won't handle the locking and pass in a mapl=
e
> > state.  Considering the leaves need to be altered once this is returned=
,
> > I would expect passing in a maple state should be feasible?
> But we don't really need mas here. What do you think the state of mas
> should be when this function returns? Make it point to the first entry,
> or the last entry?

I would write it to point to the first element so that the call to
replace the first element can just do that without an extra walk and
document the maple state end point.

> >=20
> > > +{
> > > +	int ret;
> > > +	struct maple_node *to_free =3D NULL;
> > > +
> > > +	ret =3D mt_dup_build(mt, new, gfp, &to_free);
> > > +
> > > +	if (unlikely(ret =3D=3D -ENOMEM)) {
> >=20
> > On other errors, will the half constructed tree be returned?  Is this
> > safe?
> Of course, mt_dup_free() is carefully designed to handle this.
> >=20
> > > +		if (to_free)
> > > +			mt_dup_free(new, to_free);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(__mt_dup);
> > > +
> > > +/**
> > > + * mt_dup(): Duplicate a maple tree
> > > + * @mt: The source maple tree
> > > + * @new: The new maple tree
> > > + * @gfp: The GFP_FLAGS to use for allocations
> > > + *
> > > + * This function duplicates a maple tree using a faster method than =
traversing
> > > + * the source tree and inserting entries into the new tree one by on=
e. The
> > > + * function will lock the source tree with an internal lock, and the=
 user does
> > > + * not need to manually handle the lock. Before calling this functio=
n, @new must
> > > + * be an empty tree or an uninitialized tree. If @mt uses an externa=
l lock, we
> > > + * may also need to manually set @new's external lock using
> > > + * mt_set_external_lock().
> > > + *
> > > + * Return: 0 on success, -ENOMEM if memory could not be allocated.
> > > + */
> > > +int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> >=20
> > mtree_ ususually used to indicate locking is handled.
> Before unifying mtree_* and mt_*, I don't think I can see any difference
> between them. At least mt_set_in_rcu() and mt_clear_in_rcu() will hold
> the lock.

Fair enough.  I was thinking this closely matches __mt_destroy() and
mtree_destroy().  We could be consistent in our inconsistency, at least.

> >=20
> > > +{
> > > +	int ret;
> > > +	struct maple_node *to_free =3D NULL;
> > > +
> > > +	mtree_lock(mt);
> > > +	ret =3D mt_dup_build(mt, new, gfp, &to_free);
> > > +	mtree_unlock(mt);
> > > +
> > > +	if (unlikely(ret =3D=3D -ENOMEM)) {
> > > +		if (to_free)
> > > +			mt_dup_free(new, to_free);
> >=20
> > Again, is a half constructed tree safe to return?  Since each caller
> > checks to_free is NULL, could that be in mt_dup_free() instead?
> Yes, this check can be put in mt_dup_free().
> >=20
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(mt_dup);
> > > +
> > >   /**
> > >    * __mt_destroy() - Walk and free all nodes of a locked maple tree.
> > >    * @mt: The maple tree
> > > --=20
> > > 2.20.1
> > >=20
> > >=20
