Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6790D2F1FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbhAKTii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:38:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32374 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbhAKTih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:38:37 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BJX0xP018239;
        Mon, 11 Jan 2021 11:37:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UN7Lt41cUeHDUqdzd9BBe5nhDLVkMdIDr++nqmfs53c=;
 b=eL1oN3vwCuHlJ60By7EAhrd4bLAuY7Zg1BDDUr+3+k3Pu0rQzq3kFVWDjh71CryxBDS6
 Y+hVxe80KUvg8n1Wl92RCMyXZbPikxQuTAA5SepWKDaY0RJTpGcLs5FPjo85S01ImCF8
 UivGO0RC498kUzlMvDFvG+Dl+kXdjCXv3rA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35yw876ght-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 11:37:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 11:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4DHOqXIadO8vexVLO3ddqHHR/OQe/w1F3Zduz3jk4N8vnYxyTz418eYM0eI38xMc0VAL1rULYU0PQQ3iwa6tOehstiuM5c+pzl1T9quc2RDjYuaEtzbPo316E95T7nhAVxP2a90rFT9PHamKrxtxyfZYFmu8wsTBCWQmqbf++kCQLXc+NFc2Cy4ChhAxNto3VePcYcFjJfP9GDu6raWoGw7N5ngoCQ+ybnUtfBcoIjlRrsJnG3y38SiHB1QvQiNxdr/5FPs7MVaXGtKuDcGx8hzz724jCz6ZtT5FRyGMCsf7oD+WWw4qycerzFF1dRYKJMrsEsZ2/ZHArCDy0O0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN7Lt41cUeHDUqdzd9BBe5nhDLVkMdIDr++nqmfs53c=;
 b=hLYqRyuHbnmevabOUVZOxQrwAn4XXCrJzcduEmXLxAMbKGVC6odMEVQTlp+rk4FA/cO/sVgjH1gBuRIDc5DRuh1xVPatnu0aLRjKVw/O3zWaWAy3WhAqGA0avN/CCC85SrsBboQNeYXrXPlH/36LlFrj5n6uhqa1/lW6+gI/yJ7yN/nQVWJ/2lw/ssvTNp3uTVGdJqbQKTBQHUw5m8z5gxylSntS2ucTsDXB4rqhQdCvdcdkfPnpaKVTUcYoDmZxlE9946f8kRBkoaSfeDTrUocpw8k/AXj9fiA+eH0U+st0qn/k45klwXaHrqrl5gfs+PAZCj547EleZHuOGw1kUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN7Lt41cUeHDUqdzd9BBe5nhDLVkMdIDr++nqmfs53c=;
 b=DJGOiXy3bvFVwqzEnkJA60uFgvge/GNFdttVYlijRS39atA47DFUlJnxzBulDbnOCaTNLRVsNE0eBFsdiyvUeQUzOgDayNVZf6S+QKsrT/SDcdklgVNMJb8r9L5X/R/o1yLmrURrZ7FyD84d22v/yjxiLe64j+OiqD9a1mufe6M=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2279.namprd15.prod.outlook.com (2603:10b6:a02:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Mon, 11 Jan
 2021 19:37:46 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 19:37:46 +0000
Date:   Mon, 11 Jan 2021 11:37:40 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling
 code
Message-ID: <20210111193740.GB1388856@carbon.dhcp.thefacebook.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-3-shy828301@gmail.com>
 <20210107001351.GD1110904@carbon.dhcp.thefacebook.com>
 <CAHbLzkqnLKh7L5BWdSsoX5t-DjpOwYREwY5yBXgRUqAuubueQw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqnLKh7L5BWdSsoX5t-DjpOwYREwY5yBXgRUqAuubueQw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:8b25]
X-ClientProxiedBy: CO1PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:101:1f::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8b25) by CO1PR15CA0045.namprd15.prod.outlook.com (2603:10b6:101:1f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 19:37:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e2372ad-0c95-4dcc-d81d-08d8b6685f21
X-MS-TrafficTypeDiagnostic: BYAPR15MB2279:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22795BF9790AC7AA0C032D26BEAB0@BYAPR15MB2279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1C0uBYG1HU+gRipVkkitYClA6645LR6LdsBySC8Xf88s0Gf6CUUIS/ikNWGOYSqp26gSpekpYv4pw2sri2+TDfh/tKFuNUc3uusRUk1ucd+CSp8/lqKwlFbAr2A6ayktJidbXpF6pIfJYcLDVR96BcmnKVRsPL+ju7RTEJ/Q9G7mH2ev8YVuJ9X/7R8zUXCaQv14P7sIWT5QjdqhZf/wfzM2qJp6Arw3z4fE33zdMPyFPS62aznxEXGs09OzSr8SeVWyJzsJDNJC3NaC58vI0jUHU3u8BAv61HDq/8UYaPk2+g8CPqT+Mw+k7zSWZOZnF+DYy7F1gECQewD/5dutYh32XwunOY+erlnaa9r9vIkjRdAXIHpA236ys2O76oR9fpwkGKb1FaVD4+uLCmAraA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(5660300002)(6506007)(66556008)(4744005)(1076003)(7696005)(6916009)(66946007)(53546011)(4326008)(86362001)(8936002)(7416002)(478600001)(52116002)(186003)(33656002)(54906003)(316002)(9686003)(16526019)(8676002)(2906002)(6666004)(66476007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b/7Mhvut9bWTOkusXDbe13VFwBLlGO779eY3I6Mx6wUITS7805gtvEixIimY?=
 =?us-ascii?Q?AWSy8bPeHZkBab1qwhIcLk+sfgM90lu0M3RjgT4ru1m2J4uvxJCioMdNGxw4?=
 =?us-ascii?Q?CP5q1hUkGmoV/uWqL4DQEwKxJRRLy9uCcd6oG4ym8yPPw43tESREKrngM+xJ?=
 =?us-ascii?Q?DtwpXxeV60yDksL0lZz/Ic46Xl8A1dszOk+6ZKb/IeuBQcOeyk5QpbepnvJu?=
 =?us-ascii?Q?H7nis1xLs4VvKyFDVbaJaUjIRO0WEUT9xruuMBwTQer3srP4tlWBCiQoJdIc?=
 =?us-ascii?Q?pLRZC3DOY9tJkqs8ljtzRWr7pzswb0HF56/2AWICFCUILwoOHbSNR3tkEtUN?=
 =?us-ascii?Q?hy7jo79s4breDsCQqekuOhOyOUQdeMyY7HMsDNxZBavnRnW/ZHCjU84+4B3e?=
 =?us-ascii?Q?7vs+nS1KL6KjJz01+i82jLGA82mmBbC9YYK8fTQOU7CApbt4Ivii/5fOPEUZ?=
 =?us-ascii?Q?/0W/rtSWjO6+A55/oiZJ22aLd3HISAe4KgkIGehWXZnUkwj6mshFGAvIxCiA?=
 =?us-ascii?Q?Z7N4Nx9zYzDuoQ7xDDldTcvcg7vkCqeWjTvoSTIk5LDPI4gO0I1L6KKd29+i?=
 =?us-ascii?Q?DnooCzgXwLpqu+0LcRo+rRs8Lxbg4c9kctPYVvFQW6GutZL1Yw5wI6MbcqeQ?=
 =?us-ascii?Q?imBMgC7l3GxRxCm0sZsJEMi1TWxicHUTfPaQl5JhXQ31JHVi06A9ugQHfKq9?=
 =?us-ascii?Q?o234PER7hIrKAgRObSFQdU6kgtqizq9/JBU1abX7D4pW2fc3V4Wgk8Lr6vbh?=
 =?us-ascii?Q?u+71nkT+WOjt+ppJKUu4a8V7GLigFOeNbDhi61EczPTiPmwPtgTqXFhCJbg3?=
 =?us-ascii?Q?5oHiBeKdVRMc0Nhubo2FjNCrUl8X3HEGjuwPMpjXw/PtDv6i/l53TAqlhPKD?=
 =?us-ascii?Q?weXjhOSebh5hg6c3vHrFnHMaHEr1EYQcfVb9zIBvT35wouSyRJjLvRTkQpBa?=
 =?us-ascii?Q?SLoSpgqhH60DgMrI7CMAZc5VvS2L63ll2aYzk8IQdeTZ7neyQJDCjK0gYmOZ?=
 =?us-ascii?Q?KY85cLFNvNfcoVCoygzZQOshSg=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 19:37:46.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2372ad-0c95-4dcc-d81d-08d8b6685f21
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGFH6FR8+5U9B17Sf2zkujc6O0L+5O4K0IzZGySy6cBiDYHsTy+lJXB7tw9opBRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2279
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_30:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:00:17AM -0800, Yang Shi wrote:
> On Wed, Jan 6, 2021 at 4:14 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Jan 05, 2021 at 02:58:08PM -0800, Yang Shi wrote:
> > > The shrinker map management is not really memcg specific, it's just allocation
> >
> > In the current form it doesn't look so, especially because each name
> > has a memcg_ prefix and each function takes a memcg argument.
> >
> > It begs for some refactorings (Kirill suggested some) and renamings.
> 
> BTW, do you mean the suggestion about renaming memcg_shrinker_maps to
> shrinker_maps? I just saw his email today since gmail filtered his
> emails to SPAM :-(

Yes.
