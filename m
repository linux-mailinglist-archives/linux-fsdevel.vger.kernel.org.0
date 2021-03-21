Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01123433A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Mar 2021 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCURMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 13:12:00 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:49706 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhCURLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 13:11:31 -0400
X-Greylist: delayed 4524 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 13:11:30 EDT
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12LFraIS010674;
        Sun, 21 Mar 2021 15:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=+pbRlGcHhxx3pb4Yy838iYSd1h/NXXn3hVyRr2dwuKc=;
 b=TeVJYB/74MwQVCo1d10QE0yQEOX37M6WlYVNAqe0id8zm2Jca2JRbmp01fpa01TdalcO
 vl46TnWVa7FlmtkzwZ2GQyhIizpHXn8eCZ7vUxoY7fL7+RthZOygT7KLEAFdCsMh+jvI
 0YRO9yYCEz97LSxb5qe3I9cnEFe+gRm3zME/2k0NqmtEjpt9kQ/+o00sdEFfX16TzuMi
 jyCxI1V+GTsVqLQ+9567VA77S+5a5cfvYC2FiuSGv2ugxaNwhf8o3eO6qhU+ONwXCiis
 SKWvg0OdIgKWnEY+Gxh2zU/hHFKx01cp6Aeda6saEhQfvmjK/ndlq5JBkKjYbCLdus7Z NA== 
Received: from jpn01-ty1-obe.outbound.protection.outlook.com (mail-ty1jpn01lp2059.outbound.protection.outlook.com [104.47.93.59])
        by mx08-001d1705.pphosted.com with ESMTP id 37e7nu82r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Mar 2021 15:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyzIgGeKKhvYZgBRNk0Dqfs2i7xOVeUCwPueob8jibA0LYzH7+9Df3fFlBv8WCFucTk1Q4aV2n8BQAFYsHpmBeB8l3oKc3gr3CSPb7n07yVlcuTRep/uJWccZw4Yfp6KGvm0qSIDd4J99DhUqYEQD7cikAnegeg3EAtSY8/OIA0+qlwX2KxLNQ4D0MjPEDgIH65tq6/OB7RVjB906ZGL67lCUjJpthlJtQ+bV9iT7qM3izREBAxJmR4jChHRw7Z6YnYEykmgzEghVbb8noTkK3Wj+bxEg1y+4evotwovJjbQEfsK7rMX699mQsTvW87qAJcrPv2DuQBA1WN2L6KZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pbRlGcHhxx3pb4Yy838iYSd1h/NXXn3hVyRr2dwuKc=;
 b=gfaMqbyzN1lQ5SSvoUc9SmtYijGIAX3y2Yw5rOwyqNAvcnFVUYFJkqDFp0fbPi9wnJy29k0UxHffgHEspfNtIUd1tGFm5g2VFt0n6NHbnCbqzhxUNIfJOdYDjEwDSfSQcHka/2ugCPAh9cHmXGbCLQX/7m5Dcf5mI87ZS6osYMzE0oOXbukD8O8U3+c2tOwCNudnQFKL+gUhSax43kl5iudSYuMeA+if7/2RAQ5LbGaC6wsuZutxWx2KNrkFGRnnw3pEr/n08zjdEemtu5KOSu7gm3l/sxMjv6bthUjnQ0XrTij0GsMX+lAJ5GOqaqeRr9QmNBfZ0wWQ3QFf8Ctn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSBPR01MB2677.jpnprd01.prod.outlook.com (2603:1096:604:11::9)
 by OS0PR01MB6065.jpnprd01.prod.outlook.com (2603:1096:604:c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 15:52:19 +0000
Received: from OSBPR01MB2677.jpnprd01.prod.outlook.com
 ([fe80::c5a7:f695:6ec8:7230]) by OSBPR01MB2677.jpnprd01.prod.outlook.com
 ([fe80::c5a7:f695:6ec8:7230%5]) with mapi id 15.20.3955.024; Sun, 21 Mar 2021
 15:52:19 +0000
From:   <Kenta.Tada@sony.com>
To:     <keescook@chromium.org>, <containers@lists.linux-foundation.org>
CC:     <adobriyan@gmail.com>, <luto@amacapital.net>, <wad@chromium.org>,
        <peterz@infradead.org>, <christian.brauner@ubuntu.com>,
        <avagin@gmail.com>, <gladkov.alexey@gmail.com>,
        <amistry@google.com>, <michael.weiss@aisec.fraunhofer.de>,
        <ebiederm@xmission.com>, <paulmck@kernel.org>, <shorne@gmail.com>,
        <samitolvanen@google.com>, <elver@google.com>, <axboe@kernel.dk>,
        <rostedt@goodmis.org>, <a.darwish@linutronix.de>,
        <rppt@kernel.org>, <andreyknvl@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <Kenta.Tada@sony.com>
Subject: [PATCH] seccomp: fix the cond to report loaded filters
Thread-Topic: [PATCH] seccomp: fix the cond to report loaded filters
Thread-Index: AdceaTSjtgc4FMvhQDm1OTTih2ZC7w==
Date:   Sun, 21 Mar 2021 15:52:19 +0000
Message-ID: <OSBPR01MB26772D245E2CF4F26B76A989F5669@OSBPR01MB2677.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [211.125.130.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d6eac84-68f1-4e8a-d8c9-08d8ec814f20
x-ms-traffictypediagnostic: OS0PR01MB6065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB6065C313B103F29C3D3D2DACF5669@OS0PR01MB6065.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9MXJ9ap9f/Kwin7wKyuDug3VB3Oi3y9ljzCh7fH/dklO0LuTJ8WQrL2hWn2wmyK+2NXzXVWuqwc9rMvLNrxa4vhSARNim57r+QpPM/Q+r1Eo14E0st2r23CtQbZAhLKIlN+c/8Pzh9HioqNSLDJUiyao8bTPrMlY/IY6qV/9fIFr5DRqfsMsIUAKcA4dgO2/JiqmxjR0IhmVaCANq6iDaLS/tuFET2Fn5esdhe2VUMyLdDbqywtsyuwn27UbnYc16j2JY0MT5MPxEw62t7y30W40XaqQc1wjBhVIm+mz0RTU1dDi3g9UDj26OQL24ofbHJgEIMweZpapQS+wDhpB5BuVOznNtFwB1jcc62adrEr/WZiqYxvnVZ64jGyV3XnD41Z9yrLjNiHGvSlRpdKXPufu7tChO33wpky5HwRTkC28xczQQt2RV8w4y1Wobb+c+50T22lKX4yvkyZLD+uWvWyMjocD4hXnP9jSrDJcp9mfG3uzTD7orB+rkoa4GewH6EsriYBJJLlGh+LzD3iVBg4f6aP4+9Ebc0I2p+IQBCGOLoYQmir8UMdxQFRPIIrZ2AaYJlyJafseuQy/h8yGqw37JEcz7XpIRcax85xTq/MvpDZrteWkxzRdVHBE09Xe18+nXszEVmjudSg8U7GmbJCOgbzREfjZdDXphZdkyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2677.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(66946007)(316002)(54906003)(110136005)(52536014)(33656002)(71200400001)(2906002)(66476007)(83380400001)(76116006)(64756008)(478600001)(66556008)(66446008)(5660300002)(4326008)(26005)(7696005)(8676002)(6506007)(55016002)(38100700001)(107886003)(86362001)(9686003)(186003)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cNpMfHVNSC6vmhYT7MMbDZAKUFXsV7tIH7ZdB+DSXFLCc46yejaBH8MLeovY?=
 =?us-ascii?Q?Khyv+imOf4jFZBJNf4tUWu4s8ZNNdS26pjGjFMAKiWZrEHrWoVuiCQKcXfwR?=
 =?us-ascii?Q?k0P/IMwRTbccnkZD+SYLlUI210Ve4kWAJGxSkSOiUFlaCF90KzTgzJ+FM7TF?=
 =?us-ascii?Q?F7O/DQFjOpk3ByQf4LgEjcGS9xt2+kTAufExySeRZgm+wg5iiAa+rLYAKPpE?=
 =?us-ascii?Q?0xWMkRIs61cIY1iP8BTkQpuq+KFF03Kgp3B2706d6FZYtjvxuS+7nQaGsFEE?=
 =?us-ascii?Q?9dhKLb86doFyYhHv7Yx0fSPhP3frry7ObE2ZBXqCU1U6Qz1KgruOa7BWIcQZ?=
 =?us-ascii?Q?0pzHMQkzqB95YrX51Rf+8NsIIEeQSYSiC+myDxEgNAT6S9w+UV1R+oFfQ9m+?=
 =?us-ascii?Q?c5RzPDKUoXx0d3ooC6WHvZRw44T9MviS2HDa2juQdnZoIyYIOPKYn7ntoDmH?=
 =?us-ascii?Q?RXzkJEEyCdCU8l+xuJGjXk/+/GSl8ZF7tvfCbGqxZ1Pr90qdwQKs3Zg1FOXb?=
 =?us-ascii?Q?40yogc2Styy4u53PLMt/kwjXGZsw95q+14E+a12tvE08n8h02x6lM+/WWqah?=
 =?us-ascii?Q?h3xXQPZ0dkEGGTk+9FYPa3Nj9donmwW17CAZ/7LqMXWBehnTaW7kuG7xigXU?=
 =?us-ascii?Q?Tu5MOJJ3t3IcohUpgqiTFeAxHpy1srA2oVegv6inCzyik3y1KI3IYCr3CZkF?=
 =?us-ascii?Q?JQGqwWTGQwIt27IjA1ZbiaoikiX7efnO7oWC2ZY2uq/pPhH+mJ+TMI55/mpO?=
 =?us-ascii?Q?2xaE81Xe1naQRTdODxDmSrN4pIa6EU6X1OubOe+7RS7/KZwCyVmx8e00CTXJ?=
 =?us-ascii?Q?9plbA8wpMekejIvw7Xp0iNnjSaBxnigeEoap/tFvTpzc4HSxBCps6WDTlEtd?=
 =?us-ascii?Q?t2BMLG8vMmTeeWnzhTwbkuPj9HYgifxKTRhkxXQWwxRTeDZdkbpwN+XtzYrH?=
 =?us-ascii?Q?ED3p8ECZqDETHB8bwJz4hjFwAa5rrYQkNdh45aBBgJnFfrKZ8z4ME97inkrz?=
 =?us-ascii?Q?xmyzo61HsH5K9JzgTjhTRYI0udrv65u/4jmQt1x+5d9u6J65NBDTHJ/nTFEw?=
 =?us-ascii?Q?g3CZGeHgcplKRWOCs+zytOUtKPpomXZCIar2CtwvIHgYUJ72qV0IElvGbqmT?=
 =?us-ascii?Q?mjGQkD2SD0Ft8J1WGUYvTa5Fx+SxSsaLkeqJhAgqK3gQ8Z7pdkoj8sQUZ55l?=
 =?us-ascii?Q?8pZjTH+sgbG1h4neeiZcxKEvlvbf905pgoZKGGn8e0QQGmmJ2hyuib/6moAj?=
 =?us-ascii?Q?GWThCL2p6JbDgHxK8yc83X1rpItPQey2CFWCjZL0U8WP0geDwP+FPvrmYgSk?=
 =?us-ascii?Q?2S/VrtGs0uOkmlZ6nNxYlUzM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2677.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6eac84-68f1-4e8a-d8c9-08d8ec814f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2021 15:52:19.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsgZvaCQSUmxMp0u5FADjbeVscPEV87mz2fLFA8j1lTrj+FWxuLymUt23Gwnh3TkDKOth13PHMGKOaEYnAjDQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6065
X-Sony-Outbound-GUID: iFlVyKwA_NI9Mg2q1djFDWGnevLqXCnn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-21_02:2021-03-19,2021-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Strictly speaking, seccomp filters are only used
when CONFIG_SECCOMP_FILTER.
This patch fixes the condition to enable "Seccomp_filters"
in /proc/$pid/status.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 fs/proc/array.c  | 2 ++
 init/init_task.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index bb87e4d89cd8..7ec59171f197 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -342,8 +342,10 @@ static inline void task_seccomp(struct seq_file *m, st=
ruct task_struct *p)
 	seq_put_decimal_ull(m, "NoNewPrivs:\t", task_no_new_privs(p));
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
+#ifdef CONFIG_SECCOMP_FILTER
 	seq_put_decimal_ull(m, "\nSeccomp_filters:\t",
 			    atomic_read(&p->seccomp.filter_count));
+#endif
 #endif
 	seq_puts(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
diff --git a/init/init_task.c b/init/init_task.c
index 3711cdaafed2..8b08c2e19cbb 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -210,7 +210,7 @@ struct task_struct init_task
 #ifdef CONFIG_SECURITY
 	.security	=3D NULL,
 #endif
-#ifdef CONFIG_SECCOMP
+#ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	=3D { .filter_count =3D ATOMIC_INIT(0) },
 #endif
 };
--=20
2.25.1
