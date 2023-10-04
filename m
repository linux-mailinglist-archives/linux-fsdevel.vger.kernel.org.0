Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39577B8991
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbjJDS1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbjJDS1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:27:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B859E;
        Wed,  4 Oct 2023 11:27:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIvIT014490;
        Wed, 4 Oct 2023 18:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vqbA25hMjpAKtkqeGTcdfYSK6tT8rhjph3knYp4cOKM=;
 b=hjp4FMY75Msxquy9esQx9UAkW68uKaAJZdrnYugNlQDoje16b+F/h4wZOaDfO6Vi644H
 iTy9S1jzJSDEa2SaP1Owi6tzNSo/nRkiO5ShT924/UoVaUJVZcXQurZA4tc2ZklIsQsx
 8KnjjR1sIpGR9NCpBE7QGlNRRdCjB4KBmuQApWfUY8963EqcUlCDMDYMgf6mgBI0MR1G
 jD3jhfu8T/BoCQpthn09iJ2P0VaVX4MV9Wm4P2TcOoh4PDL5w4ogbfkj1uUycFZ66Azu
 yrIkSykrohCFGJAZ9uI1O9Gcdvwjrqcy5cyIazyltBbQvm9Tc0Qqjbyp255d2+upgwP+ vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea927t0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 18:26:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394IPmYG000345;
        Wed, 4 Oct 2023 18:26:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47w8pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 18:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y32Iu7kT8ubr17alExobMlfzhxGYBCxIrzY53KGJs/nzxbuhHvj+C2GZQAST+Xt6KqC7NldYBt9V7AMriu6F9FQ5Cwnz8VkdPRTM1zZ21ydSzfrRJYszgmSzN03BWf+lpGJd3+G62eLSHFHlPxHIz/vNnCq40R/5CAqE+3rXfzLW/a9N/ub4HBcCVobG5qxfqDHCFO31m/sm6/PhgEfdQnG7VOcb5ifKzKmh1v5mKRPXXzuNnnOb62vQM+OEPajI9lJS6cT+NsShf9d54H3t0fE9S5VhWUynvKbLFkug5gaTefTH8i1swAbwqraF8vNR1plxp3JWrhgv1BR/w+yDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqbA25hMjpAKtkqeGTcdfYSK6tT8rhjph3knYp4cOKM=;
 b=nAF7k4SdAwM+ca164T5C98PDss1PVOVf9oOQHiyqTJ82BpkUem9+WRxvobZHDMsWVIU1AC4sMYSB1pU5o8cyj+z4grT6wIGEZLQxWmbJu3E9MVRqiCboXRRNV/EglmxAPwGLHAhdW238FdetCdr29vTdcDK4Hcw6oCi+vua4Dbu6J3gtphA7WWEX18DDaI1K06wDMeX98AwO+MGSqKUseBolfJGHOC2gouEUwlCdSIFIaXMbqQyZkW+SsGbx/QTmQfLvDuulL/OU01Lvug8NigrC0ZHe+wO7hzZE3qLsOOx5LPljIkrZDpOCB70FHRbjm1cALeFSAQBSuMWmfElXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqbA25hMjpAKtkqeGTcdfYSK6tT8rhjph3knYp4cOKM=;
 b=IlDuh2B0E1r2TLddgEEU+evhxEPmWdEFQ1WMufLHKMsFH1ZmER4mWrbcXG4Ew4hlqrxeT1jpa6ZMdabeczbQOoQFUq/b0DEfu7wG0hS3jMZZCnC2B0brWnKaLiymLcqs/DPsLWd7AoQy+vokUqtWYt7oHgSdp7RnsNnvSSXgdo4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 18:26:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 18:26:45 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/21] block: Add atomic write operations to
 request_queue limits
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7heqmk0.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-2-john.g.garry@oracle.com>
        <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
        <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
        <776ff7e4-879f-4967-ba46-fd170804a9e0@acm.org>
Date:   Wed, 04 Oct 2023 14:26:42 -0400
In-Reply-To: <776ff7e4-879f-4967-ba46-fd170804a9e0@acm.org> (Bart Van Assche's
        message of "Wed, 4 Oct 2023 10:28:10 -0700")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf8bea6-bb50-4e29-cba8-08dbc50776de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zD/Y9nGr7ip9UwgPmLDDh9/2YrzKm2U7EDXCRMohV8jY6LAzslJeT3XZ3j58YRmLLaIYQUnbPSRjB5i5pASxpBVEMokAby0hcQ3Z+S6E5zdghinpVRYoLAVca+9AQX5SapYYJUlco1HaLNoP24kPd19FvtM81qNuBbPgOv8ci1aMykzNFI7DDt2yJWcZqdBWlwypjbte0xNK9AnqIrFtXImNEb9Z2LKaEhrh8z+K1OiyKFXZCJ79Dtvn2AwrmpKVllnmjsDm06SN1oLhZQnPTQ/RPR7Qzc2c4Zv8ilwFfzLChSMYsPWWl/jH/sG+jXRBctaX0yWuwhsBNIiDotTy1NE9UXqTq5nzOGDMjxI/6UFIJk+BlMLiKU75rz53jODeQQR6uUtSZ2bXXyMga5bOk76tUZKz+6zLWJn8IU2EjiYGGSYf11E+GCRbDDxcGr6LJ4QmOosGkbA0rKzRC4FDgEZV7P0EVWa99NGV1Qo8nWCG4igD9Fx0igKFoX4qgrFRoNFSVco3Vn3GThsDkPNRSWizZv0sBBXOfp63ugER4vEk/6/8gsXO6D611vKvCCLi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(8936002)(7416002)(4744005)(2906002)(5660300002)(316002)(107886003)(26005)(4326008)(66556008)(66899024)(8676002)(41300700001)(66946007)(66476007)(54906003)(6916009)(478600001)(6486002)(83380400001)(6666004)(36916002)(86362001)(38100700002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hy5Lwth7bIuDBhGBCyGHWCg3z1Hrxl+jE+1iyb+NOjcaYXWd8d0HIDEbwfJ4?=
 =?us-ascii?Q?fnj0yXFSYQa/YqwMuCMim6V9P29Ne06zArTzx3qEoGi5wzspxdxSMvm43c9y?=
 =?us-ascii?Q?7iU5Tm6AFNd9BIsz3ILub8zeSnRt7LXPXAplc0lzfxzFp2lgw3Y2kuthJsI0?=
 =?us-ascii?Q?Gqerjp2/LL4XizpfeOuu5IGUdqYlbEt1nKrJuYjtaeoxEDoepsHxCXiJBEYk?=
 =?us-ascii?Q?smO/Nt8GN+ifjbNeWnIvO1DxizN9PuV3gROb6RRMX/AR7Djo1auv4xvIWbZB?=
 =?us-ascii?Q?v97XXc58OW9b4kjo0MArAJCUGI/irzmgDHEAznhJm9jYUtI9GootWMy7sIlL?=
 =?us-ascii?Q?wAFkuZHrY+p0ScnBHXT8TnU0NdzTYSiC6nxjgq3goNjH1ONsIEl04+TIdhE/?=
 =?us-ascii?Q?21Tp14ia5JhjWKan6woit4LDJbV062uPd6q20kfHcMJ3u/joD2NbfcbXqbZB?=
 =?us-ascii?Q?j/RXpCy1Rg3W/WQejDbC6yi+UFlImG248qHAuKNCVJsvNdy/Y63pou7OMteR?=
 =?us-ascii?Q?WL7lzR7h8eYvn4if6N6xgKWJ0NEme6N7zITYIulpitpMW+f4KU2hqayrYMEO?=
 =?us-ascii?Q?sDJHCPnNDX789vrHCIxBx7yqoduXYyV+NTGoJ0w9MCseXdy//3RQ8QQjTpcr?=
 =?us-ascii?Q?Wbf7M6JzxMNOwa/DHWQJ7j7tLacNGH4yY7bMJb/Wt/vwtalRam7Y3MarBI3T?=
 =?us-ascii?Q?4/wnbeQ3uvEPZ54Wi/CFAz8lvQC8teoUyfd4fBDgcUoKbs3DWC+5M9vb34J9?=
 =?us-ascii?Q?AaIddxNXenhuKWBCHGWxTVRcwLluXa8pxTS9ItVdJSIz6Xnax1BU9zGbX2wy?=
 =?us-ascii?Q?C+Y2GlqgPwWr0blzPdT7bwISSU1f2lr8PQ+EvlQTamv755jbZBLIrYZEwELt?=
 =?us-ascii?Q?yy6SbgIh2/0lOA0nwfvanhd72n4Lw6dn9EyQ7KIL1mi2FSWBCK/sTmI0lNBE?=
 =?us-ascii?Q?vqYMp+qN4KI2KCbfmxGMKwmnnVmNVTkWh7W5e6+7n5Z++74Z1X0O60/eCp8/?=
 =?us-ascii?Q?uFa0juujyclKoUcTqAHHtXdMOwN0E/uUG9ICFALLiZwQ+8uRTITvhD7TqP0W?=
 =?us-ascii?Q?CLst3XbZom60aeJnNpSHrSV3IvkkSXwGb8csvmKYHnLHyhNUbCcYZbnJ4+Bc?=
 =?us-ascii?Q?KslfXhmEIQJGYLB3s/UHLYEgGkSfKmLHR/h2nw9aYTAemvtzhkIY+2G0mZJp?=
 =?us-ascii?Q?xAKLeif/NAgdRYd1Kpqvi1unRviMGZ64JlQu3pUjidhs2QYj4RQTFZJYy7sN?=
 =?us-ascii?Q?HjxbpYc1vGieUltU71pKHfNzP7mv7JipIC03noszbtdmbqasEAxtmhVnNhwx?=
 =?us-ascii?Q?esCHh29w0EkEypLcSp3h5NNzDjeCYqWt5YhegCE5cKjWeOsdZkzlWpejq1Pj?=
 =?us-ascii?Q?0Ev6O1NvxbTUp/rjRIpNy/O5vuv9zjgx5TlTY/4GR87jDYi3NloEM2N+9QB3?=
 =?us-ascii?Q?WyTvZVmd4+UcH2SNKdFraXx023HAkViOVkupSOwql3SMwBWdVqC45NkOod6Q?=
 =?us-ascii?Q?qMXcmuwcq5kN7CSIinz5/EKvBXPev/L3xu6NxUUFcI40oQOmbFfdv9B7WSOb?=
 =?us-ascii?Q?k3j9ayNIBmgtkrRiEhrfRVhen8r4w55onXlLeFOaoA+7hSMGzltjX8gZ+7AF?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?d51To0xB7rw2jdyhJiDTiubaU3mPPlLYLyFeEksD45NVUwhwtuz+8X87SkuC?=
 =?us-ascii?Q?NUI+9aTEzsMgt4c6z/KSD9vJLriNAwOjRmEJIQSMJVh8HbnDoHQXgyKqacfq?=
 =?us-ascii?Q?gV0JCMR/gg+kkGH2mjXd3x7qCSb/lu8WIRdZaKIJKzbDnsrIjQA9xP/rcrML?=
 =?us-ascii?Q?QZxxfdYZCoNVc+fLcQMMzigiYGT5gmKNz0R8gKPi1ebN70XKVj/MEqVCswNa?=
 =?us-ascii?Q?JA7TetXnlCGllkmyhkn3OQ1SNAZH0AmvUkMwn77pzaafep3ZqkNC51G9+gC5?=
 =?us-ascii?Q?i5OascOUfb4KLOgwArMSowqNokh+BnVKGaaQICGUAtGF552M3e7y5Tf1guoq?=
 =?us-ascii?Q?b4yCSBtVj3o3P9jMUsM/1+wJwotndhN42TyvN2Q+mRM6vbwxAJxGSbNhP1VF?=
 =?us-ascii?Q?Y6oR6uZkc4qifum5ES/eCzloOv+zftiXoaguALlq3jBMuh8VeUi6B69vdmdF?=
 =?us-ascii?Q?3VE03tGsM6A0NaeSfvdyludgjxfDSRWPvkyKq2d3F9+s5vaKfatkUf3DHM/f?=
 =?us-ascii?Q?Uj6x14kOdPVRrGKBJuRBGcx5dJpEyv++IxMtRAO9r7SAqS9E9iXtWcfQcmKk?=
 =?us-ascii?Q?RmLaCJM7iriBlXfh4ffsHy/Rfc9b72HYjRn3EoUpM1NrBNaMi0fusGtTl9np?=
 =?us-ascii?Q?eFQ0WT6gd1U+nK2a1XNX5GhD8B45vtExy5vAqd5z9Oh3Aoinw2O+5+pafyk/?=
 =?us-ascii?Q?Pn2oBlJRBgAvTpCLfunnpdxddk60OcXnBiWWbqIaKZ92A48WcNtQ8eTASOkJ?=
 =?us-ascii?Q?18p22O8BpyZh+q+J2C9bJmaxuvVpy88zdDeqRyefbSOtg1CoKSbfwQMMKeUb?=
 =?us-ascii?Q?j+y1Bn8KRHAKMWdXycPE2+3/OH9XVHWgJlFQbTBeMD5TcSSjrZ3yGAiGKd/v?=
 =?us-ascii?Q?BZchXXN3rkex8+yYQbL2fr5ChS+CQ9A5avBwsxU0Yp2GkaSTGrvikNwir4I/?=
 =?us-ascii?Q?NQ0d4hr3sBfMLKGEJlW8qh65LyCpUN2iQvmDSsMU8oNMsJPXHDvyMt6ng7Xv?=
 =?us-ascii?Q?vacmg+T1SJUg8NsQgefbVr4YXkPohb2qWdQdiAHUAkfPfCymqAFB1QFJuq4v?=
 =?us-ascii?Q?TjhefFwecAgL/SAizBZw2zX8ktYHoZSJpCVwb+w1ECN6kX+Jwhg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8bea6-bb50-4e29-cba8-08dbc50776de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:26:45.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQIq0dlx/YW+8UxBgRjLRmp88obii82qOENJfcBH8UN091qSSfKDtIRlskpMj5D6dBSZCyMWNF9rNztEaDJvlnMdap+dgbWE0AR73fnuTvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=785 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040134
X-Proofpoint-GUID: HGRCpqJOJj2PMk0M3WMS0k-z6g0o2uYs
X-Proofpoint-ORIG-GUID: HGRCpqJOJj2PMk0M3WMS0k-z6g0o2uYs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

> In my opinion there is a contradiction between the above reply and
> patch 19/21 of this series. Data written with the SCSI WRITE ATOMIC
> command is not guaranteed to survive a power failure.

That is not the intent. The intent is to ensure that for any given
application block (say 16KB), the application block on media will
contain either 100% old data or 100% new data. Always.

If a storage device offers no such guarantee across a power failure,
then it is not suitable for use by applications which do not tolerate
torn writes. That is why the writes-are-atomic-unless-there's-a-problem
variant of the values reports in NVMe are of no interest.

-- 
Martin K. Petersen	Oracle Linux Engineering
