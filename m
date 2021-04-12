Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A636735CFDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbhDLRxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 13:53:12 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:32316 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243428AbhDLRxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618249972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJSShY8z6GHJpAiXewSvxHsIFNsj7tZD88cEhasSj3A=;
        b=SGnLs5QIXGdHeKPwAiu4j6ycm/YGkHiBHKU2jumrgRWYNTquROz+1+D3VTetrpYz3lNyTl
        VrgJwbHO3wONci7AN9rWX0eTdTNhlbkF9QpSPC4aB74Eon/d2vr/AQOcRatj24tz8bhpp8
        84YfAEzIGomiu9koODrKDR7W5iaZOV8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-DZo4Pl1YPryhcgKvnJUA3g-1; Mon, 12 Apr 2021 19:52:50 +0200
X-MC-Unique: DZo4Pl1YPryhcgKvnJUA3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY9G+o7UeM9cQP3toYbDFMIpL9SYP3hOw5t53T6oYF4D1WlFU9RBE02xmFcchnAmkOmO9camThrBdBFnHL6PRiow95x3i2Scbh/j9wwKxnFfXYaW4ik8qb539I5vNX1TpgvAv3fMTSWUTZiOtXC4L3tdu1zWRbYS83sIPbCS8q0QZSGWdJaeq48ypJQEPdkB/3J2DYRy2B4IvWvsMqCWjkFuLI6/X60jbPfjh0zc+5rvVnefKkaAnPtTVf9T1hxaVoFUjij/EeKTnYPEmXZxk7j87OJmNcBzG34bhzcNq+O2OIdXskd5VSrh5rrGXvVJxYDqEw7jLeDvTuMGsjXO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJSShY8z6GHJpAiXewSvxHsIFNsj7tZD88cEhasSj3A=;
 b=ELSy3+KaGCeAT6V6ttpVZkM7xGI2Gx4jIzsgGI4c/DsLJYq6yJVZBZNR+vksGouL5j5I+KKQvG09XXj8O0ztaqC3bgk+qmeZJ8b6CcyfRu7XpZ6vNw+0OG3Z08rjuzmKs1Hi1CGHfCXk3ZmA3BQSMGc65vI0H8CGZuxG12HVZMzNoOnFi2AtA65zExpeiiTdvv2G7Dop8E9jC4XlKYXKevOCUN9sTo5OiYxQIQNg6G224ztOj7GYyK3bWN25fDjTt8dRyIlyzyhOzVygSCVLDKovjX9fkgyc19HDWRJuSuUaDZI95t9nJxFxmEiUQoz1DYZ8dyRW4Cs21aCt+amXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 17:52:48 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::3c87:7c9e:2597:4d94%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:52:48 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [EXPERIMENT v3] new mount API verbose errors from userspace
In-Reply-To: <CAH2r5mve+EXFnkwVzRz2xuhNEMVgdWLZrSNcLFqhZKF4Hsxvug@mail.gmail.com>
References: <87k0qoxz7r.fsf@suse.com> <87tupuya6t.fsf@suse.com>
 <CAN05THRV_Tns4MTO-GFNg0reR+HJKa1BCSQ0m23PTSryGNPCeg@mail.gmail.com>
 <181014.1615311429@warthog.procyon.org.uk> <87eegouqo8.fsf@suse.com>
 <87eegcsj31.fsf@suse.com>
 <CAH2r5mve+EXFnkwVzRz2xuhNEMVgdWLZrSNcLFqhZKF4Hsxvug@mail.gmail.com>
Date:   Mon, 12 Apr 2021 19:52:45 +0200
Message-ID: <871rbf2xw2.fsf@suse.com>
Content-Type: multipart/mixed; boundary="=-=-="
X-Originating-IP: [2003:fa:703:389:f439:5b5b:3992:60b2]
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:703:389:f439:5b5b:3992:60b2) by ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 17:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2600dc6a-0364-499b-f8fc-08d8fddbc88e
X-MS-TrafficTypeDiagnostic: VE1PR04MB7278:
X-Microsoft-Antispam-PRVS: <VE1PR04MB7278742AB308CEAAD6B3960DA8709@VE1PR04MB7278.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsEdkuB2wgsO+U2oXQDZIoiRdgsHaunm1OWQ9r22uKniYBI1IYbgAm/J1Kl1WIQRmLvkTyxsmTYbl994WrQl/hHkqPL/TMwGIxhcgrbAcaKWjEIgze2N8dXHebDm6CTMzj4Spr9fu/Clh3aDrDAUUdeZ/aY6gudCVfEDZZlmZJcLTTU6aoIH6r1IjIEU69ZvZcrG7Ra1HFokYVVyZEjPbrCYrt9Tg5lX2xaJZvu5l53g95fdh01cEn15Lnq0DwJslOCXnxYcP/WqB46f+DYylramFfZ/RSQoKtR3Srcfe6ZZnzLesbu9iinJ75Cnq9KWEhtj0IHQ1blQA9FsQxGcJ9JcbFxEE43uFZHRZnASdRFo+7b8o5Mjp3wjRCGKJK4KzqRJ6d2BUoVoAHdmyQxxxcx1agERBP8HG5yuvY8WYfJxNSVX3Z2apVIFQpuXFEbG2b7gDpsrM9CWiRDg5b+L8Gv7PUftMPajN7sXb3GNGsvConn85tIEbjtZOE0S1ktVAOLQbsseQdJOR8cMPM4ApzMnVc9ZyfSphlvPxGCNUVo3jd2BLVvxuaIVsZXjqTIpf2mmpS0alnqb9T20TSy+dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(396003)(366004)(376002)(38100700002)(6496006)(235185007)(5660300002)(36756003)(33964004)(6486002)(2906002)(66556008)(478600001)(66476007)(66946007)(66576008)(316002)(86362001)(8936002)(6916009)(54906003)(83380400001)(4326008)(16526019)(186003)(52116002)(8676002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kph/ah2xIZs4YdGLB/mcAl8zRRu5gBhkLL/ySCxmO07EuOD3RVMSc+zXtiTO?=
 =?us-ascii?Q?08ybRjc4r+8MoAZD0MiihDocoHKbuu+PZLHpjZ62dZIqNn9fWPnAasM4pliz?=
 =?us-ascii?Q?uB5aoU9smDzdp4B4gvVeARVyjV2bOxbCl1V14z3Xb6qAHFr2cFGzA4iJh/tj?=
 =?us-ascii?Q?3tf3kTPigBw4cod4JxY9JFE7csEbwKTpTmpeyyiEkw/wGGTqbrUJMh2Py5vW?=
 =?us-ascii?Q?aIeQZDrKkbeRiOG/C/mvy+2gEx5nglMy4vAVC8tQswMGLNnR1LdHTXYil8iF?=
 =?us-ascii?Q?dcNRnQTrWTkU+UM/UNzx/NGixs3EOQ2TzD+FMrRhxuRQSDMfCMCf97LrBDQM?=
 =?us-ascii?Q?NVRV4XCEEonCwLAT86mHANiv6QnIAXT60vIig+8s1T8bkk3Ape1bCjt+XkDb?=
 =?us-ascii?Q?GcODNNstWhBYeq1l1neGu1kC93467Wam0qHAWioB03VTXyf6T8wGTBZBD0bZ?=
 =?us-ascii?Q?MBkqdSibMUzl/Wvw/DwfVgT4cRzjY8Wbnccgu59hAfvqyO2wqQoc0lv9AQNx?=
 =?us-ascii?Q?mcXns1pqGMbshqrc0K2HrKllYBYSuK72zB6VjdefyX7k23nzUmt9oWb53l3+?=
 =?us-ascii?Q?87fRmX+w8XLrF/qhWCbrttNSxYOQju7to0U68OWJbG0QDkCdCBoH7sc9Cvhr?=
 =?us-ascii?Q?aulGl6St5D6rKH8G/Vj9cGoGCU9ZokmtJWZaBvYaVpB6SsJ+S5jtfmWNTQo/?=
 =?us-ascii?Q?qW0CyFrCZ5Iw0vFwKDpay+mShVTokTE3tHJv6EcrSaSC+Ph7+xQPrkpsyaht?=
 =?us-ascii?Q?H8cMZ+p5RcCEjj6ZaUaZed8tLO5rPmf82XZPdUAlI8IQZEigYURG0I1Bhuhi?=
 =?us-ascii?Q?Xea3J/OmnvYFc/EIaD8/7gaCqL6nmdu2/GOisgNCXqyARoPX2ruT8stcSIll?=
 =?us-ascii?Q?06TA1ET1VdOj+iFFktOZ7o+KljAtNTpiD75Qo4H+mVtFVJvrJUQEXqTy3yh+?=
 =?us-ascii?Q?vXUBtZn0r7ENfEK7tTSPDg4wLt4BkZb84nkjIQnn1SSNv9k/cVp1bFPCHagT?=
 =?us-ascii?Q?3HV0mVCcbR6ZPvBg7rkFP2lzcbOE7TZ7N1nS+0rfatxw+aWpjYZpAETXXLor?=
 =?us-ascii?Q?MLjjY4NEe9V8G/UwwSWbpqAk1lDjbcnVs7SaBDfdMbcunHYDespvySCRWUXW?=
 =?us-ascii?Q?EQb3BAizC8C480zURbHdTjnBkVJ/IOu4b9oDWbKkrH6JgwstjNKoy5dhVS4w?=
 =?us-ascii?Q?ReNZ5JzMJwUylRP14lqeBFyF/7fKjzTN37f18Ol37bJXulAPVIHW+kHOdyb0?=
 =?us-ascii?Q?jXiXgbxv+peU3JtAqzkUGIkRyQ1O3uHNgYFzMPn5VCGYnIWHyJtNKjjPyAe7?=
 =?us-ascii?Q?j6R4epHz9ERmvrENdC0o2CX1k4A9OokDqd2PYsN450gxX1LXSXS0H/PU0gxI?=
 =?us-ascii?Q?kteF9IEu+/N/1j3DyaVIL0lxm3Kt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2600dc6a-0364-499b-f8fc-08d8fddbc88e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:52:47.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KPqgHZKpX3gD0+DPNwDjK3E4hSB1BGLfM4N+Qirtd+nTbZDDSiHm5FrJ7ayZpMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Steve French <smfrench@gmail.com> writes:
> Tentatively merged into cifs-2.6.git for-next but would like more
> feedback on other's thoughts on this. Getting more verbose error
> information back on mount errors (to userspace returning something
> more than a primitive small set of return codes, and a message logged
> to dmesg) is critical, and this approach seems reasonable at first
> glance but if there are better ways ...

Yes more feedback would be reasonable. I've basically redone a barebone
version of the missing fsinfo() call just for cifs.

New patch version attached.

Changes since v2:
- add missing call to remove_proc_entry() (fix splat on rmmod)


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=fs_context_log_v3.patches

From 22cfea98e6c08ccc1e3c3960502669723a4ab773 Mon Sep 17 00:00:00 2001
From: Aurelien Aptel <aaptel@suse.com>
Date: Mon, 1 Mar 2021 19:25:00 +0100
Subject: [PATCH 1/4] cifs: make fs_context error logging wrapper

This new helper will be used in the fs_context mount option parsing
code. It log errors both in:
* the fs_context log queue for userspace to read
* kernel printk buffer (dmesg, old behaviour)

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/fs_context.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index 87dd1f7168f2..dc0b7c9489f5 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -13,7 +13,12 @@
 #include <linux/parser.h>
 #include <linux/fs_parser.h>
 
-#define cifs_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
+/* Log errors in fs_context (new mount api) but also in dmesg (old style) */
+#define cifs_errorf(fc, fmt, ...)			\
+	do {						\
+		errorf(fc, fmt, ## __VA_ARGS__);	\
+		cifs_dbg(VFS, fmt, ## __VA_ARGS__);	\
+	} while (0)
 
 enum smb_version {
 	Smb_1 = 1,
-- 
2.30.0


From 0cdc5fe7c323b7b27a03da3ed7c2434630ed2246 Mon Sep 17 00:00:00 2001
From: Aurelien Aptel <aaptel@suse.com>
Date: Mon, 1 Mar 2021 19:32:09 +0100
Subject: [PATCH 2/4] cifs: add fs_context param to parsing helpers

Add fs_context param to parsing helpers to be able to log into it in
next patch.

Make some helper static as they are not used outside of fs_context.c

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/fs_context.c | 21 +++++++++++----------
 fs/cifs/fs_context.h |  4 ----
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 7652f73e1bcc..8de777efca32 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -188,8 +188,8 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	{}
 };
 
-int
-cifs_parse_security_flavors(char *value, struct smb3_fs_context *ctx)
+static int
+cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_context *ctx)
 {
 
 	substring_t args[MAX_OPT_ARGS];
@@ -254,8 +254,8 @@ static const match_table_t cifs_cacheflavor_tokens = {
 	{ Opt_cache_err, NULL }
 };
 
-int
-cifs_parse_cache_flavor(char *value, struct smb3_fs_context *ctx)
+static int
+cifs_parse_cache_flavor(struct fs_context *fc, char *value, struct smb3_fs_context *ctx)
 {
 	substring_t args[MAX_OPT_ARGS];
 
@@ -339,7 +339,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 }
 
 static int
-cifs_parse_smb_version(char *value, struct smb3_fs_context *ctx, bool is_smb3)
+cifs_parse_smb_version(struct fs_context *fc, char *value, struct smb3_fs_context *ctx, bool is_smb3)
 {
 	substring_t args[MAX_OPT_ARGS];
 
@@ -684,7 +684,8 @@ static void smb3_fs_context_free(struct fs_context *fc)
  * Compare the old and new proposed context during reconfigure
  * and check if the changes are compatible.
  */
-static int smb3_verify_reconfigure_ctx(struct smb3_fs_context *new_ctx,
+static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
+				       struct smb3_fs_context *new_ctx,
 				       struct smb3_fs_context *old_ctx)
 {
 	if (new_ctx->posix_paths != old_ctx->posix_paths) {
@@ -747,7 +748,7 @@ static int smb3_reconfigure(struct fs_context *fc)
 	struct cifs_sb_info *cifs_sb = CIFS_SB(root->d_sb);
 	int rc;
 
-	rc = smb3_verify_reconfigure_ctx(ctx, cifs_sb->ctx);
+	rc = smb3_verify_reconfigure_ctx(fc, ctx, cifs_sb->ctx);
 	if (rc)
 		return rc;
 
@@ -1175,16 +1176,16 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		goto cifs_parse_mount_err;
 	case Opt_vers:
 		/* protocol version (dialect) */
-		if (cifs_parse_smb_version(param->string, ctx, is_smb3) != 0)
+		if (cifs_parse_smb_version(fc, param->string, ctx, is_smb3) != 0)
 			goto cifs_parse_mount_err;
 		ctx->got_version = true;
 		break;
 	case Opt_sec:
-		if (cifs_parse_security_flavors(param->string, ctx) != 0)
+		if (cifs_parse_security_flavors(fc, param->string, ctx) != 0)
 			goto cifs_parse_mount_err;
 		break;
 	case Opt_cache:
-		if (cifs_parse_cache_flavor(param->string, ctx) != 0)
+		if (cifs_parse_cache_flavor(fc, param->string, ctx) != 0)
 			goto cifs_parse_mount_err;
 		break;
 	case Opt_witness:
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index dc0b7c9489f5..56d7a75e2390 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -262,10 +262,6 @@ struct smb3_fs_context {
 
 extern const struct fs_parameter_spec smb3_fs_parameters[];
 
-extern int cifs_parse_cache_flavor(char *value,
-				   struct smb3_fs_context *ctx);
-extern int cifs_parse_security_flavors(char *value,
-				       struct smb3_fs_context *ctx);
 extern int smb3_init_fs_context(struct fs_context *fc);
 extern void smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx);
 extern void smb3_cleanup_fs_context(struct smb3_fs_context *ctx);
-- 
2.30.0


From f8a58c6c1e4513cd769cd7b246ef4e0af9ed4639 Mon Sep 17 00:00:00 2001
From: Aurelien Aptel <aaptel@suse.com>
Date: Mon, 1 Mar 2021 19:34:02 +0100
Subject: [PATCH 3/4] cifs: log mount errors using cifs_errorf()

This makes the errors accessible from userspace via dmesg and
the fs_context fd.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/fs_context.c | 95 +++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 49 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 8de777efca32..74758e954035 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -203,7 +203,7 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
 
 	switch (match_token(value, cifs_secflavor_tokens, args)) {
 	case Opt_sec_krb5p:
-		cifs_dbg(VFS, "sec=krb5p is not supported!\n");
+		cifs_errorf(fc, "sec=krb5p is not supported!\n");
 		return 1;
 	case Opt_sec_krb5i:
 		ctx->sign = true;
@@ -238,7 +238,7 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
 		ctx->nullauth = 1;
 		break;
 	default:
-		cifs_dbg(VFS, "bad security option: %s\n", value);
+		cifs_errorf(fc, "bad security option: %s\n", value);
 		return 1;
 	}
 
@@ -291,7 +291,7 @@ cifs_parse_cache_flavor(struct fs_context *fc, char *value, struct smb3_fs_conte
 		ctx->cache_rw = true;
 		break;
 	default:
-		cifs_dbg(VFS, "bad cache= option: %s\n", value);
+		cifs_errorf(fc, "bad cache= option: %s\n", value);
 		return 1;
 	}
 	return 0;
@@ -347,24 +347,24 @@ cifs_parse_smb_version(struct fs_context *fc, char *value, struct smb3_fs_contex
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	case Smb_1:
 		if (disable_legacy_dialects) {
-			cifs_dbg(VFS, "mount with legacy dialect disabled\n");
+			cifs_errorf(fc, "mount with legacy dialect disabled\n");
 			return 1;
 		}
 		if (is_smb3) {
-			cifs_dbg(VFS, "vers=1.0 (cifs) not permitted when mounting with smb3\n");
+			cifs_errorf(fc, "vers=1.0 (cifs) not permitted when mounting with smb3\n");
 			return 1;
 		}
-		cifs_dbg(VFS, "Use of the less secure dialect vers=1.0 is not recommended unless required for access to very old servers\n");
+		cifs_errorf(fc, "Use of the less secure dialect vers=1.0 is not recommended unless required for access to very old servers\n");
 		ctx->ops = &smb1_operations;
 		ctx->vals = &smb1_values;
 		break;
 	case Smb_20:
 		if (disable_legacy_dialects) {
-			cifs_dbg(VFS, "mount with legacy dialect disabled\n");
+			cifs_errorf(fc, "mount with legacy dialect disabled\n");
 			return 1;
 		}
 		if (is_smb3) {
-			cifs_dbg(VFS, "vers=2.0 not permitted when mounting with smb3\n");
+			cifs_errorf(fc, "vers=2.0 not permitted when mounting with smb3\n");
 			return 1;
 		}
 		ctx->ops = &smb20_operations;
@@ -372,10 +372,10 @@ cifs_parse_smb_version(struct fs_context *fc, char *value, struct smb3_fs_contex
 		break;
 #else
 	case Smb_1:
-		cifs_dbg(VFS, "vers=1.0 (cifs) mount not permitted when legacy dialects disabled\n");
+		cifs_errorf(fc, "vers=1.0 (cifs) mount not permitted when legacy dialects disabled\n");
 		return 1;
 	case Smb_20:
-		cifs_dbg(VFS, "vers=2.0 mount not permitted when legacy dialects disabled\n");
+		cifs_errorf(fc, "vers=2.0 mount not permitted when legacy dialects disabled\n");
 		return 1;
 #endif /* CIFS_ALLOW_INSECURE_LEGACY */
 	case Smb_21:
@@ -403,7 +403,7 @@ cifs_parse_smb_version(struct fs_context *fc, char *value, struct smb3_fs_contex
 		ctx->vals = &smbdefault_values;
 		break;
 	default:
-		cifs_dbg(VFS, "Unknown vers= option specified: %s\n", value);
+		cifs_errorf(fc, "Unknown vers= option specified: %s\n", value);
 		return 1;
 	}
 	return 0;
@@ -588,14 +588,14 @@ static int smb3_fs_context_validate(struct fs_context *fc)
 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
 
 	if (ctx->rdma && ctx->vals->protocol_id < SMB30_PROT_ID) {
-		cifs_dbg(VFS, "SMB Direct requires Version >=3.0\n");
+		cifs_errorf(fc, "SMB Direct requires Version >=3.0\n");
 		return -EOPNOTSUPP;
 	}
 
 #ifndef CONFIG_KEYS
 	/* Muliuser mounts require CONFIG_KEYS support */
 	if (ctx->multiuser) {
-		cifs_dbg(VFS, "Multiuser mounts require kernels with CONFIG_KEYS enabled\n");
+		cifs_errorf(fc, "Multiuser mounts require kernels with CONFIG_KEYS enabled\n");
 		return -1;
 	}
 #endif
@@ -605,13 +605,13 @@ static int smb3_fs_context_validate(struct fs_context *fc)
 
 
 	if (!ctx->UNC) {
-		cifs_dbg(VFS, "CIFS mount error: No usable UNC path provided in device string!\n");
+		cifs_errorf(fc, "CIFS mount error: No usable UNC path provided in device string!\n");
 		return -1;
 	}
 
 	/* make sure UNC has a share name */
 	if (strlen(ctx->UNC) < 3 || !strchr(ctx->UNC + 3, '\\')) {
-		cifs_dbg(VFS, "Malformed UNC. Unable to find share name.\n");
+		cifs_errorf(fc, "Malformed UNC. Unable to find share name.\n");
 		return -ENOENT;
 	}
 
@@ -689,45 +689,45 @@ static int smb3_verify_reconfigure_ctx(struct fs_context *fc,
 				       struct smb3_fs_context *old_ctx)
 {
 	if (new_ctx->posix_paths != old_ctx->posix_paths) {
-		cifs_dbg(VFS, "can not change posixpaths during remount\n");
+		cifs_errorf(fc, "can not change posixpaths during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->sectype != old_ctx->sectype) {
-		cifs_dbg(VFS, "can not change sec during remount\n");
+		cifs_errorf(fc, "can not change sec during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->multiuser != old_ctx->multiuser) {
-		cifs_dbg(VFS, "can not change multiuser during remount\n");
+		cifs_errorf(fc, "can not change multiuser during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->UNC &&
 	    (!old_ctx->UNC || strcmp(new_ctx->UNC, old_ctx->UNC))) {
-		cifs_dbg(VFS, "can not change UNC during remount\n");
+		cifs_errorf(fc, "can not change UNC during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->username &&
 	    (!old_ctx->username || strcmp(new_ctx->username, old_ctx->username))) {
-		cifs_dbg(VFS, "can not change username during remount\n");
+		cifs_errorf(fc, "can not change username during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->password &&
 	    (!old_ctx->password || strcmp(new_ctx->password, old_ctx->password))) {
-		cifs_dbg(VFS, "can not change password during remount\n");
+		cifs_errorf(fc, "can not change password during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->domainname &&
 	    (!old_ctx->domainname || strcmp(new_ctx->domainname, old_ctx->domainname))) {
-		cifs_dbg(VFS, "can not change domainname during remount\n");
+		cifs_errorf(fc, "can not change domainname during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->nodename &&
 	    (!old_ctx->nodename || strcmp(new_ctx->nodename, old_ctx->nodename))) {
-		cifs_dbg(VFS, "can not change nodename during remount\n");
+		cifs_errorf(fc, "can not change nodename during remount\n");
 		return -EINVAL;
 	}
 	if (new_ctx->iocharset &&
 	    (!old_ctx->iocharset || strcmp(new_ctx->iocharset, old_ctx->iocharset))) {
-		cifs_dbg(VFS, "can not change iocharset during remount\n");
+		cifs_errorf(fc, "can not change iocharset during remount\n");
 		return -EINVAL;
 	}
 
@@ -934,7 +934,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		 */
 		if ((result.uint_32 < CIFS_MAX_MSGSIZE) ||
 		   (result.uint_32 > (4 * SMB3_DEFAULT_IOSIZE))) {
-			cifs_dbg(VFS, "%s: Invalid blocksize\n",
+			cifs_errorf(fc, "%s: Invalid blocksize\n",
 				__func__);
 			goto cifs_parse_mount_err;
 		}
@@ -952,25 +952,25 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	case Opt_acregmax:
 		ctx->acregmax = HZ * result.uint_32;
 		if (ctx->acregmax > CIFS_MAX_ACTIMEO) {
-			cifs_dbg(VFS, "acregmax too large\n");
+			cifs_errorf(fc, "acregmax too large\n");
 			goto cifs_parse_mount_err;
 		}
 		break;
 	case Opt_acdirmax:
 		ctx->acdirmax = HZ * result.uint_32;
 		if (ctx->acdirmax > CIFS_MAX_ACTIMEO) {
-			cifs_dbg(VFS, "acdirmax too large\n");
+			cifs_errorf(fc, "acdirmax too large\n");
 			goto cifs_parse_mount_err;
 		}
 		break;
 	case Opt_actimeo:
 		if (HZ * result.uint_32 > CIFS_MAX_ACTIMEO) {
-			cifs_dbg(VFS, "timeout too large\n");
+			cifs_errorf(fc, "timeout too large\n");
 			goto cifs_parse_mount_err;
 		}
 		if ((ctx->acdirmax != CIFS_DEF_ACTIMEO) ||
 		    (ctx->acregmax != CIFS_DEF_ACTIMEO)) {
-			cifs_dbg(VFS, "actimeo ignored since acregmax or acdirmax specified\n");
+			cifs_errorf(fc, "actimeo ignored since acregmax or acdirmax specified\n");
 			break;
 		}
 		ctx->acdirmax = ctx->acregmax = HZ * result.uint_32;
@@ -983,7 +983,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		break;
 	case Opt_max_credits:
 		if (result.uint_32 < 20 || result.uint_32 > 60000) {
-			cifs_dbg(VFS, "%s: Invalid max_credits value\n",
+			cifs_errorf(fc, "%s: Invalid max_credits value\n",
 				 __func__);
 			goto cifs_parse_mount_err;
 		}
@@ -991,7 +991,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		break;
 	case Opt_max_channels:
 		if (result.uint_32 < 1 || result.uint_32 > CIFS_MAX_CHANNELS) {
-			cifs_dbg(VFS, "%s: Invalid max_channels value, needs to be 1-%d\n",
+			cifs_errorf(fc, "%s: Invalid max_channels value, needs to be 1-%d\n",
 				 __func__, CIFS_MAX_CHANNELS);
 			goto cifs_parse_mount_err;
 		}
@@ -1000,7 +1000,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	case Opt_handletimeout:
 		ctx->handle_timeout = result.uint_32;
 		if (ctx->handle_timeout > SMB3_MAX_HANDLE_TIMEOUT) {
-			cifs_dbg(VFS, "Invalid handle cache timeout, longer than 16 minutes\n");
+			cifs_errorf(fc, "Invalid handle cache timeout, longer than 16 minutes\n");
 			goto cifs_parse_mount_err;
 		}
 		break;
@@ -1011,23 +1011,23 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		case 0:
 			break;
 		case -ENOMEM:
-			cifs_dbg(VFS, "Unable to allocate memory for devname\n");
+			cifs_errorf(fc, "Unable to allocate memory for devname\n");
 			goto cifs_parse_mount_err;
 		case -EINVAL:
-			cifs_dbg(VFS, "Malformed UNC in devname\n");
+			cifs_errorf(fc, "Malformed UNC in devname\n");
 			goto cifs_parse_mount_err;
 		default:
-			cifs_dbg(VFS, "Unknown error parsing devname\n");
+			cifs_errorf(fc, "Unknown error parsing devname\n");
 			goto cifs_parse_mount_err;
 		}
 		ctx->source = kstrdup(param->string, GFP_KERNEL);
 		if (ctx->source == NULL) {
-			cifs_dbg(VFS, "OOM when copying UNC string\n");
+			cifs_errorf(fc, "OOM when copying UNC string\n");
 			goto cifs_parse_mount_err;
 		}
 		fc->source = kstrdup(param->string, GFP_KERNEL);
 		if (fc->source == NULL) {
-			cifs_dbg(VFS, "OOM when copying UNC string\n");
+			cifs_errorf(fc, "OOM when copying UNC string\n");
 			goto cifs_parse_mount_err;
 		}
 		break;
@@ -1047,7 +1047,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		}
 		ctx->username = kstrdup(param->string, GFP_KERNEL);
 		if (ctx->username == NULL) {
-			cifs_dbg(VFS, "OOM when copying username string\n");
+			cifs_errorf(fc, "OOM when copying username string\n");
 			goto cifs_parse_mount_err;
 		}
 		break;
@@ -1059,7 +1059,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 
 		ctx->password = kstrdup(param->string, GFP_KERNEL);
 		if (ctx->password == NULL) {
-			cifs_dbg(VFS, "OOM when copying password string\n");
+			cifs_errorf(fc, "OOM when copying password string\n");
 			goto cifs_parse_mount_err;
 		}
 		break;
@@ -1086,7 +1086,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		kfree(ctx->domainname);
 		ctx->domainname = kstrdup(param->string, GFP_KERNEL);
 		if (ctx->domainname == NULL) {
-			cifs_dbg(VFS, "OOM when copying domainname string\n");
+			cifs_errorf(fc, "OOM when copying domainname string\n");
 			goto cifs_parse_mount_err;
 		}
 		cifs_dbg(FYI, "Domain name set\n");
@@ -1110,7 +1110,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			kfree(ctx->iocharset);
 			ctx->iocharset = kstrdup(param->string, GFP_KERNEL);
 			if (ctx->iocharset == NULL) {
-				cifs_dbg(VFS, "OOM when copying iocharset string\n");
+				cifs_errorf(fc, "OOM when copying iocharset string\n");
 				goto cifs_parse_mount_err;
 			}
 		}
@@ -1190,7 +1190,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		break;
 	case Opt_witness:
 #ifndef CONFIG_CIFS_SWN_UPCALL
-		cifs_dbg(VFS, "Witness support needs CONFIG_CIFS_SWN_UPCALL config option\n");
+		cifs_errorf(fc, "Witness support needs CONFIG_CIFS_SWN_UPCALL config option\n");
 			goto cifs_parse_mount_err;
 #endif
 		ctx->witness = true;
@@ -1291,7 +1291,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		break;
 	case Opt_fsc:
 #ifndef CONFIG_CIFS_FSCACHE
-		cifs_dbg(VFS, "FS-Cache support needs CONFIG_CIFS_FSCACHE kernel config option set\n");
+		cifs_errorf(fc, "FS-Cache support needs CONFIG_CIFS_FSCACHE kernel config option set\n");
 		goto cifs_parse_mount_err;
 #endif
 		ctx->fsc = true;
@@ -1312,15 +1312,13 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		if (result.negated) {
 			ctx->nopersistent = true;
 			if (ctx->persistent) {
-				cifs_dbg(VFS,
-				  "persistenthandles mount options conflict\n");
+				cifs_errorf(fc, "persistenthandles mount options conflict\n");
 				goto cifs_parse_mount_err;
 			}
 		} else {
 			ctx->persistent = true;
 			if ((ctx->nopersistent) || (ctx->resilient)) {
-				cifs_dbg(VFS,
-				  "persistenthandles mount options conflict\n");
+				cifs_errorf(fc, "persistenthandles mount options conflict\n");
 				goto cifs_parse_mount_err;
 			}
 		}
@@ -1331,8 +1329,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		} else {
 			ctx->resilient = true;
 			if (ctx->persistent) {
-				cifs_dbg(VFS,
-				  "persistenthandles mount options conflict\n");
+				cifs_errorf(fc, "persistenthandles mount options conflict\n");
 				goto cifs_parse_mount_err;
 			}
 		}
-- 
2.30.0


From d21b179317b3f952efda97b50f5eb53c1dc269c5 Mon Sep 17 00:00:00 2001
From: Aurelien Aptel <aaptel@suse.com>
Date: Thu, 18 Mar 2021 13:52:59 +0100
Subject: [PATCH 4/4] cifs: export supported mount options via new mount_params
 /proc file

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/cifs_debug.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 88a7958170ee..4f7f0941dc99 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -17,6 +17,7 @@
 #include "cifsproto.h"
 #include "cifs_debug.h"
 #include "cifsfs.h"
+#include "fs_context.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
@@ -702,6 +703,7 @@ static const struct proc_ops cifs_lookup_cache_proc_ops;
 static const struct proc_ops traceSMB_proc_ops;
 static const struct proc_ops cifs_security_flags_proc_ops;
 static const struct proc_ops cifs_linux_ext_proc_ops;
+static const struct proc_ops cifs_mount_params_proc_ops;
 
 void
 cifs_proc_init(void)
@@ -726,6 +728,8 @@ cifs_proc_init(void)
 	proc_create("LookupCacheEnabled", 0644, proc_fs_cifs,
 		    &cifs_lookup_cache_proc_ops);
 
+	proc_create("mount_params", 0444, proc_fs_cifs, &cifs_mount_params_proc_ops);
+
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	proc_create("dfscache", 0644, proc_fs_cifs, &dfscache_proc_ops);
 #endif
@@ -764,6 +768,7 @@ cifs_proc_clean(void)
 	remove_proc_entry("SecurityFlags", proc_fs_cifs);
 	remove_proc_entry("LinuxExtensionsEnabled", proc_fs_cifs);
 	remove_proc_entry("LookupCacheEnabled", proc_fs_cifs);
+	remove_proc_entry("mount_params", proc_fs_cifs);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	remove_proc_entry("dfscache", proc_fs_cifs);
@@ -1023,6 +1028,51 @@ static const struct proc_ops cifs_security_flags_proc_ops = {
 	.proc_release	= single_release,
 	.proc_write	= cifs_security_flags_proc_write,
 };
+
+static int cifs_mount_params_proc_show(struct seq_file *m, void *v)
+{
+	const struct fs_parameter_spec *p;
+	const char *type;
+
+	for (p = smb3_fs_parameters; p->name; p++) {
+		/* cannot use switch with pointers... */
+		if (!p->type) {
+			if (p->flags == fs_param_neg_with_no)
+				type = "noflag";
+			else
+				type = "flag";
+		}
+		else if (p->type == fs_param_is_bool)
+			type = "bool";
+		else if (p->type == fs_param_is_u32)
+			type = "u32";
+		else if (p->type == fs_param_is_u64)
+			type = "u64";
+		else if (p->type == fs_param_is_string)
+			type = "string";
+		else
+			type = "unknown";
+
+		seq_printf(m, "%s:%s\n", p->name, type);
+	}
+
+	return 0;
+}
+
+static int cifs_mount_params_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cifs_mount_params_proc_show, NULL);
+}
+
+static const struct proc_ops cifs_mount_params_proc_ops = {
+	.proc_open	= cifs_mount_params_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	/* No need for write for now */
+	/* .proc_write	= cifs_mount_params_proc_write, */
+};
+
 #else
 inline void cifs_proc_init(void)
 {
-- 
2.30.0


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

--=-=-=--

