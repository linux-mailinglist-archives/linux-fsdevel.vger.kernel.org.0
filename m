Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7B798A70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbjIHQGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjIHQGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:06:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5F11BF5;
        Fri,  8 Sep 2023 09:06:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388G4lQl021611;
        Fri, 8 Sep 2023 16:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=cD2C1rDyNmw03kgA0HNZPMzvU22RkZigEPZpRc1ymn4=;
 b=gDJ7EQbRC/cqOcGuvfEVmmZk5aufgJkHOZVw6p7wMmOGT8Unpa4DOOJvOYY6TBoWJa90
 DQZoCiNnb3bbFWyiAE+HCEXygg7NqSzQB0FB5C/EsHbhytynv/MRMzgfeqS/0VwdiJkX
 Xb11xPyFmYkUrfd3fOYMOn6VM+HvIh32YyW729AVEWcPHljzenlt1uX5AMr3UyUhQLX6
 rsKRDlph/73aYTq9ofTikaizgY53jvDeD1bK2Dtt2a0mEnQAiJAtTb5HPoCxQ0gjRPVM
 t/MAyBAhRC7G/MOFqAYQww1HKxaN4aCNYtS6iUxxjsPamOlx5PWmy26fCg7CgsyyqbD+ 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t063e04pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:05:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388EU09U016718;
        Fri, 8 Sep 2023 16:05:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugfkt96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 16:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNFD715Z63drImfTLTSDBxTFwYFhDUOgfxJQi4IAW+UrFcVlRiWntNsySjnSwNDDQ3paQn/EW/pIp1T4Tp9EUsHwCJ5BirZxA/ZIFenfwDHfHdkhw5Od9U7wavMXqs9sKsvfbO4X2ZhiczhDA+ZgXSRHiJbZQ5I/EVyXDhEGvizMG5Wa27Q6e5wP+RhQSLzVQ1g/56Gs9aKjfJ/bDYFYBUfJabTSseaPGc4I80MoJ48GNUkm9OxvrkOIeN7UhvWiE+8/c0FqqcfOAQcn3nAQ9FTKdN1LkT4LtwwdIHUzD7UUws/mT18CggYD7xsP5HiCw0gtcNZAHwfIeUQ1z1O69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD2C1rDyNmw03kgA0HNZPMzvU22RkZigEPZpRc1ymn4=;
 b=IoMaGQydKNd/qmI6cjGFPcyyT88igsFVfkekgnIlHOoUKU6E7YJqQM9dpmiXbUHS8XyUrtTqugjB10UBlp7kuRqkKe9GYEvlSBd3IjGMGTh5FSn4RAuR6QmYWGCuV6/xk3yoN7SbWnCS5Au7iwQRFm4GcYLlQJDt7YmL8cPGL5/xxS5mUK5J1jGYALDaqna6ANI+h/ZTDkw5Nl8SkVTHYPwIYT6MarHe9skvvdcnVBiNrYhekB+rJ1fNop+URgROEtF9cT6Ce+UOrUzEw0fxKqto2BrB3SLOsfTmfhZKidKZdC1HW5KsWsg1PA049KtOLLmhSVfWu1Gef919OK6SRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD2C1rDyNmw03kgA0HNZPMzvU22RkZigEPZpRc1ymn4=;
 b=fFedcKa85cregjJaDN71bV/wDJyl7cL8NjBXa9RfOPV9Wj6A6bnOo+DUvteQRZDQhdkZp3St5Z1L/cwX7/+79dQkcOLCEecmR/qWFCz8K6uR2tuYW9Qs7LyYpMf3x5ZO9U/comMHxE+Lpmww3NrcUvsw5nlha80Fj9ojZc70NZc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 16:05:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 16:05:43 +0000
Date:   Fri, 8 Sep 2023 12:05:39 -0400
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
Message-ID: <20230908160539.ror44o7xyffipy4d@revolver>
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
 <31cbd8a7-2b21-b7c5-51dc-20ea61353695@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <31cbd8a7-2b21-b7c5-51dc-20ea61353695@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: b027146a-b2df-4b63-966d-08dbb085746d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ReSbl/xL1tnFWbt8yQEECoSo7M1WF53gZ/hu1ccphXeXsUCvVv/pQgTUKpxPj9Qn3lq5oSucgUczG+b6b8j+jMxlN2wZrOrmB8TXPISXWwkvOtIIGBnqPJcUwaJYjwxT60eYphdjg8mt5g3v9XwamkSHH/VXwq2HeKFzKxYS/GFXUqz5xaSyiJbxcdoda7PZ2Icp8UQ31xXycQljptaIETm9HnSQPpAICsQpLkMMeZidNqYjcStF8nZ2VwOge59XwPJf+CC7JBXNS9nfndZT76B4gjy4wMFAnvziJ3NFWt1EqdjCS6ET4elxHsD+Ck9edBtPAfIMhd6Tykm3XxBvzqbWE9GnNRBOPf0nfZaeTs3CFnX/QApfG3Rj/AmDtcQSaqUb1KI5wpP+f1S8f1Ed3Xr9wIvI5NlXIPxpOEBk/0XCKUZQWhIxiwk5kEdRMgin05NtKa+AWPJ2+JYbir1qYrvplvDlVrkvO5i5PnMaAs/ilotxOTDHznuW4ZgGfamitk1fAJxRMDv6IFXgUA0Xi4COmQU61cpjJMOw+aCV9V3oq/j90O2HWzbAmmHme2KUp5yt1ozDP0aidDjIgLkj/6j68OUzjhxk/H4nBsJw5DI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(186009)(451199024)(1800799009)(38100700002)(86362001)(33716001)(478600001)(2906002)(9686003)(6512007)(6666004)(4326008)(6506007)(8676002)(6486002)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(41300700001)(30864003)(6916009)(7416002)(83380400001)(1076003)(26005)(60764002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enU1ZnFURzUySHFTMjg1YVhwdGRmZmdPV1p2dXdkYjZTRDlMcTRWV0I3bFoy?=
 =?utf-8?B?N0ltajFHaGtmeUR1OG1SUy9sNXl6TzVHTHByV0lCc1cvZy9yZVBzbmdjMGds?=
 =?utf-8?B?QWErWjBWQThib00ycWJjbWNWa3F0VGRZSS9reUxlc2pJb0tFU0FleHhMSDQw?=
 =?utf-8?B?V1B1bVhhZksyYlE1WnNrU1cxeTRvYUNLOFc5K1RHUzlhalQwRU5mb2NhQkFN?=
 =?utf-8?B?MDB1WHlYSkZRMUhPUnBSMHJFOGF2WEVyU3dZYXU4aU9BNlVOSTRXdC9WNkU3?=
 =?utf-8?B?WmVPUlNpM250dGhFWkpxZmJhOTBxMzBQV0d0K1hXaHhtRWc4SzZ3R1IzYk1W?=
 =?utf-8?B?TTJkNTc4dnloekt2UGdnMWgrMXdrMFphTGw1MURjQUVMVCsrUHk3ZHp2bGIv?=
 =?utf-8?B?enZiTlJzb2pxc1JEeEFJblJBVWJjdGlpdS81aVhqZStBRjNybnR1Qms5THhp?=
 =?utf-8?B?WDM3QUdLLy9PT0NwbmIwWjRZbDhWTFpRT1luLy80Rm1lZjYvNUtCRVRBZU5l?=
 =?utf-8?B?ZjNaOUZFaG83WVZtWHFaYUtqY0RJOG42a3dmdVliU2dIV1FsZWhrbDVKM2kx?=
 =?utf-8?B?cm0wSUVleHpUK1pJUjRYUStvNjl3RW1yNEppSDlnaFo4cHc3RnhsR3I3Y0sr?=
 =?utf-8?B?TVlFb2NWaGV6QTFXR1J5dURjSThKbG96b3YyTkhselN2SWorOGtSOWtRaEhS?=
 =?utf-8?B?VG1STTdMRlNnNFhLeDFvVm95NFJ1dTlZMHEyMkExNnpINU5JVFNUL3hLWi9P?=
 =?utf-8?B?TUJ2SHhESGkvRllYd3Vkc0c2OXovYnNXc2g4THNWSnBabjFyeWJQeWZQdWRh?=
 =?utf-8?B?NVl5bHpKNk0yYkcxc2pYdi9va2lXQzZXcjYwbEVvRWxwWE0xcjcrSFNJV1hu?=
 =?utf-8?B?OFRYa1QrOFhPNm1lVFBGdHNPa3hzaUxBN25CM0NIVlAwNVdoRGxscmxwK1B1?=
 =?utf-8?B?MENmVnlRNk03N3plVkI4MUVPTHBRejdwVFAvNGhNZEVMVW85ZHdiN1BTeWcx?=
 =?utf-8?B?U3FtZzNRL3Ewb0IrdEZmK0ltUGxUaVJ3akVOYmlJTDhrczlZTEdrR0VySGF0?=
 =?utf-8?B?OTRJeXVmR2p5RFUvc2o5ZDVXdDd0UVpYR3A1UHN1dWExS3dQNjlCYVZsSE5x?=
 =?utf-8?B?NkYrR2pNRDZ6RVBGM1dOUTk3UkFJZ05RNUFYd2QvOVBsWWFpc1ZSLytXQngx?=
 =?utf-8?B?cXVmT21xZzlOcXJGY1JnTG1HbkRkRVJ2NXBKaklxU3ZQREhnYVIrN1pWc01n?=
 =?utf-8?B?ZzYycDFzcFZvZUJsSGcvNm1GWE5mWTRZaWFLNzAzS2QxMWJ4TUY0QnFuRkgw?=
 =?utf-8?B?SXFaaGNRcDNHQ0dqWWJtOUpjSG1TUHZQOVNiRy8zRG5ab3kwNXJzL0dIbDg3?=
 =?utf-8?B?OFY1d2ZEWFdhSS9VelFPcXZJUU96anROODJzNG9VQ3lJNnNJWCtpZURYZExl?=
 =?utf-8?B?eC9mUGVjUHFpS2ZrSHNuZTF2dm9jek5ld21Pc2VRU0dhSVltOHlvbUlUc0VC?=
 =?utf-8?B?dk9Ja3Z1MmpnYXNJRy9HY0hIaExZOTFsQUh4NHBzaVc2b0JsWVc1clU4c0xs?=
 =?utf-8?B?MU81V2JNNHRtTG4ydHlzckRRZFROTTZ3ZHBEdllsbVdVVHJ5VGtIZDR5U2Jl?=
 =?utf-8?B?WW5MVXlPeDAxVFFmcXR1ODBmSG1BQTJRaE1Tc1pxOXhXNGJrRzRhZzF6MXNH?=
 =?utf-8?B?NXVNMDZ1dUdadW5MNFNmRElpZkE1Smp4ejNibzlCQ2daRm1GN1RZcWJNNVo3?=
 =?utf-8?B?ejFHMk9ZN3FQcGRjTm5xNlQ5eitvUXcxUFZwblh4T0d6QW1rR1owMHZ4cjFV?=
 =?utf-8?B?RFV3c3VvUGx1Y2hJUVFuRkh5eGdoV2d2alhQcFhUekllUWxYVDIvQVRCQlpY?=
 =?utf-8?B?TGFZN3V2M3dlYU5xdGVCMFF6WEFMZHUvdGhQLzU1M0pVRUh2WDV4aG5pTS95?=
 =?utf-8?B?aDlCN0Z4c1doc0s3V3laZlhpZ2ZKeVpqUkFXQmhzR0FGaUN5SDM0WmN6VWg3?=
 =?utf-8?B?OWdhL0pvTGlzV2ZURmpMVGJhd2hHNkZDYjc2TGkvVTJYWEthcm90VmtYQUpQ?=
 =?utf-8?B?dUhQeEhCd1hpd1NGTy9nQVZxRFMvWTV2VUlWWngvSVNHNks2QS9mclpkaGpI?=
 =?utf-8?Q?8dpr27fRerf8vSiZfbL1Lof/1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?REJJUGVaK2dMUUNpZkszakp1N0pFbTRnS2gvR3IzVHNvWnEvZHJ4WlFjVEEy?=
 =?utf-8?B?UmljSXdLbjZzOHR5eHY2Y3JNZ2JyVWtIUndHcnEyUkI2Uy9mQ1dtTFhOeW5C?=
 =?utf-8?B?Tm1OSVFaUFEvNDFlZW9SRm53SWpVbWhQYklVemFVS1dIaE5CVVV1M001bWlx?=
 =?utf-8?B?WkNJdmZmSXVpZG9xV0lQNVIzZFVpRjBnVVYyb09VckNESFcrcTlBUlBaeUY4?=
 =?utf-8?B?SjgyZlRnbVY3UENNSTEwejFxbUNnejFOOStsMk1zTmRGOWh1cXB3dlZ0TkFS?=
 =?utf-8?B?Z0xTSEIxeXJWdXE3dXpPUUZlSkl1WmFHUVlxT21hcUhpd2dTMEZDWjVkTzRY?=
 =?utf-8?B?cjR5M1pJVTdVSG5mc2FoQTFOV0pEUDlsT0pqdDZKSzhmWmx0MndlcFNXUTdk?=
 =?utf-8?B?VVlIY1RIZmxSc2xSTDR6Qm9JZTFPa2tQYmRZc2dKS1hhc3p5eDlaOGFRN2hT?=
 =?utf-8?B?eGJHeVN1dm94Z211dklrUVNBK0dFMXNHVmhOM2tEUVlNYVdnRitJMzl6OEZR?=
 =?utf-8?B?MzJjVFdNZU9tRjFhOVJGL2paV3RZb1J6SlFDaWg0cUl0TUVzSmQ3TDJSeXdY?=
 =?utf-8?B?a29ka0prQ2VWVjltdmpialR3dXdUUHBZVnAyaGdndGJMTHRGUHBON2RjT2Fp?=
 =?utf-8?B?L01oVFo0UWh5dnRxbXV3MDV6eno1S21lcDJ2TDVGUE1lQW1vT1UzYUxadzR5?=
 =?utf-8?B?QnNML1JlSUl6OFR1ZUltTklkYkNUZ1psbHBpUUZMMHV1TGZTdnJaSDY5M0NH?=
 =?utf-8?B?MFVsejJWVjMrZjJ0Ylh4V0dGa2JTNDJkY085TWxRSmVxcGRKMnh4U0hMMldD?=
 =?utf-8?B?NmJjT1RkYXp4UHhKR0YxV0Fhd29oYS9tNFBmNGZtN3QyWWtkUDE5M0liN1dv?=
 =?utf-8?B?WXdJVDIzWlUyYml5NjVtWW5SVmdBM25OZ2FwTzgzNmQwa0l0Q0EvVTM5VkdJ?=
 =?utf-8?B?dmZqK0s3Zmdvcm11d1ZwdHlzb1VMTUpCYTczS3M1SDlXd014Ymt6L0dnQ3p0?=
 =?utf-8?B?OW9ZWS9mZEVJdzYzaC9jNWlTb1NDREdKb1ZSUFptS2VRbTE4TldoMzhuMmUr?=
 =?utf-8?B?N0ZRbmVkRTAyR0RjV0RHUnJxb0VKcGxGeExJbFVkYmR3ZU9IMmQ3UlhYQjY3?=
 =?utf-8?B?TW9yc1Z0eFo5aXhXM0pocFZBMWg3WVgwZkZGUGlpNTd3NGMzLzBieW5jVFV5?=
 =?utf-8?B?TEtyK3pjYTh6YzJydi9iWU9uZ3RRaW5nMXJwd0hNTzlLcmMzalIxeHBZelBy?=
 =?utf-8?B?eDNGMzMvRFNBc1dXNXNtS282K1psbUdqRU03U255WUxORzZEYm1KOTFiUDdn?=
 =?utf-8?B?TlBPeExQNFVUZENiS1N4QWNIMFRLdEdnbDgxL2ZVZ0xMY3JacWRsTFZiWWdi?=
 =?utf-8?B?eUhjbUlzMUNjVCtkN3A1dDhESVIzZXh3TGdpcVVWZlEreGszRDZEU3RiaGpo?=
 =?utf-8?Q?94pF8kEC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b027146a-b2df-4b63-966d-08dbb085746d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:05:43.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLWBOu8YxTlogTchaauHcK1J0T0lUjh3o1Zf2vWfnz2MRRLpqWvLYNKkY4CE1akzrdbvsRsNaQDyuKfferHTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080148
X-Proofpoint-GUID: mR1o4PCe4GU8mTC1GjrAXt7B8215ouB6
X-Proofpoint-ORIG-GUID: mR1o4PCe4GU8mTC1GjrAXt7B8215ouB6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230908 05:26]:
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
> Ok, I'll change __mt_dup() to mas_dup().
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
> Ok, I'll revise the comment.
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
> This cannot happen. Note the mas_ascend(mas) at the beginning of the
> outermost loop.
>=20
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
> I'll handle the root node outside.
> However, do you think it makes sense to have the parent of the root node
> point to the struct maple_tree? I don't see it used anywhere.

I'm not sure.  It needs to not point to itself (indicating it is dead),
and we need to tell it's the root node, but I'm not entirely sure it is
necessary to point to the maple_tree.. although it is useful in dumps
sometimes.

>=20
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
> I'll try to reduce some checks.
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
> It's impossible, because in mt_free_bulk(), the first thing to do with
> the incoming node is to go up. We free all child nodes at the parent
> node.
>=20
> We guarantee that the node passed to mas_dup_free() is "clean".

You mean there are no allocations below?

> mas_dup_free() also follows this so will not free children of this node.
>=20
> The child nodes of this node cannot be freed in mt_free_bulk() because
> the node is not completely constructed and data_end cannot be obtained.
> data_end cannot be set on this node because the number of successfully
> allocated child nodes can be 0.

It still seems unwise to keep pointers pointing to unallocated memory
here, can we just clear the slots?

It's a bit odd because our choice is to leave it with pointers to nodes
in another tree or potential unallocated memory that isn't anywhere.
Both are a bit unnerving passing into another function that cleans
things up.  Since it's the error path, we won't have a performance
penalty in wiping the slots and it doesn't really matter that the node
isn't valid.  It seems more likely we would catch the error in a more
identifiable place if we set the slots to NULL.

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
> I will try to do that.
>=20
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
> I'll rename it.
>=20
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
> I will set it to MAS_NONE in the next version.
>=20
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
> I can do this, but it doesn't seem to make a difference.

Thanks, Just for clarity of keeping it all on one line and sine there's
going to be a respin of the set anyways..

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
> Yes, it will hit the root node but not the end of the root node. I'll
> fix this comment. Thanks.
>=20
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
> Okay, I will describe more in the next version.
>=20
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
