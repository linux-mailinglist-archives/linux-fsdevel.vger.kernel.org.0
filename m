Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C782EC73A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbhAGAOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 19:14:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50576 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbhAGAOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:14:50 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1070ALUq001811;
        Wed, 6 Jan 2021 16:14:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mNOmYbtTCdPOb8iGeEp3sCJ1LP6y0HLJ2TzqS4i9W8s=;
 b=jgo+iRGliDDQxgpXaZKwfiOE7pq+MqArz3k59FWasUj+ClU5Y+dolWkuXwz/1XXMyMYb
 mHm+pNQ/q/VwiBiZLQGgqEU0pSgnzPn51RsCTgIB7SzFqxctfQbAnGvNgukxjOgcdsBJ
 wtg+qUmFzvls/b2vqZs9oI+SEsZpYeA1Vl8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35wq4k044y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Jan 2021 16:14:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 16:14:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcRz8vJ5XRB3Er4OUMNnazlwBTXNfv9rJfAQ7NXKumRrTM+5HExy/Abbq/ko4iDc5/MgRCqLBASXuPTxoe3e7wM1Uy/+xvXoZ6bGDI3kjmbqBdlK6buG8QxR6Z07KhDVn5MajmCwRWnSP0Kc0IZBHbBlsQRZ/7vqFPctEBhpjwV9hOj7CKOWbuRbeb9ZQWKjtSpZZHGb1BJgm1sWEBPjFaahG/uCNUbcm2FEXoCzyv3QWqNbFXF/sBrqHhQqIt1ydJuA8GK6A7/YnYLwCCpYd212dhMkEhUK83bM8Xw55o5TLi2HGvlRASLsm2FcLkeknQ8OADkIb0J0ewWsqwecug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNOmYbtTCdPOb8iGeEp3sCJ1LP6y0HLJ2TzqS4i9W8s=;
 b=KhnVPbRoJjDzCmP5O/HVkkdhslVUiKdsMcvlup5VeS4o0fWu1vrKKjCtanOIcd5x5P9EOTimJa51ytjHhgNeVegHLZYIe7DVj6R1Mz0EDOtc27YIAdMVXJnpE+RA0njrwV5vR5TBA6FUFp7qfu7bESS/JPAr4akRStvVc1hV/anzl/D58XV3aU/6VlwRsFiqu9mKO04xPblumGuHk5c1G6H5+sE06E8ai679lq5bBe6kbFcuxRZ4DsSRawXdHDwraAECD2hAF1LC+Oqi2yaMXZJg/9XD0HOBi6Kro2STiWOd3RM6nVoXYTNz0/Lb/G2/PjIXdWl47wua9X0YVDiCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNOmYbtTCdPOb8iGeEp3sCJ1LP6y0HLJ2TzqS4i9W8s=;
 b=OackHVhgkyQ4CExXNcl3HMuT0b0JR3LdRV4y3XeSGlKhg+Zh+71De0GZ0hcf5a1SXQGCe0smnoXguP2b3ivPr5YSb2/TIPJXo53NlTOImcHWGiSkZCDBiLK0Yl0jL1YXrDG5PxVUF58ooW1UOGad3teDiwYJxmrWKQOrF+vxV2k=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Thu, 7 Jan
 2021 00:13:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 00:13:57 +0000
Date:   Wed, 6 Jan 2021 16:13:51 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling
 code
Message-ID: <20210107001351.GD1110904@carbon.dhcp.thefacebook.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-3-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105225817.1036378-3-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:8df5]
X-ClientProxiedBy: MWHPR17CA0077.namprd17.prod.outlook.com
 (2603:10b6:300:c2::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8df5) by MWHPR17CA0077.namprd17.prod.outlook.com (2603:10b6:300:c2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 00:13:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf61bd4-f950-4a70-6aca-08d8b2a1209b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32852A1D8CDFB003D85A5698BEAF0@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfwe/SEqZcbAe5CcLJbUwYwRRdlhWKQFjt+NN3N18l5I4oEHDLostlct+iHke1T5TneIuN2zUq7po+AIHeJb7ZI8nAGjxXm1YTbO10hJI/onwiHP2t3icl49ByjfREqdP30PNkpUpOyPUntJMLOTVdrHdQqz7jkWIoC4G+o9vrdpd7IICGoF0LMj/pTLZ4WYIq8hKfiPM6V31L7I0vr57yRfoI0uT74DSjhV6dQW5KgEQUS5WN+ygDPzZ4Pl5ysXJG8ifCKTqBIGzq/bFyGjCyP1DhC6XhG0f++ZYUkRxBtdemrQUXvHb93/8iL7g4/alCdHT+fk0uA2LlAIXImAUK6aPwjQUvbKAPSrUfvWk9nvRMuCrX1cfkRNYcCkXggsXFTAj5eymHmpYM4Bt7insg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(66476007)(4744005)(66946007)(186003)(66556008)(8676002)(6916009)(16526019)(9686003)(6666004)(1076003)(55016002)(478600001)(4326008)(2906002)(316002)(5660300002)(8936002)(52116002)(33656002)(7416002)(86362001)(6506007)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HXGhXwAMJzTIQN8D7/Q7BCa/KqvDfuE0EJqSBqlakTB/W9rQ5pGEjzZi9sRK?=
 =?us-ascii?Q?d4qi6uOnJ2X53Kpc8Up7gOYfmQ0Io+OGwbJgddpy4MdTZkfNfaqtfr5SfaAF?=
 =?us-ascii?Q?SWuYzHz75tnf+wif1dVOTngOwFyaEp/Py8S+acy9tkXJwbSmEx3Z84w8W18z?=
 =?us-ascii?Q?kGaqeYGzZ17K1nv07GJ+6MEaZW/gySzVab+Ry+gY8RJDSYnHr19+0MuA2+xm?=
 =?us-ascii?Q?XqemvK+ksSgPmBwmZ23kXJfX23wUgMT8w5FmGZmG6pHvaK3Esz1fyCbfNS2a?=
 =?us-ascii?Q?UaQ37/bkwxbmqHtRj+7ItrOfICppz8qdvD3s00pdO3yDC6yfG5v6OQdFrrVH?=
 =?us-ascii?Q?YNIzX3k6/MbKH+vJ6/96ETYRZLYAb1qqUX6BTjZBTxtsdTrzZAaSgl/INEAz?=
 =?us-ascii?Q?Xui9DNpkEvLBd5rq3IaruWvFoytBQsn9wlZhXDKkhw/XZvDjaG3dF1YdPzOu?=
 =?us-ascii?Q?77qUXdQzbYz6asl9DyORcuXl6w7KpZCrpbrVvs5QOhJDjKB8nzqu9h2awTJM?=
 =?us-ascii?Q?B55TtY8GQnu6K8QI0QkE8C82wMG3pMaU7ANDoK3nrHz859UAaphlcSgCA/vv?=
 =?us-ascii?Q?Un/Ro9bJAa/KNkw2rjynAGHY5bqaw3Otjbmzoui7t5Gus+m5TfkH822cTdbz?=
 =?us-ascii?Q?hLNtBfFAA+EVCZRjXsxbkmTnU/zWsJzeaLV3n3qQ5cl9LGqDS4e3UFMpDYDp?=
 =?us-ascii?Q?q2WCKCocgpHonFZaJ25+4TC/lRYbLEqWrtH/3iN6Km17yIodBlNVi8/n00lN?=
 =?us-ascii?Q?/OGXOcXilckIhKRD9El6k8dcQnT+LqCO5WKV82x6DT+0rIbnNaFyHL+8Ur2S?=
 =?us-ascii?Q?4s8dMpBs0m/c4xg9Lw3bIlulWytuJ0nGcGFOKQnMCZugp+ggxkLa3Gm9TTIh?=
 =?us-ascii?Q?xA8TYJuNDbODa2o3nAapdDBYWBcdOPr8YcJuN0OeakZ5CRPVvJ1u8W1+zoxz?=
 =?us-ascii?Q?dU/g+rJmKxUX3TSNmL3YgI+S7EyZb3TTw1QAP7wnmvx5TEF6fRtc0jbvjdTU?=
 =?us-ascii?Q?g1i68agyALuub70smKewdOwX1A=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 00:13:57.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf61bd4-f950-4a70-6aca-08d8b2a1209b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAfuatsoF/ZWWJj16zAZUHInO3GllDEG/tf/YtSjzogt3hprLEmAcBPcaq5KyAgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_12:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=867 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 02:58:08PM -0800, Yang Shi wrote:
> The shrinker map management is not really memcg specific, it's just allocation

In the current form it doesn't look so, especially because each name
has a memcg_ prefix and each function takes a memcg argument.

It begs for some refactorings (Kirill suggested some) and renamings.

Thanks!
