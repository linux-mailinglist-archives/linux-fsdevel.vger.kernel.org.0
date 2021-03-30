Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8934F312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhC3V1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhC3V0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULONSn011485;
        Tue, 30 Mar 2021 21:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=yUuQ6MQgIvRVMnLbvkNufFSI7S9ZTYuth/hjvaPUOJQ=;
 b=PvEGuM6j5q5Kx/IyAVMGCKm7Bo7ddxnKw7lk13ncrewMXdbHAIRT1iF5mylqdYOvTyuM
 3K2WtbJlPo7uDad3hBSrUnlwf1MJ85KMWnzNkffHi1sQwKiRAuXg5jGQ7VYkYEvAUtAW
 361BjmuVULLZpWuMwsa3cGs3aPYAHOSRqWgrwmxx11cT2SJjt0bkgD9YY1fG7iNbmSMX
 MAPjZeIS70BRiCz5xo1NNUxG1O55III0R7iqZ7z3gR/ZlHfF3m6tWD0QIC7tEWFQIcUX
 tVPU1TD+XxbS1/Hv2A5eu7yn4bzuNHppLPQH68mFfN23HbF5DlKUmcSd6NNoxW+D2Pdy NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37mab3g8uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULBS4f065401;
        Tue, 30 Mar 2021 21:25:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 37mabkbbfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsezOLTG/D+LMMs+cFShj/AvI6kgkqYp5gMSieIDRyABhCl9xO3pjc04gQ8CFlIoUCbPRBEZy4ZyQv0qCzVkWuHEBQd65m1F2vh3yHY7T+BFSHRqweCAa00Dz/J6R5IibO8p04PUlXNTrZji6lAjKPuh++93UUEtRWWPgZOcLQjxsDYD67LfgrNzw7A/HLDs+EP43PGhWesfwX+DI+sCUNmGNMWD8UOM7Gl4Q/A8zE+Y9YTry+lHmRQ3F/5dZAYMCIcmc40ZyYVvBnCE3oao7D1g6u8kgV6AIucIobfTRnUt4AWjnNl79bg0WEFjYMiBhCDp9/Iu51ns71r30rvmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUuQ6MQgIvRVMnLbvkNufFSI7S9ZTYuth/hjvaPUOJQ=;
 b=Ag7wAzzAIrGvnHEsjmOVzKPFK7T3EE7+pBWMkQsPqwlr/wVRw7ZyMWmqXkhHBSXO2JsSjQEzJ6KW7gDKpxO8WWsblxcP9Wcgl/tbFk6YkgwqtmE4lqZZZ0n151Mu/QUbZgnyw1r/DLNMZUe6yoymhUJfLWfwVp8kv/zxvQigCA6lO6xKFS36qFrxtKkdko/yhDgV55NGR7BnMc6JnZIjpQu9lR0wh8o33Fb/luMO5IciftTbgf27wCr2uQ7wEqzNShUogNQhZdzDqHAyb4BIliSba3IiXGnLJPDzf6zLpof71/cD3Ikl91L3Wlc2x2xgurPIr+GiCC/7otcVLOHvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUuQ6MQgIvRVMnLbvkNufFSI7S9ZTYuth/hjvaPUOJQ=;
 b=N4SX0IFmZQmpTjQk2KvwQ0i0YcJTh95XlNgKImy2PjqrA2C7FuFlaeZIkNhghuYMWOqsuhgz10ZHwstfTUlu2ozVDuTY5FQinUx+/oHJBxbZm2RWXzJ0nFHRsDyNAC92ylyhR2chy/CjcOLJSgZi3AGCyVVFAGPGHnk7oXm7JXU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:00 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:00 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 00/43] PKRAM: Preserved-over-Kexec RAM
Date:   Tue, 30 Mar 2021 14:35:35 -0700
Message-Id: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:24:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5562b439-896b-473a-1f6d-08d8f3c24610
X-MS-TrafficTypeDiagnostic: MN2PR10MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3120530881BC837BA13BD865EC7D9@MN2PR10MB3120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohp3+An/bUARqnyLaC/fXRm9XMKmNHxu2uRGETZWQAaerC7Xi+WMhwdf8W+QBEn6uo5iAbd1hT5lMtBeF3NzNOv4n0hSq7AVYvFAxJJs95dTd/6RKxH7mNR+VX95BtkhjWUR/dk4ydKPV+3JFpOPNkwMniP6XkvAqs4hRWAYYcs8y1abz7c5WsSSzdpi+jQNY66g8fY0sQ9h2DkxsQrjkbD9iO5JWMNcceE9glWVUxY3WbbSXPos5YIwRvw9MEf0zxWdTEHV2KlegUsRtCZlEWtlQASDNPNdts3iRgf0l8wMh1FYynsF0MS3X/R24cV58FmXi2vXWFftdn8Tyy1lhKyd07pnweJOZ+F81QZA1rYcZJkaqpBkxdoXIdLAiUd4bXdMGw4yoiKgm8F6yFSkSDEhVlsSu7fonll9ZyItJerUnaWnS3Mepr8XZ3ngx8B+fPvILpAdRj0clBaKySq+ncMCRr+RYiTePAzf18ZZ+IGJ0Bs0xmr2FNdRMRJr5e31lge8eleXtI9mv+7BHU1fkkIatHftFlQ4CwXsWOkG/L4wwr4jycUCjacnR3O9Eu7ComoHNlHk0Zxd/x+I/N1si/E+vUhmkxCBCBUvAvpuQFhTc5Fl9gF7vQpbZPbB8Dz1BEXstIYCtgpcMfYzOM+Y0P5iFbzhxE/kw2tifJvjCtOAe3GVmjvy0EEWBHLZaWmBSYY8QPO0YyCz1IvZib96wdW9phbUikMQQFgIDKWwSE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(52116002)(966005)(316002)(186003)(6486002)(16526019)(5660300002)(2616005)(956004)(6666004)(8676002)(66556008)(44832011)(478600001)(83380400001)(7406005)(38100700001)(86362001)(7696005)(66476007)(66946007)(4326008)(2906002)(26005)(7416002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BBCbzM3dl36wMaQOcA2F39fOGNubaF7a+cWSqcesCMccfpuKb7F2s8JT3Qmr?=
 =?us-ascii?Q?/nUYm5yMzlfgy+ahC5G0xBB9J5YOXhnRdGPO3mM4KsSPdOcoF8nwg3FjnK6P?=
 =?us-ascii?Q?efiDmSRg7VAZI2utBvlGBQUuBReepDgq/f27VMRy+nAAouOp6laYNCdyXLiV?=
 =?us-ascii?Q?/VGIhRacd6F1xAukjg0keaI4w+GShUSl/VR2ntxc44kKt80KJQrsd4n2si2R?=
 =?us-ascii?Q?O24hXju9zAiIRT2QrE2bENQbxz+hycDfBfee9l9yapiycCQG8cvPZYPrxc5d?=
 =?us-ascii?Q?8GysU8t6uTEV0CCjiyF+1CD0FQ9+TWYMgQt/7VTCzGMNvSYlHpNyfc+DKDgQ?=
 =?us-ascii?Q?mKkV6j/FDcs1Q5CJJpkljJDSARrEZ33NQWe+/KisuxBgy5j2jIYkz5I+5b06?=
 =?us-ascii?Q?Ppa05X6spwmzChM0sU41f6TgOhkEBcXWP2id6y1fvzOuA5U0CFPdDrigixE8?=
 =?us-ascii?Q?188px95TmLd73dyZxZdUZp44HCKDMh0CPMwh7A3Uuralp3os9MpR/SURBH75?=
 =?us-ascii?Q?dPop331LOKyQq58v5/8vTMEfg6iQHvX4ktnLrZGoA83MVwWYQPeayFrp04Tb?=
 =?us-ascii?Q?Vfvrfop71ESsw5cAPbZ+pCmNIXSTwA/eg0TlAAkEVwl43g9/FsQJ3dHwmz8z?=
 =?us-ascii?Q?/WHUcei6PbKug9duLUVckvjblmP2IhdJYdcWtMGYQqqKzZ8R7VGsphpfgaGg?=
 =?us-ascii?Q?+PrBBU4ITgGtGWwOHnkFPe+ZmEUrGsoPBBuNXbZZoHlZuy8FJnXxLHUF91Xl?=
 =?us-ascii?Q?6ghdurrDsiw/ENOn2YLz2ibCFM1QQOwTOlgMAbFKx1J+QjFGpX3KjwMONodF?=
 =?us-ascii?Q?fn1jiQuwpisCjJGCxTCXV491eM2BqIAUb4E+jGJKwUDykjPqbkhuA+VZhKCs?=
 =?us-ascii?Q?QsL2dhL+VydMVJS182ttj8KWKAkWxheyy5yNvLDYfVeUOA4QLaZjaBc0AdqJ?=
 =?us-ascii?Q?ctg3B5qP9t4iFXJqKu9AJytstzm2w3u6ZMWjVwMMILlHZZMEJt2igk1tnL3r?=
 =?us-ascii?Q?RKDOMsRZADl/UMuovbJ3K/dSVwQNkQyNRN+9Dtlupar4jXlGVMA1DB9Kz+pe?=
 =?us-ascii?Q?Uvb66uUV4bafPKi+7ffJjv0a0yU69vkpXda+S9nGiIIVoIM4Z/Wt27Yez8xn?=
 =?us-ascii?Q?C8Do+u43qYwfRUUwla2ljRnWeoKaPvIDJbrmsH7c60lJ1Z7MYghCCnW8prz2?=
 =?us-ascii?Q?QKkWXVDFuHlyvORWrt+Oa8nwkqKkxseKp5Tg7GbGQiOnvwknsB4G35xKMmYK?=
 =?us-ascii?Q?K39Ewdb3/ICAvRrJLnnIGqAp1PaHix0g7TeQnui4FaIo/dl+LuzRpDm+pAvq?=
 =?us-ascii?Q?8Fnyd5U31SLHHtE3+rR7EOHI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5562b439-896b-473a-1f6d-08d8f3c24610
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:24:59.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nb8KooD33OIfMi0LjVUHVazcAFr3OPSsLqSbIYM0eSgABKA6psJGDDzQwRc2b/Yg7sNYQ+/G8RGbAAtr6+2SDMbltBKI2TWF5/snHRG6MMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300155
X-Proofpoint-ORIG-GUID: W7WblQTsoSAUbExD2EdxrPAyTfBbjmNJ
X-Proofpoint-GUID: W7WblQTsoSAUbExD2EdxrPAyTfBbjmNJ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset implements preserved-over-kexec memory storage or PKRAM as a
method for saving memory pages of the currently executing kernel so that
they may be restored after kexec into a new kernel. The patches are adapted
from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
introduce the PKRAM kernel API and implement its use within tmpfs, allowing
tmpfs files to be preserved across kexec.

One use case for PKRAM is preserving guest memory and/or auxillary supporting
data (e.g. iommu data) across kexec in support of VMM Fast Restart[2].
VMM Fast Restart is currently using PKRAM to support preserving "Keep Alive
State" across reboot[3].  PKRAM provides a flexible way for doing this
without requiring that the amount of memory used by a fixed size created
a priori.  Another use case is for databases to preserve their block caches
in shared memory across reboot.

Changes since RFC v1
  - Rebased onto 5.12-rc4
  - Refined the API to reduce the number of calls
    and better support multithreading.
  - Allow preserving byte data of arbitrary length
    (was previously limited to one page).
  - Build a new memblock reserved list with the
    preserved ranges and then substitute it for
    the existing one. (Mike Rapoport)
  - Use mem_avoid_overlap() to avoid kaslr stepping
    on preserved ranges. (Kees Cook)

-- Usage --

 1) Mount tmpfs with 'pkram=NAME' option.

    NAME is an arbitrary string specifying a preserved memory node.
    Different tmpfs trees may be saved to PKRAM if different names are
    passed.

    # mkdir -p /mnt
    # mount -t tmpfs -o pkram=mytmpfs none /mnt

 2) Populate a file under /mnt

    # head -c 2G /dev/urandom > /mnt/testfile
    # md5sum /mnt/testfile
    e281e2f019ac3bfa3bdb28aa08c4beb3  /mnt/testfile

 3) Remount tmpfs to preserve files.

    # mount -o remount,preserve,ro /mnt

 4) Load the new kernel image.

    Pass the PKRAM super block pfn via 'pkram' boot option. The pfn is
    exported via the sysfs file /sys/kernel/pkram.

    # kexec -s -l /boot/vmlinuz-$kernel --initrd=/boot/initramfs-$kernel.img \
            --append="$(cat /proc/cmdline|sed -e 's/pkram=[^ ]*//g') pkram=$(cat /sys/kernel/pkram)"

 5) Boot to the new kernel.

    # systemctl kexec

 6) Mount tmpfs with 'pkram=NAME' option.

    It should find the PKRAM node with the tmpfs tree saved on previous
    unmount and restore it.

    # mount -t tmpfs -o pkram=mytmpfs none /mnt

 7) Use the restored file under /mnt

    # md5sum /mnt/testfile
    e281e2f019ac3bfa3bdb28aa08c4beb3  /mnt/testfile


 -- Implementation details --

 * When a tmpfs filesystem is mounted the first time with the 'pkram=NAME'
   option, a shmem_pkram_info is allocated to record NAME. The shmem_pkram_info
   and whether the filesystem is in the preserved state are tracked by
   shmem_sb_info.

 * A PKRAM-enabled tmpfs filesystem is saved to PKRAM on remount when the
  'preserve' mount option is specified and the filesystem is read-only.

 * Saving a file to PKRAM is done by walking the pages of the file and
   building a list of the pages and attributes needed to restore them later.
   The pages containing this metadata as well as the target file pages have
   their refcount incremented to prevent them from being freed even after
   the last user puts the pages (i.e. the filesystem is unmounted).

 * To aid in quickly finding contiguous ranges of memory containing
   preserved pages a pseudo physical mapping pagetable is populated
   with pages as they are preserved.

 * If a page to be preserved is found to be in range of memory that was
   previously reserved during early boot or in range of memory where the
   kernel will be loaded to on kexec, the page will be copied to a page
   outside of those ranges and the new page will be preserved. A compound
   page will be copied to and preserved as individual base pages.

 * A single page is allocated for the PKRAM super block. For the next kernel
   kexec boot to find preserved memory metadata, the pfn of the PKRAM super
   block, which is exported via /sys/kernel/pkram, is passed in the 'pkram'
   boot option.

 * In the newly booted kernel, PKRAM adds all preserved pages to the memblock
   reserve list during early boot so that they will not be recycled.

 * Since kexec may load the new kernel code to any memory region, it could
   destroy preserved memory. When the kernel selects the memory region
   (kexec_file_load syscall), kexec will avoid preserved pages.  When the
   user selects the kexec memory region to use (kexec_load syscall) , kexec
   load will fail if there is conflict with preserved pages. Pages preserved
   after a kexec kernel is loaded will be relocated if they conflict with
   the selected memory region.

The current implementation has some restrictions:

 * Only regular tmpfs files without multiple hard links can be preserved.
   Save to PKRAM will abort and log an error if a directory or other file
   type is encountered.

 * Pages for PKRAM-enabled files are prevented from swapping out to avoid
   the performance penalty of swapping in and the possibility of insufficient
   memory.


-- Patches --

The patches are broken down into the following groups:

Patches 1-22 implement the API and supporting functionality.

Patches 23-27 implement the use of PKRAM within tmpfs

The remaining patches implement optimizations to the initialization of
preserved pages and to the preservation and restoration of shmem pages.

To give an idea of the improvement in performance here is an example
comparison with and without these patches when saving and loading a 100G
file:

  Save a 100G file:

              | No optimizations | Optimized (16 cpus) |
  ------------------------------------------------------
  huge=never  |     2265ms       |       232ms         |
  ------------------------------------------------------
  huge=always |       58ms       |        22ms         |


  Load a 100G file:

              | No optimizations | Optimized (16 cpus) |
  ------------------------------------------------------
  huge=never  |     8833ms       |       516ms         |
  ------------------------------------------------------
  huge=always |      752ms       |       105ms         |


Patches 28-31 Defer initialization of page structs for preserved pages

Patches 32-34 Implement multi-threading of shmem page preservation and
restoration.

Patches 35-37 Implement and use an  API for inserting shmem pages in bulk

Patches 38-39: Reduce contention on the LRU lock by staging and adding pages
in bulk to the LRU

Patches 40-43: Reduce contention on the pagecache xarray lock by inserting
pages in bulk in certain cases

[1] https://lkml.org/lkml/2013/7/1/211

[2] https://www.youtube.com/watch?v=pBsHnf93tcQ
    https://static.sched.com/hosted_files/kvmforum2019/66/VMM-fast-restart_kvmforum2019.pdf

[3] https://www.youtube.com/watch?v=pBsHnf93tcQ
https://static.sched.com/hosted_files/kvmforum2020/10/Device-Keepalive-State-KVMForum2020.pdf

Anthony Yznaga (43):
  mm: add PKRAM API stubs and Kconfig
  mm: PKRAM: implement node load and save functions
  mm: PKRAM: implement object load and save functions
  mm: PKRAM: implement page stream operations
  mm: PKRAM: support preserving transparent hugepages
  mm: PKRAM: implement byte stream operations
  mm: PKRAM: link nodes by pfn before reboot
  mm: PKRAM: introduce super block
  PKRAM: track preserved pages in a physical mapping pagetable
  PKRAM: pass a list of preserved ranges to the next kernel
  PKRAM: prepare for adding preserved ranges to memblock reserved
  mm: PKRAM: reserve preserved memory at boot
  PKRAM: free the preserved ranges list
  PKRAM: prevent inadvertent use of a stale superblock
  PKRAM: provide a way to ban pages from use by PKRAM
  kexec: PKRAM: prevent kexec clobbering preserved pages in some cases
  PKRAM: provide a way to check if a memory range has preserved pages
  kexec: PKRAM: avoid clobbering already preserved pages
  mm: PKRAM: allow preserved memory to be freed from userspace
  PKRAM: disable feature when running the kdump kernel
  x86/KASLR: PKRAM: support physical kaslr
  x86/boot/compressed/64: use 1GB pages for mappings
  mm: shmem: introduce shmem_insert_page
  mm: shmem: enable saving to PKRAM
  mm: shmem: prevent swapping of PKRAM-enabled tmpfs pages
  mm: shmem: specify the mm to use when inserting pages
  mm: shmem: when inserting, handle pages already charged to a memcg
  x86/mm/numa: add numa_isolate_memblocks()
  PKRAM: ensure memblocks with preserved pages init'd for numa
  memblock: PKRAM: mark memblocks that contain preserved pages
  memblock, mm: defer initialization of preserved pages
  shmem: preserve shmem files a chunk at a time
  PKRAM: atomically add and remove link pages
  shmem: PKRAM: multithread preserving and restoring shmem pages
  shmem: introduce shmem_insert_pages()
  PKRAM: add support for loading pages in bulk
  shmem: PKRAM: enable bulk loading of preserved pages into shmem
  mm: implement splicing a list of pages to the LRU
  shmem: optimize adding pages to the LRU in shmem_insert_pages()
  shmem: initial support for adding multiple pages to pagecache
  XArray: add xas_export_node() and xas_import_node()
  shmem: reduce time holding xa_lock when inserting pages
  PKRAM: improve index alignment of pkram_link entries

 documentation/core-api/xarray.rst       |    8 +
 arch/x86/boot/compressed/Makefile       |    3 +
 arch/x86/boot/compressed/ident_map_64.c |    9 +-
 arch/x86/boot/compressed/kaslr.c        |   10 +-
 arch/x86/boot/compressed/misc.h         |   10 +
 arch/x86/boot/compressed/pkram.c        |  109 ++
 arch/x86/include/asm/numa.h             |    4 +
 arch/x86/kernel/setup.c                 |    3 +
 arch/x86/mm/init_64.c                   |    2 +
 arch/x86/mm/numa.c                      |   32 +-
 include/linux/memblock.h                |    6 +
 include/linux/mm.h                      |    2 +-
 include/linux/pkram.h                   |  120 ++
 include/linux/shmem_fs.h                |   28 +
 include/linux/swap.h                    |   13 +
 include/linux/xarray.h                  |    2 +
 kernel/kexec.c                          |    9 +
 kernel/kexec_core.c                     |    3 +
 kernel/kexec_file.c                     |   15 +
 lib/test_xarray.c                       |   45 +
 lib/xarray.c                            |  100 ++
 mm/Kconfig                              |    9 +
 mm/Makefile                             |    1 +
 mm/memblock.c                           |   11 +-
 mm/page_alloc.c                         |   55 +-
 mm/pkram.c                              | 1808 +++++++++++++++++++++++++++++++
 mm/pkram_pagetable.c                    |  376 +++++++
 mm/shmem.c                              |  494 ++++++++-
 mm/shmem_pkram.c                        |  530 +++++++++
 mm/swap.c                               |   86 ++
 30 files changed, 3869 insertions(+), 34 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c
 create mode 100644 include/linux/pkram.h
 create mode 100644 mm/pkram.c
 create mode 100644 mm/pkram_pagetable.c
 create mode 100644 mm/shmem_pkram.c

-- 
1.8.3.1

