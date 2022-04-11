Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A637A4FC1CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348384AbiDKQKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348252AbiDKQKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC986574;
        Mon, 11 Apr 2022 09:07:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFHY04031505;
        Mon, 11 Apr 2022 16:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=r6sIA6hM5ZAyYAd1LLK4LT9RIh4Duc2ooY1+A/URwWc=;
 b=tcFhct66A9BWv9GsvSsYy1rnC2T/BqICiuG0R87vhdrkPNLOgXEkVNr3Yuf1nwSCVqDS
 rXm47hkMhOfNgQ3jzK4pbW6H/H65BV01hcnZ7XUn5sb93HP3HT9OfR0r5AzpLDcphDnD
 M5FeND9GQssUzhw1z9qOIGWr79wfc8Ci/xvpgjnISr7lotsfeHR2A5SjkDLgOTPpKB0x
 E0twPvGPMJ4uqA5JNwf6MjOvaaw3ZDtsRRW+/PvA9w5tV7aM5cVI2nRZW72jO1Kdivs9
 ZAkuyQe7NZhWI8oP+UuGZAbt/SOS6ztHC/8rDxpXE5oY5G6KFAktNqY7bdaGQh95Renj 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs479t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG0PYX016319;
        Mon, 11 Apr 2022 16:06:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck11rwj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW9hMLrXd5d6G2Uf7oK3H8Lci1QMBDcHJVHDv6sH7TTFRXEWmAR2tO0DAvZtKY9EADo46SKPSWKyPWeO4S1MrhVsyiX5AL4KmlFIlYvEOwNJ7rj6u8Is+hjwKNNxOzwBCF7OqIF23Vf03LxF1J49zQ+5wWCRYEEmYBqtIyuNzvkVbNSCagmJyozaxB1cuLiqz8GGavIuKXpuNB4+fhdcYFU0okijDYfrNM74I5MMrTVuxjInOX6iVUTbd/AarOCcNEOl00ZCfvXCMbQi1mFiLehROfjRLP2dEYQJ4ZDMXG/MUCO75XUl8zWfb8xTRm6fizFhvgb1aRZ1bojv6Hz5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6sIA6hM5ZAyYAd1LLK4LT9RIh4Duc2ooY1+A/URwWc=;
 b=QIEpfUhzrmGcurW8ph2zX1VsP1ig/6cYHr7n/AjojAc/DT3iDmVJHhRlorp9HVy0q6YDzX3xbplpLEcKpY1dXYAz+l7tL7TQee5VaFsN+NQ02eBbti4pJ3I9JWtu1rvRkR9uDahegxBaD7evKOmeK7yGQc7o2OQsXrUy2+JRVODBdHnmoPAGm2J26j0WvCYL/TeXr1zJJWBatIexS77+kwnV/Ps8wNDCqjiGMhjPmFf24dOiu+JrY3reHYGHTre+swOEsrZeUB33s3qT3F1mPtFrxvQA15Sp7Jr9oCSeEm33qHn/U5zA+Loco+V+jjboDJJIzEsmKsHuv7K+9OzZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6sIA6hM5ZAyYAd1LLK4LT9RIh4Duc2ooY1+A/URwWc=;
 b=Yh9vSdS+nZYs19HhbiYsBGr9Yjo69938fh7WzhbkM4+ZfBpAaXPAZd/5VK76a9593Qs0iWcO1sU6rfTAfJNeuKp8LtSEXo56ODNm5jFHoSzZQKXxZycUG7Z6my6zt7LO7BIQz17JHWMXfjQMQaO+5Sho0pE2J+1lbU1HbruwFas=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN7PR10MB2609.namprd10.prod.outlook.com (2603:10b6:406:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:06:34 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:06:34 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v1 00/14] Add support for shared PTEs across processes
Date:   Mon, 11 Apr 2022 10:05:44 -0600
Message-Id: <cover.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34c5374c-1451-4630-2e6c-08da1bd53fc8
X-MS-TrafficTypeDiagnostic: BN7PR10MB2609:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2609AEECE2AEB45E498FA57F86EA9@BN7PR10MB2609.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Abg/dyh39yVQUnH8jVpRW3SxhrU1+VUomuctx8uC/d1J0IKnip4zp93hjxMdz0MTELUXAFoNb+QMJ+H50nqo87fzs/YPvBQieM0ZImjZK6CGQRcePYErAHP0zd886Ygo2GwIeIPG93e48mo1tChPW42HQ2rQEPkFzxkxZRP4L4TuU7W9o3NBETMopg8h6fLWk2UuDMdv7bylPuUsjUZfXhk2mYBW6jN9DpDwpuC4UGKNPaWotm04xjBL/m0plL+cUVWfGOgB3s64QVnCgSyIr5mBciAWeg7bj8B72KImFdvzahDNELwrPhCaduL735TzSU/G9BbLXUQ5YCqhJ9BCOPLVPQ8BjKxq9Q868oKxKoyXKlOE9G/gXUvCFgCa+6CpvVvCABmm4UTTX1HfaMxmIVM3Acvar5TWGIOozjYYGeukVHDf+GlBGftaCyrxnBegcAWS/Bsc8Hq+xitpJfwU+big4Die+uS9GK+i4+bUYYXdWvn6VWh1qwj0TeyelgNvL3C41KY9RF1b1I64XPvyRQYqFRSfMq0gjeUBHamIJFAToDRqqTJY+KP1QiBdRMbk5TinNLvZVyOkz5Mg0LM+Ea2cAXKbqnO13E9a2jh03WoRz7jzVAlSJdM83rjsODCHfn1xos+GUwdGdj1kxPKMzR4iTTutpRe8y9OS76ix0TjPoe5kgkYqIU9wYOt5o5+r2Wdx3A+CaLBZNqG1gYXAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6506007)(6666004)(186003)(316002)(52116002)(66556008)(6512007)(8676002)(2616005)(4326008)(86362001)(5660300002)(44832011)(83380400001)(26005)(66946007)(38100700002)(36756003)(2906002)(7416002)(38350700002)(8936002)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJqFWuHEtdlI373shMqq2xkmrX7hQMflQEdNvap8T4xN39u7w/pPcYb4A3B3?=
 =?us-ascii?Q?f9MFedTPQbYLZvAvVx3Nb6a2GoDC+fdEt/ZaidcXQdw0MKMs8CXwTrAN8WlU?=
 =?us-ascii?Q?6TtEI2Pw43EUXh+64P5JrgmiwgHWSgrJzP9nkKF15TV3kNPvm7Ngt9Wz5oXz?=
 =?us-ascii?Q?gxAr7C/FM6m5mdhKsYQ5c4DCifKbV0aYUSsHE9ji1/ElPhHzRlV7HLUrKTOL?=
 =?us-ascii?Q?WYDJrg6Uonp7MqUAU/2lhzJoMyuKl2F6YaMCle11cMiPobiVzIDyGT8uWhlJ?=
 =?us-ascii?Q?MhrFqkV29ZkO7YZsJl7Nx/xoZ9M6y+/bVrQhN+tkUDvK92Q5l/wGvEkMeap0?=
 =?us-ascii?Q?82FtV+uzXUsUgqjt7hJOaPoTYsvr9bkFMxUwFit1e45UuSXIR9jHV0p8BCU7?=
 =?us-ascii?Q?xxrB3GWLvibh8Zi0SYc3HiTpB+HC2szDYAZcu4SgnmFjnthRTvKLu+03tYsV?=
 =?us-ascii?Q?JUgvQIVHSDOA61I22HCFkZtYCzsR6K4Ptd8Dj483J/rPzH/EELU3AmeNXsuA?=
 =?us-ascii?Q?T0+QDG23yz1G8IZhCaYp2R1CWGdHoGlyrdKVs9yW4uEdQ+cAu0j+fyukqFRx?=
 =?us-ascii?Q?07YIOvQ0ti+qCf9hUjbHqhN6wpXS3l+2u4D3vDSSUne/i2N5VWAh74rWC+zj?=
 =?us-ascii?Q?mu4K7qRR+IXF+XrLmtfs0Xne7WuFYobpOCEHRfRElQuWohex5uxpKqGw+vLG?=
 =?us-ascii?Q?92a77frKo1YoHzJdw24WgFlnnMnBmnB2oAF2YhqAltHqH51lacT6hBlBXPLy?=
 =?us-ascii?Q?l9/m5ooG6s6HE29SSSJgBomuKKkMscUgMb9HLnPCHnbkIGXVz7JLy6HdH7bX?=
 =?us-ascii?Q?91Ul/e4R458LpkohG4CMbYumsgAQlsa0RyJ2Gb22Wx1RCcNGSfEMk7god79C?=
 =?us-ascii?Q?cFZXy9nN/fne7RsYj2L/oGw7wqtsMzPgGCA+BREodqLKvr1yOBpwal5OoInh?=
 =?us-ascii?Q?0e36Ei4LD6iT+FNWusLTlm4klHdbVepe0mHaQNyVTiKf8Bj8gySA52a+JpMq?=
 =?us-ascii?Q?R31GDu8F/yF9k5iMzhIoEw8eB74HBkaf3OgAK7661WyziXR1qRcnSEatAhLH?=
 =?us-ascii?Q?7tVmtNAZmzqfev/cbd82YL3ZrJU2b0R8ugVwoP9S/TUy3cna1b9YNzWyhnFd?=
 =?us-ascii?Q?pTI3wg6W++H4MMbsO70CfyU+FMEKFmWACR5REOJ+cyOgRflqMyId4QCGnhkM?=
 =?us-ascii?Q?gd1FXLZQ8AHJfbTRpcGm2sjaTMoPoDlRsRDofy3Jgnk/iteV+XrXcwQNueqn?=
 =?us-ascii?Q?CSbRcaVuVB9MY+zmG0380ZfNbpvEKNqPIm1FQyYzM+z36ul5SExu1n6LV+vE?=
 =?us-ascii?Q?0Gx+LimbH8SeeiIGNrryqFbXUEFePPxoXbw0uHwKIpOv/XzdOpjgjEi2QGx2?=
 =?us-ascii?Q?tKbt8s2WL97yX1mMLuK5AMdDkNvGuEcz2R78PRbCmiVgg5k7f5pWAKbksVV6?=
 =?us-ascii?Q?fx7dbUZtLhClEAAtwZuoKYIE2i2bRXJ/L5Cj17nxYFKRdbkoHsPl+5imFVQp?=
 =?us-ascii?Q?sKcDuNiJXbW6HrT7zqbkR14vMZgU7bPC2LyKaHsORrQhAtMAyM3a9I2x+3Sq?=
 =?us-ascii?Q?9WfMwZTB3UMp+/tMp+nDGVOCfPdV6Rpm5uOv0vTK26MwDFsRvzskI+IXYaaH?=
 =?us-ascii?Q?6GdFMPA+E3IK6yJ7xlnO/eGs3stdvJXI9kzHSm4FmUt1HCXTrvOrIYLktm1N?=
 =?us-ascii?Q?zwJHeFFhVsO5SeSMCcWxrzJ133k3MfguVhTr2TWhq7cm5uc5exX5GzmWj0sn?=
 =?us-ascii?Q?uZ8anG9IQg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c5374c-1451-4630-2e6c-08da1bd53fc8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:06:34.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIJFgFQO2JSWXMnvwzGt5AVKYGWdu6PiN0dfogZOhTHHYMHXpLQNUyyvCzvG8NvVhR7vGaCxwdEgdMYDBIc48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=948
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: vfoAOSMAUw_0-QKP8vjmNLdSEBP-Nm6N
X-Proofpoint-GUID: vfoAOSMAUw_0-QKP8vjmNLdSEBP-Nm6N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page tables in kernel consume some of the memory and as long as number
of mappings being maintained is small enough, this space consumed by
page tables is not objectionable. When very few memory pages are
shared between processes, the number of page table entries (PTEs) to
maintain is mostly constrained by the number of pages of memory on the
system. As the number of shared pages and the number of times pages
are shared goes up, amount of memory consumed by page tables starts to
become significant.

Some of the field deployments commonly see memory pages shared across
1000s of processes. On x86_64, each page requires a PTE that is only 8
bytes long which is very small compared to the 4K page size. When 2000
processes map the same page in their address space, each one of them
requires 8 bytes for its PTE and together that adds up to 8K of memory
just to hold the PTEs for one 4K page. On a database server with 300GB
SGA, a system carsh was seen with out-of-memory condition when 1500+
clients tried to share this SGA even though the system had 512GB of
memory. On this server, in the worst case scenario of all 1500
processes mapping every page from SGA would have required 878GB+ for
just the PTEs. If these PTEs could be shared, amount of memory saved
is very significant.

This patch series implements a mechanism in kernel to allow userspace
processes to opt into sharing PTEs. It adds two new system calls - (1)
mshare(), which can be used by a process to create a region (we will
call it mshare'd region) which can be used by other processes to map
same pages using shared PTEs, (2) mshare_unlink() which is used to
detach from the mshare'd region. Once an mshare'd region is created,
other process(es), assuming they have the right permissions, can make
the mashare() system call to map the shared pages into their address
space using the shared PTEs.  When a process is done using this
mshare'd region, it makes a mshare_unlink() system call to end its
access. When the last process accessing mshare'd region calls
mshare_unlink(), the mshare'd region is torn down and memory used by
it is freed.


API
===

The mshare API consists of two system calls - mshare() and mshare_unlink()

--
int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)

mshare() creates and opens a new, or opens an existing mshare'd
region that will be shared at PTE level. "name" refers to shared object
name that exists under /sys/fs/mshare. "addr" is the starting address
of this shared memory area and length is the size of this area.
oflags can be one of:

- O_RDONLY opens shared memory area for read only access by everyone
- O_RDWR opens shared memory area for read and write access
- O_CREAT creates the named shared memory area if it does not exist
- O_EXCL If O_CREAT was also specified, and a shared memory area
  exists with that name, return an error.

mode represents the creation mode for the shared object under
/sys/fs/mshare.

mshare() returns an error code if it fails, otherwise it returns 0.

PTEs are shared at pgdir level and hence it imposes following
requirements on the address and size given to the mshare():

- Starting address must be aligned to pgdir size (512GB on x86_64).
  This alignment value can be looked up in /proc/sys/vm//mshare_size
- Size must be a multiple of pgdir size
- Any mappings created in this address range at any time become
  shared automatically
- Shared address range can have unmapped addresses in it. Any access
  to unmapped address will result in SIGBUS

Mappings within this address range behave as if they were shared
between threads, so a write to a MAP_PRIVATE mapping will create a
page which is shared between all the sharers. The first process that
declares an address range mshare'd can continue to map objects in
the shared area. All other processes that want mshare'd access to
this memory area can do so by calling mshare(). After this call, the
address range given by mshare becomes a shared range in its address
space. Anonymous mappings will be shared and not COWed.

A file under /sys/fs/mshare can be opened and read from. A read from
this file returns two long values - (1) starting address, and (2)
size of the mshare'd region.

--
int mshare_unlink(char *name)

A shared address range created by mshare() can be destroyed using
mshare_unlink() which removes the  shared named object. Once all
processes have unmapped the shared object, the shared address range
references are de-allocated and destroyed.

mshare_unlink() returns 0 on success or -1 on error.


Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
        addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
                        MAP_SHARED | MAP_ANONYMOUS, 0, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
			GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
        if (err < 0) {
                perror("mshare() syscall failed");
                exit(1);
        }

        strncpy(addr, "Some random shared text",
			sizeof("Some random shared text"));
-----------------

Snippet of code that a consumer process would execute looks like:

-----------------
	struct mshare_info minfo;

        fd = open("testregion", O_RDONLY);
        if (fd < 0) {
                perror("open failed");
                exit(1);
        }

        if ((count = read(fd, &minfo, sizeof(struct mshare_info)) > 0))
                printf("INFO: %ld bytes shared at addr 0x%lx \n",
				minfo.size, minfo.start);
        else
                perror("read failed");

        close(fd);

        addr = (void *)minfo.start;
        err = syscall(MSHARE_SYSCALL, "testregion", addr, minfo.size,
			O_RDWR, 600);
        if (err < 0) {
                perror("mshare() syscall failed");
                exit(1);
        }

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
	printf("\nDone\n");

        err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
        if (err < 0) {
                perror("mshare_unlink() failed");
                exit(1);
        }
-----------------


Patch series
============

This series of patches is an initial implementation of these two
system calls. This code implements working basic functionality.

Prototype for the two syscalls is:

SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
		unsigned long, len, int, oflag, mode_t, mode)

SYSCALL_DEFINE1(mshare_unlink, const char *, name)

In order to facilitate page table sharing, this implemntation adds a
new in-memory filesystem - msharefs which will be mounted at
/sys/fs/mshare. When a new mshare'd region is created, a file with
the name given by initial mshare() call is created under this
filesystem.  Permissions for this file are given by the "mode"
parameter to mshare(). The only operation supported on this file is
read. A read from this file returns a structure containing
information about mshare'd region - (1) starting virtual address for
the region, and (2) size of mshare'd region.

A donor process that wants to create an mshare'd region from a
section of its mapped addresses calls mshare() with O_CREAT oflag.
mshare() syscall then creates a new mm_struct which will host the
page tables for the mshare'd region.  vma->vm_private_data for the
vmas covering address range for this region are updated to point to
a structure containing pointer to this new mm_struct.  Existing page
tables are copied over to new mm struct.

A consumer process that wants to map mshare'd region opens
/sys/fs/mshare/<filename> and reads the starting address and size of
mshare'd region. It then calls mshare() with these values to map the
entire region in its address space. Consumer process calls
mshare_unlink() to terminate its access.


Since RFC
=========

This patch series includes better error handling and more robust
locking besides improved implementation of mshare since the original
RFC. It also incorporates feedback from original RFC. Alignment and
size requirment are PGDIR_SIZE, same as RFC and this is open to
change based upon further feedback. More review is needed for this
patch series and is much appreciated.



Khalid Aziz (14):
  mm: Add new system calls mshare, mshare_unlink
  mm: Add msharefs filesystem
  mm: Add read for msharefs
  mm: implement mshare_unlink syscall
  mm: Add locking to msharefs syscalls
  mm/msharefs: Check for mounted filesystem
  mm: Add vm flag for shared PTE
  mm/mshare: Add basic page table sharing using mshare
  mm: Do not free PTEs for mshare'd PTEs
  mm/mshare: Check for mapped vma when mshare'ing existing mshare'd
    range
  mm/mshare: unmap vmas in mshare_unlink
  mm/mshare: Add a proc file with mshare alignment/size information
  mm/mshare: Enforce mshare'd region permissions
  mm/mshare: Copy PTEs to host mm

 Documentation/filesystems/msharefs.rst |  19 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/mm.h                     |  11 +
 include/trace/events/mmflags.h         |   3 +-
 include/uapi/asm-generic/unistd.h      |   7 +-
 include/uapi/linux/magic.h             |   1 +
 include/uapi/linux/mman.h              |   5 +
 kernel/sysctl.c                        |   7 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |   7 +
 mm/memory.c                            | 105 ++++-
 mm/mshare.c                            | 587 +++++++++++++++++++++++++
 12 files changed, 750 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

-- 
2.32.0

