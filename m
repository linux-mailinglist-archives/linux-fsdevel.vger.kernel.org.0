Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAF2CCCE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgLCC60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:58:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40420 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbgLCC6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:58:25 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B32tvGR015500;
        Wed, 2 Dec 2020 18:57:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1zQp0AXrf3cHHfo0Za9XIhmPZSmPqpOpz/l5UESdNMU=;
 b=qH1IiRP1EJr/Oq/sXUwAbTJ2YqlMqrqw1xJ5DFYh45In2VA+WaerX8X3mhvb9wzVOnB2
 6xEo5kg+u2s1pSbvbPMHbZ+ROjCCFHr6D6LauueRJqRJaX49kouBky+e33aPbVB9jjpS
 V2wIYrlkuTzyUPwQN5QPKed9BckJo3T7NNE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 355t7yb7v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 18:57:37 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 18:57:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnIlfkAVdTs+BC/Eg0VgyE0B3KF2p+Apa8JG925lEA05xZLyH+UMRvZAWHW9W7mVa4oIyqDCCpMTBdqFE9D96xRjEK2LQwaDAOq0QnDjqcxuidr+3E31M4Wwzl/TR9ZW9srKHAknSdvoYM7ZGFSOxLciIkhhpykXZp/e13p/njEzHUR7h72tC9SDNtJsnqsR8pgtzCwFP2aTYxtIPEU/FxfhdA3m8zVCOltesYvvlEtX/z317us2yrHNzMZz78xAZpw6eRwf4GgzVUpV/htKUFe3LC/XkhIT8SMfpPkKH/gZaY9GRijdfFwt7vZaV0ZJSkOWFjnBzgbrMe0B604jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zQp0AXrf3cHHfo0Za9XIhmPZSmPqpOpz/l5UESdNMU=;
 b=ar641LZqgJQZqvEuu6kvfDmAcENx91bU2jmrvQjyDw2nFyDT8Fdtm/8q5w9UjrTf4z3HjyZU2xWrusHjsmNiCQ+WEIjQfAKDqTwOVeNnjXkkrkkQ0zmGBh+9aBPWO0GbHXYNT7HiaSvBJVWJzZf/nNqoTvK0l5m3rurfMd1h0AnU3RO0PR3bWkipLsyanjbrhZtu3oer7+YXCjhIVvcgcYW6BN6ux+GoCKdmWtqCDtqk/mKYs05uhq4zZxRukhQRC1QcpTY/eNMQCifAhdPu+WhZ2J18isfrzj9msSFFSjx9QpJAnrNldLKEuO0mnndxqOMK86hh5b5gde6xBoqbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zQp0AXrf3cHHfo0Za9XIhmPZSmPqpOpz/l5UESdNMU=;
 b=k9hOfGQSLiCcFXJNABKfSJicSIop0qsAxeCvrsRO2BNRvAGI2+FTzIp7/fDUni9yX6K7lyJ+iHxV818P1FnrfiZFnZ/WVhQmlmbkGnR8KjwJ9O10Om/ED7Evse41TlWH00G+BdothD0xdYaS3sxADbYTGX/52g1JQLyYKKn4HlU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3521.namprd15.prod.outlook.com (2603:10b6:a03:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 02:57:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 02:57:21 +0000
Date:   Wed, 2 Dec 2020 18:56:54 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] mm: vmscan: simplify nr_deferred update code
Message-ID: <20201203025654.GE1375014@carbon.DHCP.thefacebook.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-2-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202182725.265020-2-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:df49]
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:df49) by SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 02:57:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11ec4f9a-6582-4802-cae4-08d89737273a
X-MS-TrafficTypeDiagnostic: BY5PR15MB3521:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3521B54DC6B83ED155E47E1CBEF20@BY5PR15MB3521.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFuO4rhzSybyN4naqrCuP2LRcVoYSdXPNN93S2RWLjFMdxpw8/TepuICszZHe3yLIH78bxtvjYZ1m+YDXSY8MlcGl+gNYKV7EjMxq2bwvY5tceY8EcacPQg3SHPouUA2tJzPcbpUz59QQq7+HGIVns2xPcWZ9/efeuWaO3ExVNaNvahsIsmpFhgYbnq/W3bN2y435LJk71+fF5CTf7ac5q3CrgIek0f7LHaror4oarQqHTqqVcC5Dzpzv5la2pZO15zJ2k6UTNyHLoDPSNM7tDHqAVelMH6j6IVsKiADTSdbfaGbH+WdTI7pSv1G23l0d7MC4o9HTaRgFB0CuA4KkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(396003)(376002)(186003)(6506007)(16526019)(7416002)(55016002)(33656002)(6666004)(86362001)(316002)(83380400001)(52116002)(7696005)(478600001)(66476007)(66946007)(4326008)(15650500001)(66556008)(6916009)(5660300002)(8676002)(9686003)(1076003)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RWCeadvTIWXuVdSJskI8wDRqOYTqigrDk9LmDyhtHOs7svLqdbCxMNja0IKb?=
 =?us-ascii?Q?DBW5xPtIyRgPTK2sc1RRaQkMie5nBQiUjfVGcs5M16s9NOogyYuMmx2xk6n1?=
 =?us-ascii?Q?tOWdatXDV7KJE0787RgzDMAvqIib4S+ycjxKaUm3fYKS2dCcaSlULJl6vqbZ?=
 =?us-ascii?Q?/Cu+gGatGzeIOSeocfWrQZ1SMhTppvuIdSj/7GhsiXkqcVRwdDQBYqM46XQw?=
 =?us-ascii?Q?F+dD+SakcNBb9AjFJjxEkCEq1nO2E1xkK1JvI6pg/T/waA/ReYhLUaXqKAMg?=
 =?us-ascii?Q?myTLN7qiKBEAAIP5k+beYl5j0akHjmRnYxGuU5Ztfh3sZd2TzEYZVonuSF6Y?=
 =?us-ascii?Q?hurmLfb84RYYlJaQqh1b+xMg/0ULlz40K0V+7EBEnR1Jl6udOkyOn/mYmFZ+?=
 =?us-ascii?Q?nQVGykfs5T29uN6YK8aP7VYht8a5dKqfqpsq8p0NiYuQJc++7W6nPujPL7M5?=
 =?us-ascii?Q?2tGuCro4iwRrJoDRrjdbj1TZThk8uR09ODACSN30PelICzIEAdxAstcvIxJr?=
 =?us-ascii?Q?CvDIb6ek1dyr34s9GMlV9Fyyl9ILBSo1QHbA47zEGp6PxL86zddHbxZ9Bloa?=
 =?us-ascii?Q?fOWlEqRGi4GkNRn8AfceiJOD8JjjVm0r2s6ViUp/P0cfn7bS8dlPQs5uBFHI?=
 =?us-ascii?Q?uZ+vX51xDcqWo78XrZvwEL6Gp9CTc6aSGBGZKILsEY4T6g3akAZLgz/BNZkW?=
 =?us-ascii?Q?rTnBkqCLUSB7NwsE5lRkZH8Qt4CZBeyRgZFDUD82DJQUWi0mviz7Py35k99Y?=
 =?us-ascii?Q?9DSzX1PJyIgATjcIcDxTPaY7AIUz1WWi8AbDX6f59uHxPD81gWOLyk/Ue4dG?=
 =?us-ascii?Q?qw7r/zauPDUr0/PM0CHcX/qD2HJZolyx0/hdzg6fwqV44+OslcsIqzHJZFXu?=
 =?us-ascii?Q?MpesvIQ8SASowxJ3/CdUyIt3gKnjFScdN3OOvLa55Vvarr9kjqMleiq/sPcj?=
 =?us-ascii?Q?x5pUkcB8s+xi5v4j7i6PiK13U83Ax9UTIIBt6hZessPw38UTXUNxyUX18fV0?=
 =?us-ascii?Q?v67Q1THb8RS/You1eX3SN0UnxQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ec4f9a-6582-4802-cae4-08d89737273a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 02:57:21.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnwFGfasUZohJ5JkoBstJ0ZJo4Dv9RlCx/z+qbQvDTEk9U5GXn6kAPDlcG5fjHxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3521
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=1 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:27:17AM -0800, Yang Shi wrote:
> Currently if (next_deferred - scanned) = 0, the code would just read the current
> nr_deferred otherwise add the delta back.  Both needs atomic operation anyway,

But atomic_read() is usually way cheaper than any atomic write.

> it
> seems there is not too much gain by distinguishing the two cases, so just add the
> delta back even though the delta is 0.  This would simply the code for the following
> patches too.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7b4e31eac2cf..7d6186a07daf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -528,14 +528,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		next_deferred = 0;
>  	/*
>  	 * move the unused scan count back into the shrinker in a
> -	 * manner that handles concurrent updates. If we exhausted the
> -	 * scan, there is no need to do an update.
> +	 * manner that handles concurrent updates.
>  	 */
> -	if (next_deferred > 0)
> -		new_nr = atomic_long_add_return(next_deferred,
> -						&shrinker->nr_deferred[nid]);
> -	else
> -		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> +	new_nr = atomic_long_add_return(next_deferred,
> +					&shrinker->nr_deferred[nid]);

So looking at this patch standalone, it's a bit hard to buy in. Maybe it's better to
merge the change into other patch, if it will make more obvious why this change is
required. Or just leave things as they are.
