Return-Path: <linux-fsdevel+bounces-47523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B2A9F488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3787163556
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5C279905;
	Mon, 28 Apr 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ovlPANcZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k62LEp/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65362797AA;
	Mon, 28 Apr 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854423; cv=fail; b=jWqdGA1hEYcmMJClSqew3Ipb4IE7+lpta+doYTkiRSo87iPWRPpgw5PiuR7fk8/jBRt7ukMKZdk1p9YHCFU8BwScMCWOhnnaB/zg4Oh7RK+6XDUZFtInTo05bJCtIWkCHZk82DKYOlAZ59C5K/rS3OOC9ootRj834ghjLpf1H8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854423; c=relaxed/simple;
	bh=P7bee66SXB5//fUmOIfnX23I1Ki80ET4LxnukwfFJ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RUJXRRs3nVvrTRyPLi+yaR4Ve4jq/cQQa1srgKVLaWGRfBTSxKZyrs4le02D4gyusbzfGUfUquunuU/gYJuJ0AFEjimTbzKXqUkBW6LEQ5pVFKwVNucIva8cQ3Si2XLKrLxxfL1BfJXzq2+Y5sGwEFJccrzjlLJwG25xwV6UwT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ovlPANcZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k62LEp/O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFMv7A000530;
	Mon, 28 Apr 2025 15:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=xIQzR76zpZjJ4ELP
	xFt4fwb7S0n3HGjCdRI4AlT6mAM=; b=ovlPANcZzbX4ZAQl+zSsxzFoeOjd69tE
	7DcAKAVg1n8+jS3bkknRxf6ZF/kocZlhWSFVNZnWaZanZo9wWjtVKX+uLhNCQ5P+
	El7ybgrIhbrxkiwfHHW2yk6WcMSMk2DbCZtr9kJyYXntnffUH0mcAWyUbhXIMO0D
	CIOAUCPdwIAQnbUd68UlHzJ7g1HH7yFX5AGunK2rZQ2/TMOZ4ipp04USnswsfm3g
	tXgoRuSQJCLhiCNAnO2KmKeXQ2oQv29XJ94r1kKe7lEX7ElNI6jokN9iqgUWi9X0
	q5ubjA+RTVG+7T5LDTeWb1u5CTu7SSPL47T57NeVVYhgULtsNDHMTA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ac6781cv-33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:33:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SEsJYI028457;
	Mon, 28 Apr 2025 15:28:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8jknn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5PbWSEjXk93/sh0RY/ciGEu3EBUMc/XKhHGrQaLxnaIJPrv0G2GRkj1bnyPqIJwEMTfOXUfRUmQst3qja8n4MeoHkUzu0B/be3pfdysSBvOHDuHaslydhHc2NAZtxU1kf08Z7d7Ij6oG50glO8bD2OrmXe/gWJcu90CvJw0uEBJ+i2ACsxcyiGTt03FR5U5YRKugj0FMKd1RN3dlhpz5aQNQjXB+pqpmC14hyh3+OJ3MlIo7m9ODkIVW2+5JKU7RAsAZqCCilcvQBv06jLZRHE4V2xUgcAS7Uq5oK9YOn4+Ccml+tKblAwlPUYP5h840/Fc7P3IwonjybIevveEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIQzR76zpZjJ4ELPxFt4fwb7S0n3HGjCdRI4AlT6mAM=;
 b=ymeKdSSe3WykOM6vvx2u17insu4aFuQMCWUra9w22Ka/0wq9gN73RO2cnlDWwQP6wEW0iQwEISad3wdSFlkXcjvjVL4VPFRtw0U1Ztxf1JZhMZM1kwkKTL3YJ72iog9bfZWzkcM7Z+f3MDDw/6XRweq4xNSeLpYprzvfvDT7j6132OHJUG4UDx7ukMIuzb6oP+H8ObwFC8VNhOOUpOlNEsD0sw9aLSxXo3H+Q83rR2/5JHr4YRK1aTfYC3CiIaGFHpMx0HrpwXnQY9RP3I57s+lqv8vXzuYKnMjvCTOM3qGS4LHVVKmWs+rjQdfcn0o/Qds/IDZ9jSpWorOMpHlg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIQzR76zpZjJ4ELPxFt4fwb7S0n3HGjCdRI4AlT6mAM=;
 b=k62LEp/Olz0IB+fHFESCl7kuXsmTvcbx91629fl1gC0Y/0QXSCxC2k6+fymHKh77qew88zEPgIRt/iMhD1jGF4z7Gz96jUFFQD7wnQzQauEog3BTHMIGgJ42lVSLWY+UcACyAH/N2OfJdIrz/OH23pMOxvPQOTCr/rpkGodpMVk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 15:28:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:28:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] move all VMA allocation, freeing and duplication logic to mm
Date: Mon, 28 Apr 2025 16:28:13 +0100
Message-ID: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0674.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d35591-58d4-40dc-2774-08dd86694fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUi84StS7Z8533Bofz3YeMB8JY4uN78qr6GD5OwgIMlGTSDZxlPcc+p6tKGI?=
 =?us-ascii?Q?3ASW6cV7LkE6nofx5+ogtMHmhpviE6UsyRrInNLI0fyZi9DjMziqEiMJfo13?=
 =?us-ascii?Q?sTmwUu8mJa6fqS6bir1b+IKyU1IiyGY4CpPhS9m3HqLSi7nKnZfXzbwQIbur?=
 =?us-ascii?Q?X+F42iL2ZiLUv+WHzkeKGLoLJ8B3U4Q2xKvaCx+Xw8qtASOybVV5sntvJffG?=
 =?us-ascii?Q?poh385BzTh0FlUXJ74ZQVLzjSSrGW1I1VA06JxM8OnVKul2kvXx0ApbvgZFH?=
 =?us-ascii?Q?2V93iboUF40WlMAZKaicGqaBxbvZmpEvHnorGHOxqk6FDQm6Mc6hI2OLmEnL?=
 =?us-ascii?Q?1qf3WK5el3WgML3yVIK3BT1ha1GFt2A7Ti1tjkZv+mEhLmkm4w+EFaQ9DkTa?=
 =?us-ascii?Q?olz0U3lly+E7g6Nwjt6E3IDipcDiHuuAzp7tgkUDJFjFH7/2J/wGrjwFyUW5?=
 =?us-ascii?Q?uW4Qxb5eZ13xVREY2zme71Tp7rEZyXivEznnsWc7J50E1rEbe6+cLeUOrpXZ?=
 =?us-ascii?Q?VSVXpJDEbVpLVlFcjhsi2NyJe0xBzpAzVzthkwiS4azWlKPY9dzh+5lA10ov?=
 =?us-ascii?Q?xUUwtu3gYO9i2O3EWJKWXuC+mdpeV/Qi63kkzDiGmzECRRwnWOF6Fccntoor?=
 =?us-ascii?Q?ELVKHbSh5fNR2r6AW06Kw+9ETp6Wn6w9FTT42La1rxEMP8wiu88fzgm+D880?=
 =?us-ascii?Q?3JXu9q4TOIa66D/Pc+IQqRDVZShoZlC1AFwCtvejQ3EzVajnmaOdE4O/oZsE?=
 =?us-ascii?Q?7UZBkxkXvklLZ3Wo2EfVtEwBTc5HONZVgsknmf52tzR8UIH8Iwf0iL45y4Dw?=
 =?us-ascii?Q?ifQC35QRl3dA8CTSLwvUm0wD/XtOJSIz6Cn6IiUTSYebcGkDpASa0QkEWCyh?=
 =?us-ascii?Q?b3m6k7PY5Fm1852N28eGrduT1cZ2DawxjMDQowVeFQ27sdKbfwJTXowZvYY5?=
 =?us-ascii?Q?mgMvMzqwgf5ZPLs1AHc7zC9CW9CgCOjqf1pP4M7VD/wdlBMnUQPPp7cwjeG+?=
 =?us-ascii?Q?DdA4o70KOtD4YCKdMfZmXA8hHKN1nHa2ApumHIlD4aXf8CqjvvF0XaU6itZE?=
 =?us-ascii?Q?s3eumbTZF8Z6SE0Um2q1CeUf0r5yJQium4cRmRoUiQKIRBZ0Ll5VUy7U2Bb0?=
 =?us-ascii?Q?Kx0X2dSxb6DI62orTikIxchmLZmid73JoAdAMti4wIHEDzq2NmkqPcR5Ms7B?=
 =?us-ascii?Q?tUPRcNAjeklGrydnIZqdcbZwwmdpCovbxgOYYPqfYyp8BepVMX3IKBoGtkRI?=
 =?us-ascii?Q?uVCkbWW1/JKaMxq9V/SWk/Gacq3qjoVuLagebl8Z4B1AT1AcH9PIDm9q1eV6?=
 =?us-ascii?Q?DRC7cD8vn8wjD1gbLPrbMQ+EW99R0qzQepG0sd1kBU0ywlLp9hEmffSEI+BL?=
 =?us-ascii?Q?S9gw4I/ewY1qGe090aveB7O3FkzwQJ2waTJeIOO/QMW//lFsPtFcyxjiuLm2?=
 =?us-ascii?Q?pOEVHnc5yew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5L8yPvAZ2KQNiTLjel7VEfLSXsiaPXk/DlAtzolvZJPpxDE6vv+S5yQyV7UQ?=
 =?us-ascii?Q?Ds79hWxbLTgtRzD8ASBwwVk6tS30pC+9gn/rDQZI8EQfs8w5y2B/1oHmwezK?=
 =?us-ascii?Q?dT5XAHTFyWG/MYt9Kp+KcdfRXZzTdlrMeH9juq+fG/cRACnD6Xm6Xv3SHnzs?=
 =?us-ascii?Q?y/sXevluiunl3vpJCwfYDqJ4Z9KaGpLjwNcYFzOD5TPu1tp+dWpxmJV95dPW?=
 =?us-ascii?Q?Ji86oX3Pak0ncVZ4mhmqfLNaIiVs+1HghpvRPTsmnfK6W8OqBBE7PyJw7blm?=
 =?us-ascii?Q?8gy6zH7O+uSZihV8NLhr9En7x9a3zdyxU8y77d09cRgo7pw6Uk1G3ZC1O8gD?=
 =?us-ascii?Q?f+RbRlnxuTF6mTzPu/98x566mt8v4P8gqbv6vYTFUBk5Jf1gw+uBCErqGsDP?=
 =?us-ascii?Q?/kybXkeXY+1RZ4K1+aUWbOr4HmTZAXY2cLKyzMfjhDFzysce0sFiKCLh0xWv?=
 =?us-ascii?Q?jNWbA2rNiNyy/38ilPEzSxCCntARIZZtZEz4INaZL6u+y5GscDOCFpVLAzOl?=
 =?us-ascii?Q?FyfIXHZY0g12jkgFZLKBiXSXHkv+eapF9W7TUT5w1mRGsiwxMu5gr97pO/OI?=
 =?us-ascii?Q?gNtA1r09AJsw1nyX2DFp4u2Aw2BJYL1LpRKcNoTUl7cEIcd/ncKpe2od+h2A?=
 =?us-ascii?Q?FK1vxY2U2QWUBhKMtOyqkavfqyLnREEim7MeaM1qgGBhXMcDHW3H9jDH2Sf1?=
 =?us-ascii?Q?76T9T/wiBN7rzMOwdzvMSysvEPCSrjM1DGFn7sAqDgW6bfLcxew2+fJOSRcp?=
 =?us-ascii?Q?AQMbbJc1CXDdaRxCxBfUyws57dwPfYaK1e3POZHC+VfegYNizs+TBseJtDal?=
 =?us-ascii?Q?lUuR1aWjZH9PFPm4cz8Oi4iSHEx+yFsFRSUC9/XZzC054bRnMOK6W89umq/R?=
 =?us-ascii?Q?3KGgB8lnWdBYwfNrb+89b2P0vRNL4CTKYPWQoXI5gyFqE4BWALUFOwenU1fv?=
 =?us-ascii?Q?cWhSmuPPEp9MDa8OoZPUWgV6wpHySr7b3RbvoLK8S7gboSvAm87jlj6q8IEg?=
 =?us-ascii?Q?Gw24IjP8MEmQq7hgIsxY3efCorMapEfpS1lS7wvnzbddviB4kKBOUa7KhBAM?=
 =?us-ascii?Q?D6YTF5eNX6zsYs+VVTrI6g9DTAL+b8ibHhyUml6rykpYYdChy6j+ZX2h+u+y?=
 =?us-ascii?Q?fQAl53wLTadCjLgvijB+oFQaTu3zHTFv0DL4WMrZJkvHP8MWhmpUVvhRIQZJ?=
 =?us-ascii?Q?Tn/eoIga0v8XpxaFMn54mbaW3/37H86mqSAt/paylBcIO/f1zMgDhMf8l8xN?=
 =?us-ascii?Q?w6/jzVqsWSJnbt/dAunz8+obDZmtzQxFUu4EjXM9g8NksklXiXNvHl9/ccyb?=
 =?us-ascii?Q?mdzpm7GVUJvfQ96UILv54Y7Pav0DLJ8ZI7R2PUxJwjOmVCzEnrpebZ6Z2rIo?=
 =?us-ascii?Q?RcN0h8NLe8UU+qHgsLSHkxqPfDwtS/7qWf8g9prMU75eyEJETd8w1HxUFyYO?=
 =?us-ascii?Q?tVFoBQcvnEUjjhYEfsIn6az1CqCDp4W8vbDKMHVS40GD4hFK7kfkHDHYcxI3?=
 =?us-ascii?Q?BBwMZlhFM8etfKtS4mROdqhGqYkVx2LIO8W9hHD+ikN/i5TxzJW+zHnJdQ78?=
 =?us-ascii?Q?KcZyuEXNLkiEl4eYTtDH5Vk9EPf7Q15ruBdTBNmFUXt6h37P3pTWBrs4E6/m?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I6mLfIbaLF6NrW2/WLUuaAgG69ghvGZCZWXASwzAcrDAhyirpoyTF63YNUaY5qNwAxf2SWko/USnP5n2ygm5FnX8aUT3E9M+Rz+pVV4L0hwyCZwCwref1xMXviVvIAYXOZHd0+xoDyW951bfBAg+Le0n3TPWbZyuAidIQDfpL2LxPMRvqdU9lfIi8aCc4ce9tH3ZqrSXyuDtcrBIV93jgXElD58sioiZGrMfP55bzSXowj2ZfjGSgCZqRRltxM/Ase6Xt5i8g1SbpbqWwhuss5s5SEL8e7ZIvU0yKwcgmkn1XegpPIPFTd+6UiUaTIdNhHZj81nyhbdGbc39bga3I0AdGM1xhcZjIfiaPWIjdHqHAnq3Uc2lEc4lbP8eMqnE/5CWeB8K/EbFXbnA/DdTajfBv0AZpBXNCiWNVeOH/2AawBtUPyQQSPkPWH5YTcC5ac8wKoISPmk7ZhD/usD5jnQGCS3EZ5BFrtt7jSngDwQ2QW1m1dfMPaIv3xdJqqHs+bkP1uQ3HSL3KcVipZU78Lizh7KTBOoAeTrAynNe/986kJHpuxPh0tU2eQLyrX3qElEELLNfiY32UmWGLmpDzo3dJOskd2Jhyd7WySJxuh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d35591-58d4-40dc-2774-08dd86694fdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:28:22.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpTHKcGaflAPJp0DvEUGUSfpw6eHU896+ZuPyB0mKIsGK9MnRtw4qw2woSbaJxpOdH9X1MFeS/ROHPRCr4YpGZduK2sz5np40JABPoefL4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280127
X-Proofpoint-ORIG-GUID: fcUlSqrzMWTOwoA-vJmelfKTlMHmvxqk
X-Proofpoint-GUID: fcUlSqrzMWTOwoA-vJmelfKTlMHmvxqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNyBTYWx0ZWRfXz6P7MKSqIlgg ZyEF+xp7qcM96EAzIA/xFRyFmiib7QxbZFnqKfuFi8MKDGPQQ8mCg1Ff9uiy+qtI+wcuce5RzLB eCaFgty1e145T0ZkwSNYKWNwCtLvb5pxlLXPi3VWfEAPqO2ssmvFrHAb1EUhlVEv5p0e/OUBlYX
 gG0pEExveHwgI42zYVzozamYZXVWA8qfCeqN4uIKmpYucciA+fpxinFai30vqp3mHibhgx63o0N jfV+JFA7zOPs6ogtJIOZsPvLoZpflytoZPNVwIsAORkj3RULM7pKMOWlB9aAmQUwWm08mcD2z+8 FEGVPHeLlDlrCqzsJqohowlUU1fym0PW/z5GD58fPtOS/R05sKLzJ274EKHflN+HtoOm8Jbkcmk M8pNJ+Kz

Currently VMA allocation, freeing and duplication exist in kernel/fork.c,
which is a violation of separation of concerns, and leaves these functions
exposed to the rest of the kernel when they are in fact internal
implementation details.

Resolve this by moving this logic to mm, and making it internal to vma.c,
vma.h.

This also allows us, in future, to provide userland testing around this
functionality.

We additionally abstract dup_mmap() to mm, being careful to ensure
kernel/fork.c acceses this via the mm internal header so it is not exposed
elsewhere in the kernel.

As part of this change, also abstract initial stack allocation performed in
__bprm_mm_init() out of fs code into mm via the create_init_stack_vma(), as
this code uses vm_area_alloc() and vm_area_free().

In order to do so sensibly, we introduce a new mm/vma_exec.c file, which
contains the code that is shared by mm and exec. This file is added to both
memory mapping and exec sections in MAINTAINERS so both sets of maintainers
can maintain oversight.

As part of this change, we also move relocate_vma_down() to mm/vma_exec.c
so all shared mm/exec functionality is kept in one place.

We add code shared between nommu and mmu-enabled configurations in order to
share VMA allocation, freeing and duplication code correctly while also
keeping these functions available in userland VMA testing.

This is achieved by adding a mm/vma_init.c file which is also compiled by
the userland tests.

v3:
* Establish mm/vma_exec.c for shared exec/mm vma logic, as per Kees.
* Add this file both to exec and mm MAINTAINERS sections so correct
  oversight is provided.
* Add a patch to move relocate_vma_down() to the new mm/vma_exec.c file.
* Move the create_init_stack_vma() function to mm/vma_exec.c also.
* Take the opportunity to also move insert_vm_struct() to mm/vma.c since
  this is no longer needed outside of mm.
* Fixup VMA userland tests to account for the new additions, extend the
  userland test build (as well as the kernel build) to account for
  mm/vma_exec.c.
* Remove __bprm_mm_init() and open code as we are simply calling a
  function, as per Kees.

v2:
* Moved vma init, alloc, free, dup functions to newly created vma_init.c
  function as per Suren, Liam.
* Added MAINTAINERS entry for vma_init.c, added to Makefile.
* Updated mmap_init() comment.
* Propagated tags (thanks everyone!)
* Added detach_free_vma() helper and correctly detached vmas in userland VMA
  test code.
* Updated userland test code to also compile the vma_init.c file.
* Corrected create_init_stack_vma() comment as per Suren.
* Updated commit message as per Suren.
https://lore.kernel.org/all/cover.1745592303.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1745528282.git.lorenzo.stoakes@oracle.com/


*** BLURB HERE ***

Lorenzo Stoakes (4):
  mm: establish mm/vma_exec.c for shared exec/mm VMA functionality
  mm: abstract initial stack setup to mm subsystem
  mm: move dup_mmap() to mm
  mm: perform VMA allocation, freeing, duplication in mm

 MAINTAINERS                      |   3 +
 fs/exec.c                        |  69 +------
 include/linux/mm.h               |   1 -
 kernel/fork.c                    | 277 +--------------------------
 mm/Makefile                      |   4 +-
 mm/internal.h                    |   2 +
 mm/mmap.c                        | 309 ++++++++++++++++++-------------
 mm/nommu.c                       |  12 +-
 mm/vma.c                         |  43 +++++
 mm/vma.h                         |  16 ++
 mm/vma_exec.c                    | 161 ++++++++++++++++
 mm/vma_init.c                    | 101 ++++++++++
 tools/testing/vma/Makefile       |   2 +-
 tools/testing/vma/vma.c          |  27 ++-
 tools/testing/vma/vma_internal.h | 215 ++++++++++++++++++---
 15 files changed, 737 insertions(+), 505 deletions(-)
 create mode 100644 mm/vma_exec.c
 create mode 100644 mm/vma_init.c

--
2.49.0

