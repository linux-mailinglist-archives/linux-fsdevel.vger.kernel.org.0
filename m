Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D559A0BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350085AbiHSPod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350084AbiHSPoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:44:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF8104B2D;
        Fri, 19 Aug 2022 08:42:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JFfjlx011327;
        Fri, 19 Aug 2022 15:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4ifY4tzloHSrsI1ARlF14N/ysCWoE9WUdO6rM50eBMY=;
 b=E3U/dqamzhf3mH0RpYY/FXGS9TnzJj8K/6m874zwo5QoYmL43OyxW44chFb8GZX4kIpG
 JrfI6/AUHld7i0tQSPbTQQtFi/ZYrJzL0/46Y2gkRP9gdQilhlh+jWsScME5m5JmS3N+
 4vpbHavIcsRH3HJRH1C+tiOSPRUJaG/y/t4XB/Nho3wzPCUwGkO/eb/LCba1YAWZow2y
 N/IyGjZNCXfq7FNtlHooGNlwSIG5jNIIhq0OCGbjjmvdyhNVbXqAteHimusbXMf+NvOj
 B7VeRYl7K5xBtwBphjp1hxT89zfe3BD4/2my+fTIdVvFmY4ynVK691TeSpCedHSdiLxh aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2dbqr05s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 15:42:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JDppGg020800;
        Fri, 19 Aug 2022 15:42:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d5k5yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 15:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m06RnNsgi6SW2p2L+TobrgyVqyReWGa5PVNpaFlb7+TVpafsdeNB2fH1007HDmPhhkRKJ2ae4t4z29bzYXEF7tVtd9Wi2Ewz3+hDbT1ZIZzxm1In8yhmL3xP+qDn17z9bEXfp+GqYfdurc/YY3Riq8UfAfbKyoWWgofD0+fS8SJ6LJt/gUny6LttQpOuZ0YAB/YvoBmNskpB5epKOjgMftvE5b6DNAYfCW2RjvBR9QhIYinzf9JbnaQBjeJDsP7nS7p+rvRDjC6jnmXMML/DfWGMw4in2pK5MceRfryZ2zRR1UMwoEpAuQ3GgOriM5yym60bc7XlJalrDgoR5I5QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ifY4tzloHSrsI1ARlF14N/ysCWoE9WUdO6rM50eBMY=;
 b=l729TCPaBeM53FWzOlnMwfloTCRCGtdBNSE+iTO6lTffpC4swOR12iHqna7IKeoarDgu8Y0nyQ9kegOdXrgQg4mFVQ4otdWif4QEODFS/5IAhUQVfcUqtOW2WaYueaU1jzRmXm4+uen4s9FNvouxaPZy0rwO/kA5Ahx35iiYiofR2p971eaRQowtwxXkYF/o3CSD32b6k6I+1SUlrJZbJ+Ac0nv9IJmIuDl6hi40Bf2xh+05jx0DZaZO/Je1NtRSd5sm/WnURhoUm+O4LBcNlmtQh6MGQ9ArX69tbR1OrpiIDVQEQabvKHoLlvefvbw37dBUusv8TT8uwC19PWeu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ifY4tzloHSrsI1ARlF14N/ysCWoE9WUdO6rM50eBMY=;
 b=wRrfNEq41qyGzA2zeAb0U7Kofmxr9INCySTd5Bs3MJs0HCGs1nPpdHCDlA+H1jramfMdy/F5RoOcGa5tG402azq3vA7F0NWlEy62K+LeK2T7QJK40kClQi1j3sy7tE7T/e/WLRUPzwLtORifRIdsmKBqMzGm34EfjVY7ihAti5s=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 15:42:19 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::d90f:4bba:3e6c:ebfd%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 15:42:19 +0000
Message-ID: <debe59b1-35cc-c3b0-f3ca-76d6a56b826b@oracle.com>
Date:   Fri, 19 Aug 2022 08:42:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <Yv1jwsHVWI+lguAT@ZenIV>
 <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV>
 <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
 <Yv3Ti/niVd5ZVPP+@ZenIV>
 <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
 <b7a77d4f-32de-af24-ed5c-8a3e49947c5a@oracle.com>
 <CAN-5tyH6=GD_A48PEu0oWZYix4g0=+0FwVgE262Ek0U1qNiwvA@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyH6=GD_A48PEu0oWZYix4g0=+0FwVgE262Ek0U1qNiwvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcbb4ccd-6ff8-4e8a-8a27-08da81f96676
X-MS-TrafficTypeDiagnostic: CO1PR10MB4772:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tEcXmhSvlrXayLP/W+cFGXbfFEtrqLgzZ3fSgUzPRA3Bpc1hjsiOOCOCvrNIMaL3XcRcniUSq5BYum2pVqrE0grkyCSZB6PvuT/hkJPANuMgpt7clH6xNabvE94V/MTWieNdkfQDacsKarU1m42inqDYKJktUs+gJgqi2rMOgMiPMPniNzS0mP98ZjV/E9ruGZEDIPk9yvnz9XUmFqKXzmELBoMjFARsLRTGA7kdgySWAQ4rfeNPtWKQdeokqfjpkmWP/+T8b2dMp/VSxLzNR02NJeA8mM4//4ISaNYTbUFqfAjn85vAMJteEO/kBP2sevVAbVCPJTCx5C90ImhG9ryJ9AaWgtwJnOFK0wYxxXuBLj3eovs4JtK4+H7+Tm9lHFHRgLTVthTkmRicNcwXaaqZTV1fMza6WuHu6khr7SCVgJqy5IcYcmvVEK6sK38xquJZdmh1drrvKtnI/sNa+JSiVLpvH4WfNra4RMyydxeNOGSfoCBNgpylDdsS7fXTyAZ33G/yyP4uV7RwWOdIW1w5Qz9BI9fwd3guoh4PpTr+iPpjt3TDyF4bsEtQxXUUkT9cqw4Exm5HFlbiqguMXklnnBcM3groPlW1sT4MJ1sJ47fXnZMyBxul2sJ2OlAAUIPf8I+ZUTMWYG6i2Xv6FPxwRDsLIwNfLBVxnQDHx06vTITj0RkpnGODl4B0OZf8erdTHhrKulMD2IAtUk8hvJYXGtoKkL9Sw6yl3MbTA0ItlN1wGGHdumc2rFX8OnW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(136003)(346002)(39860400002)(83380400001)(54906003)(38100700002)(6916009)(41300700001)(6486002)(478600001)(8936002)(316002)(5660300002)(2616005)(186003)(2906002)(6506007)(53546011)(6666004)(6512007)(26005)(9686003)(8676002)(4326008)(31686004)(66476007)(66556008)(86362001)(31696002)(66946007)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpyR2tiZUZNK29LVW1lVG5yU2Nubk5DSzJQQmhNSHRXQjhEQVBmSy9UdFhO?=
 =?utf-8?B?L1QyL1U1bjMvUWc3SFJVRk5QK3RtVW4xMUlOYm5maUNPU3ZzRnFyY1A4OUJl?=
 =?utf-8?B?Z1kzVzVhRVpSK2ZJZk5BcXc0cVVaSDJWcFRMM3IzbEhQbTJEeWtzb3BrWFdh?=
 =?utf-8?B?QS9mOFptaGtNNWw5NlpCekNkR1FGTWRmcFJiL2dQWGs4QkNUNUFnbGdRalYw?=
 =?utf-8?B?WWp1aW5xdFlOKzhhdzlORFBMZE4vamJmU3AyYUpPZGF1WFJOVVd5cjRJWk1H?=
 =?utf-8?B?KysySnhMdUhFamZOSVpKbmdMYTBzdW80ZFp0UUtabDRzVU1LU0pRZFRpN0xi?=
 =?utf-8?B?NGYyZ2Z6VDkyTTFicWEzZmpoaUlzUlNLRnVRRDNKaDdYSDB4RXMyWnNMZHBw?=
 =?utf-8?B?VExYS3U1YW5xYkY2Wmc0bS9KVjBqSmN1S3hpdDVzRkhjZm02SnpqWDVlUTlh?=
 =?utf-8?B?NVJaVWlwazNLZEdITXFCT1FiNmRhaW9iUDRDZmpjZU9CZGFjUFVVSWdYWVNy?=
 =?utf-8?B?aTYybngxWFYxK243ZGtvcGpxNUpHYWJTVmxEeTBEZjIrakloWWtmaE9WU1cx?=
 =?utf-8?B?QXVkMFhod0NiTk5EQURMdm9XTkZiSWdGOVdSZGFvYXFIdFo3UlZaMGhBdnh5?=
 =?utf-8?B?YnhadGYxQm9YMVkrSXVieCtzTlpuYy9ueXdKZnhuQzkwdEdodHFHbTFtYUJG?=
 =?utf-8?B?QWNaVW4zWjU5RkZjNUtHMmJiV1RHZkxBbEMxeUh3QnN2QUdlNFFQUjNJQngz?=
 =?utf-8?B?ZmwvVnBFbi8veERVT3dSaVcwM1pzYzJoM1JtbkdmNHdlV0JJYlhPbkZrZUs1?=
 =?utf-8?B?amtJZitEMzg5Y2VNWHVuN2NxUCtnaG45Ri9jS1RJTjJranBBYm1jSkY5NTlJ?=
 =?utf-8?B?N1NHZDh4U2Nja3A5cUxrSG9obWRPbHJkRStQdzhkNTlueUxxSnJPNlo3YzR6?=
 =?utf-8?B?REJjbzYxZmZBVVJ6SzBDT0YwdHZJQllOdUN4K2J6ZWgvT1ZxU1pHbXBvMDlz?=
 =?utf-8?B?RmgzUEhFaWhDWnVNRXkrblpTcVdqOG9BdExxaVdBLzZWaFg1ajA0eDlNbjdZ?=
 =?utf-8?B?UVlPZXpkUnJiOVBSWTRDdlZXU2phTmpUWjNITElvNnNRWlE5YnRUNExZcm44?=
 =?utf-8?B?K3pjN1JFRzdZZmUyZ2VVUG1Idm83M3ZnWlo5b3FmWUlFdzR0b1llTEFaNldH?=
 =?utf-8?B?WnM5akMxdDd2UG81VDBoWVNwWm1VSWFPMUJUVGRvbkZKMkFDYTlaYVMxNzhr?=
 =?utf-8?B?SmcrYnRGQ3MyT0ZUZk14b1BVMW4waWlnQUdDMXl1U0lIRUZmRXVoSWg5RC9P?=
 =?utf-8?B?ZlM2cDlYc1N5czdsZkNxZ2JWZi9lOU5sUVQ4NHBqMWgxR0J0WDk4MnNHayt2?=
 =?utf-8?B?ajU5NllXeHFwUnRlMy9VOVlhS1ZUaCtpMHhsYUErTUtXeWdXK3hMcXIxbDBL?=
 =?utf-8?B?MVNGMzk0Yy9QVVpWNlJrelRuT3RWejgwMTZzWktxTVQ5YkUyM0xTWW4vMmdm?=
 =?utf-8?B?RWY4bWFSYXBWemxQWWtjRm5xcytxN09vSW9JdDVROGhaY29TMUIzYWpVc0xN?=
 =?utf-8?B?WXZYbFZzZEVCa0ZPVVRsZlUyZzBRRlNwWDR2QTlsR0NrU1lGcENqcDVQc3ox?=
 =?utf-8?B?YVV2ait6N2ViNmZjVnpCa0dVOU1xdnNVZ3hqUk02ZmlGZ1ZNQVlqNGJqdmdj?=
 =?utf-8?B?RWY0OThhL3c0Q3NscldNbUxCYXpRNGRPMS8yUzRua25hQk42c3YzUzk5Ly9T?=
 =?utf-8?B?L0Z2UFltZkV5bUNvN2JuSWlaUjU3WFc4dUIyTFc3ZVpseWpYNkVYR0R0MEpJ?=
 =?utf-8?B?L011SWp0bmxPK2lnc1BISVhMVDBVb3lpdGtRMEkrWGZudUt5Tm5uRm1KbUZX?=
 =?utf-8?B?NDVqYkhYSUZwaXEzcFlKeUtvK2p0RktQb08rL1pBeVJ1UzhXRDNmY0JFRWVY?=
 =?utf-8?B?NVFveTRlMmgrQzJNVUdLaUFwSkFqdjY5ZmxEazNMN29Qd3BwdEo1WEZnajRR?=
 =?utf-8?B?QzJTTzMzcnkxSEZZMDlzQzNJL0Y2OWJHdDZQMlN1R3ZlMUdjbkhNWExFSk9a?=
 =?utf-8?B?VFdSckpFRnYwZnV3WnhOcGh1WnpyTU1jNlF1aTU1Snp3YlRKSjJidjNYT3cy?=
 =?utf-8?Q?LDUt4o+79z8xlc53x8A9ThXlX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T2UwNkdGKzF5dUNzZ3RXV2swekxDcWkrZXpTbXVJM0Z5ZFhiaG1zeTlvUk0y?=
 =?utf-8?B?a2cyUThGSE1tMStDZUdKTkZwQjlUWGdKRjd5VXFRSy9FeTcxWmw3emxQdndR?=
 =?utf-8?B?NEROWUdRRkFRVUxna3JSUGpNajdQdE5JUVdRdGNJTStvRVJqcmNnOEs0S1R2?=
 =?utf-8?B?R21aeVU1SnVDZklvOWwzc1krcm9oSFg4UzdmLzBta2tFRG1DalExMmdZUVNV?=
 =?utf-8?B?Q0d6eWpzTWVvK00rTXdQcGlYbmNQb2dFWE9rTElLcHBBSEswcHoxcDdCTUV1?=
 =?utf-8?B?cUJ6Sjl6ZjZKNWJYdXJzaDNqbGJ5dWdDeTF2bGcwUjNlMFpReWdWUzFLcTNm?=
 =?utf-8?B?VkIrTXUwUWhRRHVHaHMyNUJMeHR1RHFBYWJ5RTFKWmdiQWJSd0pPLzA1VUFs?=
 =?utf-8?B?RjFVU0NtSVhCeVowWStFajZ6VnZQYVRMYVVJa0M3Yzd2QTBxM0I0SWh5Ri9E?=
 =?utf-8?B?WTRFemZUS0NzeVVCL1N4YkEvWnhOL0tNeXROV0w1aXpTUFA3eXV0bWxQb1Bv?=
 =?utf-8?B?SGFFZG1CTWlQL25STGNOTDY1b01keXNVM1F2ZlU3VEg1RVBRZ2lOL0Z4dUl5?=
 =?utf-8?B?ZG1ndWNCekJmZHZhZE8reWhlUEs0QUNFUWJyS2Q4bUxaY2l0OTZJL2pxMnV4?=
 =?utf-8?B?SFY2VEE5ZUlVVDQySDJqSzd2cHA0eDZxa1V3TDczYi9zNktYdE4xVzN4bWdy?=
 =?utf-8?B?blFrVXVJT0YrMVRtOVdPUVRXWHhHVUVJTEUzaHh0WkZROU9qRyt0Wmsxb0p4?=
 =?utf-8?B?QjArMGg3Y3owTXFTeVlhR0JtTEwxOFJCeDJ0ekVjZTRwVENLQlVYeTJjYVdo?=
 =?utf-8?B?b29ZWFJ3ck8xU2JFRno5aC9FRHFacjBwZGJ2bHZobUZGa09jMGgrUjV0QlZG?=
 =?utf-8?B?bWY0WUoyWHJEM1FteVlXWmNsbVdyejdic3A3TGxja29XRWVIL3pDN2dNM05u?=
 =?utf-8?B?dGdPTTlGU2h5ejZuV0k2SHdINWtYK1pFMDJqekRJZ3hqQU5Vd09UOHR6T2Fv?=
 =?utf-8?B?NjE0aUxpTThEcHJnVFQwWFc4MEJFb2dQSDEzUDI3VXN4MU03U2JsczV2N2Fl?=
 =?utf-8?B?MXlqZE16VXdqTGRwS2NBMmhGb01iZnFrVGE3L0ZUNFVmcitkNHZEQXJGd2lP?=
 =?utf-8?B?MHZacXJWb2NOVWlDZGdnSmN3bjErdUxNWFJ6Ny9UZG8vZlpVRW9KZE9qQVlF?=
 =?utf-8?B?SlBsVXhqU05KZjZwaWoyZ3cwaldHSE1za2FJTlNEVUR5QnkwM0Fwd1BJUDRJ?=
 =?utf-8?B?bFZBZ2lmS0RIT2wxN1h4NXFvZkJRQml1SWFQUzJxMFBxWlU5aDB2eVlNd0RG?=
 =?utf-8?Q?yVKP4FvDrcHj0yVZocUexOAKSiUSVRrBnE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbb4ccd-6ff8-4e8a-8a27-08da81f96676
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 15:42:19.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40gRhBHVqpHHLR0ttwOFSazD72BdYSd+0vP8i3w+am1e2t/4HHqlczcb2B+yAl/j2aGqdcw7O9COogPoRX4HpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208190056
X-Proofpoint-GUID: YtB1jyEzQoqpGwVu5BrvzA5fGsnCbjgz
X-Proofpoint-ORIG-GUID: YtB1jyEzQoqpGwVu5BrvzA5fGsnCbjgz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/19/22 7:22 AM, Olga Kornievskaia wrote:
> On Thu, Aug 18, 2022 at 10:52 PM <dai.ngo@oracle.com> wrote:
>>
>> On 8/18/22 6:13 AM, Olga Kornievskaia wrote:
>>> On Thu, Aug 18, 2022 at 1:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>> On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:
>>>>
>>>>> NFS spec does not guarantee the safety of the server.
>>>>> It's like saying that the Law makes Crime impossible.
>>>>> The law needs to be enforced, so if server gets a request
>>>>> to COPY from/to an fhandle that resolves as a non-regular file
>>>>> (from a rogue or buggy NFS client) the server should return an
>>>>> error and not continue to alloc_file_pseudo().
>>>> FWIW, my preference would be to have alloc_file_pseudo() reject
>>>> directory inodes if it ever gets such.
>>>>
>>>> I'm still not sure that my (and yours, apparently) interpretation
>>>> of what Olga said is correct, though.
>>> Would it be appropriate to do the following then:
>>>
>>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
>>> index e88f6b18445e..112134b6438d 100644
>>> --- a/fs/nfs/nfs4file.c
>>> +++ b/fs/nfs/nfs4file.c
>>> @@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct
>>> vfsmount *ss_mnt,
>>>                   goto out;
>>>           }
>>>
>>> +       if (S_ISDIR(fattr->mode)) {
>>> +               res = ERR_PTR(-EBADF);
>>> +               goto out;
>>> +       }
>>> +
>> Can we also enhance nfsd4_do_async_copy to check for
>> -EBADF and returns nfserr_wrong_type? perhaps adding
>> an error mapping function to handle other errors also.
> On the server side, if the open fails that's already translated into
> the appropriate error -- err_off_load_denied.

Currently the server returns nfserr_offload_denied if the open
fails for any reasons. I'm wondering whether the server should
return more accurate error code such as if the source file handle
is a wrong type then the server should return nfserr_wrong_type,
instead of nfserr_offload_denied, to match the spec:

    Both SAVED_FH and CURRENT_FH must be regular files.  If either
    SAVED_FH or CURRENT_FH is not a regular file, the operation MUST fail
    and return NFS4ERR_WRONG_TYPE.

-Dai

>
>> -Dai
>>
>>>           res = ERR_PTR(-ENOMEM);
>>>           len = strlen(SSC_READ_NAME_BODY) + 16;
>>>           read_name = kzalloc(len, GFP_KERNEL);
>>> @@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct
>>> vfsmount *ss_mnt,
>>>                                        r_ino->i_fop);
>>>           if (IS_ERR(filep)) {
>>>                   res = ERR_CAST(filep);
>>> +               iput(r_ino);
>>>                   goto out_free_name;
>>>           }
