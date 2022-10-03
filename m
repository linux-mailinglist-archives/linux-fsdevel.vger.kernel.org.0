Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB405F38F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJCWX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJCWWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5877550B8;
        Mon,  3 Oct 2022 15:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tpc4xA8fN6UW293eHu+jViLcNIxCAC4gyh8/bnK/QlZ/vLcVVHgmgqzzo/3f+HO+aX2CO4qEn4y242+p56gOrCZy8ux9QLRZm0Q5nffo4V1r7pkB49/NyVkSHvvyyr38gxyZdfdvVOYpVgxh5pB+MvbGrqCpMwYW2F1HxAvgMQM3b5lbgNEdMOHibbqJ4sJnW+rezxsgnHzXh4TnLbdjO59GG1Z0JkYQZtZzPuwHvJkDwqKDKD7uhm8UgDBKGS2w7Dfuft91Hu6CyKeRkiDpq2HQtIw7kkDpcVg+oztA65MibqXEiH/PxcV1xy4BTaxLVTbzUKU/sLRzLO9MDu7u6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMQWJJqnY8f9a48zMpCnUDxBB+bfezktXkVD9Awamf8=;
 b=NNbZTylGENwN4dRkEGJWVyvp487gHzeezbn4qe0Pq5KEDIo1mKJ1dI9hXMiI0xXlPKgXNM+o78BTvE7Y9huQpxFK+MaCVNPZPBBB49DFunJpqeQX2HK9DBzyWxmlJEZ653EEtURsOeIYSRe6sCe0ZQAW6Ju3uHopEJa3fYPXWQgbAuON/2qXlUg+s2+4ew0MlQTqT9XBO/vyYhqYXjZV7megLQT3qIOOJkfhgkrGNjbDmtxR152pLcs5aoeDsIiienmVY4yDla9NdR2LWNLy4Dlyn9xODdFqWb5wEHVNeRJJkk87X/oB5gnKtgmO20fhEBmIziO60ws3Qo6yelfT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMQWJJqnY8f9a48zMpCnUDxBB+bfezktXkVD9Awamf8=;
 b=o7dJCv+37xHHnYPdmb6o9t+Ks5JgBdeT17RG3mc5rQpCNEyx0B9J4m3pj8KuEKP+29yMQXt8YrVu5rjH8aob6bUmo0H6lddi1Wo23W6nUrF5x0zTTYiBCeSgAAUL6Z7SNlRMJ6mrz6uGkOMH0s/AYvNgKmHoYuAKcR+B/mTK2UQ8WeWZAmavPOWhXay6Azt+UeyIAnFnKsDvkFxKGgZwvQn6iUSJmdFJo/pFmXrt7DntQpm8skzE+XmX94+IKeLkY/VOBo6Opnrlmxh3+EdScYA8ZjTaQ03BICuVy9kNWGHify9yBZuHNJjkh8jZdS4FadzHzmmDEMZL6osQgX2YVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by SJ0PR03MB6270.namprd03.prod.outlook.com (2603:10b6:a03:3ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 22:22:05 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:22:05 +0000
From:   Ali Raza <aliraza@bu.edu>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pbonzini@redhat.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu, Ali Raza <aliraza@bu.edu>
Subject: [RFC UKL 10/10] Kconfig: Add config option for enabling and sample for testing UKL
Date:   Mon,  3 Oct 2022 18:21:33 -0400
Message-Id: <20221003222133.20948-11-aliraza@bu.edu>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003222133.20948-1-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|SJ0PR03MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce1047e-2e19-48d8-727c-08daa58db387
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgS/z7lAWqtXzVwcKL5Cu0p6jakw/MVl3ikUvx+h8gKeIJAJolstNRxYgdcgFbp9hTCwKnN5MIM9m2lzj8YnHHHTywjH6FOq9ZkFrCiPwiEYwSb1TF1Hbaooe98hdBODZle23u73JPE3mGZoaceBAM+FHl8ZAOVVdld7eQFS6sH9x3b0CxpD9I7aAPfnPsIbjR/I8zn7cEXfOKF1uxdjgUPIRkA4vBEoGXX3ch2r8QGiFx+tTJWKT9GEWdRRTjzWxoliYwSbPclb6IIokARhgwG0+LOK6FDGImaD/xNHxqz//GI3Te6SfY9lKU+3446fYrEliQUY2HJZV+sosm7HClr4+2rX4uP2viw5VEWFCLhUO25KJtRF74WIDCqCGCnmeGmxzCWm+/wsXUX0qiS5nTpHu+XQgS8HwReM+ZAg2NovhpITQTB4sr1BCoqdzoHV2UGrAnu+iOIs2bLyiyYpgN9FEAMZsS+73pjqBzNBKcThC8/UqGnSKdODdK/B37mW3l/g7skkcoTzMx3tJbU4xPXRDoSNv9goe6/tkApleui1CarG3U/hpe0S07o8JsfvP6VHX+YeooKeMzl1wEyZvHBjHbDxeI95lyh0AUo1oIGVqutA9rPEEkP6sKtyPSAmLoeY+iRB2r5JkGkoA8YouPw3MPr6YSEzC5nXH6QLFEhBs0Cp7PPUhs4TiktbMw97dygFSBY1/R3n3vFczms0DowwzQCdcwZumvYpqQPEdgRal55yjSTU0IqEEdDsDMVwxH4hu1b+sWr0CqmpcueC+0piO8gwSekvRsQft0BbqfdHzLNQrq9/58Am7d24zFt0+SUD0ckHfmDADDc+cto2Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(52116002)(186003)(41320700001)(38100700002)(38350700002)(8676002)(4326008)(66476007)(66556008)(316002)(786003)(6916009)(2906002)(7406005)(41300700001)(8936002)(30864003)(5660300002)(7416002)(2616005)(1076003)(966005)(6486002)(478600001)(26005)(6512007)(6666004)(83380400001)(6506007)(66946007)(86362001)(36756003)(75432002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TisrZWhhejFiOG1HWUc5eWFTV09oOWdodHBpczhTdnVJQkpVeUlCdDNvTUNs?=
 =?utf-8?B?eWY1b1hKZlBiUWZLdmRRRDNyelVHZDA3aUlCdy9xTzBubGpZc0ZrUTAvQkhD?=
 =?utf-8?B?MVQzWmlwUWJ6dHo0L0RRVm5xSVhoOFhNUTBXQzI5VUxneWI1dURma0NKeWFn?=
 =?utf-8?B?MStRc1ZBUEFKY01RNVpPWWE2akV4dUNQSktlNVV2OG1RVG90eExYZVBFeWt0?=
 =?utf-8?B?aHZRdGRlUys2cmVyWGUxUXE4cnc4dk4yN25HMCtiNXhPaDNsSnNnWnVTTk1T?=
 =?utf-8?B?U0l2ZFBwY0ZQdWl3QkN2N2RPcERkcFRGK2htNy9LRnU0TTVaMFh1bmR5ek5Z?=
 =?utf-8?B?Nm5GQmZpVjlsdGNNM3ZCVXZXQ2ZyeSt3OXdTQytESVphakZleWplb2FnNXF6?=
 =?utf-8?B?WmtrZHJuRGRQSER1Q3B0ZUxSbGxaZExmTnlWTTg1UmswRGFvVGRydEc2TTVE?=
 =?utf-8?B?U2g2MjFmMG1SeWRPemR6Z1NqVERkVXlhMXBoOVpvQytYRkluOWFMdDNTK2g2?=
 =?utf-8?B?UFU3Zm05THRaR21tV3B4d1U0UHZ1Tk1KU3pVL1J5NkRKVEZ4dGJkN2NBalhH?=
 =?utf-8?B?Tmc2TjdqRXBVUCs1SWtuR2NZYmpselVWOStqZjA0OW9QZG41OFZjMFFMckp3?=
 =?utf-8?B?Ri9HaDEzWitPenVYQ1BvTkc0bEhPRVgwd0ZmYzVBaEpzaE8rV3BSSW12dHdG?=
 =?utf-8?B?b1lxWDFQNm1RK043bEQvclVaKzhyNmplS2FaL0l1ZnNBVXdIcDFacitrUFVQ?=
 =?utf-8?B?blFibGVRK0NNQkRUeUNXVnJTUUdCR3RranBRU0lvNmpBTFJyZWs0UWhKZVJh?=
 =?utf-8?B?eW54OUxpcTkrbXZxWi9LYU5memR6VXp1QW53ekFMVVpJRHJkL1YydEd4emor?=
 =?utf-8?B?WUVhMVR1a01MYzgyR09UWGhlVXJ1RkdkQ2lPUExzU1Z6TERvdEVVd3NoVzhr?=
 =?utf-8?B?b3VKc3BOTTRja0xjbzdjdXdJUUxTY2RzUG45ZE5KUTNRWFB2RmpPTVZKdy85?=
 =?utf-8?B?ZnJ5Y2hIMXJJNXFzbVRNSE9vb0NieVpUVDBjVUhObkVJRmZSZ0JBZlNoTk9F?=
 =?utf-8?B?NDgzQWc4dlZUUnIwbGdsbC83ejg3b0tLckJYbzZjTlcwUDFUVC9FUExrL0Jw?=
 =?utf-8?B?YktTTGNWcWRnK21GZ3Y1QXpwTjhhdXdSOHhpMWVIcDVtR21PZ0ptd1o5Ykx3?=
 =?utf-8?B?ZGFGSDdFOG83bEJhaXUrdWFob2VlODFnWE50N2FJemh2QWVkNDYyNW5zRVZD?=
 =?utf-8?B?ZHB4c0V6QWJtSUlMZGVLOE5tMXNJL3RSR3plWlRVamFOelVlQmFEaGV5eFJs?=
 =?utf-8?B?d2hkMzFMTVRFckEwZFdpQ1p0cFRZcHNveXpuYjA3OWhsSEFaVzNPdzFGZ3Bx?=
 =?utf-8?B?VS9YR3lzWnRETTIxSkt4bitvMTEvRGZNT2VxcCttWEl5OFhnZDU0cHJZc1Ni?=
 =?utf-8?B?M0xEYlppd3I1U2llMWs5amlQaEphcVJHZmdNOTZXTHNuMUtaWkszYjBqdTRZ?=
 =?utf-8?B?UVJWdVVFNWNxZzdOSXcxSFlTL2RTMU4wQjZDQ2wyL3dUd2hTNERBUmVUY3dv?=
 =?utf-8?B?YXZJeStSV2lnTXNFZ0EzRWJ3UG50WHIxM3Z6N08yYUpiQ0xPRFlBOWdFakdP?=
 =?utf-8?B?TDZyVjAwSjhVbElTTURiZ21VL0gyLy8yRGFXbjlPR1B6b1NhNGhvMEttUFdk?=
 =?utf-8?B?aU15M21aQURDaFBFelpEd1VqWUFnUk9kVVM4Ly9tVlRZUkVBQSs0Y2d3aE11?=
 =?utf-8?B?WGhXY0ZlOW5KREJLaWNYT0xSV2lwZGx6cjZ0RENULzVhWUtPUmFHSmErMmhW?=
 =?utf-8?B?N2QwaDlIUktFRFdLQ1NBOXlYWDVxN0JPakp2QXJ2SUxocXVrTXRvK040aTUz?=
 =?utf-8?B?TWVrWUhUWElLRDZRTE5QTnlrMlpVdzFtY3JqUEZ6QTJSMytvM1VzalFZUVd5?=
 =?utf-8?B?djhScyt6S3pEcXBIdi8xQUxHM2d5Qjg1Y2dDYW1uZzVjYk45RkNoNnNhSkgz?=
 =?utf-8?B?U2hIbFRPcVIzOElYUXFLTFNVbS9YZXEyTEwxT0N4NjhXSGoxWnZER0VPdEVv?=
 =?utf-8?B?R0QxTWJjUE11cHB6Wm9VczlRVXFVc1RyY1pxWDkzQk9WTFpYSzZRZU0wVUwr?=
 =?utf-8?Q?W3yv1DhBYWspmvD4UBctwGpMc?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce1047e-2e19-48d8-727c-08daa58db387
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:22:04.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xeZ+m5rEp93nnu8wrG0q4p2nNogGkVYlwxGEgHrCJbHa4N3kBf2+r+U/DBKgMDo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the KConfig file that will enable building UKL. Documentation
introduces the technical details for how UKL works and the motivations
behind why it is useful. Sample provides a simple program that still uses
the standard system call interface, but does not require a modified C
library.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>

Co-developed-by: Eric B Munson <munsoner@bu.edu>
Signed-off-by: Eric B Munson <munsoner@bu.edu>
Co-developed-by: Ali Raza <aliraza@bu.edu>
Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 Documentation/index.rst   |   1 +
 Documentation/ukl/ukl.rst | 104 ++++++++++++++++++++++++++++++++++++++
 Kconfig                   |   2 +
 kernel/Kconfig.ukl        |  41 +++++++++++++++
 samples/ukl/Makefile      |  16 ++++++
 samples/ukl/README        |  17 +++++++
 samples/ukl/syscall.S     |  28 ++++++++++
 samples/ukl/tcp_server.c  |  99 ++++++++++++++++++++++++++++++++++++
 8 files changed, 308 insertions(+)
 create mode 100644 Documentation/ukl/ukl.rst
 create mode 100644 kernel/Kconfig.ukl
 create mode 100644 samples/ukl/Makefile
 create mode 100644 samples/ukl/README
 create mode 100644 samples/ukl/syscall.S
 create mode 100644 samples/ukl/tcp_server.c

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 4737c18c97ff..42f8cb7d4cae 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -167,6 +167,7 @@ to ReStructured Text format, or are simply too old.
 
    tools/index
    staging/index
+   ukl/ukl.rst
 
 
 Translations
diff --git a/Documentation/ukl/ukl.rst b/Documentation/ukl/ukl.rst
new file mode 100644
index 000000000000..a07ebb51169e
--- /dev/null
+++ b/Documentation/ukl/ukl.rst
@@ -0,0 +1,104 @@
+﻿SPDX-License-Identifier: GPL-2.0
+
+Unikernel Linux (UKL)
+=====================
+
+Unikernel Linux (UKL) is a research project aimed at integrating
+application specific optimizations to the Linux kernel. This RFC aims to
+introduce this research to the community. Any feedback regarding the idea,
+goals, implementation and research is highly appreciated.
+
+Unikernels are specialized operating systems where an application is linked
+directly with the kernel and runs in supervisor mode. This allows the
+developers to implement application specific optimizations to the kernel,
+which can be directly invoked by the application (without going through the
+syscall path). An application can control scheduling and resource
+management and directly access the hardware. Application and the kernel can
+be co-optimized, e.g., through LTO, PGO, etc. All of these optimizations,
+and others, provide applications with huge performance benefits over
+general purpose operating systems.
+
+Linux is the de-facto operating system of today. Applications depend on its
+battle tested code base, large developer community, support for legacy
+code, a huge ecosystem of tools and utilities, and a wide range of
+compatible hardware and device drivers. Linux also allows some degree of
+application specific optimizations through build time config options,
+runtime configuration, and recently through eBPF. But still, there is a
+need for even more fine-grained application specific optimizations, and
+some developers resort to kernel bypass techniques.
+
+Unikernel Linux (UKL) aims to get the best of both worlds by bringing
+application specific optimizations to the Linux ecosystem. This way,
+unmodified applications can keep getting the benefits of Linux while taking
+advantage of the unikernel-style optimizations. Optionally, applications
+can be modified to invoke deeper optimizations.
+
+There are two steps to unikernel-izing Linux, i.e., first, equip Linux with
+a unikernel model, and second, actually use that model to implement
+application specific optimizations. This patch focuses on the first part.
+Through this patch, unmodified applications can be built as Linux
+unikernels, albeit with only modest performance advantages. Like
+unikernels, UKL would allow an application to be statically linked into the
+kernel and executed in supervisor mode. However, UKL preserves most of the
+invariants and design of Linux, including a separate page-able application
+portion of the address space and a pinned kernel portion, the ability to
+run multiple processes, and distinct execution modes for application and
+kernel code. Kernel execution mode and application execution mode are
+different, e.g., the application execution mode allows application threads
+to be scheduled, handle signals, etc., which do not apply to kernel
+threads. Application built as a Linux unikernel will have its text and data
+loaded with the kernel at boot time, while the rest of the address space
+would remain unchanged. These applications invoke the system call
+functionality through a function call into the kernel system call entry
+point instead of through the syscall assembly instruction. UKL would
+support a normal userspace so the UKL application can be started, managed,
+profiled, etc., using normal command line utilities.
+
+Once Linux has a unikernel model, different application specific
+optimizations are possible. We have tried a few, e.g., fast system call
+transitions, shared stacks to allow LTO, invoking kernel functions
+directly, etc. We have seen huge performance benefits, details of which are
+not relevant to this patch and can be found in our paper.
+(https://arxiv.org/pdf/2206.00789.pdf)
+
+UKL differs significantly from previous projects, e.g., UML, KML and LKL.
+User Mode Linux (UML) is a virtual machine monitor implemented on syscall
+interface, a very different goal from UKL. Kernel Mode Linux (KML) allows
+applications to run in kernel mode and replaces syscalls with function
+calls. While KML stops there, UKL goes further. UKL links applications and
+kernel together which allows further optimizations e.g., fast system call
+transitions, shared stacks to allow LTO, invoking kernel functions directly
+etc. Details can be found in the paper linked above. Linux Kernel Library
+(LKL) harvests arch independent code from Linux, takes it to userspace as a
+library to be linked with applications. A host needs to provide arch
+dependent functionality. This model is very different from UKL. A detailed
+discussion of related work is present in the paper linked above.
+
+See samples/ukl for a simple TCP echo server example which can be built as
+a normal user space application and also as a UKL application. In the Linux
+config options, a path to the compiled and partially linked application
+binary can be specified. Kernel built with UKL enabled will search this
+location for the binary and link with the kernel. Applications and required
+libraries need to be compiled with -mno-red-zone -mcmodel=kernel flags
+because kernel mode execution can trample on application red zones and in
+order to link with the kernel and be loaded in the high end of the address
+space, application should have the correct memory model. Examples of other
+applications like Redis, Memcached etc along with glibc and libgcc etc.,
+can be found at https://github.com/unikernelLinux/ukl
+
+List of authors and contributors:
+=================================
+
+Ali Raza - aliraza@bu.edu
+Thomas Unger - tommyu@bu.edu
+Matthew Boyd - mboydmcse@gmail.com
+Eric Munson - munsoner@bu.edu
+Parul Sohal - psohal@bu.edu
+Ulrich Drepper - drepper@redhat.com
+Richard Jones - rjones@redhat.com
+Daniel Bristot de Oliveira - bristot@kernel.org
+Larry Woodman - lwoodman@redhat.com
+Renato Mancuso - rmancuso@bu.edu
+Jonathan Appavoo - jappavoo@bu.edu
+Orran Krieger - okrieg@bu.edu
+
diff --git a/Kconfig b/Kconfig
index 745bc773f567..2a4594ae472c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -29,4 +29,6 @@ source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
 
+source "kernel/Kconfig.ukl"
+
 source "Documentation/Kconfig"
diff --git a/kernel/Kconfig.ukl b/kernel/Kconfig.ukl
new file mode 100644
index 000000000000..c2c5e1003605
--- /dev/null
+++ b/kernel/Kconfig.ukl
@@ -0,0 +1,41 @@
+menuconfig UNIKERNEL_LINUX
+	bool "Unikernel Linux"
+	depends on X86_64 && !RANDOMIZE_BASE && !PAGE_TABLE_ISOLATION
+	help
+	    Unikernel Linux allows for a single, privileged process to be
+	    linked with the kernel binary and be executed inplace of or
+	    along side a more traditional user space.
+
+	    If you don't know what this is, say N.
+
+config UKL_TLS
+	bool "Enable TLS for UKL application"
+	depends on UNIKERNEL_LINUX
+	default Y
+	help
+	    Not all applications will make use of thread local storage,
+	    but we need to account for it in the linker script if used.
+	    For the application in samples/ this should be disabled, but
+	    if you are working with glibc this should be 'Y'.
+
+	    If unsure say 'Y' here
+
+config UKL_NAME
+	string "UKL Exec target"
+	depends on UNIKERNEL_LINUX
+	default "/UKL"
+	help
+	    We need a way to trigger the start of the UKL application,
+	    either by the kernel inplace of init or userspace when setup
+	    is finished. The value given here is compared against the
+	    filename passed to exec and if they match UKL is started.
+	    For a more 'traditional' unikernel model, the value set here
+	    should be given to the init= boot parameter.
+
+config UKL_ARCHIVE_PATH
+	string "Path static application archive"
+	depends on UNIKERNEL_LINUX
+	default "../UKL.a"
+	help
+	    Where the linker should look for the statically linked application
+	    and dependency archive.
diff --git a/samples/ukl/Makefile b/samples/ukl/Makefile
new file mode 100644
index 000000000000..93beb7750d4b
--- /dev/null
+++ b/samples/ukl/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I usr/include -fno-PIC -mno-red-zone -mcmodel=kernel
+
+UKL.a: tcp_server.o syscall.o userspace
+	$(AR) cr UKL.a tcp_server.o syscall.o
+	objcopy --prefix-symbols=ukl_ UKL.a
+
+tcp_server.o: tcp_server.c
+syscall.o: syscall.S
+
+userspace:
+	gcc -o tcp_server tcp_server.c
+
+clean:
+	rm -f UKL.a tcp_server.o syscall.o tcp_server
diff --git a/samples/ukl/README b/samples/ukl/README
new file mode 100644
index 000000000000..fbb771da033a
--- /dev/null
+++ b/samples/ukl/README
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+UKL test program
+================
+
+tcp_server.c is a epoll based TCP echo server written in C which uses port
+no. 5555 by default. syscall.S translates syscall() function to a call
+instruction in assembly. Normally, C libraries provide syscall() function
+that translate into syscall assembly instruction. Run `make` and it will
+create a UKL.a and a tcp_server. UKL.a can then be copied to where UKL
+Linux build expects it to be present. This can be changed through the Linux
+config options (by running `make menuconfig` etc.) The resulting Linux
+kernel can be run, and once the userspace comes up, the echo server can be
+started by running the UKL exec command, again chosen through the Linux
+config options. tcp_server is a userspace binary of the same echo server
+which can be run normally. This is meant to show that UKL can run code
+which can also be run as a userspace binary without modification.
diff --git a/samples/ukl/syscall.S b/samples/ukl/syscall.S
new file mode 100644
index 000000000000..95d1c177fb05
--- /dev/null
+++ b/samples/ukl/syscall.S
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+	.global _start
+_start:
+	jmp main
+
+	.global syscall
+
+/* Usage: long syscall (syscall_number, arg1, arg2, arg3, arg4, arg5, arg6)
+   We need to do some arg shifting, the syscall_number will be in
+   rax.  */
+
+	.text
+syscall:
+	movq %rdi, %rax		/* Syscall number -> rax.  */
+	movq %rsi, %rdi		/* shift arg1 - arg5.  */
+	movq %rdx, %rsi
+	movq %rcx, %rdx
+	movq %r8, %r10
+	movq %r9, %r8
+	movq 8(%rsp),%r9	/* arg6 is on the stack.  */
+	call entry_SYSCALL_64	/* Do the system call.  */
+	cmpq $-4095, %rax	/* Check %rax for error.  */
+	jae loop	/* Jump to error handler if error.  */
+	ret			/* Return to caller.  */
+
+loop:
+	jmp loop
diff --git a/samples/ukl/tcp_server.c b/samples/ukl/tcp_server.c
new file mode 100644
index 000000000000..abf1a0e2bb79
--- /dev/null
+++ b/samples/ukl/tcp_server.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/epoll.h>
+#include <arpa/inet.h>
+#include <netinet/tcp.h>
+
+#define BACKLOG 512
+#define MAX_EVENTS 128
+#define MAX_MESSAGE_LEN 2048
+
+void error(char *msg);
+extern long syscall(long number, ...);
+
+int main(void)
+{
+	// some variables we need
+	struct sockaddr_in server_addr, client_addr;
+	socklen_t client_len = sizeof(client_addr);
+	int bytes_received;
+	char buffer[MAX_MESSAGE_LEN];
+	int on;
+	int result;
+	int sock_listen_fd, newsockfd;
+
+	// setup socket
+	sock_listen_fd = syscall(41, AF_INET, SOCK_STREAM, 0);
+	if (sock_listen_fd < 0)
+		error("Error creating socket..\n");
+
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = 45845; //htons(portno);
+	server_addr.sin_addr.s_addr = INADDR_ANY;
+
+	// set TCP NODELAY
+	on = 1;
+	result = syscall(54, sock_listen_fd, IPPROTO_TCP, TCP_NODELAY, &on, sizeof(on));
+	if (result < 0)
+		error("Can't set TCP_NODELAY to on");
+
+	// bind socket and listen for connections
+	if (syscall(49, sock_listen_fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0)
+		error("Error binding socket..\n");
+
+	if (syscall(50, sock_listen_fd, BACKLOG) < 0)
+		error("Error listening..\n");
+
+	struct epoll_event ev, events[MAX_EVENTS];
+	int new_events, sock_conn_fd, epollfd;
+
+	epollfd = syscall(213, MAX_EVENTS);
+	if (epollfd < 0)
+		error("Error creating epoll..\n");
+
+	ev.events = EPOLLIN;
+	ev.data.fd = sock_listen_fd;
+
+	if (syscall(233, epollfd, EPOLL_CTL_ADD, sock_listen_fd, &ev) == -1)
+		error("Error adding new listeding socket to epoll..\n");
+
+	while (1) {
+		new_events = syscall(232, epollfd, events, MAX_EVENTS, -1);
+
+		if (new_events == -1)
+			error("Error in epoll_wait..\n");
+
+		for (int i = 0; i < new_events; ++i) {
+			if (events[i].data.fd == sock_listen_fd) {
+				sock_conn_fd = syscall(288, sock_listen_fd,
+						(struct sockaddr *)&client_addr,
+						&client_len, SOCK_NONBLOCK);
+				if (sock_conn_fd == -1)
+					error("Error accepting new connection..\n");
+
+				ev.events = EPOLLIN | EPOLLET;
+				ev.data.fd = sock_conn_fd;
+				if (syscall(233, epollfd, EPOLL_CTL_ADD, sock_conn_fd, &ev) == -1)
+					error("Error adding new event to epoll..\n");
+			} else {
+				newsockfd = events[i].data.fd;
+				bytes_received = syscall(45, newsockfd, buffer, MAX_MESSAGE_LEN,
+						0, NULL, NULL);
+				if (bytes_received <= 0) {
+					syscall(233, epollfd, EPOLL_CTL_DEL, newsockfd, NULL);
+					syscall(48, newsockfd, SHUT_RDWR);
+				} else {
+					syscall(44, newsockfd, buffer, bytes_received, 0, NULL, 0);
+				}
+			}
+		}
+	}
+}
+
+void error(char *msg)
+{
+	syscall(1, 1, msg, 15);
+	syscall(60, 1);
+}
-- 
2.21.3

