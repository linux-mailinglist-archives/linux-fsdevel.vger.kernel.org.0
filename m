Return-Path: <linux-fsdevel+bounces-36933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A09EB166
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C016B1B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6C1AA1CE;
	Tue, 10 Dec 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZstlNmz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ookAxM2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E61A76AC;
	Tue, 10 Dec 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835510; cv=fail; b=DD//QbIcj4KAoeh6NSqDcAoo2vhW0kaJzCly0525wB8VPSUejOXyk23xcqPQBlKQ/JXtnXrhUcSHE9snLfBpZnM/48SvaiRMcGFwcA7xBJFBWpaibxlCmjOxbzlyLwYpQ0rdvzQMq7LC+Bnd6QWFmVXc91ySMg8HCpScOKuWidQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835510; c=relaxed/simple;
	bh=kr4MVKLjqrr4Sbuv5oaGyeYek6Aa5Van74JzRTBzevM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gYqMr/T8KVic/pYWCr4zGp/g+kMuphyfwt6uPPVNmGLJH9v6YahhVCZLoTZUf0l98i6nIiiNRxIWEX4rNiA5OyZa1f/NgdxadN3ZjicL3ofswjmwOQfNk28Mg7of6t+dzP149yzI3Zy5ujDimcgANeFwg6w5vtUDyZ9NRDP+V5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZstlNmz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ookAxM2J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAECWV005021;
	Tue, 10 Dec 2024 12:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h1bYF2QtEWrwEwmUv3zWhvUfFUbe+NxhHtggxlTLhKA=; b=
	lZstlNmzq48dJ2tv1rR1K8uA0QrrBz6opZal9p/C2gIAxJpwyr5DuiBtP2A1sGoA
	/MW4H0XHjZzaH4LBkuGAXtBn7RR32nq5qlUJyx7R+pB8ZPWcI3UB4qnQovSs/WbF
	2XsXCszIOzkb/zIBT7RQwBQCShEuQIIBYuXuypKNJ1zqIOIA3FaDictZSbAmvn3e
	RbYywQ3TqsEhryGsfg7BFqNnz00EdIpzYb3Du2dpPkNcO/hkCUuzadOLzRYIWy41
	eiASgl6b7eKxm/9YqpnyJYd9Kd1reOpb0cnvu7CzUdm+YVr1gcGcVPuhcCNAzj3I
	evezX9Jqz8GVGJGqa9aucQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyswnt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACXpPM037949;
	Tue, 10 Dec 2024 12:58:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccteumy1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skfGPytPrW2oa0lQ19zXdKl7aBN2ekedNtlHc1U12HQs90j539x4P6aefURmFXc9lE9Rb6lZaGH1d3IRiWsqtX9uMd/CfGt0/ebjidYMuNMMhTm919xEPbu6d8DcdqtI6T4+zV1UT4itMAvo6F1oE5itFh+KPj5Y4rVL2lvXepi69dPlZFXygyOxSZT8BzDbSz8oEWJDHNbzaBnY+YyoGqpihnuLUTee0hO9iWrATkPeBZh/g/WT1FaDZmWDf6xu4ps4maRLzn9l+orsGphDUWvd8cgQXr+eoJLeNQhYn8ffCqn+xb4ZjgDFKJLlEoEhSMKWvMq0w8Jfv0veWQYDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1bYF2QtEWrwEwmUv3zWhvUfFUbe+NxhHtggxlTLhKA=;
 b=bDseYCgVbszhoQuILq6XIVJ+Q+6lkJ5dBDfRBmKJe5EqTi32WCR5xffNny8OTngtV5oc6aJx+p8VgD9w+8R4EFk24URiKhcWGnGYqIPa4b8ufJHLOfmXqktqcf343wefCq7V4gu+bYVK07YQ+aFkCWd2UIJlMCxn40NJ85Gai/evrjyWFphIQEPnwa/EOnaQiB8SRYqxI/TNK9a5q7D7tztpGBhb5RxKxkVpQgg5couj2+iMe06XC44KW8YR8oIdGowirKYR2Arn+lHQAvUIVYYmIVeqfxfNiP9wF06dTJ/UhflgumdUa7S9aI4dEeFgTHxktURMGkN9dqiEd/TP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1bYF2QtEWrwEwmUv3zWhvUfFUbe+NxhHtggxlTLhKA=;
 b=ookAxM2J9OR8VovJ6ENV+4/q9OlQVamsx5yuYrm5DKbAXjF+AqlyaiFaOX6u4MG+k0GNXvgJAfuIE6VP7NLlrXZamQyqpOjLhx9VVyLwRyKRPjny/31HjofiSrm6d1Gk5FbOPy0eK8q3aJZb7aCwy52I5iL6JsD49KUR4g7s3zY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:58:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:58:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 4/7] xfs: Add extent zeroing support for atomic writes
Date: Tue, 10 Dec 2024 12:57:34 +0000
Message-Id: <20241210125737.786928-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a3b234-e17d-4c0d-7c34-08dd191a4792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TJOQeI/OT/h1FI0gc9wXgzViw0iYCZukmeacOceumm6DCsQTtuVcAbhRkHV+?=
 =?us-ascii?Q?LRBLNSteb+xtfoLAtuFTExxIhmX+pVKFhyFelOSI/Me2k5IwGtZpOD3IbfZd?=
 =?us-ascii?Q?ZhAqXyofxPfgWSfecKXIi+Ntt79Jf3xeh+v18su5kHW8nFxqrNou1YYtrajG?=
 =?us-ascii?Q?jfNEhw8PYmHcc0+KF3t2E1Wa/j8BMZzbBsZigeUO0pDa6grG2aKvk4Uf6nqP?=
 =?us-ascii?Q?D9kra5kyyORqdFocE79oz0fR+WV6D4gVsu7ONWVfxCZnSnCS+od4ula+VWmw?=
 =?us-ascii?Q?CaF5PwAv7PWfj8XFirnjnesRU2sbd6kNtC00zxc9EoIu14zBOEhm7EmK3oBx?=
 =?us-ascii?Q?BsTsIJ1TWVgSGXULHLTi8XgCH3GCuMlJo3i8UP2hn6AorT2blxCz8Ksm3Ie8?=
 =?us-ascii?Q?Or16rKMg8orGhjVnYoSdbeB4BRSabzM8lgjx/MLPhU8ui8M0dwjedesbnfOh?=
 =?us-ascii?Q?qv6NANKjq7ZPrkokUqVJ0fLx0Nej8gPxWW8pgtNivvQFI6tqN2NXX4gqYSQa?=
 =?us-ascii?Q?ao8mDSXHs3ZSvKkcE1JFdwDVQOjhGAkNaI8WfUZlL9Qg01cgQID3HZW0QzGZ?=
 =?us-ascii?Q?Srbz1JpelYJjIJtXF99yLlrLBfNN0ja7i4zwJCZoM2PYlRAT5qjOapi8Hqxt?=
 =?us-ascii?Q?pguksCkGdUsCMhfQ4o6DiJw+GKLWT2qCzURHgIqKOBiM+i9WEt7srhAGgI3k?=
 =?us-ascii?Q?2tHmxy50pSTqDI8ONANtAoCgL/c9PTTDgqOwQCwEQh97nu65BMpHFUxSzrUC?=
 =?us-ascii?Q?pKndoG3B6dybe53KpAN/SvnJ/bGhnuivQ90yLxz3r4PDxa6Ye9TzoON0hvKH?=
 =?us-ascii?Q?tsW8NQIoQIkeLTDTUmG2P9aXgfc38KfXB1u7ua7VcLKveHrO1dwdmEU1Fj0X?=
 =?us-ascii?Q?jgOhgnVqFK8AmF9hKPhknGMZHFwzxMKrp7eWyLh6QBpC4J5gTZxvslP/IREM?=
 =?us-ascii?Q?BZRUogJxMwJsnmjxjG4RR2GkyUL5TGDNJMbrdyBIamiL1860gNn1fFCla8gx?=
 =?us-ascii?Q?3v4PKgmVRRgqH2YcJ6QRXtTkJu8iSGh2Kw/SyHR2QZNHvrGOJaHHhpaf2ZM/?=
 =?us-ascii?Q?+xqzfyscJkHeVYVDK93cc+Nd7AXQfsHIKTqTOsa+VeXYGPdWsF8fjsuggLw2?=
 =?us-ascii?Q?2DlYOzGXoGU37451jdDZb8Gp5VusEy8WzZdzPFm76+UqraerI5vFKmePAaf+?=
 =?us-ascii?Q?SdD3twumCb56WC+nflmEyyua+5hgyHCf6XaqMVYUBc8q5/xPCGevREhBtjVs?=
 =?us-ascii?Q?n8HipTO+X11ajD80tEN+zPgMXbvqe7gv2IdHAk/hITHwi3TE31dCJ1vCzYpo?=
 =?us-ascii?Q?JBj+2Y6LCmj92fCYscV1uu5XrdbDl3Ie/FwN6O4T6g9EgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4jfaCZhu14uaBl9brMJraVwkCbKRCL6lgLdApvnSPN9poA0kxT937WawWj9?=
 =?us-ascii?Q?v1QKTPsV/iGs8UlquFUFhpZ1PKnAggzki9GBYrB1ZmSMqtDVMUHj1rJpRses?=
 =?us-ascii?Q?i2GJ6Y6TRQhej8DE+bYeMMrf20qPPXFyU1aPHwDqk0zzn8Unm5vtBRfYdcEg?=
 =?us-ascii?Q?KR0BDnnpZXpu9kJB+K7YgXSpVqPmue6EI63VLBk0E65bduxtV7VgltaXveFa?=
 =?us-ascii?Q?UoxX+qYJxeplozr61mFRiHCP0jTkTFu55C2fYF+nRsdDnxTS8eBEzVhpMgNE?=
 =?us-ascii?Q?EJGiszOgavrYPFzLh3sDgqBeu0IpVYqYJbTc/3iXKu/nnbm3dKghwQnRssuU?=
 =?us-ascii?Q?pWn2+gVNKDi7sPui3FOwGtnGihRsyDzQ37nK3Z9Bqf1OPUE+Bz2jw31nJOhV?=
 =?us-ascii?Q?nL5SA3fGJNBoJ/IN5F+M3Hb6dxOZz2SgEKo4qziIHz44UOhX40kW2ywAhZlb?=
 =?us-ascii?Q?80XjJfzg/caHmX/zdNHLPMCn7G2Tc43hu3V5QN9SzOL24uXepc+bO/nwRoB8?=
 =?us-ascii?Q?L0htelhCG0pSx8DBaqdLGnQCoJYhnELQnDbX6vSYGi5wE0g347dvf/31nMIX?=
 =?us-ascii?Q?xNNg+I6wK83CK9GX/yuUstsTkrbbHLtUqvVDVsrndCZg+8sZfQqnxZSMzK/x?=
 =?us-ascii?Q?eVfmnT8k/F2rXLg0w1fRKmWuLsu1NFg0XiPgiXcjhwBnS5mbIu70hQofvJbj?=
 =?us-ascii?Q?ndQGKMwkQt78Qkfeb5aswYo9ukoTcCqXikZllseJESVYfAiGQjI72zD6Exu8?=
 =?us-ascii?Q?OQqrCOOWu4JDjml6Vca9XLvpoScVBtxEuT8MzLbXcGAIMD2MGc/2smjjQhyo?=
 =?us-ascii?Q?46UOwUMsan7V0OADf86DzOGucNsJSa7GqWIuKYtJrKrLn4IBD+zNtLoJ4Lt3?=
 =?us-ascii?Q?4iHoE4HBTo96smUWboJcsGRsXCtKmt0+pV0JJjXxfpl4Ykgo7RMy9B3l0ZMb?=
 =?us-ascii?Q?uE5WPvNsO3sWZoYZwwod8dgMqj+vjeyMkXSt0BJnv431s+qZv3YeY20874Vk?=
 =?us-ascii?Q?/KIQvmkjsIGv518ShaqIOe6Ts345YuBYz5yD6Fpgdw+OfZ1lNs1/dtMtau5C?=
 =?us-ascii?Q?IdLUimn5y53+E4hcbggCTf/bJefeVYoSZlfaCBXYGDCSHO1NSNlvT0+OMJMr?=
 =?us-ascii?Q?wgKzbv7kfXiqwulFz32HLbZAPmTqsGsHKVAh7UeMZhO/997+7lzRnZChR6Md?=
 =?us-ascii?Q?JUdCDD1uyL5ZGm9NxRPkaiOqeTWsylJfSJqelt94m0G1bPXn5k+AvYbmexUk?=
 =?us-ascii?Q?UktYBOpvDHflr24Alzey7QMjQryszO9PfQO967oayNSEiNeD3E+mKpalfIKg?=
 =?us-ascii?Q?unXgLK2GPoT6HSQl68OmU7nmPZ0zCDGW0eBMouA5sJhxsnihLF9vA634gvQi?=
 =?us-ascii?Q?x2h56GwnD8zDRCh5lgg/9UZW9v2Vtur1Hkqr8OKanbjBycuVi2aY4ISxXT0S?=
 =?us-ascii?Q?teO9Tty9mMlAeqKTHV4EV7eq+DxKc9NodQE2pjmP9df7JO35SmYCvuRkoqxO?=
 =?us-ascii?Q?V5D0imAYFZkQbPP8FLJiKf6K5xRnHV3z3vugc37C1S8oH5lfhfelEXZLDLwb?=
 =?us-ascii?Q?VkL/aplMBWV3TJxL9SgdyNBjdroh/grAlgSYMqSJRzYVe4lpm0slcedtoY97?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qx8tIInX7OK55wCXwR/6CJzaCOqy9+pT1nXhbI0yXSfo5hJoZut8yOKExuhXJCPu1HD/BTAkUqLuqkAy1iGDNTTCXEw4lWHkQ+EFPckbHJ5odqdyd9jpP1ua0U9pjD9tDE9kC+qApa0Z/VACy0HP+2RSosCZwZOnym6BJhtgM0PSaU5ztoH3sAeqCLiHFWaWp/2A7obTBkwMWUWp7DlRRNf2ldsPXnW/5uqhOdxgmwnyAKMfUNBo6w4uCkj3N6qRX3WQmzp3ZcbkxZz7wtvTfGbZs27DuYP9Na/Cxe3Do3ZSV7Dh6yV2QtAwCzbLvC6SxfHhEacgtlczB1GwjdH/2/dA947enG4pm5Mtfr8YO576HGyzCaxRAgPr8fZxdB0u4ogRBK4B8e5yMun1/8j5pfZf5hiicpXQxq+mcaByIstXUIlfS7Z9KhunSEzflyTlnfoylxTyQ7KxRhn/E5sXukMYcaFyQMN/n+kXBlOL0+fa8KreDlT16jVcHDyruIiPP3Rv6Wpfg6k/kvcs5aEnXBTSrw4qygevEpRl9Q1Fe/LE1SMUv3esYoQ4Eh1NyjkkPtiZ+UjZVz0mgjPZeODmtiGulSrVPIo4rIGsfpwat6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a3b234-e17d-4c0d-7c34-08dd191a4792
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:58:01.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4o9xOhIyDxwUG+scbLpfsb1owgNxL9CdU/adt5Lhjrfff4RRww88gLViEh/nOba32KhEV5N/Q/ZDj/uob+jKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-ORIG-GUID: vYSFFKDnr2z4fTBm0XecloUdbCNZj0rt
X-Proofpoint-GUID: vYSFFKDnr2z4fTBm0XecloUdbCNZj0rt

An atomic write which spans mixed unwritten and mapped extents would be
rejected. This is one reason why atomic write unit min and max is
currently fixed at the block size.

To enable large atomic writes, any unwritten extents need to be zeroed
before issuing the atomic write. So call iomap_dio_zero_unwritten() for
this scenario and retry the atomic write.

It can be detected if there is any unwritten extents by passing
IOMAP_DIO_OVERWRITE_ONLY to the original iomap_dio_rw() call.

After iomap_dio_zero_unwritten() is called then iomap_dio_rw() is retried -
if that fails then there really is something wrong.

Note that this change will result in a latent change of behaviour, in that
atomic writing a single unwritten block will now mean pre-zeroing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4a0b7de4f7ae..f2b2eb2dee94 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -578,10 +578,47 @@ xfs_dio_write_end_io(
 	return error;
 }
 
+static int
+xfs_dio_write_end_zero_unwritten(
+	struct kiocb		*iocb,
+	ssize_t			size,
+	int			error,
+	unsigned		flags)
+{
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	loff_t			offset = iocb->ki_pos;
+	unsigned int		nofs_flag;
+
+	trace_xfs_end_io_direct_write(ip, offset, size);
+
+	if (xfs_is_shutdown(ip->i_mount))
+		return -EIO;
+
+	if (error)
+		return error;
+	if (WARN_ON_ONCE(!size))
+		return 0;
+	if (!(flags & IOMAP_DIO_UNWRITTEN))
+		return 0;
+
+	/* Same as xfs_dio_write_end_io() ... */
+	nofs_flag = memalloc_nofs_save();
+
+	error = xfs_iomap_write_unwritten(ip, offset, size, true);
+
+	memalloc_nofs_restore(nofs_flag);
+	return error;
+}
+
 static const struct iomap_dio_ops xfs_dio_write_ops = {
 	.end_io		= xfs_dio_write_end_io,
 };
 
+static const struct iomap_dio_ops xfs_dio_zero_ops = {
+	.end_io		= xfs_dio_write_end_zero_unwritten,
+};
+
 /*
  * Handle block aligned direct I/O writes
  */
@@ -619,6 +656,52 @@ xfs_file_dio_write_aligned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	bool			do_zero = false;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock);
+	if (ret)
+		goto out_unlock;
+
+	if (do_zero) {
+		ret = iomap_dio_zero_unwritten(iocb, from,
+				&xfs_direct_write_iomap_ops,
+				&xfs_dio_zero_ops);
+		if (ret)
+			goto out_unlock;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			&xfs_dio_write_ops, IOMAP_DIO_OVERWRITE_ONLY, NULL, 0);
+
+	if (do_zero && ret < 0)
+		goto out_unlock;
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT)) {
+		xfs_iunlock(ip, iolock);
+		do_zero = true;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -723,6 +806,8 @@ xfs_file_dio_write(
 		return -EINVAL;
 	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from);
 }
 
-- 
2.31.1


