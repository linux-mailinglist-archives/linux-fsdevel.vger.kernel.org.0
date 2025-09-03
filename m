Return-Path: <linux-fsdevel+bounces-60180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6FB4284F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC201B2839C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221433438A;
	Wed,  3 Sep 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SmGdgSBl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZWpwq0NX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358782BF015;
	Wed,  3 Sep 2025 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921748; cv=fail; b=mZHPnHD6ApSjUZFdkAmuT/ZHc7MLxH3GHEVly8a16jiatcc5lTyzLeEISP/LovuJsesjvQd7t6UUi1/mVHVfvQt2/O4HPhcBjyxrfJ18YzGl53xGZwbfA1QvxfjeOh2E4+f5YRT3UmH9jGJhxgRuPx1MC8NTRk9AHTJmN+KPfwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921748; c=relaxed/simple;
	bh=MaPijKnhr9GSw4ssIrMXa3qC8e85OruVeZdT3R5e4ok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cERPqaONwXFHPcAQj0XC0cGBiJEOPTR4kTik/lxTqlgMizEdMdzDr6V2YhKrPJD04abRbIoEyvsKdhwk/Z+k8PsEuNlefRtCetiTHGVeL6BwJG859qbpLCoKh0eOMj7ZpwdBopUarIlQEZuHb8nXofnjPjXOzn8I9Ijue+bdY2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SmGdgSBl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZWpwq0NX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583HV2Gp027740;
	Wed, 3 Sep 2025 17:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=efA9ftNRgeH3gJNA
	tqfMiVnZ9l0OH2WG4lkKrX1eDoA=; b=SmGdgSBlVCEv86ZzBjZJQ/ePPUttLTOi
	73FvpBNu1dPgKgFGSxqQtsbh39Rwfdkz6OF/v/LTA9U2NP8T75dhHxzrubbcah/k
	Kf1RPOr5PmQwbWjWA9v+CimrvuDY1QwhpDHOp12IZaFpJPt7jD+jBiK+RV8rvAv3
	h7QMWUN1E+mwvHzBjyvKh7KlqIJzWKDjgAIbeJTROHMFi9YKnxMxVnVN2vw/BY5T
	YJIAPrntlNNRknDUSWdMWMsW55+pirtrecxpSQvjY3pLgmuYCCHZqSKr3et2nMhp
	GSMpL9hlPcy6rVIDM4ZOrzTQbLSStBY/CVJJKTKTTZa780KyOSZ3DQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xt4ur17f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:48:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583HFVU0040063;
	Wed, 3 Sep 2025 17:48:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrgpn4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:48:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAuAjlY0Gf+cxojKt3K4MfJ36vBAdgyhZrEkuqEjgLSSunNQUeVEm8+iWnh6aSpuHJZ3Oc+CjrXDGRiJZgd6SZzYyLWyXJkpnDyIRa54o017xg0iHviTU7J/Y+JcR6qrpRUzndn8e/ek1R8HtMDfqPjfcJZTzhT0/Rnbh5rFMebQWtUbpvIm4xV25smpodCTETRXG8BycYiq+eSJepqPBt6js4sG2fPNiU8ciTwtP+k0jNCZaJ3EdEyOjiriERr9E7tEHCpjeZe9pPdApNHjuhskAD+Ze/+tm0Mci7EjlWaCfxESmb19pexlg6ytzwKHuRvQWMMkjPPSdn2LzF098g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efA9ftNRgeH3gJNAtqfMiVnZ9l0OH2WG4lkKrX1eDoA=;
 b=hhC78PliJWfQYIs2Omulrf7O/Xfi0vzL5OSTse8XNwssiCfhwKR25gnkAdkvrwuRVrXYs9ABrJYtwQlYxAHZFEtiOeL6mFYAhMEOV0/7zG/cr55WVPoAQRtkT/arsMdgasynipWLieCX+BZDDoytW73kJXGei2oQNuYanzPWThpGLLwT6EP8n4TPHnKkIrg0t+SFPK1XKzN+wdfdh0OnwGZaEgcRBQzJPwyBq0AQnKo9ZMHQDPgetcEmCuJ0MnFzHHEZK8fWLQLY2PQLL4CxxUNYJ/BIxwk4v3+jv8oF6n1fKbJuXDC4yBbThemWD8ZeP3fV3DwUFu2C/4tHN82itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efA9ftNRgeH3gJNAtqfMiVnZ9l0OH2WG4lkKrX1eDoA=;
 b=ZWpwq0NXl31sq356wK6Qw3C9p/JunT5wrG79zr5l4c1q8bBhMisndOVeaxmn9uIypCTV0ZM1zxORF7TEhRGU1Icm48lJKsdA0zX5OmFrAqO8bPFEn6Bytq1qmnTR2Qj7/8OOHrT7qMgtcbx5V++xl8KkA5mC5oCoTNOaR6LshsQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 17:48:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 17:48:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/2] mm: do not assume file == vma->vm_file in compat_vma_mmap_prepare()
Date: Wed,  3 Sep 2025 18:48:40 +0100
Message-ID: <cover.1756920635.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab635a5-51e5-4d04-2df1-08ddeb12211b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/YpojnR4/4HOVW2ccbEFf97a51CDkZTPMYqBIq33bNPTNVRPHeoJmuGgv/G?=
 =?us-ascii?Q?8iCQKn1xB7Y/xfQ4Uy4qiawzEPAlAJozUCXc/TIzGsClteUC+V3jJ3LInsCS?=
 =?us-ascii?Q?1yZd0GaVVYTRXXA/WrN/YClHla2pm5QCT5lBqbOLRZbSyE+x/gNIqqSyAY5P?=
 =?us-ascii?Q?mriQokr3rBJ0Ffaf85cYzd5U1TIzSqD8NQ0urswhn4zBUxcmU/LsgpjB89EB?=
 =?us-ascii?Q?V4F9Bzt76DiHdU5yFuLGUPvvstrqy6JuVtmRgxGFqTHpu5DyRDjHYZyz0ZqE?=
 =?us-ascii?Q?9fdZ0nmyZZD7j/gAHiPK9TjJicAwwgjx/DuLPEB7a4PkW8/onWxNsP39Um2g?=
 =?us-ascii?Q?qYcaA/p6T2vWJw1o+PCTZ18stSnB/SY+h9n08KCI+KnSE7+CjBqF5kB5d6r9?=
 =?us-ascii?Q?g7utRuCmAF5WVZ5zrCzfiyhyPfqOld7DHyg9MW9HeQM8Ftb2wW9qQERgSLMf?=
 =?us-ascii?Q?X23bqH3piyXm10HH61r/maFAzK9a7ZEGeEa+MYV6ey5D89r3s+ssgyn0i9/u?=
 =?us-ascii?Q?laja1KO0fel95ak1xFdZozKuo2r1QEEdLO/sRAkAUJaA/H9TYAtTI7is6QZw?=
 =?us-ascii?Q?OwmBrc90d25h0OuKfbUJVs58JdRurYuQbYkKxrgHAdBWP8amc0c2q1LUu/db?=
 =?us-ascii?Q?Oggqy1u6ztwcmakQUxkpQvuQqDUncZUcTBvk9D1WjxmPneWptTj+AjJXeF4l?=
 =?us-ascii?Q?eJKu7ipabxoOvBjPosJbHAmB6FlQCZF/F2jPWfdKt1Wy+CxUGUfwyaUZ+27O?=
 =?us-ascii?Q?607970MzRYT1IYnMZ/gsby5cvCYcsXRi3IbkuHFY5aIKC8IHi6T9JTPfoCWL?=
 =?us-ascii?Q?44SpzdHswfk4n4c4kx/KhxYOaWVIqXuByK5PmDXCUQ2jvv4c2WG8LtaAR+/x?=
 =?us-ascii?Q?EiqztMGAvyAldxbSb33P4uQo8v14UbVxoKxxmm8yKJCnFksloFikZOLf0Dmd?=
 =?us-ascii?Q?GJB2alse2hk1b/GuLB0VwJHvnUCGttQyi9Ojhi4YWG2Yxh5GCnxGMLemTZDZ?=
 =?us-ascii?Q?497PbOf4qEmbaXHRT8WGyAxWlANaAxuT0ia/djwV5qneIgkuFiiarm69xJNY?=
 =?us-ascii?Q?944q2j05GHdghW+OeeaWFsj8SsVlZVx/VmO+q+siW9TfIKp+FiXlhlBo5UTs?=
 =?us-ascii?Q?YD+Rgiy8L30xX2lonwwJiZhSIptr3KBIBPVJGilZtL9TCIE2gHG+LAJWDoW9?=
 =?us-ascii?Q?hOKmVI8KlKq6k8u0HkmWJoYwp5naFsZktkIeSm/86FyyDWliT6LfB7/Y/rnl?=
 =?us-ascii?Q?sOII6SAb8NItPfrbzykoFmLbmAmUDEIdKC1fdVAkJn/ZNM3jGssKosnNZve9?=
 =?us-ascii?Q?yXLz9+KjJ0j5tjOFXGYAPA1lW3/Sl9lsV6q/hUPDURM4eieF/z3ype7BzYcT?=
 =?us-ascii?Q?6RQjwSCYwgx29yvKZ7JlOQbzbe4pNwHA6oRvq1Mdq3634QUzSsd8tJs6JTH3?=
 =?us-ascii?Q?fDiDnwLwYMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mycs2Xmh9XFcX0iXfx3P7Udzadtbx17nNLVh1wi8a5UhwWdO6I1wq1Sv8qCe?=
 =?us-ascii?Q?OS9KgPIJ1gKqrdiVqXBjUEs2Xp7MZ1RH+V3ySuhjBIZ5s3PboKJ3mnRFqViz?=
 =?us-ascii?Q?rHcyjcDYHDqA6NDA7J/nRGkay8a1ViKsCCwuJ1b2jAmDcZDYeJN5VZhEg9QH?=
 =?us-ascii?Q?SVUhZfnDMmMhwca6qQy2xNHqxKEIt3wVZiGVyaY/GndlUuu+5CFO6LDTUybY?=
 =?us-ascii?Q?dzdvKfz1EPu44GumOV3Qz/oUz7QyZHCphvZ3F08tvooEpSMiuR82LyX23Ohm?=
 =?us-ascii?Q?IICD6+o8i2cqz9a6DfLtzXk2zXyLPMbEjPZzECr/zcdewix0AAxFglAdmmUN?=
 =?us-ascii?Q?ifVxBDKaQ+HPTqhFE2A3iPSGnH+sc1DJSGxazTjzo3LsdteYaWywbP40jaR4?=
 =?us-ascii?Q?KuLkXCzPHt4vYDSDkCebFjEh3PagZJudbwmE8gfS9xEKEUR4MS6D//Y7si8Z?=
 =?us-ascii?Q?xR0Z1bogUxOG/mrDSLCRNRqinY84piZGxeQiUpqGTuSB6f2QY6OpRJVu7OoX?=
 =?us-ascii?Q?NszlcB1rGMmKmtkZLGRySery6bIjKP/CV1B86ykJbEEhyl/DTgWj8M9Z6r2G?=
 =?us-ascii?Q?fhgzaC75olS2dygB5yWs2rH25V7j+Wi4n7sAva9S2tJ7WjLkdMnrKzBRQ/7k?=
 =?us-ascii?Q?6jXHxuaJ3G0HrlkSrlIxnGYtgAMFzu1uRH7ti7FWgJb/oLNvpReRKeeuS++o?=
 =?us-ascii?Q?Yb85j7Vfk8YYkCqvxfWkdrBusR2xvhkBWgmgc+uY+Ibh859arQOFcPOMnAeB?=
 =?us-ascii?Q?rGWOMaIJsciYH42ncaBiLJxDyINt07ooKZB5vjaR5Ey24F3Gp8L9/NIFppFk?=
 =?us-ascii?Q?s/Byx6MIiqkxphfjCIGN3mojcCxPdg87lgT/5KRbWD8PhZJtnFO7Dfyve41K?=
 =?us-ascii?Q?xlQk4uxwQOzHR4vXtnzdvP+gzcNQjGBRX+Tq5r6lX/U3ANuvbfcnmDDxQOxW?=
 =?us-ascii?Q?VwXndFYmSCY4e2z/Kko1kxaTOrY75707SMLi+0TDFXSm2r7/JvEVpUASwy1q?=
 =?us-ascii?Q?fNcS+6Lz1ZYQARmZGuO+fj06hB9tQCLHeQ2Kg2qxE4yb/3NPC1gttm58vq1R?=
 =?us-ascii?Q?0o0PmmZ9y47B200b8qqBz/e3ahwcYc0qYT1khwLVarRZNvFIU7wdJYP+9tqo?=
 =?us-ascii?Q?oi6o68BTajb4Sxf9weHir2F7XFSE1lu5ILirp3kk8SJEO7C5tthuKVA8WOeh?=
 =?us-ascii?Q?cZsBa8HD00R1AgnE7sL2+yLRuywiQVCOwVsONC0zDEmq9xF1X3P4/Y+Hx4F+?=
 =?us-ascii?Q?VBdaz+dWB9Wzm0MfWs9IkivbAQT8wLcIA2AwO88YUySCsZx4VDw7s1NKzd5q?=
 =?us-ascii?Q?8QN8djVn7KeXHyNSsrr7uyNrtuGx/gLpJPB/0DFv4q5hFe7lF5+yh/7ffOt7?=
 =?us-ascii?Q?4ZsU5P5U45sUwY8g/QUxHkMTiNtDAzF1n7gOcAxqKqiXBV+eFkuQY22aBAu2?=
 =?us-ascii?Q?nB8h/uvCfwepxIPuVeGCyKgRkMtKxlt7YA+NpYulLqis1v3PP7xuYQ6Tv/kR?=
 =?us-ascii?Q?Zfl6gDIWoSNgLFzApMmXgprhAWgSOy7vcVVK2uWsjkgqvr13S01zDa+Hf171?=
 =?us-ascii?Q?lzvdMNNI8Cbid+6XG20kSD3sS7CmM1gOlmCMTunQ6udY8zEQCJsStsCTQFlt?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LJr7sabwmx0SvTKJKOhON03qCR513sNiTTl1D3GYyoHZn1i7oDdztIZTABQnMQVuCK6IS9aUTrzY0THpvD9GjHlT+S2URcm1NdR8taLHs1J396jG+YGSlnTInvLBsMThVC4kGQtUa4ohpnaauNx7wiUcY7FUe4aNVsPz4AYBQ7u9h8zQJ+ie8/3Kq1iP75OpRHOBvYWkduO24Wmuh/ggXwdNWVdf0eXPcn/F3Jyqlh/snc5+LI+CXGGH91eijplNO2iXpM+y/EvztSz7xacte/SKLsF22fEXJF/8oeFXidex77TnKHiKLNF8FLnHSyjjlcsBkCx3Ilqjhkzh7Je8+z+c03yr4H2lWxYLNzk73tjMRolttCl2Xc0UlaunvXmTicjiou8SMGnPdYRDewk09etoSFJ0ZKulSZUedlfwVbE8B+x5tBiYxwen2iWgycEfjGYWeE8ZUjwuw93UJE3Gd4MZ3jxPtwUJAxGy5UbBsMhRMX+aLMclI6XQb6u14FXzUjDAM0VAH878ycSJ7hThyq7B2YBa04K8FGsS9I0RKDTiK8J8T3sL32/IvlcbMoo1JBtx5sRifC5SB0LMZJLv1s1gOR/rCg6VgPZgqnEE31Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab635a5-51e5-4d04-2df1-08ddeb12211b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:48:45.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/tNR3fb6pyw56gLBu0jLM6Blv93rfiVwJRG/Ot9OrdDfcAErIwT1+zDwYWqglciI7TENnHQPPMjzMlH5v73C4X3xd+KcQJu2jhLTgYt2Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE3NSBTYWx0ZWRfX8Nw2K4c9Y0+F
 7nwMDVGKpuQ9hOrw/aC5DY+4wvw+VNO7rhl+ntLZEAGRaVmvc+BWANC7PYE5oUxV7SGyaxoIClH
 ypw4uG40U5LklvjlKftPGMs3j/hR8v8aoEsUy26HbUuotarKNyb+r5301SR5+T0lhERChVqB6ND
 hjHiao/hGQOBZoRziIVbxRFj9OyMc7JC340R886Txb1QBvCDrxFlsWelPS5el1Tsl6opNkOO//s
 r1SbtZ2JoDGT8/g2WJOvs0fd2Lx0dXka78P7xN4pbvWGMnCgVHepU8OUKS6DIOGw4ie6DsKhi7S
 rpODns861l7ZAeHEdP2uUfG88sV9BQ2OihHpi6B2iFYRx4xtcmdWkDgs2Yil5IQ70wiUkpmUGv/
 6NR7xr9Mowy5wU1adka5iYXYwEeAEQ==
X-Proofpoint-GUID: ZiEBQEyvh_a7ELXnPraOZ0VqhQGu2McQ
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=68b87f82 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ujzI4ElQP4ZYgkrQ7ngA:9
 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: ZiEBQEyvh_a7ELXnPraOZ0VqhQGu2McQ

As part of the efforts to eliminate the problematic f_op->mmap callback,
a new callback - f_op->mmap_prepare was provided.

While we are converting these callbacks, we must deal with 'stacked'
filesystems and drivers - those which in their own f_op->mmap callback
invoke an inner f_op->mmap callback.

To accomodate for this, a compatibility layer is provided that, via
vfs_mmap(), detects if f_op->mmap_prepare is provided and if so, generates
a vm_area_desc containing the VMA's metadata and invokes the call.

So far, we have provided desc->file equal to vma->vm_file. However this is
not necessarily valid, especially in the case of stacked drivers which wish
to assign a new file after the inner hook is invoked.

To account for this, we adjust vm_area_desc to have both file and vm_file
fields. The .vm_file field is strictly set to vma->vm_file (or in the case
of a new mapping, what will become vma->vm_file).

However, .file is set to whichever file vfs_mmap() is invoked with when
using the compatibilty layer.

Therefore, if the VMA's file needs to be updated in .mmap_prepare,
desc->vm_file should be assigned, whilst desc->file should be read.

No current f_op->mmap_prepare users assign desc->file so this is safe to
do.

This makes the .mmap_prepare callback in the context of a stacked
filesystem or driver completely consistent with the existing .mmap
implementations.

While we're here, we do a few small cleanups, and ensure that we const-ify
things correctly in the vm_area_desc struct to avoid hooks accidentally
trying to assign fields they should not.

v2:
* Refer to 'stacked' mmap callers as per Brauner.
* Updated comments etc. as per Liam.
* Add new vm_file field intended to be mutable as a result of discussion with
  Liam.
* Made desc->file a 'const struct file *const' pointer so a user won't
  mistakenly assign to it.
* While we're here - Made desc->mm const (and updated the one case where
  desc->mm being const matters - mlock_future_ok(), invoked by
  secretmem_mmap_prepare()) and also set const for assignment to ensure hook
  user doesn't incorrectly consider this field to be updateable.
* Separated changes to VMA descriptor logic into separate commit.
* Consistently refer to 'filesystems' not 'file systems'.
* Rearranged checks in set_vma_from_desc() putting the possibly desc->xxx field
  first as this seems clearer.
* Fix the kerneldoc error for __compat_vma_mmap_prepare().
* Update comments as necessary.

v1:
https://lore.kernel.org/all/20250902104533.222730-1-lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (2):
  mm: specify separate file and vm_file params in vm_area_desc
  mm: do not assume file == vma->vm_file in compat_vma_mmap_prepare()

 include/linux/fs.h               |  2 ++
 include/linux/mm_types.h         |  5 +--
 mm/internal.h                    |  4 +--
 mm/mmap.c                        |  2 +-
 mm/util.c                        | 52 ++++++++++++++++++++++++--------
 mm/vma.c                         |  5 +--
 mm/vma.h                         | 28 +++--------------
 tools/testing/vma/vma_internal.h | 36 +++++++++++++++-------
 8 files changed, 79 insertions(+), 55 deletions(-)

--
2.50.1

