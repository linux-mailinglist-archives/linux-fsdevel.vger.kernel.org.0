Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C505F38E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJCWWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJCWWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:22:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAE5509E;
        Mon,  3 Oct 2022 15:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5JvXvyGZ1Wts3f4VV7VUtPuN3+hD7KTqZEPTeE+UpyZ3w1OJcidLibLewUNGwM2NlohIwvXdxGY6aKuY3IRjU5+3mTDu7Zw8ikVryi/C9Pc6kf+mWO373A6sJBIvrkF46hAnn4MyaEpBt7+/rWt8c3RDEz/t0vY7+f98myhVhESQzdsVPOPiPLPA5DRqmxpq9pVn3b3bM7zB+6uqfZ+GAa/ds+EnK6mp47IxfZSabT9v44Vnd1IwQ8ZNkpvDPDosdBf2CblIWH7JBz1xsJ4r/hXjRR9O+oe9GVl0JSlVL8c1iI2flGFe05KFFRttQeZS+7L7yepADj0w9WV+iQWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoLludXIvj9/dFEss6wXJs6a1houVrS1o/ZDErKipS4=;
 b=kuavkvcT7OsyeSPDmED8U+xgJfipFHg3mCN+La/CguiwtWnllUwCuX59JdJ0rb3yPE6PBC+T6kaQPjSQ1eUz/u/VSthTlzik1ZDFhlL13j6+20H7ZB5GYuGOQTCdvMZPFgDEaJOzWcpXGqGo5YVOoqJvoKGI3+2B490b93/NBXSQIvFiv6UKL48V4X68BofsmC64GQ+psPLZVscpTa/+K4t7MIQ5iNQSdpPWdp/cA+u4dF16jPTIksdtVatkWvKArbYj6E4fMdLV8FToVbymDm0vccx9hOdUNfgcJMmV6PQHYOxna1w4pZwkSksQO6cd+po9emBo1ZRVQUIjTQaPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoLludXIvj9/dFEss6wXJs6a1houVrS1o/ZDErKipS4=;
 b=TPByCr6ijpqhvzviE7nHWyUiBODOk/W5byNNKbOskpmcCHswYR9Jbnw5QllNce+M8Nkr4PGgXIBeBfstfLvOsuRCJesJbBRT7ecS7UZP6B2lW1Aj1M+yKjDiQoXJCwXwiCKmQ04GcGWT7UzOoK8e4g4kNQ7FNmqepkBIK4Sh7kKCT8s0LnBEYKq8nAprOGjbzkDA29wh+DNsOrYi2i40BxuZ3dppD0vfsZghoahAh4C5skQIGY4ljYoLuHzY5EJnfgWu3JT4duFMEFZEXcLE5gCYO6prnexBjO2Y1QxxHJRdz0HTcDWhtCu3q536LfGfg2G+e0G8IL2LE+oQpSOuRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB4928.namprd03.prod.outlook.com (2603:10b6:208:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 22:22:01 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 22:22:00 +0000
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
Subject: [RFC UKL 06/10] x86/fault: Skip checking kernel mode access to user address space for UKL
Date:   Mon,  3 Oct 2022 18:21:29 -0400
Message-Id: <20221003222133.20948-7-aliraza@bu.edu>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003222133.20948-1-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MN2PR03MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a87b478-7197-4113-10eb-08daa58db112
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8f/R1ivFOIpe61oGnzjp4VZk4MizdUuTPVPUtJuu0Ndi2TnrOOLddTPrOKMG45NNew1PS57VJkN2wcIMzpoMG+vNuTN1nTAZzSBXB4XzxLRgDjlmS4ysAuhqzhbevExw8xJ1d+JbPYcAMjwwCL2fTjyMjZxY0rvMr6FfhlRI6XslE5V1b0yS5l2bCNWVQfNdSiDuqZfoKNHaaRyqmx4aPFCxChX7T6KWjwbcOrGQ3L4YZL8KOojnCy5r4eAqR+J0CWzMx/4wsmRNrPzdM3TJa0gWd3Kkq9tGdtzKkaQDkNxrOGwzzS6Ed0I7B1bC5DM3OaoVsIGJPrT6EwUxl63YCb7lIPSZ2iLoBuZRPTOFZCtA36r9oIWJwEnxHJajirplHr5dS5wp4L3VYYGEe++6v0TjlybXYocA/IjcS9rMEQMdW1hQ+1L2aaaAnu6nbQiYAWBhIEkZY7OPsfhtkK+8yw7VQ9+paB6Ok5HNvi8+Isn78eR3NePwrCqrPI2+zv5ShkTK9UWcvCQHNx0A/Hm2WWC9StzT53Ia0KgPYcoGrcso3Aos0yaszCV5VzIxq5gZbdS3XoQV4r6VPms/SIZm+jjXheOcmZ4soyzB7LC33YTu0mXb+M3bRHd82Z8s0Bp1I7nTVX0EWrxeE+F21knKnBiJW9U9wHCkdaA5d0AV6YgQmqfmDKXEhH0k4XH6x1ZSyZ4IwJ8IwTHR33DEurI5d3AMlgt1s8Jx4PlFV6gMlP9xgbodAweauS/a7m+VfR2CQNlgFUyljMj9axls4Tc0VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(7406005)(41300700001)(6666004)(38350700002)(75432002)(66556008)(66476007)(4326008)(8676002)(1076003)(186003)(6512007)(2906002)(2616005)(66946007)(83380400001)(52116002)(6506007)(36756003)(5660300002)(7416002)(26005)(86362001)(41320700001)(6916009)(38100700002)(316002)(6486002)(478600001)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YWYUYFyfxDihmPhu5mscnvN2afmKzFQlS/UU9QaMC4VWsNNxRxDY3sYLthJ4?=
 =?us-ascii?Q?LHDRcLw2BQ3Fk50FYXTH3BUQS4YSZCo/aJv0lhajficycah79ceunot1LhoN?=
 =?us-ascii?Q?NhlnmDGyidzNx9quHyGKVkLRDEwPAEApgrl/jmVGva0n6xdKZGeD5DUvBDjY?=
 =?us-ascii?Q?z+RE3GjvuE/dgnMLxoH3uwSwzbyG1Jlxz7KSkwtXafjLxst2fLOLvpQ7rG+Z?=
 =?us-ascii?Q?Xu5F6VkC6JVmczwLAcaaJqv7Zx2TsA2ogBP9unnvhqE9lG+FaSeJ8yvZWog/?=
 =?us-ascii?Q?SlAsru7BbjxGcIz2YLGserV6UVIBpPB7ATQrXXfzFqtw3uiQvEZzRehbl+pl?=
 =?us-ascii?Q?iyolRzqF7KGkeVKxXVKU9uNNt0dmwES4+rhSc/RPFkGgtYLEkL1ziKi84ocy?=
 =?us-ascii?Q?0KN6DwqOgEKex6h6pO2vwN5q+aQqCST/GxlYXP726bF2yDR2SLk+2SH29yEo?=
 =?us-ascii?Q?U3d7xhKXaoqCy8oy5F7G/UYOZg/C5oi9nqAJps3eVPA1LS5uSwnlaWrsSnWh?=
 =?us-ascii?Q?S3D+JvSkyPO7srdHpNCsEkvBpXASljXrMlp2zPChxDJYb55ffM4wnYNPEVbE?=
 =?us-ascii?Q?84I7pjag6wyrodnT4wLgHBq66JkCYWAhHeW0g0AsaK+5xqGsSj5S2fxhcAN7?=
 =?us-ascii?Q?czq6OjHLsdlmMo0BTZ8RjvTnPmLvdtqpK8SgQ0L0e8roD50p46/z+2ESBzAW?=
 =?us-ascii?Q?QUOUfjtW4XvBP8Kt7uO6SUcsPx8QqfiYIKnJKN/oWdHofU1PsiODn1QTMmD2?=
 =?us-ascii?Q?uJzTe/MroHEF+emNl+rU7Y32c7QAeZ4DWO4/DggEb3Kipr5CZmPgzMedSm9z?=
 =?us-ascii?Q?tr+2L7TlvkaAV8oGcLW0q0inhgzxkHzMjQm9/VvxbTdlygb10yYCHRksen79?=
 =?us-ascii?Q?DetWp7o+jw551SvI3GMCMgiJxsz1L7A8QDCV157lUzjthi98+FIHhBRhhpZ/?=
 =?us-ascii?Q?SabO1qlzyXmRT60wNMqy55ez1hF6wXwurPvtlBvOUfeZlrRjUCMPBmEIQZEy?=
 =?us-ascii?Q?LE7fy/9gtZmfZLuduxPQq/l/c/AxCSrrQwR5J/FL9A8lt5V5lRIiCgGT8o6u?=
 =?us-ascii?Q?/dk4RZ5eztpGY5h4nPbTo/TJfz10mSmkCYh+enmK5oy7ooSXo+r+UF0UYZ8r?=
 =?us-ascii?Q?YE5vki2ReMt4xCbrkxP6VXByscVieAfAKn/uS3vSSA4ikcG1O02GXRNsLg3Z?=
 =?us-ascii?Q?s0sfYt9KSniNCkC08TDACwQmuYz+yS+O7zvqRBw+vW5xvqAfu4y7+Rha65Wj?=
 =?us-ascii?Q?T23b/92cB6nPsEJR733OjzRT9axGgNkq60WV0lkOK0tzgnz43SSN8Dg2usRi?=
 =?us-ascii?Q?3OLjEvGs2gI7zQOmg0AlFMWOAER4ztjOr8+0XkQRD41ckvq3Tb9I1XmK/3bA?=
 =?us-ascii?Q?EYb07crA8dhx3U1vrVhQ4A7/X45pBlX5UGa+v4FV66qcguPehCCJKwikwLRS?=
 =?us-ascii?Q?RqgklS9zo1ZIYpGkLTdWl01oLan0rHovjGyhNf36Dby0myT+8dHbm/67izTP?=
 =?us-ascii?Q?NW8zbTRV+0a2aDvNm62YRZRT14FnraSWhdnpFDBrVyppF8BCLhISpNaT9gW4?=
 =?us-ascii?Q?Op1f9rsg+SRuTxLsMV/Sw7sZpkjiYmN3AaILMtJS?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a87b478-7197-4113-10eb-08daa58db112
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 22:22:00.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjjzY3rg8+0uhjkvOXopfRWUFP8B0XitVouupzt97577gDU2uCc6T/9kT+bPnFwq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Normally, this check ensures that a kernel task has not ended up somehow
raising a page fault in the user part of address space. This is done by
checking if the CS value on stack. UKL always has the kernel value so this
check will always fail. This change makes sure that this check is only done
for non-UKL tasks by checking the in_user flag.

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

Signed-off-by: Ali Raza <aliraza@bu.edu>
---
 arch/x86/mm/fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa71a5d12e87..26de3556ca2c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1328,7 +1328,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * on well-defined single instructions listed in the exception
 	 * tables.  But, an erroneous kernel fault occurring outside one of
 	 * those areas which also holds mmap_lock might deadlock attempting
-	 * to validate the fault against the address space.
+	 * to validate the fault against the address space. However, if we
+	 * are configured as a unikernel and the fauling thread is the UKL
+	 * application code we can proceed as normal.
 	 *
 	 * Only do the expensive exception table search when we might be at
 	 * risk of a deadlock.  This happens if we
@@ -1336,7 +1338,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * 2. The access did not originate in userspace.
 	 */
 	if (unlikely(!mmap_read_trylock(mm))) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
+		if (!user_mode(regs) &&	!search_exception_tables(regs->ip) &&
+				!is_ukl_thread()) {
 			/*
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
-- 
2.21.3

