Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F7638F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKYSQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 13:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKYSQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:16:43 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2011.outbound.protection.outlook.com [40.92.52.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377C46661;
        Fri, 25 Nov 2022 10:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2wTgOSQMhXwJGfh05ZxfL+I4feFxOPqoWXyu7E+/Kphd6GB4VbEcda6zTXLX1OnHZoJhFS/qcw5DHWoxdT34Oe+mcJs+5CWXaX6wcY+gA/RhGGqMYogg8r9aR2GKkGpxrl//Ik4mA9yzYY4oXsa/EFKCMXgfVZNqpWE0I0f+VJtiwrgYqt6xS3odtSD/pZOWdMEkPwSUebQiIe+hMa3cGWA0RiElw7pFQsau5Nrxh72w33Hn6rF61KmnJ3kWqChilQnk+aeeAsvLSJ9gha4ZtdMKyAIQsyY1MIuOsvswSkXzBIRkpTM7MjQeza6M5IThWbO4AovBc3HbXjt65e8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkhulgFWMag46CUFZdywor7NYq29QizZEqjmAbphHh0=;
 b=KgHzcDZXO3PX9Nzr/Cb1TPDTzWlFC5CEjJ3l5fUtqhDdYdTkYpnU+92Tp6xRpPspL9GWWtTAUE9v2DXsjWmjdqHob+QqABn0sqGXZzZC5eVjolc4KEkRmYv9d8mTgPqntY9JJ8g7mxdCYqk6koK5+IWRX9nhWT0kxB3IvcGS79U5pJw8Vua+NYpH/kSv701tbIgXtWJ+RwK/CKl6a4x6nxBOGVKwEYkMLOErkKfSnVlJDB+Ww2GkufRXfuR48Mqv68GUUjY4T5Brz9D+MV27f4yZiD5coKVJvdC/BBcwCMe09EQ3gkF+KqW37Sc050y4jGDcXTDN6woGRVavAYN/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkhulgFWMag46CUFZdywor7NYq29QizZEqjmAbphHh0=;
 b=XY1tFWBLiNc9RrEcV8CNy+OjJTlxOSxRWg28Pa+kL1oQhIyd8qedDRsg45wyQ5loY4CVQnT/Dd5ZA8R9ih78nE5uV7vP2Qv4OVztTBhJ0WioBssG0081aFF9cegIuxdxZLykcJHK9e1YFnS1xowhzDRo/JYUWw/CNNXGo0Iegavr038uIGl5sdvAkH5HLoXFmVVVn2VxytG3R0UL4hYiTECjP92droOMCY547oVUIprSSL+nUqd83QoD3kmds1ktyUZxh0f3f6ewGD19dPQwLGKkuftk/sTBOcBU/Wctkv/7KaWNyPQykFx4BZ92vFMudPQCVrqdTP+j4sDftADPEA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by SG2PR01MB4592.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 18:16:39 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528%6]) with mapi id 15.20.5813.020; Fri, 25 Nov 2022
 18:16:39 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] fs: namei: fix two excess parameter description warnings
Date:   Fri, 25 Nov 2022 23:46:03 +0530
Message-ID: <HK0PR01MB2801A4C374BC28C8C98BA7EDF80E9@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dGCkUfoRhom+QGa+ruXvgVKYsVCxbTednEwtO3KH0axzMCTrk1plPqoAaFoUkLPj]
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20221125181603.5867-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR01MB2801:EE_|SG2PR01MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: a5902b06-f50d-40fa-4228-08dacf1131e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auP6k2xFn6DodtXPi51zTW/o7+BR3Rz7hodJJQaD8skWZWjrjjLFMWZYjBpqese9a8EYxxqjPwCMiSOfOj316TztLlN5IrUHa97gRTGTiV7b7045TkMcCLHAqXITq1dAKeyV2Fbk9cZWRopS7EfFsgAHvYkKZ6t/ABG5FH73sqg9zWKjWMN4QyCJChORJGe9g2LBAZP+YniAtodqn5j+Ezy14MzMTOztmKBeEtpZ+3yEh79wTMRIN8sGRp6PQRlMartqIeMqaRfedvIBoLUhL9dDY+x8rdO0MdiwD9C5fRO7qhAIyF1subV8EuxWywIJB8GjNqfzvDfB8SUnLE/pCds2oSwKBzxgSwx+w4bfPqBzxKtIujUSM0TihF0dtkoU52YXwoTJqGdMeE+ih3MOykvUKu0oSM1KzHNxnJ3n0C4ZBM2gzng84t/qYlt9eqtecX2egNTHDIsJdKEqtYtCwzA7DupJd5TufxSPfXa/IhJk5b281yNq0EbhWy60q/l0oEMXjD1DqKNqBGtx9XnaSxyujQJhQL37zHS5tThOAS3qccY5P/7DkY8tKCWuaSMG65jGLAMiV/38hWqOxyivwAMtbu6x1BA43QUWXD4bP0g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?81DZsak7yVWBWzHpRhMmWHj8PDknEcteKKCpQEORdfRj3q+SdDItjkNlk0IL?=
 =?us-ascii?Q?oQ2fj9fCM05EPF+8J8bTrCMKMmeluwbaCwkLDW5RXRwZPac5lACOnE+5U4jf?=
 =?us-ascii?Q?5EZaWRVsF1G6kyt4a+/YOfS3F9bRcH9/TPYDXwKlC1SJIJrmUYDyBXF7h0yN?=
 =?us-ascii?Q?fRZby+kxtbcBRC9EfGpQMZPG+EXbKs8q7qVB21Xz0VQ8ank4x/SPrf4akm3u?=
 =?us-ascii?Q?Rapl3oa314Yl3vQdfpmp8bZ/i7QcSoWLbvr7apmoGtg3ERFHuvZGXWi4yRRp?=
 =?us-ascii?Q?RjDeahdBJ+d9vQtqxWBw8zNvdWi/Xu4Fo0iLWWwVFF8fXXGK6gXgCjIafm/P?=
 =?us-ascii?Q?JhAKXUdMTAvB5XKiL945UXiw+z5Gl4AVC6dxPmDOOzit6cp6shbR8P2WG2rR?=
 =?us-ascii?Q?P4oJFvD0Jag+tp7L1QNzSnxBkZSfV5juCvJtGJi7zHm2AQG75g9u9U0SJvnJ?=
 =?us-ascii?Q?Ncf6COXBIdu5dyThaAsjpOftRrnd2WHbOQpYPrlsXYrjbiVXMFp2vsl0b6WK?=
 =?us-ascii?Q?cuy3D6kIO1Bqg8PkPHJIKYpAKUqtwUHH0SJM5wjyk7E9yYK8ZxJQ6bb5G1cF?=
 =?us-ascii?Q?EEiCzG3jvX2jmbkvajsMddfmIDr/51zVBo7Nl7nCWKjHg6ffkCeS+0U0Xh33?=
 =?us-ascii?Q?sXXlZwIUhqfMNfajiri/DB6A7UkrcxBGniO1oSJxJV79ufQQUsp/K4+cOweO?=
 =?us-ascii?Q?UJJJ7soXtTCfhkL359XqfOSJHsKb2zIJSFFPtXvdCEF8OiyoeQ46AoqLFRa/?=
 =?us-ascii?Q?sHR/tNXxi+WACHCZOMFnQpaYEiXM/xNh8gBu/WwU62JwOuRAXuM10tqRShyK?=
 =?us-ascii?Q?C8We3hKsjfIETSbuuYhtPJEHVMhpsKXxaLCSMUpIOLKvYH9lP6bl6j20BCsX?=
 =?us-ascii?Q?uY8Kp+vM6+WAVffGZ7YfYk6jpAvxMdbS/a7A48S/DkVxNsMwGOv9tatMlBGp?=
 =?us-ascii?Q?kVgNz2OZrsJtwAXbfrJ5SHyDmFF+pLYOXmklqoqaodf8tkms1ySxPbTN43cw?=
 =?us-ascii?Q?mcK/ZsmO7MJIHwoqh1+CB6FGzoTcxLwe4/MdswAuJ2evDfonOcHFIQWk1wGD?=
 =?us-ascii?Q?glNA5ekFHEuvYfG1S721xczOrt/XPZhLNBb8aWmFQyjo7Zu893eISa38g6kh?=
 =?us-ascii?Q?fThJbFkYGm1pGFW+Vgu0HX4j6nxg6Oo3aTksAC9dgm3yEXQAfodiq1qXBhyp?=
 =?us-ascii?Q?vuu0aA+RbGdo7+LIYOhZProz+Z/jXGGkzu4lmnIcSYp8KIWwH7D71ppLhd/k?=
 =?us-ascii?Q?ziGNJ7PUo2QkjAmz2ov4V4iStIe2AXGwJwTrarZ79khaLcss1gNkYKVuh4S2?=
 =?us-ascii?Q?29w2sAEh7Uy5xaqbFb96AHUTH69IlerRcy38zYsPYUqbNg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5902b06-f50d-40fa-4228-08dacf1131e5
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 18:16:39.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4592
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While building the kernel documentation, two excess parameter description
warnings appear:
	./fs/namei.c:3589: warning: Excess function parameter 'dentry'
	description in 'vfs_tmpfile'
	./fs/namei.c:3589: warning: Excess function parameter 'open_flag'
	description in 'vfs_tmpfile'

Fix these warnings by changing 'dentry' to 'parentpath' in the parameter
description and 'open_flag' to 'file' and change 'file' parameter's
description accordingly.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
v1 -> v2: Add Randy Dunlap's Tested-by tag

 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..8e77e194fed5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3571,9 +3571,9 @@ static int do_open(struct nameidata *nd,
 /**
  * vfs_tmpfile - create tmpfile
  * @mnt_userns:	user namespace of the mount the inode was found from
- * @dentry:	pointer to dentry of the base directory
+ * @parentpath:	pointer to dentry of the base directory
  * @mode:	mode of the new tmpfile
- * @open_flag:	flags
+ * @file:	file information
  *
  * Create a temporary file.
  *
-- 
2.38.1

