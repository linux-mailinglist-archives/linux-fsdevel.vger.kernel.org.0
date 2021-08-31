Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D13FC6BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhHaLpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 07:45:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13182 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234392AbhHaLpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:45:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V9CJho010878;
        Tue, 31 Aug 2021 11:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=TdElprx1Q5W4MHP6AoIEQ8ucEY6d2i/FalgLMl8Qgt0=;
 b=bvhcfkkITCP9v+dMLlMN8bqct3IoovEw36fhyf0MPUEb+4+gpNyhj/4QCXTc63Bi0gF0
 1I+ez2ByPzzkUoRMfJgJ0Ig8vqOn2wBuIBUdIikLx6bpehv/w0OrD9NB/VKx8Wp5RcaB
 o6bcb1Y5/CCQc/cYMSxLEO+3RemdCZmmX6emhj8GRmZ1Q8hc3ZbEjXekgFPUgMmRapnZ
 AR/Z8JsnK7D0oy+L+U087jEcUmGJyBYsJrZ6nuZPTv0LbXFCrVuP3Wop44efhv89Rw3+
 rDWI3hThOATQoBywEr4AEdFD2KXG7dE9Om6xzE7PbDRggr3MUyrSY3A/fmSDnRx33MgV 4g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=TdElprx1Q5W4MHP6AoIEQ8ucEY6d2i/FalgLMl8Qgt0=;
 b=hSm1446uOMmfbj/r8ZjGMLi8Py/vOpdn3q0lDoVq+NM1R1SJ0ahgVNhYFsQtjUXvxJ6n
 6Tx007ja0hJLYVDDTeKOunY4s4BpMycjWuXO010636nPp6ttJ5zTnsFRDw80BvUo34BZ
 ITa5aLHsSuFdczybldF2rQyTMcOvLoTA03lWebV+/efzDrAE7Rwbjg+l+EL0adBrm6bw
 2IJpgDcqPqME9HdFydwZIVqH8WZ0ovCX2qa4lM/NjlfrTcddWAmOdiDKeEIFEecNZ6Wd
 CI8kJbZPyiwXeMlW16KB40tCeFr+qiMUTscDHHEcHynVmvI5TfBtcjxXwUR2RYIQejz2 yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aserr0rud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:44:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VBdk7m165242;
        Tue, 31 Aug 2021 11:44:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3030.oracle.com with ESMTP id 3aqb6dqafq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRvCtS0s1xH5CFOhLwcSgyNZU7rklbU0y382rIQ1UX1TfdcQY98Fw5syfH+nmxFAD1V2twnpgfe9xgoOZOqtf20Zn9QUnwXToqRz2yL0zyMby1FXVbkOHVA3N6F1IP8L2oYzmYiB0Q1nF06ix/s4jDFF452GIzyqew7wnuDvh8jMoPrhYaxnOv8iQRuX4l3mD2iVerJL+XNfdTCGAscym4C8c4cC/S8sKsPGogxumNw42DwNGjoO4TriYeXwyFsH8rbtnRtSNtquQO/Abn+XZQcRSLmmB+GJJjPnNAXznhlhXS1GB3DIJMzgrI9XfEwF8ceHIst5HO/A81bGHN5P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TdElprx1Q5W4MHP6AoIEQ8ucEY6d2i/FalgLMl8Qgt0=;
 b=Eq6t6qpe2NAajMdBJv+RmNTpf0GVoCohMbiu9qES9ln9yxAZcvXJlMeesK88gWFO0Itn8EsGucCaHXSxXnboClz8kF/70KWbbprli5SPOBZ0R2UMj36xOg1One54cg1wYg1G5Qki4uRasrEm2n0xT0CaUO7C837Gn926AZPMvDnn+1lma54hA3MZZ3b3qK/7L4rC9g7woFkoO1gHjAR7wkxgucT42JRclDzFREeieir2U4I3yPrO4XIEnc+rX34zzafz3ow4C6WVlhf8SvzCyUQVUFqkVPMXF3o8BQ0bx30KtLuITBhRjDkwTSidxdEXHy+KA2OdgtwF7YGNAacAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdElprx1Q5W4MHP6AoIEQ8ucEY6d2i/FalgLMl8Qgt0=;
 b=V19vWg/MNWB/6+WH3g6ytFSUrAuTBR45TP4b/GUPq4C4IQ16sEKW2ZYctY4BMjegxAVvdp+F+9o3SfADwOXXij38nq8HFj/4tQZJP+MrVmrrO6+PqFy+9VvcpSj1MyKiVnDLjEnVvFZjFeIju8yGPntJtNrJEQ1lHMZTg4zlDPU=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4721.namprd10.prod.outlook.com
 (2603:10b6:303:9b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 11:44:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 11:44:23 +0000
Date:   Tue, 31 Aug 2021 14:43:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     namjae.jeon@samsung.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] cifsd: add file operations
Message-ID: <20210831114358.GA26132@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0171.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0171.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Tue, 31 Aug 2021 11:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e53315-b750-4557-066d-08d96c74ad64
X-MS-TrafficTypeDiagnostic: CO1PR10MB4721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB472188991E4A96D694CBE11F8ECC9@CO1PR10MB4721.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBUBcrvRuLvkW3aD/lYzpYcJld+9OqZe6jmKB+2i5IQR7dxD5hHw1XIwmfGsO/1OKVzlF3PLQFHqpxBtPXG8kKYEBLS5FsHMTAZrlemC75xRRdE3XOmatYcUPeK6Wvs5Eb77Ni0TeXGCoBMLDzMeFifBpVuWp0iDsCAoaAnKkTZ6g1XFHA70ddHguerMxKBvxFPDTP292Clbe1Mq+jMhneaZX6VPD4x9ED61Ca6H/4aez2nrTEoGZSzVHAwHcFcqp415SObMmbOul9uTtuLY1p5PrrAdUIoeV8TmOov7zmWK1xGrliFTh0mPp808C2aHvlaKdvtCW/mWJYRvMkcA7vvtIluEAaPcoVZEMk6vqBQEgarimJPqKlZYfzbN8YRG4Cq3KlMWjOMd2Wf8daIXZUoYo0FUpA213JWPg40lijOfMcQRKMwvWHFOkKEzqYdoebLKH9eZHNw6f13HG05BfswwEC/f2XoX/QyXSmVsUvM6oPwVxw0+aZm5HnGGpJHezYyAJLaLk+U02ls0AFP+U3nNetgZHwav+zZQvIeajG6r2v7KljviDi3dCwVPgUKHb0iTS8+PFHiSFX2VxYFn/7APLG/48yzoeUNp7ldtRhQx2gRFbp8PccBfL4I9JD0uVJblHxoGM/Y8O+pwpdR0xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(136003)(39860400002)(2906002)(33716001)(186003)(83380400001)(316002)(9686003)(5660300002)(33656002)(55016002)(52116002)(478600001)(6496006)(44832011)(66476007)(66946007)(86362001)(4326008)(6666004)(9576002)(38100700002)(1076003)(8676002)(8936002)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yynrgw/mE3K9kxnI4csRYN+cWQGdlMGe8vp2YrB7FVek2b5MDO0osMSjwVDZ?=
 =?us-ascii?Q?ojwguIZ+BWEUwzDV+w9MNMnAGqgPk8qr7QzZWrKClnuIfpHhvYXXwKVBkKbg?=
 =?us-ascii?Q?Getu7bV4xYQRDfgKBERPUNnj7WUNzxpGK5a5LMErlmuisTI4r3R9UKV+prre?=
 =?us-ascii?Q?BzjAuo5+Jw/zt/kbjhmfOHwJr8lBcZAbNw9moGZobXPI/bQIveoch2+WH5P8?=
 =?us-ascii?Q?NBZXAZUdI0NOcTZIYCPrQiz0ZCSVH49crj+aHwvqxEEpjd35PuDDWvBSmNlq?=
 =?us-ascii?Q?Xj0EnmwQy7lVgs8F79V6CDAPf8C7f28bWeHkORU+C2a2Xa9Ek6lrTm081tDO?=
 =?us-ascii?Q?5fs3LyeOyrDwh6ZCijxFrCZR6peZ1oHSMSJP56Sb9fz63eDHN/yWe80LDBDd?=
 =?us-ascii?Q?rKJGJTnw3z8Qf5ysBE3tWTwThi2+tdvirg/Q2g5Xu5yudRlH30j8rFyBhzOR?=
 =?us-ascii?Q?GZSO9vSqG6O2uzAZG/AYGS4FCvN9LJTnNsnqoJp1G3pzKGD8kuoy7aAK0Z5u?=
 =?us-ascii?Q?dR8Lp1YUwJ/hyag0xKBxWZRSBab9O64jwIA+PaIZF7ZaIynsSUX6fG95sJr6?=
 =?us-ascii?Q?u3zBSad3ZPu+pdU2g85w55Sx2wW3ixQ45FFbwvsYjq7+McxkCluHg8gI1vM6?=
 =?us-ascii?Q?HEiDaB9RuZZ9vkxAwK3ks1birPvErDivIaH7iS74eWkPPWf1/Jw1gv++YOLj?=
 =?us-ascii?Q?iN8JOcCCChbjvtsMVDApvfMSdP8Uhz4sWA5L6Ed6WekyXXV+l2/q9m2kbIA1?=
 =?us-ascii?Q?W0Z1cWIosyMktKEmRDT1E7SvR2A4THx9NzOzKZfYiy6uF0+fgTNeVkbWRGYd?=
 =?us-ascii?Q?UlWyZ+9x+St372a9n88WBvkTnMwWU8CrWsEzvdHF1cj5V+GYreO55I923w05?=
 =?us-ascii?Q?08e3K5IB1GyexGT45qALT/8edLLVYA4ElnmZfsd0ZUUPLQXonN636iSwvK7a?=
 =?us-ascii?Q?2N1f8gajaTQatUYgjr92Q6b3P1t6noshd0jFlxRXqGgOe8qgMb+JR+Ge5G8n?=
 =?us-ascii?Q?DGQjYJvMQM1sVQWloi6QJ83UftUv9NvydTJYD8MZ20tAa9GIXqDwDH+CTNvB?=
 =?us-ascii?Q?SwKfPSJGxgi1ywUfCEm9tHvri51mV02+NFqOd9jpJBdKftsLKs/qKsDZUMbo?=
 =?us-ascii?Q?ODrCw45dwE494jYVjik89pZdK263oOyZ2PkCb0ZKqIfQT9bER1eKOBQhHcNo?=
 =?us-ascii?Q?+6CiF7+TtVTY/DlwN5j14XRFw4NbD+2hlBC14Y1f44OB1YKM3Buqc3TtYFQd?=
 =?us-ascii?Q?hExXfm2hl8n1kiLwH7NAyLf5A/S4r3d4Ym0FwhF9ufD7OEHho5p2OytZO5KX?=
 =?us-ascii?Q?6ESWjWrVkkRWuoqDfd3pHNleq5tzK717F8H7+xeDmfeMUAJqVqBZ9EZWaK3L?=
 =?us-ascii?Q?F1hTKxM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e53315-b750-4557-066d-08d96c74ad64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 11:44:23.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1SxwXeMQShj5O0yOVxkEpIdgmg4jbSAYrr6+9TCqV5WRwMte44aNlAR9Tu2Lv/GHa/0dzcLCcXKyZ0rzwQ9CJoOtKigxvRp7eJXtioZENM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4721
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310067
X-Proofpoint-GUID: Z0s973NJdf7iwCjoLx0K2g7kumGMISPC
X-Proofpoint-ORIG-GUID: Z0s973NJdf7iwCjoLx0K2g7kumGMISPC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Namjae Jeon,

The patch f44158485826: "cifsd: add file operations" from Mar 16,
2021, leads to the following
Smatch static checker warning:

	fs/xattr.c:524 vfs_removexattr()
	warn: sleeping in atomic context

fs/xattr.c
    514 
    515 int
    516 vfs_removexattr(struct user_namespace *mnt_userns, struct dentry *dentry,
    517                 const char *name)
    518 {
    519         struct inode *inode = dentry->d_inode;
    520         struct inode *delegated_inode = NULL;
    521         int error;
    522 
    523 retry_deleg:
--> 524         inode_lock(inode);
    525         error = __vfs_removexattr_locked(mnt_userns, dentry,
    526                                          name, &delegated_inode);
    527         inode_unlock(inode);
    528 
    529         if (delegated_inode) {
    530                 error = break_deleg_wait(&delegated_inode);
    531                 if (!error)
    532                         goto retry_deleg;
    533         }
    534 
    535         return error;
    536 }

The call tree is (slight edited).

ksmbd_file_table_flush() <- disables preempt
-> ksmbd_vfs_fsync()
   -> ksmbd_fd_put()
      -> __put_fd_final()
         -> __ksmbd_close_fd()
            -> __ksmbd_inode_close()
               -> ksmbd_vfs_remove_xattr()
                  -> vfs_removexattr()

fs/ksmbd/vfs_cache.c
   669  int ksmbd_file_table_flush(struct ksmbd_work *work)
   670  {
   671          struct ksmbd_file       *fp = NULL;
   672          unsigned int            id;
   673          int                     ret;
   674  
   675          read_lock(&work->sess->file_table.lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Disables preemption.

   676          idr_for_each_entry(work->sess->file_table.idr, fp, id) {
   677                  ret = ksmbd_vfs_fsync(work, fp->volatile_id, KSMBD_NO_FID);
   678                  if (ret)
   679                          break;
   680          }
   681          read_unlock(&work->sess->file_table.lock);
   682          return ret;
   683  }

Hopefully this bug report is clear why Smatch is complaining.  Let me
know if you have any questions.

regards,
dan carpenter
