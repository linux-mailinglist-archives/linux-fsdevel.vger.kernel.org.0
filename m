Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296BC7BA9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJETJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJETJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:09:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B065DB;
        Thu,  5 Oct 2023 12:09:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IPlHR024127;
        Thu, 5 Oct 2023 19:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=uvc3s/KVDdMJWUGc9JFV8ZinAL3Vpcd0B7gGUFljHlY=;
 b=d33/FdIEyosNYNxgru7ru0WO0XR+A06ziSrv6XzqNnhChSNwPPC761qbfw8yb2wRfTwy
 zmnwtNXd5BS8e1OwA2qa3J/JhiCfK46eqQ9DvuuG8aDmPJGqjMrJrkuz+/uqavZQnonH
 nZhpqmZ42q+n8sb57m6xHv9YqA+IIZaauPzZJ342OVj9FxlonhLI0BkZHP6Fb5DxYIlq
 tD1uc27luc4h7LriZYrwRwVq/O5Vc7DATENfcLOOXcio1btiam3i5UFtutfnrdmwl/sd
 ipRWwG+7jA6QVwxDpefj/9XvDx4Qq8//NEc6YjTUhZw8wFaa9SyYdQT4JN4HKwDApl/W 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4adh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:09:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395HnKN5000391;
        Thu, 5 Oct 2023 19:09:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49fdcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwV6vDXIE4GjvtuhFduSy6qJmF6iDSPixZxuqcCzMc+5ayn1TcJSc+pKGHcUIPA0Y+7z+OYgMp4e1Lr3kWgW7nPhJtk03CfE+NcV1Orgy4+9RZNQXl91g0fb9aaSyvzYBp8Civz+tTRhUcvxx/gOeB+JSVnJtu2hwMYHAQ261g5Cye+Ka1QabFMuXebaaSD5aUobri5cJq3ssB1qz9S568D8VTKOBYxQqXfqJ/cTSd0YHaAqZakrhJgFgBenP0j6k+YHn1oX5mM7sGAUn6HoUdhrefvb8mPONSoqmQH1lO0yGx0eiQLohp8zQVelyDWnWX7JGp2X7nd8TyWpiepleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvc3s/KVDdMJWUGc9JFV8ZinAL3Vpcd0B7gGUFljHlY=;
 b=jfiwqW4hN0z55i3YunCXotidCHV96LgBqWz9tny27nXhi68z17PNxzevDgTCOrv6oE1TvU7dvcFv6prBvJZ5+AADQ97eyik3XpsEgscALZhmDu1ngGtklTUE6cfb3/m0sCxITHI5qMpnJKGMGZXhQu+9c0wzqPa2Mnq55znSoWl04LhRdHeVNWckSlRDZw/hiDAWe0WEKEp6RSdA89nTcjMQGdX6GNM1M/YFldMxsx8hr3QmBljbwmAvAHx9pyE9FXLsHF4Ul6GGRSru21yVggTfSK0Hne6PX17mg9txmLw4PcF6auKXcsiY9JZX8liXH+msIqtvPsMiiEXHfX5FLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvc3s/KVDdMJWUGc9JFV8ZinAL3Vpcd0B7gGUFljHlY=;
 b=BYVBM8qorta2bsuWTn8Odaon7JRv1x7ur/najnIEA03vXms/u4TUnGCfdAp9suMyGgqYuqL3jpvX2/26B8o3aIMliPVW2qbl8zjytCZrLFp0JsqaV+cx0NvBq1bhEEQRMNdTeHDK+0MJQI5vOQ5WEq/4hJQoOCOkCrhSns1yOxQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 19:09:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:09:09 +0000
Date:   Thu, 5 Oct 2023 15:09:05 -0400
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
Message-ID: <20231005190905.opgrihyhg7uwc5ig@revolver>
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
 <20231004142500.gz2552r74aiphl4z@revolver>
 <867f3fb6-22c5-4dd1-479d-5b148163f2d0@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <867f3fb6-22c5-4dd1-479d-5b148163f2d0@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA3PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c5770d-f06a-437c-43f1-08dbc5d68d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jURvXG3dWAB589lVrG6YihDk7oxN19JcMDe397p+pBrGMsS/nqT9SoA+FwXta0rKlvfOys1vPTEI0c8KBD8C028nPE/stwWAFWk6MV8n6EOXvT0Ebc6Da5OSzYZE1OaLP+1KtOP41EEtrvUUwmZC4xnLC3C52Tcfio5jI684/Vt7/eUH+w3mdBtroXVxO4Hw+OP6clEBP2/f6OcNUhhrt3TS/tnVAfexdDEsFey8JuU+PEe13EjH/iixs8voVqKhdJiimANX13YcJekhIucOCe85gnaL0KQSmGNcT2khrVX+EcEn4j3riPy+VIFRnZuwEW0M7BpWq4y17mSFeOWEqyB6IefIjwW78a7DMr762A4ErUKwKQd6AIm87wYbvEDkDBRK8rC2iZvjA81auWrJtcx/957aW/u/5Cya8qUT70BpwF4XOz4nVFCGYgkREbiswRrFhlz/B6LDxd1D3O/WDJP7IWhxNI10F58BHmEltUHLVFg2X81pUHWvrsz6LJeKXp8bR0+LHYdhl1tfNjgk7ZLuVHL8zP3e7vYMqpP62pI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(966005)(38100700002)(8936002)(4326008)(8676002)(6486002)(2906002)(7416002)(9686003)(6666004)(86362001)(5660300002)(33716001)(1076003)(6916009)(41300700001)(66556008)(478600001)(66476007)(316002)(66946007)(6512007)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhVQW56S0Rqa3ZRaEEvSkVCMGF5eEpUUEhzL2tGbnl6a0UwR0ZRSjF6UmhN?=
 =?utf-8?B?L1l0cVp0aTVHaHJvNjQvZ0s3ZEplZzRuYmtPZ2w2K1pDMGhGbkRvRDl5OFh3?=
 =?utf-8?B?NUoxYUtleEFRNGFVb1VDYVVoRUpGNHl4OXVMWVg5MWdjdWdRVG00aDMrUUNr?=
 =?utf-8?B?eXA0aTNNTHozS0NNTnJqVlR6bnhTWEkwZzhlK2gyWkZmUXYrT0gxeDBWOThL?=
 =?utf-8?B?Z0FoRC9zSWV2VjFFZ1JWOCtrMVpFZDl2RkV4bmN0dGxwNW9hZzkzUHU1Q09z?=
 =?utf-8?B?TFJTM05jYjY4akRnRFowQjNlK202NEMzVEU4MWExZEl3ZWp5MXlyZFlmRXB1?=
 =?utf-8?B?MnB1NFRQeHVPYVpCNFVUZk1qSHZHWVcvUEhHdFo3NkJ4T011VDdvWk9UNEdI?=
 =?utf-8?B?UkZDK3ExMHJvOFVyMTlMMlQyMG5JTnFBMU5QY2pCcGwxR2sraFVmSTNBMkRK?=
 =?utf-8?B?K0YxZ0ZQaytYbFdNNmFwWStLdWVEajBFMU9sbmpnNWdYNTMrNGZaeGNhd0Q4?=
 =?utf-8?B?d2N2WkRFZVBsM25nTGUreDQ5dDBWUEo2RStNdTF2MVZrcnZyd0tEWjJFeFhC?=
 =?utf-8?B?cHRXZVMyM0g2RUVOQSt6UVBnd1NVa0hQWlFwSDFtQlM3dFo3VkYyRjdNQWNr?=
 =?utf-8?B?bmVYLzRtcnEyNGpVZjVSdXlERVlOREVXcm1HWmtndFJhcThmK2tXUjdpcE5M?=
 =?utf-8?B?aWJhWjc4WVBCSTc3UC9OSk9MZmMzVGpjaWtmUXlmeFFwVEU4dkFFblZNTy9r?=
 =?utf-8?B?VWdtNDZwTi9PL0E3M0c1ZS9RcGc5aWpQUzFpWHFOdHhvcW9TbkxSVXVCSFF6?=
 =?utf-8?B?Q3ZyeFJvSHMrejFKMWRTWjFsTE1WcEszd2YxVkllRmVOUXpkelZyeUtLaWRH?=
 =?utf-8?B?bVA0aHE3Qk96Qlc4NElxUnZDaWFLdmJ3d0t6VmtiWVNWNG1vb1ozeUVmRFdZ?=
 =?utf-8?B?U28ybzE0SE5YT3dLeWZMQzltVTlxaktPN1JjZ3pXYUh3SjQ0QU5pT2d1UTVD?=
 =?utf-8?B?QkNuOSt5WHc4T3MwRlo4SWUvNWQvVXcxQ0FwUzZMUU81UVJTMmtmeEdhRzVT?=
 =?utf-8?B?YlZ4MFgzTVROdjBZa1BDL2FiaE8zeUQzbEJaeVpLa1VCdk55TVZyR2ZyVndY?=
 =?utf-8?B?NXJoNjBIdXpyNzZXL01WM0N0YmRWWFdDTGV4d0FheUVHU1haZmdBdFdqblVE?=
 =?utf-8?B?Sit4ck5rRUlDdjFEdUszb1lRNmhsRHRpeEhDcDc1RDNzZzhwTmNhS0pKZzha?=
 =?utf-8?B?NDBqcS9LYmoyY2xNeURNY2RNR1VyYUNLYnV4N21rYlZNZmV1UkdrSjdOamVw?=
 =?utf-8?B?MHRKM1FOcDN2aTdHR2t3bnMzbERYQXdrVUxPbVNiYXVwNkRzNzZuZjRtY2RJ?=
 =?utf-8?B?V2JJb0I0c1RuWW9iWkVDdUJ4Ri9zWDNZdWY1a2JXZWpudGxaMU5ia2ZUSWtm?=
 =?utf-8?B?QVhidS9mVE15TkN6M3I5SFR5L2U2dkdhZS9BMitBcStwdS9RL0tCaXlkSTZu?=
 =?utf-8?B?NEtoeUc4TVpBcUFmbmRGNVFaRlY5UFhDU2JCMXR5MXFETWdtMFNFVjFxcGxI?=
 =?utf-8?B?YTJxZnFJMHFpQ05NaXFoVFdocEI4MG9uT0hWVGtteWgzMjhXTFRybTN1Vnhp?=
 =?utf-8?B?RGtlZ3FjeUdWL05TV0ZTRGNQSGpqWmpDWXlXd3Z3bmtwVERsYjhvV3I1cW83?=
 =?utf-8?B?N25vQ0NtRlBrSDJrQ1lEZmlyQXR6UjNQL3R5aGplS2RhUG1zYU1aM3pSY3Jk?=
 =?utf-8?B?djl6SUcvNGZJbHpybzZUQUE3MVhtS3hTZCtqczNqVHNvTU1rN3B2dVZSS0ph?=
 =?utf-8?B?T0NpSnBuQkdNNWZyU1FqN0U2SlNiRlFCREJibG1DSmtUZ3hobXJVTmtwKzdM?=
 =?utf-8?B?WGxOaEp6SnBHeTE1bGhPQ05Va291TldmelN1ZnNJbDNkWkp5ckV0SXRNSERO?=
 =?utf-8?B?aXRuT0Y4R2VUMVphUjdQMWlwQVY5SkRDQW01eWZnUFo5RXJpbkkxVy9PbHZ6?=
 =?utf-8?B?Vlo4REUwWkRUK09jK3h5aTNBV3dyWmNFQ2c5SGlJSS9HRnk1emc3SzFoS2hW?=
 =?utf-8?B?MUlIZUVQZDdWWE8xWHIwMUtneHVkRUNXQndiSGFUQUNyMFZyNDVEbzF4K2F5?=
 =?utf-8?Q?lBtd5rtaHaC7QU11jfQOZ+vfW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T1VrMVVxZXE4ZGlUb08zUkVGR0YxQlF1UytmUnljMXYvN085ZjZPaUluTVoz?=
 =?utf-8?B?YXc3bzBKanJUUDZMS0JuNmloMmZqSXBxYk1YVW5COEVxS0EzSFQrdFVXK0Yv?=
 =?utf-8?B?NHhuWmdiM1N3dVl6dnpPMFFPWEI0RVBDaS8zaXB3Q3JldUFNWE9WTTg4U1B6?=
 =?utf-8?B?Qm9XSEJ3MnZnQ1V6WGVGaXdSamZ4b3JZTHQveVFHUWV6dHRPSEVuZStLNGpB?=
 =?utf-8?B?QWxvV1NEdXlUaGZKdlROZzE3TmdSa1Mxb3FPdFRQdGxyakUrMktYNWZyMDA4?=
 =?utf-8?B?MlkrSUhCbW8vR3plNGVvMyszOStMckxHU0MweC9tdDk5TUFoNkRxMTdzczY1?=
 =?utf-8?B?WXIxTVY1R3QveUNYY0w1YzhZdGhsVUU4OWxIZHRLdmZPQ05Mdy9TMmVKeWpN?=
 =?utf-8?B?RHFxME50MTI1bVZvckFIM1lLMnJiZjF2QXBJNkt4S0RqWjEyRnplRVROWG1N?=
 =?utf-8?B?TDJLVDMvcUdTRTdCRUloSmhCYTE5K0hIbk1Kdm9RUkJRWGhBQlNXYjhCU1hS?=
 =?utf-8?B?dGpWdXJKUW5zcTM2cmIrOWVoUjA4Y1lrWkcvMmREanoxQ1U1NlpqN2VLdUp5?=
 =?utf-8?B?TUlQZ01nVk4vTHRqd1h2QVFHWUxNaXlzV0ZiMHJwK0ZzaTVES0s4T21OdWNP?=
 =?utf-8?B?Tkg5M2pYQzhpenFpWHFGYkM2dEJrTW1SVnNzUVZLdEZRcDVOT2hyY3puZkFS?=
 =?utf-8?B?S0pPUFVQZ01zOUY0WXZhZUVCbXFwUFZ5OWFzNGs0UzUvUFVRQmZneHowVVNl?=
 =?utf-8?B?VWwrZ1F2K1VLaGJxZ3VZT285KytyUFVzY0gyTkh1QjBoby9KZGVxb0ZRc3pC?=
 =?utf-8?B?MHBhNXUzODN5VVV5R3hqQVo3a01wQTVLYmk0MWZ4QWlQSmphVVF5eDMzVXFu?=
 =?utf-8?B?K2IwWkRPeGcydkFOT2xFNUM5WEllOXVybnBpTnpuTCs0VVpMZ0g0Y3RmNVlW?=
 =?utf-8?B?R1d4K3p3eHhSYXNud1NSYlh2eHNaTDZTWGJoZjk5M0xQZDg4eHVSRjJDOVFZ?=
 =?utf-8?B?WXhmMlBacEFsZXliUzJqd1hETmZrUitpQjNMK2JoYkRsUExaTzQ3LzZCK1Q4?=
 =?utf-8?B?ejFDWFBBL1puREZsOU1BdkJyUjYyVStrZ1hQU2hIenhkT0swYWo3bHlWWjJz?=
 =?utf-8?B?ZVNvbkVNaDgzMVY2TmoxNnYvY2lGSFAwOXRyUC9ZUVhYZGd1S0hMWkxoLzdT?=
 =?utf-8?B?WmU3cjFDZm90MzZaWnQvbDEyTDNuQnlHakoybUFsbWkveWIzOXZHR1JlanR1?=
 =?utf-8?B?T2NFN21yeFVDS3VLSWtseDZUOEk3NVZQcXl0WHYwc0xVN1BRTXhJdHIwZ2Vh?=
 =?utf-8?B?MzhQRDYyMlJYZ0NobGtvVDhTWnVpVHJOV0NSWVRlVzhXM3ZHVC9QWkZEbWJ6?=
 =?utf-8?B?ejVocTlrNE5iNFk4SkRBQ3psNFhPcnRhSFR6K3lqM3dtdnRBRlExdzdDd3kr?=
 =?utf-8?B?NXo1TFlTRldxTlhqbUNhMjcxbTdjRlVSUjY1R3lBSU5iOCtLaEhHVW0xeUg0?=
 =?utf-8?Q?fK2e/ek8CNPDJ5rSuSXkvrySxNz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c5770d-f06a-437c-43f1-08dbc5d68d75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:09:09.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ46OQgU1vrWZy71lajF4XQIuhioN3uL6CRRtGWpGx68QRM69MkFT9i9+Y2l0QOCQLW+FEbs+i/Tc/woriCylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_14,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050145
X-Proofpoint-GUID: _NoA0BbbDBegYHeWyPhksskg0aRkOtyh
X-Proofpoint-ORIG-GUID: _NoA0BbbDBegYHeWyPhksskg0aRkOtyh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231005 11:55]:
>=20
>=20
> =E5=9C=A8 2023/10/4 22:25, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [231004 05:09]:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/10/4 02:45, Liam R. Howlett =E5=86=99=E9=81=93:
> > > > * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> > > > > Introduce interfaces __mt_dup() and mtree_dup(), which are used t=
o
> > > > > duplicate a maple tree. They duplicate a maple tree in Depth-Firs=
t
> > > > > Search (DFS) pre-order traversal. It uses memcopy() to copy nodes=
 in the
> > > > > source tree and allocate new child nodes in non-leaf nodes. The n=
ew node
> > > > > is exactly the same as the source node except for all the address=
es
> > > > > stored in it. It will be faster than traversing all elements in t=
he
> > > > > source tree and inserting them one by one into the new tree. The =
time
> > > > > complexity of these two functions is O(n).
> > > > >=20
> > > > > The difference between __mt_dup() and mtree_dup() is that mtree_d=
up()
> > > > > handles locks internally.
> > > > >=20
> > > > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > > > ---
> > > > >    include/linux/maple_tree.h |   3 +
> > > > >    lib/maple_tree.c           | 286 +++++++++++++++++++++++++++++=
++++++++
> > > > >    2 files changed, 289 insertions(+)
> > > > >=20
> > > > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tre=
e.h
> > > > > index 666a3764ed89..de5a4056503a 100644
> > > > > --- a/include/linux/maple_tree.h
> > > > > +++ b/include/linux/maple_tree.h
> > > > > @@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsign=
ed long index,
> > > > >    		void *entry, gfp_t gfp);
> > > > >    void *mtree_erase(struct maple_tree *mt, unsigned long index);
> > > > > +int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp=
_t gfp);
> > > > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_=
t gfp);
> > > > > +
> > > > >    void mtree_destroy(struct maple_tree *mt);
> > > > >    void __mt_destroy(struct maple_tree *mt);
> > > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > > index 3fe5652a8c6c..ed8847b4f1ff 100644
> > > > > --- a/lib/maple_tree.c
> > > > > +++ b/lib/maple_tree.c
> > > > > @@ -6370,6 +6370,292 @@ void *mtree_erase(struct maple_tree *mt, =
unsigned long index)
> > > > >    }
> > > > >    EXPORT_SYMBOL(mtree_erase);
> > > > > +/*
> > > > > + * mas_dup_free() - Free an incomplete duplication of a tree.
> > > > > + * @mas: The maple state of a incomplete tree.
> > > > > + *
> > > > > + * The parameter @mas->node passed in indicates that the allocat=
ion failed on
> > > > > + * this node. This function frees all nodes starting from @mas->=
node in the
> > > > > + * reverse order of mas_dup_build(). There is no need to hold th=
e source tree
> > > > > + * lock at this time.
> > > > > + */
> > > > > +static void mas_dup_free(struct ma_state *mas)
> > > > > +{
> > > > > +	struct maple_node *node;
> > > > > +	enum maple_type type;
> > > > > +	void __rcu **slots;
> > > > > +	unsigned char count, i;
> > > > > +
> > > > > +	/* Maybe the first node allocation failed. */
> > > > > +	if (mas_is_none(mas))
> > > > > +		return;
> > > > > +
> > > > > +	while (!mte_is_root(mas->node)) {
> > > > > +		mas_ascend(mas);
> > > > > +
> > > > > +		if (mas->offset) {
> > > > > +			mas->offset--;
> > > > > +			do {
> > > > > +				mas_descend(mas);
> > > > > +				mas->offset =3D mas_data_end(mas);
> > > > > +			} while (!mte_is_leaf(mas->node));
> > > > > +
> > > > > +			mas_ascend(mas);
> > > > > +		}
> > > > > +
> > > > > +		node =3D mte_to_node(mas->node);
> > > > > +		type =3D mte_node_type(mas->node);
> > > > > +		slots =3D ma_slots(node, type);
> > > > > +		count =3D mas_data_end(mas) + 1;
> > > > > +		for (i =3D 0; i < count; i++)
> > > > > +			((unsigned long *)slots)[i] &=3D ~MAPLE_NODE_MASK;
> > > > > +
> > > > > +		mt_free_bulk(count, slots);
> > > > > +	}
> > > > > +
> > > > > +	node =3D mte_to_node(mas->node);
> > > > > +	mt_free_one(node);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * mas_copy_node() - Copy a maple node and replace the parent.
> > > > > + * @mas: The maple state of source tree.
> > > > > + * @new_mas: The maple state of new tree.
> > > > > + * @parent: The parent of the new node.
> > > > > + *
> > > > > + * Copy @mas->node to @new_mas->node, set @parent to be the pare=
nt of
> > > > > + * @new_mas->node. If memory allocation fails, @mas is set to -E=
NOMEM.
> > > > > + */
> > > > > +static inline void mas_copy_node(struct ma_state *mas, struct ma=
_state *new_mas,
> > > > > +		struct maple_pnode *parent)
> > > > > +{
> > > > > +	struct maple_node *node =3D mte_to_node(mas->node);
> > > > > +	struct maple_node *new_node =3D mte_to_node(new_mas->node);
> > > > > +	unsigned long val;
> > > > > +
> > > > > +	/* Copy the node completely. */
> > > > > +	memcpy(new_node, node, sizeof(struct maple_node));
> > > > > +
> > > > > +	/* Update the parent node pointer. */
> > > > > +	val =3D (unsigned long)node->parent & MAPLE_NODE_MASK;
> > > > > +	new_node->parent =3D ma_parent_ptr(val | (unsigned long)parent)=
;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * mas_dup_alloc() - Allocate child nodes for a maple node.
> > > > > + * @mas: The maple state of source tree.
> > > > > + * @new_mas: The maple state of new tree.
> > > > > + * @gfp: The GFP_FLAGS to use for allocations.
> > > > > + *
> > > > > + * This function allocates child nodes for @new_mas->node during=
 the duplication
> > > > > + * process. If memory allocation fails, @mas is set to -ENOMEM.
> > > > > + */
> > > > > +static inline void mas_dup_alloc(struct ma_state *mas, struct ma=
_state *new_mas,
> > > > > +		gfp_t gfp)
> > > > > +{
> > > > > +	struct maple_node *node =3D mte_to_node(mas->node);
> > > > > +	struct maple_node *new_node =3D mte_to_node(new_mas->node);
> > > > > +	enum maple_type type;
> > > > > +	unsigned char request, count, i;
> > > > > +	void __rcu **slots;
> > > > > +	void __rcu **new_slots;
> > > > > +	unsigned long val;
> > > > > +
> > > > > +	/* Allocate memory for child nodes. */
> > > > > +	type =3D mte_node_type(mas->node);
> > > > > +	new_slots =3D ma_slots(new_node, type);
> > > > > +	request =3D mas_data_end(mas) + 1;
> > > > > +	count =3D mt_alloc_bulk(gfp, request, (void **)new_slots);
> > > > > +	if (unlikely(count < request)) {
> > > > > +		if (count) {
> > > > > +			mt_free_bulk(count, new_slots);
> > > >=20
> > > > If you look at mm/slab.c: kmem_cache_alloc(), you will see that the
> > > > error path already bulk frees for you - but does not zero the array=
.
> > > > This bulk free will lead to double free, but you do need the below
> > > > memset().  Also, it will return !count or request. So, I think this=
 code
> > > > is never executed as it is written.
> > > If kmem_cache_alloc() is called to allocate memory in mt_alloc_bulk()=
,
> > > then this code will not be executed because it only returns 0 or
> > > request. However, I am concerned that changes to mt_alloc_bulk() like
> > > [1] may be merged, which could potentially lead to memory leaks. To
> > > improve robustness, I wrote it this way.
> > >=20
> > > How do you think it should be handled? Is it okay to do this like the
> > > code below?
> > >=20
> > > if (unlikely(count < request)) {
> > > 	memset(new_slots, 0, request * sizeof(unsigned long));
> > > 	mas_set_err(mas, -ENOMEM);
> > > 	return;
> > > }
> > >=20
> > > [1] https://lore.kernel.org/lkml/20230810163627.6206-13-vbabka@suse.c=
z/
> >=20
> > Ah, I see.
> >=20
> > We should keep the same functionality as before.  The code you are
> > referencing is an RFC and won't be merged as-is.  We should be sure to
> > keep an eye on this happening.
> >=20
> > I think the code you have there is correct.
> >=20
> > > >=20
> > > > I don't think this will show up in your testcases because the test =
code
> > > > doesn't leave dangling pointers and simply returns 0 if there isn't
> > > > enough nodes.
> > > Yes, no testing here.
> >=20
> > Yeah :/  I think we should update the test code at some point to behave
> > the same as the real code.  Don't worry about it here though.
> If we want to test this here, we need to modify the
> kmem_cache_alloc_bulk() in the user space to allocate a portion of
> memory. This will cause it to behave differently from the corresponding
> function in the kernel space. I'm not sure if this modification is
> acceptable.

Well, no.  We can change the test code to do the same as the kernel -
if there aren't enough nodes then put pointers to the ones we have in
the array but don't actually allocate them (or free them).  This way we
will catch double-frees or memory leaks.  Essentially leaving the
partial data in the array.

If you want to test it in-kernel, then you could alter the kernel
function to check the task name with some global counter to cause it to
fail out after some count.  That would just be a one-off test though.

>=20
> Also, I might need to move the memset() outside of the if
> statement (if (unlikely(count < request)){}) to use it for cleaning up
> residual pointers.

Outside the "if (count)" statement? Yes.  I think you have this above in
the "code below" section, right?

Thanks,
Liam

