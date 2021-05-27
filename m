Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11A63933FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhE0Qbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 12:31:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233656AbhE0Qbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 12:31:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RGBRk3029695;
        Thu, 27 May 2021 09:30:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=R8ZMG4jJXCPWRao7W7bJfPCzcxw625gj7FlXrxTH8W8=;
 b=g6DnJH9ojrQ/UkBEGAIhVxs609mzImCV3Y808GFAcYdRkFMeGUdEPEK/a28BiQkBG2ek
 AKAa1Uk0bLQquY2j/NvsnrhblreLR7BhJO4JaQ3cRcGK8XRuN/bftdHEu4BxdjthQoSU
 E8VC7zVo9mfAPNoX1j1ZL6m2CAbExzrbd2M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38svuqe6gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 May 2021 09:30:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 09:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVBBlWFlFhDQWNxlJZeasK9GINNr1Ero40bQy14RvsJMHMRFsUTbw5lCmcYtuxSvQv5AFZj+1/68zqQ92RQ+oBxZ1qegCgNR1iixFA6oLg9q+1sdnlv1IKCpRxrYTXmU6Cm5RFZXzQg232P93F/U1GGf2IgcB5A0JGpfLuhDM16C7rrvsj/CACSh1ZCm+1zeF5luQggN+HCd5gDItL840C0w6lwFJm0VvI6N3wj7+NtTUqoLBG1INQ1KCCZj4DgL6SeVYivxtC5E8O92MwLqu0CBE6EU9EAR5u1mW1Yg6gN4JzvT/DN21JksS9N3VvqLhjJzlmRvEciQNQfmPvRcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ZMG4jJXCPWRao7W7bJfPCzcxw625gj7FlXrxTH8W8=;
 b=R4XgArtjeyb5VrYcNVOlDiV2Xz/EoP1cz8eOwmb05euMaq7JA0rzIZ3huE1LVgsCV15t208orP1bJXnW99NjSSrOn/p95odwRDO5BgwAJ63HpRpL2EyorevT6NRbDbVSWy4r30vA8KIy2P061s8azIlwE2uYmuukDsXNtwHlgG9HDdQfr/eI96Svyn189ohcFarRZGqv5aZGaptYHEi9FvcChE/o8HFIflgfBIxfCk2HMc+by4M6wxUzbcUPVgJP9zCwmN4UYY6WAp3IX2lLevMZHnI718SEL+jub88WD5EiNLWx1bgSgsjb9YpMx6e4tnvifyvtzmHl24Lt69m+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA1PR15MB4324.namprd15.prod.outlook.com
 (2603:10b6:806:1af::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 16:30:01 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb%7]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 16:30:01 +0000
Date:   Thu, 27 May 2021 09:29:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YK/JBDxsZQwC0q8J@carbon.DHCP.thefacebook.com>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210527032459.2306-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210527032459.2306-1-hdanton@sina.com>
X-Originating-IP: [2620:10d:c090:400::5:8774]
X-ClientProxiedBy: MWHPR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:300:6c::22) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:8774) by MWHPR04CA0060.namprd04.prod.outlook.com (2603:10b6:300:6c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Thu, 27 May 2021 16:30:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b027746-33af-4c1e-3d70-08d9212cacf4
X-MS-TrafficTypeDiagnostic: SA1PR15MB4324:
X-Microsoft-Antispam-PRVS: <SA1PR15MB43240912AC035548467E4BD5BE239@SA1PR15MB4324.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9f4lcC+ePB3ZniKN3cBgfZ77ZPSGb2j9r0Jc2g+BJrNae5QOAEq5DQh8pJR5FAW8N+84jgYM0eA8yBSg/z/FTo1otnBJS0arv1pmTju+EyUSahbsYdQO+QMRQwqsMzo/zKDHB3nP3+u+gCTthFJYwroF/rFPj3HjOkozQ9CGsKkLhebHOxFJ37ucOK3+2t7i66iWQkgsWtGd9NRzGOJysXnbpaCwVnelb4pIIEhk/wxbGzxe0XDLS9DCb3winyPklyL+iDsDtENzb/m2FJKCCdvxrCe2swo4CbGi+qyXJMj3Fp/QpVUPTbqXaPRg8n+iZgXz3AsApM4fHNLEVLg16VXQd2+0JikBrvmZu0et5hmJ0jG8SABLW7fPNW4KE4gxFai2RT+QCBZVGJ8VmaJbHTk9vCYZa4Y+J09bGGqK1e0LJiviOq74peXf/EnTI3/51pcQtQJExS0oFzkOYV1wSSsT4P4eE0NzKAGBy2TMCEPc0ZJ+6www9l0kZiYDsPm97nVsk2axd3xVUofJqupGeslbPXpURezXRQ+DFSA6UnE3Nqt1Cr3hFDD0dFSGS77+4CIRH01RtSksEQ8RRZA7hiiDY+bOcyimx+PrjwF+f/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(4744005)(54906003)(86362001)(7696005)(16526019)(8676002)(38100700002)(52116002)(478600001)(55016002)(316002)(186003)(6506007)(6916009)(66556008)(66946007)(66476007)(9686003)(6666004)(4326008)(7416002)(83380400001)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PKKVmDAAj2i7i17oHrLYw3DanIfoRgRkOrkyVv0/S+TA2NKr/2KaMUjeeDSp?=
 =?us-ascii?Q?1nPEki69bAi6iYQ5IJLTSkUL9Dqr81NWzjgMoJadYlgte7BHjURoGjojT0SQ?=
 =?us-ascii?Q?UQKP+wIqBGtXTufVo628miD2Hy8zT0s+g49TxzCfn9AtWkRlPAZZxxdGfo4V?=
 =?us-ascii?Q?wVOPLI6NGAisoonbqJKP68j8Q5jJqgx3H78x4M5vpAD9JQiV8sjWkFEl53iy?=
 =?us-ascii?Q?BDKidUmgQ87ivRKktFZ3RkdIOF8d/xBmF2qwaOcw1BDlK8bujIaG0EiVRx/a?=
 =?us-ascii?Q?jwe/xOyei1do9QAYh/kzxiRiWRAAXzgmC/VnhOPSAmWd5x4BzZJ7W/08hYYR?=
 =?us-ascii?Q?oOuGtNPFYQfVym3KD7MHKZ32/gJF/ncRW/l6C4Ea8rkd2lR02xXvsBRTmqHv?=
 =?us-ascii?Q?6cAUMdSEJPry5r0pbjaq8+M5+YyVUY8zDH/XwXhQFuu1RTRiq6O5VBCZ0PmQ?=
 =?us-ascii?Q?T7yuTrka6pDT26FP/HaLiGAblINXSNNZoKxYaxf1s4vNralHGlX/HeQoDs1D?=
 =?us-ascii?Q?QO5ftuGSqGW2WcZ6PNoxlCTAhBWS0StM+rT7qrZdmpfVAC2S/IbGF4vBvf5r?=
 =?us-ascii?Q?+5l/AaEebDiyChC/+P7Ib089sHkZ9BVXIiwwDlhPC/CUC32hDK1/FOAlV+Jl?=
 =?us-ascii?Q?OwXnweJQzn8TbuvW9SSx2dTFp7PAL+iPDdWAzLUQzARVY1P8nRtkcMeRY+rR?=
 =?us-ascii?Q?XhdB9Ud3seBhhl+mr47UXQCRPjJCkIUo4nMvLJfG370Nw0nvC1u49cX72+Ch?=
 =?us-ascii?Q?O/YSvYOw0knSP35kV4t47HMzK5rAfvP6Y3n4J31Zn8aDDZMMiaBQgjuygwtE?=
 =?us-ascii?Q?fzft+zw90He73nhm2ADjD39m2gPZ6oSn83NIEeBsETaMn2yvxeQ/2PAD038Q?=
 =?us-ascii?Q?xhAGQbwtVFtebjosYIZIUtl3QCJ7J2X3JHWCnY5AulRqIFmF2EPnp/DdfBSw?=
 =?us-ascii?Q?WNdgm2GB+X+VrcN683M+hAn7l0i9spo9lvxiMbaOkqnM08ppp8MK6OcycM5y?=
 =?us-ascii?Q?JSIy5+7UI19ROYclRT5o4THMQG/EaGX63HR5TSYnYLq7kY8GFG+dPtnaVhRo?=
 =?us-ascii?Q?p8SnbBw/rX+j/D7Lz7Qw7PdK6d12KrmghR7jn+3iKeqHvT4/NH6Cdf4+mrtJ?=
 =?us-ascii?Q?oPiXAMW86cKtDcI50fMY8QW3khfpL59CYbKaaWb8SDF2RBdpzRoeKkgpZQR8?=
 =?us-ascii?Q?a6SGBbASUqeKG2JCxEMN8P0FrntInow2mAeh4dus6/drwORMkrmEURo1fHu0?=
 =?us-ascii?Q?L3rpfiOYdLCTLS7vHuMCBhDDXWuOz782uxPGMG6v8VT/J1PA/Vrzoc7Fiu11?=
 =?us-ascii?Q?j2j2iY/jSuSXUgugxYQ0FNCifPB7DozO8vzsp+YQlTDl3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b027746-33af-4c1e-3d70-08d9212cacf4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 16:30:01.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Np1wzhXmUc+0cvEYxEwn8E+21lsHuHWxpsXqSn8Xg/9AWugjPA3Vv6eTg4NxgjKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4324
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8RA9eJ9j73bgxlD6N9MhzI-wVdHWDqR2
X-Proofpoint-GUID: 8RA9eJ9j73bgxlD6N9MhzI-wVdHWDqR2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_09:2021-05-27,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=664 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 27, 2021 at 11:24:59AM +0800, Hillf Danton wrote:
> On Wed, 26 May 2021 15:25:57 -0700 Roman Gushchin wrote:
> >+
> >+	if (!list_empty(&offline_cgwbs))
> >+		schedule_work(&cleanup_offline_cgwbs_work);
> >+
> 
> Good work overall.

Thanks!

> 
> Nit, given cond_resched_lock() in cleanup_offline_wb(), what you need instead
> is
> 	queue_work(system_unbound_wq, &cleanup_offline_cgwbs_work);

Neat, will do in the next version.

Thanks!
