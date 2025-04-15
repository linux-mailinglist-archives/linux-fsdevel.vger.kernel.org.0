Return-Path: <linux-fsdevel+bounces-46478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F6A89DA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E167A2C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9B29E06A;
	Tue, 15 Apr 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nL5GzUIH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lxU/zT0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5229A3F7;
	Tue, 15 Apr 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719434; cv=fail; b=Cb7wbUpnhRMpomIEWOkNoBaBf5lTy+kvgWm8VCz7hCEQ4b3sXTYJDyZhIXGKGxJPLCYarMuM/clzA+YFnm+CYH39fE7D1dNsbWRwgj85c/tNGO4XSvo3zXvCySruVTBUFfr7pmO6QDxOEh4YoQXcOa1tgFIeVRDvMbvI12KLO4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719434; c=relaxed/simple;
	bh=y3tRoBulLacdYM6HByETphJBqopj9PI5ytX+pysqdNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPF3GY/3unKs9WiEmRwaPhSuulTTHuTJh5HFI4ZR9i/JK/wSLE6hdcZ4rv4BFZ1V4iep4HtfD+4xjALCiYWxestN6ca0yF2BLdnfEALu1Dqx4bkibHQ+xSfHkqEdbirewpiolxdYgFHzqYAFhZMv/eZrfyIC2CwscDGBJZYrVYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nL5GzUIH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lxU/zT0N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fnJa004636;
	Tue, 15 Apr 2025 12:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RsCb/GLDPVNfQEvks2acOJYBf+0K6ihFcjuOwJYTRkI=; b=
	nL5GzUIHJqwYtXZ1e1dqcyLvZk7inmLieFj0PuVW2z9/TYccooAA7RdGbGpFBH18
	bmm8vBQoVvbtn8xMFA+rPdnvaCRcA+V/hIxe3JaVJyQcPnow9KwUhdLvo0nhD1td
	ul8H4vTKCfcDqACP7k/Wh5Goz6beWlMOIYFUaS9P+WqEQHTeBQS0KovwjkSAYdOq
	++j7qOpwHmcEgnScIV++sFhDa2PfWxS97wVQBYIJbf9TkT2a2+ZZNoYLbH4uM8ka
	FzJViwo6hZofz04mP5KDsz5ngliG4BwAAr46mfK5Jm0TO/gejpYy4f11dplTqGEP
	WM+tjEmY6UKBIX8o8MoLSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180w9j51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:15:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FC0hr1005663;
	Tue, 15 Apr 2025 12:15:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5v5p17-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:15:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvfBYrsjpk3XL50wxKaC4mZi7+HI9nFr2vi4nDkHmfZ+35VwYITJmxydJWrFZ1KLpgiH62/ULJYdmmXENFcZv15XVJ09DV13L0TkcVfxQ+ZMSi/Rs6rvZDYqosHxSyfQpJiV6QhvvPGbRuQyKMd8BdiMPDEXWDxgybsnJvsLAN1JVQ3EIQYt8lpX74Cfw7Meyik119oQiWKpvWSMT+axd9goFgtd+/5trk5dkl7aG0vn+nlw63k7FdQNstEgvnTCsowPGGr50dscoQbcYWYnzrwcRv4MIO8B4HOBqV7sB6T1DnMjItNuAS8Og+miialDPpOkO++Gm6ULqQuH/5VrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsCb/GLDPVNfQEvks2acOJYBf+0K6ihFcjuOwJYTRkI=;
 b=VXJqjY775SnDkQBpfRSksNa+3O1hy1jgnSvQX0LiO11nbGhdz24AnnQUUJg215HfZiKZnLkwcp1xf+0t3Wr2MG8UHz9X/Rv30unxjiA7JnvLtdwJuLpPm6mtLoobkDoszal0xyIQpuATK3kXS1FMJqyv7w+BOTNOLxABcnKLU7t9SPKeIZ3trlOxoczJC/1EYKX7nsphJgr0D9pvHbp2mGtpC7v2ApjpPiarCkTcyYB9PKOjndScECYhYIGv3oi+DfLKfgDnSW8lfxW27vz/I6R8alDBUypyH+KioVY4UFBaQ1PBsRoKARJCM8J2w1xCGi2jYf5RgXvJCPgCAfTRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsCb/GLDPVNfQEvks2acOJYBf+0K6ihFcjuOwJYTRkI=;
 b=lxU/zT0Npze/64bU55tzILtz8XNM+RGA7kEGpsMdI8t8Ty2lT6kL/QxFuFzaTjzBKuGeeDO3hLhP3KVQ/HSjPjHkxE4EijTXabltqlkVQwbjuofba3CVxZjyI0jUnopWxJcgJE15gc+cz/BlKOp/wWyD3v3N511VYaagyJ/+a5Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 12:14:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 13/14] xfs: update atomic write limits
Date: Tue, 15 Apr 2025 12:14:24 +0000
Message-Id: <20250415121425.4146847-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: c5569280-7be4-471e-f456-08dd7c17232e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MstwUA7rl5jsm44fnkns3nFBf4j+9VMb864RIgBdnvDPWey6IMA5CYwxdHUV?=
 =?us-ascii?Q?S5XPW43zJBPWJ8kxtqDlJgGqMZGRig6OzeZbyC0vj5MxM6fXyH+43GLVM/LF?=
 =?us-ascii?Q?Srp3U/6RaL0nzRNBzu6PSLssZHx8uCDqU8NonOApmB/ERw9R23RVPAJm60ps?=
 =?us-ascii?Q?6k5DFOa2qYiWT/zdtEMFqe+hXSNkcCmBnp7vPSiWcNZ9mN8F+cMyiUctmfY0?=
 =?us-ascii?Q?RkxNGoiZlxVp6fRoCru/xesrjGvN/OluCpG2h8a5LMaG573abm5T6laSlYpW?=
 =?us-ascii?Q?FGJ48wxUXAICmuBU99eCYTIcG2L9Q0wPgFjCpptwvD8KScLQLLHdoNpdaofx?=
 =?us-ascii?Q?ih1dqxSGRVTqf9IFZshuOy5WF4xkfRWmeEIF0tdCNh/WAJmQHqMj36MZ+4Yg?=
 =?us-ascii?Q?4fTWg6GLgMUh1n6+uknE3fLusJRx4sDBYpv3993HHTx6Xcl+Vfz2QqXJk4XT?=
 =?us-ascii?Q?AXI7Ayc5jGxJ/Ux6p+EYCdMXiLKF0B+Q6hAmaK2BGiSdd43ZqpWRD4OXcWzC?=
 =?us-ascii?Q?L7JmzOEJQgA6ByVl9lR0vZ+GogA5ZZgWvhZvr48Q2u9iEsxb5q60HOZI4kYe?=
 =?us-ascii?Q?U31+WlgPQ5wzbkX6Jn/vMULfjQFiYWWdXjL/2j+NNJKB4xi4t41jnF1KUmc9?=
 =?us-ascii?Q?AZ/5JMOvsyq0porpoN06CvhNBHLrCyr6A/9iUr7vofm12eyE+E2iqwT73vFt?=
 =?us-ascii?Q?kG2o9ZF54elXFuDmAwcYHr3GV6XJ62IkZP5Iem86uyv0tXzgj1GmnXXyLGOi?=
 =?us-ascii?Q?uBARlcgq6ftStsOZavqAtEvvTlZSMNh33DgVnswxHjnW7nu4fA3w+v7HiUNB?=
 =?us-ascii?Q?t9QB2Q9ZXF9T3ohagq1Zias6D3uSLduHv7rHnpGSVleGFqy40Kzk/qf7P6mu?=
 =?us-ascii?Q?liiGVWB2/97HD7EZUoDLPN8RmB8zfJWQAVoxJ9b3b3vOCXg/H3EFxC+gdJk1?=
 =?us-ascii?Q?HjTYhWouTdX8b+8HYD/KAkqz9rCIpWNoGFsetZdXLxMNhEgxNkTSeX17d+LI?=
 =?us-ascii?Q?ss7byoCRtq0NmcuR9wfgekBzAEWXO+snvyrdmrtuwBXSr03cZSqXn638GPEC?=
 =?us-ascii?Q?bYbEnPJ9O1PK6zY97Rraf//hhKrOhVuUbZgYrzika7q2frnH1HSRoJO6RGuy?=
 =?us-ascii?Q?ziyTzcGKgcCockXcO4qnJ6TR/R8TzzuGLpVSuOt0q9bKSjdjcT2BfJ35el0j?=
 =?us-ascii?Q?BVwMYKyXBj7wTrsmgQkALBclTxQOIHJ5JIJR6TcjWq41SPbTk45eRCNVY6xP?=
 =?us-ascii?Q?EZtJOJ27w7z6Vdm0f7SmSFzeYwfriMe1oiPR1vdoIWuLabnIWUgSYy+sl+En?=
 =?us-ascii?Q?vTd9lVJ4CcS/Zrl2mE6qutKy4pfmzi3xh+XArdP368dfA9CGRN1zYCsbP6jC?=
 =?us-ascii?Q?qF2KvsPmarQIubvMEZH/VvQUtcIriU27IG2Iq0q5t4kifvvA1wQjWZZvldzW?=
 =?us-ascii?Q?GUqITomfdDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhxOhlCsS8Dt/tlOeizAlVlvVjT5xpSJmm2V7Iqb2uZ2q5Lp8E/lwZDFrrtz?=
 =?us-ascii?Q?X5JQuxddxWkPQqrfpcnblM2nGwLstTfETPcHml4GKR3e9p0M2YLYdRMwGv5+?=
 =?us-ascii?Q?gPan/GrdnPW7WMvIEZQ1BLwKUwFQQWc+H9tXJEimdOn65JfoBq9CdcvlCCX2?=
 =?us-ascii?Q?u7IsqW4JDC/8WrqmJ25KesNYRigp9EKUtLNnpSv/2dMckkH14DoTLqHkqQby?=
 =?us-ascii?Q?Dm8LaynOuj+LoT18hpc2P+QqJMMb2yjOukbZKd2zBYWJnSRcWzuL4HA0N0sS?=
 =?us-ascii?Q?0tLeHpwOspxtgz+ZO0IfXvlmQmYUPTa1cmstSFjDvcE7jQYp+oc9+uBJB4t0?=
 =?us-ascii?Q?HGj0waiK6sAxb798ibuQoVC9lO0cCQe+5k7G10l6EIF6wkbBA4HKTcx/9UYH?=
 =?us-ascii?Q?UmQjMUXxskMn6vjQO+aG7kr2+cuGPh2yJZ/veN/qpDPEeiLGBctFK4sr6MNl?=
 =?us-ascii?Q?8/bg5pyP7BuvZILIrd1MV0vhFE8ltREasshebp/EQ6bj6EtPbTAJXs2BceRS?=
 =?us-ascii?Q?L3OaaEwqSH7Xi3xrugfTbDTQnszn04VXfzOMD0jC3APgJ5mcWhs5y//pk37c?=
 =?us-ascii?Q?czPctGTXpfrKy7ReJ+Nw4siFO4RK78CQENqcqdqtk4mjnOUi0GrzhTVjZ7GD?=
 =?us-ascii?Q?fkkPmWVgzmWrWEKe3W09vrMmvmfhb7nqXAbtNaCUby7jMMhuw3pLkVHH0Cjg?=
 =?us-ascii?Q?HDHDqWq8EOxuxXD6qPRlmmP3yJGabx02LkjUAnIwArhHb8erpaazvDz7+Xpw?=
 =?us-ascii?Q?5+60KfQhtyDh51qcHoyPrjr6MXsOYMsUMrXMZekK6Vh+ljrk7lHInF/XkTfE?=
 =?us-ascii?Q?7yBSMA3/V15Cayk/bSl74XFMPvH9ocQ0R54ob6P0mZtzXrW9XhhDd6q+vscX?=
 =?us-ascii?Q?Si0kH2nB9HkmFdKXgGFmje/dP3nbRq7yBAP3sLd7T1TCEZBOsWYQrxcJXoiQ?=
 =?us-ascii?Q?9U7OZ+WlW5/+WaVYgK4W6bPq94AfAypPajCJl5FyqJ6CvfoUWdCuMdytTz4q?=
 =?us-ascii?Q?kAqs4pJ1TIyRMIbdm3pduRkv8hJEqGt1cJIxAYCmpv24FFg+7OyNq3DX2fPj?=
 =?us-ascii?Q?fBAM12L6jAT4zV6T3RE89IBK8USeNIWF+9ChQxgll6GzW0AJ6gq1sUXUU/mC?=
 =?us-ascii?Q?1BYeqYv9do1cNGnWt8FJfuW2LtdO2BxNmDYbImTdr+6r637m0zEvwFiqSdU8?=
 =?us-ascii?Q?3ocg4ZKeI7ppyescvV229LtpdjAoKJv1+6C39E/Bzmrwu6iztw6wr9l8gZZW?=
 =?us-ascii?Q?5cVBYGA3e2Rxiju5z8/WKIcIDZlW1/8szxyfF6zHNAl2wWHFBC0P0YSNVUE0?=
 =?us-ascii?Q?fcTKKU8QH53A98b5BVemkWWdB2WEg9VlKTlDeN8YtbJXRayHfqz154/xLU0d?=
 =?us-ascii?Q?ToAEOVkYmnumuYifXhFsMch5EwSg/dNa9JtarOygUozsDSGkD+gZURGnTGvl?=
 =?us-ascii?Q?y8zOavG1CNyIyklTl7rz9adpI4qhelK/yQN6CaD8rStxpxUAO32qD1ipHMp9?=
 =?us-ascii?Q?H7+Sm3DiQ+SsfEP8eKeGT1tTP1aJB6/frYFDU7+Mp7T4+SEJp/4noT0pYQ57?=
 =?us-ascii?Q?B16gj8f9RI+6j6KnZPUreeeXpMrmzTz/1usob8EfTJ/zm52Zue7mIJAYP+f+?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UCHeO7h6p0QQuhkVYFdb3yLHpdtih59U+Qbp3qdP3il4X+wpzaGUlTKdY09KPQid55k8WRL0ykzfDzGURojws/ncTOuEHyIAqiVEZOAxqnV506m566KccbV79fbpNl5cHBufnDMFaB6OZfpk3+ef1PTPkF2QzE0V1nKKj91dZ6u7fC1qqHA9ZS5KmwvHcJllzuKmZKkxFB18s8R/3bPLGUO5fSwBwnuYDm9DAkvlV1TKweZLge/aHrlFp+QMMWUgK9nOMBEvLKDzgY0oEv7lkAlCtigJuvuL139nKjzYPRfm0oot7/aVX6H4VnKaUwsBV2WPv+xT+rRoCmxJfhggK1/BCdsjh51kqXUwXyIwgC3qsbfT2H+9p5VdCyYbMhVmBE12IwhjzDmjpOSWJ3lbSz6PXAu8fhB3cCrmCSD9rIguyme53LJx5sS5mbqVTHRGh6dyhEQVceauUrVdvCrfffrjgdzmNE4MnDooPxrswAhmcdie3FVkOSPkjkAvy+MgXWOk41ZxcJG2OZ0/kRlG6PtS8tmxSUaKQpQHdT48FI9F5XVfi4h4cD/pzZ3faFrQqfr5m3mxlNQaQ/ajn5dSfHWVcDxzDT6b6N1b6Xqn+Zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5569280-7be4-471e-f456-08dd7c17232e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:57.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOSc3QpxxIZJS321u/TLYSd7rz/Ecou5kyMWwu5EK7Niob6LltoZp5vfI4t84vMwMvQ8imWo0Ecmb/ohnVf6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: 9u4zNXZNV7UlYgHekGNch42qWB1VJVNM
X-Proofpoint-GUID: 9u4zNXZNV7UlYgHekGNch42qWB1VJVNM

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
blocksize but only if HW support. Otherwise we are limited to combined
limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
 > 1x blocksize, then just continue to report 0 as before.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[djwong: update comments in the helper functions]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 53 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 81a377f65aa3..d1ddbc4a98c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 3b5aa39dbfe9..183524d06bc3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,68 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomicwrite(ip))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a minimum size of one fsblock.  Without this
+	 * mechanism, we can only guarantee atomic writes up to a single LBA.
+	 *
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (xfs_inode_can_hw_atomicwrite(ip) || xfs_has_reflink(mp))
+		return mp->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomicwrite(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (!xfs_has_reflink(mp)) {
+		if (xfs_inode_can_hw_atomicwrite(ip))
+			return mp->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a maximum size of whatever we can complete through
+	 * that means.  Hardware support is reported via max_opt, not here.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	/*
+	 * Advertise the maximum size of an atomic write that we can tell the
+	 * block device to perform for us.  In general the bdev limit will be
+	 * less than our out of place write limit, but we don't want to exceed
+	 * the awu_max.
+	 */
+	return min(awu_max, target->bt_bdev_awu_max);
 }
 
 static void
-- 
2.31.1


