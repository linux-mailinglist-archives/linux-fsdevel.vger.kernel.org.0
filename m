Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD77B6E99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbjJCQeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbjJCQeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:34:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5791;
        Tue,  3 Oct 2023 09:34:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DtsbN031033;
        Tue, 3 Oct 2023 16:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YvFXw4l2uRbbw2t4kSqgMx1RSmdkTsGDdZFBDdylil8=;
 b=Y/iFPSRPnPIyKmQYSjl4h8idMBZHZEBg8wnCpYx4HOiqk3I3EnvMxlwFhoOFUCioAKyN
 woBrBVdL9d1u5tflk8ZIyeneQXfw7tQYonTVvSgQfsdcWOhh+tlWwswastjMxMkCeS3m
 aJmzm8YJO6asUXKPO7/BNFMt3wHK1BcKyLSyA1MmONmoKCxWzh3hjFxEzho4x2gmM7Vl
 9yzHoiMn73i7jE+bpeCEEiBWXg3iW9MmBPbn2gCa2i0oRb9y7vEzJet2aM3+0aIBY802
 NDZPvWdzgpKdyRE5Tr1wZ21+ABfDieS3DRV3L4EbvBAjv1q4LGy7pHh9JyPsxid7E2qE CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbw4nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 16:33:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393GWRFd003078;
        Tue, 3 Oct 2023 16:33:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea468mxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 16:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cer0HfsmvxqsRoNK5vprrf4RNZzWdhktyJmDIUXY5K1b+lrsdIxCoJhkP0SdVvcVlDu7JP0FNuSUb6SQJ8GStLkCrZg8SgqDAXoSDI0jmZur+mQgvQk0OAcyvICTbEzFWowy93BGGfxMG7Yn1LdJHy7NFONxx7LICPP8PMq7M6k/JwNQkAbnPotmrEW9m7LAulBWywghlS0XeEJS5YrwvaL7jW3D+JxWBnctDtrPfLQS7x9vhNttK3JlVQZ4NRISdsIK9BuVFqPLqK+bKWYhEOd5Wtw6615h8I4oNwIaR6ikW25SuLVcHkW0VsxuhzzehKh4fVys+5f8noST0uIAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvFXw4l2uRbbw2t4kSqgMx1RSmdkTsGDdZFBDdylil8=;
 b=MUZB4zPaM4yKaPNs3rEzQcOAyTWIaLF3XdUaWogx9lTQa8w6OUoekYnDrkoBu11Dn4WstN11gYIEcHFSq+14YxB3FgLK6r/9hcuL5ccSWZ9wqmbpgfI/kE4kGLyIsd2MLnJD1ZxSe6n5OZHFrEDr11dH0nkdPEljhJLxdby2VZ2SDvfYg6kVUWoEUBmtnr+pm09V3kqmggtYhZJg6U3EY8UqOnnHdMQW/h85o+A1R6ZKKnZABrKAmoVDcluzRMfZyho4XX9qryqSIok7h/o6+4UGawpHc0X/zW12QDoVEQeT2Xi34+HusthAn2jkxKJR/LXffEdOxQ+eQEdwC2w5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvFXw4l2uRbbw2t4kSqgMx1RSmdkTsGDdZFBDdylil8=;
 b=WC7lrVqCxflZWOqr6ykX1yhsTMZt2Q2zkpLCgmF6a3ZuSCTHdwZApu+hirI2bHKkP4p3Uu0ByRkyjofZRG+eBqF4XZAWI+mc1N0xDDliz7N8aV0CRPW954yg4n+9g8nDk71u2KMwSGdvcT42aVMcl9/naqhkNDWdoLanGKQ8Tgw=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 16:33:34 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Tue, 3 Oct 2023
 16:33:34 +0000
Message-ID: <8987d773-27cd-4065-9f9d-8bd8aef78100@oracle.com>
Date:   Tue, 3 Oct 2023 11:33:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH 47/87] fs/jfs: convert to new inode {a,
 m}time accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jfs-discussion@lists.sourceforge.net
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-46-jlayton@kernel.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230928110413.33032-46-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:610:54::40) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BY5PR10MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d43437e-ea90-41ad-0f28-08dbc42e7c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdi/zkagQeVznBy3eiZBT1DL19QykAKNemaYztfvD5ays8RODVei8A//Ov4J6grnSRblXcX9JdJCWMgpzPfenPJHpYDazCzE7SG2XRDIbywQfPGyIs2u29Njk6DbnwdRGxJOfVB2z8Zx0jdjSmQT8etHRV7doy6yTKtOrGLybWLcg8ryOpT5vXOdD2sT5wTS4+624+tusePG/JjHGssrt9KYr8MmIAzNG/tK75RtjRyOIT8Zj53sI435qOdMzEbqTL5892verhA08K+g5pKEZ2/braSOX4B7N25JFAVtnEABNTRnM0LtB9dg5LSFsBTNc6UPyTD0OJ3Df7Sl3eNOpb8i+3AWDkOgZAEpD7bKmPwS/EJ26CBywDyuUoYYw5cbUI26cbxil7jxJT7woJkrmdHfo+QRuMa3Ae1yvoYY88csdyKWP32ckYPQYY7Mn3bUHo5E+EZHA/6zLRtoPXdx00/x38+AP8cJE8kupGsHGuGznOGkuCKohgD9v/Hj3eq7gyAs4SJgg30e/jCHygmxTouBzBHH20La+LPFL//nSK9s+amQhBTQJl3eLlqinH50q1BD7WY6zWzm9CLcywKdpCLElEfwQoX6teHV3ZL2Z5HggTJBlOmMzYB0abCz1l9QzLKK35CEzE9bFNpn3dfAIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(5660300002)(26005)(6666004)(8676002)(4326008)(8936002)(31686004)(478600001)(86362001)(31696002)(6486002)(38100700002)(66556008)(66946007)(66476007)(316002)(110136005)(6512007)(6506007)(2906002)(36756003)(83380400001)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZStlaXMyclBMaGNRVlJvYll0bjk2enVsVzlLV05Oc3Fzd21rNURLVlROYi9V?=
 =?utf-8?B?L3NkckRsUldId2JXK2s2T1lLbnQzcVF0SEs3RGVkMGFaaGtITkZxQk1tMkJN?=
 =?utf-8?B?b0lqZ3Z6bEw5dVFzZ1dNRkd6cDJHbnNZRzVXcnBqVlJsb1Qxc0hwdGhkbklq?=
 =?utf-8?B?TW8vbjViQjZWdkh0cFJ0TGx5QTRWeTBQWkpkemZkcVJkNEZJK3FBMGtiZlZE?=
 =?utf-8?B?TENWd0RsMVVBUzByK1U4UFhRcVlUMHpGY1BRRTUvdWV1eW5aYmt3QUV3bnBN?=
 =?utf-8?B?TGxhQ3BJbnA4d2RoRHByVGVGWmE1UXMzcExGM01mZ1ZoVXFUTmJZRVgyK1JE?=
 =?utf-8?B?MXVpOHdzcW14MC80ZHZ0K1RYa1R4S2RjNkNZUm05bTJLaEZpc3NVZUFUajBy?=
 =?utf-8?B?cC9UZ3JuOFFvZmwzcHQyc0wyZVhtZEJ0SVJ4eVI0UndHUm5CREprL2s1ZkJm?=
 =?utf-8?B?SVNVMW9rekRTUGVvampZUnYrbVRlWHN4TERRT3VNcHJpdXdsSGRId2hZREpx?=
 =?utf-8?B?OHVlMXFrcEVRSGIxRURmOTlDb3hLbklsd0RwL0J2UjJhb21KWlErNHVkaFFi?=
 =?utf-8?B?eThmekVJUHAwYy9XOWhKaGR5U3JNeXJRT3FNS29Gc215djR0LzUxZTNWaERW?=
 =?utf-8?B?V1BGUG02M3NESUFhYkM5V1dmeUhxbjZvTVRwM1F3WFE5SXM1dFF5TXYxaWhj?=
 =?utf-8?B?cElyR2h5aHA3MzJDRkkvMWJDbGVVNHBmcC9SN1NJNXczc21rSW5oY0VTcEVq?=
 =?utf-8?B?TWZERXpsak43MXVieE9yNDI3d3RGZjFtK0hKZ2UyWnVqTjVna3g5S2tBU2sy?=
 =?utf-8?B?VExpeE5lRUlOUjNqWkNoR2drTFVqOFdBZTNJLytuMmFpNWlYZmFOOHU3NXd5?=
 =?utf-8?B?RG1WUlRyVlh4NGpMVy9zNEFLMVN2cmszem8vQUhMNUdvenM2RHpPaEZGbDI5?=
 =?utf-8?B?VkNhVUcwdXB5SmhJcnRTZzVuREhGcHJFdnU3Qm9FQzN0dk1HV0tTaW9Zc1Jv?=
 =?utf-8?B?UVgrb0kyVWFiOXk4SHA0RXpoT3hxTFpnZTd5Nms5MmNvTTZCU1htdUk2Wjdi?=
 =?utf-8?B?RU1TS2JiaithbnhYdlVZckpBZmtnVzBJOWJldUV6NUtrelQwV0JKWnY0eTRv?=
 =?utf-8?B?dm9ldWw1L1RRNFBDWXBDazZTRDlUZjNBbzE1RFRLK0RmYlF5MDd5ZTdXK2U1?=
 =?utf-8?B?WGdSVEJMSXdqeEZiQXNEb1E3TjNwbGhkaDEyMEx1a0VsNWhJWlFwQTBseDhC?=
 =?utf-8?B?a1psRkxhOEgzL1A5MTk4VlJkUVZwOE5hNXBXejF5NTFYMzlWd0Y5Qi9MUDY0?=
 =?utf-8?B?UnBJL2tBd2U1WUk1bm8ycTVvTW14bC9jM0VZY0xsTmJWbjc3c1MzR0xKbklh?=
 =?utf-8?B?Ni9UN0JJM2FYRER5YVQxUlV0Q2g3dVU4cEFsRjFzZ3BQMndiaDROdWxIYjB0?=
 =?utf-8?B?NUd2clFZQmxaR25qSm9LMmZKa1VGeDU1VE1RRi9RSzZ4a25udHVxSHNPY3pH?=
 =?utf-8?B?Vnl4a3hzUW1FcTVNL0pmYzUvRG9PaWw2SHZPTXF0U3VRVnRrWUZBQ3M5OUNY?=
 =?utf-8?B?WGRYVTdYUGNQVHc0SXlxd1BNaktNWXE5UzAwdC9kRTYyQTB5MERiSTRnYnlK?=
 =?utf-8?B?TElDUmN4QzFMQ3hVTEtGcTFuRVNMaUNKK1NTY1RiYUk5dWlQYzVpSWNvTENa?=
 =?utf-8?B?ZmxLZW5xWjNGbDFXM0JyT1l2ME9LLzQ2NnF2eGVjSWF4d24wZ2s4ZC9IWUd5?=
 =?utf-8?B?dkxqQ3FsMUdzTGUwdmx0SVBTdmxLMjNUOUlPcklyRHVReFNpUEJzdjZCMHNl?=
 =?utf-8?B?aWhPYlM2TXRyU3FQMEg0K0w1bzNtdEV2M3dFUWZMVHBtY0JZWlFoR3NZamF6?=
 =?utf-8?B?eEhIdUJ3LzJhUW5pckw0QVd2dXNQcEdUdWlwWFVkNzhiQ1JKSkcyVVdHU2F5?=
 =?utf-8?B?V0RkUHYxdDRROTFPQ29jYXRBQW52MkI2Z292ck5XcWxPRmE0a3M3WFpteXJV?=
 =?utf-8?B?eUJQZEFFMGl5YUxtWDM1MGZaclQxemtyVC9pK1I2RjIvUVlUOW1WcHNtUFc4?=
 =?utf-8?B?YTQ5WWlPeDJTbC9sS0ozVFBqb1k1RWZLUUxFdWQxakcyRDZUdHJCWlhLTlpU?=
 =?utf-8?B?cFlWTlo2VmlwWjkxZW5Qa2JhbzhJSkJ6NzNsWlZSbERtY2hZWDM0Q2pucHFJ?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n3yK3yViaRsOd8hqYqKdunKrheKG5WhdZnpAaBKXr18aK3FvbjszeBJ54hPE2Es7pIZctOHAyuPBSinempseOwtAb5pd9PHQH1XeNijBehYDEy3aueHUhwg46IzVAffLqFrUDNoMlT6Kng8k6LSLeqY/NqsF84U5WEKY1Qg9iyNqB6cMQmm1TxBJrr/bcblGx8Aho+XR4W7dmB5rP/VYgKsly72EnqnR5yX9EYveyKrd4FlyFYfILPFaoqcBWT7uv0gIvGhe5r/lFcN8V2/vAF/mqLOW81C06oYqbSdOC0+eh9feYgLjy9M0UKQKG2a8mjDK9JCHdY0YR/KamPb2DZwqLas1pSpz3KcrMxq66vauWGWR/GZze01xx6WXLHa15H3xmb4LkWG6DCClGDywVQvaiiknf7NK77QHQB/4WoDXI8XAhCkC9xGoxa56X/+97lMGDrUJw6uPtqB+B4+jrURFjlb1vSjm3YOoRMnbKJr+megwbhjTc2D29zu01JKKB3UlKflVcJWhIRNNyRKmvlJTFIJjZljTrBrzNgsKR0hEEb4heXsygLldQS+o3OPp5YTD6de6pjTmJ7yXru5JHhzW7smhvbuH/ZlgTDq8N23SUHEFwwuq3s9lhlT95QLeme4obpRvdSd4KuiIpL195bG+ze40JYk6UU16pWbntHwn7M3a1Qi9DrnhTKy+PbavPMQMYt5CJm7biqq8YattqJR73Z7eIrEavUiBgyOQFSd8lrGOxcsxVtR0slUjbNL7OfCseDr7AnBMYjQdxOdVLQxVcaxu7/4ugJw7HWoFVt7B7zhiizNv3GpWEaA1XLnP52BV5iHsuv376oPk98q4ew1Y+6VudhJNsNQHVlprO1x0h2Ei7FrFePBX7N5ZI8yiSqH/2d8nqc7o68C/B5jExw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d43437e-ea90-41ad-0f28-08dbc42e7c5f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:33:34.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lDflHh2445DZqoqf5oZ/mJMZKWHPDcCZhIAJU4MS769bBxORXWPuPdEnqXrxA9OCbrWFnTkIAgt4Mjp5IAXxaxUktCo7Tm8MM+8fuT4JIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030125
X-Proofpoint-GUID: 800qxGLq_0M9QRvGLkwhFLhhEm501LCG
X-Proofpoint-ORIG-GUID: 800qxGLq_0M9QRvGLkwhFLhhEm501LCG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/28/23 6:02AM, Jeff Layton via Jfs-discussion wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>   fs/jfs/inode.c     |  2 +-
>   fs/jfs/jfs_imap.c  | 16 ++++++++--------
>   fs/jfs/jfs_inode.c |  2 +-
>   fs/jfs/namei.c     | 20 +++++++++++---------
>   fs/jfs/super.c     |  2 +-
>   5 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 920d58a1566b..1a6b5921d17a 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -393,7 +393,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
>   			break;
>   		}
>   
> -		ip->i_mtime = inode_set_ctime_current(ip);
> +		inode_set_mtime_to_ts(ip, inode_set_ctime_current(ip));
>   		mark_inode_dirty(ip);
>   
>   		txCommit(tid, 1, &ip, 0);
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 923a58422c46..57852a515660 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -3061,10 +3061,10 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
>   	}
>   
>   	ip->i_size = le64_to_cpu(dip->di_size);
> -	ip->i_atime.tv_sec = le32_to_cpu(dip->di_atime.tv_sec);
> -	ip->i_atime.tv_nsec = le32_to_cpu(dip->di_atime.tv_nsec);
> -	ip->i_mtime.tv_sec = le32_to_cpu(dip->di_mtime.tv_sec);
> -	ip->i_mtime.tv_nsec = le32_to_cpu(dip->di_mtime.tv_nsec);
> +	inode_set_atime(ip, le32_to_cpu(dip->di_atime.tv_sec),
> +			le32_to_cpu(dip->di_atime.tv_nsec));
> +	inode_set_mtime(ip, le32_to_cpu(dip->di_mtime.tv_sec),
> +			le32_to_cpu(dip->di_mtime.tv_nsec));
>   	inode_set_ctime(ip, le32_to_cpu(dip->di_ctime.tv_sec),
>   			le32_to_cpu(dip->di_ctime.tv_nsec));
>   	ip->i_blocks = LBLK2PBLK(ip->i_sb, le64_to_cpu(dip->di_nblocks));
> @@ -3138,12 +3138,12 @@ static void copy_to_dinode(struct dinode * dip, struct inode *ip)
>   	else /* Leave the original permissions alone */
>   		dip->di_mode = cpu_to_le32(jfs_ip->mode2);
>   
> -	dip->di_atime.tv_sec = cpu_to_le32(ip->i_atime.tv_sec);
> -	dip->di_atime.tv_nsec = cpu_to_le32(ip->i_atime.tv_nsec);
> +	dip->di_atime.tv_sec = cpu_to_le32(inode_get_atime(ip).tv_sec);
> +	dip->di_atime.tv_nsec = cpu_to_le32(inode_get_atime(ip).tv_nsec);
>   	dip->di_ctime.tv_sec = cpu_to_le32(inode_get_ctime(ip).tv_sec);
>   	dip->di_ctime.tv_nsec = cpu_to_le32(inode_get_ctime(ip).tv_nsec);
> -	dip->di_mtime.tv_sec = cpu_to_le32(ip->i_mtime.tv_sec);
> -	dip->di_mtime.tv_nsec = cpu_to_le32(ip->i_mtime.tv_nsec);
> +	dip->di_mtime.tv_sec = cpu_to_le32(inode_get_mtime(ip).tv_sec);
> +	dip->di_mtime.tv_nsec = cpu_to_le32(inode_get_mtime(ip).tv_nsec);
>   	dip->di_ixpxd = jfs_ip->ixpxd;	/* in-memory pxd's are little-endian */
>   	dip->di_acl = jfs_ip->acl;	/* as are dxd's */
>   	dip->di_ea = jfs_ip->ea;
> diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
> index 87594efa7f7c..9137e5d96db8 100644
> --- a/fs/jfs/jfs_inode.c
> +++ b/fs/jfs/jfs_inode.c
> @@ -97,7 +97,7 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
>   	jfs_inode->mode2 |= inode->i_mode;
>   
>   	inode->i_blocks = 0;
> -	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
> +	simple_inode_init_ts(inode);
>   	jfs_inode->otime = inode_get_ctime(inode).tv_sec;
>   	inode->i_generation = JFS_SBI(sb)->gengen++;
>   
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 57d7a4300210..d68a4e6ac345 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -149,7 +149,7 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
>   
>   	mark_inode_dirty(ip);
>   
> -	dip->i_mtime = inode_set_ctime_current(dip);
> +	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
>   
>   	mark_inode_dirty(dip);
>   
> @@ -284,7 +284,7 @@ static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
>   
>   	/* update parent directory inode */
>   	inc_nlink(dip);		/* for '..' from child directory */
> -	dip->i_mtime = inode_set_ctime_current(dip);
> +	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
>   	mark_inode_dirty(dip);
>   
>   	rc = txCommit(tid, 2, &iplist[0], 0);
> @@ -390,7 +390,7 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
>   	/* update parent directory's link count corresponding
>   	 * to ".." entry of the target directory deleted
>   	 */
> -	dip->i_mtime = inode_set_ctime_current(dip);
> +	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
>   	inode_dec_link_count(dip);
>   
>   	/*
> @@ -512,7 +512,8 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
>   
>   	ASSERT(ip->i_nlink);
>   
> -	dip->i_mtime = inode_set_ctime_to_ts(dip, inode_set_ctime_current(ip));
> +	inode_set_mtime_to_ts(dip,
> +			      inode_set_ctime_to_ts(dip, inode_set_ctime_current(ip)));
>   	mark_inode_dirty(dip);
>   
>   	/* update target's inode */
> @@ -828,7 +829,7 @@ static int jfs_link(struct dentry *old_dentry,
>   	/* update object inode */
>   	inc_nlink(ip);		/* for new link */
>   	inode_set_ctime_current(ip);
> -	dir->i_mtime = inode_set_ctime_current(dir);
> +	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>   	mark_inode_dirty(dir);
>   	ihold(ip);
>   
> @@ -1028,7 +1029,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
>   
>   	mark_inode_dirty(ip);
>   
> -	dip->i_mtime = inode_set_ctime_current(dip);
> +	inode_set_mtime_to_ts(dip, inode_set_ctime_current(dip));
>   	mark_inode_dirty(dip);
>   	/*
>   	 * commit update of parent directory and link object
> @@ -1271,7 +1272,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   	inode_set_ctime_current(old_ip);
>   	mark_inode_dirty(old_ip);
>   
> -	new_dir->i_mtime = inode_set_ctime_current(new_dir);
> +	inode_set_mtime_to_ts(new_dir, inode_set_ctime_current(new_dir));
>   	mark_inode_dirty(new_dir);
>   
>   	/* Build list of inodes modified by this transaction */
> @@ -1283,7 +1284,8 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   
>   	if (old_dir != new_dir) {
>   		iplist[ipcount++] = new_dir;
> -		old_dir->i_mtime = inode_set_ctime_current(old_dir);
> +		inode_set_mtime_to_ts(old_dir,
> +				      inode_set_ctime_current(old_dir));
>   		mark_inode_dirty(old_dir);
>   	}
>   
> @@ -1416,7 +1418,7 @@ static int jfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   
>   	mark_inode_dirty(ip);
>   
> -	dir->i_mtime = inode_set_ctime_current(dir);
> +	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>   
>   	mark_inode_dirty(dir);
>   
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 2e2f7f6d36a0..966826c394ee 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -818,7 +818,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
>   	}
>   	if (inode->i_size < off+len-towrite)
>   		i_size_write(inode, off+len-towrite);
> -	inode->i_mtime = inode_set_ctime_current(inode);
> +	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>   	mark_inode_dirty(inode);
>   	inode_unlock(inode);
>   	return len - towrite;
