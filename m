Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3E72500D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbjFFWlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjFFWlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:41:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DF59E;
        Tue,  6 Jun 2023 15:41:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IYhGi032139;
        Tue, 6 Jun 2023 22:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Fgm7Ilf3qWVvtzYn/rkTb9MA4jQjgNnaCdv/VkQmcqM=;
 b=FZqSSZysdh8pGoZ1k5VYgESU9tA71zNlcbfzE3zur9BNhRtY9mhr6muzkQyZrTxy3Wj7
 XkCCBRXfPoKrJpHriWcxEQ6uEXbukdPy6wX4cwg5UqJAVfYpXNkeM3H03egLAuiUaXEM
 Tvs29yVW/FJdQuo5FTMr1ulNnHrrEGjl7dmEPQsr7l2Quv22JmRX1jCDuJhXAX0WPLaJ
 4c73BOVwn2IqaYakfwG4wafz7CsRHwRgj1lubJm5Uzm21aiKAhPf8bua2Kf1G4pKg9U8
 IvZH9+iN+EL0kFzyI0oO3r2QPXXjcu70X6dfUZd8wZlw+B2+5EGVuEATqrqRlRp897bS Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6r8dvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 22:41:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356Kc33T036598;
        Tue, 6 Jun 2023 22:41:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6gffhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 22:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqvAsi9FqMuc2vrmKaMOCv/8Erz5f3Lnbaloy0RseD5OL094q5Ac4MQqCDWlzQvPQ4M7waXI2YFF5jyDHzI/Odl4lVDNOTjGvMvcomFNA7tOt8L0U29Fo8zyWkI1nJdyxkM86et1E9pq5SeXUEuRn4yLuXKNTTK3XXdMlJpfMsavGlqklZOvqzJVELlWL3HlCUcltxaBG15Eztr0rdok1SkDJGv6joBqAr/a6a3QK2GSkIER8hsZvwIh3uqCW91ELPpdv1esrp/TQIxIrR31rPSSd6lctvnALqfDBiY/8RWFakKVb1aOcQ28bHS/vJfAeBld4FGVBZ3m/4Rl2l+yEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fgm7Ilf3qWVvtzYn/rkTb9MA4jQjgNnaCdv/VkQmcqM=;
 b=gXj3E+lHFwT5L0+DTsy8gcy5wtXJEm2bVe6N9pN+MO+ebnsEoR7rM6U0znM4rVde5DWXIhDS5FGimk8GzbZ0hL9Dxp86nNVIoiREYJ00z8uIGpF92j9rQix3w2qTCNioVp9LUE+zmsdoxdeE/3o/y1B4/Ej1dOjpaj/1OB+dM1Jwm8Vg7cy+m3OOEGvANi6atVE3x790gFxPPTA2zY6mYavRzwBkU1FpN70sCMR9CfXFPOWulJX2f++gfxTJqdGFgk8VPNfZCsoR6sg44N3m7xzE+ahBW8PoBfCmLlG/d5rVLGhzJbhgZwxVs/PwNhGGYOGLP7jZ0VmkiNkpkQ3pIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fgm7Ilf3qWVvtzYn/rkTb9MA4jQjgNnaCdv/VkQmcqM=;
 b=rqKbLVoG18J4WwOUJebdkvbz8DK5cqRHfV18/QxypRROH54Tn9iCKj6+qXbodnNkXRRXiK/w5DlJUKeMjDbcA8nF+vaBo1XKVttoIoXEii5BYALYFpxVkpWkt6GrPCOB1acBp65g/Y/MtuaJ3aKyX7lGpb9BDBmlRVaNcKY2H+k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 22:41:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 22:41:04 +0000
Date:   Tue, 6 Jun 2023 15:41:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, songmuchun@bytedance.com,
        vannapurve@google.com, erdemaktas@google.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/1] page cache: fix page_cache_next/prev_miss off by one
Message-ID: <20230606224101.GB4150@monkey>
References: <20230602225747.103865-2-mike.kravetz@oracle.com>
 <diqzttvlom5g.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <diqzttvlom5g.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 125dcb6c-cd26-4f4c-41fd-08db66df1c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuBVmP89io46maUZFIxDJnJQbtApASuMpwyFzf6biqPWTKqp2LaK0JEpNU25G3H2hm9A9bU1IwY9EKMeAhAcZIEv5uvanzQbWAdLpwxUSaGWbn+wUt2b+4hw6rZ1gYahVe3aQKM/XMHHJL+Y/rhiGo9OBFTcCUzjZAHAhuYuvzR8WtQNGhOUHF1xmc64PFZIyRoC1KVG3ZYA+XVM3WcE2+0VkHnTqFSq97UrhuYzpiB0Nl2/Ian7KmsyNUXaJtILzoJwN3tk2ImMCD/87yHWC0kKY2zp96u9tXA1pybU2qQMZtFOlYxRXT14+URcS8KJmAVmiyNeHApkVcFzobCPH8AHIp9ldIlWs5EhoAUhfzMyxwlLNl2IVRzEXrd7kzGVLzS+vla05cOa3uEBfuf/bf5jlug8mfDfyuweimFfMAAlU1QUvmGKsFdolEgj+fWQ7qIiti5RHHhRddoUcyRUaqqSk/gndP2dWiCyb0GLPI/5B83kN8kMj/5Nv7HwQBsH0xgvTvSi92+aT4CzY7i8GAQRWPYdnw2xQdOW9ojry3tEWhCGhna3sDACJTQRBnXo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(86362001)(478600001)(44832011)(33656002)(8936002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(38100700002)(6916009)(5660300002)(4326008)(6486002)(6666004)(2906002)(6512007)(26005)(33716001)(186003)(6506007)(9686003)(1076003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mzgr3+y85wffJ1NAdcfxLuPeGvtmUPUDJzCo27uz5W6xb/++K6uLKjgPsa9Y?=
 =?us-ascii?Q?zZxzwf7Aui17zzh+q7LK78yrZwwO0ravRpW/knf4FUsPcUvPU83Ua8UqmEiZ?=
 =?us-ascii?Q?OtIAgExKE4TXmvI8J3yWcwMFQPaijf4YyhgeuVowFE3C+NZeLWcO1fFWwVJt?=
 =?us-ascii?Q?liffovnImeD801ps4CNqgcRx9zk9NxonUKP5hT1JelJG5ECz/1/2vRW8AheA?=
 =?us-ascii?Q?W2AtUjGk/+OWMmt8qbtTP4xGRSTXeB3RpwCtm9LkvlEDFzmPcyXC65dJGps1?=
 =?us-ascii?Q?+DTFcagvVlB+MdCvK0JTBPyieoaxPodOFkiKDHSjrmmMmCj1f69iBs6tEhpm?=
 =?us-ascii?Q?ovvcQ+kKhDb5mdMq2E9FPW/EhTzr663wOTJ2Cuebqqor7V8s9zTuDznvtJVw?=
 =?us-ascii?Q?IMWUy0h1ilsutaj5kUtfvloJDD0ZUNe4FubZ6spLqgWdp8DKOX0BO8PI0cj2?=
 =?us-ascii?Q?zPfStXZiHCXpivq/WNRsn4CYouAB8H3mbROswL8pLSs33OT2kmzYfYzFaBOd?=
 =?us-ascii?Q?HVDSjrSg0XXs0Z+NeBkdPlBLkgmTmM/MElPSkrU+RUFGhUXVye4qwhHJSQtU?=
 =?us-ascii?Q?Du3fdyeCLwVMPxNm4aZrqsw9PgbvHEGbSySgRAwgi/mwEdmnPZj3FHxu1Z+e?=
 =?us-ascii?Q?PsZvnDOQny4gTKtIxShsHmztVQq2qFYkRrqOf0y+7lYuMoyI8pouoky58MUm?=
 =?us-ascii?Q?nlcNoDqQ/ysRRo4pk2t4q+CUtGHXsovDhZ+nnc1fc2xqOFVKfn3Hk3fqHUuS?=
 =?us-ascii?Q?LFh8lJQ2S2bYae7XpaJlnmjC/DuaBwXt+FbAaxuGCnrADrhgKI+OnQfSyvGZ?=
 =?us-ascii?Q?IIhYJHvUn4pp68nCOPlC8ValUoK9TARsmM81bRgGelPoGhXvKgKfCkmZ9y8+?=
 =?us-ascii?Q?skNSFeBVWGjf+O3jPgXgwRkIqcKP6zh1tB0Yv5IfH1ft9dSqnxl4DBi8MLC5?=
 =?us-ascii?Q?G7f06XJExluS/6cZ7fEX9RMjsJEhu3GzHwkII/Irt2Jiu0KgK8GflT6UgYj/?=
 =?us-ascii?Q?fGhWBFGsBjuHy7OIkIjyNORihgkTkmIEIbxmhLt1ORuT2/7lHACeSGw6C+xC?=
 =?us-ascii?Q?wJEbaMY6BQ4A7Trm9oWYDu6HqLK+vx9tx5XQskBUnnFzRC87UvKACXYL2HYx?=
 =?us-ascii?Q?b+00lOpvKv8Jyvsl5K7PFMj8Es/MxmzjDFdmaEqAiLGkSWNj+jzdvfvl2lAn?=
 =?us-ascii?Q?FlJXmdrAYc4U3LOfUUFd1/OMOm8iqvt0Tirbj9SxWqFm1+b/nvHvFFpUPH5w?=
 =?us-ascii?Q?UhjBEqQVfitDvi3puAM6ecP5spo1H+3XL+kB+nBU4WAVuTQKtoTIoNkNHrB6?=
 =?us-ascii?Q?pO7eBVHMnPdpexZdckItJCrP6zMrKTHC/dAuh5oIqgFa9pDf/x0JDTLClTQy?=
 =?us-ascii?Q?ScKas7wGZZSM8o87dWXveaf6LBuxbIYxg6cFHPOC70ms5ZaBBPkOEpKTBrjY?=
 =?us-ascii?Q?hd8+pSamAYfF339M0Q6hKCrB/kuyp3Qj/L1nRl9/bfefZryMTXyZYHT5m86H?=
 =?us-ascii?Q?dHqBHz5PwXu0vIqbQ7ldJLmSSBMKyC52JrtbGzRgfnXWg3bOEKT7DPWJ4H8y?=
 =?us-ascii?Q?PYe6lsXSt8Iq3YSJvlA8r9A49bqMgOJb3FP6CibJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Qis1yVD9hTrGu3RIcKvhol220wy8Cx1mfXm3eWxM5RLP/wIkSfAdy41EitQO?=
 =?us-ascii?Q?OhUPWTldrO9BL+Yga0zZd5aW+Y1LoaHGBfi+ScospFNcKZuQRy2ZOHQ8ZDaY?=
 =?us-ascii?Q?EbcYJDNPNQ4DzQThHA6n7ioGpWWB56YPJso5EVpcwrmRGcEbavxBSdFS1iNq?=
 =?us-ascii?Q?eLpWciHCpvpby7Q/fyKzr3WIPWn5Rt26Bak27/mUeWXBBh+QmRgDCnwbMcxr?=
 =?us-ascii?Q?3vw3EIoAaLhaH6XoGlsXKsgrNVOfHT3JgTimRvdTmdkY0ITt9Bt9iM51Jewb?=
 =?us-ascii?Q?6pDkhtSlCcN7DZ0Yslv3dWLLVl6yO0hC9ymk8g1Mm4nVWNZr8FqIiBSiToU3?=
 =?us-ascii?Q?g9n/JStLKLHqNweCyLbxJIyu5p8PIw9/4rC32OWgTfOqIaUR1KlNH+m5qMk8?=
 =?us-ascii?Q?8TnrFhfIm8ApjOETXaOQHdxcoCYyyvwvrQcwzP66BA8KPJKupyhgpbqSZ57u?=
 =?us-ascii?Q?n7PFUKh5XhoMtn0ZiakVMh3B/8xYyymHih/icTl5vxBbAIwbBcCJaj9gW71M?=
 =?us-ascii?Q?QkKv+kT7PeVlhJe9jIMks1AQwoqOYRPb/4tD4h23xq29hT45XEERe3RsXqph?=
 =?us-ascii?Q?Y7eY7t726thTxa1oYGccVLNsj7RDSY02vrRNwJlOC3BSR3qQ3xPCU65XiRMd?=
 =?us-ascii?Q?KA/mLn59yYP9AymB0Lrsxf/E7GSApv/kUJiyVDCXL7u8z3dIpOO0cXWCg9A2?=
 =?us-ascii?Q?Db+yJcXxk/Ifh/wBnIHq317AgQtjH+q2ueWxGLJbLDawsT8uKdY9Me8J6hDP?=
 =?us-ascii?Q?bco9O5s/XzQeZwrDoSP8lMkye+E03jNVcSh6jSJPMkmBi5FQbfiNqLaIPZWu?=
 =?us-ascii?Q?vW/hDJHDZg7PJD+i0Iy6ypFF/moLWAl5aU6DE0T66AayaLFwNp7HZdP3GELf?=
 =?us-ascii?Q?oSmX2a68Xi+Qaj1MDLIaaisALkrBvTdFkMlWXCq8TKlfxyQYid1gRvhb1scG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125dcb6c-cd26-4f4c-41fd-08db66df1c0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 22:41:03.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5vXlCbjjRsVpRdutD+uiQat4c9UWV62XAmALHJ67MZchrbx6Ybffyn7uEbt5HOQnOowGh+qfix30qbZM1TbBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_16,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060189
X-Proofpoint-ORIG-GUID: Q2hCoZJxXP2RZqvGcRJLwOiLacu2sO-z
X-Proofpoint-GUID: Q2hCoZJxXP2RZqvGcRJLwOiLacu2sO-z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/05/23 17:26, Ackerley Tng wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> This doesn't seem to work as expected:
> 
> Here's a test I did
> 
> /* Modified so I can pass in an xarray for this test */
> static unsigned long page_cache_next_miss(struct xarray *xa, unsigned long
> index,
> 					  unsigned long max_scan)
> {
> 	XA_STATE(xas, xa, index);
> 
> 	while (max_scan--) {
> 		void *entry = xas_next(&xas);
> 		if (!entry || xa_is_value(entry))
> 			return xas.xa_index;
> 		if (xas.xa_index == 0 && index != 0)
> 			return xas.xa_index;
> 	}
> 
> 	return xas.xa_index + 1;
> }
> 
> static noinline void check_find_5(void)
> {
> 	struct xarray xa;
> 	unsigned long max_scan;
> 	void *ptr = malloc(10);
> 
> 	xa_init(&xa);
> 	xa_store_range(&xa, 3, 5, ptr, GFP_KERNEL);
> 
> 	max_scan = 3;
> 	printk("page_cache_next_miss(xa, %d, %ld): %ld\n", 4, max_scan,
> 	       page_cache_next_miss(&xa, 4, max_scan));
> 
> }
> 
> The above gave me: page_cache_next_miss(xa, 4, 3): 7
> 
> But I was expecting a return value of 6.
> 
> I investigated a little, and it seems like entry at index 6 if we start
> iterating before 6 is 0xe, and xa_is_internal(entry) returns true.
> 
> Not yet familiar with the internals of xarrays, not sure what the fix
> should be.

I am NOT an expert with xarray.  However, the documentation says:

"Calling xa_store_range() stores the same entry in a range
 of indices.  If you do this, some of the other operations will behave
 in a slightly odd way.  For example, marking the entry at one index
 may result in the entry being marked at some, but not all of the other
 indices.  Storing into one index may result in the entry retrieved by
 some, but not all of the other indices changing."

This may be why your test is not functioning as expected?  I modified
your check_find_5() routine as follows (within lib/test_xarray.c):

static noinline void check_find_5(struct xarray *xa, bool mult)
{
	unsigned long max_scan;
	void *p = &max_scan;

	XA_BUG_ON(xa, !xa_empty(xa));

	if (mult) {
		xa_store(xa, 3, p, GFP_KERNEL);
		xa_store(xa, 4, p, GFP_KERNEL);
		xa_store(xa, 5, p, GFP_KERNEL);
	} else {
		xa_store_range(xa, 3, 5, p, GFP_KERNEL);
	}

	max_scan = 3;
	if (mult)
		printk("---> multiple stores\n");
	else
		printk("---> range store\n");

	printk("page_cache_next_miss(xa, %d, %ld): %ld\n", 4, max_scan,
		__page_cache_next_miss(xa, 4, max_scan));

	if (mult) {
		xa_store(xa, 3, NULL, GFP_KERNEL);
		xa_store(xa, 4, NULL, GFP_KERNEL);
		xa_store(xa, 5, NULL, GFP_KERNEL);
	} else {
		xa_store_range(xa, 3, 5, NULL, GFP_KERNEL);
	}

	xa_destroy(xa);
}

This results in:
[  149.998676] ---> multiple stores
[  149.999391] page_cache_next_miss(xa, 4, 3): 6
[  150.003342] ---> range store
[  150.007002] page_cache_next_miss(xa, 4, 3): 7

I am fairly confident the page cache code will make individual xa_store
calls as opposed to xa_store_range.
-- 
Mike Kravetz
