Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D545A809A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiHaOtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaOtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:49:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9CED1E27;
        Wed, 31 Aug 2022 07:49:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEGFUf010674;
        Wed, 31 Aug 2022 14:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=BIHU9/xF5GwPYo6hwNxtZPOrXUd6qGoYRgn4IY6CIKA=;
 b=KJDll6nsDznvAVipgf26eYmbUPBNiUgZiEhLyaiXiv5TAjJ4c0g+iCujNU8V5VQ9YEEm
 I2CfV+q+q2EtpwysR/q0CiRF7dsSXX/mrlFxAtPylEMYgirczw/7udV7FcRkZ83d3Cin
 0XuRn8k8MxUGf8EI1Kpg4kClpyEEtSAawsCLqQRgRe1saY93+el2+c/Yg7okjocybII/
 Tfs0096twhjzOnh+iz1cXNkUB9NJPF6E76ZclahOxEzV6mdfDhT+odXEbkRLvn7BTqlu
 ZySq/o2wr2sJYFp5sD0Cg3K9LjHqchLb8Da7YOZ+rES62HfFzrDTuspzuGQv29iigpf0 /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt9etj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:49:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEN5vT033772;
        Wed, 31 Aug 2022 14:49:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gqdx4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 14:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9zqk7h0gfuWOhHx6/nQsu+Ht6seQl41AxeZZhb4C8t2mqdIraCh4sLMPkAj/VAGv3C+Xwf53BXglq03j9Ca+rk6TzDbQzgpSSlfliDuPEcBm7AjAu1vYoYoQMXxRJ6VuOijzaXRo8W0fZBOal9ZQzTwwhe/9ijqPrA8tGws2FoqkBakZnDxUfLzxjVSBIarwvJILckv23QOwGfNqtk23reXae4wYEyS8uNSsenyX/AwPnoCKE69kuxKYErPSWiz8njVowLGzOqC4cbFD1zy+NsepFIJqSZrFKqUmBmLHc8nQj5NCqnp1YWmdGJtfoDbvApz/URsQkQ9rlp4Plx+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIHU9/xF5GwPYo6hwNxtZPOrXUd6qGoYRgn4IY6CIKA=;
 b=LhFmb9801Xf6cGkksXAmr0ledItKIIuKUlGsYRVHBCjRvtJEZAnrTFgWXWfeB1Me5Ibh6Ss1mngchc+Xkez/47sHXzD7DvjxaEN+YAtYZ1blyKC5IpsTRnV5fSMUgRJlM4mPikxQWQuVdOBJLwvezTsIG6av99hB+blG/QKaSlzWGsfFjgULjb0yIHTSd0qvdMuHRdQZDqEtGRPSDmS119q9pK3MyNBm6VNQGt2F91uAkNX1Qr/xprqLtzehl2QbqtVjekaf5Z2FAqVxSbXXYKLq6fDn0K5vGmOlai4ZQfweQFfSwCSuHScKmVsL4VJZj46zOOPCvdm5vUkblgi92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIHU9/xF5GwPYo6hwNxtZPOrXUd6qGoYRgn4IY6CIKA=;
 b=CqR33wbDTEQJROjbxPx1V4xy99Z4Jz0sB1sMAUBR3POH6u3CIlo/kHY2gQt0Y9CnCxwmsoXIEy8Yyjx4WT+jyMXEiVB5ZfJnVXKnRpFqY00gWwXqSBO43Hex+cxl2e3jSoNnWgWDqQgRlQRKI4MkCtoYm18PioHrQbBr9J+J80U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:49:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 14:49:08 +0000
Date:   Wed, 31 Aug 2022 17:48:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Sun Ke <sunke32@huawei.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com
Subject: Re: [PATCH v4] cachefiles: fix error return code in
 cachefiles_ondemand_copen()
Message-ID: <20220831144848.GL2071@kadam>
References: <20220826043706.GC2071@kadam>
 <20220826023515.3437469-1-sunke32@huawei.com>
 <1544479.1661953939@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544479.1661953939@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d9d8a7-e78b-41f2-673e-08da8b5ff551
X-MS-TrafficTypeDiagnostic: CO1PR10MB4722:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgfkuDUYO4rOi0GQgUOT13s7eASPphz8wagqRMGCMWUHOYAIrnvE5M4tJo6kb4bMQEXzaMufMJblF/yQOS1OCGkqT4/nf+JZETc0uE/w2Awo9RHM8bfh4PaG4VPQQD1snNQeyZHuD6EWG8iZwVNDXBWZUyPz9ykZB4Bh9rjlKSxZBFrxNWdyRICrxpn5X28WPWbFqQyXNYAWINwNR+IGn+jKUJ0O8aetLz0wqOemW7b5kqcsQR4VN71FLRKpc+Uj9+S4UMIfyzb/R2KvhWACm2htYcyYhYSAhDcZF4+vMYdU6gnKhG4KnvRmyHVHS6499WG6WCHAxNKrALQT2AcpmqSfB6F4wDfD5vLElk9v+qoQOsKWj9tg2jKzrLmsODbFGihYyHPbeXx2uufoabC9sIKcxK6fqgYYyBohWa9yQAvajnVqc0JD/PVdJ+8el8KSyj9bP26wZHImO4sjICrlE6TSO7pqydeWTdsiDEOtlk/agWaiUkhfSgBoq1RL8a+KIfINADg41EXolo94Gc2FmTa0Z2xk7GkUOZg/rpo/xa1AEt3jdUmIEXdcfpx0EA7fAUWoOdPSAtJaBuAeZnL5wk5ik5cUyaWo1+tXvv5r0BegOW/vAptVieKQ0+HzrtVQA6BUpfJdlX+p0xutTKLaKSA5tFUOFGmT9gxdJ8RvRlTRydmQU5GVnnAp9IBH/RpPiQUfWjlJZRIs/7jokQ4yqFHMVc/D0/rkYUHkXpx90ZFtXK0UWWALaMqlKl/jYBBC1mpqBPyzbRbZpIbaIoImkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(66476007)(66556008)(66946007)(2906002)(6486002)(86362001)(316002)(33656002)(6916009)(558084003)(6512007)(26005)(9686003)(8676002)(4326008)(44832011)(6666004)(41300700001)(5660300002)(8936002)(38350700002)(38100700002)(52116002)(478600001)(33716001)(6506007)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPPPO2JZ2wuLHoP/fWhmZtXOwMAhwUUxVfaZVvO2z+9I4FI+gBqCh9iZLSlj?=
 =?us-ascii?Q?1rQa0FLdT3DrTIPpGA48sCv+6S6bVWXvCEk+ybUse80w6p9QiQ/gCdG5DMOe?=
 =?us-ascii?Q?3eCpapGNL6A4eEbnafFKJSdq/Rx0cL41qHy3Mcm9xbMmPssZkfHK//uCjsnM?=
 =?us-ascii?Q?lImwX/SK3N0L+X0wAFonnsFlXl4lU0eHymncNxHCX1vKwurlLsf2HVPk2C/t?=
 =?us-ascii?Q?/1YFDkoh+E9NYFegVnz5gylaKh/pZsGYX2dAuw0xtxaf4BKpxwpDNyVTm4+9?=
 =?us-ascii?Q?JdfQcE7Qx3gKC5r0sr3N927Sl8NdZbEzfCsOyswKZ+OYgBjo93zLBUXyIabp?=
 =?us-ascii?Q?ptJdoMlJjEWfMuH/W74vBewzF+FAKsykvyQ9dWRWjawf30z6W2YSB2WunH81?=
 =?us-ascii?Q?uAKj4ktaUw0uHnndRMKPdK7FekhFK+J8gLiUfJzl9hm7wyPQmtSBRtTp+cmf?=
 =?us-ascii?Q?bQmKkreKbj0Q5lZ+PuXQrn6/IeNOxlqm14BCon7igJs4AldB2f9wVkE7yYFN?=
 =?us-ascii?Q?yirhgn3Ns9kwY31/4mkJHmq1HM19i3qX8YjazBvuBERHMOBeTTNbaS6yT/HY?=
 =?us-ascii?Q?ZoFBK3Hnxt0CIGTYwydOOLrlFKZp8QizwmUu+2mU809f2wUDMZsyz2oqyTWr?=
 =?us-ascii?Q?X/T35n4+AC5k/KOM9x4Rh7wa6dJInyHqVuLQoupTiZTaw3eIHaDNRQAds/5y?=
 =?us-ascii?Q?5cJ47oLhKTL5IhbwvbQNnSbJY3mW8gPmircF/zl/b7phsLvuuQ7EU5HrAg9B?=
 =?us-ascii?Q?daT5dyJUO8M6N5kzX6jhFByUpZSbZQD5u+2Zv6QDmawreueqrovc+SoP5aFA?=
 =?us-ascii?Q?BMKPO1SAJQHQRyOXcL1ZTLhWMj+C2G9dvJGo5oBE+WuEZafxWCUt9LkZmNOd?=
 =?us-ascii?Q?vWt+k0/PsKnHSRwvXdy1Dy/PGpUYmeLYNpIot07QuGVdR/Po4p4OZSzjTpjJ?=
 =?us-ascii?Q?MvNvOBHTDSazGS48OXNq+ha2UwUo94OOO5M0iWvjSXApeS652oUl4oOhtdVO?=
 =?us-ascii?Q?1nGis7vE2fvDQH4DkuvDvtjQNRjOqGNkxXl64nMxuZUqdfybtpX3OsgrW4vS?=
 =?us-ascii?Q?oMkRUx/UT+hGXT7EOz5JcSinFFVDNYLpymJrlgnPvr6JJC4GUVX0yGHOLxDs?=
 =?us-ascii?Q?TIxulnT6xXbW09IJ5nc8j5aoQnZQFS2OT0sIBpPPaxMBGxrV/HJn0EsE5Sqz?=
 =?us-ascii?Q?A2j/+6fnLP3Z8ytPRlSoSKmds7OIt4Zk29pggfL/7gY1NSydx7LNQ+npNaU6?=
 =?us-ascii?Q?3WcWCB2I/JEH9s2qtIQy7nUljXy2RFNIrlPtmSx+sQUI7QoM9YDxGMAdps/j?=
 =?us-ascii?Q?k9M4z8G8MQorczl/W3tSlNqjBRVGUmOiI6WwLizpHkKMX15DxAYfXCnIVDq1?=
 =?us-ascii?Q?KJ6PAMtn3g/ozLxQPuSb2mP7jagUePdsUGI0SV9GCtH+Hmp66wMo7zE8r+xD?=
 =?us-ascii?Q?/pqu1BKCSas0BmQFSjZDdRryegMBewuiM7o09FD86yD51NLemiBZ7KKM1hjB?=
 =?us-ascii?Q?OfBJdOQSNAQfntEsNh5ghHi5D+A/fk+KEfOrsmv1fse1TdvrIWUKwGYSdBSF?=
 =?us-ascii?Q?x+qpYgth3GOWcHyhGOrZ7eEny1rLbbwpESB1FR3yCf9/PXAVGSCZNeGSBiJP?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d9d8a7-e78b-41f2-673e-08da8b5ff551
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:49:08.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJUnBpRNVfdpjAQ0kFk6yxVQ+LKLP5fjCY8jhtVwi5n+2DO9+3g9tqH8KjadHLLM/hc3PetYeTZzX4SqIuUBBOAbWV+VxUYiVYJR/C5ZThM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310075
X-Proofpoint-ORIG-GUID: IY6l2Qw3X2dM3_f6-iu-HHgkzIimrFnM
X-Proofpoint-GUID: IY6l2Qw3X2dM3_f6-iu-HHgkzIimrFnM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:52:19PM +0100, David Howells wrote:
> Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > Thanks!
> 
> Can I put that down as a Reviewed-by?

Sure.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

