Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF16E2024
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDNKCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNKCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F917D83;
        Fri, 14 Apr 2023 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBLXpsB10dl2ZXiqvVeiWURL8MXm9A0bLXW8Wc5CUQQ=;
 b=J5gYKnen2rMkmfP+/IcHyP+06M0gJJ/dL6KO7Xd+LfelbL+x9R05G1a0mZWxUKH9vR4bBVA1b0fdlgUyGqWEPg7RBe7ocXAiveCJ6YLAA6ZtG20uObdjdMvKwT3N/b33xiqMUTPyvRclGTsM65OQbjFbUBz3CYhV0KOKDivr/Bk=
Received: from AM5PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:203:91::32) by AS8PR08MB9888.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:02:42 +0000
Received: from AM7EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::c4) by AM5PR0502CA0022.outlook.office365.com
 (2603:10a6:203:91::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT004.mail.protection.outlook.com (100.127.140.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 10:02:42 +0000
Received: ("Tessian outbound 99a3040377ca:v136"); Fri, 14 Apr 2023 10:02:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6fdd3755a942e6a4
X-CR-MTA-TID: 64aa7808
Received: from c81e36c9c379.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C24EAE52-F571-4AEC-9997-576D03AD1B5C.1;
        Fri, 14 Apr 2023 10:02:35 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c81e36c9c379.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 14 Apr 2023 10:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8k2plxETt8KU7HFnzmvmotaoFnMbdNT+KP1e87xdz9+SrW/8p3JPSNc/WkCQ28DNOGwptZAHjV47bDVVWnWPDMCxbvsSU+9ayTPyeax8uanAjlqDh+xZbSH6Hq+Req21YqVFxNymgt21c7emxBN9ZocKp47MJXK1246U9Ycqkt876h76OKFJUpRXb6P4Egq9CAuZu/kG55AmHt7RiaPhyAnxk/cn9KynP76zBXJqqaCgpAo2/1AYmktr5MP5Y4SVMMAmVoZJN/9GXRI5Ju3OuUibQKxolT7/StrMH3DUIJKF32kDL3zsCRhOLRbR/emcxqPWEi63GXXKk2A7+5oFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBLXpsB10dl2ZXiqvVeiWURL8MXm9A0bLXW8Wc5CUQQ=;
 b=bl2YRe46qkKKlr1kYK70TooTpkmkyNUfzTN6UzEnM7qQfsU71VydUavMYgNM64glZomvKYsm0hzHBLjy0Q2bzT20Wp80SVWpcCg5nZ0/ouZKGSMZTpYH2S1SUdemnJDtP9mgociqEW6EYtUPxHTk4ctZmsiLIlOXZiORPajxZsAGctVwZmgVxs7xi0XSVoQcL++/hqiCuEir+OTmMjOnxQfD4mWQsMZH7vgSzGs3B1sOE9cF1TXpmCyK/T+QPdKuYYmIqYoKgIdTKXhY+bwseGyHMi+PNeoFfg3xBjdbdZfEm9CV+sxOFN6nVKZONezA8nMvxDaH/yZXPEJTMT1aGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBLXpsB10dl2ZXiqvVeiWURL8MXm9A0bLXW8Wc5CUQQ=;
 b=J5gYKnen2rMkmfP+/IcHyP+06M0gJJ/dL6KO7Xd+LfelbL+x9R05G1a0mZWxUKH9vR4bBVA1b0fdlgUyGqWEPg7RBe7ocXAiveCJ6YLAA6ZtG20uObdjdMvKwT3N/b33xiqMUTPyvRclGTsM65OQbjFbUBz3CYhV0KOKDivr/Bk=
Received: from DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) by AM8PR08MB6514.eurprd08.prod.outlook.com
 (2603:10a6:20b:36b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:02:32 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::b0) by DUZPR01CA0019.outlook.office365.com
 (2603:10a6:10:46b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.29 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Fri, 14 Apr 2023 10:02:32 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 14 Apr
 2023 10:02:30 +0000
Received: from localhost.localdomain (10.57.20.128) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Fri, 14 Apr 2023 10:02:29 +0000
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 3/5] pipe: Pass argument of pipe_fcntl as int
Date:   Fri, 14 Apr 2023 11:02:10 +0100
Message-ID: <20230414100212.766118-4-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT037:EE_|AM8PR08MB6514:EE_|AM7EUR03FT004:EE_|AS8PR08MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae546bf-49d4-44ed-1d15-08db3ccf6375
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UOI6iqQ+9FzNLRoXVjf907fdQrs5j2Hmpeg8pMF6RF2PEEOEscIpgASFc9avupIJOy04pKObBSr0CqePrE29XCpghpYdGna/VCjL4yL6adghqPjxsJbsO43NSan5zObb0YMMGGa69I3soNa3UmFWTMKky89LK93RrUqT3O9WV3+7y0p0ln6xc8mOkrlCb/UdeTC0RqDJVhZmcOmG/sqR3sL57FXBW3aVlJxcxG2yL7prPQ61vnyRrQ5KPQ1QsgbO0nqxp//BMP+iK5uWg2q+hAilbr1mAc76XI8ilm/EFZgxDCqu9EMMCi/Rcg3T6mUwnzOEEx+mL+wa0TkFqzl2QNhAWYrV6m9Izzh0PkBLDDJKLtho78+RNhuC214vE0Zc0Bn/6TNQ2jUCfXvq1mnKlNaZT2xaLpbMI1agNN9vm0DZ6K+n7aaqkLkT/ujJB3sjTHQ8tfQsCRdzFjn+ap+EaDoemVb82jfqsWRkCeEfwARG/VwzhLGLteCMReDtZ1HBIqVj7yH4h/aHHuUMSveZrVJ2bM9LfReowZveBoSq3aAil2t41Mg1kVxX6Uv/OICZURHXjAFikDlTuH7Z3hz7SR1ddzo4hw8sDa2vMN386YJsMma/izj8PtnXkn/NF/RbRGiCUE+dh6IAe7DJGWW3v4COVgaRRD0GxocnRf///v9Q5oqoAvtgzGp0koSzKSTnhH/b1/IM8AEORJpi8I6haw==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(54906003)(2616005)(478600001)(36860700001)(83380400001)(1076003)(40480700001)(26005)(6666004)(70586007)(6916009)(70206006)(316002)(4326008)(82740400003)(47076005)(426003)(336012)(186003)(5660300002)(8676002)(8936002)(81166007)(356005)(2906002)(41300700001)(86362001)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6514
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b9d546f-0399-4283-16d6-08db3ccf5d98
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9KV5Rw1oRbQV+WnmAwxPV6U5QTdEiTjdl7fJyr/6epIjLSkSH4MdFn3pqhOuwNOreFmUN87tOG5HCkJvLU9vtVnXg9+rDEzX04XR3u2KP8ZChq1WZlRF1XAUYv8ee+HIgWd3yJFyqF4sQIX57X0qJLuPgvUZ/WcrJ3oxGAJkNrK48V+T351yTkwrFbh3gmy0KQx1P/4++ncuO7OqZWI4QnneiZhvcarZiFxlEGos0f+n0ieixr5GrjhAiEtSl3df+dF0KdD3TryLJqvDylyefaQ1+glZpLBd46+jwAU6qg2ozI5rJW2uB8tY+0Humhfp1YY8ouVMlsghm3ngxSMufg9hcph1h8E537UU5k1Vb3+LV+X1Sj8+ziwxLL/U3mC8AMvQInthsQH+NLvu7AMTS3/fpxvOFMiHksFFOUEqiRtwkL8jmHhxH35037o9oIJnrAB+FBqrcjdChOufkAvExxXEptkQQhsLW66Ar7IV3QoLPIlHvifMGXAIu94R5XXw5O6VgqeD54re02XvnNGmwGDFBuPb62cZVdp4GmY6zVQqRL5P/1EDERIli1fRLALAbaiJwQhIxNXZp2VZrK8lbkYZ4d2XcerTWr+y5X0SdQFp4SGLmhl6K/tAbO0CXO6k5wMdj6i7v0wBks/3adWUcnxLL8P2NmBRaIQKz824aLF5e56wsgOq8iMXuYcPRrvtn7fK5PthxY2K7R9VlYQdg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(336012)(70586007)(5660300002)(36756003)(2906002)(316002)(8676002)(40480700001)(86362001)(8936002)(41300700001)(81166007)(82310400005)(40460700003)(6916009)(82740400003)(4326008)(450100002)(426003)(70206006)(83380400001)(2616005)(47076005)(54906003)(186003)(1076003)(26005)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:02:42.6636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae546bf-49d4-44ed-1d15-08db3ccf6375
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9888
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interface for fcntl expects the argument passed for the command
F_SETPIPE_SZ to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Laight <David.Laight@ACULAB.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/pipe.c                 | 6 +++---
 include/linux/pipe_fs_i.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..5b718342105f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1231,7 +1231,7 @@ const struct file_operations pipefifo_fops =3D {
  * Currently we rely on the pipe array holding a power-of-2 number
  * of pages. Returns 0 on error.
  */
-unsigned int round_pipe_size(unsigned long size)
+unsigned int round_pipe_size(unsigned int size)
 {
        if (size > (1U << 31))
                return 0;
@@ -1314,7 +1314,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, un=
signed int nr_slots)
  * Allocate a new array of pipe buffers and copy the info over. Returns th=
e
  * pipe size if successful, or return -ERROR on error.
  */
-static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
+static long pipe_set_size(struct pipe_inode_info *pipe, unsigned int arg)
 {
        unsigned long user_bufs;
        unsigned int nr_slots, size;
@@ -1382,7 +1382,7 @@ struct pipe_inode_info *get_pipe_info(struct file *fi=
le, bool for_splice)
        return pipe;
 }

-long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
+long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
        struct pipe_inode_info *pipe;
        long ret;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index d2c3f16cf6b1..033d77f0c568 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -273,10 +273,10 @@ bool pipe_is_unprivileged_user(void);
 #ifdef CONFIG_WATCH_QUEUE
 int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots);
 #endif
-long pipe_fcntl(struct file *, unsigned int, unsigned long arg);
+long pipe_fcntl(struct file *, unsigned int, unsigned int arg);
 struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);

 int create_pipe_files(struct file **, int);
-unsigned int round_pipe_size(unsigned long size);
+unsigned int round_pipe_size(unsigned int size);

 #endif
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
