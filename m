Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602A42D1A30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 21:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgLGUDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 15:03:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12866 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgLGUDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:03:10 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7K0cFL030170;
        Mon, 7 Dec 2020 12:02:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=m+GbydYCsM+9Eqs+kHgUyqtbdjf9kuBWw0UOILhR8fc=;
 b=TEBJ3xKrcYDEr0oA3UehSzwxZwE7hNLl39NK47qcZTXBSjx2RtVKXAdONUccFnRinN1Y
 Ae+LqnRKwtRT5tSdCeYoBSeA30+rTONFofjKW9F8/cjQ/ymqhhcqbcaVL44+LJa1zqpK
 p00qN4XZR0jc5y+4xSKV8wMtbBFK3SDyqCc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 358u4ugtwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 12:02:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 12:02:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPagJIxyZ5Zt0jy7wz/+poVKHDlb+f19LW0CrM0t05yGAPYiYqxPXsP9Kq/vr7Yt+l/AUqiwtFy15l7+iYB0lUjdIpM77zIM8yRqqP1OpBgBz5acU8YitUwFSQOKm19/EFn3xPLgQBhfz0uj2J5ARjClu5ky4Uq5FKcb73W7OIDocUK7keLYs0PAPGBgN37u3E6IKo5435ONgQ5tE2Q9pkGPm/rL5gbTzF/ede0cL+ONICogmseQU5yESo0rtkdoNS1hzTN4uKGkTpkOqrzToOl8HTF+SnEKQ0SqiHhK7GCtRPyfvGthfekbvXAk3F1Y+jn2TR/xv6jFDtuGbm3asA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+GbydYCsM+9Eqs+kHgUyqtbdjf9kuBWw0UOILhR8fc=;
 b=UhRL5ZIIA7Mvt4eUft4AHUaF6bp+uAaOfdVMrAiAfdjR/ZUUSeraUYNQKO5Nw8yUgF0AWXsPXbqOmkkpwJfALO/4w1x0GwxId3ZV95/Mff5jPWy1Vp+hHgCNzbqZ9fqTTJ2Cz18f5Xi7g8QvHgzw6jCFv998mmXgDpa/7GA8cQP7S3B3oNh/30N4iRcmBBKesJemNUmojtTby7yVScPuLNu1jPVWY0uPknBWlwbys0mVPgwuTTloli06GAegeqlVH0w6ajInXvjUPdswOyKXN//UQQTABNHRbnbtqzRPAB+bDrr58B5d7W5LBRoRZ1D+6GMaKsxe71rTj4Ciuk9yLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+GbydYCsM+9Eqs+kHgUyqtbdjf9kuBWw0UOILhR8fc=;
 b=KUkOVynAWJVo3RLc+0/MA3Q3fXoTMtT+BrhpJNlS/F75eo3MIytp1CZxJ2A9Ru0oJmyCunYgKVQ3vOo6wZjEDRqdZLYJBg33v0Y6ohiPIbO3CdlDrdthPzjVgw1UM7FPI4ZlFLkUD5svN6RS3UkN8fgESx0QiFlTJVdw0Ox7yQg=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 20:02:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:02:00 +0000
Date:   Mon, 7 Dec 2020 12:01:55 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <hughd@google.com>, <will@kernel.org>,
        <rppt@kernel.org>, <tglx@linutronix.de>, <esyr@redhat.com>,
        <peterx@redhat.com>, <krisman@collabora.com>, <surenb@google.com>,
        <avagin@openvz.org>, <elver@google.com>, <rdunlap@infradead.org>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 09/12] mm: memcontrol: convert vmstat slab
 counters to bytes
Message-ID: <20201207200155.GC2238414@carbon.dhcp.thefacebook.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-10-songmuchun@bytedance.com>
 <20201207194622.GA2238414@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207194622.GA2238414@carbon.dhcp.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::5:64ac]
X-ClientProxiedBy: MWHPR15CA0035.namprd15.prod.outlook.com
 (2603:10b6:300:ad::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:64ac) by MWHPR15CA0035.namprd15.prod.outlook.com (2603:10b6:300:ad::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:01:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3023b256-e7cd-4ca6-8161-08d89aeaf5b2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2759AD920961BF906080D987BECE0@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJdx8cMUtF6bOQ8p+4VUNL48WUO7YYYmfnopvGR7Bdhs+91T1WGAhhKs5Y/eV6tJmPQD912hXsbFnmBQXoullY9rGQnbLrSw+tTeWQR5nX0OPV+A1eS1MLO9a54QfvHM56rtsaQjVspJbrTNRg2SPBJMf+4TaUxbpm3UTRsSPXIHym0mEMZ0gHLNB3uU/u9H4grpY5RecOoTWnLYA9TMmOZN+y2gXMnf2KQTNkStqKpPY1zvxMVp4qm4oEk9UyeJQruePIgpxxr2rnmGkOVrg50A+qvOG8Ad/HtakmYHmM0p9mf+WT8GAIrQgTLEUJO1rdhgQQAYDrNdiG3gNnbLtTHVYYyI560rSzHG0BW+v6WpzpRuj66gfrWr1GBejcbOpBOKwVpxGBvOZGjCY4is3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39860400002)(366004)(66476007)(66946007)(66556008)(7416002)(5660300002)(4744005)(33656002)(8936002)(2906002)(6506007)(7696005)(1076003)(8676002)(966005)(16526019)(186003)(478600001)(9686003)(6916009)(55016002)(316002)(52116002)(4326008)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jc7QaiPcUcs51Adad0dQiHreY+zVrrL/wAvc/J0mR1bAi9yq9eg26Ooc+mFI?=
 =?us-ascii?Q?SshpTK7InjsFwnNXQQ8UZY8jNEO2DtNGOHbtJYDHO3WnDJsAQPnc3Cas8AMm?=
 =?us-ascii?Q?afEgf/V+yDSHvRsRlCqewK5MlaXh0M/F2efqQjd8W35D5pEafzHCDkRZFYG3?=
 =?us-ascii?Q?/aA4jFBWLSVkYqPhSnZS7fEHH6UM/8iCMov9DNIxPu8GIpNW7tb8Lhnb3Lns?=
 =?us-ascii?Q?RwYg6phwsICQVAsN5nYL+5rpmgE8jrMO4WU7BciXohZgZseTp8iZOmzCqHnJ?=
 =?us-ascii?Q?+0GxetFvElKTMJzEbX3upH7P6cZRUWhFyZxuoDDn4KuAoaKE88xUu5sznwAy?=
 =?us-ascii?Q?bURJWWL0vnxJHgbF+pMjaRIcLo2RNWjUITpZfsWukKuxNrdp5jD4n/uDQfmu?=
 =?us-ascii?Q?wA6BUOa+MoYJDqIiqrrCudFMpPQ4OJeOE9NmA4BlLSL9SOro9ZmhS/Jdq+tb?=
 =?us-ascii?Q?E8QD5mY8GA0COof63Rao4TuLqbQMXaNDQsWmMm86Hht8vNF+FUAZp/WfdsS7?=
 =?us-ascii?Q?vULdmUo3CrshY1i9qw5c4KbT6HKIvjNOJHzJG8b96YEikU37RNG9puXWkNKO?=
 =?us-ascii?Q?CA1Ld+RJd/453vQLfOA+b4SJNuPiHC1wp89l6rBl3AkjbDPFsb2zr9qzX3GQ?=
 =?us-ascii?Q?ccp36BdH7ZmxmgJ81zn/67DEagtleqEKnSKMNkKMq+j5KsTmf7BwAwzYkoW6?=
 =?us-ascii?Q?3viTkNHYEric5Z6l3q+ara8baldWxhNTA3pfjmNI5BU92WakDB2mIMvNb8P0?=
 =?us-ascii?Q?/4UN3oXG8xnwIkyionj4SM6no0SNOjgsYPSK+ZJkqOJugZ2DDm9SDuuOebk2?=
 =?us-ascii?Q?4KvcsjoT4WM2xVB5UzdfCK6yXyHqw0Sxf639p6pzkY/HKbV3PTIqH3DY5xhl?=
 =?us-ascii?Q?9mG3BFMJlY+QaoCKYs+Bz14haLer7DxlV53QFzG9gS3/6Gy7oDfJxRG5SqmD?=
 =?us-ascii?Q?E+Q3YIPTpqpHQBrJhhY9H2ke3WHsY3DMrdMnmhpX4nvhWGPcVNjp598KXAua?=
 =?us-ascii?Q?um9Y8oGKK9YUMfHFRusdYm5vHQ=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 20:02:00.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 3023b256-e7cd-4ca6-8161-08d89aeaf5b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mkKHwBgoEjxIEAGSvYmkt5TgKO0wq++QqiHuFBqJ5HhzzJ/16PChrdTe0/wD3Yr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_16:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:46:22AM -0800, Roman Gushchin wrote:
> On Sun, Dec 06, 2020 at 06:14:48PM +0800, Muchun Song wrote:
> > the global and per-node counters are stored in pages, however memcg
> > and lruvec counters are stored in bytes. This scheme looks weird.
> > So convert all vmstat slab counters to bytes.
> 
> There is a reason for this weird scheme:
> percpu caches (see struct per_cpu_nodestat) are s8, so counting in bytes
> will lead to overfills. Switching to s32 can lead to an increase in
> the cache thrashing, especially on small machines.

JFYI:
I've tried to convert all slab counters to bytes and change those s8 percpu batches to s32
about a year ago. Here is a link to that thread:
https://patchwork.kernel.org/project/linux-mm/patch/20191018002820.307763-3-guro@fb.com/

Thanks!
