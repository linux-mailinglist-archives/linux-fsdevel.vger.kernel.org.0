Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CE70AFA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEUSs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUSs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 14:48:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF0CC6;
        Sun, 21 May 2023 11:48:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LBpAt2017949;
        Sun, 21 May 2023 18:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4EkRXX94RqTEwAGyE9zK5IgmXV09Bd6kiLpZKnepLJw=;
 b=AciH6LRbEmZakRLgvKndvCiJNjtdo6EN4oGmwDQFyC/ZKT9ADI6WzpLKP6es0c2T27gh
 qRES7gOn7clJlj+CCL6GB/Ni7ju2iMo98HJB/KOGT56KCqRUeEThzp1B4whpqcI0bMQE
 M2xAcpIdoNREi/PVAx1qtM7CsIj48i3D4EVnYND1MGP3B7KPd9nKXO45YcwWEj4NVaZS
 FaGUDmDbPqDXi1P7JNteK92jgfW/j7ibozwp1MFC1R6pQGtdIzKqNtz/VFirg70h59nj
 53Cstg2sgaTw/dZyNrWh4K5lz/Uyucd+NFtgZ/cFg8VF6SGEu4p6PvNGSy8ctB488Drf dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bhea6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 18:48:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LHUTpv012874;
        Sun, 21 May 2023 18:48:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7cnhcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 May 2023 18:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAC1tmKlfnBLyWzqVUyq/KwLzgq5m+Me7Jo/FaM3xdme321HavnD+lQdWP/TuFImU5EpwtTth+usg/LMJO53EJMN+HcAmX0LYzZSTcakcQZ5ru/tuAsXRk0uKdemKhJ9NdO3M4nZ+CebaVoxiBoPqXaThezEhb5MFjjbgk1B8UhwFJ3/ZE1IlrZ7Uih28AAKqnIJq+AbDYWTv3PP2IE9yQG9SnDjnUpbvSzqTnkZLT3hR1YkvP5MeNbKLASQx4wNyzSs2Q/+INMNqXD+8CNYWHRKkaaVSpQvniI4/AZWgOdrar+fvr28izBu7H3JfYpaVmDCBBB1g/xk03ggxsOhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EkRXX94RqTEwAGyE9zK5IgmXV09Bd6kiLpZKnepLJw=;
 b=OGRhTsivKSaG2jsbjq7xMZd2wPhl2O0v1L54aL9nuTwzyMHjJs/oVQVSj6xljnFm+hF+BP7oQTGU/KlCZ0Cf9bOKXRhvLE0YbwaHj0dL+eCzAyhFltdI7uyDkTPu7m9XeiFOPAJ/QbIouxPkwaHSZd6QVHaGIVImbYGiVcTOwgY2HmLLmRTI4wWCrW/dz2Hsy1HIRyyfpVfbOLMx36kIRrJ9W2epu481N6EKrzrU/UZ/acsC1zViQikyTT96RQ9lCHJWYMXe0b4uRqJ7yZtGqS2yaqfDSEHISisWOmSKtOs+S3oxo8ttkg4UE6id0/ll6rJNR7dEmGkEQThUw50ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EkRXX94RqTEwAGyE9zK5IgmXV09Bd6kiLpZKnepLJw=;
 b=lK6vbclO3ZI4GWvhE3kPapI2eoUVgcwIs2VOFdZ8BeJl/VlLUaqiFxS49zTKWAu4k8LBJ1gtyWN3VNjsByBqZvVRKgdjMYM4RYV8rqYL5o4kx+sTPVdq1eDbW3GtwIX1xUaGlkCwYaQKKx0BtadGYqlpxx2NoIPcaDM7ujBOkbw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 18:48:46 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.028; Sun, 21 May 2023
 18:48:46 +0000
Message-ID: <e6e38693-38c5-d944-08ae-258b57973d97@oracle.com>
Date:   Sun, 21 May 2023 11:48:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
 <d6770af7219b19dfeaa05a271444dd462c32943c.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <d6770af7219b19dfeaa05a271444dd462c32943c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8ceb79-e5a5-4ebb-3b2b-08db5a2c0228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBYaRAAr4SljWZVISMGmR/NJv6uhQhn60s00NeyG2OhHilUA+y6LZtK8hsi6O2tYp1kk+Yl71g0X5YHHZ3+rg2H0e8OJBdpKF9lNJ8TG4tFqeRw3z6Er50ZJtznrVH3RMD/IvcU73IioEcmpDlRzzGIBJy4JjWtba/bjOlLSVo9yu+XhiKEBIJSDWVBlozXMBWE6wYgsaWlOIfuEtPHwPQeKN2N8cqVcl67nwL4ZlG4I+1LhatvwuIZWShYC1dUVAuzO9YB8m1Km6Us+DvyQ+/mNxxwnpxLOw814pCo+BjrL1QnEXieLvuIMLm6Pe9LvRIn/JtQB0936+KLer1PytaeixWdr30rWd7GmwfQ8KbYNQNPV6f4HEUDfMD2LSKRtClCH6FKqzNk2t+gAdKLQsERdEc/MzPAyFrc+ifN4ABfSZVqW0yNKWZbUztENmmxppF9HZl+1WR3dJECKhFpJmI5gkwoQ3qmyOLPoqt3jgvJPf0fP4cg1m8rT/Jbk5U+aSdAcwv/72FsI1XX7UY7rgv4p0/PHul1njNbaINm64+DHddnbS0TvtG8ZH3n/HSy99V1mL0QQhCrk2OQ473A4XU2a9x4vclhjlpI1jIJynFzog/s7e2310JkGumxb/njM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(8676002)(8936002)(86362001)(6506007)(26005)(6512007)(9686003)(53546011)(83380400001)(2616005)(2906002)(36756003)(186003)(66556008)(66476007)(4326008)(66946007)(316002)(31686004)(38100700002)(478600001)(31696002)(6486002)(41300700001)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNTU29JTWhsZ3pFTmRpekE5YTcwaTN2ajRuK3dLUmdXelV3R2pKT3hNdDB4?=
 =?utf-8?B?MjdYUTVmL2Z1OXpMWC9sRFBxU0d0TEFFUS9zQVhHSkVaSUdxWEZNeVYxNU1u?=
 =?utf-8?B?UVY2eENVUFZjY0ltR3NvdXlLaDkvdnF2cGh4VE14UHVqUUF1b1oxaGlsbGNu?=
 =?utf-8?B?VWI0OUtqTVVBMFZSVTRHK1JOZW4rNEN5MmQvN3pGN2xiZGZOZWJEZ2V4d2Zr?=
 =?utf-8?B?SUVsNG5LQmdoaktyVHF0QUFLMTFFZ2IwZ1dBU3ozNjZRd3UvTGVrVnBHUmN2?=
 =?utf-8?B?YnNybTJhcFpiakNlV21zL2JLVGV0Q3VXRTBWb0hYamJmNmFTblNVWGg5K2Y3?=
 =?utf-8?B?ZWhKc1IxNUZNVmdTWERtbGtGVFFwYVk1M21mV1puYXdQY0hXNGhTSURWdFBn?=
 =?utf-8?B?bjJPczl1OElhemtHTnRFM0Z2dU5Ick9BWW8rYlZKalRxcEgvTUxoVUJOS1Yy?=
 =?utf-8?B?a2lZc3JJbkJGWWFrYzlCbFUzN0FLUFljR2YvcUFyYjVjMUtMMUo1aVJWMmJv?=
 =?utf-8?B?VUg5VmRsSzFUZkFTZXFjSU1kbWV2eXFUOVcyVkl6Z0lGZ01INitodVIraGor?=
 =?utf-8?B?TDFJTUczTTJKeGNZYkpocXJlWkhudVRPZ29XNWdGdktEeGpmQXNGVWF2UzAz?=
 =?utf-8?B?Znh3Z1g0cllyNjJsNzUvakM3T2hSSGNYVGNZTUhrZXVNSHZRSFVWZ2VYNFhB?=
 =?utf-8?B?clljYjlRWkFQVlRGaUxUZ0dIbjFqY0tkL1kvUC8yamhEdDdMTnBCaGpKbHZ3?=
 =?utf-8?B?d2ZrUUZiWUFYNGRFakRJdEVqV05oZVkxaG1XTVE4clNQODlkY1RpT1kxeW9o?=
 =?utf-8?B?b1RvekQ0UGw5VGtMWkIrVFN1Z3lUZStydDlvbG1RYVIyWElOTVBHZ0d1VU1z?=
 =?utf-8?B?SXdsQ0xFN3NwL29mcWo4TVl1RWt6V2tPbm9RQ1lpaVBvQ2V1TFZaNFhJVHRq?=
 =?utf-8?B?WGxRUHBaZzltNkVNeWRvaUxZVmhXc1FFM3NOcG90RXBGQWZheTZycGNSU3BN?=
 =?utf-8?B?OG9PdGdYMFIzN1JnOHdYRk02eWU4TmI2UGFGZUdPRGZuV2NtaG1POWdCTVhy?=
 =?utf-8?B?RG0xTm4xSlJ4QVJqc251dGRjNklMWUVWYVh0SXVqcWpNV25wVzdtSVNYWks0?=
 =?utf-8?B?NStoZjJxbUdQMmx2SjlqWTNsamhtRER6anJQbTh3dnA0ZVlaTXIrY2VKZ0I3?=
 =?utf-8?B?MXhiY2ZTQnRzVHY2NXMwMENNOHF4a1ZtOVc4QVkzYXhMeW5KVU5ZQkZ5U1cz?=
 =?utf-8?B?WmtoVE8wU0tKOWVzMmF0K2EycmxOQzB4ZHByYnpNTkY0bWNBVWNRRWVPN3JK?=
 =?utf-8?B?Q3JtTFN2MFBnZ3E1ai85c0kwdERuUlZXU2tkTFpZNC9TVTArdk1UTlB4bENC?=
 =?utf-8?B?L3pxb0pZSEJGcmhVa2xydmt6VXhtWUlDU01wVEZFcWFvbkNESkpjbnNxbk1p?=
 =?utf-8?B?Z1dkK3AwUWFKTGVvaGl5a0h0NEN5VGY5YTdYVWIzN3N4d3pwVlZGWS96RDJX?=
 =?utf-8?B?RVlrODF6TmFGU29zZ01hODVGT3V4M2ZGL2lidGwwL01CZlVENHY4Um5STXZy?=
 =?utf-8?B?dmx2MjcvMlhTcUlsL21taTZ5QzZPWmxuaWlKQVg3cVB6RVhQbmZ5d2F5a2lh?=
 =?utf-8?B?ZnJsYkxiTVJSTEdLSmdxRUJuOSs0dFJhSFhtRXpRRVAvMWtvaUZ0QnJQanVr?=
 =?utf-8?B?MExBbmNtMmtUVm5kczVTR2E2T2ZWM0YybkUzZENvb2dXaVNOdWNYZ2tHSUdB?=
 =?utf-8?B?ZVpYby82OWNUTzlKY0FCcFFSVG15R254cXk5c3dvRUtYNzFVK1YzejFqM0Rq?=
 =?utf-8?B?VlRrcXI3M3cyS0s2bEJ2ZEIwYWFJSVNkQmRqSVJiU3VQT25UZ25pRk45MEFI?=
 =?utf-8?B?QjF0cHFENVl3bzV1RHd3bVFOTEhQYXB4TklGZ09yVnpGdjJSZnBUQStiQTJ5?=
 =?utf-8?B?ajVKMnZmUjhBb2RzTDlSUUxzSmVUL0llMmZNa2I4dDliY3NmZFNnUExaQXlo?=
 =?utf-8?B?S2RSTFVTRU1pUW51MExKc00wTjdyczBMWXlJZDJsNURBT2tXdThsMlRmNVFK?=
 =?utf-8?B?TnQ4YXpmWm9MMi9BaXNXcjJXRWJmVFJtR2VyZjlhc3psSG9IQjBTck1kR1Nk?=
 =?utf-8?Q?5VQwL+z+DPkj+x9PpU3+5HPXk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9+oYM+/AuRvlsWo0O/4Dyrqeo66K+gbYb4DQSrI96sVMKy1NwCjCah8VuGy8UoEfwYy6+8KYCr/ad3zUPZvD5yomRm4hdpvPm0kVEH8Db0yhATPol7FJ7xsEHTO+aGJaL463ddJOP3fvPiT1cw+WpwSfina8S+WkDv9BoxyLo2fBZTjqm0h2SGVCN8wBYwtoH5RJoRvMqox42o9ICNPu4/fNt/46PqZu8zXKL21ZLZ90uLlIEx4CwL4RkwRk6TFVEl78Yz+in5QfxlKum+tb0XZj3RjpAXpjTVMtcaCsPArHPz8rnE0afE/VY+wRgn9ngbbRsbhdyWjLlaMwL4MuitN+kHJepKIxGY+jY1Nr90xg0hY7zVprjZbv/hId/4LcGbFpJS7v9syGKzsAXRMVjklKyN+hU6QUxyJXVty286z1myz1cF8ryiyl6BHDz69leWqe6HZUGu6fhrJVsI1XcYjwEvVZjNBcOxrcpBk6dQyEzPlzm4DeHznB2gM0Y1IhJy/s0wqG6ZWtA8aqNVEtbQosC8Ty0DTb7moLF463IwtQ7rUD+iweTh9JKvcVDG+ZV2+rBZ9Fz3X4x+TnQEzNTrJ1Qgdn/TSofjgy7Wn2K9T4oe3sAK0hE94tOZC2DxbE9mjtjf0iMOfoCUDm/HX/AyoBVxInN+hzYj7dcbTtK6j5RFQuFAOevQzTM6onK1GjV22cS75vqnAElWE1PjYrB578bCXvLJBoU4Mbdcrj1tyN8NCBLaJmQVsXDQ7d7TPa5bF86k5YlTbP1aUlfS7hlmWObAMPJ62QgNxizdW3GwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8ceb79-e5a5-4ebb-3b2b-08db5a2c0228
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 18:48:46.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1sD3dnM4w38WmWFyt4htx7EZVbMQEpNx4/PjEydIIFNrv2ABSy0tcaOt91AYk0V7/Mec/Y4m7xQWXL/TknVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210168
X-Proofpoint-GUID: QUvmxbCz7UOEvRY0lbn63qVnBsMZW7a2
X-Proofpoint-ORIG-GUID: QUvmxbCz7UOEvRY0lbn63qVnBsMZW7a2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/21/23 9:49 AM, Jeff Layton wrote:
> On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>> for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..e069b970f136 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
>>   	return nfserr_resource;
>>   }
>>   
>> +static struct file_lock *
>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	ctx = locks_inode_context(inode);
>> +	if (!ctx)
>> +		return NULL;
>> +	spin_lock(&ctx->flc_lock);
>> +	if (!list_empty(&ctx->flc_lease)) {
>> +		fl = list_first_entry(&ctx->flc_lease,
>> +					struct file_lock, fl_list);
>> +		if (fl->fl_type == F_WRLCK) {
>> +			spin_unlock(&ctx->flc_lock);
>> +			return fl;
>> +		}
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return NULL;
>> +}
>> +
>> +static __be32
>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	__be32 status;
>> +	struct file_lock *fl;
>> +	struct nfs4_delegation *dp;
>> +
>> +	fl = nfs4_wrdeleg_filelock(rqstp, inode);
>> +	if (!fl)
>> +		return 0;
>> +	dp = fl->fl_owner;
> One problem here is that you don't know whether the owner was set by
> nfsd. This owner could be a struct file from a userland lease holder,
> and that that point it's not safe to dereference it below like you are.
>
> The q&d way we check for this in other places is to validate that the
> fl_lmops is correct. In this case you'd want to make sure it's set to
> &nfsd_lease_mng_ops.

Thanks Jeff, fix in v5.

>
> Beyond that, you also don't know whether that owner or file_lock still
> _exists_ after you drop the flc_lock. You need to either do these checks
> while holding that lock, or take a reference to the owner before you
> start dereferencing things.
>
> Probably, you're better off here just doing it all under the flc_lock.

fix in v5.

>
>> +	if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>> +		return 0;
>> +	refcount_inc(&dp->dl_stid.sc_count);
> Another problem: the sc_count might already have gone to zero here. You
> don't already hold a reference to dl_stid at this point, so you can't
> just increment it without taking the cl_lock for that client.
>
> You may be able to do this safely with refcount_inc_not_zero, and just
> ignore the delegation if it's already at zero.

Fix in v5.

Chuck, I can do v5 to address feedback from you and Jeff.

Thanks,
-Dai

>
>> +	status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +	return status;
>> +}
>> +
>>   /*
>>    * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
>>    * ourselves.
>> @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		if (status)
>>   			goto out;
>>   	}
>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
>> +		if (status)
>> +			goto out;
>> +	}
>>   
>>   	err = vfs_getattr(&path, &stat,
>>   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
