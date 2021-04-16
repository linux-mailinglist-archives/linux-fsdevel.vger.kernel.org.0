Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F84361724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 03:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhDPBRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 21:17:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52742 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhDPBRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 21:17:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13G1AfO4100527;
        Fri, 16 Apr 2021 01:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=l7iEKidx9hZVLm1ttjC/aUKrug5K2rre1ZmlplRmM3k=;
 b=kaHV6IotN6y5/JBXQ8QJK1RtMiSZ8BG1uW5zgLfvpPEM3xrlZB29i0bp7N4ognB7phFg
 XBZO9K7BhE/jiuJ94z8OGByl/YHOTI2lPqfsQwP0solvHKDzxeVWlwlpnMicNnlSsF+f
 rSUI8vtddEqt177TxAChnLzdKIV112pXUaorKQdRRzK+ukcAwSeD4vEM3oUrExCVRFdB
 iFB2CzhfSYr5cF3Q/dh3OWWul6TIOK+cDVyt5HiqoKa/n2Klgss7/0ZfDiQRj5MKhYqO
 c2ePXjv4IX1PqmlryCizdMqaz5Dp3/lFrQlB2hQV9JERvweTQJP4K+x0rHhargbZ5EwQ cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbqqh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 01:16:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13G1EdCW054129;
        Fri, 16 Apr 2021 01:16:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 37unktdua5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 01:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMs30wH9cPE06zIM4onRlmLzDzxWIXB+EoJyX9RtS2bwil7AA484G1n5tYzsiyUDLfr6qDMAjsYM7fdhCAcPcqAnvsNPON2mka1Areycw243l2Mg2q48JUiHczfAPXY3BH1cYFZH3f82NZmtPaCvFrtT37TI2pUH7tY18uszZdntzkdUK5Nk1GQeTc+W6kJei1zc4IGEvi+RgT1wZNoVEXf/zOkmvP11BERc6f6RFT//HmcA5oUSX/HxZS1LPHb5U1LSXKFTbdf5lv9vtRgvACBz9rzAImB585zZ8h0xqpAg5JHXNg9WZdCbrK09qkM8YmXQAsSN8vu0cG1wsK83tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7iEKidx9hZVLm1ttjC/aUKrug5K2rre1ZmlplRmM3k=;
 b=hOCj0xLJgmXItP2w5cYQGA+htSrC5KlQna5I1DA9XvALek5EM56K+lDKDJ5Ixe+7x45qFgRgR+vMq71J07PG/BsiFhNuDf/RxSO+m0IQKGMsXs/7LKDZ7+w1kSBqICbxuv+stZB77+bV9XjNM8eqRmCM/aa2Rse73XOB5vcVcdMDUSL9YdZBqE2rcvcp93/ThEPzxwmdf0wrsJXzKNFEL2hjtGNuf2HThlXm9/adTSA/ZnPc1df/90YhT4EISZC9KXIT+rSmis7i4vtbCxdRG1npgRvQ8HyuJ+6zMEO/KCweXJ8ZSG2U5AYcntSQwGcD6hL+MFlicGR1QZgDorj7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7iEKidx9hZVLm1ttjC/aUKrug5K2rre1ZmlplRmM3k=;
 b=kKjcHaNC5BJu80C5l7q01obEiMcuDv3GPXl7ChB+Eoki6tNqUR5YKip11BqgIwxYmMKCEdk3438hay6dRUPLUm01qOB9oKmd3DFdKYXYz5bi/SShp9P1U7HwN4kzplTOLMaLV+QR8KaDyxCSlY47pWbC7ghOza5xU9WLEeKvEhk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4733.namprd10.prod.outlook.com (2603:10b6:a03:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 16 Apr
 2021 01:16:39 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::e83b:92af:c9d7:2fe9]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::e83b:92af:c9d7:2fe9%7]) with mapi id 15.20.4020.022; Fri, 16 Apr 2021
 01:16:39 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH RESEND v5] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Thu, 15 Apr 2021 18:16:38 -0700
Message-Id: <20210416011638.183862-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1041::11]
X-ClientProxiedBy: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8301:1041::11) by BYAPR02CA0026.namprd02.prod.outlook.com (2603:10b6:a02:ee::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Fri, 16 Apr 2021 01:16:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4640c57c-3254-497d-3ebf-08d90075492f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB473302C25B2FC59655B76773DB4C9@SJ0PR10MB4733.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fp8KGZ0FEeMAMgn8r9yJtzyM/DxigrtFOrzGbcQxountWmDiOBTXkq1mwGDL?=
 =?us-ascii?Q?VM4fgPSmR8kI5e52HEW6ZdwmUvPN3fcDcKwH9ywDinPnJsHPM3LiCTAoEw2u?=
 =?us-ascii?Q?wJ7PUASQxpY8rOxn0xpJVfDTp0/PDXavsNYN3tcsGVUhrHrMVCmFJbspscaY?=
 =?us-ascii?Q?xecaSoBFZCz1Xtd+4EUwrtBdEjbDUkN4Zaoh/L4pJdC+OOpkrdl9DzSmaHCI?=
 =?us-ascii?Q?Sjrf2hXhtzyukkr90jfH9LpDlMb7fcgbB9WNeDJQDvAfzk8bVEpz33VHahCO?=
 =?us-ascii?Q?j9aAAae83LIDD+JJ8kBAU3QqLskVA0yV7sGSIj3rheWcV784f2BR9F85864g?=
 =?us-ascii?Q?ZUju0KIozOGmWA1wQhQFr7U/3zgqBa/a+cGt7fkppcXGihLGXMB96UYQrcQJ?=
 =?us-ascii?Q?YS/ArQLVp2EcgzUfOIvsJAHaW7z0T1NIDsswxh1xRXr5y3K/FDbFJX17TRtU?=
 =?us-ascii?Q?8j5a/PwMxscNs9QcV25qZfZciuxvDcYZwRkGhs6VDI+1Lpd08mPAOdn+SKJM?=
 =?us-ascii?Q?V8vHKMWVjJhagMPG3jzukK/nonGXTLOb2O3YItbA/lHKpIgZF0RWISoI91KR?=
 =?us-ascii?Q?JhCQPc+BJ+IFpIhytOJ7EibI5uCZeiJmgjrrS1A8MmuSox/ifg2YUcRf/pWF?=
 =?us-ascii?Q?BmGhsjzP5ix6O4kMSy7Nlg+3MmcAe2BR6XPCYZD2oc34gxRk4PZ2upW1bo7E?=
 =?us-ascii?Q?1Sl2J+5rVjXm9+Cok83i/2kGUGaLfiJU165vNKl4YxHQ4PTRGt1UPkPsBqA4?=
 =?us-ascii?Q?JyOrhqdfhe/6Rzed73H16ITmDuHBuhTQz89hYK/UOsMwcrM+auPIJHfQCWWN?=
 =?us-ascii?Q?FUPSiD4VIxI7e6C7vKqO1DnbAirH+iup3+fNk3YUvUEhPz4BW+h82LP+VXiG?=
 =?us-ascii?Q?UZk//M6Jm5aKZJgfmThm+MMHUAO+s+NM75H/894Rkw4ezKzQA6NaJqeDNq2f?=
 =?us-ascii?Q?IqKq16bkZQGK1GxHYRLXgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(66476007)(83380400001)(2616005)(16526019)(66556008)(7416002)(2906002)(6486002)(103116003)(8936002)(6916009)(52116002)(6496006)(66946007)(5660300002)(86362001)(4326008)(1076003)(316002)(508600001)(8676002)(36756003)(186003)(38100700002)(54906003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pn7DX1aMS+SVJFLep3dI4aPMeERDP7zmPchUXpeMG6NTOqY0QMlXkjpVG7Ad?=
 =?us-ascii?Q?tAGfXkzGnUWR8g3/CJ+klnGwR7O+4t7UqL46s5eg97hlJSSan1aMXGvfDNaa?=
 =?us-ascii?Q?z7iBaAfTMBtrIE9stJg1lXMSDjSO6K1IvcXBvWu4/fGcYAkKfras7JGzT7n9?=
 =?us-ascii?Q?EdFHWRAzpgrT3MQvZsftYbBsTqC3pIJF16KFvHCtyBvThF2kAUIEG2w2Q4aQ?=
 =?us-ascii?Q?2HUriQGJ3CrkjE0CKShBdBjRGTDYxCsyhzkiLOYZbrHxoK0NRzFtsZaXABJS?=
 =?us-ascii?Q?6qzEvIGA1QuIF3zUI5xAlPRf6uOsfggny1sAW8OfyVFZ4qlMlOKVQTqKmkNg?=
 =?us-ascii?Q?OqEJoNmMuRzF6XafuixZoiCbJsJIRBns8rga+1150D1BK5FLxQzt/iiJgpou?=
 =?us-ascii?Q?9/hDyDxk+Vmdoi/YRpCZ0zfoZ0X6tHsZJmniJyH5cq1mMbBwh2F82TtSBUg6?=
 =?us-ascii?Q?CmBJCYI+HPT27mcdU1tUUyLL7wXAqZHIPNCGI5D3AWLX9FDKbcSnO+DVv4oS?=
 =?us-ascii?Q?ETFwOxVQSFLtBcGsBLSxLOnvU2PTpUCG9frkr0BNbQnHDZ/+3k1+BDZ1HK6e?=
 =?us-ascii?Q?TlKwQEAkKr0sZ2Lk5m72bmMQ3izGJrFy6MnZnHFeAPpX5btV7XPDgqP+EQAC?=
 =?us-ascii?Q?wijnf9UlhuxcjR5O7LD1GbjHV8XMPCpGtcUbl5oBsEdlb4W6ZljzF+ZnS1Ol?=
 =?us-ascii?Q?tip4jWCajOaJXMDu5QLmdpMfxdEROCbCIlZ0WsyRwHTaXRCkoyCbXmJ1IkPj?=
 =?us-ascii?Q?4QRkZAH+kh1KSVaWJtFmNbAfOdv+JqmEm+A87996lCJFW0FtaU7mOHdjHDuZ?=
 =?us-ascii?Q?kzaXpjsLUr0lA1oDSaa6n9ANxKxQwK9tGNPhCdDQB150Xdc3xZBeVhRi8Qm/?=
 =?us-ascii?Q?S7ZANXrVjMZSwzGX3761JkEEAXoy5qEUJPRnO0EJ6JxSK5tcEIluZAbRykmi?=
 =?us-ascii?Q?PTkyxDa5dog5fmDQFDkRMNMEYOYNZUN+hhoFeosvcZ0OxZVCzHIr24YgKQkK?=
 =?us-ascii?Q?L2l5kjGXp0Cbzo66vtAK5aN9yGvgl3cSv/eKJbYbXfWDMZv9dBAQBu9uM2eC?=
 =?us-ascii?Q?0qAtFx/u5rZJBmgggto+7mvyEYydjYbnBGIt+0SEsp7XuYAYGP/X3uTtYnq+?=
 =?us-ascii?Q?nimDAfEXuBLENAaOU9xFxHah8VRZBSnLVXBbRRhceJ0gXURxSKwrGWl0LaqM?=
 =?us-ascii?Q?7XBCa98TZt32XXGl/Dte6JB6eQu5utuhVXakqqVqylEo49bZz7S/sRNzVZgR?=
 =?us-ascii?Q?DPmyn20eeCg8cBepA/wMehr/TGKGhBKJwQNH65gvR5bavyfwIKHmfuxBH2T4?=
 =?us-ascii?Q?BPnIJDwBXvFb10riB1E4E6v+Ny/TxVDjbxpZCq8Y6f0Efw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4640c57c-3254-497d-3ebf-08d90075492f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 01:16:39.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk4Smc9qv1AXbkLdU9o2ZoN4Vg8RVFF16rw7AoMudf8pruR8YEks5PcYyGaqC/Dm2OJRRXxe44JzDxpv2i38eQawvrBEKKztRXrQqEr0W7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4733
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160008
X-Proofpoint-GUID: DQdsJvmCrP34HJt_3qlTcACmE76Qub9U
X-Proofpoint-ORIG-GUID: DQdsJvmCrP34HJt_3qlTcACmE76Qub9U
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160007
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pid_revalidate() function drops from RCU into REF lookup mode. When
many threads are resolving paths within /proc in parallel, this can
result in heavy spinlock contention on d_lockref as each thread tries to
grab a reference to the /proc dentry (and drop it shortly thereafter).

Investigation indicates that it is not necessary to drop RCU in
pid_revalidate(), as no RCU data is modified and the function never
sleeps. So, remove the LOOKUP_RCU check.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Resending this in the hopes of Al picking this up, or else more feedback about
how to test for RCU-unsafe code in procfs.

When running running ~128 parallel instances of "TZ=/etc/localtime ps -fe
>/dev/null" on a 128CPU machine, the %sys utilization reaches 97%, and perf
shows the following code path as being responsible for heavy contention on
the d_lockref spinlock:

      walk_component()
        lookup_fast()
          d_revalidate()
            pid_revalidate() // returns -ECHILD
          unlazy_child()
            lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention

By applying this patch, %sys utilization falls to around 85% under the same
workload, and the number of ps processes executed per unit time increases by
3x-4x. Although this particular workload is a bit contrived, we have seen some
monitoring scripts which produced similarly high %sys time due to this
contention.

As a result this patch, several procfs methods which were only called in
ref-walk mode could now be called from RCU mode. To ensure that this patch
is safe, I audited all the inode get_link and permission() implementations,
as well as dentry d_revalidate() implementations, in fs/proc. These methods
are called in the following ways:

* get_link() receives a NULL dentry pointer when called in RCU mode.
* permission() receives MAY_NOT_BLOCK in the mode parameter when called
  from RCU.
* d_revalidate() receives LOOKUP_RCU in flags.

There were generally three groups I found. Group (1) are functions which
contain a check at the top of the function and return -ECHILD, and so
appear to be trivially RCU safe (although this is by dropping out of RCU
completely). Group (2) are functions which have no explicit check, but
on my audit, I was confident that there were no sleeping function calls,
and thus were RCU safe as is. However, I would appreciate any additional
review if possible. Group (3) are functions which call security hooks, but
which ought to be safe (especially after Al's commits: 23d8f5b684fc ("make
dump_common_audit_data() safe to be called from RCU pathwalk") and 2
previous).

Group (1):
 proc_ns_get_link()
 proc_pid_get_link()
 map_files_d_revalidate()
 proc_misc_d_revalidate()
 tid_fd_revalidate()

Group (2):
 proc_get_link()
 proc_self_get_link()
 proc_thread_self_get_link()
 proc_fd_permission()

Group (3):
 pid_revalidate()            -- addressed by my patch,
                                calls security_task_to_inode()
 proc_pid_permission()       -- calls security_ptrace_access_check()
 proc_map_files_get_link()   -- calls security_capable()

I've tested this patch by enabling CONFIG_PROVE_RCU to warn on sleeping during
RCU, and running heavy procfs-related workloads (like the PS one described
above). I would love more input on selinux/audit rules to explore to attempt to
catch any other potential issues.

Changes in v5:
- Al's commits are now in linux-next, resolving proc_pid_permission() issue.
- Add NULL check after d_inode_rcu(dentry), because inode may become NULL if
  we do not hold a reference.
Changes in v4:
- Simplify by unconditionally calling pid_update_inode() from pid_revalidate,
  and removing the LOOKUP_RCU check.
Changes in v3:
- Rather than call pid_update_inode() with flags, create
  proc_inode_needs_update() to determine whether the call can be skipped.
- Restore the call to the security hook
Changes in v2:
- Remove get_pid_task_rcu_user() and get_proc_task_rcu(), since they were
  unnecessary.
- Remove the call to security_task_to_inode().

 fs/proc/base.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..3e105bd05801 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1830,19 +1830,21 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
 	struct task_struct *task;
+	int ret = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	inode = d_inode(dentry);
-	task = get_proc_task(inode);
+	rcu_read_lock();
+	inode = d_inode_rcu(dentry);
+	if (!inode)
+		goto out;
+	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 
 	if (task) {
 		pid_update_inode(task, inode);
-		put_task_struct(task);
-		return 1;
+		ret = 1;
 	}
-	return 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static inline bool proc_inode_is_dead(struct inode *inode)
-- 
2.27.0

