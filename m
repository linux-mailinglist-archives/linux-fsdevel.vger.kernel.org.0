Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AA3D0F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhGUMNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 08:13:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24194 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233929AbhGUMNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:13:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LCohTp025265;
        Wed, 21 Jul 2021 12:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=vVf+pvyEQrKwlFnOiiZ+iKcqUz0RuR3V0ig7u8abU7E=;
 b=on9t5AodgjZd/kN1Ty5RFv3n0e/wFKAiJ4ggq0ttxRhyqSxts7t409fLHdU6fBVA0YI9
 7Dr2AtoGHbc9MR0wgIuOzva7aQEhI2P8x6Oa3LGSoJfLE7Pe+91Nr0ivQFJCRWlkPcZ0
 bJnRprmLkee6QHDFxyEyOkxS+pZI46tY2oh5wFekqVEbYzwsSK4Uscq7QHG0tk47XN3a
 c+9lUgeAXDYcwJqgH2TDwebJa9roMNJxrI3o9Xl81sqQvyWesErd9OcSkypZp/g0XMAI
 NPVD+UxUzXEZXdOX6QK9y0YHGXBlEgilYvyNlMZGw9FIeWabGnGg4OwztidyJcQB95// cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=vVf+pvyEQrKwlFnOiiZ+iKcqUz0RuR3V0ig7u8abU7E=;
 b=raKSFbVvYzgEfuNaKfFPbFzMofp1v5RBCPwdCCCCkE07fqUxEqnWIFasGmZHmsfi8Pt/
 UeF7e+LS/wSBWGQeoCHpzMXW1fkWSlN4WrQb4QMsXUNr/cWvxHKj7hSX5j/bitQdtl4u
 vN/jTHq8vfwEhqs2KV9LUz3GWzatNfjf4VvmTdrLjfzmIp5PtchXCAtS8Wnlfg/eVfct
 ZMf5pD6Dtyi3E62IoAmiG0BEdHRyjdWMUYea20PGHVS6FIl5PBsjCFL0m3wlMZzxXh6y
 vdWRerX7fSTb81bbSrMASIwexXnicLO6S17sycBYlex47S7BYyrc97WUZmDS6Q9l02AV sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wwmttnrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 12:54:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LCpAB1019517;
        Wed, 21 Jul 2021 12:54:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 39uq195bbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 12:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilVTaMuuvDEyY8RqGGn0VfUccpmfFFeOFzLmwK8Kchh5UmGWsG+zmSfpTJ7yzgyQEdBojjat7DuX6izVGufLJp0heQz49+ciJvlm1PBw3HZFG2Zu+lKqctRMgQTO8ujigCdzHI4SQsBQFHO1RE+fVfn1ymNx1lyMCK2OMiVXdBCW1Emu9RYjATpSOEVPlIx6Pn5gESLM4RNpI+Enb+qDg4WiqvN4GEiF4Jv096L/tx9lRn82+60Q8dgRdhR4ywSoJsSoHY5SVEL09SjS9MGxXBPb305YGmo0O/aLGyMGdPtpX+AaZrwdwsLNVcR0CMW9hkftQDiochx/dDAVUz/xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVf+pvyEQrKwlFnOiiZ+iKcqUz0RuR3V0ig7u8abU7E=;
 b=COPA3xUYWOtQTMGkvArzp17D2/T2nR1tzS7jK+Ze0/9YG6ycIAIabx1Avrl0vAKHred4F3r473pVYSQF2a9ttO5tSxloCfzKCxtVxcfXzp9sf3rXRHxFwPrTkvshq2MwsvH2J88Scx+c4geomeCd9XnchkfN+e65uHJmc7AprbLtDldAxgDJyNQ758vGHiDOTlgGCjA/+7b821qXKIWEk0/ZIWx2uSNwomKdHUpdqZ7eiLQGz538FPBa1YrCM5F+HsJFZo+erwedPZtOJcEnSQtjQQb88RvNoTLy3wJToY0gnrCUaIq9a2RQMKxcwNaMp93YkqVwTvsJroZEOIy6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVf+pvyEQrKwlFnOiiZ+iKcqUz0RuR3V0ig7u8abU7E=;
 b=Vi7mdW90Of1NxGQAc+aGALPkIy8f4QyFE0P3SIlB8OYPacAv00Nj4Xvb+UvwNuTIJS31SH65HciEcFcSqVGSBE8RI+zRNDnUS1jaaj+lZrKpYBYsYM9+OFfmPLLsmZ9tAalPZ3n8zN1bdV+vCYLP1PdlG0dsyH8V71GTQznTZvs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4626.namprd10.prod.outlook.com
 (2603:10b6:303:9f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 12:54:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 12:54:19 +0000
Date:   Wed, 21 Jul 2021 05:54:07 -0700
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     repnop@google.com
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: [bug report] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <20210721125407.GA25822@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 12:54:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa195c6-b488-48b3-4fcb-08d94c46a792
X-MS-TrafficTypeDiagnostic: CO1PR10MB4626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46261D60A24A5CC934E232E78EE39@CO1PR10MB4626.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMZFEKCdbMxFouGlaEKIJZ2N4zgNu+9TiPM+8Caig+zGggIiAuRaPf6tIvuPWWr/cLoJYMTlH0PrKCsKViuTk69YNZT779PdQyaGhsP083NNXCZg4JiCsI5vOqruMTPT1bnd2uJVXE9HpzzfgN25ONDSojG1QjmDxYiiDvyqkrkJtZ81L2DyDK0/3zZKzjKSE+EWO+tKCqPQYS7QY0GSmP51J9j2UxlGdntMkGrX9Kqp2I5jNB8V2hI+/xNGArHSL4ewlGkLyij7UPjgg1UEgTY35fS480OR+KHTHlmdqHXtTNrHT+9XW5HYz57oifIIQNaVS6BVb1QqC9GU7SKjYqQLJtMKyLbaeT8EiAKvTKcFRn1vcMdh/0GFMYPpR2t+fxERHw/QV/b3bYcdjj+NZKI5v6Y4nBTsfWxt8SM+RidOyuuxdg+qkAk9YnBiDdTTGGjpXQwZZ3ZO4U8dL55/jKDp3fZULxftkkV/pl5lX81mdV5bygjXDHcB56oWGcG0giWlNqMfQY5xUnDPv0yBi3Vuho6ButuVyJ4XrIHKccOHk1FtSu9sW9YSGDosJeXmuf+OMiH+oI4JSmKdUeAFgRPNTF7BJi70L/ioX7z9L0D6y/vANiLzBRKAPPZ6se9Rxhod3tSkIX6NFHgOaGII2hLoPq8ExkHJkvUqex7vGOmRV2okDpKNeSnRvVql/6KzrAoRNLm+MdiaQU0GfLnGyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39860400002)(33656002)(478600001)(6666004)(38100700002)(316002)(33716001)(956004)(1076003)(6496006)(5660300002)(86362001)(52116002)(4326008)(8676002)(9686003)(55016002)(186003)(2906002)(66946007)(83380400001)(8936002)(66476007)(44832011)(38350700002)(66556008)(6916009)(26005)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZIcyQRocg2Rvcpwv+7lRCmc+KTuYDL0tdYfq7lHWVfcZIVp2MxqpbrGn0k4?=
 =?us-ascii?Q?cJwnwCSfxfJH7xCnx8hKRvcbKF4nV3AMWsIJeLm9heajZB/DEjfcBfV/FnvL?=
 =?us-ascii?Q?l5EvUGKsf09WHGGGM7rWM/4+U/4qvbiKWA9vHf1HmCkmRK+oUHzD5NzzW17h?=
 =?us-ascii?Q?RlUEAmgD4ycnhbyK0y0uYMzWp3kBL80MuFm4X7w66jehhKhEOtrgX2EFGT3D?=
 =?us-ascii?Q?vDGYoQWhdFtXmfWc1W5mKCO8UId+FfHWfgJbh54SmOUCw5dNdlT+a8oMXa1t?=
 =?us-ascii?Q?7XeupMJ38NUqNr4yv9qHzM8SUZxHaWtzrM9oCYi0nZItn0zEFMW9XABE432x?=
 =?us-ascii?Q?u8ojn2fKvu520A9Of/1TXzqB7CakLNNDIPVzEikJpX9s0Uh1rcrFBuiOUMGw?=
 =?us-ascii?Q?T1WMzlp9SCQDYzSTJ6Ku1M8+MSSee4MEOq0Ys1XfwKda7ajWENu8PoCCgWg2?=
 =?us-ascii?Q?Oko8jj06o1N64Yb7n27wzjORvBpxZkOztAmBYOZ3LUtgfNHdo6k0y/2XPjD/?=
 =?us-ascii?Q?bZ0aspqNeoLJ9laecwMgYp7uDz3YELWetPzEP+caoo/7X3YCAVV8Z5XaO+bG?=
 =?us-ascii?Q?3VgKOBMSiCnDZ7tvWsxG07zFYBbSoMhmYg+n1NkJmNmimwP/70cEaGtKfeqK?=
 =?us-ascii?Q?3xUZmAv1IapJZfgGBl5eAv0Dw8vCoeCph8Kg2iA50n2krxzqDiqvXBTFtWJX?=
 =?us-ascii?Q?ur1BgwFF6FcljhKlBbzROxjsogs8Jva9htnw9eVctRCOIr8+U+zsURksDXvc?=
 =?us-ascii?Q?YrOGnMAUpOM3B+F1N8WlP769aM/4OH2xF7OTmpjwTJePDU9QMVHEhN/J8CBF?=
 =?us-ascii?Q?BUASL1DvHxgv8dq4AlzcxeC1EL2ahO2e2cl2LCWrmZzqaUi5V6IBTRjAycJI?=
 =?us-ascii?Q?0rv4tBqZAa8zlokYnBhJV52yhL1x6UXXJQlDl51qDBc6++K08+oRapFqhUtY?=
 =?us-ascii?Q?i3l/EVVqaJ81rj9D34UbPRx9uihFlzSfDxIX97gaUjUUczNPl2dFXVPONNAb?=
 =?us-ascii?Q?bSYmBS2gd23KJ2hhyKk9Nl8Fqsmxr93kMU1SvZc86sAbG2s14aPJuVaJS/lP?=
 =?us-ascii?Q?jkETCdg/Hi5IeWOYycFZ2efcoy7twYKhIX7s5sqHBf7WN1pm7KIym1cycTr5?=
 =?us-ascii?Q?CYFLGv9a0qpI4s2qYxzFpueoz54lsEGqGtSe0vUxxlOL4373wdFYNcP4SYoE?=
 =?us-ascii?Q?LPn32YG2FS4NU5//1Xzg5+rWO7Q2XVBuru28qxo+OF91q/GBlsrKRuyCwKB7?=
 =?us-ascii?Q?o8NffaIcCMYhn86dSTeY4Xkyj3w8xtuFVhOOKHd/7EEzMvgW6rqKu+R6KioF?=
 =?us-ascii?Q?WZgnGvNk7zICbkp5OQ03Emgo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa195c6-b488-48b3-4fcb-08d94c46a792
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 12:54:19.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLpZg4ROuLXV1+hsWkLCUnhI3+z+NEtgqdyiOuQivB2dt6YZvLwJDGeSeHknLHD+wc7vtD5tmSQhFLkaHAC5r0SeTwz3DlVBLMJcHggXKB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4626
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10051 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210074
X-Proofpoint-ORIG-GUID: 4g-_byqjpuqt0zpRWiytKSHqQCB8LKrv
X-Proofpoint-GUID: 4g-_byqjpuqt0zpRWiytKSHqQCB8LKrv
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew Bobrowski,

The patch f644bc449b37: "fanotify: fix copy_event_to_user() fid error
clean up" from Jun 11, 2021, leads to the following static checker
warning:

	fs/notify/fanotify/fanotify_user.c:533 copy_event_to_user()
	error: we previously assumed 'f' could be null (see line 462)

fs/notify/fanotify/fanotify_user.c
    401 static ssize_t copy_event_to_user(struct fsnotify_group *group,
    402 				  struct fanotify_event *event,
    403 				  char __user *buf, size_t count)
    404 {
    405 	struct fanotify_event_metadata metadata;
    406 	struct path *path = fanotify_event_path(event);
    407 	struct fanotify_info *info = fanotify_event_info(event);
    408 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
    409 	struct file *f = NULL;
    410 	int ret, fd = FAN_NOFD;
    411 	int info_type = 0;
    412 
    413 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
    414 
    415 	metadata.event_len = FAN_EVENT_METADATA_LEN +
    416 				fanotify_event_info_len(fid_mode, event);
    417 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
    418 	metadata.vers = FANOTIFY_METADATA_VERSION;
    419 	metadata.reserved = 0;
    420 	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
    421 	metadata.pid = pid_vnr(event->pid);
    422 	/*
    423 	 * For an unprivileged listener, event->pid can be used to identify the
    424 	 * events generated by the listener process itself, without disclosing
    425 	 * the pids of other processes.
    426 	 */
    427 	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
    428 	    task_tgid(current) != event->pid)
    429 		metadata.pid = 0;
    430 
    431 	/*
    432 	 * For now, fid mode is required for an unprivileged listener and
    433 	 * fid mode does not report fd in events.  Keep this check anyway
    434 	 * for safety in case fid mode requirement is relaxed in the future
    435 	 * to allow unprivileged listener to get events with no fd and no fid.
    436 	 */
    437 	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
    438 	    path && path->mnt && path->dentry) {
    439 		fd = create_fd(group, path, &f);
    440 		if (fd < 0)
    441 			return fd;
    442 	}

"f" is NULL on the else path

    443 	metadata.fd = fd;
    444 
    445 	ret = -EFAULT;
    446 	/*
    447 	 * Sanity check copy size in case get_one_event() and
    448 	 * event_len sizes ever get out of sync.
    449 	 */
    450 	if (WARN_ON_ONCE(metadata.event_len > count))
    451 		goto out_close_fd;
    452 
    453 	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
    454 		goto out_close_fd;
                        ^^^^^^^^^^^^^^^^^
This is problematic

    455 
    456 	buf += FAN_EVENT_METADATA_LEN;
    457 	count -= FAN_EVENT_METADATA_LEN;
    458 
    459 	if (fanotify_is_perm_event(event->mask))
    460 		FANOTIFY_PERM(event)->fd = fd;
    461 
    462 	if (f)
                   ^^^

    463 		fd_install(fd, f);
    464 
    465 	/* Event info records order is: dir fid + name, child fid */
    466 	if (fanotify_event_dir_fh_len(event)) {
    467 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
    468 					     FAN_EVENT_INFO_TYPE_DFID;
    469 		ret = copy_info_to_user(fanotify_event_fsid(event),
    470 					fanotify_info_dir_fh(info),
    471 					info_type, fanotify_info_name(info),
    472 					info->name_len, buf, count);
    473 		if (ret < 0)
    474 			goto out_close_fd;
    475 
    476 		buf += ret;
    477 		count -= ret;
    478 	}
    479 
    480 	if (fanotify_event_object_fh_len(event)) {
    481 		const char *dot = NULL;
    482 		int dot_len = 0;
    483 
    484 		if (fid_mode == FAN_REPORT_FID || info_type) {
    485 			/*
    486 			 * With only group flag FAN_REPORT_FID only type FID is
    487 			 * reported. Second info record type is always FID.
    488 			 */
    489 			info_type = FAN_EVENT_INFO_TYPE_FID;
    490 		} else if ((fid_mode & FAN_REPORT_NAME) &&
    491 			   (event->mask & FAN_ONDIR)) {
    492 			/*
    493 			 * With group flag FAN_REPORT_NAME, if name was not
    494 			 * recorded in an event on a directory, report the
    495 			 * name "." with info type DFID_NAME.
    496 			 */
    497 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
    498 			dot = ".";
    499 			dot_len = 1;
    500 		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
    501 			   (event->mask & FAN_ONDIR)) {
    502 			/*
    503 			 * With group flag FAN_REPORT_DIR_FID, a single info
    504 			 * record has type DFID for directory entry modification
    505 			 * event and for event on a directory.
    506 			 */
    507 			info_type = FAN_EVENT_INFO_TYPE_DFID;
    508 		} else {
    509 			/*
    510 			 * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
    511 			 * a single info record has type FID for event on a
    512 			 * non-directory, when there is no directory to report.
    513 			 * For example, on FAN_DELETE_SELF event.
    514 			 */
    515 			info_type = FAN_EVENT_INFO_TYPE_FID;
    516 		}
    517 
    518 		ret = copy_info_to_user(fanotify_event_fsid(event),
    519 					fanotify_event_object_fh(event),
    520 					info_type, dot, dot_len, buf, count);
    521 		if (ret < 0)
    522 			goto out_close_fd;
                                ^^^^^^^^^^^^^^^^^


    523 
    524 		buf += ret;
    525 		count -= ret;
    526 	}
    527 
    528 	return metadata.event_len;
    529 
    530 out_close_fd:
    531 	if (fd != FAN_NOFD) {
    532 		put_unused_fd(fd);
--> 533 		fput(f);
                        ^^^^^^^
This leads to a NULL dereference

    534 	}
    535 	return ret;
    536 }

regards,
dan carpenter
