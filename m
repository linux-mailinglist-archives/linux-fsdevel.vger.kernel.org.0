Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751303159A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhBIWq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:46:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234414AbhBIWZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:25:15 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119KXd6w010307;
        Tue, 9 Feb 2021 12:43:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uZzunr2xxzpMFULhiNQhv37D5PIPxL8Gwlc2sv7xwPI=;
 b=Tqf2G/1QSg/du7JlOA97zSZUWdCpXQPYZtgXyFzMqUnJZVVHZWV6TcbXKHhDwYQxWWEi
 c80S95E/uMH2f2wCQXPEDtgfz1hTzLdp865HLCuIpk9jj/LDpm9iBQKey9pWcV+l813/
 As67YDmcE1OxoIbS85a+XynxlyXtgYph2QI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1cdn49-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 12:43:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 12:43:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moJWYL+LzF8lUNrhXiG1dHqv8BIMC8ucOgav7K/+p6blEfNKPf/8snQxE0WXMU3RpNWEaLLVaMmQqh/YXczBExQxzPUaCFsGkmfKEgXeBeIon0XQg5y4+VqD1oKEDzY7fYMmMn26pIdfTRe8qYpsT6Tuxtl/ZBUh6HAuVdlGrmazF8J+FMNGFYm3eSaapWvsoV6hVzk7SeH56wSQ4sNzscpIcAZ+8lExEBlnJqCowr7N7XCcOwezIOQOyQzpnR825+3yHf3e2Rvui3tzCfraJMFhuJAYj8oxwSJYM4IaAgPR0Y1ryzWPXKGcYApxmMir9De0WJgSuEx0eWlRBX8sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZzunr2xxzpMFULhiNQhv37D5PIPxL8Gwlc2sv7xwPI=;
 b=oEUp1qNSt1HajnmFkGJe9CB97fVST1k/1TiwOMuaKDVzM2pZGk0RAaHl++8sPMnfoTLTJa1Pozv+RCBkhamdoKE4eY+nGX3QRIaUUdTEy7xlMOukuF8ebDZKnUhUP5Ym4TyQxU4CV/1vNkv6nd+ys4DKwe3dzocVBzFBSerS4/Hzee4XTpBr6CPSKzMozUkG2bR+1XDl759kaGl6HCjFzDwb4FY9PU1l3Zt0rDZ6kuMNSH6p0/F+yAbo4A3SFjf7lxUjX0WItSeKF8H5vdItPvrVEElK1LnLFfcBPX7zNbtAjo46AXVOFcbWulejk3vZqq2wKttRptMzRA/o0PWgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZzunr2xxzpMFULhiNQhv37D5PIPxL8Gwlc2sv7xwPI=;
 b=ikiHg8cpJZFMbm2p7wx9W0v+eDiF7TXvL++VDmBnwKbN2wd+PP1cTXy65vWlj7tMarlnnScvTujJmuK+IHHUaQZAP7kIlyKzm7O7kLYNFm76H+eCfoQRpzPRfOd88Y8ihJkF1QhoeMPlFXFRwJTVfhYTnKn0e/1N8jgXl5abst8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2390.namprd15.prod.outlook.com (2603:10b6:a02:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 20:43:19 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 20:43:19 +0000
Date:   Tue, 9 Feb 2021 12:43:14 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 04/12] mm: vmscan: remove memcg_shrinker_map_size
Message-ID: <20210209204314.GG524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-5-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-5-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:cd24]
X-ClientProxiedBy: MWHPR21CA0037.namprd21.prod.outlook.com
 (2603:10b6:300:129::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:cd24) by MWHPR21CA0037.namprd21.prod.outlook.com (2603:10b6:300:129::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.0 via Frontend Transport; Tue, 9 Feb 2021 20:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da2ec57-9e8a-4ff4-c762-08d8cd3b559a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2390:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2390E0D010B1C11D974875F0BE8E9@BYAPR15MB2390.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWZUBn2AjFG3V3vdYvIYEQLEdMOLSUEMJUZDkt8P/VLSjCfuJoofGyqs6HeoCkgqpBRqGnOvgg3HCbALIxeSA3aI0NU7Cr9nlVOIs9HemeTObmn/JR5TDRA6giUaJz+s3XoDxTFJ+nn3Dcxc/G1aLRor6uVCFxxL9Z1ENq0gl3Qo9TxB2Z0Yq3EHkBRGaRuVzcAhA8H0CBgel9IZhAZWXNQ8thnqJFvx1sWdqpa8ClWll9A9QTxNEB6t+YdHa6qTv54mFvV3fYpiizrKsuU51WjUVIX787EMgt45wxQI9Y/L3AxgMQHgJOgvZ/tjG6x30DrJ8ltVgLJHdqh6M/H+yWr0NY2Tyr3Om3lI0QRuLAncgQn9//LSgDNU+tW3Yqhaq1ZMV2m8ug+iwgEChjMGsiIXTTeIIkO4OuISXq1G/mXtBehUbKT9IQaA9gXsOII7vkgmNQPc1YSKkWIWNrB4qOPReekIflG3TEPP+eWXoIm+fcknLLkRLwmG63NB/Uima13GnqgP34jJ+gdv1gnaAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(8936002)(186003)(8676002)(16526019)(2906002)(7416002)(86362001)(6666004)(6916009)(55016002)(316002)(9686003)(83380400001)(4326008)(478600001)(33656002)(66556008)(52116002)(66476007)(5660300002)(7696005)(1076003)(6506007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?76xKelat2e9FpU8vLWaY47xeJSKJwCJJ1krs0zeZJ9TAvdrW4Obd1AMFN2/O?=
 =?us-ascii?Q?xpw6xDNYi+7+o0NbQkwaqla5P9Ff299TC5KU17kS59M9Hui3FRBJ/l4kweux?=
 =?us-ascii?Q?7cIxP1EiYwIcJcBHXD/W2Ffz+jWOcbFaxJH/CJmAFlsimhLrkLHwn0zk9WwQ?=
 =?us-ascii?Q?ZdBibxZ2QAQOMHya1yxjLiqWu+6XzhQcVK/fEkC/7ovRAMeD3DBHgLtLzuPQ?=
 =?us-ascii?Q?zR8WcCQJ/zGerToCc0+YKzLW0RgM8vOAIymWxmjb/gn9+EEQuwEj6+sLyZIO?=
 =?us-ascii?Q?jsF1v1ajB40yAkFO91hKyHva1ykFQYSmFK5eg9kT0W960i3meQop7UdmimjK?=
 =?us-ascii?Q?6DehHJo75iFVY43O/R20viVTvfkVmrq0xXcSrmUjjuKQcauqv58/OiCt2d+j?=
 =?us-ascii?Q?jVN29/UOAm7viZk2XqGs14ucWSu2+E+IOi+bLoDyrbp0p3spWcVXxbPqmvH/?=
 =?us-ascii?Q?By8RyRxKZDGnD4sZ/DUIBeAwz03nI/YbThEuWg/svrBlLs7DwhzqDMLeph+B?=
 =?us-ascii?Q?BAoetliCu9AUUli5SwQ/9/NJFQC14Z4Yl0ZYJZbopy+vZ9cYw/EBac1LwWR8?=
 =?us-ascii?Q?bmjFMM/u7+s6iERRNYN4D1MW/Hom/J543nnEcmDdCpkVZUpiyHLYU+ckHIDX?=
 =?us-ascii?Q?39cxo5E7WO2kWNGCcwrFUlllk1pDUx1T5yleVjI+Z2gJed9BQDbvXr1h4Hm2?=
 =?us-ascii?Q?kxt7W/tGkPKRpOcZXtqk58vG9A/1qE30BrT3xfJmpOyEUlyAk8OYEp8iw0/w?=
 =?us-ascii?Q?X8EPWWRstQXd+40bI1C1Y19fPmB4QUK9qHiIROtyaPk7ZRMB3CiWK15zS2qe?=
 =?us-ascii?Q?nxhBQeM0KBVG+XdwqLhBDzQcojA44ynxWP93E6AycTNSBfqE+ExZNj4kNy9S?=
 =?us-ascii?Q?eFFFLkPYN161GuVO+IqGPSj36Zyn/t+X3RtNujgwKGmPTT5WHqD4NJvkhnCw?=
 =?us-ascii?Q?w24X1cvRnfewv8c9X7vWE4p/AEImzLRoRr6A92rmC6zvPi7GTIsc6+I89X1S?=
 =?us-ascii?Q?2yTCNAOi8guF+dX5hhnMQnPZuUJRC1UP+2WrELysmD6ACeQ+0fVLXVaLYgRz?=
 =?us-ascii?Q?yixNbSQJr0EPuqFwus/PITQs5hS4aeZQigczYdB+pwHm0z/EQUawjLpu5Fr1?=
 =?us-ascii?Q?78ZkFFl+88yKzq42oxivwRZ1I7TZn3IcgLbZkqGzcJ7zQf5wiyL4cz1DsOrW?=
 =?us-ascii?Q?3oXERBDKr3hnCi8c5YmWhGvP/Muikp4e9kRUfiRgv68oWYK7LRrd1C3074jf?=
 =?us-ascii?Q?5dGzs4nmmObuanq/Y4gYM0xZf3QHRCYocv+yUFPHcTbn1PYaNECZWIWiToQG?=
 =?us-ascii?Q?asHCveOu8yDEVPwUmZN90ufoOydEQ1rYvWN1uYZlor6pJg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da2ec57-9e8a-4ff4-c762-08d8cd3b559a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 20:43:19.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNMXgxfqJbccXzH95s7zB428J34pyQvblkC5Z9sgQFKEAcTaHWaMVx7LZSuEzGm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:38AM -0800, Yang Shi wrote:
> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> bit map.
> 
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e4ddaaaeffe2..641077b09e5d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -185,8 +185,10 @@ static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
>  #ifdef CONFIG_MEMCG
> +static int shrinker_nr_max;
>  
> -static int memcg_shrinker_map_size;
> +#define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> +	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))

How about something like this?

static inline int shrinker_map_size(int nr_items)
{
	return DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long);
}

I think it look less cryptic.

The rest of the patch looks good to me.

Thanks!
