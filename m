Return-Path: <linux-fsdevel+bounces-48586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D4AB1310
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526CDA073EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB7290BD4;
	Fri,  9 May 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="il1WO+/G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MwrHoV/a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75827FD57;
	Fri,  9 May 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792887; cv=fail; b=BPV/UhYUN516dwdOGvO9QimdpiuZJJ3/BRpo6cYTCUX5h9lHetmY4/+qX+VPJ6fixAIRFUU4eE0p5wK5rd5KOeONKJeKbXPvBlrwiwrfNjQngZLxEFaCs+kbDbBLeN4URapHw2AO4RmqEC+SRqDfLwzEgUtKomHD4pIstCF91Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792887; c=relaxed/simple;
	bh=GUAJtD2Ida8/VXTjStrim+NjVn1sRegVwSWLhsGNAMg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gVj6JUHeiVhxpj20D+TCEXpQkEMctWewQnu+yl0cbF4+rrRJo1O6zoc36cIH1zaKkTAE4XA7SbBpMLbzXvlJTCTbCFP1ugYy7qsAbGWrQBnTExgcsZGS/S/sKhE0jdEoVal0ehEgJO/PoFpvGPWuNkoibHQtvDdfCc7imVFyVfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=il1WO+/G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MwrHoV/a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549Bi3Cf013241;
	Fri, 9 May 2025 12:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=JPhpervWbcuvk+KV
	ozNGBpOdKqwp4RJOPTiXmWovlEQ=; b=il1WO+/GnV/yL504wXrKhI8KH/goJkfi
	3pYL5V5dsNcBTddDqOFFvKVUhtLkRX0I1a2UUe4WjjxWKX5L41Ub5V5wPIm48Sll
	/tZAODwfN0XrwlP4BQDDHJqQE5w4cfn27CgqzZcX8PwBVEptLxx1F70eWasefrjI
	cNVKfdJK5jajovLslXcAkAHEIFsQirc+ryTIu5EWyQCiLGCmaUjJ8uNGinn6At3h
	nXaU82BFirEMvh0cOAPvNVDK6dFYGCATwBOh9XoHX5soqYb2BWPqCWNz3d9Pmw16
	S+gF6IA4wtQLJC0iVyivGTQttoombyfvZxWk9gC5G9wcXoatEoBwzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hh3e028v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549C9n0X025071;
	Fri, 9 May 2025 12:14:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kk5qpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2QFcThjyOlggjeDYcB6x/WnrTvj3NzTT9/npUtm4hOuGYh9ad7iE5GFZTcJV+v2IHHD4n5KRWUm+TOTqsD9swANcW25UIj1zyZN/oeJjFhSF1zzSHWE8drluvmjVn9hhjHQELkviMOQ7BU6Dk8v0UZOTG6CaC69sTVTtIlxBrzVMJTuFDFiRBfWX1Id8U4gfyTZBWjqA0t3KJoK46C2tTd35TzrAV2oj4LSM2QHot2i8swNl/Wh8yKxqtCcG7UhiOlsRZ1+Q8IKfwLDYE2klf16Oz+kNKpsIWicK/Gduie2VvmrHfPy6um6u9nMyJB1XESn5tBLO+g4QslkXTM5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPhpervWbcuvk+KVozNGBpOdKqwp4RJOPTiXmWovlEQ=;
 b=mqQCO2Y6BLvCl9N0I+h7DSTKSOEfEecdmaDvewEhJATNTXNfmgnZfCr08obqcg/YMQ7lvO4dDkCz5yl4/0n5Dr/Yw3zlBqjhImlmzgyZM2rCzEvN3W/CYa+4k5UHjGk5Hg7m5VnOYtKcCyGfJ6rK1J9qVaUiJZ5y6p/VKUIliu/oMKq6aCE6lIGMQArmSmCpLD8Rv1Xirat9/28q2trw5gF5o7Qghp/VzGBAGbmQyhf8Hw/OKDW1lf3A4iNsslz6vncf5zgf4PywMcq/uJ7Y6GXTV9SNWNPBqqJtRr26yYuzij2MzGujzdqIloVv9kdt62Sl2zKo+1Wlg3WtdGpbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPhpervWbcuvk+KVozNGBpOdKqwp4RJOPTiXmWovlEQ=;
 b=MwrHoV/a8QM/TmzRVkvKUe/pVBSQzPNmpwcbYfqhRMk0MxHZRfx6qTGdYrfpWx9iAwlpmq78fXxTaipIPrSUebCd5or0sexg7+AFq6W+P8InhDf4ekZuIjSd+FHf6WCA2GHu68mvdueejmSLN4vzaFP2AlVf6iYmt17ylW+W5HI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5058.namprd10.prod.outlook.com (2603:10b6:208:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 12:14:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 12:14:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/3] eliminate mmap() retry merge, add .mmap_prepare hook
Date: Fri,  9 May 2025 13:13:33 +0100
Message-ID: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dc84c6-dd24-4300-d9f7-08dd8ef2fb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GgAgMPt+gjN959lL3vgT0LSY+3SjdaiM/HDBZ8IXyTMnLg9XNJQEDKC8Ch0j?=
 =?us-ascii?Q?fnjVAeEBg7/SOCWRdNYoS9llrW0jo7Gtg/jT4GkuaumHQf9yUUm+bd3sZdRj?=
 =?us-ascii?Q?5Cf9EIpZAD7hvvK+KBectr7uyXFSYU5CHVIpzMmGjEFuaprnuULoRETdTeVm?=
 =?us-ascii?Q?YpSobRrQM13nP1W8/tddeZidDOvWrWQ9hJ+IqVlp7LJr8Nlux4/03WlJocPM?=
 =?us-ascii?Q?wqqU+pPefoFWKZu8BrG7puqxFKrcvlYj2vhVgoRnO7qXZseyVP8GudWf9R5Z?=
 =?us-ascii?Q?vOgL9pPjGLUtAmateuhOGTBQQiaREmyKkc/HOob1zfJhWrJgwzrc1swu3D14?=
 =?us-ascii?Q?AFYdp1JJDxT5SZva6yh3dPFJ/8T115JTRTG7nVgpGqWLMvJyF1VJDch7BG1y?=
 =?us-ascii?Q?kfDk4rPDQJIPo9yTVWlrsFt81Kaioe7ECEv0C/ajUqpPavMtRQxktoJYN49h?=
 =?us-ascii?Q?WnBi8t+4zqawMx52jrf9VHRC4oohy7tyrvce6uWxmYnybfVZLi4Ptti7pVl8?=
 =?us-ascii?Q?QIumA54jcCKhfhNodjDT0E2ktuRzPxE4FFN2pzBTmb5bRKMDMoCE2b/d05tv?=
 =?us-ascii?Q?Qh47BQHdS8ITvFty0Aq+MBLytrBojwLueHTwXCTY+2+tZ4KQN7xBkYJdudAa?=
 =?us-ascii?Q?YJF6xh649WhsDVTkXzVDapLkCvi2Oo8SmRhFfcDjISb4o1kqIvdLOUkpHjKb?=
 =?us-ascii?Q?CByYIrz/S73NL9RIzG/CHNQk+D+cBB/tllGB0DCzQBdgnnOSqtNpjVu5a+yS?=
 =?us-ascii?Q?1HEimIIpYUVBHuIBvLk0beJpJ/vPCSChpwcFowqHQwCRKk7EWOQpkIfIYtNs?=
 =?us-ascii?Q?oAVm1/mvTusscLcWC4geIAzCwLAHp0rWkCo8GerXu1Gmkcfwor/Wg7jFDILa?=
 =?us-ascii?Q?K0xWmsJhAvaJNennySPnTcW7OB8ieIzYopV7hWvQUFUVL6pbi1BlUOpcLhr8?=
 =?us-ascii?Q?Gg8eWjKJuriykG4LWcCzKGp/04P+0e/iKoPRlK7eiX0rFvfi4wya8GtP4er3?=
 =?us-ascii?Q?iBdmwgypXiDEwMwzaLPh+uHJ5KxzjFD1sV9X1EVBYSGGTo7gpBTxdoYK7dOe?=
 =?us-ascii?Q?kVC1eKnFChdBWibhqE8HNfvBPYnBFqntHmLwBhl8S1b3cLAUd+xnoS3QG98/?=
 =?us-ascii?Q?34IGgcuHWY0Yei/vbzBfcBVmyEzUTlqmX6KjTQb8IhoROePhJubtdr2bBdyl?=
 =?us-ascii?Q?mKFf3XTp/XcxJ5ALi/JKMWUS13wu56JMwfyRwrKXMsIJ73QRSSDcmfkrG06l?=
 =?us-ascii?Q?pjvD1GQddnPJGoFeRip2ZmDNSzDrm2aM5XCSgfCGMfrVmXDgBdmxsQQt/6gA?=
 =?us-ascii?Q?QDuK88hoNbw0zY65lcPr9VdXOUcpMHO4dnCF+p5mNDKxpSrMKS8dOulssdDq?=
 =?us-ascii?Q?1X5FiwBzW6Gh5lV+ClMUA7iXyxtVaPNPDWDhBRMEDEyDHHhZMjz2Fk4M9DjP?=
 =?us-ascii?Q?iqBkNXA+eVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6Q6dCcrq/YhDreGUSOlljf1Z4U21j/Zo56fkNS4/qlrn/KArumgruYW3jEv?=
 =?us-ascii?Q?zqIEaPF2Y1klLrZ25LoOc5wa2olxmZ2MjjuhNP9t5QPJdGwNsx4cwMa1Yl9I?=
 =?us-ascii?Q?Mk0GHtCpznGCTRMWpLSBJql7qLs4ktUNC8UXwvXGFP9c2jZvcqxZwRTAGRSY?=
 =?us-ascii?Q?dELtuIk/X28rN4HchKZ7BEmr0Al0E1rtKRGLnk+gvVNnhZDCIa8UqA82wgWi?=
 =?us-ascii?Q?WOp+ZdJUFpcXTQ67Dt1lKeHB2xrpccaiJwCqKWCZ9C017VST7ubS5av/bwqO?=
 =?us-ascii?Q?FFCq/ji06IXiZd76VEM3X3jlno7Av/yczaCHV0vXcXQMlftegzNPInbe6HW9?=
 =?us-ascii?Q?g67FImz2BONDPmNZiUjfsBbG475QNQrUf8Ydq7N7wB+Q3zZ9mJ+X6gzW/N64?=
 =?us-ascii?Q?EuOhdXaYoNnNl7bM6dXeQs4c77UNT3wpLFpCJf88h4KyjdudfPWLkTaoIsGx?=
 =?us-ascii?Q?1WGrCNiABgburULSa1DEVfslgem2gxuvlo67Oy4AFYsFzo3EZWNFKwvQ2ZG7?=
 =?us-ascii?Q?6nKMmC68QMhHx1FZ8XYDVXu+6V7nLmdx6CZ2qHHV7y2fxGGHFOZ0AwPyRzb2?=
 =?us-ascii?Q?khLHH5WfG9DyVW4O09fGesW6lZ3cbFd44WbbmRnP4YQjrTi4ta7XKDqfVBOc?=
 =?us-ascii?Q?ovhYjoQCAzjY/949RD+ATyUMXSEqYFcRUjs0ebMyYlcsqeXpE9bFL/4KoHe2?=
 =?us-ascii?Q?4CiCu3iDjEDGijKlboyiRrZIvV/wMAxskOkNxpgbkLDzpX2jJe8YohDrzwT4?=
 =?us-ascii?Q?VhkQ9rZf3Vo8iH11dwGGO16GXhgpzpTh/WVHOTBLXqnKFuUW0qeURDqyTiFi?=
 =?us-ascii?Q?7/TYc8fUXCl6lXAZtCJc8U7GR8JbMNH1VMwytecFWbwGPskpSnxrKPJRDgW9?=
 =?us-ascii?Q?tlkwCgPpxonzIIloqYcMPRFV3oOLFlT7nm0pvOXewcjn21oMVCg/kEXAwuDX?=
 =?us-ascii?Q?VXyvK2//OBGO8e15efGZu+wMUSnEo/o8ZH6Z1aZag8NOySiGdMwaXAgjFzRl?=
 =?us-ascii?Q?XMnndh5AwixdwghU2Hvk+MjhrP7d7ITza24SjhIC6KGSBo7r3AO5PKxf8VyB?=
 =?us-ascii?Q?VAlCq6osGnESdk0UOycdlNowEVqRRT2qO1N6c3JEu5GMOyzhxRU7aiUU2Yi9?=
 =?us-ascii?Q?1QuctLfu/q4LzMuz/lCuCKrzccC7ATGbZNYBFRN7a/vd6e+0Ai+PQcsMNPTf?=
 =?us-ascii?Q?q/0sM5rxQ0+Rm47ddscsUWmvXRGEg4ic6pQThpke7/Ug+GCORh7ilKvRWFNc?=
 =?us-ascii?Q?C8SWG3uynTNRo6ZKrF6I3gYvpk/TqD0Tx4qRZRfPMmgxE91fzEGV78dhpaoh?=
 =?us-ascii?Q?DI/ccCeh+g/B0XHyoIX10lEN8IWoHL7atiGO80HZZPM9srROhyLNfUPxoNK/?=
 =?us-ascii?Q?kQ7ULGGZYBYN6LUP+1yzwJxZNM85+a55Tw74SuPTUu7b8ctsoXiQzm0IT+Mc?=
 =?us-ascii?Q?IpQHLD8G3Ous2EpEhrydK6thOFrCsgtk3tb9f6iiEpsatauuPPiVmLBclgj8?=
 =?us-ascii?Q?z9HWsZrC0R506OEM0/pVvSKiIi3a2XOV/MxGOy3NJotj31fwqbkczwk3ZeYe?=
 =?us-ascii?Q?J0ohg8tjaq77f2DldBmBO4gYZ0HEqjHVaqU+5MVOx/DpKUwq2/t6jSEmsYC7?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U1IUJZAxdFK83WydnPHofSOzXAGx8TpNtjf4jr3wgwzBv1MSol8/QplXGqYS8+lINxQ5tUZ6RMAWpEt25WZnRDMoDCSRBMTtD6lsTlhp3VLC4vHxutOn0F/HEbIuLFL5Jp6YQTaiw0hoKuzjoSBrtTQY70bajz1eSOzGJRhUm1Y6ceoxjqBFrmwHtenVSozXQ2pd132OTf4zVqFh3BJu27zuLjkpNNJcRVcYjbqaYuLMF1WglW4zqSrF/HfRljEgaDfIWDebKSdriurorCOHC24Di6FPCReWY9+/YvzyjuUYvFiGKgyEAOAkZrDokRAikCSUs9NHxIpFcLB08qLH6Bjs/RiuU1q9AcOIOWsbltqmXagm738EC/fgaAFwPGlmQA680fe0QkG41nKERV7iw9bsRrq9Xa0pDEhq7GzPsBrpe/hP4noiFh2LfrbBF9tEDMj4gfwf4Kg1D1bHcdFsDcYA6Hr40L7GD+E3gaj53Fl8ejynZ+Ji3vM+QhOmuW7xGj1t9h6jpZF7sVRLC1rPAK7rwMSzam+3scnDjknKuUsBzV8DOuXsxenDZS9Rqc73KKzWWnucS0DcawDp73BKSP+MPmwzbhdpDizlLXC/wf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dc84c6-dd24-4300-d9f7-08dd8ef2fb94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:14:01.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLoJLzQKT88Znrkt1dokn/LuVxFxoejtEqIwNNgF9b1u9cCvGrkb1yCzZwAR/erZIoubv3W+GazG1fG+dW89dlgxR0wKrvyNy4trR+MERo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOSBTYWx0ZWRfXz4hoefzztT3P aO0xoKujsNm4leQZWvdQwlamjJsgALmm1aCyRpXTvWUMNbQv1xZTen8OlgXF1K+NjzPcQDVbH/E jNmsM9nJDBWxAlRPgl4Bq3w9c4AXx/XOCl36O8rrmxjH/alfJn+VD1s7SPK2/epZPNlq+Vuu5NR
 lOKhCx34tdlPdpQT1gV/wPDhQzELzLnNi+aqOkjoRTmBiruM/yCh44KCgB8kW8742kTvacMibaU rsGmDRgc2oKQe32EoxSF2Me7YhUVIx5NZ32EG8ebw6mWUXir5+pQ2/BXow1bXe2EdQ5ogXQlScR KfiDAqIjGVaXf1rBZxygyAnXYXDbRpxq1BJtRZbeEBHAk7NmEKUSGNYHN1zAEc2kHGXGiI8a+nO
 SxLvrxw/OSULCiUwRoEne5SsZ+0CQZm0DN5nuIvaorq1XxcCf4TfUNqDublLT54q2RQYLl8O
X-Proofpoint-GUID: dMrTamXjFYzA6FfNTUXr621frsVw36hc
X-Authority-Analysis: v=2.4 cv=PbH/hjhd c=1 sm=1 tr=0 ts=681df18d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=fYcPrh1RY6OB40ofYu8A:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: dMrTamXjFYzA6FfNTUXr621frsVw36hc

During the mmap() of a file-backed mapping, we invoke the underlying driver
file's mmap() callback in order to perform driver/file system
initialisation of the underlying VMA.

This has been a source of issues in the past, including a significant
security concern relating to unwinding of error state discovered by Jann
Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour") which performed the recent, significant, rework of
mmap() as a whole.

However, we have had a fly in the ointment remain - drivers have a great
deal of freedom in the .mmap() hook to manipulate VMA state (as well as
page table state).

This can be problematic, as we can no longer reason sensibly about VMA
state once the call is complete (the ability to do - anything - here does
rather interfere with that).

In addition, callers may choose to do odd or unusual things which might
interfere with subsequent steps in the mmap() process, and it may do so and
then raise an error, requiring very careful unwinding of state about which
we can make no assumptions.

Rather than providing such an open-ended interface, this series provides an
alternative, far more restrictive one - we expose a whitelist of fields
which can be adjusted by the driver, along with immutable state upon which
the driver can make such decisions:

struct vm_area_desc {
	/* Immutable state. */
	struct mm_struct *mm;
	unsigned long start;
	unsigned long end;

	/* Mutable fields. Populated with initial state. */
	pgoff_t pgoff;
	struct file *file;
	vm_flags_t vm_flags;
	pgprot_t page_prot;

	/* Write-only fields. */
	const struct vm_operations_struct *vm_ops;
	void *private_data;
};

The mmap logic then updates the state used to either merge with a VMA or
establish a new VMA based upon this logic.

This is achieved via new file hook .mmap_prepare(), which is, importantly,
invoked very early on in the mmap() process.

If an error arises, we can very simply abort the operation with very little
unwinding of state required.

The existing logic contains another, related, peccadillo - since the
.mmap() callback might do anything, it may also cause a previously
unmergeable VMA to become mergeable with adjacent VMAs.

Right now the logic will retry a merge like this only if the driver changes
VMA flags, and changes them in such a way that a merge might succeed (that
is, the flags are not 'special', that is do not contain any of the flags
specified in VM_SPECIAL).

This has also been the source of a great deal of pain - it's hard to
reason about an .mmap() callback that might do - anything - but it's also
hard to reason about setting up a VMA and writing to the maple tree, only
to do it again utilising a great deal of shared state.

Since .mmap_prepare() sets fields before the first merge is even attempted,
the use of this callback obviates the need for this retry merge logic.

A driver may only specify .mmap_prepare() or the deprecated .mmap()
callback. In future we may add futher callbacks beyond .mmap_prepare() to
faciliate all use cass as we convert drivers.

In researching this change, I examined every .mmap() callback, and
discovered only a very few that set VMA state in such a way that a. the VMA
flags changed and b. this would be mergeable.

In the majority of cases, it turns out that drivers are mapping kernel
memory and thus ultimately set VM_PFNMAP, VM_MIXEDMAP, or other unmergeable
VM_SPECIAL flags.

Of those that remain I identified a number of cases which are only
applicable in DAX, setting the VM_HUGEPAGE flag:

* dax_mmap()
* erofs_file_mmap()
* ext4_file_mmap()
* xfs_file_mmap()

For this remerge to not occur and to impact users, each of these cases
would require a user to mmap() files using DAX, in parts, immediately
adjacent to one another.

This is a very unlikely usecase and so it does not appear to be worthwhile
to adjust this functionality accordingly.

We can, however, very quickly do so if needed by simply adding an
.mmap_prepare() callback to these as required.

There are two further non-DAX cases I idenitfied:

* orangefs_file_mmap() - Clears VM_RAND_READ if set, replacing with
  VM_SEQ_READ.
* usb_stream_hwdep_mmap() - Sets VM_DONTDUMP.

Both of these cases again seem very unlikely to be mmap()'d immediately
adjacent to one another in a fashion that would result in a merge.

Finally, we are left with a viable case:

* secretmem_mmap() - Set VM_LOCKED, VM_DONTDUMP.

This is viable enough that the mm selftests trigger the logic as a matter
of course. Therefore, this series replace the .secretmem_mmap() hook with
.secret_mmap_prepare().

v2:
* Made len variable in secretmem_mmap_prepare() constant as per David.
* Dropped file_has_deprecated_mmap_hook() and file_has_mmap_prepare()
  helpers as unnecessary as per David.
* Added WARN_ON_ONCE() to conditions that should not happen in practice as
  per David.
* Updated vma_internal.h accordingly, added todo to fixup duplication here
  in a future series, as discussed with David.
* Dropped unnecessary 'at least one must be specified' comment as per
  David.
* Propagated tags (thanks David!)
* Removed useless file_has_valid_mmap_hooks() check from
  call_mmap_prepare() - if the .mmap_prepare() hook is not set correctly,
  this will blow up anyway.

v1:
* Seems generally supported, so un-RFC :)
* Propagated tag, thanks Mike!
https://lore.kernel.org/all/cover.1746615512.git.lorenzo.stoakes@oracle.com/

RFC v2:
* Renamed .mmap_proto() to .mmap_prepare() as per David.
* Made .mmap_prepare(), .mmap() mutually exclusive.
* Updated call_mmap() to bail out if .mmap_prepare() callback present as per Jann.
* Renamed vma_proto to vm_area_desc as per Mike.
* Added accidentally missing page_prot assignment/read from vm_area_desc.
* Renamed vm_area_desc->flags to vm_flags as per Liam.
* Added [__]call_mmap_prepare() for consistency with call_mmap().
* Added file_has_xxx_hook() helpers.
* Renamed file_has_valid_mmap() to file_has_valid_mmap_hooks() and check that
  the hook is mutually exclusive.
https://lore.kernel.org/all/cover.1746116777.git.lorenzo.stoakes@oracle.com/

RFC v1:
https://lore.kernel.org/all/cover.1746040540.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (3):
  mm: introduce new .mmap_prepare() file callback
  mm: secretmem: convert to .mmap_prepare() hook
  mm/vma: remove mmap() retry merge

 include/linux/fs.h               | 25 ++++++++++
 include/linux/mm_types.h         | 24 ++++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/secretmem.c                   | 14 +++---
 mm/vma.c                         | 80 ++++++++++++++++++++++++++------
 tools/testing/vma/vma_internal.h | 66 ++++++++++++++++++++++++--
 7 files changed, 186 insertions(+), 28 deletions(-)

-- 
2.49.0


