Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9597834F314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhC3V1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60806 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhC3V0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP80x122942;
        Tue, 30 Mar 2021 21:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=4xJD9dBWZTGkr9GFOZ1rhfq9w/F6myJVw9nCCu4BHdo=;
 b=x7KT/KmElZkSmMt9Xh83PLS/vlYmvyJlzUDJhbSnwusBME1b+vCuN1zs5zhT89TChMhQ
 GoCZmkT6MugnpZoT7iv3Fz6ZfjESgPZ+y4m+qdiRhuxTyHWp/drDNEeplh7BtMicH/aC
 GgQxH0+v4JnrjbX/GGN1874+n6Pkj9FhtniNH0wX9AYnF7SexCWDvGcq2D8Rb78t95gx
 ZKN0Me5Cl3Me6SdAhfvIYiGs+tj9Ik1pZFFUWHpabasP81r8n9krOs0ULdYoqZSfyf6s
 DzMKmb00DRG0B0gLICluF8WLE71ppStKR23HYJHt6JG8sfytaJjpmjYM8bE8dGQdEQuv 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37mafv0810-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULBSwq065456;
        Tue, 30 Mar 2021 21:25:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 37mabkbbjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OirDWEi8VWEriZN1uRvAU5pUl9YmPntfh+HWYrn11SOLG9J+/iemp3SfHeQruR+5TA/QpOAACAk4ze0lhmcP1EyL/XAU0udfak4KSEwrFBiUtIeVd/lrEUBB3+AUaeyGodXo4tuimwa/D1cgncP4eQkkn5bkvK4bw8Q/6ZEuElGrCITSK+IrLjDOrcC713M+aiNomMXDpgpJRieD6C4EP5Dt6lZjOgNBlSyoMUZpIQsWazprkPRA6WhYieJZ0RUZLPWwxJfYvE3neETvNQSacg9NQMlsEcSBoEAd/szqgsaOOYUcwNOv0n9SFWBYuUXbWlxdWVm2dwEr4/u3xTm20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xJD9dBWZTGkr9GFOZ1rhfq9w/F6myJVw9nCCu4BHdo=;
 b=GOdeUdMSyII7Cs2i6hNPekPCSatdI4eyIlLol9qhy9t8NMHiRtkxUdHBc5yWGF3AEkxRiwDlHBBS58i0uRJoH6mwURIuWQQEgH361fraSV5SimFSCvo96RiMeMTMFbO3EZ5l5JTa0b0Umw+F4ucWQs9Qn6Ce88aCdlhP7qSV+qgpEnRO9jCpMMflZpADXrTt0xOIMrOiiOl+l8U6bnsW8gAxlx+ecpRAnGhm1HYWNMOEbczDCQ4RuPd3ELGZ+28QBv9PsL7GRPPH8I/HJSbryClYIdIvjw2PNouYSIWqVuFuojAkZnHDZduHA4QbGjK41HqptdshbwDgLs+Dt/dL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xJD9dBWZTGkr9GFOZ1rhfq9w/F6myJVw9nCCu4BHdo=;
 b=x+XDOGbxB0HtZf/T5MHs3eOKq7k85WdF3zJic7LYO2Riwe1Q4+ApIXW27DZekYSjmra5x8mqhaLGogSGxRlLVpC1eTqWfK90Nvmp4hPFt6jugd6HNnGnAxy9u+eTknDd9pKXVir9/ghnUS/uraLz+T5/tWjqu1DAngj3JveEVBs=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:04 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:04 +0000
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
Subject: [RFC v2 01/43] mm: add PKRAM API stubs and Kconfig
Date:   Tue, 30 Mar 2021 14:35:36 -0700
Message-Id: <1617140178-8773-2-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 479d6f06-0fa4-420d-5ef3-08d8f3c2489c
X-MS-TrafficTypeDiagnostic: MN2PR10MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB312034AAB028122ECE26ABE9EC7D9@MN2PR10MB3120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmNxxGMDVb833n+1r8H87LN53U9hnUk0AiVCYHK0V4+ueKvUaP+GxT7gUuBMkZ5w4PGbrx1B0vBNiPdc4fOoNFCnfyLPvw8ipMxHiZCupTmh5ku3D/P4NJXMH7PPxZzTbWk3yTqPB/KmvCN5zTLOItfXlpMaGr/JKbff2E0hyi+IalLO3ThAebMdUjVBT8X6OM8A8QU/nCNa8OZr9WB17IGP19fDLdd/M5ygiQ6r4WseaC0lbUiEEXyUsQz8sjhZk7GTVnw90TKwzFkLoINjNo//IHt4wFJ+vZcCc6ypVUPrQBpzV7SvDuQnWH3TzNuvIKtATBJUHDV40aCYxONtRTQYPLX3iqh4bf14FPYrxla31abMCR5f+twZayRN0DJCLxN58tzZyqCN7jkX9uUtNbKjlJxWhmqIOxSd05DQ0P5d+3bZMlvbsGnZjrW09sh2uXKxspWchYv9U5g9MG+8Wn8OmPmZAbt+pybRT5eqezB+4ELSuY/7SGEJSxgr8agNwknZ9FRKT99ULGdKEPA5VNCrQQCwdugdUjqrbtsF/x7KnOhztsSU4Zg17WVDhC8/MXTQFU7VaXSq24yt/HpQYN1Qackgp5G5kXzda4GflX8ltLwwf6X3BBxrkJl9SdAeqqPOOHvKiO23UYN6gIFAnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(52116002)(316002)(186003)(6486002)(16526019)(5660300002)(2616005)(956004)(6666004)(8676002)(66556008)(44832011)(478600001)(83380400001)(7406005)(38100700001)(86362001)(7696005)(30864003)(66476007)(66946007)(4326008)(2906002)(26005)(7416002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hEr9bVWsUdduhJN90F2Mc8Drii01BtIjPCeeCwddo/OmDIostBeWaTGKOqZk?=
 =?us-ascii?Q?Y+YeD66C5rjwh7hm5g8g+n+OWlJwBQ7S3EoUGoqSZjg4QOmv/nWptqqI6C7F?=
 =?us-ascii?Q?/U0oeKHPmMXu0tN2jzTaor4liAk40bH4S+XR0VRKQuyje2ulOJdnBNdUMCTe?=
 =?us-ascii?Q?lwXERNm/0kZ8feBZoQBeYkzOAtb2bHKqEWBpow9+kEbRFOflc6notPAB5YTf?=
 =?us-ascii?Q?tEQPAx0D4j8aDr+ZjPt9hHhZKKBx9HrnbdSt/Cia7i+1RzBa4ykFpvrviwGO?=
 =?us-ascii?Q?0+ptl21eEt1oQoGuCp8L9vDE8bNPQ0yaY6sqVD7A7rXbpOVeq0hnnEEhuyIX?=
 =?us-ascii?Q?lnW8O6AqGATHz7xSzHFCGybMTbTyhCflvSlwPBbPscCTZzar6M4+zlYzedvz?=
 =?us-ascii?Q?qreMB+4ZghRoDoPDLdSeyFbPktN9CwWjO/5M+r5VdA/S4ZxGxd9fWgnfngbO?=
 =?us-ascii?Q?XTIlFkouhVsuttc2+1Ex33zwgucucuagBgElBCwknk8fFWzzzGteOuHfuGL5?=
 =?us-ascii?Q?XLFc/r9YWDwBB0pwppCnYz5KlDA6Sh4nmHOanDyf9JuZBsrnOt8/QznzmBTJ?=
 =?us-ascii?Q?ir0S9yGUgspRmP6aw8TEuvFY+9i+sDxxuXA7Pdhf2XrqqxnXca7/Hl24vu9L?=
 =?us-ascii?Q?wockp/jw0aNla7s59FmoPzYTQLUJ+JQpvSQvzXOW6zrzKb/N9Tv/XXNiMUPT?=
 =?us-ascii?Q?RTlpYYWXjFqDV4ZNe9t85q9sdR4XC16eVhkHIGodEIp0Brjl5wg6DfeoDDUi?=
 =?us-ascii?Q?O4ESgVleDlGZJG/OvOPaVhFPuNDkQSi4497SuIvHjf1t45Cs3NVJlaGcsDH1?=
 =?us-ascii?Q?zXA/L4odfKwB4wwRj41mQdxjdjkr9XfcMeufc8jUWxklhw/rwmhrKD/plPWC?=
 =?us-ascii?Q?VZIMMQSzteoxVJTbNS2tecNJ38EErOlCO10g7b2beN1igjVjkrveZI9ZcyuU?=
 =?us-ascii?Q?2CbHDjvNt5fv6fRfvyOA4KhCXpUGuHxKCYiV8510vEEgPCowAyAPvOsVlZ1J?=
 =?us-ascii?Q?2fAmM9apTrp8yL3lSmLVRAANbHs6mDBdYUNzGJ+uYgfxS6ihrcnsO4lXXguW?=
 =?us-ascii?Q?LEqzEkX9L1keGUqSS3BFB52VgsmOcvqyOc81ndChdKYnFrh04QBjg6U6aRJp?=
 =?us-ascii?Q?EGS9nIhCCCO3Qg3hVJTcr2yGNtPkcTIqcptIvizD85u4ujK4umxMcAnoHszP?=
 =?us-ascii?Q?CHDqhBSBgJMKRxn9zovjMCxjfCep9eqlkDLQNyZ/zQnkVgRhX4cI2cyYvx15?=
 =?us-ascii?Q?teBPPfG+Uq24T0Z2GktejLZXmuzeFNivYRzdMnXN1TSnJHk5+6Z/Ta5W6KMv?=
 =?us-ascii?Q?xLw3PQwUN+oren8P0t3buVMJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d6f06-0fa4-420d-5ef3-08d8f3c2489c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:04.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YW8slpzheQ8YtgY7O3M1ilN1VBn+qiqMgafAZg/wgBjb5EL0V+c3MEhhiOYYzNorPvk0dvG56D17Y01eesv6Nm4RwT3an19ieV7xxpwhUD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300155
X-Proofpoint-ORIG-GUID: Iaf0wUPbZLWZXVChLsPXaYEnFKXLlCmc
X-Proofpoint-GUID: Iaf0wUPbZLWZXVChLsPXaYEnFKXLlCmc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preserved-across-kexec memory or PKRAM is a method for saving memory
pages of the currently executing kernel and restoring them after kexec
boot into a new one. This can be utilized for preserving guest VM state,
large in-memory databases, process memory, etc. across reboot. While
DRAM-as-PMEM or actual persistent memory could be used to accomplish
these things, PKRAM provides the latency of DRAM with the flexibility
of dynamically determining the amount of memory to preserve.

The proposed API:

 * Preserved memory is divided into nodes which can be saved or loaded
   independently of each other. The nodes are identified by unique name
   strings. A PKRAM node is created when save is initiated by calling
   pkram_prepare_save(). A PKRAM node is removed when load is initiated by
   calling pkram_prepare_load(). See below

 * A node is further divided into objects. An object represents closely
   coupled data in the form of a grouping of pages and/or a stream of
   byte data.  For example, the pages and attributes of a file.
   After initiating an operation on a PKRAM node, PKRAM objects are
   initialized for saving or loading by calling pkram_prepare_save_obj()
   or pkram_prepare_load_obj().

 * For saving/loading data from a PKRAM node/object instances of the
   pkram_stream and pkram_access structs are used.  pkram_stream tracks
   the node and object being operated on while pkram_access tracks the
   data type and position within an object.

   The pkram_stream struct is initialized by calling pkram_prepare_save()
   or pkram_prepare_load() and then pkram_prepare_save_obj() or
   pkram_prepare_load_obj().

   Once a pkram_stream is fully initialized, a pkram_access struct
   is initialized for each data type associated with the object.
   After save or load of a data type for the object is complete,
   pkram_finish_access() is called.

   After save or load is complete for the object, pkram_finish_save_obj()
   or pkram_finish_load_obj() must be called followed by pkram_finish_save()
   or pkram_finish_load() when save or load is completed for the node.
   If an error occurred during save, the saved data and the PKRAM node
   may be freed by calling pkram_discard_save() instead of
   pkram_finish_save().

 * Both page data and byte data can separately be streamed to a PKRAM
   object.  pkram_save_file_page() and pkram_load_file_page() are used
   to stream page data while pkram_write() and pkram_read() are used to
   stream byte data.

A sequence of operations for saving/loading data from PKRAM would
look like:

  * For saving data to PKRAM:

    /* create a PKRAM node and do initial stream setup */
    pkram_prepare_save()

    /* create a PKRAM object associated with the PKRAM node and complete stream initialization */
    pkram_prepare_save_obj()

    /* save data to the node/object */
    PKRAM_ACCESS(pa_pages,...)
    PKRAM_ACCESS(pa_bytes,...)
    pkram_save_file_page(pa_pages,...)[,...]  /* for file pages */
    pkram_write(pa_bytes,...)[,...]           /* for a byte stream */
    pkram_finish_access(pa_pages)
    pkram_finish_access(pa_bytes)

    pkram_finish_save_obj()

    /* commit the save or discard and delete the node */
    pkram_finish_save()          /* on success, or
    pkram_discard_save()          * ... in case of error */

  * For loading data from PKRAM:

    /* remove a PKRAM node from the list and do initial stream setup */
    pkram_prepare_load()

    /* Remove a PKRAM object from the node and complete stream initializtion for loading data from it. */
    pkram_prepare_load_obj()

    /* load data from the node/object */
    PKRAM_ACCESS(pa_pages,...)
    PKRAM_ACCESS(pa_bytes,...)
    pkram_load_file_page(pa_pages,...)[,...] /* for file pages */
    pkram_read(pa_bytes,...)[,...]           /* for a byte stream */
*/
    pkram_finish_access(pa_pages)
    pkram_finish_access(pa_bytes)

    /* free the object */
    pkram_finish_load_obj()

    /* free the node */
    pkram_finish_load()

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  47 +++++++++++++
 mm/Kconfig            |   9 +++
 mm/Makefile           |   1 +
 mm/pkram.c            | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 include/linux/pkram.h
 create mode 100644 mm/pkram.c

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
new file mode 100644
index 000000000000..a575da2d6c79
--- /dev/null
+++ b/include/linux/pkram.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PKRAM_H
+#define _LINUX_PKRAM_H
+
+#include <linux/gfp.h>
+#include <linux/types.h>
+#include <linux/mm_types.h>
+
+/**
+ * enum pkram_data_flags - definition of data types contained in a pkram obj
+ * @PKRAM_DATA_none: No data types configured
+ */
+enum pkram_data_flags {
+	PKRAM_DATA_none		= 0x0,  /* No data types configured */
+};
+
+struct pkram_stream;
+struct pkram_access;
+
+#define PKRAM_NAME_MAX		256	/* including nul */
+
+int pkram_prepare_save(struct pkram_stream *ps, const char *name,
+		       gfp_t gfp_mask);
+int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags);
+
+void pkram_finish_save(struct pkram_stream *ps);
+void pkram_finish_save_obj(struct pkram_stream *ps);
+void pkram_discard_save(struct pkram_stream *ps);
+
+int pkram_prepare_load(struct pkram_stream *ps, const char *name);
+int pkram_prepare_load_obj(struct pkram_stream *ps);
+
+void pkram_finish_load(struct pkram_stream *ps);
+void pkram_finish_load_obj(struct pkram_stream *ps);
+
+#define PKRAM_ACCESS(name, stream, type)			\
+	struct pkram_access name
+
+void pkram_finish_access(struct pkram_access *pa, bool status_ok);
+
+int pkram_save_file_page(struct pkram_access *pa, struct page *page);
+struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index);
+
+ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
+size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
+
+#endif /* _LINUX_PKRAM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..ea8242c91728 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,13 @@ config MAPPING_DIRTY_HELPERS
 config KMAP_LOCAL
 	bool
 
+config PKRAM
+	bool "Preserved-over-kexec memory storage"
+	default n
+	help
+	  This option adds the kernel API that enables saving memory pages of
+	  the currently executing kernel and restoring them after a kexec in
+	  the newly booted one. This can be utilized for speeding up reboot by
+	  leaving process memory and/or FS caches in-place.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 72227b24a616..ab3a724769b5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_PKRAM) += pkram.o
diff --git a/mm/pkram.c b/mm/pkram.c
new file mode 100644
index 000000000000..59e4661b2fb7
--- /dev/null
+++ b/mm/pkram.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pkram.h>
+#include <linux/types.h>
+
+/**
+ * Create a preserved memory node with name @name and initialize stream @ps
+ * for saving data to it.
+ *
+ * @gfp_mask specifies the memory allocation mask to be used when saving data.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
+ * case of failure) is to be called.
+ */
+int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Create a preserved memory object and initialize stream @ps for saving data
+ * to it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
+ * in case of failure) is to be called.
+ */
+int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Commit the object started with pkram_prepare_save_obj() to preserved memory.
+ */
+void pkram_finish_save_obj(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Commit the save to preserved memory started with pkram_prepare_save().
+ * After the call, the stream may not be used any more.
+ */
+void pkram_finish_save(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Cancel the save to preserved memory started with pkram_prepare_save() and
+ * destroy the corresponding preserved memory node freeing any data already
+ * saved to it.
+ */
+void pkram_discard_save(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Remove the preserved memory node with name @name and initialize stream @ps
+ * for loading data from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the load has finished, pkram_finish_load() is to be called.
+ */
+int pkram_prepare_load(struct pkram_stream *ps, const char *name)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Remove the next preserved memory object from the stream @ps and
+ * initialize stream @ps for loading data from it.
+ *
+ * Returns 0 on success, -errno on failure.
+ *
+ * After the load has finished, pkram_finish_load_obj() is to be called.
+ */
+int pkram_prepare_load_obj(struct pkram_stream *ps)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Finish the load of a preserved memory object started with
+ * pkram_prepare_load_obj() freeing the object and any data that has not
+ * been loaded from it.
+ */
+void pkram_finish_load_obj(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Finish the load from preserved memory started with pkram_prepare_load()
+ * freeing the corresponding preserved memory node and any data that has
+ * not been loaded from it.
+ */
+void pkram_finish_load(struct pkram_stream *ps)
+{
+	BUG();
+}
+
+/**
+ * Finish the data access to or from the preserved memory node and object
+ * associated with pkram stream access @pa.  The access must have been
+ * initialized with PKRAM_ACCESS(). 
+ */
+void pkram_finish_access(struct pkram_access *pa, bool status_ok)
+{
+	BUG();
+}
+
+/**
+ * Save file page @page to the preserved memory node and object associated
+ * with pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_save() and pkram_prepare_save_obj() and access initialized
+ * with PKRAM_ACCESS().
+ *
+ * Returns 0 on success, -errno on failure.
+ */
+int pkram_save_file_page(struct pkram_access *pa, struct page *page)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Load the next page from the preserved memory node and object associated
+ * with pkram stream access @pa. The stream must have been initialized with
+ * pkram_prepare_load() and pkram_prepare_load_obj() and access initialized
+ * with PKRAM_ACCESS().
+ *
+ * If not NULL, @index is initialized with the preserved mapping offset of the
+ * page loaded.
+ *
+ * Returns the page loaded or NULL if the node is empty.
+ *
+ * The page loaded has its refcount incremented.
+ */
+struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
+{
+	return NULL;
+}
+
+/**
+ * Copy @count bytes from @buf to the preserved memory node and object
+ * associated with pkram stream access @pa. The stream must have been
+ * initialized with pkram_prepare_save() and pkram_prepare_save_obj()
+ * and access initialized with PKRAM_ACCESS();
+ *
+ * On success, returns the number of bytes written, which is always equal to
+ * @count. On failure, -errno is returned.
+ */
+ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count)
+{
+	return -ENOSYS;
+}
+
+/**
+ * Copy up to @count bytes from the preserved memory node and object
+ * associated with pkram stream access @pa to @buf. The stream must have been
+ * initialized with pkram_prepare_load() and pkram_prepare_load_obj() and
+ * access initialized PKRAM_ACCESS().
+ *
+ * Returns the number of bytes read, which may be less than @count if the node
+ * has fewer bytes available.
+ */
+size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
+{
+	return 0;
+}
-- 
1.8.3.1

