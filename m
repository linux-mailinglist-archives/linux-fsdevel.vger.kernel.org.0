Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4362642E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiKKWHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKKWHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:07:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F143AE7;
        Fri, 11 Nov 2022 14:06:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLomDe025514;
        Fri, 11 Nov 2022 22:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wFpbesVg/nz+VUPlEsYVZunVsPHTHm38szTsgXmNXsM=;
 b=uI6iNXcDWkuLhWogJxLHE1C00OPbOEcLun9h8zI+fB2i13GcLTnIGN7JtckcyF9fv6kf
 U+hAcM60wFaIbq9nrXGlk/JtPZgAmbXrg8Ky0Ttj6HhUVh920sfwbaH/O4tsxA1n/HOi
 GfPxREClNjQpdurOlY+ZZXC5oPvFwQXsmVI1CYi0HT8NqudUqL8FGQwXgP0e4rTh5euQ
 unKG6Yn/TwOSgesdhyrmr2en9hJSza8DARMxkw2KvRa9/CERbkF/A+O5g4BPlx+lQUKJ
 cWeCMDX9c6cVMe7BybYzuiB0xdvJerrDX3Kdk5D96Cg8jCE4NDHG6tZsd4em+7azjeB4 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxnrr13k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABLUOuw022311;
        Fri, 11 Nov 2022 22:06:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcytsv08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XedXquWRNvlCDD3RbEvWfsRLtKWe0KNkc0Rr1Ml7msi0V2K1q7PI4pdlAkU2JTBM/Lrjo6u0zoRThHwMYJeT7SADwxwtKElgdo7CgDj2tO/B9pCBuhC6gXRaw9EoXLUOUrgn7Ks91MgHyE0ul2bS1uyH1wtPmExLjoDyKDQ3PLpY8KbzZ/VADzyAYlXppyY447+5IsdklujEOe2b34R6Dk2DIris0LXCkvHN4JBqLHGH88BEakr+nps+WSNMw3eUEthfv2kzicmxvQVegA6ev08hXjuAoD56Bym4ar5/T9e7QG+PNELIaXmaKi1Pg9mlAPnjqLlBbN6BLE9LDSv5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFpbesVg/nz+VUPlEsYVZunVsPHTHm38szTsgXmNXsM=;
 b=HjKV+eRQdteUnBBSJBAq66EGI+v+7bWSMfpRCd1Ma4OMYImZKyRy513y3Ct28jUOsEf2b1uJmJ4v11P75gc+1C4rzyBXPdrb3+Lg7OkbisaxMSEE7UWXK7h511TPDBtJ4GejbPoAJAbzOIhMy4vcF8h/MlMq8sB7pA80KTpFzpYbeFdPV+tsSlO+yUH3Brq1vto8JaLuAP+WJSyUdWDaXQH3TL5RwcVXF4n8WTSNsIFvjBma2eJtLSyemYZsqPIhCMoyvjheK1BSjAfzDVliuD7PuF8/cphCFG8IvwsXQ2DGf5Yh383E4NoR7W5z0T+s9yZ0eO6o5Xt4a7FM3/53xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFpbesVg/nz+VUPlEsYVZunVsPHTHm38szTsgXmNXsM=;
 b=Y6IhWhV4vbAkwE0Rt6X3WF79fyRbDy4IlSGQT4huzx/SK1OHDFptI5YuQKy6kyCjxYdDq5kDhi0QWQh7KfbzpdGvLm8ddOLWX9zFCOdw6PzRcr2DG7PoPd43NwMhZvqnw4cnqpZAfEwb7kbSM+4xLEwUu8dDMnGRRUYkhk6rouI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 22:06:25 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:06:25 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v4 4/5] fsnotify: allow sleepable child flag update
Date:   Fri, 11 Nov 2022 14:06:13 -0800
Message-Id: <20221111220614.991928-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:806:122::27) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 3825e25f-5399-4873-5e03-08dac430f989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TMMcGcBWb/3ISOWaUqoHEjv4qQ4WhU9iIzyM+VJc84dDnkIbNXh+4tE5I2jwOhJ2OiAmFbTiOyn0vtqurGeNWhTgkYwEPNry0t24zDUzT3muwJv5p53xx3RE0SVYvvdp5QXisUaSkPghkCjxsvQn+sCYur4f13GFdk6Gil48lFo28i+XCi/dv+h/8dMMrsKt5rVmCHpXYAmdMK/dJ0lhmxziKCCtNr5h+9OG6Mb/4fYDnbwicgGBSozmW1gy49cKl/71/4oayhyA4bqkDvBhXk6DduicRKbPqB5GrTAYVqopgCvXv6lYddLjzfLaXXULoxenmHThUaSwgCCEfGRhIH+2Chyq3xTM8LRZ0xKf+3+XE21KGNdauvDzeVchikZtCTFWMFo0CRsfSILNrToUhn8rpLLXPEUIlqL2u/+8z/8H3ieQDTU1zBN3C7XuP92juGZTGlsKmjU2Xhwy144zsM2Qh4krATmWhvyj7tbiRdziPe8qFZAFPM7fI3FgO0poDmPjg4XpRo116irww/OORDA8T5UmqtUe0u5PA74bwwvWPv8qqu4bWY63aU1P1/EbVDJat50ezz18VnxuEZ+hg5uPVGFpgBqTQArbTyaQNQWJaSCXePIBinIYCufNUkwIH0vwm8Cbp8lKE+mBW+7GGTz/WRPflgVvVN0TFpVRpkZzw8nEY/xzTv5X/xWTicZx+0foLZ1JTDYMVG642GiJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(86362001)(83380400001)(103116003)(38100700002)(66946007)(2906002)(15650500001)(8936002)(5660300002)(4326008)(8676002)(66476007)(41300700001)(186003)(6506007)(26005)(1076003)(66556008)(6512007)(6666004)(54906003)(2616005)(6916009)(316002)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWLlrnwiUJLxpQDIrVy3XIAn+/7A6Iax/+lCF17mfd+p9pJI96eYyme3NChb?=
 =?us-ascii?Q?a9Wed/fyF0sylJHQDPxbHPy2CpA5fPm4Tm8eHad1ZCuB9S838x8y07pbcU42?=
 =?us-ascii?Q?PRxjzl/P4lNWlrRf/YekSuABIDskcD1K1sYfIajJn6ymhgVckTf/UAyEmozF?=
 =?us-ascii?Q?nkH9mOHugJSW/fWp8Psg6XitGQ0hmPMxFCNUdET56XmDo9ucJy67/r6G4RIF?=
 =?us-ascii?Q?qhJA1AQzMjzRiLsW/vHyu0558y0lDVdpaH+4FhztGDnieGT218o5vSGpEI6U?=
 =?us-ascii?Q?yQuPy+kNiEDGbtH+DP7bDiDGq72aoxcyc5Btb2CyPWY0fP1bjha9WvsgoNIw?=
 =?us-ascii?Q?zFc7CZfOEHXi5b8Ya3u4sm9kF5OOPW22UD4Spy7r+KgMc/HuW9sjtsvw8LHn?=
 =?us-ascii?Q?zg3lb8x3OYI4SR3m/yyEWGwBw18r3PdP0MAe5RMtJ144jeXdOf6cRB6ZrixS?=
 =?us-ascii?Q?H6FW74lFrepdt1ikOcPnGpRmtIJOtlpUrHxsEbDhUVdFF0bR0eU6bkyOh89k?=
 =?us-ascii?Q?vS9aCVAtFG3nwqiwnseMum3Qcd9IU2SrmibvlzYJuP4J52wq6UwmidvDmYI1?=
 =?us-ascii?Q?PwjsabAjTK9ZjAqBJC1a7JCzfuPn4RFPFq3ADjbsNLrzdh3rNoBqYsY5PkB1?=
 =?us-ascii?Q?JuMCUK7eNzUOEAOXKoR/rI0t4IIYcQpx8XSl21Defn9bEZMp5dV+gCwpMTHN?=
 =?us-ascii?Q?qwlRV4q/b9Z0LFag3UPMa0eIYUpb1IxtWm5edE+xF+Hc3lWwNgxZ9jf3waiM?=
 =?us-ascii?Q?khfngwmdX1A+3TjidF6kc7CfZ6AXLYTW+A3iHi28Se2RvKnJ+2AYL9p7CkKP?=
 =?us-ascii?Q?ijvL7bUKjlvkpGeFSAXpDNvpFw9wCs4fqksjIBAazpSldeToaXcd6GeUnMaP?=
 =?us-ascii?Q?GhusvykHAHgRFA3zm0SUA4lxFWzkQh5dqP9lSYxkvWxHpf9mbc7Sgjn74VcS?=
 =?us-ascii?Q?2oNx4w58kFm25Y0tRogOv9VFu2rJSJum4LvqdH+1WAEjG5GGXJ3HW/DGRlAl?=
 =?us-ascii?Q?W+vlTGGkMktDxspMGI8qDlJ/+KhrFqwN6to9bo2z0fp0DAJIlbCCdiqCF6Bf?=
 =?us-ascii?Q?BVm5mYoM4dh1e6xwTLqjhJ2qbHyhj7fKxMIP71pZn54N/uuDkNPG/LXjd2Fb?=
 =?us-ascii?Q?GgdnI6dv3OVXpb8RJWjRgpjtyqNmyxAtRH8h2+AN/xVpcLB0sQj0Ay0IcRFk?=
 =?us-ascii?Q?EBm/XuJpbuq4dvM7Xra6/66NGyw4vTyThvzX+vWcz1D4aPEP2aft7FrjMMG9?=
 =?us-ascii?Q?3s779Yq6caVGjAHeD1i6ilZkAomYAbsqo/+z4CurwHyVmhLiLW1pq82+W9FE?=
 =?us-ascii?Q?ht349FM5Bxy1pB71Xy4RcEeKqXIRAoSlaYk5ddTgtKyk//dW0PgYk6zzkuU/?=
 =?us-ascii?Q?6AmMZKlJRw9NEadY1FBsfIFZNu0j1f1Pe6DRD2LbnfIJusSrOHbwbQNJHt/l?=
 =?us-ascii?Q?PAkDvSNBhMEtlO2uw2vUKXNjQM+44zWv9Whw5eqntC/mGvy3+sBSSl0bM3ih?=
 =?us-ascii?Q?wEQtzKsixfdeDxU4yzu30fuYIBEiYOrk6ttJ8Dp0OYvuixEWlJ5R4bBHIPSR?=
 =?us-ascii?Q?wc+hYXnZ9kCHmIibBv2sSY4GVVseN725EiDAKm8nSF6gfKHHUHiYjqMsKTDE?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0PmNal+fn9814AWG46DuNNeAWb3mpHZeGFP9pIbfUS0CL5HjADRd1hDVyBEqF4cd/2NB/O/qXZR1efuYoeUTmXb3x7EPF5wapmfmxv01CJpSdgzT4lwDXOrGudLbRwSi1zXBVmQ8XjKzr/gMekOifaL4lr06tPwlEullizD7DV3g1G9nJWWqlZvKlE6jbOVBpfnm+iq+3WNp8ByAIBM0fshkpWYMdPW1u94gMchWo3t05U5JvwDPEE6oNS5aPyGCs7BUVX0Y2qw1wWkaR1c+mHYR5PP5HeUnkoFwJ39RLEB1+QHViEHHiolaguXTlOjIB7iAE/68QgwnVlRMCjJZl4vYTS/OV6D3rvdXXypq2YoJHlJfJGZMVm3MHkRLvQe/GWX7udMwlj4kdGvhW/lEk6z46ppAF2IY0JXX3TUAgJEtau7Xuh+jCP/NFC7yKMLTez7LBrzFNVld6w6sokCDBRXHggSMC4GNRSlPEjK7hZvLoYia4H+SHCFIB68u8Lre5i6VkhcvGkmaV9LWBXpT2PFY0DZXKzZhJAdTcAHxVi1N2MAIZ/62guYdKUwEECJoq+M3xGD73miay++TyOLk1UEpjJL3YN08u3ks20PXYq1Hk7rOBy1fO6MigiQtojaRup0ciQ055JTplzXZ2XTczaKsHCQ/fH5JzUFgk7/UuSWQg1Kjdz+T4AGuonzClX+vIkfzofyue4GrhtyDjngylkD/z9UGJr4UibQTnMeqmxLgGmlSXDrt5J/VMdbcTYf9P72P2rnPFyKxyp1jC9sFJzS5/mMaXoulhV7x3bFoE3QXBVIiv6uHy0OzBbG9vvjfYgAdWBUHXc1DYaI3/ZNv0ZUOKFFISEUReOdIAWiYsEofIU8HmX1WEt2wQ7bmrZJomNGnR/iFh9FSMVy5LCoxFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3825e25f-5399-4873-5e03-08dac430f989
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:06:25.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVJXA8GYCDGzp61qLhOXARA8bg23L3qTtnMlEXIqE0zrcy9xkKpe5aXKUl0xBxHRYWDY7mJt1UoU3R4Vl5m6/NYurnFPci8lQe4/dNo5sOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110149
X-Proofpoint-GUID: F6UNK_18169HMcm9l9SOvn3s6v2wHvvi
X-Proofpoint-ORIG-GUID: F6UNK_18169HMcm9l9SOvn3s6v2wHvvi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With very large d_subdirs lists, iteration can take a long time. Since
iteration needs to hold alias->d_lock, this can trigger soft lockups.
It would be best to make this iteration sleepable. We can drop
alias->d_lock and sleep, by taking a reference to the current child.
However, we need to be careful, since it's possible for the child's
list pointers to be modified once we drop alias->d_lock. The following
are the only cases where the list pointers are modified:

1. dentry_unlist() in fs/dcache.c

   This is a helper of dentry_kill(). This function is quite careful to
   check the reference count of the dentry once it has taken the
   requisite locks, and bail out if a new reference was taken. So we
   can be safe that, assuming we found the dentry and took a reference
   before dropping alias->d_lock, any concurrent dentry_kill() should
   bail out and leave our list pointers untouched.

2. __d_move() in fs/dcache.c

   If the child was moved to a new parent, then we can detect this by
   testing d_parent and retrying the iteration.

3. Initialization code in d_alloc() family

   We are safe from this code, since we cannot encounter a dentry until
   it has been initialized.

4. Cursor code in fs/libfs.c for dcache_readdir()

   Dentries with DCACHE_DENTRY_CURSOR should be skipped before sleeping,
   since we could awaken to find they have skipped over a portion of the
   child list.

Given these considerations, we can carefully write a loop that iterates
over d_subdirs and is capable of going to sleep periodically.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v4:
    - I've updated this patch so it should be safe even without the
      inode locked, by handling cursors and d_move() races.
    - Moved comments to lower indentation
    - I didn't keep Amir's R-b since this was a fair bit of change.
    v3:
    - removed if statements around dput()
    v2:
    - added a check for child->d_parent != alias and retry logic

 fs/notify/fsnotify.c | 46 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 409d479cbbc6..0ba61211456c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -105,7 +105,7 @@ void fsnotify_sb_delete(struct super_block *sb)
  */
 void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 {
-	struct dentry *alias, *child;
+	struct dentry *alias, *child, *last_ref = NULL;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
@@ -116,12 +116,49 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 		return;
 
 	/*
-	 * run all of the children of the original inode and fix their
-	 * d_flags to indicate parental interest (their parent is the
-	 * original inode)
+	 * These lists can get very long, so we may need to sleep during
+	 * iteration. Normally this would be impossible without a cursor,
+	 * but since we have the inode locked exclusive, we're guaranteed
+	 * that the directory won't be modified, so whichever dentry we
+	 * pick to sleep on won't get moved. So, start a manual iteration
+	 * over d_subdirs which will allow us to sleep.
 	 */
 	spin_lock(&alias->d_lock);
+retry:
 	list_for_each_entry(child, &alias->d_subdirs, d_child) {
+		/*
+		 * We need to hold a reference while we sleep. But we cannot
+		 * sleep holding a reference to a cursor, or we risk skipping
+		 * through the list.
+		 *
+		 * When we wake, dput() could free the dentry, invalidating the
+		 * list pointers.  We can't look at the list pointers until we
+		 * re-lock the parent, and we can't dput() once we have the
+		 * parent locked.  So the solution is to hold onto our reference
+		 * and free it the *next* time we drop alias->d_lock: either at
+		 * the end of the function, or at the time of the next sleep.
+		 */
+		if (child->d_flags & DCACHE_DENTRY_CURSOR)
+			continue;
+		if (need_resched()) {
+			dget(child);
+			spin_unlock(&alias->d_lock);
+			dput(last_ref);
+			last_ref = child;
+			cond_resched();
+			spin_lock(&alias->d_lock);
+			/* Check for races with __d_move() */
+			if (child->d_parent != alias)
+				goto retry;
+		}
+
+		/*
+		 * This check is after the cond_resched() for a reason: it is
+		 * safe to sleep holding a negative dentry reference. If the
+		 * directory contained many negative dentries, and we skipped
+		 * them checking need_resched(), we may never end up sleeping
+		 * where necessary, and could trigger a soft lockup.
+		 */
 		if (!child->d_inode)
 			continue;
 
@@ -133,6 +170,7 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
 		spin_unlock(&child->d_lock);
 	}
 	spin_unlock(&alias->d_lock);
+	dput(last_ref);
 	dput(alias);
 }
 
-- 
2.34.1

