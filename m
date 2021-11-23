Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC64245AF6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhKWWxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:53:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57226 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhKWWxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:53:15 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMexiQ023235;
        Tue, 23 Nov 2021 14:49:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=VPUw1cqUf+nw7ZyTOj+GohbTxa4/MixmiasZHJTn3I8=;
 b=MT6P2ZR8MN8g5GXA6z+z4Mof2gc/0+myrsDRzbz0HKc8C8ewPfYsGADllYg5Eoxa6kYa
 pynLWjZD4Dsh/9fEyzjjNP5WokOznZYA12pHBpQV5jwXb+IhsVgynUD2QdcJUGpzzJuV
 c3NX/EAZJHX3FNnwv4p2YS5xhp+qycFSwHw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0vt41e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 14:49:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 14:49:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPo8LZYa8eq0JMTPF1AtmCCZqN0mtgw5LRaJ0tbO0NrJApB+A0V9UOhi3/e3iSzscD2Wu0X1ae0YowNEuULtp2RMCdxt5lvaiUscg1K6X/6WE9k+EBunz4XFCNgyTuzAWC/qz4hOj6ZkS45CYek7TbQVPrdF6KVhrE8Eic+6zZy4S/W0qSvNbHYeit67H8QXPpAtittCTF01nHwG/2JNOwMl9XwT6JDFLwbLrEmmlBFICSp6JC3b6kUuhT0KSHErbkJeYsllu3qFESF9KCo1hrI8LQa8jL9yQNCQMy6npOf5Xd1bhd68QjQraI0Iq6bQcdS6RoSTcnzNfsKotYd7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPUw1cqUf+nw7ZyTOj+GohbTxa4/MixmiasZHJTn3I8=;
 b=E5PhKBANMpfwsPgkIaGvu+NZh9GASXubp06G3S4XHC1JLmGvOVNpbKHYFCx9LXwOxOnQyQx6DkJGPxrTYEndRnbfQd7QkuLnrRmF5LBCF501jYK/ZYFF9KUL/wIP2rG6TwwZfhCi1s/EahB3E3N7lHt+K5tRDLMC8AOnjGoi35+vyAnsm35eGTU8TP02q2kxzjP+dwwGWS3vKQZxtN+gJasAhzb3Arf94D/YY1d7xwbOLTbuEXF8Yx7Myha/3NLD7JPwZsCt3q78SI6uR7D6AImBW59k26Ev1G7ZaBnPoEnR5+4QOKuUMYqBJ5B5/LgH4ZCYOqMRvGSZmWCHJqUGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4647.namprd15.prod.outlook.com (2603:10b6:a03:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 23 Nov
 2021 22:49:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b%2]) with mapi id 15.20.4734.020; Tue, 23 Nov 2021
 22:49:38 +0000
Date:   Tue, 23 Nov 2021 14:49:33 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mina Almasry <almasrymina@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
Message-ID: <YZ1v/XtxVBI+nLwx@carbon.dhcp.thefacebook.com>
References: <20211120045011.3074840-1-almasrymina@google.com>
 <YZvppKvUPTIytM/c@cmpxchg.org>
 <YZwjJjccnlL1SDSN@carbon.dhcp.thefacebook.com>
 <YZ1NObN6HkxLwLmb@cmpxchg.org>
 <CAHS8izPVwF7m59UOuYTtGD_C9f5Bm+ErqmvmQ_m4-KJcyLBAhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPVwF7m59UOuYTtGD_C9f5Bm+ErqmvmQ_m4-KJcyLBAhw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8c86) by MW4PR04CA0283.namprd04.prod.outlook.com (2603:10b6:303:89::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend Transport; Tue, 23 Nov 2021 22:49:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c964c65-a570-4ea8-4277-08d9aed3877e
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4647:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4647CCB5F19563035319C871BE609@SJ0PR15MB4647.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bsPX4rnRt3MmzOsp2T3q+qFOIIeYixwX4EKXmUv6tMkgatbHyYa3Eoj0D6wg6PiccSLyQ8SBvbPrMhU3vHOL+be1Nj0AqUc5gh0JZ9t78a+SGoBINCX5w1OhNHvDIdbZH4fCXtrkKHLiQMyg6pK5EASq2IDfBtQZ0+lfhs9XzT3GwG5MCcdwSil7R/hL9Pz2UFO75aLRMM6BTHXLjgMw8KINIf1+lvuf1TncIculshHLPJDnGiJ42ZIac7hpQaIwnZJ7QxVQEu0a945tLZb7FqiyBaybon8hXptWX5erLOZ8U0eNRQcfUpMvRGdwKEadeIoRX6hVmf/sdAjl4zRiIxSPl0mEC38dBWS9ssgpv5VUumrAfUnbECyvicYD2DVupX39M4T8MM9WHqb1+vrmo3Nlso4RNCqLmUi6C2vyvIzrxOWkYFt6c3UKD1YfLb8TeE47qqfsfiAMopkSRGc0NZY16pp3YQxAJicFzCpHa+rQGFiUFoNrrGOuFzJMpIu3BgdEfMr8M9HVjpxejrJevBCRSavHUS0kDz6PVtVUAmtz5TcnfnoxxrTtZyfagHK5Yspc2ypD11jFNebh2nua8+ZzGywHBVVfelPh+9Nd2FhLqy7WkXIgSKWPy46cW299uOk4mm0e38v6gM19rz9c1bv/oOIxqGbA7q0dcejlC18/wvzo7/noQX8QdzfRL3MiTyf/DKJUlIB6KJvfLCVdKvfS4zhNWIHKev+1+gnfE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(52116002)(86362001)(8676002)(4326008)(6916009)(66476007)(9686003)(66946007)(84970400001)(66556008)(186003)(8936002)(6506007)(54906003)(30864003)(53546011)(508600001)(83380400001)(7416002)(316002)(55016003)(38100700002)(7696005)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElKNk1PZTFta3lnWm9saUR6L1gyRHBUZ3lSNVZlaEVvdHNlRXZqM3U4aWw5?=
 =?utf-8?B?ZHpBditaUExnR3k0TmgzZjIxYlNaM2lRMit4WHU0YjN0ZFFGOW9yL1E4ZCtG?=
 =?utf-8?B?STBqVjJWbmRVeWRhTERjZExVYmtUVGc1UkowQ1FlMmJhVk1ZYlJ3Z1EzeEw4?=
 =?utf-8?B?RGtzaVJhWTZpR2p6d3JnWkFvbnBjK2RQT3BscG5VNXdWdUhnTi9mYWZOU3dp?=
 =?utf-8?B?eHdWdmUvVEQ4R2dHN1lHV1lzMTdMdTZJckpaaFJVZTVtVnJjcEVqNEU3UjJK?=
 =?utf-8?B?aWVSWEg5ODY5UkpmZ1JFdzlyempWNWNFZ24rQ1MvSVdlVVc3SHNKdldTQ0tD?=
 =?utf-8?B?K1pNWGtOeXZkRmFDN2piVDdmV3FEdTJKRmVLZ0tDQTJjRVZSeURwM0xzQlNu?=
 =?utf-8?B?bWtGNzlDb0t6KzhtNEtWTzhwbU5yOVRhWFJLMWo2Nm1OamdsamFkOVRObkpj?=
 =?utf-8?B?TFRuUTVKOHhlbWlRRm5NVXRDcnJrUWRXSk1SM3RwZlI5eENpOW5UZ3o1MXRU?=
 =?utf-8?B?K1dKOXhJNVVGQjdZY29od05vTTBmeXR4RjQzbjlqMzltd0Y3WldOa1JnMktZ?=
 =?utf-8?B?N3RhM3VIRlBSWGlTSmlRazI1ZC9Ec3QyaVBZcmtxMEc5UVNUK0NCMHVHNU9B?=
 =?utf-8?B?MmhJUnowb1I2cEV3ZCszcE02RmsxaHc2aHdnNWJRVkJ2b2VIMlZMLzhTTUVZ?=
 =?utf-8?B?dW56Vm5DTi9UdnJuNWR6b2Iwb1NMMk9WY0xVd2c2SWJvSlpIRTZDRE84WUll?=
 =?utf-8?B?Y0dRb21oYldzaEhJK1F4ZlhVdW5VQzJralgxejA0Z3NDb2NwQzJBTUJJSTk4?=
 =?utf-8?B?U05yYXAvNkVrZHMwVGxmeGdOVVVzSXdWbWIyeUFiUGVwSmRsQjJvMzJueGJx?=
 =?utf-8?B?Q2ZiSzBiQVpVUGRpK1NXZTA0VEI5aTFRbzdWci81RDVRK1VCalBEbWZlbU9a?=
 =?utf-8?B?disvdE5QeTNVTmc3YUNGSlZYbW5NZHNXbjA5MnhtWmJSakROck9OQ1VHd3pD?=
 =?utf-8?B?N0hCMmZsdk44UWoxelUvVHJFdTZFRTNqYmN1ZzZNRGxNb213dXZiUDRQRklF?=
 =?utf-8?B?eldUd0xiVkQ5Vkd3Z0U3WTRSQUlMOXpkMm9BRG9OcnkzSEl1T0s1OW9ISVhJ?=
 =?utf-8?B?MWRIZ2grT0FtS0xDWXlmTFdidVV4UnVNelNrNXJUN054Q0pPaEFDekhaKzNQ?=
 =?utf-8?B?eDRvcmtpL3BESkNFZTJvQWoxZnV5OTF6UHFTZjhabkpjUzJuWTh3YVAvUlh5?=
 =?utf-8?B?eVlYQ1ltbDhnT0xQVkV4Z29aMW84RVVSSmh0aE5id0EzWDE3elFGNE9CUGNj?=
 =?utf-8?B?d05UNHVpVURDR09mVVhBT2RkUHFCdU4zK29kM2F4QlRubXRnVmhyREJRWENt?=
 =?utf-8?B?SDg4cUI1MFJmU1RwbkZMb2pCb2xDckhIa3Q5eTFKdWxLRi9YbmlyZG9nYWMv?=
 =?utf-8?B?TGdtMkRyTmErVU94YUV3eVR1MGk2eGQrNlZLMW5qMXRtZ1RsaGlXNGhWeHVX?=
 =?utf-8?B?aFBxVXBVUHI3dktBSE1YVVZZVFlhVnY3WGEzTWxhZ3ZQQ1ZaSlIxOU1OdG5a?=
 =?utf-8?B?SFBaSGVUdFNHaVZaM3VuK2YweHNJck9zSmYzSmtRM1pxRXVrU0dhOFFQbEFJ?=
 =?utf-8?B?bEZmNXhoNDNCWWc3NE9nL0hpT0t1Z0hVdW4yblhVcFZXODROZjM3cUpwdW1m?=
 =?utf-8?B?a3hWVkZHZFFadkVjQXB2Z1BsSW5uY1NLcDRERlZvU01qRDYybEZ6YW44MlNR?=
 =?utf-8?B?REtxOUkrVk53UTR2WVpITVVHS2JlVmNCb0FXRi8xRTI5d200YUNXejRyeVYw?=
 =?utf-8?B?RHB2dWFKb2xUQmZveHRXTVVWOGUvRERzcGEwZEFnUCtMUFhNZGJLUjhyKzc5?=
 =?utf-8?B?N1d5Mk5kNUdRbExmS1c4S0RaM3FSVms5SURSdjVxOThoZ05MUFdUQjY0Y3hG?=
 =?utf-8?B?ZEorbGw3QzB1MGJyUzB5dGxhYXArUGRKaXJ2cWlCd0oyK2wrSnU0OXBpTUdt?=
 =?utf-8?B?dnRpVTlUN1cwUURTU3p6TVJzUk55MkxRdGU2ajZhWXVWWEFYTzdLNERTSnJB?=
 =?utf-8?B?a0VSL1ZYTk5IaC9PVFVIb0J6NnJXdkNyc093VXpOUEVMRklnU1ZXVXd6OC9X?=
 =?utf-8?Q?At+mqAv1ljMymIRXZ1N8vuBnL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c964c65-a570-4ea8-4277-08d9aed3877e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 22:49:38.6785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml7vPee1lAE20B1a8Q6fQBAKh2F6+qYB2y4wxeW7meR7HmhrZCmlfU+WqMfkMLip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4647
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Ioafw1cglpeMl9pU-HfwgykwhgOyD92p
X-Proofpoint-GUID: Ioafw1cglpeMl9pU-HfwgykwhgOyD92p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:19:47PM -0800, Mina Almasry wrote:
> On Tue, Nov 23, 2021 at 12:21 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Nov 22, 2021 at 03:09:26PM -0800, Roman Gushchin wrote:
> > > On Mon, Nov 22, 2021 at 02:04:04PM -0500, Johannes Weiner wrote:
> > > > On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> > > > > Problem:
> > > > > Currently shared memory is charged to the memcg of the allocating
> > > > > process. This makes memory usage of processes accessing shared memory
> > > > > a bit unpredictable since whichever process accesses the memory first
> > > > > will get charged. We have a number of use cases where our userspace
> > > > > would like deterministic charging of shared memory:
> > > > >
> > > > > 1. System services allocating memory for client jobs:
> > > > > We have services (namely a network access service[1]) that provide
> > > > > functionality for clients running on the machine and allocate memory
> > > > > to carry out these services. The memory usage of these services
> > > > > depends on the number of jobs running on the machine and the nature of
> > > > > the requests made to the service, which makes the memory usage of
> > > > > these services hard to predict and thus hard to limit via memory.max.
> > > > > These system services would like a way to allocate memory and instruct
> > > > > the kernel to charge this memory to the client’s memcg.
> > > > >
> > > > > 2. Shared filesystem between subtasks of a large job
> > > > > Our infrastructure has large meta jobs such as kubernetes which spawn
> > > > > multiple subtasks which share a tmpfs mount. These jobs and its
> > > > > subtasks use that tmpfs mount for various purposes such as data
> > > > > sharing or persistent data between the subtask restarts. In kubernetes
> > > > > terminology, the meta job is similar to pods and subtasks are
> > > > > containers under pods. We want the shared memory to be
> > > > > deterministically charged to the kubernetes's pod and independent to
> > > > > the lifetime of containers under the pod.
> > > > >
> > > > > 3. Shared libraries and language runtimes shared between independent jobs.
> > > > > We’d like to optimize memory usage on the machine by sharing libraries
> > > > > and language runtimes of many of the processes running on our machines
> > > > > in separate memcgs. This produces a side effect that one job may be
> > > > > unlucky to be the first to access many of the libraries and may get
> > > > > oom killed as all the cached files get charged to it.
> > > > >
> > > > > Design:
> > > > > My rough proposal to solve this problem is to simply add a
> > > > > ‘memcg=/path/to/memcg’ mount option for filesystems:
> > > > > directing all the memory of the file system to be ‘remote charged’ to
> > > > > cgroup provided by that memcg= option.
> > > > >
> > > > > Caveats:
> > > > >
> > > > > 1. One complication to address is the behavior when the target memcg
> > > > > hits its memory.max limit because of remote charging. In this case the
> > > > > oom-killer will be invoked, but the oom-killer may not find anything
> > > > > to kill in the target memcg being charged. Thera are a number of considerations
> > > > > in this case:
> > > > >
> > > > > 1. It's not great to kill the allocating process since the allocating process
> > > > >    is not running in the memcg under oom, and killing it will not free memory
> > > > >    in the memcg under oom.
> > > > > 2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
> > > > >    somehow. If not, the process will forever loop the pagefault in the upstream
> > > > >    kernel.
> > > > >
> > > > > In this case, I propose simply failing the remote charge and returning an ENOSPC
> > > > > to the caller. This will cause will cause the process executing the remote
> > > > > charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pagefault
> > > > > path.  This will be documented behavior of remote charging, and this feature is
> > > > > opt-in. Users can:
> > > > > - Not opt-into the feature if they want.
> > > > > - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
> > > > >   abort if they desire.
> > > > > - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue their
> > > > >   operation without executing the remote charge if possible.
> > > > >
> > > > > 2. Only processes allowed the enter cgroup at mount time can mount a
> > > > > tmpfs with memcg=<cgroup>. This is to prevent intential DoS of random cgroups
> > > > > on the machine. However, once a filesysetem is mounted with memcg=<cgroup>, any
> > > > > process with write access to this mount point will be able to charge memory to
> > > > > <cgroup>. This is largely a non-issue because in configurations where there is
> > > > > untrusted code running on the machine, mount point access needs to be
> > > > > restricted to the intended users only regardless of whether the mount point
> > > > > memory is deterministly charged or not.
> > > >
> > > > I'm not a fan of this. It uses filesystem mounts to create shareable
> > > > resource domains outside of the cgroup hierarchy, which has all the
> > > > downsides you listed, and more:
> > > >
> > > > 1. You need a filesystem interface in the first place, and a new
> > > >    ad-hoc channel and permission model to coordinate with the cgroup
> > > >    tree, which isn't great. All filesystems you want to share data on
> > > >    need to be converted.
> > > >
> > > > 2. It doesn't extend to non-filesystem sources of shared data, such as
> > > >    memfds, ipc shm etc.
> > > >
> > > > 3. It requires unintuitive configuration for what should be basic
> > > >    shared accounting semantics. Per default you still get the old
> > > >    'first touch' semantics, but to get sharing you need to reconfigure
> > > >    the filesystems?
> > > >
> > > > 4. If a task needs to work with a hierarchy of data sharing domains -
> > > >    system-wide, group of jobs, job - it must interact with a hierarchy
> > > >    of filesystem mounts. This is a pain to setup and may require task
> > > >    awareness. Moving data around, working with different mount points.
> > > >    Also, no shared and private data accounting within the same file.
> > > >
> > > > 5. It reintroduces cgroup1 semantics of tasks and resouces, which are
> > > >    entangled, sitting in disjunct domains. OOM killing is one quirk of
> > > >    that, but there are others you haven't touched on. Who is charged
> > > >    for the CPU cycles of reclaim in the out-of-band domain?  Who is
> > > >    charged for the paging IO? How is resource pressure accounted and
> > > >    attributed? Soon you need cpu= and io= as well.
> > > >
> > > > My take on this is that it might work for your rather specific
> > > > usecase, but it doesn't strike me as a general-purpose feature
> > > > suitable for upstream.
> > > >
> > > >
> > > > If we want sharing semantics for memory, I think we need a more
> > > > generic implementation with a cleaner interface.
> > > >
> > > > Here is one idea:
> > > >
> > > > Have you considered reparenting pages that are accessed by multiple
> > > > cgroups to the first common ancestor of those groups?
> > > >
> > > > Essentially, whenever there is a memory access (minor fault, buffered
> > > > IO) to a page that doesn't belong to the accessing task's cgroup, you
> > > > find the common ancestor between that task and the owning cgroup, and
> > > > move the page there.
> > > >
> > > > With a tree like this:
> > > >
> > > >     root - job group - job
> > > >                         `- job
> > > >             `- job group - job
> > > >                         `- job
> > > >
> > > > all pages accessed inside that tree will propagate to the highest
> > > > level at which they are shared - which is the same level where you'd
> > > > also set shared policies, like a job group memory limit or io weight.
> > > >
> > > > E.g. libc pages would (likely) bubble to the root, persistent tmpfs
> > > > pages would bubble to the respective job group, private data would
> > > > stay within each job.
> > > >
> > > > No further user configuration necessary. Although you still *can* use
> > > > mount namespacing etc. to prohibit undesired sharing between cgroups.
> > > >
> > > > The actual user-visible accounting change would be quite small, and
> > > > arguably much more intuitive. Remember that accounting is recursive,
> > > > meaning that a job page today also shows up in the counters of job
> > > > group and root. This would not change. The only thing that IS weird
> > > > today is that when two jobs share a page, it will arbitrarily show up
> > > > in one job's counter but not in the other's. That would change: it
> > > > would no longer show up as either, since it's not private to either;
> > > > it would just be a job group (and up) page.
> >
> > These are great questions.
> >
> > > In general I like the idea, but I think the user-visible change will be quite
> > > large, almost "cgroup v3"-large.
> >
> > I wouldn't quite say cgroup3 :-) But it would definitely require a new
> > mount option for cgroupfs.
> >
> > > Here are some problems:
> > > 1) Anything shared between e.g. system.slice and user.slice now belongs
> > >    to the root cgroup and is completely unaccounted/unlimited. E.g. all pagecache
> > >    belonging to shared libraries.
> >
> > Correct, but arguably that's a good thing:
> >
> > Right now, even though the libraries are used by both, they'll be held
> > by one group. This can cause two priority inversions: hipri references
> > don't prevent the shared page from thrashing inside a lowpri group,
> > which could subject the hipri group to reclaim pressure and waiting
> > for slow refaults of the lowpri groups; if the lowpri group is the
> > hotter user of this page, this could sustain. Or the page ends up in
> > the hipri group, and the lowpri group pins it there even when the
> > hipri group is done with it, thus stealing its capacity.
> >
> > Yes, a libc page used by everybody in the system would end up in the
> > root cgroup. But arguably that makes much more sense than having it
> > show up as exclusive memory of system.slice/systemd-udevd.service.
> > And certainly we don't want a universally shared page be subjected to
> > the local resource pressure of one lowpri user of it.
> >
> > Recognizing the shared property and propagating it to the common
> > domain - the level at which priorities are equal between them - would
> > make the accounting clearer and solve both these inversions.
> >
> > > 2) It's concerning in security terms. If I understand the idea correctly, a
> > >    read-only access will allow to move charges to an upper level, potentially
> > >    crossing memory.max limits. It doesn't sound safe.
> >
> > Hm. The mechanism is slightly different, but escaping memory.max
> > happens today as well: shared memory is already not subject to the
> > memory.max of (n-1)/n cgroups that touch it.
> >
> > So before, you can escape containment to whatever other cgroup is
> > using the page. After, you can escape to the common domain. It's
> > difficult for me to say one is clearly worse than the other. You can
> > conceive of realistic scenarios where both are equally problematic.
> >
> > Practically, they appear to require the same solution: if the
> > environment isn't to be trusted, namespacing and limiting access to
> > shared data is necessary to avoid cgroups escaping containment or
> > DoSing other groups.
> >
> > > 3) It brings a non-trivial amount of memory to non-leave cgroups. To some extent
> > >    it returns us to the cgroup v1 world and a question of competition between
> > >    resources consumed by a cgroup directly and through children cgroups. Not
> > >    like the problem doesn't exist now, but it's less pronounced.
> > >    If say >50% of system.slice's memory will belong to system.slice directly,
> > >    then we likely will need separate non-recursive counters, limits, protections,
> > >    etc.
> >
> > I actually do see numbers like this in practice. Temporary
> > system.slice units allocate cache, then their cgroups get deleted and
> > the cache is reused by the next instances. Quite often, system.slice
> > has much more memory than its subgroups combined.
> >
> > So in a way, we have what I'm proposing if the sharing happens with
> > dead cgroups. Sharing with live cgroups wouldn't necessarily create a
> > bigger demand for new counters than what we have now.
> >
> > I think the cgroup1 issue was slightly different: in cgroup1 we
> > allowed *tasks* to live in non-leaf groups, and so users wanted to
> > control the *private* memory of said tasks with policies that were
> > *different* from the shared policies applied to the leaves.
> >
> > This wouldn't be the same here. Tasks are still only inside leafs, and
> > there is no "private" memory inside a non-leaf group. It's shared
> > among the children, and so subject to policies shared by all children.
> >
> > > 4) Imagine a production server and a system administrator entering using ssh
> > >    (and being put into user.slice) and running a big grep... It screws up all
> > >    memory accounting until a next reboot. Not a completely impossible scenario.
> >
> > This can also happen with the first-touch model, though. The second
> > you touch private data of some workload, the memory might escape it.
> >
> > It's not as pronounced with a first-touch policy - although proactive
> > reclaim makes this worse. But I'm not sure you can call it a new
> > concern in the proposed model: you already have to be careful with the
> > data you touch and bring into memory from your current cgroup.
> >
> > Again, I think this is where mount namespaces come in. You're not
> > necessarily supposed to see private data of workloads from the outside
> > and access it accidentally. It's common practice to ssh directly into
> > containers to muck with them and their memory, at which point you'll
> > be in the appropriate cgroup and permission context, too.
> >
> > However, I do agree with Mina and you: this is a significant change in
> > behavior, and a cgroupfs mount option would certainly be warranted.
> 
> I don't mean to be a nag here but I have trouble seeing pages being
> re-accounted on minor faults working for us, and that might be fine,
> but I'm expecting if it doesn't really work for us it likely won't
> work for the next person trying to use this.

Yes, I agree, the performance impact might be non-trivial.
I think we discussed something similar in the past in the context
of re-charging pages belonging to a deleted cgroup. And the consensus
was that we'd need to add hooks into many places to check whether
a page belongs to a dying (or other-than-current) cgroup and it might
be not cheap.

> 
> The issue is that the fact that the memory is initially accounted to
> the allocating process forces the sysadmin to overprovision the cgroup
> limit anyway so that the tasks don't oom if tasks are pre-allocating
> memory. The memory usage of a task accessing shared memory stays very
> unpredictable because it's waiting on another task in another cgroup
> to touch the shared memory for the shared memory to be unaccounted to
> its cgroup.
> 
> I have a couple of (admittingly probably controversial) suggestions:
> 1. memcg flag, say memory.charge_for_shared_memory. When we allocate
> shared memory, we charge it to the first ancestor memcg that has
> memory.charge_for_shared_memory==true.

I think the problem here is that we try really hard to avoid any
per-memory-type knobs, and this is another one.

> 2. Somehow on the creation of shared memory, we somehow declare that
> this memory belongs to <cgroup>. Only descendants of <cgroup> are able
> to touch the shared memory and the shared memory is charged to
> <cgroup>.

This sounds like a mount namespace.

Thanks!
